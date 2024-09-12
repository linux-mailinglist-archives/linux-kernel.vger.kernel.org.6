Return-Path: <linux-kernel+bounces-325793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25417975E46
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D5C1F21C58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2652BB1B;
	Thu, 12 Sep 2024 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Crvj08qk"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181391CD2B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102749; cv=none; b=XE6SKgeSAQJoW8Wg1jNozDl9fX72GiSy3wcCB7/Vl96tihVknGylTa3zfPondMvDsMlmwYkeMjInGjUMIKbdVk9WdKcjyFJup8o2repY5uSMIIOk5RmhfenUIBmWKq7jclZLdC624RSMuv9gdyqBSE308linj3hVl/akOEcyUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102749; c=relaxed/simple;
	bh=BoJ+Z+Gg7odxVsXwP9zT4qzAJawRN/y0N3Fgtb8j5EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHWySMhHuyYh+VHhrguSsWSWP5XjLzY03UbXQdJXCbVPGKG4RLo3GdXCxjP14WrPLTvppCAJcE/9kFDdZs83y2B4c/Uy3kowxpZiJHJLYFDZA20ZaYpF61EbwlvTsDVfZ7Vi0ZjyuvbvfV1TkZF045y4gHKXJatOQh2XsXE1VQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Crvj08qk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d704704aso291553b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726102747; x=1726707547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6g3voaE0sy7kgnP1N/NuWOD5ksHhW96h3ew8XdguEY=;
        b=Crvj08qkp6ayHjPgsRHCLPPYEALVjpvGSbReYPr9FfSan16xxm0mu4wXSEbNcsRdGO
         /e1jQQw01LExhUilfui39BD4OgeUOD9657TQb/vaeJcg+oB+z2jsqcfOOMqCMRIF/T0V
         H4UBVQEnwjaCrIlqioyImeg30PfRaG7hXF22w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102747; x=1726707547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6g3voaE0sy7kgnP1N/NuWOD5ksHhW96h3ew8XdguEY=;
        b=jjIF6njuUJ1GrqiEljxFpSNeOpyURmw8pd/wUPvdBQkZh8qznq6IB+n6QjeNtUb5oE
         gItDHMWxV0JvXqgisid6KnjvD+uD+G8aH/UE9+t7pf4UN2jjZHJjvXobNfjaUypX7UTH
         vlBLyW011zUTiJeCPO97WrNXAOaHm6Gc0TGY2966rBlNVGdFlH4FN2BUPxqA0HXsE5Lf
         v0kq51fXTod5nhAwOKBZSl74dR/ulpK1tDuxwKOab6hgxXnH0HL3L1DCJu/v9hJe4jV+
         06uuZGzTVBfb8FL0PtQD1XXCXAvq3NKHi+pByvoKX/VpeaZJqyg2gtS8fGcrd6NbJhpG
         koiA==
X-Forwarded-Encrypted: i=1; AJvYcCWMd9GI1QmTGye9EyEdeDfYzPcl3ro/BhQ0RSaH0/5RZh7r+wu/4t3NLW53in0Cc0qoRHQUdaMtWE56t1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ybtHgsIN5XrLngc9Ak3X8hAZCF58BrE+3uq9BEfO2kcn0VLT
	5UDZsxy/OcUCnlKcDvFcnSyXOMDXQUW2IH6W0LKy9yX7F5ZVv68jqVygOmnXcBrVMO5Lh4Ab4n0
	uaLuAVFSII9SuVasgKdOwgy6KUQnWkYvkzKO3
X-Google-Smtp-Source: AGHT+IGPjrQb11ArWIze3a9NUSvBK83x+4lyFvRUzKqBHPs72PiOn3L4zo8Rx6lNqIjZ29pgUH5Wdf9Mn85Ez50E59I=
X-Received: by 2002:a05:6a00:3392:b0:713:f127:ad5f with SMTP id
 d2e1a72fcca58-719261e77cemr1928879b3a.22.1726102747279; Wed, 11 Sep 2024
 17:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com> <20240911062511.494855-25-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-25-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:23 -0600
Message-ID: <CAFLszTj01iHxq4zgDkER4oNZtUZvBTO+qTykb1ok5fwB_QmBFw@mail.gmail.com>
Subject: Re: [PATCH v3 24/30] arm: mach-bcm283x: Bring in some header files
 from tianocore
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> These header files presumably duplicate things already in the U-Boot
> devicetree. For now, bring them in to get the ASL code and ACPI table
> code to compile.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 ++++++++++++++++++
>  .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 +++++++++++++++
>  .../include/mach/acpi/bcm2836_gpio.h          |  19 +++
>  .../include/mach/acpi/bcm2836_gpu.h           |  47 ++++++
>  .../include/mach/acpi/bcm2836_pwm.h           |  33 ++++
>  .../include/mach/acpi/bcm2836_sdhost.h        |  18 +++
>  .../include/mach/acpi/bcm2836_sdio.h          |  21 +++
>  drivers/pci/pcie_brcmstb.c                    | 101 ++----------
>  8 files changed, 427 insertions(+), 91 deletions(-)
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
>

Reviewed-by: Simon Glass <sjg@chromium.org>

