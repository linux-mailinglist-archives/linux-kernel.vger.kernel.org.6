Return-Path: <linux-kernel+bounces-333560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB897CAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4994AB21D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D341A01BC;
	Thu, 19 Sep 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cB+nuR01"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625B1A00DE
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755008; cv=none; b=pK+Un02Pb6LdvNce8Lef6T3SdrIyEHqXbhWZzr879NQsjApsv4N6j3z+fn5h8bo4y27JdItUvF5QAGSzXzGY9gPKmNcdlynelGsbD7422UvjUT2u6Qs3VdbFKnxqjaSUXSdoAQxEBZxL8pENDPX/br6trBKiSDAY+0lsDOx9LdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755008; c=relaxed/simple;
	bh=E5KGchCQCnd6NKgwkAOHCbqrXhD0jjreojUyU6SkJqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6d3GfJFRK/99UeFf/TDho++LX/nBMO5SG45wEGsNap1GjgaYDAHm5klI+vLYrzhaolFsCewHWf+3hTWFZC50vnyfuXO82mKYmfg+8tDdYYhHJlozz1gBv4942F9AtmBehtt16rl2LrGuzFcWsU255HmVvP5LaHVYAuQTG4JllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cB+nuR01; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c358b72615so7313146d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726755005; x=1727359805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5yKwD6iSxVK6iOcdb9iFxqHmMv1z9+9s1JQS8QSMS4=;
        b=cB+nuR01L4qSBVgoMRX6lrkZynkNkwqKvz/dG3w2f/IL7BrJPqAp/6etkYOl9TDF6v
         rERNBWwtLRCC0Y2CDgnqNSBbfbGOSKXn4Jw8CQugK4GCqh9GV25H2M7/LSDMX1y99jAr
         JRFX2TlByqPXBxR5FMZGPH1sD4VXWnfvPjLOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755005; x=1727359805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5yKwD6iSxVK6iOcdb9iFxqHmMv1z9+9s1JQS8QSMS4=;
        b=PsJL4Y3ChjsK78eaaGH5q3srQkP8j5Qs5Z2qpOCscBx20Q905Lmt2TdF034TEYAI5j
         sa0/Jv5xXBLhulJxLDu51eAxRJifIUZbIaz95EGpHz11FR4cXEIw2PdjkF54CpCp+3+b
         sUbSM5tlj9aNjFAZ8yHB2rT3XMA4lclMX1w6JtL+Y2uhihj73VBE9NKfboGxxv7f0/gB
         JZsPd5betLKHNlvJHS/BxXC5ztTehqjOJYtiMcawfPlCH6hGr4rmmHIWmSuYgAeoPWGC
         H+yYMbLdTOxAPipz/vBFR5P6tZA2oUOHCEz49BhftZ9ckdQjlCemp3TIP60NobtZ9Wib
         AKnA==
X-Forwarded-Encrypted: i=1; AJvYcCXH80MxCS61hkdIYyxCqjbMdFa7e/eYj6nNv9SlwjWa2F2v/bH6YWpp3rfEB/zpGtPLHWjivoPmgowbIj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8O8GK4+a/HAL07YTuuitI9izEyMZwGWpIsEaj5i9LTz89JSv
	0/dOhhKd/ZukxzhtnieCzu376wCYcdWPEZniQ0QEkon/4ZsSlw8lsxmmBhXSpzW4kyqxDsGWX+s
	HgO9Ac/HGylTa1N0l9+vgxG9FlVrbz2hbg0yJ
X-Google-Smtp-Source: AGHT+IGQ3avyxha5SRR4L/3mE4y1D8VFFMUrfimuvv2d6bcrMQC9MK1d3izsS/bqJlC1G3ZSpD/jKXGOFa33Id6qDno=
X-Received: by 2002:a05:6214:2e49:b0:6c5:aaca:a48d with SMTP id
 6a1803df08f44-6c5aacaa50fmr212995276d6.13.1726755005487; Thu, 19 Sep 2024
 07:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com> <20240918152136.3395170-32-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-32-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:54 +0200
Message-ID: <CAFLszTgYwRc+1c3p+bg13T3Jz4r3=ZCuwioc3vcNS3CR9FUqyA@mail.gmail.com>
Subject: Re: [PATCH v4 31/35] armv8: cpu: Enable ACPI parking protocol
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 17:27, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Update the generic entry point code to support the ACPI parking protocol.
> The ACPI parking protocol can be used when PSCI is not available to bring
> up secondary CPU cores.
>
> When enabled secondary CPUs will enter U-Boot proper and spin in their own
> 4KiB reserved memory page, which also acts as mailbox with the OS to
> release the CPU.
>
> TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> index 7461280261..544a4a5364 100644
> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -178,6 +178,18 @@ pie_fixup_done:
>         branch_if_master x0, master_cpu
>         b       spin_table_secondary_jump
>         /* never return */
> +#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
> +       branch_if_master x0, master_cpu
> +       /*
> +        * Waits for ACPI parking protocol memory to be allocated and the spin-table
> +        * code to be written. Once ready the secondary CPUs will jump and spin in
> +        * their own 4KiB memory region, which is also used as mailbox, until released
> +        * by the OS.
> +        * The mechanism is similar to the DT enable-method = "spin-table", but works
> +        * with ACPI enabled platforms.
> +        */
> +       b       acpi_pp_secondary_jump
> +       /* never return */
>  #elif defined(CONFIG_ARMV8_MULTIENTRY)
>         branch_if_master x0, master_cpu
>
> --
> 2.46.0
>

