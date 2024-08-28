Return-Path: <linux-kernel+bounces-305040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36B962886
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A240D2828E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D518784C;
	Wed, 28 Aug 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQqwOhYc"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E554176AA3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851280; cv=none; b=SROfxFglrsN3BbDlNgFkrPWVMsLBnqtZCIcDbw+MkNSG0nvBg7Z8k4tCVf+4hbY7YEkof8GJbYoxNcujv8LvgIL9RvuRB3GNWLP4xs1KISoXTjOQfcTx0f4jeDNy+b7h6fh54OB8Atr4fGnmyAuaTggN/JJiNOx1pY/Y9MNmlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851280; c=relaxed/simple;
	bh=D+7nUxeWxF7+imi13C+bI1JPqaQWgqJIK4NeOS4udow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQlXex3izYboJ9Cvf/5chMekenTeod9syLXoZ/DgaUhLt2gqwNRs34+PpNtLtOKyMErQQjXsCWSmELQUUSMLciZjYLJzerdU8P9fIJl2MgCdE6Vyil5hG8dnK8Fkv6xuG6euCmeUeHSg4BDSSfoZkBFm24jJ2QVTnYgbtJvDhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQqwOhYc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so3661791a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724851278; x=1725456078; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNG0tEOd8XWp2aVP4rYbOAd9YCHzqDwou1Nrb2RcN7E=;
        b=YQqwOhYcYjuYap1U4wPLOw5YFsPv3HRlZ3JsuOULymLB9wxdVsu4OzIBNWgGGXo8Wk
         BGD2oUY8R6bmIiKniV4Wc1BP+IMyqN2idDnsN1avPJbO+PFQUNWQKua9sO0ihAj2byCS
         E8pozZKnAtZnp/iXr4G9dvQZ82sWyjGa6Ivp7QmqIF6U2YTcJuD8LAJMh+Szsx1hadwd
         m31QcLZo2lhya8o7Y+OMTuKoilpuh6IN8+iMKtlyba4YWNtRB1dVJFPSG067iLcPjRT+
         Y73Klok7rT+1lY6N4dDOsm6SsSGVdk2/wz2GfV7f1097Mtn4DZyyRRxKwuwYcBQUThKO
         MA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851278; x=1725456078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNG0tEOd8XWp2aVP4rYbOAd9YCHzqDwou1Nrb2RcN7E=;
        b=Px6jAT60BgH4GoIGzcLAKtyzEQe+o031F/XjZL5aEgpKnaHokOxH4NXoi8VdP/fXxS
         bZLw4lktwCTpRc6c0SysPh5gx2WmE5utjXhlXJ6UPgYc4FzBowq7me+3g2+W6DdCij1U
         ji01ZmjTb1wNBbZ/srtN7YQR+1noKWNjJ1aidraOsuz/GQ18ecqyz/h4eydK+mGvDjdZ
         YwjY+U7NpVSJ6PPWVr4oIdVAxUaGAsEdF2dojXh6reOabN0JQ0mfVEm23/VZBARCL+3e
         VYyc07ArJoF4seCGTCKv/2edoHaJMAnj8qeyka/zTHfZN+iXaUDTtkZh3LCszeZ9u4KT
         s5/w==
X-Forwarded-Encrypted: i=1; AJvYcCUtWBLHh9E8MKCcEyuDKyzKtOH2Y7tTsOtSAa3FVc2FEUobqVDk8bgSsi1wljg2r0hO7J7hWUhvDOCpzGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNQKprX47mK5AzMRqW94PP3eakS9GKt4ljraSyfyOIORGliuL
	9DQYvY2Cg3lngxSsmMeF+8D+SCTF1Ycef90/Qqwo0bAaM5CW0CImtN/WxD+0DA==
X-Google-Smtp-Source: AGHT+IFvrPYSygKDYA7zlYJkbVh54L0Xymzma+SssWfADUbWO6/UYuCjYq65WJaiPtjZxw0YTgMzIw==
X-Received: by 2002:a17:90a:f48a:b0:2c9:67f5:3fae with SMTP id 98e67ed59e1d1-2d646cebc9fmr14810136a91.28.1724851277604;
        Wed, 28 Aug 2024 06:21:17 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f3c86sm1761970a91.52.2024.08.28.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:21:17 -0700 (PDT)
