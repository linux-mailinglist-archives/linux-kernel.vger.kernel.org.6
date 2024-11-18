Return-Path: <linux-kernel+bounces-413024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250D9D1271
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED587285495
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201ED1991C6;
	Mon, 18 Nov 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDHEkSQq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FC198A39
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937640; cv=none; b=F4/XuettNymPL2q8MWtgcqPAIpGoqQsl0FgS4ObwaOngJH99F2xwFFUMSGkgkI98I1aSahduDS47WGS04ccGRpGvZKqzbToZLoUA95g2wwSkI/VicM4PGNGwvX5M/Ipenfd48nX/5r4HgSu483fU1QLljMLNxj50sFuaYeR3GKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937640; c=relaxed/simple;
	bh=pJxl4rQZejyfJm+QNm/dBeQozxmiMKPzYEx1qY12VVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tt3Zdh5mIDp0TYAK6f4LiU4IkTAvYk/fQNOZdvYXtm3jVcTW8kpsvuFlajb8SNRd8IFygcWgHlkrpeMMlxesNa39XImy5VOIOxDYrBVNfeytOA7oUCzxfL/dXZ5iTCHH+KMWnY/SgYC9IG7z7BbG26oyo4S1T1vvaSHNvUzynSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDHEkSQq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso36929915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731937636; x=1732542436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s8NgQOCCqPqf7FHd7BM4LXvTtZURwEU3Cj8EytucMjA=;
        b=fDHEkSQqen5NcYUF5LL0TKURcC/drB2TuJlKJg5wMhCqe/ETcTc4NSA+NC96J3h9xJ
         A5y16q1MAnXTnGRGaDeDB+BdEWBrpvtZkrR/Il9WbJGOQXa/BrWL3obbRAraFlP1vrJ9
         N03K5G2Cy+BgdVevNEfQY8oXGSj7w1/+0cFBvNuz5yVANwSIgr5Si1v872nD8pCojKFT
         nPpFVzykUOmtIizIQUMee3+ODvQA36ADxpBtwU2/u9bSwkI8dMZXj+r499zIJccpjisN
         MeriaipxNx+4ey20pXv6roAt+H7fogpb0pTEtOrXWY9Ay9zh7aCRkEE4jd169+zgFxNI
         mO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731937636; x=1732542436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8NgQOCCqPqf7FHd7BM4LXvTtZURwEU3Cj8EytucMjA=;
        b=Cpbn4kCvWdPklzakBSonkoHNedIuwtf/awm3EeSZ93zuo9HbuDkrfZui+OQgYoMo/1
         i4WHXCdxfE8KV980RRZHTH3Qr9QfMmvxs4Q2tNcUFxj8Vb53DkpkPvjmG14Jtiq3BMNu
         f7Gt49YUHQNqu9+D3N9w5pWWc+HuW+cY2rv2lSA1P8cWaOj+Y6ydFXGz2pCON6Y2NZUd
         iHsSMNcfjHQxNYoccgZuQ25Hpw630Q6OGz+tOhJNrQBtujPa6NxKbFkYEV6q1N/1RnDm
         o7N+oXjPAtT0i1s0dvJNrd/REV8fKsBKlCzFIbVhP9E+mKzFwIZOA3mnIsM+hnoEukA0
         SP7A==
X-Forwarded-Encrypted: i=1; AJvYcCVaCDBaRLQ+snfeXLf3aVzUQBiqWWckx7TkNce+SZH7TqCtZD/0wg1Ln7MkLHJ8NOTyJvZSgDqGyST0wXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcsrguzOLeGDYWudEmkQqkg+GSkTWr9aIMf7SzHyd9rBugweQ
	kkvPpR/abNY3UCoaCIiqwn9nLZHb13FbGkDUfpxDHGfl86VUpqzAO/OMVx4HQ4M=
X-Google-Smtp-Source: AGHT+IGkNPMfEbTsWdumFk18TzboywRqef3yKH0bCK2BXh5ptB4CLaWCTXz64qGRHLnn74CknlpZng==
X-Received: by 2002:a05:600c:1387:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-432df78a971mr103770975e9.25.1731937636216;
        Mon, 18 Nov 2024 05:47:16 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80ad9sm154398355e9.25.2024.11.18.05.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 05:47:15 -0800 (PST)
Message-ID: <d80e23bf-3e13-43af-9bc8-fa6bd4a86248@linaro.org>
Date: Mon, 18 Nov 2024 13:47:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: gdsc: Add pm_runtime hooks
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-2-b7a2bd82ba37@linaro.org>
 <atg6yw64f4aojcbjyarljb57cejqk56g2qnddrloa3smmupm6d@fk3oyiycnuco>
 <45c0950a-0cde-4bb9-9e3d-7f25b8a3da31@linaro.org>
 <5lg7rsndxrcogrwywlciek4fdfejnpmvuibpwhh33whg2ebtlt@jli5g3qliota>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <5lg7rsndxrcogrwywlciek4fdfejnpmvuibpwhh33whg2ebtlt@jli5g3qliota>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2024 13:39, Dmitry Baryshkov wrote:
>> It brings up every PM domain in the list
>>
>> clock_cc {
>>      power-domains = <somedomain0>, <another-domain>;
>> };
>>
>> No different to what the core code does for a single domain - except we can
>> actually turn the PDs off with the pm_runtime_put().
> I see. I missed the device link part of the dev_pm_domain_attach_list().
> 
> Just to check, have you checked that this provides no splats in
> lockdep-enabled kernels?

No, I haven't.

I'll have a look at that now. I did test on sc8280xp though.

I'll get back to you on lockdep.

---
bod

