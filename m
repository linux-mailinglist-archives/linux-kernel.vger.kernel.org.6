Return-Path: <linux-kernel+bounces-305120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD49629D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318451C23A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04D11891AA;
	Wed, 28 Aug 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFOvHwHw"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73940188CAC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854094; cv=none; b=kNI051mTRC+WFGI6H6bEnY5K5DOAOG3gEr97gE7kyY86bnHuijODQq3MUuqFF2ARH8Z1GDiYv+eIQ2q6fpdBq0WMMWbuufd9k7uBl0ite8RZsDH8oRYnMEho9qeJvHtM4c/4/CImlLtUaXFiX03llMaPEjYxeXE0QTqfLMOtpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854094; c=relaxed/simple;
	bh=6i0DTl1y7zbuvBA51P56G8/7JFUWcfprfnnfq9ZDKXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTVbfbXI4HqDzWxyL/hb0rx7nQXgwBXQ6vHFFraKvKf72gXMFU/cO10LULY3TTIVKTxA26vdozudYMDKMffgsisBl3sVQJ6IGfu1KaFeSYPqyWCTxlvhypUsSRcDEcteNP736e2cQOFJ01WwgWnx3GP8ODitBPDrtsgxPYCE4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cFOvHwHw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-715cdc7a153so526072b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854092; x=1725458892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5zUmIuVSMTrxDTnFMXgZkNU2N5FNce8+WlLOBteoNVY=;
        b=cFOvHwHwfljHavta4YLmoKqZtwznKuQ0A6ixSn66OfnP39G8NwkGohfbft8hb0S15c
         lgDxJmD/y6M7EgQpSTgPJTBghLDG8rlmmo03ZqfQb5d44HqkYSkscwexn8dzu2sFPGOm
         oxlV7dP3TS3FkA97YFecoYuTD6tFQ+fXunQVVVf5DK6HAFtiQMe2y8VUtzuj+87DKc45
         I35XgQiXmmRjtHMq30k0Y51QdvKNopel2Du5Vx2AnYPMW6VQuvDSoHiWpmpvkSwXBpPw
         0iozOZGpQT90YB5vdpAiBirdgCaQuIw3imWCLoDA1QhkJhmYrFjfdg39xDRMQCsWPBQi
         OOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854093; x=1725458893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zUmIuVSMTrxDTnFMXgZkNU2N5FNce8+WlLOBteoNVY=;
        b=MWdcCADsj90Cf9NvR3y46pT3LXUV+CkNDU69mNvL06b9114P4/p/upNBGnVkJ3cnUK
         AqCvIJbz5N8UIyFYwe28j0mD6I8MVdEHL6W5DAjEr4DPL7gMufyt47SCxb/v+PdjVuR/
         uji11apbbLyQX/aUSD+Q7yoZBydk7sRp+XfHYPhTuVbqcrAk7atKtJHbQLPm6I/yDJYM
         yRSipQ8273dLS7TDOAtcCzABCdeMMN82D4QZ3/sR/hsQwSgqu49V4PM6kvIyYpdtekNA
         tADM2zR30zeT0T87mB/3XJtkMK4k0pmydVOFXk+sjLUjXUplLvdbE2l/8IysB1++TJTd
         nSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUctMFL/PoASnbfCcTdByxdaL7Y4S9lG1i9B4snkb6rCCZuMC6EIvRCDqCiGk5g7kubkUigFSINqda12NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYjdxpHoEPqGG1LQzt1k/TydCUd68HP8F8qEdLw6S/eWn8N24
	QMNlPq7MLVhE19AuTMGuocHBZYFKUNlcj5B+82GbD+is+7P/mhWq0NOIq698QQ==
X-Google-Smtp-Source: AGHT+IHSBNCosOUJ4UP07jnycwgnAwwiOp55OzQxxQNujnZSA4wzt+zHe/mbquDbKqudh7XMBpjfDQ==
X-Received: by 2002:a05:6a00:23d2:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-715d10fdc97mr3135046b3a.8.1724854092494;
        Wed, 28 Aug 2024 07:08:12 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143425527esm10147003b3a.57.2024.08.28.07.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:08:12 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:38:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
	quic_rampraka@quicinc.com, quic_cang@quicinc.com,
	quic_nguyenb@quicinc.com
Subject: Re: [PATCH V2] scsi: ufs: ufs-qcom: add fixup_dev_quirks vops
Message-ID: <20240828140805.zhvand7q3wbdmfrt@thinkpad>
References: <20240828134032.10663-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828134032.10663-1-quic_mapa@quicinc.com>

On Wed, Aug 28, 2024 at 07:10:32PM +0530, Manish Pandey wrote:
> Add fixup_dev_quirk vops in QCOM UFS platforms and provide an initial
> vendor-specific device quirk table to add UFS device specific quirks
> which are enabled only for specified UFS devices.
> 

Why the quirks are enabled only for Qcom platforms? If these are required by the
UFS device, then they should be added to ufs_fixups[] in ufshcd.c.

> Micron and Skhynix UFS device needs DELAY_BEFORE_LPM quirk to have a
> delay before VCC is powered off.
> 

Micron fix is already part of ufs_fixups[].

> Toshiba UFS devices require delay after VCC power rail is turned-off
> in QCOM platforms. Hence add Toshiba vendor ID and DELAY_AFTER_LPM
> quirk for Toshiba UFS devices in QCOM platforms.
> 

This sounds like the issue is specific to Qcom platforms only.

> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> ---

Where is the changelog?

- Mani

>  drivers/ufs/host/ufs-qcom.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 810e637047d0..9dbfbe643e5e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -834,6 +834,25 @@ static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba)
>  	return err;
>  }
>  
> +/* UFS device-specific quirks */
> +static struct ufs_dev_quirk ufs_qcom_dev_fixups[] = {
> +	{ .wmanufacturerid = UFS_VENDOR_MICRON,
> +	  .model = UFS_ANY_MODEL,
> +	  .quirk = UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM },
> +	{ .wmanufacturerid = UFS_VENDOR_SKHYNIX,
> +	  .model = UFS_ANY_MODEL,
> +	  .quirk = UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM },
> +	{ .wmanufacturerid = UFS_VENDOR_TOSHIBA,
> +	  .model = UFS_ANY_MODEL,
> +	  .quirk = UFS_DEVICE_QUIRK_DELAY_AFTER_LPM },
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
> @@ -1798,6 +1817,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
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

