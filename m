Return-Path: <linux-kernel+bounces-203038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EF98FD574
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A697A1C24E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204D21487EB;
	Wed,  5 Jun 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxEsysgf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20292F24
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610733; cv=none; b=DkimMDgjsr0huGFRSg4neLu/5HBlNxnAukzxrTZKgeRai74OXOwC0xjxyVHzlXhSxlO54Vv9tVtZhMgXIOGan9nHGoO8zvxlrtLvA2q36f/sHiz1eTvdB8a2z48lO3u1bsml6wIoTDXJEPP8PnujdwARbZdR3p6Fl+WuSRcP8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610733; c=relaxed/simple;
	bh=Vk/ERoC3W32xeD0IGF2+YT7kGcLfj42xUhg89x3DWeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SAb9q68FMJ4rbR/gz1MMNoHDQudEwff2oS2nNLJd42Y/TuWUBUbsLJ210g4IeqQevwXNG3DkMoSWgIoNgiLVNij3xonGkAUGa4H7WTdrqHiaezDFvohfyw5DYvQxQnQwqLYGXx4AvTwmlUS6/SkLoAuOG5hOSKictr1tW5W4Xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxEsysgf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717610730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnQyygABzKQHoTTYC4HeEhDCmTqB5p8EDTzr/dhdxLw=;
	b=SxEsysgfQv8mL4hY4v3n1jEe85RBWOvXqsgONJ/HoiplPw5lKTAE5ttOi1EsGeCRbXpG6E
	uC9NB2x+ft7Ggu88gRFXtORAoxFYF2TSs6KQ72XfRhNZXI2r8Z48pdNFgrwKHj0Vt9NlPX
	Uzi7kukl+YRAYrvlOMWC6RkLEneHF1M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-RUsGgJuhOMWhEzITYeJNTA-1; Wed, 05 Jun 2024 14:05:29 -0400
X-MC-Unique: RUsGgJuhOMWhEzITYeJNTA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eaa43ba959so584161fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610725; x=1718215525;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnQyygABzKQHoTTYC4HeEhDCmTqB5p8EDTzr/dhdxLw=;
        b=LzL73z17BDPFEy2wtpXAE2RfOOECkW0bbHrVUMfbjNXlrTRfZjE+FVMYW3ba1+ohKE
         i7siO7MnyghTv+u++woq+3fO/UdS0tRlPcd0Sx8zy51WMaZTq9VhjbNWjSeMuWhUerr6
         eMvgzsrEwt+5Se0ffUcCyvU7SowkFftmGXM5pHoxoskU7Ou3XEmxw1vWCHBCBfJl2t7/
         980X5npqVZ1tNEHsq6UN/I+8bK92y18dTBhvVE3A2nE/v9BdHJifw5oWEsizkoK8BjIO
         kOTksHCWiMFeaJ8sXQjI7ayQPiuj9FgaWYFcukgmUJxEKFXVEjWFfZ1XJPZmGMPn9djA
         yCVA==
X-Gm-Message-State: AOJu0YxQYZIVLfjTY7Z+37SoG9TEBw+miqUnU5jemW9FJ5z7ckSmthB2
	G5OdNViRkQOoixiCXPDhsJsJVWKDlr20HMajz6P1LgV+o9diwKtaBuR4NCSiYnOJGoCYTzfTDK7
	6A04Me/zyTRht6chZM2s9QX1DNCZH4yJAQxpuv88pOv1lQQ/lshA/R5nGrcXbhmejmWSceg==
X-Received: by 2002:a2e:7817:0:b0:2e1:fae0:8ba3 with SMTP id 38308e7fff4ca-2eac7773e1dmr19957631fa.0.1717610725530;
        Wed, 05 Jun 2024 11:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnxGaa9jNeNGLuGONRLhJmttCuhMqDL2lN30Wlte6VnoXC/MXT8mIV5RiHOU116ngl53pE1g==
X-Received: by 2002:a2e:7817:0:b0:2e1:fae0:8ba3 with SMTP id 38308e7fff4ca-2eac7773e1dmr19957511fa.0.1717610724983;
        Wed, 05 Jun 2024 11:05:24 -0700 (PDT)
Received: from localhost ([90.160.207.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813d0a7sm29831465e9.45.2024.06.05.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 11:05:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brian Masney <bmasney@redhat.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/Kconfig.debug: document panic= command line option
 for PANIC_TIMEOUT
In-Reply-To: <20240605174736.778321-1-bmasney@redhat.com>
References: <20240605174736.778321-1-bmasney@redhat.com>
Date: Wed, 05 Jun 2024 20:05:23 +0200
Message-ID: <87wmn3nu3g.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brian Masney <bmasney@redhat.com> writes:

Hello Brian,

> PANIC_TIMEOUT can also be controlled with the panic= kernel command line
> option, so let's reference it in the Kconfig help. This option is already
> documented in kernel-parameters.txt.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  lib/Kconfig.debug | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8..a6eb7425b888 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1043,7 +1043,8 @@ config PANIC_TIMEOUT
>  	  Set the timeout value (in seconds) until a reboot occurs when
>  	  the kernel panics. If n = 0, then we wait forever. A timeout
>  	  value n > 0 will wait n seconds before rebooting, while a timeout
> -	  value n < 0 will reboot immediately.
> +	  value n < 0 will reboot immediately. The kernel command line
> +	  option panic= may be used to override this option.
>  

Thanks for adding this, I wasn't aware of that panic= cmdline before.

Maybe it could also be mentioned that the timeout can be overriden by
user-space using the /proc/sys/kernel/panic sysfs entry too ?

Regardless, the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


