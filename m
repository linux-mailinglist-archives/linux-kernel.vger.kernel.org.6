Return-Path: <linux-kernel+bounces-343301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A787989953
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319CB1C20C82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF827466;
	Mon, 30 Sep 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DavZyLXW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A4163
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727665258; cv=none; b=Kde9AIwPQvf1+p51FpEU1kB0RbWBOhaEmeRxFc38HwtwEAB1R7sRjmHGCfd8E4ux2//c6Q0S/XGptbb2+NxeH3ltnPMDQtGwLMplmFnMQyz4Sjw35ITgDLjoeGtMT8KaRj3RE6y/9w/jpcUsaMMW+zFOcdj5UZuDMFbNsd070f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727665258; c=relaxed/simple;
	bh=5L2RW5xxyTA2EzxVRd6oLsu/w7M/vk61ONldLEJDAAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8gpe4OP1Z4uIobtjTTTAjA74aJFkzGfx0mbd8kJHlGMVOQIsFW/8CSGyvtHBXvd4bIhIIyruGsna3j2Ym/IsRwDofN5wmqpMXmDvtJXKNo/xl/WN3I05Usn+wwy0k73ZRZjh+4om72Fn+yX9GvpwbDumxPKHJWwXhD72v7SIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DavZyLXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727665255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZM5NdSEWWxV+d7/NgptFaq3MVMQUll/nVFG6CmLrnI=;
	b=DavZyLXWGASsqp2Cc4bIs2gsvKV0dLqV1826agrw/wV5LHIHK23BwD3SgkT/uiNF2d3K/c
	CGfOLparHiTPLaD7Edn0gPUMVvKXheQuC7FgNBS9TFLzUNY6VyXmnpf/xUA0zl0nmazuuH
	KO7yVJ8VYJCCeRdVf/gJbD0EJGo0IpE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-zSa0gl6AMSaSWEkIjUVrkg-1; Sun,
 29 Sep 2024 23:00:54 -0400
X-MC-Unique: zSa0gl6AMSaSWEkIjUVrkg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFDFB19030A8;
	Mon, 30 Sep 2024 03:00:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F161D19541A2;
	Mon, 30 Sep 2024 03:00:50 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:00:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
Message-ID: <ZvoUXjWmojyNs6dx@MiWiFi-R3L-srv>
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/14/24 at 07:20pm, Dave Young wrote:
> The setup_data ranges are not reserved for kexec any more after
> commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table
> for setup_data"), so update the code comment here.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/e820.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-x86/arch/x86/kernel/e820.c
> ===================================================================
> --- linux-x86.orig/arch/x86/kernel/e820.c	2024-09-14 10:39:57.423551301 +0800
> +++ linux-x86/arch/x86/kernel/e820.c	2024-09-14 18:56:30.158316496 +0800
> @@ -36,10 +36,8 @@
>   *
>   * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
>   *   passed to us by the bootloader - the major difference between
> - *   e820_table_firmware[] and this one is that, the latter marks the setup_data
> - *   list created by the EFI boot stub as reserved, so that kexec can reuse the
> - *   setup_data information in the second kernel. Besides, e820_table_kexec[]
> - *   might also be modified by the kexec itself to fake a mptable.
> + *   e820_table_firmware[] and this one is that e820_table_kexec[]
> + *   might be modified by the kexec itself to fake a mptable.
>   *   We use this to:

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

>   *
>   *       - kexec, which is a bootloader in disguise, uses the original E820
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


