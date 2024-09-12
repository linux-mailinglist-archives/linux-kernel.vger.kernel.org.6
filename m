Return-Path: <linux-kernel+bounces-325791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11534975E44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E2B237C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3921A28D;
	Thu, 12 Sep 2024 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T1025tJF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9BB1877
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102741; cv=none; b=XSSuSBDTOyNTXDGRjk/GZfpW7UNF9AK3RwQwjnA0tA4oqclAxX4Vm0btA6rYX/X8BHhUXc/WL7gAG3FLTrtDYRljuyOqGqTpBsnJV4PTmaJJUO7pzYe8mNKE1MPxfuRTirfzyDT/T2ezb8zrjgyMLS2lxqCE8RxzsFMLwmEW+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102741; c=relaxed/simple;
	bh=53MCxuuifvJZuheyW4uvWimpwdrM9VQqrFIa+ATMN4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3ZsANEN543APw6nBawNw78QCAicUJ2Tf+G9VsM6HdkWR4QgBaRsg/U8V1uMsuRFICXAc/cqvTPjv6TNb744Jd22MUHZI96AJI46oVREg0GE2zty56XBloxbhtcHrSn7DTLDW0wCtTdrMh6AEyLcNkn3ak2nPCgxgLSByofxEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T1025tJF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso255641b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726102739; x=1726707539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUuu1BY8JmxPtncoicyXpBDLumXc43JkYXU1jQBJeqA=;
        b=T1025tJF2DJLLZjssRJCQTOa+7Zgluks3zhAqS0K+wsT2DexZONQrmjgnlqibs8LOG
         YvAxATlGQn8MnsKnQWR8NtDGCJ93fUzoaj2oFnjmM4bH8IRzrDswGtyihFRR4GMBBdjV
         ss5BZFRS1M9M5SPasYZY5ZLB547gYIfSmxM+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102739; x=1726707539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUuu1BY8JmxPtncoicyXpBDLumXc43JkYXU1jQBJeqA=;
        b=BFTYUo4baJkJIiXfXZXkv2NtaLmdTlFB4qKzjbzfSFb8xRYuCLL79nVvaQCEwarnip
         Zu/ZjFj5Wq6G0WgqQ+AKTHB+/jxauQMMUK6IKPNu/ZPbEyIQmT0rCXpJDd3dq2FxeLqp
         Y8IdAJiKhpn4VAhzkfeuE4eu5BlfuBOOZupzvNkk579+4HtISiblucRhkLIh466Mj6NA
         E2PBNVBJntx1duuwTHqPovhgmFBOBXDk8xeqgjYC5BuzFJG9sYk8CfBE5nI4XAX9qCKM
         l10Ts6YQF03voTe9/bv/pTeCnANj/xEMac3vev58miS3FtgBFihUpe9mNS+dODJ3ylcJ
         VZFg==
X-Forwarded-Encrypted: i=1; AJvYcCWMB1hKU3WPhxxl6BTV+4w62MSAF+xs5LKoGN26XeKu3pIXV/E0VsXFDlER1PLO2Kx4UPEnPAZxZ3JAJFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxo5bHjXRPhiwB7XJOZD83jQstF9XtYZ8yCkvP2cZSvUwYxCB
	Y9RJTD2dwCL08A28ROtG0J668dGO06IAXzPLlDmqUHyYvlaxJY5Uq0MG9/kq0fwk6fQbVK1Efx5
	EOm7ispWKI03Ev9rpPZraMQMCjSAI9h0ZNV3wfwSYs8dPzmk=
X-Google-Smtp-Source: AGHT+IHjPKhktcqnObUnkBvf1pi5sfq33bsr27s+nh4MlMe+2yDHjbdVbafJDgxivmPqWxbwK6p52CuqSoUpYH9AebI=
X-Received: by 2002:a05:6a00:4b52:b0:717:9754:4ade with SMTP id
 d2e1a72fcca58-719261edaaemr1821400b3a.22.1726102738842; Wed, 11 Sep 2024
 17:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com> <20240911062511.494855-22-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-22-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:27 -0600
Message-ID: <CAFLszTgBSBu=p0MxhdrXi-=zd=0cXFqGVZM-R7Q6tJeWLPGm-A@mail.gmail.com>
Subject: Re: [PATCH v3 21/30] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 00:29, Patrick Rudolph
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

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/common/Kconfig b/common/Kconfig
> index 83c81edac2..a864e24508 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1075,6 +1075,7 @@ config BLOBLIST_SIZE_RELOC
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

Since you are changing this, you might as well drop the 0x here as it
is implied in U-Boot.

> +         and the tables can be placed high in memory.
> +         On other architectures the tables are always placed in high memory.
>
>  config GENERATE_SMBIOS_TABLE
>         bool "Generate an SMBIOS (System Management BIOS) table"
> --
> 2.46.0
>

Regards,
Simon

