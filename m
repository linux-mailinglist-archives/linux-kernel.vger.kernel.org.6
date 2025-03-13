Return-Path: <linux-kernel+bounces-560101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF7A5FDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D722288008B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783919D084;
	Thu, 13 Mar 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgphnUfa"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF2154C04
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886916; cv=none; b=MlphzhG4JZad27ipbygsytJVoqbazsOsn/NXhpqPO0iVxFlPA8ZTvOB9rkwEOAbLsLoriV3Q8mcxin1oz030jpgovChkB/lF6HUNTwMDaf9jyXODdwzYhnj7c60Sw6iuJx/zYWoJpPvBpzfCnow7CEcrycvwMZgltEVHEeEtumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886916; c=relaxed/simple;
	bh=uATKcbHrr4oTJE/cn4lhLMPPtuzpNY/82PPgYbeOaKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuS/c02xohcPmczkeseCmdAijKLl0oCIoVoNpguZHg1WgKTz67ZExs2xGXt2sM4EQkVomOp9gyUwEhRAPiDSD7zZwnsnc1T10Mok5Zw1KGqdNuOQ4aJ3t+wTLLJwMtCGdQX/hVFL4hsE+5iaXDCO5Z8wjOMkVWfi5hJRzAWkefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgphnUfa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so2212160a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741886914; x=1742491714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZrGVNwUQ5jJGSVofb8QOBJpSOkJrQt8IsuJ+7RddHI=;
        b=zgphnUfabVju1LN+pQ09wRKtcqsLT0YY7Uwtz5nCkkbctLSlck3KwcRQO7RNNmbHzE
         E4Om9pINvxGeDVF91NcRGVLRBxoQXpD2mqZrDp0kgsXd1+ZGdta+nZFwEwCMYEGsxZRt
         FOe2c5kHtOvqicG7sRXMdVKFlZMiF6XtOu3gQ/7+1/poDVFJQMMQT33aVYAXYganrYLz
         8SQF80029uIdlM1FG6pXObyx77RbIPu1TUdNuSq8Jy0+yQfHHfPDhA/jpi7cl3jBrJDs
         VNmt6pvf8qo8NHPFhcgA8fXt3KIK+VHyy8J5kLUOBG52dwLiAGXw1cPASoByrh6ZdwH9
         2ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886914; x=1742491714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZrGVNwUQ5jJGSVofb8QOBJpSOkJrQt8IsuJ+7RddHI=;
        b=euF8cPs0wsEDGSQqRnaQ5U/40oOKcjY7e3jM5nRxCWWAcKEz1Ct4gKbjcuEhAm55eg
         ov4z5yP5Fltifgffrl6sPk2nSc+DI/3oaWCuIfHWsbcq0NzlVKwR9Ma+AoVLuC15NaGQ
         PXNZeVFzL+Y8kXi0xnaPMjJFSL8Ff3e9MilwxJ+Ia03fjCTrI131flUY0oFm3MYj0m+Z
         Gruq9D0LDqZ9hrcmkdPCD/H4x2CZpn7BFxKNg0NXwg0ZrsmnSpJyCJxsHVQ5wAPtJKa4
         +y3kpEyF+79bAoCERzwBh+28SkkqT1pOnW7Du0Csvdt1wp1P0QKLPtn1nqSojAeWYrrf
         JRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKZEUa8ff6ACpzAcPN7cdkhAOMkb0XasfReIkZmgyb/UG+0kv/bAn+nqrdcOfzFmFHEBTk/HPcrUObFJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzECoOKH/k09Gf7KiCx4PDVtVMOISs1m0zLt6FCpXtf+4ZWzI2I
	C/iPEsyjVKukCePTtkmdBGMebAkJI6+d+HT5m6pqHBe66SwTQjzt6g5bAEKgSw==
X-Gm-Gg: ASbGncthOYlIn0FdbEpJXerXXzAOkwAl3hckeJXs1QjnqU2q0MYzifLsnqf3aoDF0yr
	iM9vHG3FyAS1CxcBbZv07PQzrkT4Gp5JGzMpKzegG45/vDfUpIgOL4QlaxCoQf5ctNbYBbK+GUK
	wdPza5dkgD0uKsgul+H0BmptUhmWo3GJN7lUOvP3mwCuzwgSFvbMOo17ExTorNCLAEyL+xwMmQk
	zWLONTJc8/FJQIOIY7VEl4sjeyuQfghRnVNs5sSyyDzHgBgUDlaQKQNDlihhtR2sVLl6drlwTSq
	+uNWSx2+dBIn0fq+kAYY7qnYWVkneJhFSKPo4QFsbFo5m6koqOUzRg==
X-Google-Smtp-Source: AGHT+IEggtRzx3PbFGQOkRuQrNEotEzfOz11JYuzd2X6Iwabnvc8Zf8QuXU1XcSuu/NAfUiKCrzDgw==
X-Received: by 2002:a05:6a21:9188:b0:1f5:9024:3246 with SMTP id adf61e73a8af0-1f5bd7d2271mr844783637.17.1741886914092;
        Thu, 13 Mar 2025 10:28:34 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea93e1dsm1538175a12.69.2025.03.13.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:28:33 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:58:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc: quic_cang@quicinc.com, quic_nitirawa@quicinc.com, bvanassche@acm.org,
	avri.altman@wdc.com, peter.wang@mediatek.com, minwoo.im@samsung.com,
	adrian.hunter@intel.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Bean Huo <beanhuo@micron.com>,
	Ziqi Chen <quic_ziqichen@quicinc.com>,
	Keoseong Park <keosung.park@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Eric Biggers <ebiggers@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] scsi: ufs: core: add device level exception
 support
