Return-Path: <linux-kernel+bounces-531994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1A3A447A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4681C3A9F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7818FDB9;
	Tue, 25 Feb 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9nh4yut"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524218EFDE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503280; cv=none; b=mdmQuqr8fknxCBtvypyWfBtAI5Rsu7t8HqC97tIG7LGvMBzAcK0drjQ/2iYZ6Ozpkknrm/yHaF/P4P2yHZhaMHMLdyHTArheKLPhU9b4bAYoBexs99eCyftYEQyCDh5MkYyUDtXRyxs5RTj4MMxPiFf6lIBx4IM9koOO1qpiRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503280; c=relaxed/simple;
	bh=JrDjoWv38lWuagASc6cN/GUIdTu7q0opFYTGtJoO3rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQfQXOYQ63LHEaJ+Kad8DewUf31EK5TM6mHdz+MbZuUg3CtFgaNm6cOdhNFocervzzTK2wY67yZn7z7ZofS/ep9xJg2Ux1/wUUlyzlN1uv6e3IPVtdyoORfadotN+efPaUOoHIHUz6CAPsdmbrRAPEQAxBuIBXf0ikOEfSBBN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9nh4yut; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7c4350826so98253766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503277; x=1741108077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O2Yww8i5PD9sxDad7Sc6TNXIrj7gMeSMfS/yw5deiF8=;
        b=C9nh4yutbO7qTnjLqIDfbIsstatShZ3PmtqmGDBEtuYohpflbTJDa1+lDlcicz9hCy
         2/rPB9i/3AiD+5Omazk6gqCHKQeWb0AvtuG9iaYhBFJFHHDdVgZ9I4BeVqhxswviCSnF
         ZFXLkA89/PNpEPR0hhuGRog82G/bKZ2VuI9bFgMW6aSD0YPWC30IlxiT759FEKxHPA7c
         RaaMheUf7cK3zRNqyFcNllxGGypgJR9msUgaWTdregKK2/tnVxkylDTQ+bLKvHxuPENr
         7YufIWWi/IU+nZFAGHr64CUOvW2nMfUOY4y/HBvdjo6NYMN3qQTXu92QJKqB08TBd8Wn
         OZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503277; x=1741108077;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2Yww8i5PD9sxDad7Sc6TNXIrj7gMeSMfS/yw5deiF8=;
        b=mh3svGmWummkts0TUTLy/GFnZ0GBJsDx1MVSC43PKWyg0+5QOkv3Cs74RqChtXExC+
         iyRCldR1jGh4nht/MD4D9sVLUH2kqGhPP7nTRqCQ0otCjHzMZYlNUQm5vZalffoNVjm6
         BHVOaVuq9dXJOaCrQLGy6VmZnjhllP6RsaHHrSIcdRQoujDCcToko/PEfxIp21U1Lak6
         6Vx+AvxrV+YpZDcoXVtmV4aYJ7CJKFjuL5V9A/9LfSvxeXDBcbIRnmfSL7ojsxT3EwSM
         0i+imEBZM2B6o2shOygBSc9uViYZcb4w2PO6HL14E+R4Drwba52newm6vdF8y8Y3ome4
         46Ew==
X-Forwarded-Encrypted: i=1; AJvYcCX3Km+9NMmLAxy3iyMZrnwlZBR7ShTTfHUdfDlwIWtHvrUkhHpH5cHAbmhaGVX2wrkUKzOle9BoI9kZ9+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywbp67qjzKuwZAgTXl50QX0M/5UZkVvz+qoXiMQnJLb7WeacqU
	c17UZ3BBNvh6mGx7R9nAu3oQwrZDd1F0QpGnFFWqswr0cH+SFSiapNOzXCji8eQ=
X-Gm-Gg: ASbGncunJtyXOPMJLNQudaJ/+1+OL3a5AAj7gXVynprSQucVMWXs4YGO1JNo2Rc8p9b
	IhduDr/gtti8xeYjhKNZk9QLcpt17/nwsHzB/A2QRdWcN//6TWAUy11wOnP10rsCnw5HYcbE7iH
	DMI+VnTq5SRea2phyv8uS/Ij6HQDaoIkCKMw6shXwWv12r4mUzEnr/cYyt9mbozyAmlFM9izQPT
	/3/1ggYOKzDJq36cfR7i89J5lrKRpJA5dVb/c6chkeJkaWpIgxjyjt9kPuMxXRzEFJEoqeydLGJ
	ZqRFSC71CSteq2GMJQvOGsw1LkEPXT+tgLB2tvZdTR0Cb4u/2gxXRn3t0EuARpTGUY9ORG8AZK2
	kjOAJ
X-Google-Smtp-Source: AGHT+IFolR1/SB/hCyUdTCpb3AKwskzaM+cnfMctfFebsUFypTxfpk+6oEj+nPeNvivB7JnjlaXP4w==
X-Received: by 2002:a17:907:7284:b0:ab7:63fa:e48a with SMTP id a640c23a62f3a-abc099d4d36mr792150066b.2.1740503277338;
        Tue, 25 Feb 2025 09:07:57 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d55dcfsm171387966b.44.2025.02.25.09.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 09:07:56 -0800 (PST)
Message-ID: <c55f615e-6831-4470-9ea2-73fe605b8a5f@linaro.org>
Date: Tue, 25 Feb 2025 18:07:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-slim7x: Drop incorrect
 qcom,ath12k-calibration-variant
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ath12k@lists.infradead.org
References: <20250225093051.58406-1-krzysztof.kozlowski@linaro.org>
 <sfhcmlz3x254fdowufeeuh4uiwxfgkphm4ch4laceivbrs3zir@qvqk6jxi6zhf>
 <7b54e965-3395-4349-8ae7-51a28c759235@linaro.org>
 <kce6gzso22fp3ze2wp43fvy4tv6yqkaijm72kh5qk34jwijk2l@3ifaiz5tgjvl>
 <d93789c6-61d9-4761-98f5-aa3dbec14d82@linaro.org>
 <21ad3381-4d65-4c68-892d-9f485bf13735@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <21ad3381-4d65-4c68-892d-9f485bf13735@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 17:44, Jeff Johnson wrote:
>>>>
>>>> But nothing parses such string as 'qcom,ath12k-calibration-variant' (see
>>>> git grep), so how would driver use it?
>>>
>>> That's what I'm asking: is the property redundant or is it correct and
>>> it is a driver that needs to be fixed?
>>
>> I assume driver will need something like that property, but that's not a
>> reason to accept incorrect one in DTS. One cannot add properties to DTS
>> without bindings, so bypassing bindings review, and then claim "but my
>> driver needs them". Send proper patches for driver first which will get
>> a review.
> 
> We definitely need a calibration variant entry.
> I've pinged the development team to get the driver patch.


The patches were on the lists but were not accepted. Therefore DTS
property cannot get into the kernel. I am sorry, but this is not somehow
fluid or flexible that internal team can squeeze something into the kernel.

Also post factum reasoning is not correct, because this would open the
gate to bypass any sort of review. Just squeeze your stuff into the DTS
and then you can bypass all DT maintainers :/

All properties must be documented and bindings must be accepted *before*
DTS patch is applied.

Best regards,
Krzysztof

