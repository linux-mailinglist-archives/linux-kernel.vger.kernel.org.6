Return-Path: <linux-kernel+bounces-219120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8290CAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC03B25BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD119E80A;
	Tue, 18 Jun 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rz8/JDQy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC219CD03
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709116; cv=none; b=NEiBGSgbcKsjohKw7aLbTawALanxnrHDswdhGxSvx4pC3fpbqAY8i4TTwlwVDTLo+1Kq1K+keadOAuvvWpevoiYfbj1YbyqcY/mZ84h+dsaBQDdv02HyuiYYuGff+LkE0XgohuLODjq72d6IRUzZ5q11KEXsFy+SQNjmhdWNoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709116; c=relaxed/simple;
	bh=4qr0Jwp+ToD1+DqxjeSolQYckZ2iWNyyhdqCVAQ4LF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rs33nH+Bdvhz0kYD1coAeWqRvlPD5ZaCBUAb56F6s/6G3fzLbtDOqLQVGD9y2pqH7jSzRJzv0SL9Y+f19AF9vFDRQFz9XxcfFFZkMVSmjq+knmIhCCjFOSjbTB90QgCMMpKYEMCpf805xjTYc4EKLEgTFMPafuZDHMLhB0wjsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rz8/JDQy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bd48cf36bso6093104e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718709113; x=1719313913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCJ1koSXaUSbG2q6a2DQFAstliIPSMU/Xsi5Jpzojx4=;
        b=Rz8/JDQyGsRKs5Jt+StFVWOyemVtLfb/emszqS3ebB3z3PMI6dJN5/lmLeEyeU3pZM
         EMuJsRFXOzh4NDzjIbOG0m3rUKaifdK0Cgtq2NC1VLsZrhIRJ+t6slAASlEnbd0AluMk
         4D2TPZ1wmaRUqiqaXWYALR99ndkcvZE8+y9fmvC3CasVHAh/4C2DSe/C7MYDkZ4o7RQf
         0r5+SmNm9WKT8uuzLEbQEINAmZhqN7KOHgXABWJvjAOLgbirxFb5yV2V39lOR4fsgn84
         K8Xof5/BbKLPQV6MSMGfRnvTfqWnVi4YniSeU40ciPD2Kcjx241DMxtKzLMxj9/FeR7H
         mjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709113; x=1719313913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCJ1koSXaUSbG2q6a2DQFAstliIPSMU/Xsi5Jpzojx4=;
        b=OjbrlxTRxxwjA64TxCOZMsbSrT0qoW2U6o5WhUkSRqyD6LFkvvyabmmMRoXrVvU5GR
         y1ipXKoVpBUBXN6RwZzoF+n41X2esD8hlRkGmd5BMYK1fPujBGwHPV6LLPY/YrhlV5Xp
         UCs1gOxJ6Twi8KAsGfLdhOUuBEQ8+b/+PieceQikpjiZrrL5i5KBOc0xkocZJz9i2KHJ
         zjP4iYS79raCwNvF2k5FhH//LgwMErMqT3rQ3eoFNl++bkWUwDuHPvM7+03WePG6Pmke
         8WpTaYECG0RIr9fIMl88Jmkghj35VZsKn3BVKuTVYSmtvuDBYXLbXccoE2ObAt4XRtqA
         VOCg==
X-Forwarded-Encrypted: i=1; AJvYcCUpYF23MhMCw9sTGV7AbVFVA+ABkX9NOx8Xk5Tlewn9My31hitAQLqFDWvDoavU/BAabe3rVu6EliAlQatemKDEKNbJ3Rlnry1cpybn
X-Gm-Message-State: AOJu0Yz2CMuc1ZnhRFd8aSzwXKE/u+Xzuq/1zGieETbfYITvipQCFMss
	XZ4jBX6CACA6x/5VEqm2K6D46mIAgTkR782XUz4RfJeLovDQiu1+is8g8zqnEg8=
X-Google-Smtp-Source: AGHT+IG4NDeCUql9vT+yjYQb6VBnlvabxwjfMz1iCQArGCJOw0YSMVEKgJePGYR0dmojAmuJWyu8kQ==
X-Received: by 2002:ac2:490e:0:b0:52c:9413:d02f with SMTP id 2adb3069b0e04-52ca6e659e9mr8585345e87.17.1718709113180;
        Tue, 18 Jun 2024 04:11:53 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f2ddsm1467138e87.87.2024.06.18.04.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:11:52 -0700 (PDT)
Message-ID: <948d34a9-ff11-4ec0-ab6f-05e87533caa8@linaro.org>
Date: Tue, 18 Jun 2024 13:11:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/msm/adreno: Move hwcg regs to a6xx hw catalog
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-4-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617225127.23476-4-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 00:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Move the hwcg tables into the hw catalog.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

