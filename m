Return-Path: <linux-kernel+bounces-327667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39071977915
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E487B23F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F81A2561;
	Fri, 13 Sep 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0qN/Puc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908782AE9F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210995; cv=none; b=TancpNxHWEbJf4ZlI3l++6q3VxpieIAufghhbi5W2CYPLM08/kqBuZ+ftl2GBFccZgv41KCLwF4xsjMOkyHE/iCGPJ3x4FuStNB8JPsgTi6PXENFlLWOBJJKK05mLpLeMrilYvbynoeYtK8BWPuTykNqk2nO71VBLQCLbPtL+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210995; c=relaxed/simple;
	bh=Pcxc+EYTY/Zox/ijAp5jY27pQLDu+ZiYXpSY++OkQ/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5dlyuGAAHHKMP7Kj2/xKjD7wXscpOswG2eR4XgMNOUa92tTk+g7QYGdIrRL3Ox7xrQa4d0OTVWQdCcK245hGkNExm168B95/BhsXA//3uJcKeoFrQtpWm4yKrq+xRbKAkELAqoPQ9NETH6IVAzCHfo6MsGJ9DRO/HKkIBUkI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0qN/Puc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7193010d386so570109b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726210993; x=1726815793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5e2APrvIr0iBdhPUANMRU+/4M8viwko7EsgvUm5WX0=;
        b=s0qN/Puc8JdEXh7vGiJaPN10UqXa7b/3VwovD9Dny+jak+GaXN0YlQytIyV3101qmk
         qZLAmumL/FFDcAwT2NLthbBE+rSbVXAaNJYE6+oLawdfSnWLNCB2k8GdrX47MGdzWfAp
         re5IN8HBZkwoO81zqptan5NHoURmwwwHAcjwUeKDyvyVqQ6U22bngJo+cAKMpybTMxfg
         0NBjlZPSKM1wrN2PCavkx0w9BaCvbXhtMLBxn7ImSIOm+8pH1t1WeQJ6HhPtWMPHdhxc
         130jfiUh4qvzLj/NyklAkPi6ELoXLnxneR5q+ZwxKpwJW5pEkeuck1bCLNA6106sVcxh
         IrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726210993; x=1726815793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5e2APrvIr0iBdhPUANMRU+/4M8viwko7EsgvUm5WX0=;
        b=P513tlZn8zvUud1Odnh5F0Yidp6dOM14xjy1AT5PjupUaprRwz6gaMFmpA7uzLZxnL
         GBdFIUZjR/lY4f0kqyEmdHGWDDEGn+NkDtnC72REG1LBjUzzR7oNxSL2xYawbbYmPd5m
         jr9jU/QsZYAdYuQ8wMrnv96LXNlve8oXJWf6UyUZMfAqj8FxLIp12ZmJjSITvcF0lIy8
         um6W141xg2ZqFDLqc6xJ+kGUEiHwEDj4wK6QuTZuGu88IqCFVhjbu2stw5+A2+LJsRdT
         do8CvU3EJPGOBoDSF9dvJyoliFETfMpSeKpgYG1z47CSJb9zJkDrp+QUZ9ulCa1U5Pj7
         UWyA==
X-Forwarded-Encrypted: i=1; AJvYcCWkkv4oNkkoI/iqDLNs8qrwcyje7GD0f6LBKcgPa0Q24VAJq0sK0hVnOxLfXTA4kRX4hToo1ZsQ7MdPEKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0X9zOY7VYo/ciGQ3TWjzAf5+I3q3vpgVzSCp3xq5FwSIcidoF
	dmdmWRwKk5fWvwwYH0T4pVTy8tLWdPOqfOrc2amfJZcdXgdSWNQOAwIMO2gBBhSElSpDeY3PxqF
	o+kUKZdBPxy2Vg8RWLVMzdKRuZI5GjtXQ48s2Lg==
X-Google-Smtp-Source: AGHT+IFhKBfHCLTcdF96fnJQ8ermuXuYfnTgJ0TMseCuYjTqXM+6WuATSh9HMOgGDabIf59nSEaJTHpjDm3iEFsC3hU=
X-Received: by 2002:a05:6a00:2d17:b0:717:9483:5887 with SMTP id
 d2e1a72fcca58-71936a4b6a0mr2799151b3a.8.1726210992805; Fri, 13 Sep 2024
 00:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-3-gourry@gourry.net>
In-Reply-To: <20240906202745.11159-3-gourry@gourry.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 10:02:32 +0300
Message-ID: <CAC_iWjK6EXf1g-CwBALTFmhhnRJaHcrdCS787aDDksdhSJxJTA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tpm: do not ignore memblock_reserve return value
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Gregory,

On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
>
> tpm code currently ignores a relevant failure case silently.
> Add an error to make this failure non-silent.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/tpm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 9c3613e6af15..6e03eed0dc6f 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
>         }
>
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -       memblock_reserve(efi.tpm_log, tbl_size);
> +       if (memblock_reserve(efi.tpm_log, tbl_size)) {
> +               pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> +                      efi.tpm_log, tbl_size);
> +               goto out;
> +       }

ret is going to be 0 here. I haven't followed the rest of the code and
where this function is used, but you probably need to return -ENOMEM

Thanks
/Ilias
>
>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>                 pr_info("TPM Final Events table not present\n");
> --
> 2.43.0
>

