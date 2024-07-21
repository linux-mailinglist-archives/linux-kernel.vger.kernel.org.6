Return-Path: <linux-kernel+bounces-258119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C58B938407
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9C028142D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 08:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA8BE68;
	Sun, 21 Jul 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAEhPjRS"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF346256E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721550654; cv=none; b=L/V2eF6YZwr5IC89hnP0x1tUPmKqCoQPy8D0b96/7m10svMBwSYsxt7B0hKpc4Es7M90TRxj0d20sCoMcse83204LoO4w2wBH/0e71IGdsopNFJj6IxxwlTj/yzSLDga8fxRiXdeT5+gEvuQFqK1bzQBoa0XDdwOgzm2lzs8hlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721550654; c=relaxed/simple;
	bh=gZiLr53g7emxIq+w6dEC+wbTz7w9qZNQom4zVWb3NeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaeQmcGRV9O5hqyBmYLR3/oK1XC9TzXxSLApRDIrvnLYoazXdrOxAhUlo5o489IyOZ5VAmyxKIBvb2JKDTpO9PlSBx/+hKlBGqrt/bM0Yd8Od84bG9sTD2fudiQUcM8wXIXyLHVBfdlA4mdzt91g8/vRI0qz/vHqU0LnfYaGfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PAEhPjRS; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9db222782so1981065b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721550652; x=1722155452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z6SxzaLFMa/0kSdsQV9DLEd0mH2Xc1Dr3ABGtN1DCM4=;
        b=PAEhPjRSEtEo6kL7vW7PYOQ/KEDAVRlblg4P5kuTY40GVKXxHz+rUaGTYZOY8cbhBl
         SyuxcTv71GYySoJ/gJT0IoXNUqD0bQDw5hTCMKRPrEY765Rx+1EbzPbmU8eVfp77weEM
         TP05g6lewgf0dL1aDTa0/MNVWjNGdpy/B/8k9aHhLf/aVGvti9xF8hsdLMSP5AEpCW+y
         UHtqcr5HOI4mAJ9GqPCvlLfMHZiLh4TyUxvTbKmonU91Yx1XRxUfSKTEzqiGcK/kNkos
         zaTfiOC4vtlH1ULR22/9LGq+z2prZsv4JLtpbQAJXGeFhmn/hJPagpDf3REvSwgb1AzE
         3krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721550652; x=1722155452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6SxzaLFMa/0kSdsQV9DLEd0mH2Xc1Dr3ABGtN1DCM4=;
        b=R44M6CGH2YfXdA9n9Dm3TW8z/h1swCKmbkxTIzBNE+uovahyV6mYKZVl3lhVLFneyn
         iRhuElpLYyYXSGs2kyDF2Uq9xFhHEjVLBh7uIA4n7HIsBSf6q+KBY9LhOlEGoBLcX55V
         /3L6jkHa++TJVlL1QM8whCs845F784OtYW6XPcbU8Cd5zLaDtumiUTPxFdToytoEEVco
         ph9kXNfsc0/AT0WloE76BcJvXcDJ/DEJuexwloeC+9tpvbSz+PWYro0MQ5kDxv2vG8XL
         Ep21DyXWsw892Q7CvCHhg2TYghd5I474JSVywJPOQjSK7/0jVZ6SYM1qWn126Hg66PjC
         z5/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpjY2pMK9FbILw2CclkVLWwJvG5iFynGXHWmzTculH2vili0215bm0Bih8ETvs/zr6k1IHChwCEelbjSm5vgiyaNYyAbTAvsln3dtP
X-Gm-Message-State: AOJu0YywIvIAoS6GnRvjAw2HM/dwJ0Ru25GUI9XHDG/WkeQdj6eYguV1
	4ilajKAHVwviZ/hsmqohPADX9OaBAUWO7/Pk7ENa2lp3fbY5aWW+YA85qibfZA==
X-Google-Smtp-Source: AGHT+IFBw5J3+c4AIw9uGdqz5e1NYbaC8oSvh0D3lTfLHD3VRJeTOwwFxU5gvncwQAXr9qZGONLDkQ==
X-Received: by 2002:a05:6808:1528:b0:3d9:2986:5a3b with SMTP id 5614622812f47-3dae63746e6mr5533085b6e.37.1721550651850;
        Sun, 21 Jul 2024 01:30:51 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2591c1sm33199045ad.47.2024.07.21.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 01:30:51 -0700 (PDT)
