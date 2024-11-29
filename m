Return-Path: <linux-kernel+bounces-425540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236159DE656
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFC8281502
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9219D083;
	Fri, 29 Nov 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkuvstxS"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC219A298
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883119; cv=none; b=eq1BesYuu6d7LWeHlF0C77DjH+k2xVsdZVJdsAIOExx2ZL9mdHpSJkEan8nK/UTh2+YWYYmvFanC38PJD/MuIP4ACbP75eHbUI1CANLQ8gkJuhwTppnEjE2SsAXZY51FisEL72l8nb/yf/a1D1tqbpH6Bl/m6xTF6oNLdvUJozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883119; c=relaxed/simple;
	bh=o8HEnOjpe2SP2Y+jogFDyN/Mo0SW8oxuVkT4x3RnrWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZKdzfWRCDiixD7+n4YJJskfrnCcU03o6/eade7tN45W4a5tZXS3KqWYVAc/aS0zPC+ko/xuJm0JZbQdh9pJNext0IDUNmX0GiSXZZd5yh7hy7XgzkgvzHkaKQhxY/83izS9pSFi3B/QF90PvzWAbSxigasanpvoivQf7H1LUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkuvstxS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-382423e1f7aso1238909f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732883116; x=1733487916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9PyfoxYk6cSqtAE4cwiXMDHVr0/Xlhbbabc9YAFuxI=;
        b=bkuvstxSS+qwrR9GjvQoA/59h94558eTRpCzOI0W+FkHlyNB54386VcrVUJk1F8oG1
         rARs2uJkwC2WzdrLjWzo1wxiNHibBQC/GRWVarjHgaQaB5uRddAtBY4WMp0bPHAcLBO3
         Q8l2IKSakRt1m5PxbyU4SGTs/WNqlE7KcuCJnl5K0dbpU8IgRPR2ReCkj5/1rtAnQ/Rx
         w/s5LGD/4IDzamFLXC+hmnHhGIOp3dIOa91MYmXZrNRnQ5X8uGoc8acMyWzOoUVqVzRX
         8rUliTOYJBZhYZA+8IpCYK2+fn2/J6/52uF1L/oxPgmPPt9b/Fn0gYWFYnByB6Qn1Ss+
         KcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732883116; x=1733487916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9PyfoxYk6cSqtAE4cwiXMDHVr0/Xlhbbabc9YAFuxI=;
        b=xAM3fE8UfluICbYHFhcI8PzToF8HhdaUg4WfhZEXFjt8Hu6wYYCYBoNM/eOFUA0PL6
         ZwyI93RbPBrL9NM3Nt2Zf266YP1veqfs8VqrvR2AuhSg++JwHr27G6czoIoUztt1fTfh
         vD0HxWgWypXP3YnkHH2hUCHrFCVKDxoeCYYlseZhB+lSJo6S+m6NK2CAGtF4DrA0LnTu
         X0K1NNRo3UtRjW5fnItvKqjQ2FzoZ/0THmR98DKy0KNuCCgGUVAwW0jwS4Dg8Tbj7L2q
         lexQX65EKITuIFp6CubDdrwFkLRjpBE/+yjfuKxPT00R2EabK1gluahUJA8NDuvpMdp0
         8zxw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Nd7Lz7EXHZq7uiftXdoS94ZYwHGR0z05bmzeYfKicA89olIvHaaQUgKMFnWaWNQ3+XtdJ1Opg1xjdAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHukDb1lYcJOiViz41kttzSmH6cWBfG1qkTMITjKaTiHMm9lZd
	4aKZpig5kkTwOTkhQjTx3+nfyT0CIE5s8g9e2fp6VNd2xeIxsyADn1L7Eze5oV0=
X-Gm-Gg: ASbGncutoPagHJJhLIAx9nZtMXkZyJjkzyGSudoBmGbm7dddCGLATzY02kWN2pOwmCW
	LmTp0Rhar90Fcon/Nt82gCtDr12wtYCXJHctHXhkcLYmgCFUAUNRsM4WxHNRq9dgHRcLK3M3DUr
	e4R3BlecOTXpKiidmjYzpSZg8TlMVtXEaqWj4x2jBRgWmCdyYl/LSKm5G80ygqtQI4Tg0kE05ZG
	9XPPLWzRVvKbZD386NdL0P0Y071n6vyZK0LuyaMKCBvI8OWgxA16KdM1QObKiQ=
X-Google-Smtp-Source: AGHT+IGmoCspL3T/lhwTwBWMmmVpK4Wfl8T0tGwPv1bmoDJfk4x0AfSr2KSu0p2y3balC3pqTji+og==
X-Received: by 2002:a05:6000:4710:b0:385:e013:73f0 with SMTP id ffacd0b85a97d-385e0137516mr1722779f8f.59.1732883116492;
        Fri, 29 Nov 2024 04:25:16 -0800 (PST)
Received: from [192.168.0.31] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dc715a74sm2353625f8f.82.2024.11.29.04.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 04:25:16 -0800 (PST)
Message-ID: <8dfd2ee1-9baf-441f-8eb9-fa11e830334a@linaro.org>
Date: Fri, 29 Nov 2024 12:25:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: qcom: camss: fix VFE pm domain off
To: barnabas.czeman@mainlining.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
References: <20241128-vfe_pm_domain_off-v2-1-0bcbbe7daaaf@mainlining.org>
 <3a5fd596-b442-4d3f-aae2-f454d0cd8e5c@linaro.org>
 <5cccec71-0cc7-492a-9fb9-903970da05c5@linaro.org>
 <d3a8d38c-9129-4fbd-8bd6-c91131d950ad@linaro.org>
 <a08e95fc03fce6cb0809a06900982c6c@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <a08e95fc03fce6cb0809a06900982c6c@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 11:44, barnabas.czeman@mainlining.org wrote:
>> The change does not describe how to reproduce the problem, which commit
>> base is tested, which platform is testes, there is no enough information,
>> unfortunately.
> I can reproduce the problem with megapixels-sensorprofile on msm8953 and
> it can be reproduced with megapixels on msm8996.
> The base is the last commit on next.

Can you verify if vfe_domain_on has run and if so whether or not 
genpd_link is NULL when that function exists.

That's the question.

---
bod

