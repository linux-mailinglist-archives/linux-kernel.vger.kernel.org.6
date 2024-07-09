Return-Path: <linux-kernel+bounces-245526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5201492B3D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A6DB237C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB7155306;
	Tue,  9 Jul 2024 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lq2p6VLJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CC155329
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517405; cv=none; b=kND96wBEnaGAzVhCoovw+AMofmayJZpMSWxfNIOTS83gOpG9pJdmgQ5QMU2XOnevMt6B35aCCncYxfPv7aoTLrmx2yBPpLZDlqPC8LXhyYViIFVFAq2FSrf8m6umRKNdSBWd7IzWoGbhhtJHs2qH3rwL5XR3qDZvSed02sGe2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517405; c=relaxed/simple;
	bh=3UrNehCdEOz3kmpljIH4fi/GT8Naw2VAyq67V1zlRwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg1Fhiip4nunFoqQ8Phb8BYVaqsWEwWIBwespNeFCJP9i6CF545jjmRgVqFajWckycOU7RVc4aqochzJ9nKiRpuvs9j7ec9E9utA4iUJR2d7DY95nkmCmBbAs8RzimnU4wUFZUt5Ol7yzw/v1gpPQD5GVzDts+QaHCtJXKGU6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lq2p6VLJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720517402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UrNehCdEOz3kmpljIH4fi/GT8Naw2VAyq67V1zlRwE=;
	b=Lq2p6VLJBQDn/gOad5KoPl6+CmbA8qrE38CAr1BwyRHJBexv19zhrqxpBAMkBon5M+lbIK
	UbWYIXIbx119xygnqe7+pt1NVLgoXTiIMegZurzYHyIxKmCmC2zyNV8gkNHOZYVYha9tyf
	7byt+Y76sTAM3+W8CSm6nX62GI6yWiQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-M8UPmP1PMDilwb-uNonikA-1; Tue,
 09 Jul 2024 05:29:57 -0400
X-MC-Unique: M8UPmP1PMDilwb-uNonikA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CC6B1936187;
	Tue,  9 Jul 2024 09:29:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0D441955F40;
	Tue,  9 Jul 2024 09:29:49 +0000 (UTC)
Date: Tue, 9 Jul 2024 17:29:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org, deller@gmx.de,
	javierm@redhat.com, robh@kernel.org, thunder.leizhen@huawei.com,
	austindh.kim@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Message-ID: <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708133348.3592667-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
> Currently, x86, arm64, riscv and loongarch has been switched to generic
> crashkernel reservation. Also use generic interface to simplify crashkernel
> reservation for arm32, and fix two bugs by the way.

I am not sure if this is a good idea. I added the generic reservation
itnerfaces for ARCH which support crashkernel=,high|low and normal
crashkernel reservation, with this, the code can be simplified a lot.
However, arm32 doesn't support crashkernel=,high, I am not sure if it's
worth taking the change, most importantly, if it will cause
misunderstanding or misoperation.

Thanks
Baoquan


