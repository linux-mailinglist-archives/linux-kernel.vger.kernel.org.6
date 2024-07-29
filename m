Return-Path: <linux-kernel+bounces-265046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90893EBDD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DFDB21844
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563C8172D;
	Mon, 29 Jul 2024 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StOwZour"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1478C84
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722223802; cv=none; b=iUhf8oO6e6TraJIkcS5yPNjYkh0zhQnX34VAO9mk4WWjpL5uJE+BnKI96L2X4hN8F6wmJXZ9ReUz0FWvEC4CWUzh4K1D2lZJpTXISIvQEFE3R+cfY1HpUf6BB7F63wTY0XPVI4MntbqQi3MFOVk101EVYOztqJizUqAZQkrmdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722223802; c=relaxed/simple;
	bh=DeKmnA3My9e1ppM+Uf8W6Gb1gjfhP4OQVPKT0jkwST0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCO4DveMFLnI9noyipZdsiaJXOpqZ5x5i+XSn/j4HP+wzePBXMP5gl8pEoCo08HsRcLwtngwvC7TvVjmT7W+RWSAB8WWfvJEwEelXMH5/ev17mO0bmTXtfcACtkEf3TpsyCdBcEBTS3FQzKH6kM+mBbITPnq96ceD81RXQ7LIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StOwZour; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722223799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO9CpgXouDh8hOZN70chmiOKh3p65Id9D7Y8jU0waHQ=;
	b=StOwZourodaoq9QzHty1L1ZLLouWxdNElh5fdiA2zGVvIJD9sS0y13wPiayOC4S+njn5gs
	iEohWPK8vm6JTcHK0FYdo1NeLQZRC2kMhlMM8Kf2B53WpOUNayrLoMFaZyV/s9vo0jIC+g
	kKulfCZ1VArVT5a6VtzUybSbNbkr9Kg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-iQL7kj1FMMaHm6fmYiu_QA-1; Sun,
 28 Jul 2024 23:29:56 -0400
X-MC-Unique: iQL7kj1FMMaHm6fmYiu_QA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA7CD1955D47;
	Mon, 29 Jul 2024 03:29:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D94083000193;
	Mon, 29 Jul 2024 03:29:51 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:29:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	rppt@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] crash: Fix crash memory reserve exceed system memory
 bug
Message-ID: <ZqcMqsMo8SYVv4Tl@MiWiFi-R3L-srv>
References: <20240723020746.3945016-1-ruanjinjie@huawei.com>
 <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
 <564e362d-5e8c-5d23-9c54-bfb811794169@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564e362d-5e8c-5d23-9c54-bfb811794169@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/29/24 at 11:24am, Jinjie Ruan wrote:
> 
> 
> On 2024/7/23 13:17, Baoquan He wrote:
> > On 07/23/24 at 10:07am, Jinjie Ruan wrote:
> >> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
> >> as below:
> >> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
> >>
> >> It's similar on other architectures, such as ARM32 and RISCV32.
> >>
> >> The cause is that the crash_size is parsed and printed with "unsigned long
> >> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> >> which is 4 bytes in memblock_phys_alloc_range().
> >>
> >> Fix it by checking if crash_size is greater than system RAM size and
> >> return error if so.
> >>
> >> After this patch, there is no above confusing reserve success info.
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> Suggested-by: Baoquan He <bhe@redhat.com>
> >> Suggested-by: Mike Rapoport <rppt@kernel.org>
> > 
> > 
> > My Suggested-by can be taken off because I suggested to check the parsed
> > value after parse_crashkernel(), Mike's suggestion is better.
> 
> Hi, Can the suggested-by be removed when this version is merged, or a
> new version needs to be sent?

You can send a new one and CC Andrew.


