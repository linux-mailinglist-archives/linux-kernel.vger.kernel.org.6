Return-Path: <linux-kernel+bounces-433168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400BA9E54B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50E2282A28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F773214A67;
	Thu,  5 Dec 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSaokD6p"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6802144CA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399799; cv=none; b=WXdGVFaOmV3hwyNAbqKTeRZshxyhtpcbXTS9JpDYmchPaSzOpGSEgawJmaRbKhGx1o5IucddsvyumT3lBPlNHoqcMi5zaNmcCULt8mCuEhou+SK1hb290n6+Yr92uvCb3aplrIItN/pSww54j3QdO84PMr2cgHX/tpa1ACX45QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399799; c=relaxed/simple;
	bh=jsU/m7SEIIFDJmhyxSYaMTRswrSMMAnmayMJmhdd64M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0+uUhYQ8xzOWVblxiQjHCGBa1whHP0hSPTtgTlXxfsxpmKo6CJ61oJ1CeGS8GoZvqfqHlJSsM21AHvVZ7jkGAXsWt2/c2W0K+qbxSyK2cUpROHscDHk425hn0EbB1t4oSD4kEUhoQb9LIwU71I+oTwk6slqqYa7gZ+XFR9xg3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gSaokD6p; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa628d7046eso85434866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733399795; x=1734004595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cs9RMDRe4jTFPEvDmtH/eSMnjvvfZudpLPQ72QFuTUQ=;
        b=gSaokD6plYvYPl0qYwYlXhoCs6MaskOz3po8/8lSMP0x37ixBX8teAApM4ujyuNtLr
         bmglAfIJ6ScmL03PxbSECkeog94hJKn+1z15y4Ejopom2bSdC+POUBubxF4jCcVVECkk
         zxD9DroYCHiAonPqmc0xj6AzevTjy6TEoSDtrppBmB7fjpssgiJeBwhqmb5eWPVYeb98
         V8sq9m72/LWtIIJ6BDnEgqr7fpBipOFxG9inrGdG0Bt5skiTxGkJUtmsUsqZfDjC2A8o
         VVaQVqVXkMPfM6tHGdEyArKXm4xikoL727azGr7mfe3Ni8Y0Ih2sJpPbDlJnaaDaIjyr
         2lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399795; x=1734004595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs9RMDRe4jTFPEvDmtH/eSMnjvvfZudpLPQ72QFuTUQ=;
        b=B5eKCuXMiVb26+cC2aOI0ZwdZcCyjEG2LJ3YYSHBn3qQ1ewEvMPHmrIDGEU9XRkOzL
         U9XrmGDYCYKYsC/RncxMeaqTMU150Wtv2FSm9J00WCSpkeCPrDt2aWq8ctFw7l/9xs+q
         ONOMael0XfOsyIvThoLy5ZQILKAfg6ZXCkdwx5AZJMD0b+Gm7QAh/ghhfhCVoA4sY7p6
         48eQ45tMpEMFTqRN4nYk5ajiyVz+QvafBavuBxndH6+wZowUXoltMLMSnK2e5Cvpdeuj
         5SvdcL60xlFdW0tJoTo3s01Dfl8k72dSrthr47ImR/0sMaCisgCgHndsjLCPzh9TTVsL
         L3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWh5uCj2++dYiSG9EHK9sV/exJOYwx/HAwBenaYM1PkyvRpt9c8ZwI97ICVyDAZbsvLxep3zH3jcpdc/VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJduh0otVruviahDswU/l6aUDQymEDZQkLlkownj/4LYkhey4O
	H+pgQVMIZNXiIdr7K1o9/XRAaqZCXdqJ4NAlB5lrGlokmK40STT/QxpsA1M4aQA=
X-Gm-Gg: ASbGncvDpwYhb9lYSnQ41PaeayjINVcegni+Qm5N2Wk2cf3C9cHjdnhK5v8dUf7TBAu
	U74Blq0HIMggFg+EThutbmPNyg1WqDJ/HUlV3GQFS3S3LinC4+tGD7HApy+Mm0DPPuvW8jahaYD
	My5He9bHjFhKT73KyWqa3Ts3l2ju8nQuctMr+ZPr5UFclYpJTLTd+clniSaV/nZzen7wPIiD3y4
	VqM+rx/SzZsBC76RrRuEPQxAoj3k3b8ojc9t1UCzsxdq2CM7Gly+hRuvDl7/sc=
X-Google-Smtp-Source: AGHT+IEWGiuqCz5p22sJv4oUuBbuzMg9J4wgAEUTDCD4f1ma8OOcOH3epiuHrkUATGhdMfNL7flyUQ==
X-Received: by 2002:a17:906:23e1:b0:aa6:312c:5abe with SMTP id a640c23a62f3a-aa6312c5c99mr28100666b.58.1733399795552;
        Thu, 05 Dec 2024 03:56:35 -0800 (PST)
Received: from [192.168.0.62] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa626088e8fsm81659766b.139.2024.12.05.03.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 03:56:35 -0800 (PST)
Message-ID: <2cb5940b-3779-4450-a213-fa766df7f406@linaro.org>
Date: Thu, 5 Dec 2024 11:56:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] media: dt-bindings: Add qcom,sc7280-camss
To: Vikram Sharma <quic_vikramsa@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: rfoss@kernel.org, todor.too@gmail.com, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 akapatra@quicinc.com, hariramp@quicinc.com, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241204100003.300123-1-quic_vikramsa@quicinc.com>
 <20241204100003.300123-2-quic_vikramsa@quicinc.com>
 <oko5qqysmxhicqzkwhkz54wvsmt64ba3cd37zkcy55ee77owbk@5z3zetfr2ejx>
 <eaffa633-c3a4-4924-8ba7-694b18bf92ee@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <eaffa633-c3a4-4924-8ba7-694b18bf92ee@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 10:59, Vikram Sharma wrote:
> Hi Krzysztof,
> 
> Thanks for your "Reviewed-by"
> 
> +        camss@acb3000 {
> 
> If there is going to be resend, then node name: isp
> 
> Sure, we will change node-name from camss to isp or camera (As its a 
> part of generic names recommendation as per the shared link.)
> If there is a resend. or we will address this as a followup.
> 
> So
> 
> - camss@acb3000 {
> + camera@acb3000 {
> 
> Best Regards,
> Vikram

Please no top-posting.
https://subspace.kernel.org/etiquette.html

Shouldn't that be isp@0xaddress ?

If you are making this change, please remember to do it in both the 
example and the dts.

---
bod