Date: Wed, 28 Aug 2024 18:51:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc: quic_cang@quicinc.com, quic_nitirawa@quicinc.com, bvanassche@acm.org,
	avri.altman@wdc.com, peter.wang@mediatek.com,
	adrian.hunter@intel.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Bean Huo <beanhuo@micron.com>, ChanWoo Lee <cw9316.lee@samsung.com>,
	Maramaina Naresh <quic_mnaresh@quicinc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] scsi: ufs: core: Remove ufshcd_urgent_bkops()
Message-ID: <20240828132111.7yineo6u3ozumdvu@thinkpad>
References: <0c7f2c8d68408e39c28e3e81addce09cc0ee3969.1724800328.git.quic_nguyenb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c7f2c8d68408e39c28e3e81addce09cc0ee3969.1724800328.git.quic_nguyenb@quicinc.com>

On Tue, Aug 27, 2024 at 04:14:13PM -0700, Bao D. Nguyen wrote:
> The ufshcd_urgent_bkops() is a wrapper function.
> It only calls the ufshcd_bkops_ctrl(). Remove it to
> simplify the ufs core driver. Replace any references
> to ufshcd_urgent_bkops() with ufshcd_bkops_ctrl().
> 
> In addition, remove the second parameter in the
> ufshcd_bkops_ctrl() because the information can be
> retrieved from the first parameter.
> 

Maximum allowed columns in patch description is 75, please make use of it.

> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 32 +++++++-------------------------
>  1 file changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 21429ee..a52c95b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5895,12 +5895,11 @@ static inline int ufshcd_get_bkops_status(struct ufs_hba *hba, u32 *status)
>  /**
>   * ufshcd_bkops_ctrl - control the auto bkops based on current bkops status
>   * @hba: per-adapter instance
> - * @status: bkops_status value
>   *
>   * Read the bkops_status from the UFS device and Enable fBackgroundOpsEn
>   * flag in the device to permit background operations if the device
> - * bkops_status is greater than or equal to "status" argument passed to
> - * this function, disable otherwise.
> + * bkops_status is greater than or equal to the "hba->urgent_bkops_lvl",
> + * disable otherwise.
>   *
>   * Return: 0 for success, non-zero in case of failure.
>   *
> @@ -5908,11 +5907,11 @@ static inline int ufshcd_get_bkops_status(struct ufs_hba *hba, u32 *status)
>   * to know whether auto bkops is enabled or disabled after this function
>   * returns control to it.
>   */
> -static int ufshcd_bkops_ctrl(struct ufs_hba *hba,
> -			     enum bkops_status status)
> +static int ufshcd_bkops_ctrl(struct ufs_hba *hba)
>  {
> -	int err;
> +	enum bkops_status status = hba->urgent_bkops_lvl;
>  	u32 curr_status = 0;
> +	int err;
>  
>  	err = ufshcd_get_bkops_status(hba, &curr_status);
>  	if (err) {
> @@ -5934,23 +5933,6 @@ static int ufshcd_bkops_ctrl(struct ufs_hba *hba,
>  	return err;
>  }
>  
> -/**
> - * ufshcd_urgent_bkops - handle urgent bkops exception event
> - * @hba: per-adapter instance
> - *
> - * Enable fBackgroundOpsEn flag in the device to permit background
> - * operations.
> - *
> - * If BKOPs is enabled, this function returns 0, 1 if the bkops in not enabled
> - * and negative error value for any other failure.
> - *
> - * Return: 0 upon success; < 0 upon failure.
> - */
> -static int ufshcd_urgent_bkops(struct ufs_hba *hba)
> -{
> -	return ufshcd_bkops_ctrl(hba, hba->urgent_bkops_lvl);
> -}
> -
>  static inline int ufshcd_get_ee_status(struct ufs_hba *hba, u32 *status)
>  {
>  	return ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> @@ -9801,7 +9783,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  			 * allow background operations if bkops status shows
>  			 * that performance might be impacted.
>  			 */
> -			ret = ufshcd_urgent_bkops(hba);
> +			ret = ufshcd_bkops_ctrl(hba);
>  			if (ret) {
>  				/*
>  				 * If return err in suspend flow, IO will hang.
> @@ -9990,7 +9972,7 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  		 * If BKOPs operations are urgently needed at this moment then
>  		 * keep auto-bkops enabled or else disable it.
>  		 */
> -		ufshcd_urgent_bkops(hba);
> +		ufshcd_bkops_ctrl(hba);
>  
>  	if (hba->ee_usr_mask)
>  		ufshcd_write_ee_control(hba);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

