Return-Path: <linux-kernel+bounces-340364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955D0987217
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1C01C22916
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4C1AD5D9;
	Thu, 26 Sep 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4OpDABY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9213AA53
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348129; cv=none; b=DAEa+SlXpaHpJavjA2PExbnNgRfzVTDw1WVy9MnzkNCcNA+mES0IPs3B04Hc+yDvTHQsfMNFT6YIEjrXNpWrVicuAgaWjTDC7Ufm+31LgR79UPQlWQ5TO/7SAbTdAnCsyp9CAZF4/pJ6ysHtjb9iAgFd0Mc65vAgv+GyTuctj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348129; c=relaxed/simple;
	bh=XCI2d6zOGn8vcBsyrqcPXVXGQlDNXAR3n+2+vnXTTQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbezMtO7oOdqVb/uxmd9zD4uElT5L3NuSilT/0vf8wq4Xk1Lb8k9yehxMlESDNkjI33RM2xjwyPyNEEJHt+kwAdmT4LGn2gFVR3HjvVNunDTrapr0GrkllXReQckTMFdcuyQgF3dvez1WXQoe7f8LGUx+YjbMoqpG9U0hl0a7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4OpDABY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986AFC4CECE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727348128;
	bh=XCI2d6zOGn8vcBsyrqcPXVXGQlDNXAR3n+2+vnXTTQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S4OpDABYE1wCiLgIXdZbu83lruYEQ01KQl5udAtsM0GVIdkvwzjDz94UuZfHnU7eY
	 Wep2L8zNz011G6KDH8KRKRc7t4F7B1Cq8DtswMmVIvbk94n6Wt9LSElagi1X9aiY8s
	 E/I9uWhA6wxauuWak+TVTPo4jGdNpp3EH8WxEwUwpotthAHP8brAG5SpfLi21HHHU/
	 gx3w5dCIFQnTXmQD1n1CdlcsztuFEVDuvYjot1ACrxolR533tuHTrs/US2BumWu6r4
	 /fuEwyAakBFyae2Ky10q0/u9ox7Z/HAf5Z6TsRZKWxrkoia4swi/cUUJaGvLW2LVWv
	 NNnlzqK/yQfGA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f66423686bso8349681fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:55:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YziPWvc3qCqlAFj5NgmzcXJHHsc2U4tgzOo871gsD0sK5xkIVpr
	QnXvme5Qmt+eymkVnRsMW19Ovx/Y8M2/lQW2ksnphrq1fS8/EhNjTiJtogR3U5YfvXPLK18QmAB
	Px1WwugvDAAJXeAk3yKobnjMcdB0=
X-Google-Smtp-Source: AGHT+IFuhl6qwq8nl2RSBrT3s7O5uxpJjtC+zwMU2JDoUkVTJsUk+tGX1p500y3w9bc9d55KP8bhUYqCcZcUrXiWCmA=
X-Received: by 2002:a05:651c:54c:b0:2f7:5dad:1433 with SMTP id
 38308e7fff4ca-2f915fdbb05mr41627421fa.11.1727348126883; Thu, 26 Sep 2024
 03:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com> <20240926104113.80146-8-ardb+git@google.com>
In-Reply-To: <20240926104113.80146-8-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 26 Sep 2024 12:55:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGQhj4RK=Ks_WD59hG1FzX=vsEkugDEW1tmzJzjahrB4g@mail.gmail.com>
Message-ID: <CAMj1kXGQhj4RK=Ks_WD59hG1FzX=vsEkugDEW1tmzJzjahrB4g@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86/pvh: Call C code via the kernel virtual mapping
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 12:41, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Calling C code via a different mapping than it was linked at is
> problematic, because the compiler assumes that RIP-relative and absolute
> symbol references are interchangeable. GCC in particular may use
> RIP-relative per-CPU variable references even when not using -fpic.
>
> So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
> that those RIP-relative references produce the correct values. This
> matches the pre-existing behavior for i386, which also invokes
> xen_prepare_pvh() via the kernel virtual mapping before invoking
> startup_32 with paging disabled again.
>
> Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
> Tested-by: Jason Andryuk <jason.andryuk@amd.com>
> Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/pvh/head.S | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index 64fca49cd88f..98ddd552885a 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -172,7 +172,13 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>         movq %rbp, %rbx
>         subq $_pa(pvh_start_xen), %rbx
>         movq %rbx, phys_base(%rip)
> -       call xen_prepare_pvh
> +
> +       /* Call xen_prepare_pvh() via the kernel virtual mapping */
> +       leaq xen_prepare_pvh(%rip), %rax

Just realized that we probably need

+       subq phys_base(%rip), %rax

here (or grab phys_base from %rbx, but the above is more obvious and
less likely to get broken in the future)

> +       addq $__START_KERNEL_map, %rax
> +       ANNOTATE_RETPOLINE_SAFE
> +       call *%rax
> +
>         /*
>          * Clear phys_base.  __startup_64 will *add* to its value,
>          * so reset to 0.
> --
> 2.46.0.792.g87dc391469-goog
>

