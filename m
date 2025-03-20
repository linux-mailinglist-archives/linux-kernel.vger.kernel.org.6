Return-Path: <linux-kernel+bounces-570073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C386FA6ABB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFED53BDB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A1223709;
	Thu, 20 Mar 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CU16RTa8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E8188915
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490687; cv=none; b=vDsTIwvBAQ0YtKtNzq2PYfTVgj88NDgazvaD4n2mMuDFWT5uqSyskKds+bgTysVh65bYoD0yKms27tUwKiB/5qzmXgJzoXbssDATPgNeWG7ocA4tQ6TYsfJOPFTBIDCTl8W+DlKhNpp9Bc96ZYU9H50kM55J7kLT8tE8CsY+tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490687; c=relaxed/simple;
	bh=oZH8Uuel0+yRQNWORDr6kA9v0JoudJDsYXEqg521FJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUMmkQxg9m5jSddexm1+qsqWH9OC/2cDmEc3oWrhzs1jh2TzHbrE6Ev+JeLxLFLpt1jTgE7fpGlQg44Uu66W6dhyWcyWH1sj+pEJcr8pnxDMgryH17jjeREktd0PiD0mpXkhinp2Bsfg+O0CwxaOGHI0bRNC7+nhCFnHiXrDfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CU16RTa8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso5352725e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742490682; x=1743095482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LszHKVAAmbCzrn3xqUVYloX7G0EimqlzgJrGy2gnmsI=;
        b=CU16RTa8IzquEBjkWTq+yFWD+PIH0VXwCjaipYXfgilEGI89OUY0r8D+qvJxRb6w5R
         +1IETKEwo9MgelgMzuwk5m77viHOJW54nVrU+vNJs3aNOGxf5w/6cXF38a9hG972fexy
         Ve5lNjevrs0uOTk7ffOlAe976IbXabIzdP8y2L5c0ArOXId8Z6Vc4b9k2Paj6jEb2HE+
         atirNc62tvlSgYfNz8yzo3414dqgJf2IxYFb7dnEGFlyn03CQYEvQau5QiPs9t15Xv/a
         /SehLLUtdC9t+4PxcOXwceXDAOCMhD7xDLmx7wk2gt0KY0Xebm5HkVVm4jarRZMeFQwy
         mQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742490682; x=1743095482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LszHKVAAmbCzrn3xqUVYloX7G0EimqlzgJrGy2gnmsI=;
        b=dOBLs7+ANhpw+tMYmf2H3txZjU/PxhmhlqJpGwK7HeNSCtSAkNnxcdsmBvOkh5TBJw
         MjP0FXE4kjqcd0ra3jksyeNzDNVZWXXtimj+pG2BPNci9/MwOsxrshWlU4WfTRzOQav3
         nmFy1GxmC6rl4zZ4YLJMnO91m6XaLeaeFj2rbSXH+pNHM3wJoDGVgd6d1JIK8qhtggPg
         FIuy9wYDY38x2XWATRrHcKa2EzpD7dVyEZQA4pfKU9PnUANoyKvm50rnBCyjoMpkNkpR
         URLKFddaDmHxdzUmtOMP6S705X1f797g7qnG5mPFCbz/t4baCyLBWH7OKT3q8ztw+JSj
         fRMg==
X-Forwarded-Encrypted: i=1; AJvYcCV2WMr4bSzWDcackiBqRL3jSrraxXLSr9qDxFovcufKbbDKo/DSOonjokrUb/MQOxuyH6u7U28dgCUvwQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypcEdEi9om5NzHVu3OxfwV5/PwbBWnRcs+6Iebbn5d8yIuL8rT
	11FZ2u/vHtZ3rUuRDL3H2wHidfmvHIln1KgVsEpX2ogqGRWvb33XVkXNWTk6PFU=
