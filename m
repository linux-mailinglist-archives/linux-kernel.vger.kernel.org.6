Return-Path: <linux-kernel+bounces-242100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC243928385
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DFB281B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F813AA2C;
	Fri,  5 Jul 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLE4c9d6"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1D2BD18
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167448; cv=none; b=meg/js052xJ8sQ5BWBXK2GrBDnDHaNLTaylFbR0AZHAF6XG89oAC1w+UjMzE6CTHRfLiDkQVnL0W20e1tnC9Dr2B5QVKwZG3WfSU+CDdX5WswcK77JZIvEMqtr4R369MRaGH2Tiq0P7hE6fTX/2h9IvOqQKL7iH8ZYHwnSR2eG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167448; c=relaxed/simple;
	bh=k5hKYMpK350fWSBFrhuiU216jTabEoDlXMzzmkTopgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPyiZsrP7lp4MWE63lbarD86eukNfN7Y5Nq/F7ZkH+S9MvjypszS3B/pFeNpY6gs0ty7EBmcT5o9iwsABP2YJtblMBH6vLL6z0r4RLok+xVEyRL0UVYGSUGEhUMEXd3SKxQ4AmETXlPg0DgcVc+vv+TaYQAOO7N9oA+dtfrXcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLE4c9d6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70af4868d3dso951891b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720167446; x=1720772246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzfKlM/Vn4uJrrvE1tXg7/xNfMnv4vE3PiH11TPIKHk=;
        b=uLE4c9d6Aio/xxuexRO4VCwPbQU++mUzUIQTecvdLGWVaROYj/eWy0TWbviov2D3Hv
         Vp7IWd+4qgQzl/ZAkiSAa53L3np31/DmB99uwjtS/f0LRwVANinmxswJ5qmFya9LDIIQ
         9gZ1IkiQvzsxGNzUbEFVw0vBlGO4XBhiolbd570vq0nz90Dj/AVT8k2jDTQ2dPmVA58i
         N9I/4sgwhqkWiKwXYGrrPVRDwq7OSYumrXO2Mgcavy6Xb3y5HWLvA2wd7SV73BT+a1wZ
         93jE9QL9ao4cr9Ly3RtVw9pZIouQml7k4/tFCQ17KOGFcqbr7v1TWBgS/icURkJDTJRS
         Z37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720167446; x=1720772246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzfKlM/Vn4uJrrvE1tXg7/xNfMnv4vE3PiH11TPIKHk=;
        b=S/CvIcVui+yelMplT4Fj4py19ZlJA81J0fV+sU5M1tRS6pAAx8Dzy8KOUgZ+ajFs4w
         sN2WWwZppTm4DqLHL0Gmd487vb50o/ZWZoeDnRDdbOAbhgYZwCG1xxpuy56cOIyhj3Ef
         WzCjw3g7fFIolnCqFQQaN53tWKTKPbZMeFC9JZnw5aigSgnvS2TfovYd2ZjottCJPw8L
         ggymZBBqL9uIj27KM5g9Ii5k6QTfCsbOxHPYEk9bpENp+h6Nta9MMTh1iWHPldmGnP18
         /msnaVckiuZIeQlwDOTvADgn4Xl3qV24xpKtiU9Eb+xU4zqp17rlaN/UCoTnQV6C78FB
         ijfw==
X-Forwarded-Encrypted: i=1; AJvYcCUOWBK60ERewx+QEorNTdo0CM2o8SERVB1WmLAiZrN1jIN6lV2VWvyt1794SFh7lU3xwTqs2hBJa+cm0SOSEJKi8RAYDb01ADXFcsfb
X-Gm-Message-State: AOJu0YwYZ0+n8JpS0lY+5vda4Bj7WsdGs1w0inRlu2+LQHw5OW9LDgn2
	+InUsnhRVyEET2iMNNhwnTLYti/aO/EQcJoOWpoL9FDGUpZWfXCJ+DaPL2uaKQE=
X-Google-Smtp-Source: AGHT+IH/Ok6sP+JdlabYWPmIV0ie4eKlTtC1WvqWC6Ox5nuRQtOPolIcc8ZRY7CawjQpGL835UjUPA==
X-Received: by 2002:a05:6a20:748b:b0:1bd:2368:829e with SMTP id adf61e73a8af0-1c0cc73b1e9mr4206880637.5.1720167445835;
        Fri, 05 Jul 2024 01:17:25 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a984507sm2815912a91.32.2024.07.05.01.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:17:25 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:47:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V3 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
Message-ID: <20240705081723.6y23ts757aunwyhi@vireshk-i7>
References: <20240705060650.243497-1-chenhuacai@loongson.cn>
 <20240705060650.243497-3-chenhuacai@loongson.cn>
 <20240705071313.ddl6geg72t4n7j3s@vireshk-i7>
 <CAAhV-H5q5hv2sA7EAm1D1nmbG-VGPzc4kpTnHMDSFuFiTKEH7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5q5hv2sA7EAm1D1nmbG-VGPzc4kpTnHMDSFuFiTKEH7A@mail.gmail.com>

On 05-07-24, 15:34, Huacai Chen wrote:
> It seems except changing mutex_init to devm_mutex_init, all other
> changes are line breaks? If so, I think additional tests are
> unnecessary. :)

Yeah, I just wanted to make sure the build passes and I have not
introduced a stupid bug.

> But now long lines (> 80 columns) are accepted by checkpatch.pl. Even
> with --strict, only > 100 columns are warned.
> 
> Especially for the change in loongson3_cpufreq_cpu_exit(), there is
> only 82 columns and I think that line can keep as the original state.
> And if possible, I also want the devm_kzalloc() line keep as original.

Fair enough. I am still hung on 80 columns I believe, but I shouldn't
be as the kernel has moved on :)

New diff (Prototype of exit() callback has changed in my tree, so a
change for that too).

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index a530e4a56b78..5f79b6de127c 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -31,10 +31,10 @@ union smc_message {
 };
 
 /* Command return values */
-#define CMD_OK				0  /* No error */
-#define CMD_ERROR			1  /* Regular error */
-#define CMD_NOCMD			2  /* Command does not support */
-#define CMD_INVAL			3  /* Invalid Parameter */
+#define CMD_OK				0 /* No error */
+#define CMD_ERROR			1 /* Regular error */
+#define CMD_NOCMD			2 /* Command does not support */
+#define CMD_INVAL			3 /* Invalid Parameter */
 
 /* Version commands */
 /*
@@ -230,7 +230,8 @@ static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int
 {
 	int ret;
 
-	ret = do_service_request(cpu_data[policy->cpu].core, FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
+	ret = do_service_request(cpu_data[policy->cpu].core,
+				 FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
 
 	return (ret >= 0) ? 0 : ret;
 }
@@ -310,13 +311,11 @@ static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+static void loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	int cpu = policy->cpu;
 
 	loongson3_cpufreq_target(policy, per_cpu(freq_data, cpu)->def_freq_level);
-
-	return 0;
 }
 
 static int loongson3_cpufreq_cpu_online(struct cpufreq_policy *policy)
@@ -348,13 +347,14 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
 	int i, ret;
 
 	for (i = 0; i < MAX_PACKAGES; i++)
-		mutex_init(&cpufreq_mutex[i]);
+		devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
 
 	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
 	if (ret <= 0)
 		return -EPERM;
 
-	ret =  do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE, FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
+	ret = do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE,
+				 FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
 	if (ret < 0)
 		return -EPERM;
 

Applied the patch. You need to take 1/2 through the arch specific
tree. Thanks.

-- 
viresh

