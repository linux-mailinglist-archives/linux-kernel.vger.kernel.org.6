Return-Path: <linux-kernel+bounces-333558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDDC97CAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B761C21CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA119D06C;
	Thu, 19 Sep 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UIDwn7dd"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8A19F473
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755005; cv=none; b=pdQlQKGGidwImqYOQighsGjM2xRaNt9rX0fbBDNaebcQskeuGfM2Yebj8hlBfHuPTDpJu61Tewk7Vn+HdPqNXXbVn4fogTSmAp0mnnk6q5gAG6wRXf0lQKJ0Umvg1WdPnnmBpZLmObTvceDyfjJNu1HPAbw7b8GQEbz8xBYkb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755005; c=relaxed/simple;
	bh=GctlgkbVG46a73opTCwRpXS+1tw1jNGhHzO8oVHvc78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMuPPyixBNCbmLT7n2v6g/ULKO/aZLXS/aK4rTRZYLKRO4pxXKcJYEO2pLtNOYAJZuK/VljL4/Zzwr4Qdwf8tUiTte99N2Lradl/NjOoAxrB8cvlQTp5b0lxBEal2N+wPlH6zqzMWuUbm9kej+MVU5hqftOu03wrlWr/vj7pZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UIDwn7dd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9ad8a7c63so86514985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726755003; x=1727359803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NChGShmu/A2FFo9w9p27EZY1uREvTdNv88+MNztbS5o=;
        b=UIDwn7dd5uTgaNNDA3ULF7ID8muC+wT08mOGD1kUMsZXfRrnTvVQ2bUvG8RLmWIVv5
         2TRBARXy8wBl4iM6Uayh/rVxssjIRNLRMRony1osfEgz3TOmR2jzc4WVkFLBpF6TbUiu
         wSQzd4C9M27RNCkm4wpu7bdPB+hJ4hM11KhtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755003; x=1727359803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NChGShmu/A2FFo9w9p27EZY1uREvTdNv88+MNztbS5o=;
        b=pa10WbC+d3g9d7h28VDOHXVe/ix8LQmRSMCmp0J5G4jm7JdjuTBu+wYJEgZ8Z9lLmU
         rU8DDYxlOSh79kgkQXTOpu1ScZ3aQopr9PUtAOa3zQrEkrIu0GM082YuuxDvKpu9adTD
         bvubyz/5bUS4Kj/NBpdH10nxmLoWh28ef2AH+/9BJ1SBoBFQzusfdPGc4dU8Y0Kn7Dro
         JLoT2mqC8tOEoVuWdN8qPv65r6P6B3vRzuh9+A3etSBcmYSlcibPbU+6a5fb128v7yl5
         n7YutFiNFUYOc6uEb722ukH4k1hwrSUHLvDrlgyRARPB+nlfDkVm9sWKCb3BpHa2j+Wp
         AhWw==
X-Forwarded-Encrypted: i=1; AJvYcCVGRrUu3diGy5ZZBpCinbUau10GwvyHPjO99go0NBjRJHirzwGJR2PGsfZZu39daiyVz+6oOBs9QQMv7lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJv93gPlRHkWscpaJIvmcaH0OqFGLgRlJ9a50Xk3wxCkD7OXG6
	ltgrO9RZ2mhgQcCwam6XC5P541SdBhSCsIq/htCID6urUDXtDlu9aClVIB6ql1s05z6xv2Y9T9m
	EMPm/vkHwAB1KmDflENHOOXsZU90ZwXmmiXgX
X-Google-Smtp-Source: AGHT+IFK1tgtdbQ0YRwAA0XigHbB1+9JueK0tJ+8LKCJRAeASOrptA6a4tgi1fTAWUlyUCcT/WZYNa+6LVuxG2baft4=
X-Received: by 2002:a05:6214:419e:b0:6c1:7d85:d151 with SMTP id
 6a1803df08f44-6c57dfa2882mr326966066d6.15.1726755002992; Thu, 19 Sep 2024
 07:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com> <20240918152136.3395170-25-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-25-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:52 +0200
Message-ID: <CAFLszTjsoN36dOa8NKfCvcvxFKkzOQRVs85-AfDRZ-waOJNr7w@mail.gmail.com>
Subject: Re: [PATCH v4 24/35] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 17:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  common/Kconfig |  1 +
>  lib/Kconfig    | 15 +++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/common/Kconfig b/common/Kconfig
> index e1b8557e0c..09ead61817 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1076,6 +1076,7 @@ config BLOBLIST_SIZE_RELOC
>         hex "Size of bloblist after relocation"
>         default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
>         default 0x0 if BLOBLIST_PASSAGE
> +       default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
>         help
>           Sets the size of the bloblist in bytes after relocation. Since U-Boot
>           has a lot more memory available then, it is possible to use a larger
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 2059219a12..ea444354eb 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -983,12 +983,15 @@ menu "System tables"
>
>  config BLOBLIST_TABLES
>         bool "Put tables in a bloblist"
> -       depends on X86 && BLOBLIST
> -       help
> -         Normally tables are placed at address 0xf0000 and can be up to 64KB
> -         long. With this option, tables are instead placed in the bloblist
> -         with a pointer from 0xf0000. The size can then be larger and the
> -         tables can be placed high in memory.
> +       depends on BLOBLIST
> +       default y if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
> +       default n
> +       help
> +         On x86 normally tables are placed at address 0xf0000 and can be up
> +         to 64KB long. With this option, tables are instead placed in the
> +         bloblist with a pointer from 0xf0000. The size can then be larger
> +         and the tables can be placed high in memory.
> +         On other architectures the tables are always placed in high memory.
>
>  config GENERATE_SMBIOS_TABLE
>         bool "Generate an SMBIOS (System Management BIOS) table"
> --
> 2.46.0
>

