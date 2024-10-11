Return-Path: <linux-kernel+bounces-361641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9462999AAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62A01C21C36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64C1C3F0A;
	Fri, 11 Oct 2024 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmS3c8vA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996811BB6BB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669537; cv=none; b=n8kjx6iRp1/D8pdJdh578qA7j9ru3bNl+YY53G00ecWfwo+G2u6dOXq3qUY4j4BXr5aFQMoAwoKOAaovMnmewBVc2t21HTHFDC84i4fNafbzIEyFHUoPkv4rMH++9naxAZ5qYDMSqf1sNBQ8uZ46fSv9qB5a9A7vjxrIlganUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669537; c=relaxed/simple;
	bh=MTP9v94kHA+EdXU2Uoykt2WGBeHhp0M9n/TQa9HNqbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSe6Fbrw5FO0iYOpwyD+4XewX+h+fx4smGQcNOmOi9q9de8cAmJMuCJhVyAP+qYGHEyRwAch+cVuDxLLTlnQVnnxz/vhEPhoN27QesBCujUZi+qAeEsQyl96qfKl3EMGuHGQEr3pX60LMPEMj8SQx2kSRr/2/ITC111hq1GTPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmS3c8vA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BDa30H027028
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AS1rxy8qMQglCbFoeSipseWM
	7ev0lwhscuoExty4uFg=; b=kmS3c8vAjBNrpWF44ABBl+WXgJPO3MZUpKlANOrd
	XdTmipfvHSHGHb8fRhB3qdk3LGFvEqMdcjJBxw6EimxARGXd45eOV1MKEiDGwEo8
	UfaaXzwy56eCISgNV2Pa7b5beHZw5SLdIlqt1Ie+aaVbVgrAc80F6ELHOOEZQHxt
	Rao2rO+gkAsTCJSNNiXO2jAZH+2rF5C5TirDAQKKkpz25Sp3bNHMA1sKpsEj/N6L
	zrsiDaz3o3bLbY7JEcDRRTL1qimsX3OEA/0AJuLFSUdDakiB4YHOZf7u0n5r5EY4
	RBbu1U9dhhiWCyK0hfM+ea0JHMscDYqdm9eTXOV5CvKM3Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426fj6v635-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:58:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20c92707255so18099275ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669532; x=1729274332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS1rxy8qMQglCbFoeSipseWM7ev0lwhscuoExty4uFg=;
        b=DkNmPXVqR/ohCkvLI6HYazb67S+R6+9oTyG9Kp596EB3MTyrB/HsLfx9XuoZxQRUey
         oScg1i9sUZgvXWeaI4PZVtNLg2F07Ctd41qFibjng2HrcjEY2MLAoEwgI0HOQCgU11mn
         s94P3RxqyVymzFXXUwueUX5xqfOZRghbKSJBQ6ji0wFG1/sMuFCaAeR53r+Pg4CtGgMX
         Hv4kyIXm2RXgRkYQTPm6x69ffPiH0a0S87VLLheNnp16pMWKXeMT51k/Hjz0a84+nNco
         UAozB9SgAhw77YV+oHWTte61x9xoKvTgxybIxbStHPhVvZWQwXGGj2V1y4KmqV66DhNa
         /Htw==
X-Forwarded-Encrypted: i=1; AJvYcCUi8CJqFjqbNvIyEdOnoH65XOSMY3enOcsdFbodMTIRcIQ+O71UZ6LkGP/bQRG0cWbjD4oo7uSHkE331Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVCM7xSjKcn1Q3SkIbXqxsdp2IAw6zjHdOpgSDn4wPb8/D0RE
	H5T6WQNNK7EaYfCP2z8MJnnTSpdeV8agRE3iYgVH7KOTGF/IWy0nHTH0724n2ExWit+5ug/Y1jC
	PFf2kCazLcbOdi/M09te9zEr9Lx57ZdVzUImg3irD6MUFaiF9M5jgkweA04rYKRg=
X-Received: by 2002:a17:903:2285:b0:20b:80e6:bcdf with SMTP id d9443c01a7336-20cbb1a9314mr6647485ad.23.1728669531959;
        Fri, 11 Oct 2024 10:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFESTnYEwGemJ5Xft5cNtABvqj2e5cIVHpOKMOt3qbTDrZt0qv/vOWjSGlEPCys96ek2YjhYw==
X-Received: by 2002:a17:903:2285:b0:20b:80e6:bcdf with SMTP id d9443c01a7336-20cbb1a9314mr6647185ad.23.1728669531614;
        Fri, 11 Oct 2024 10:58:51 -0700 (PDT)
Received: from hu-bjorande-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc0c9f5sm26009615ad.82.2024.10.11.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:58:50 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:58:48 -0700
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: andi.shyti@kernel.org, quic_bjorande@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        quic_vdadhani@quicinc.com, vkoul@kernel.org
Subject: Re: [PATCH v2] i2c: i2c-qcom-geni: Serve transfer during early
 resume stage
Message-ID: <ZwlnWIWkS1pwQ/xK@hu-bjorande-lv.qualcomm.com>
References: <20241011121757.2267336-1-quic_msavaliy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121757.2267336-1-quic_msavaliy@quicinc.com>
X-Proofpoint-GUID: Fg8SbrZwNA_ZBC9K4vPThUe3zEh7H3Wx
X-Proofpoint-ORIG-GUID: Fg8SbrZwNA_ZBC9K4vPThUe3zEh7H3Wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410110125

On Fri, Oct 11, 2024 at 05:47:57PM +0530, Mukesh Kumar Savaliya wrote:

Your recipients list is broken. Please check go/upstream and adopt b4 to
help avoid such mistakes.

