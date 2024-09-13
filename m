Return-Path: <linux-kernel+bounces-327657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C689778E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF1E287959
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063011B983E;
	Fri, 13 Sep 2024 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwpyuUx8"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BF186E46
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209669; cv=none; b=o54oCUAWEVTfprcLHXUQFk7IRmL7RQ2WFCEEVQN1k6NR8o7zPfVJNvzbNjl6x0yIbuJIHRnQOVtD/AENhCPEC06dyIeV0GGY7y+0W8Jp46Qq0dt5NdL/Yj32klyIIFC8Ax7lQTCP/FLRsgO35kz3pkGJXhTv/xhEXs1qMoEYY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209669; c=relaxed/simple;
	bh=ehcs3zWtTc6DmoyDuY/1gTW6lTSxcf2UYJrb+rJ+Qj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV/5d+/CYFIt9huxT9jBUz65jBwvSpu3mXwyXTtwqzvvylQgtKN2mmp2+dN6ARs7nMvXTKpIa/IjDx8DhMAbdh9G2BppCOmN9PHCV9r6H3KNKZ4zt1bT7IiZj/pUJBDz2l/Mtn5qJjKcUQJlx8mi0AZa7bir6oFqWSZJFLmx+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hwpyuUx8; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27051f63018so258780fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726209667; x=1726814467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mST6gEktXZQHF6SwcttPjz/jfWpwUS5ebz/OPlAa6uM=;
        b=hwpyuUx8kby7PIvgpgWRUzru/HiIvei8Ymq2juzp6bqcYR7XRypMD75XFFesXTQBtU
         rdc+qL8LFqOZbEkbshOLysYmeKvmmTUUehouHLDorktfsMrOayireLe86tUE28zx5T0g
         1XJAZcdc3vfsYKBxGJGOeZrtEjl2m3MBP1RJZofjaIa3UYkGlyZnrackZpTNY7MLU7an
         gKE4jMGJo4gOwI4xmHYMtQDUAteW0QwdJoTSm1vPnA0b+rcgQpYF8d/nvtDuwbgPferI
         gbkCKLXpyEy80az2QAhCu1Vtikv3bxkJY4uznT80uahUHqzIAifabmyu6kog66BcqY9z
         6jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726209667; x=1726814467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mST6gEktXZQHF6SwcttPjz/jfWpwUS5ebz/OPlAa6uM=;
        b=iqcZ5QG6kG9keUgXIsmupoVv5EizaBKz5ZYuCEKLWq4z8w4VeNqQeQgHsswFwGU3FU
         XvKzR6KJKIU7eDlq7oM+qZaOjn2fdZB/0DdvCAyl63XhDJn3fGY7QCfL0P5SFyqpNLlx
         uXTNdS8K9lY5sa+d0vuEaWgcKQlQMNNmJFcmIhMhFgdSmV1+rH1z1SkbX99ljMQAi52N
         t33vemY/1wmTGaKHweZGQAsTxGzndmHBNdBNQ6j/S0vwiTZ9I2zeAo8LYb1XJkJWpeOo
         DSTR8u2FBzbuQlSLDGlcrF7lNoP1OxwEfyEGODLGw14lKtj6fuFjNfbylY7szXM5Moli
         TaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CKkoD2TbOze0F69gg4CAdzFU/QqqeEe+THkv3v9eG+ZNzRwogc4lVa1e6p+8BdtiMNBdsdJZPYWeKo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xxq0zim9ITK7Sdku734PiV3M0fva/Xog0xbwwb0JLwim6EK/
	6PFZ4TSX4gDCEwhVHZB8d5r1IbS33WNzjTuPVRwLVamBWrtVm77ZUHFNB+g/da3XfrGH+DZkaAy
	qs699kLxZtHOPWN8n0luPW3l1dZGblC00ZVDJ6UxnAqT4Bq1RBLQ=
X-Google-Smtp-Source: AGHT+IHq7LKuC8w8KZXTC1aYQokjs33/F/qEQAisoiDkuE50PH9P5dpa/EWsmU4eHs1SO0Aao6x1WX+8wzR8ghf5Hk0=
X-Received: by 2002:a05:6871:e2a9:b0:25e:eab:6d32 with SMTP id
 586e51a60fabf-27c688c0640mr1090936fac.5.1726209666728; Thu, 12 Sep 2024
 23:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-5-gourry@gourry.net>
In-Reply-To: <20240906202745.11159-5-gourry@gourry.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 09:40:30 +0300
Message-ID: <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Gregory,

On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
>
> If the log version is not sane (0 or >2), don't attempt to use
> the rest of the log values for anything to avoid potential corruption.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/tpm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 6e03eed0dc6f..9a080887a3e0 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
>                 return -ENOMEM;
>         }
>
> +       if (!log_tbl->version ||
> +           log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> +               pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
> +                      log_tbl->version);
> +               early_memunmap(log_tbl, sizeof(*log_tbl));
> +               efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> +               return -EINVAL;

I don't think we need this check at all. Did you actually see this happening?
efi_retrieve_eventlog() that runs during the efistub tries to retrieve
the log and the EFI protocol itself explicitly says that the firmware
*must* return EFI_INVALID_PARAMETER if the event log is not in 1.2 or
2.0 format. If the firmware does something wrong, we should report the
FW BUG in that function, instead of installing the config tables Linux
uses internally to handover the log and catching it late.

Thanks
/Ilias



> +       }
> +
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>         if (memblock_reserve(efi.tpm_log, tbl_size)) {
>                 pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> --
> 2.43.0
>

