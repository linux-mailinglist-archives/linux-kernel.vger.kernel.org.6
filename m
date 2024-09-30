Return-Path: <linux-kernel+bounces-344386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31B98A8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCAE28408C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB037192D94;
	Mon, 30 Sep 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeARaNrO"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81999192B66
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711027; cv=none; b=OVJxqVWgHZdPNe/RPtEyIukUAmsWSCfgjtts3XORRO9bA5hHKOBCT+pov6VPneAZiYV97ka435FrUsqIXl3eXaN8HCoypYXrvLUqY1AYIKfSO47RsipYVH2lCvkhIaaFz6Yg8pHpCnPEXI3ylK5jL+8iwvXIbQwtfAyJNp5m9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711027; c=relaxed/simple;
	bh=cAsqa3qYXqhnj1agKTZPtloe67eD9YBRbldk75Q8XdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU9VuNbwZjhJL1Nhk27f1l4VgS2CtvQQ1Jwx9w85WDJlVA5uaCNS3R5mUCtSa+36DZ9+wbsoOEohlMwWk/GqMmYJfc//gfKmU3MnztL1IudWlKn7wL+GZ9oqvCoQPVarLcQGuHWqBTx+xbJWaRilKi/+6zwwn18AtIRJmDxrpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZeARaNrO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso3828480a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727711025; x=1728315825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fNZ4BRKI4heUuNuygwTDPDgSoVqXEGdj+M0ZAo01Wgw=;
        b=ZeARaNrOSp1o2mVfxWfRRBjHRE0mi+k8ASAskTBtp7s1WMBfucukn7nGWvYzTKDDzI
         CaPuFq5TO0zznh4sIU+ytGY+wvnkWU8Fbvs6/XSaqaXgDGNWSGdGG9DEBbh1BXTB0zs0
         LbQAaepT5e3QIgGNnR1xbI9TStHijRecWQkeudtjzIaF6R4OwyrsUDq/RV2whyiUIHaD
         fCHNUaw+TmajciAgHm4CfuUkBx99gFeljipdtm69Zn6jgGKOmfXe2bU4YE1HC8A82S5u
         va/1D2oShAOIW0XBO0wMcpISmD2G9lGByBTMUffV2B77LwvP/b1xsgO0F95Vs1Y2/RKC
         gH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711025; x=1728315825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNZ4BRKI4heUuNuygwTDPDgSoVqXEGdj+M0ZAo01Wgw=;
        b=Uexf8+3Sipi2LqTCLfwO5a2XVENKg7wqJcNyXXOGc3WTn/Py0tF44XOl+re5IYWSJY
         CxO6GP4vXdHJT+FcA4y8kIPAkmWHqTgiREIaxoeIOJ9w7LzUaKk1seCj92b5hFbMcQ3Y
         2Mz7Qqi8Tni/J8RMuqpg2lIY6ky36KtQ5g67Nqn8YxY3wZfIxeSRXw5irfV3gY8hf1AX
         7HPDbB5yoPMKD6JLhQdARc4ksM270onavjIpfUQnCXJTE4TOIJeJbQR80z7du3WFFrvY
         La23BZdsTw5FteTYUx5F42dJCqy2pXaqZQIlpxiLILF+P5J3on4YiNM34I9AsVPkeVJH
         V5qw==
X-Forwarded-Encrypted: i=1; AJvYcCWcQDlYYMxh7XwVd/2mPBqmO/2FGQOSeRhb8WgM+Hg6A2oYBPl+M6VkX7TstB+tcgpJ2Rlqj4dzQcxHf9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9329Ia16HNCAvqsn9lzQJf5+BfZzC6/OghgWv/CUQtbQC1VM
	i9vOieA0A8EDCFyDee2o2s0WW+9DNJW2UGDsEeqWQXSN6a9FUlapFzo0tIC00w==
X-Google-Smtp-Source: AGHT+IHHaRFu3mDRiM3/orLs2TA6CzeY6SJU7xXYhg2AH/bZOv0apPv2H6UgsN+fwa3K1V3zM5MW1A==
X-Received: by 2002:a05:6a21:3414:b0:1d2:e504:52ba with SMTP id adf61e73a8af0-1d4fa78b7a0mr20068809637.38.1727711024765;
        Mon, 30 Sep 2024 08:43:44 -0700 (PDT)
