Return-Path: <linux-kernel+bounces-179219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE918C5D94
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF541C2117D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA41181CFD;
	Tue, 14 May 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkaXSBLI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB079182C85
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725049; cv=none; b=qdiE59shTlwCk2J+Wesu2O8R8JmfZ7Y5oOVWDFGxJxpnYOu+QZJB32votkWDLSkPYamOgUcm5FKpUkYqfyM1PEviswd7DwC6snIJ5PsdnBGa5o3VacNCLCWfMi65TnzDSSF4wuVpSF8wBkhejqRgb5tLeGqTaT57soEd+n1BPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725049; c=relaxed/simple;
	bh=dICNG5Mavyv9DTbDSfwvDK8paf3rfuTwOCDV2Erf3t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0qa8xiYt0kzN7ru03Evx31fdEqVuorcHSxhF1RSULo9gsSj0v7fL5JtIY/6adinCDKmRYMOCBGmxKVWDVLrRiwDURwS1VSXtHYvR+7BMhbP8U/FiWkd/YmKA5WDthWdJA7lYszt1/Ecd6hOJO0FFNg8yoPp+WB8o8M0myb4/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zkaXSBLI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so65986901fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715725046; x=1716329846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtFt7wDddzxzOujkRVGAoAf/dJUoMvePNiVnCCaevzU=;
        b=zkaXSBLIUnD8U7ObTsDadbZlAotEyI1mbBIwabuOwB/HOSa04hu8uH1+dkn2SW7vsJ
         IOb672YvuNKDrwvB9TEt+qHAL+vm9T93Xi0eGUhlTHOKpy3Q6vRWHjYU36vaQ3OTzICP
         AwVJwNBso1Q14Y65BXJetRXj4GtPHoX7vNZxeLxtWzTW3uhO62o9dSZFg7UrWtzI88xN
         SLP2YwQyPPLORbGNmwdM1Jf6W2ENOBwKevw5TJH7+51pzDiMsgrhj/S/qS99X2oc3kaK
         3v/Kor2WhfFSIlSeDjHbr1YFYs7uyh8iPizmSz7KFlZYs7zIYJ0ipSX+Rssvdx0LtzrL
         W44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715725046; x=1716329846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtFt7wDddzxzOujkRVGAoAf/dJUoMvePNiVnCCaevzU=;
        b=owOOupZ8GQTKWVlhTDIwqGPXgdsO/EWHKqrcgxNNvg/x9nzv5wTjZl8wzSwUhSAHRC
         XbGwUT18gLDODh4bplqQ6SiPTZKC9/5y/EIyUbcqq4Sac9/YJ4kp7gFmbTwNDiOLBdbm
         wxelcsOxV+ab3r0aFjdkmA1N5fZ2W/+rxXDZjSaV/s22uHSDhekVKjJ7JOAWS5koImZz
         4mYJg/FvFh0FCkAMkhGXoznfBpIqbDFkcePtrhBE4Uc6S8YVz83QUQfpCxufl99hwrEj
         k3CXKwA5dzOxJy4Syw7EV9vsIMxUwgTG+zM0l26IqZlve7+PZ4e3XCbfUqAThma5orSB
         +ehg==
X-Forwarded-Encrypted: i=1; AJvYcCXuI99coxYyjYJqd7qov4+SY213c1yBick19tEfo+/GT02SswxLMQ0jZdLsyL3bLfmG/dDo5Jmw/cdfbc28scXDYZSprejj7AVlvZ0z
X-Gm-Message-State: AOJu0Yx363ULhrWZGnvJ91W7pR4mNfbqkHOPNOaEvttMBsAl7HYwI/Vx
	DqlPDfYEQbs85yEfLIQDGmzMnytnSX7Xb8L5AR06y+nmcnzO5txEHOA0ehfnyMo=
X-Google-Smtp-Source: AGHT+IHufBornj75MaM0CaFqK+fsJscVVdOQ/IMTS+dnU8UXQa2+ajhmTfkTpNSwPpVz1LgRs/Djzg==
X-Received: by 2002:a2e:460a:0:b0:2e6:f710:6061 with SMTP id 38308e7fff4ca-2e6f710617fmr340141fa.17.1715725045977;
        Tue, 14 May 2024 15:17:25 -0700 (PDT)
Received: from [10.1.2.16] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff063d8cesm175234525e9.46.2024.05.14.15.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 15:17:25 -0700 (PDT)
Message-ID: <0ba6af4b-1d69-454b-85cf-a83b64431496@linaro.org>
Date: Wed, 15 May 2024 00:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Add obj flags to gpu devcoredump
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Connor Abbott <cwabbott0@gmail.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240513155150.166924-1-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240513155150.166924-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/13/24 17:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When debugging faults, it is useful to know how the BO is mapped (cached
> vs WC, gpu readonly, etc).
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

