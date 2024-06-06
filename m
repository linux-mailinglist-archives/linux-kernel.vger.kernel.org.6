Return-Path: <linux-kernel+bounces-204061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C388FE379
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16B91F27045
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BA517E8FE;
	Thu,  6 Jun 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOn+B8HT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823F17F362
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667549; cv=none; b=Xdcz5EYAYzUZqx2eanKydOCJkUy6NFe4R+BGsBWPW4gVnwesg43X+ROczxGFIEfeiYTYzVjMU7o0stFOP4fm0gwF6eH6Tx07MBu0XNMKImc7i6z33aX5qUwVkp+jZLCyGzUKLX4SLy+KedtzGZehMSeD3NZ/OWVH/w8CQq5fhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667549; c=relaxed/simple;
	bh=X7cVxbBveQqrOZ2WwFezmFwF45VgSY2MzHX0JhuP+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLc4Iml6j0RctGXwblQL/AIUE64MjzRAINddkY7ImqVcsdOw/vMdW1zGGH2yBuwEmF3OXBe+L0omFR06L6+BvSFu4ErXmO2I+tRu4OkrfcbC7fbRLaL+x2WKpn4uHAYnG98k4GuMjAL0685SXknpODfxmkaILsSJ1gRyzHrKYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOn+B8HT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717667546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rpvCY5bzwtgFrw8HO1MFPpTrsqw6qdsV1vTK4nMLwI=;
	b=VOn+B8HT4qYh8o0koqMmyCQnOWPO/59F8cL/9fSOFiCL6pXEtiZ5evV6/RcuiPxtx+Ho7C
	6aJWGnpAtqdrCCV2fjtgZdIVz9NXUDL1UweAvuTtSgx3n+hd2auycW8NimEcGpzW31K8r9
	h0oyf3E2hiS3KgY8lMo2551j/acouKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-mIggGKAlO3S6ge_9wYrxmw-1; Thu, 06 Jun 2024 05:52:23 -0400
X-MC-Unique: mIggGKAlO3S6ge_9wYrxmw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E97C185A78E;
	Thu,  6 Jun 2024 09:52:22 +0000 (UTC)
Received: from fedora (unknown [10.72.113.78])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A116492BF1;
	Thu,  6 Jun 2024 09:52:16 +0000 (UTC)
Date: Thu, 6 Jun 2024 17:52:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: Changhui Zhong <czhong@redhat.com>, axboe@kernel.dk,
	ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
Message-ID: <ZmGGzNLLC6WpM9tb@fedora>
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora>
 <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
 <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
 <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
 <ZmA0Se+t/LZihBKp@fedora>
 <CAGVVp+WoBochfQvLgAVbpWFv6JVAfQVkPwWDG8mBxqgGK-NDbg@mail.gmail.com>
 <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Thu, Jun 06, 2024 at 04:05:33PM +0800, Li Nan wrote:
> 
> 
> 在 2024/6/6 12:48, Changhui Zhong 写道:
> 
> [...]
> 
> > > 
> > > Hi Changhui,
> > > 
> > > The hang is actually expected because recovery fails.
> > > 
> > > Please pull the latest ublksrv and check if the issue can still be
> > > reproduced:
> > > 
> > > https://github.com/ublk-org/ublksrv
> > > 
> > > BTW, one ublksrv segfault and two test cleanup issues are fixed.
> > > 
> > > Thanks,
> > > Ming
> > > 
> > 
> > Hi,Ming and Nan
> > 
> > after applying the new patch and pulling the latest ublksrv,
> > I ran the test for 4 hours and did not observe any task hang.
> > the test results looks good！
> > 
> > Thanks，
> > Changhui
> > 
> > 
> > .
> 
> Thanks for you test!
> 
> However, I got a NULL pointer dereference bug with ublksrv. It is not

BTW, your patch isn't related with generic/004 which won't touch
recovery code path.

> introduced by this patch. It seems io was issued after deleting disk. And
> it can be reproduced by:
> 
>   while true; do make test T=generic/004; done

We didn't see that when running such test with linus tree, and usually
Changhui run generic test for hours.

> 
> [ 1524.286485] running generic/004
> [ 1529.110875] blk_print_req_error: 109 callbacks suppressed
...
> [ 1541.171010] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 1541.171734] #PF: supervisor write access in kernel mode
> [ 1541.172271] #PF: error_code(0x0002) - not-present page
> [ 1541.172798] PGD 0 P4D 0
> [ 1541.173065] Oops: Oops: 0002 [#1] PREEMPT SMP
> [ 1541.173515] CPU: 0 PID: 43707 Comm: ublk Not tainted
> 6.9.0-next-20240523-00004-g9bc7e95c7323 #454
> [ 1541.174417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> [ 1541.175311] RIP: 0010:io_fallback_tw+0x252/0x300

This one looks one io_uring issue.

Care to provide which line of source code points to by 'io_fallback_tw+0x252'?

gdb> l *(io_fallback_tw+0x252)


Thanks,
Ming