X-Gm-Gg: ASbGncunuLiiFnWZo3VZPTtwfYFQCjOeZlBTNgtB2bOxHujPL1OZQuYHvzeovlEjZHH
	3HUvK8sQ2aaYqXYN4A0n0rKFd6OkYf5WCmw1swDrET5VPQqQLR3LhUzbjnzHzkVzS3zZHUla7H4
	byNnuWAqR3ib0yTjsRIKFZETwyDCsmrIXrd19lxo8EgPYwSfycnr8J5I4MOX8xJsCO/sOb9C5+F
	3Y7aguq0DOHB4faxd3/ruBRsztrJxPdkUug3bsj+ykT0EkRPLvDp2Vo1skTC7Ruo4k5FujxwE+F
	bA/7b1SgKnBtkISEF4zqS3Pz0vbT0T9xafkIRz267o9AdUknEal/rPrBcmALvpE=
X-Google-Smtp-Source: AGHT+IEEqmDyc13593/QHHJ/rxN/j2FUptO7R/XTlEXHlWVEHh3gZS6BqeAIdYMHPC2w1m3aWmzwvQ==
X-Received: by 2002:a5d:6c67:0:b0:391:30f0:1704 with SMTP id ffacd0b85a97d-3997f9008d9mr339289f8f.4.1742490682128;
        Thu, 20 Mar 2025 10:11:22 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f6bsm141041f8f.39.2025.03.20.10.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 10:11:21 -0700 (PDT)
Message-ID: <30bba296-8e6f-41ee-880e-2d5ecc8fe5a4@linaro.org>
Date: Thu, 20 Mar 2025 17:11:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] misc: fastrpc: add support for gpdsp remoteproc
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-3-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20250320091446.3647918-3-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/03/2025 09:14, Ling Xu wrote:
> The fastrpc driver has support for 5 types of remoteprocs. There are
> some products which support GPDSP remoteprocs. Add changes to support
> GPDSP remoteprocs.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 7b7a22c91fe4..80aa554b3042 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -28,7 +28,9 @@
>   #define SDSP_DOMAIN_ID (2)
>   #define CDSP_DOMAIN_ID (3)
>   #define CDSP1_DOMAIN_ID (4)
> -#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
> +#define GDSP0_DOMAIN_ID (5)
> +#define GDSP1_DOMAIN_ID (6)

We have already made the driver look silly here, Lets not add domain ids 
for each instance, which is not a scalable.

Domain ids are strictly for a domain not each instance.


> +#define FASTRPC_DEV_MAX		7 /* adsp, mdsp, slpi, cdsp, cdsp1, gdsp0, gdsp1 */
>   #define FASTRPC_MAX_SESSIONS	14
>   #define FASTRPC_MAX_VMIDS	16
>   #define FASTRPC_ALIGN		128
> @@ -107,7 +109,9 @@
>   #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>   
>   static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
> -						"sdsp", "cdsp", "cdsp1" };
> +						"sdsp", "cdsp",
> +						"cdsp1", "gdsp0",
> +						"gdsp1" };
>   struct fastrpc_phy_page {
>   	u64 addr;		/* physical address */
>   	u64 size;		/* size of contiguous region */
> @@ -2338,6 +2342,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   		break;
>   	case CDSP_DOMAIN_ID:
>   	case CDSP1_DOMAIN_ID:
> +	case GDSP0_DOMAIN_ID:
> +	case GDSP1_DOMAIN_ID:
>   		data->unsigned_support = true;
>   		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>   		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);


Can you try this patch: only compile tested.

---------------------------------->cut<---------------------------------------
 From 3f8607557162e16673b26fa253d11cafdc4444cf Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 20 Mar 2025 17:07:05 +0000
Subject: [PATCH] misc: fastrpc: cleanup the domain names

Currently the domain ids are added for each instance of domain, this is
totally not scalable approch.

Clean this mess and create domain ids for only domains not its
instances.
This patch also moves the domain ids to uapi header as this is required
for FASTRPC_IOCTL_GET_DSP_INFO ioctl.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  drivers/misc/fastrpc.c      | 45 ++++++++++++++++++++-----------------
  include/uapi/misc/fastrpc.h |  7 ++++++
  2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7b7a22c91fe4..b3932897a437 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -23,12 +23,6 @@
  #include <uapi/misc/fastrpc.h>
  #include <linux/of_reserved_mem.h>

-#define ADSP_DOMAIN_ID (0)
-#define MDSP_DOMAIN_ID (1)
-#define SDSP_DOMAIN_ID (2)
-#define CDSP_DOMAIN_ID (3)
-#define CDSP1_DOMAIN_ID (4)
-#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
  #define FASTRPC_MAX_SESSIONS	14
  #define FASTRPC_MAX_VMIDS	16
  #define FASTRPC_ALIGN		128