Received: from thinkpad ([36.255.17.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649ca2dsm6369843b3a.41.2024.09.30.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 08:43:44 -0700 (PDT)
Date: Mon, 30 Sep 2024 21:13:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
	quic_rampraka@quicinc.com, quic_cang@quicinc.com,
	quic_nguyenb@quicinc.com
Subject: Re: [PATCH V3] scsi: ufs: ufs-qcom: add fixup_dev_quirks vops
Message-ID: <20240930154337.r65qk2bps5jsgbnm@thinkpad>
References: <20240903131546.1141-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903131546.1141-1-quic_mapa@quicinc.com>

On Tue, Sep 03, 2024 at 06:45:46PM +0530, Manish Pandey wrote:
> Add fixup_dev_quirk vops in QCOM UFS platforms and provide an initial
> vendor-specific device quirk table to add UFS device specific quirks
> which are enabled only for specified UFS devices.
> 
> - Add DELAY_BEFORE_LPM quirk for Skhynix UFS devices to introduce a
>   delay before VCC is powered off in QCOM platforms.
> - Add DELAY_AFTER_LPM quirk for Toshiba UFS devices to introduce a
>   delay after the VCC power rail is turned off in QCOM platforms.
> - Move UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE quirk from
>   ufs_qcom_apply_dev_quirks to ufs_qcom_dev_fixups.
> 
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>

I'd still like to have these quirks in the core driver if they apply to other
platforms as well. But I'll leave it up to you to check with respective device
manufacturers.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Changes from v2:
> - Addressed Mani's comments.
> - Moved quirk for WDC to ufs_qcom_dev_fixups.
> 
> Changes from v2:
> - Integrated Bart’s feedback and consolidated the patches into one.
> ---
>  drivers/ufs/host/ufs-qcom.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index c87fdc849c62..6a715373d81c 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -828,12 +828,28 @@ static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba)
>  	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_PA_SAVECONFIGTIME)
>  		err = ufs_qcom_quirk_host_pa_saveconfigtime(hba);
>  
> -	if (hba->dev_info.wmanufacturerid == UFS_VENDOR_WDC)
> -		hba->dev_quirks |= UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE;
> -
>  	return err;
>  }
>  
> +/* UFS device-specific quirks */
> +static struct ufs_dev_quirk ufs_qcom_dev_fixups[] = {
> +	{ .wmanufacturerid = UFS_VENDOR_SKHYNIX,
> +	  .model = UFS_ANY_MODEL,
> +	  .quirk = UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM },
> +	{ .wmanufacturerid = UFS_VENDOR_TOSHIBA,
> +	  .model = UFS_ANY_MODEL,
> +	  .quirk = UFS_DEVICE_QUIRK_DELAY_AFTER_LPM },
> +	{ .wmanufacturerid = UFS_VENDOR_WDC,
> +	  .model = UFS_ANY_MODEL,
> +	  .quirk = UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE },
> +	{}
> +};
> +
> +static void ufs_qcom_fixup_dev_quirks(struct ufs_hba *hba)
> +{
> +	ufshcd_fixup_dev_quirks(hba, ufs_qcom_dev_fixups);
> +}
> +
>  static u32 ufs_qcom_get_ufs_hci_version(struct ufs_hba *hba)
>  {
>  	return ufshci_version(2, 0);
> @@ -1801,6 +1817,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
>  	.link_startup_notify    = ufs_qcom_link_startup_notify,
>  	.pwr_change_notify	= ufs_qcom_pwr_change_notify,
>  	.apply_dev_quirks	= ufs_qcom_apply_dev_quirks,
> +	.fixup_dev_quirks       = ufs_qcom_fixup_dev_quirks,
>  	.suspend		= ufs_qcom_suspend,
>  	.resume			= ufs_qcom_resume,
>  	.dbg_register_dump	= ufs_qcom_dump_dbg_regs,
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

