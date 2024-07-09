Return-Path: <linux-kernel+bounces-245652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E792B584
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC955281DFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8613156968;
	Tue,  9 Jul 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOmHiaJn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05C152DF7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521600; cv=none; b=TdX+Q3jSoCinp7+TXHMw4yo/Yh65vNQQDp0n+Ug6SOFNKWP2WIK6wsG27tItGgkIozCF76J66ZD7U+HYsKcRfAjkUZbp1Lj1UPIhnmFSRAMvLfgAouVv3rXJ87PXwGrCfcpT7cT/3DfpfZJNiHpJSAFBtxWQA7oT5CjjEowQAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521600; c=relaxed/simple;
	bh=csn1WnP3P9ry6Da6c8Oi4/nJEjnW05ZV6n0W+BOOSWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRP7ewgvCcBvSRlZHfJZ/C7C0W+0NHoof50wncyz3/1+jiSyYbK2GTXCr2C1S2Xr8xyeanvAbj4NCCSKijdy0wjighbmBFTipAEOQ3aHiZa0udLWpTV7ywoQaYZwn+yVHXJt0z2bXWDj5zUaMt260o2WHTbrTdIGs+B8rA3RGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOmHiaJn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720521597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1HsxreEQuhm/cJ8pO1jF0rT+KIGY8ZQkAVruIP3CKhg=;
	b=YOmHiaJnzyV4xQmWlFud+jy/nC8Ze01IAqitP3bYyto9+S6XnJPmv4U83OMPYUT3PjsWFm
	FYGEN/T2cZTL2mdEy4RZencj/NwH/2yyCujFivgSIFgAfIlpCMP+c2wItZNq2c7mQs5mvt
	FSADuMokppmHjTb8fRYSMY/L1Z0X6NE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-Ry-MDm3LNnernJl-EEleOQ-1; Tue,
 09 Jul 2024 06:39:53 -0400
X-MC-Unique: Ry-MDm3LNnernJl-EEleOQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 445EB1955F0B;
	Tue,  9 Jul 2024 10:39:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE6F019560AA;
	Tue,  9 Jul 2024 10:39:46 +0000 (UTC)
Date: Tue, 9 Jul 2024 18:39:42 +0800
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
Message-ID: <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
 <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
> 
> 
> On 2024/7/9 17:29, Baoquan He wrote:
> > On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
> >> Currently, x86, arm64, riscv and loongarch has been switched to generic
> >> crashkernel reservation. Also use generic interface to simplify crashkernel
> >> reservation for arm32, and fix two bugs by the way.
> > 
> > I am not sure if this is a good idea. I added the generic reservation
> > itnerfaces for ARCH which support crashkernel=,high|low and normal
> > crashkernel reservation, with this, the code can be simplified a lot.
> > However, arm32 doesn't support crashkernel=,high, I am not sure if it's
> > worth taking the change, most importantly, if it will cause
> > misunderstanding or misoperation.
> 
> Yes, arm32 doesn't support crashkernel=,high.
> 
> However, a little enhancement to the generic code (please see the first
> patch), the generic reservation interfaces can also be applicable to
> architectures that do not support "high" such as arm32, and it can also
> simplify the code (please see the third patch).

Yeah, I can see the code is simplified. When you specified
'crashkernel=xM,high', do you think what should be warn out? Because
it's an unsupported syntax on arm32, we should do something to print out
appropriate message.


