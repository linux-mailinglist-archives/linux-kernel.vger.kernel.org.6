Return-Path: <linux-kernel+bounces-327280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A71977350
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482F5B213CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71091C1AC9;
	Thu, 12 Sep 2024 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCC84n4q"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080913CFB7;
	Thu, 12 Sep 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175163; cv=none; b=bzZzCmrisaQhkKpmyQYoOz4UzCte8VG2RdwaqMxurUa5Tm52zgFgEWJRymyCEPNSvdPPup8wco1Zj/yYzpCGDyjoVSddeR7XUp2u/Sj/BZrh9rkvkT5acv0cUaS1cDUUhT2MvrEa7jWiz9f/jVB3MDA0LOoppJo5FxLhwlTLk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175163; c=relaxed/simple;
	bh=maVSLvZFLcsOdWoWALMsw18r/Gm24WEmErrDf8r4s7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ecp8ctA8RZKvqBhPOIAVVlvTASdMR8FRsKMGmj2vy0vmgDuumEdzrILpCRGsh4dmH2nx4mCtw2B1vWWCVvKxDKuy3IdZWl/1maq13fT2KHcZYiy3drfz+JUzfcXGtF5hy4UhJE49+X+4iULehwGHfVrlJoIrPAdXvNpHXWLcSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCC84n4q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso12857005e9.1;
        Thu, 12 Sep 2024 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726175160; x=1726779960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dCFCtYRF0r0oUa2Y3h+lyp5YSyFCuvNcC5gH+noZfs8=;
        b=dCC84n4qbTW+V0ECMMgnhvzCKmj0r0nRVUD4IIpZe4mNziFAgKLDajIhyUQZ+3UF/c
         6Vz4dGbOTitWqrEbm2NNxJN4RCcEZG4OwsNa2wk+4mmHAGEpcfSifBM2PE8cxqj+f2UV
         9hU5e7ITnDQJnfyGRA5SwLF/E30Wges+jk3hHeR756mkltgOiRa1Hp2BrZvMMAa1q7qc
         ohKuor1nR0HjVIgwe5aZyxfrNYbVzsP7KE3XNbKeiVhYgvFam9j/PwxVj4dlxBmf9RFF
         BfqUmQ0MFJBvT11oriJlN/noZyHBPBFQwM8dBaDfnEkG7CRIZuP3nR8oRNxGYCEXSyLt
         xSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175160; x=1726779960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCFCtYRF0r0oUa2Y3h+lyp5YSyFCuvNcC5gH+noZfs8=;
        b=FhMkY14mlOciBbBI8zp9cddI5N4AiJ8dSTbJ1mZXBIyr3J2Lu61IvWIiPDf5ktp59l
         0Yj/mC4GiJHA9roWd3MUpXFyt5BI/cAPJD0xSDBYADQKgtK+KPKSVSDTo15ZQK2ARssH
         KpTfEUJ4B40IIygtUgc9RV3HduTHGkU9UG3iNVKqcL+Fusq5mZ/OS2XSrh61bKRoSdmv
         XRZ2f5yFbJJtKMDlhS86bO2LV/0HtZAfq9kUex33HbPbPWUUPcIEUvSSZT36ksX8fNAX
         horI//quWhQoB0uIpLSaGtVEhKCL77doSPQjZSFGU60KM3p2pvxDBTMrrFqThWQIDYIR
         mGXA==
X-Forwarded-Encrypted: i=1; AJvYcCWiSDlP8gsiLRV3BPkST96Kn9RWKl55geg66bjaJZ76p/1CV48/sIdO3gyWIAnDxiWVwb1lELz8pA/MflKI@vger.kernel.org, AJvYcCXGhRG4CZ5jR2zptglFoh3cTOyv3N3LxcUl5TECborR4BatDWiUf5jbxFhwBFBQJq2MKrR7I3H8+g==@vger.kernel.org, AJvYcCXLPdiElV5vsAo71eGXIM0M2fFkIOKE0LTOj024hC15DUk+Z7WXoYRojuy7aExAKe39scetKQX8HFF0eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEj6D6ENWAuKAEBAz4pMIOocQqGzk+x3aozDqAd3SI1FsqV4EC
	3hfhZX4pqbO26UPwxoUNaBki9pXgkAfX1ybxUbu2nNDB/7W3RQ2n
X-Google-Smtp-Source: AGHT+IE6dRu5huMEssWnMsPIy2t6zBPfrKMsG6Pz+edE4URaDTNGGNiP4KPcM+oZQLgD+z2/2tnhVw==
X-Received: by 2002:a05:6000:c86:b0:374:b3a3:3f83 with SMTP id ffacd0b85a97d-378c2d617cemr2360491f8f.53.1726175159433;
        Thu, 12 Sep 2024 14:05:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956dd932sm15173971f8f.98.2024.09.12.14.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 14:05:58 -0700 (PDT)
Message-ID: <1ea7fff0-149d-408a-b5a7-1b223e8509d0@gmail.com>
Date: Thu, 12 Sep 2024 14:05:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] firmware: arm_scmi: Use max-rx-timeout-ms from
 devicetree
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com,
 dan.carpenter@linaro.org, souvik.chakravarty@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <20240730144707.1647025-4-cristian.marussi@arm.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240730144707.1647025-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 07:47, Cristian Marussi wrote:
> Override default maximum RX timeout with the value picked from the
> devicetree, when provided.
> 
> Suggested-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 332cd5207bbc..e7dab0eea540 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2964,6 +2964,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
>   static const struct scmi_desc *scmi_transport_setup(struct device *dev)
>   {
>   	struct scmi_transport *trans;
> +	int ret;
>   
>   	trans = dev_get_platdata(dev);
>   	if (!trans || !trans->desc || !trans->supplier || !trans->core_ops)
> @@ -2980,6 +2981,14 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
>   
>   	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
>   
> +	ret = of_property_read_u32(dev->of_node, "max-rx-timeout-ms",
> +				   &trans->desc->max_rx_timeout_ms);
> +	if (ret && ret != -EINVAL)
> +		dev_err(dev, "Malformed max-rx-timeout-ms DT property.\n");
> +
> +	dev_info(dev, "SCMI max-rx-timeout: %dms\n",
> +		 trans->desc->max_rx_timeout_ms);

I am bit on the fence on that change, it is useful, and we have done 
similar things before using a command line parameter.

This is definitively useful when bringing up new systems where you might 
be sprinkling enough debugging messages that this pushes your message 
processing logic too close to the default 30ms timeout. For normal use 
cases, we really want the message timeout to be as small as possible for 
most SCMI traffic but if we want the timeout to be configurable, that 
might have have to be on a per-message basis.
-- 
Florian