Message-ID: <20250313172826.xzqkrx5rzuqpvz7j@thinkpad>
References: <772730b9a036a33bebc27cb854576a012e76ca91.1741282081.git.quic_nguyenb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <772730b9a036a33bebc27cb854576a012e76ca91.1741282081.git.quic_nguyenb@quicinc.com>

On Thu, Mar 06, 2025 at 09:31:06AM -0800, Bao D. Nguyen wrote:
> The device JEDEC standard version 4.1 adds support for the device
> level exception events. To support this new device level exception
> feature, expose two new sysfs nodes below to provide
> the user space access to the device level exception information.
> /sys/bus/platform/drivers/ufshcd/*/device_lvl_exception
> /sys/bus/platform/drivers/ufshcd/*/device_lvl_exception_id
> 
> The device_lvl_exception sysfs node reports the number of
> device level exceptions that have occurred since the last time
> this variable is reset.
> The device_lvl_exception_id sysfs node reports the exception ID
> which is the JEDEC standard qDeviceLevelExceptionID attribute.
> The user space application can query these sysfs nodes to get more
> information about the device level exception.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-ufs | 23 +++++++++++
>  drivers/ufs/core/ufs-sysfs.c               | 54 ++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h             |  1 +
>  drivers/ufs/core/ufshcd.c                  | 61 ++++++++++++++++++++++++++++++
>  include/uapi/scsi/scsi_bsg_ufs.h           |  9 +++++
>  include/ufs/ufs.h                          |  5 ++-
>  include/ufs/ufshcd.h                       |  5 +++
>  7 files changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index ae01912..5cf3f43 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1604,3 +1604,26 @@ Description:
>  		prevent the UFS from frequently performing clock gating/ungating.
>  
>  		The attribute is read/write.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/device_lvl_exception
> +What:		/sys/bus/platform/devices/*.ufs/device_lvl_exception
> +Date:		March 2025
> +Contact:	Bao D. Nguyen <quic_nguyenb@quicinc.com>
> +Description:
> +		The device_lvl_exception is a counter indicating the number
> +		of times the device level exceptions have occurred since the
> +		last time this variable is reset. Read the device_lvl_exception_id
> +		sysfs node to know more information about the exception.
> +		The file is read only.

No. This attribute is RW and the write of 0 will reset the counter. Please
change it here and also in commit message.

Also document the spec version requirement for these attributes.

> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/device_lvl_exception_id
> +What:		/sys/bus/platform/devices/*.ufs/device_lvl_exception_id
> +Date:		March 2025
> +Contact:	Bao D. Nguyen <quic_nguyenb@quicinc.com>
> +Description:
> +		Reading the device_lvl_exception_id returns the device JEDEC
> +		standard's qDeviceLevelExceptionID attribute. The definition of the
> +		qDeviceLevelExceptionID is the ufs device vendor specific design.
> +		Refer to the device manufacturer datasheet for more information
> +		on the meaning of the qDeviceLevelExceptionID attribute value.
> +		The file is read only.
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index 90b5ab6..0248288a 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -466,6 +466,56 @@ static ssize_t critical_health_show(struct device *dev,
>  	return sysfs_emit(buf, "%d\n", hba->critical_health_count);
>  }
>  

[...]

> +int ufshcd_read_device_lvl_exception_id(struct ufs_hba *hba, u64 *exception_id)
> +{
> +	struct utp_upiu_query_response_v4_0 *upiu_resp;
> +	struct ufs_query_req *request = NULL;
> +	struct ufs_query_res *response = NULL;
> +	int err;
> +
> +	if (hba->dev_info.wspecversion < 0x410)
> +		return -EOPNOTSUPP;
> +
> +	ufshcd_hold(hba);
> +	mutex_lock(&hba->dev_cmd.lock);
> +
> +	ufshcd_init_query(hba, &request, &response,
> +			  UPIU_QUERY_OPCODE_READ_ATTR,
> +			  QUERY_ATTR_IDN_DEV_LVL_EXCEPTION_ID, 0, 0);
> +
> +	request->query_func = UPIU_QUERY_FUNC_STANDARD_READ_REQUEST;
> +
> +	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
> +
> +	if (err) {
> +		dev_err(hba->dev, "%s: failed to read device level exception %d\n",
> +			__func__, err);
> +		goto out;
> +	}
> +
> +	upiu_resp = (struct utp_upiu_query_response_v4_0 *)response;
> +	*exception_id = get_unaligned_be64(&upiu_resp->value);
> +
> +out:
> +	mutex_unlock(&hba->dev_cmd.lock);
> +	ufshcd_release(hba);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_read_device_lvl_exception_id);

There is no need to export this function.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