Date: Sun, 21 Jul 2024 14:00:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc: quic_cang@quicinc.com, quic_nitirawa@quicinc.com, bvanassche@acm.org,
	avri.altman@wdc.com, peter.wang@mediatek.com, minwoo.im@samsung.com,
	adrian.hunter@intel.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Bean Huo <beanhuo@micron.com>,
	Maramaina Naresh <quic_mnaresh@quicinc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] scsi: ufs: core: Support Updating UIC Command
 Timeout
Message-ID: <20240721083046.GI1908@thinkpad>
References: <cover.1721261491.git.quic_nguyenb@quicinc.com>
 <44dc4790b53e2f8aa92568a9e13785e3bedd617d.1721261491.git.quic_nguyenb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44dc4790b53e2f8aa92568a9e13785e3bedd617d.1721261491.git.quic_nguyenb@quicinc.com>

On Wed, Jul 17, 2024 at 05:17:34PM -0700, Bao D. Nguyen wrote:
> The default UIC command timeout still remains 500ms.
> Allow platform drivers to override the UIC command
> timeout if desired.
> 
> In a real product, the 500ms timeout value is probably good enough.
> However, during the product development where there are a lot of
> logging and debug messages being printed to the uart console,
> interrupt starvations happen occasionally because the uart may
> print long debug messages from different modules in the system.
> While printing, the uart may have interrupts disabled for more
> than 500ms, causing UIC command timeout.
> The UIC command timeout would trigger more printing from
> the UFS driver, and eventually a watchdog timeout may
> occur unnecessarily.
> 
> Add support for overriding the UIC command timeout value
> with the newly created uic_cmd_timeout kernel module parameter.
> Default value is 500ms. Supported values range from 500ms
> to 2 seconds.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufshcd.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 21429ee..d66da13 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -51,8 +51,10 @@
>  
>  
>  /* UIC command timeout, unit: ms */
> -#define UIC_CMD_TIMEOUT	500
> -
> +enum {
> +	UIC_CMD_TIMEOUT_DEFAULT	= 500,
> +	UIC_CMD_TIMEOUT_MAX	= 2000,
> +};
>  /* NOP OUT retries waiting for NOP IN response */
>  #define NOP_OUT_RETRIES    10
>  /* Timeout after 50 msecs if NOP OUT hangs without response */
> @@ -113,6 +115,31 @@ static bool is_mcq_supported(struct ufs_hba *hba)
>  module_param(use_mcq_mode, bool, 0644);
>  MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from UFSHCI 4.0. 1 - enable MCQ, 0 - disable MCQ. MCQ is enabled by default");
>  
> +static unsigned int uic_cmd_timeout = UIC_CMD_TIMEOUT_DEFAULT;
> +
> +static int uic_cmd_timeout_set(const char *val, const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtou32(val, 0, &n);
> +	if (ret != 0 || n < UIC_CMD_TIMEOUT_DEFAULT || n > UIC_CMD_TIMEOUT_MAX)
> +		return -EINVAL;
> +
> +	uic_cmd_timeout = n;
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops uic_cmd_timeout_ops = {
> +	.set = uic_cmd_timeout_set,
> +	.get = param_get_uint,
> +};
> +
> +module_param_cb(uic_cmd_timeout, &uic_cmd_timeout_ops, &uic_cmd_timeout, 0644);
> +MODULE_PARM_DESC(uic_cmd_timeout,
> +		"UFS UIC command timeout in milliseconds. Defaults to 500ms. Supported values range from 500ms to 2 seconds inclusively");
> +
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
>  	({                                                              \
>  		int _ret;                                               \
> @@ -2460,7 +2487,7 @@ static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
>  {
>  	u32 val;
>  	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
> -				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
> +				    500, uic_cmd_timeout * 1000, false, hba,
>  				    REG_CONTROLLER_STATUS);
>  	return ret == 0;
>  }
> @@ -2520,7 +2547,7 @@ ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
>  	lockdep_assert_held(&hba->uic_cmd_mutex);
>  
>  	if (wait_for_completion_timeout(&uic_cmd->done,
> -					msecs_to_jiffies(UIC_CMD_TIMEOUT))) {
> +					msecs_to_jiffies(uic_cmd_timeout))) {
>  		ret = uic_cmd->argument2 & MASK_UIC_COMMAND_RESULT;
>  	} else {
>  		ret = -ETIMEDOUT;
> @@ -4298,7 +4325,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
>  	}
>  
>  	if (!wait_for_completion_timeout(hba->uic_async_done,
> -					 msecs_to_jiffies(UIC_CMD_TIMEOUT))) {
> +					 msecs_to_jiffies(uic_cmd_timeout))) {
>  		dev_err(hba->dev,
>  			"pwr ctrl cmd 0x%x with mode 0x%x completion timeout\n",
>  			cmd->command, cmd->argument3);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