@@ -106,8 +100,6 @@

  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, 
miscdev)

-static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
-						"sdsp", "cdsp", "cdsp1" };
  struct fastrpc_phy_page {
  	u64 addr;		/* physical address */
  	u64 size;		/* size of contiguous region */
@@ -1769,7 +1761,7 @@ static int fastrpc_get_dsp_info(struct 
fastrpc_user *fl, char __user *argp)
  		return  -EFAULT;

  	cap.capability = 0;
-	if (cap.domain >= FASTRPC_DEV_MAX) {
+	if (cap.domain >= FASTRPC_DOMAIN_MAX) {
  		dev_err(&fl->cctx->rpdev->dev, "Error: Invalid domain id:%d, err:%d\n",
  			cap.domain, err);
  		return -ECHRNG;
@@ -2255,6 +2247,24 @@ static int fastrpc_device_register(struct device 
*dev, struct fastrpc_channel_ct
  	return err;
  }

+static int fastrpc_get_domain_id(const char *domain)
+{
+	if (strncmp(domain, "adsp", 4) == 0) {
+		return ADSP_DOMAIN_ID;
+	} else	if (strncmp(domain, "cdsp", 4) == 0) {
+		return CDSP_DOMAIN_ID;
+	} else if (strncmp(domain, "mdsp", 4) ==0) {
+		return MDSP_DOMAIN_ID;
+	} else if (strncmp(domain, "sdsp", 4) ==0) {
+		return SDSP_DOMAIN_ID;
+	} else if (strncmp(domain, "gdsp", 4) ==0) {
+		return GDSP_DOMAIN_ID;
+	}
+
+	return -EINVAL;
+
+}
+
  static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
  {
  	struct device *rdev = &rpdev->dev;
@@ -2272,15 +2282,10 @@ static int fastrpc_rpmsg_probe(struct 
rpmsg_device *rpdev)
  		return err;
  	}

-	for (i = 0; i < FASTRPC_DEV_MAX; i++) {
-		if (!strcmp(domains[i], domain)) {
-			domain_id = i;
-			break;
-		}
-	}
+	domain_id = fastrpc_get_domain_id(domain);

  	if (domain_id < 0) {
-		dev_info(rdev, "FastRPC Invalid Domain ID %d\n", domain_id);
+		dev_info(rdev, "FastRPC Domain %s not supported\n", domain);
  		return -EINVAL;
  	}

@@ -2332,19 +2337,19 @@ static int fastrpc_rpmsg_probe(struct 
rpmsg_device *rpdev)
  	case SDSP_DOMAIN_ID:
  		/* Unsigned PD offloading is only supported on CDSP and CDSP1 */
  		data->unsigned_support = false;
-		err = fastrpc_device_register(rdev, data, secure_dsp, 
domains[domain_id]);
+		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
  		if (err)
  			goto fdev_error;
  		break;
  	case CDSP_DOMAIN_ID:
-	case CDSP1_DOMAIN_ID:
+	case GDSP_DOMAIN_ID:
  		data->unsigned_support = true;
  		/* Create both device nodes so that we can allow both Signed and 
Unsigned PD */
-		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
+		err = fastrpc_device_register(rdev, data, true, domain);
  		if (err)
  			goto fdev_error;

-		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
+		err = fastrpc_device_register(rdev, data, false, domain);
  		if (err)
  			goto populate_error;
  		break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f33d914d8f46..89516abd258f 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -133,6 +133,13 @@ struct fastrpc_mem_unmap {
  	__s32 reserved[5];
  };

+#define ADSP_DOMAIN_ID (0)
+#define MDSP_DOMAIN_ID (1)
+#define SDSP_DOMAIN_ID (2)
+#define CDSP_DOMAIN_ID (3)
+#define GDSP_DOMAIN_ID (4)
+
+#define FASTRPC_DOMAIN_MAX	4
  struct fastrpc_ioctl_capability {
  	__u32 domain;
  	__u32 attribute_id;
-- 
2.25.1


---------------------------------->cut<---------------------------------------