> pm_runtime_get_sync() function fails during PM early resume and returning
> -EACCES because runtime PM for the device is disabled at the early stage
> causing i2c transfer to fail. Make changes to serve transfer with forced
> resume.
> 
> Few i2c clients like PCI OR touch may request i2c transfers during early
> resume stage. In order to serve transfer request do :
> 

This problem description is too generic. I am not aware of any use case
upstream where PCI or touch might need to perform i2c transfers during
early resume; your commit message should educate me.

> 1. Register interrupt with IRQF_EARLY_RESUME and IRQF_NO_SUSPEND flags
>    to avoid timeout of transfer when IRQ is not enabled during early stage.
> 2. Do force resume if pm_runtime_get_sync() is failing after system
>    suspend when runtime PM is not enabled.
> 3. Increment power usage count after forced resume to balance
>    it against regular runtime suspend.
> 

Please avoid the bullet list form technical description of your patch.

> Co-developed-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
> v1 -> v2:
> 
> - Changed gi2c->se.dev to dev during dev_dbg() calls.
> - Addressed review comments from Andi and Bjorn.

That's nice, but spell out the changes you're doing so that reviewers
now what you did.

> - Returned 0 instead garbage inside geni_i2c_force_resume().
> - Added comments explaining forced resume transfer when runtime PM
>   remains disabled.
> 
> V1 link: https://patches.linaro.org/project/linux-i2c/patch/20240328123743.1713696-1-quic_msavaliy@quicinc.com/
> ---
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 61 +++++++++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 212336f724a6..e1207f1a3de3 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -134,6 +134,8 @@ struct geni_i2c_clk_fld {
>  	u8	t_cycle_cnt;
>  };
>  
> +static int geni_i2c_runtime_resume(struct device *dev);
> +
>  /*
>   * Hardware uses the underlying formula to calculate time periods of
>   * SCL clock cycle. Firmware uses some additional cycles excluded from the
> @@ -675,22 +677,49 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
>  	return num;
>  }
>  
> +static int geni_i2c_force_resume(struct geni_i2c_dev *gi2c)
> +{
> +	struct device *dev = gi2c->se.dev;
> +	int ret;
> +
> +	ret = geni_i2c_runtime_resume(dev);

Wouldn't pm_runtime_force_resume() help you do what you're looking for?

> +	if (ret) {
> +		dev_err(gi2c->se.dev, "Failed to enable SE resources: %d\n", ret);
> +		pm_runtime_put_noidle(dev);
> +		pm_runtime_set_suspended(dev);
> +		return ret;
> +	}
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	return 0;
> +}
> +
>  static int geni_i2c_xfer(struct i2c_adapter *adap,
>  			 struct i2c_msg msgs[],
>  			 int num)
>  {
>  	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
> +	struct device *dev = gi2c->se.dev;
>  	int ret;
>  
>  	gi2c->err = 0;
>  	reinit_completion(&gi2c->done);
> -	ret = pm_runtime_get_sync(gi2c->se.dev);
> -	if (ret < 0) {
> -		dev_err(gi2c->se.dev, "error turning SE resources:%d\n", ret);
> -		pm_runtime_put_noidle(gi2c->se.dev);
> -		/* Set device in suspended since resume failed */
> -		pm_runtime_set_suspended(gi2c->se.dev);
> -		return ret;
> +
> +	/* Serve I2C transfer by forced resume whether Runtime PM is enbled or not */
> +	if (!pm_runtime_enabled(dev) && gi2c->suspended) {
> +		dev_dbg(dev, "Runtime PM is disabled hence force resume, pm_usage_count: %d\n",
> +			atomic_read(&dev->power.usage_count));
> +		ret = geni_i2c_force_resume(gi2c);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = pm_runtime_get_sync(dev);
> +		if (ret == -EACCES && gi2c->suspended) {
> +			dev_dbg(dev, "pm_runtime_get_sync() failed-%d, force resume\n", ret);
> +			ret = geni_i2c_force_resume(gi2c);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	qcom_geni_i2c_conf(gi2c);
> @@ -700,8 +729,19 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>  	else
>  		ret = geni_i2c_fifo_xfer(gi2c, msgs, num);
>  
> -	pm_runtime_mark_last_busy(gi2c->se.dev);
> -	pm_runtime_put_autosuspend(gi2c->se.dev);
> +	/* Does Opposite to Forced Resume when runtime PM was not enabled and served
> +	 * Transfer via forced resume.

Please polish this comment.

Regards,
Bjorn

> +	 */
> +	if (!pm_runtime_enabled(dev) && !gi2c->suspended) {
> +		pm_runtime_put_noidle(dev);
> +		pm_runtime_set_suspended(dev);
> +		/* Reset flag same as runtime suspend, next xfer PM can be enabled */
> +		gi2c->suspended = 0;
> +	} else {
> +		pm_runtime_mark_last_busy(gi2c->se.dev);
> +		pm_runtime_put_autosuspend(gi2c->se.dev);
> +	}
> +
>  	gi2c->cur = NULL;
>  	gi2c->err = 0;
>  	return ret;
> @@ -818,7 +858,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	init_completion(&gi2c->done);
>  	spin_lock_init(&gi2c->lock);
>  	platform_set_drvdata(pdev, gi2c);
> -	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
> +	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq,
> +			       IRQF_NO_AUTOEN | IRQF_EARLY_RESUME | IRQF_NO_SUSPEND,
>  			       dev_name(dev), gi2c);
>  	if (ret) {
>  		dev_err(dev, "Request_irq failed:%d: err:%d\n",
> -- 
> 2.25.1
> 

