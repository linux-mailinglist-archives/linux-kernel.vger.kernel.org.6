Return-Path: <linux-kernel+bounces-259471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D59396B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40217282125
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5DA47F6C;
	Mon, 22 Jul 2024 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvGtwhGq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1B3D969
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688458; cv=none; b=OkF1Mk/7ZFA31AvP44BeFF3oHxtOCvy2idXfHenwf9MjhPtH2mAZC3GMJXg/b/RhXo7d9UasFV9qZRfPCTr83DqZQbXhc5nhtWqDeebONq9M80SHLWSn7iH9uNOY4qcLCZ7HqzcIGPrU/t4/qFsBEf3BHREyir7y1MyWxisYsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688458; c=relaxed/simple;
	bh=jhr/hSesu9bMjbHGgsjFIvcF0F2IZQ/Hy8j6pHQdmVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJqT86tabtLgfX3yn2o8wM4rnSBGL0oYgKLKxrcaBdnAwINQ/f8nKWddj1M4I20D2Tn1pYVziiwtHxBx82IzYbO6pXeBovOUaPMvzPaNcifr44UoAK3x4FTLzYetQEDwuRc4A+V/iN3zPbtydkaO2Ln7qTLT7/eS5OUNCEWxEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvGtwhGq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so36771366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721688454; x=1722293254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TmTbrAU3gNOB0OQ9NMFI2VwuOLJi0QeqBNahkuW7iV8=;
        b=rvGtwhGqImsQxaXifnybXw8DFGeYicrNu7V5sSXTsW7nZsW9K7xSo0Df8swF4fQ5zT
         JgZu6QQckIPMjRaVHzzxbzsuZMhLDiUN2ACs8zPZKIkXTNh2lZSyrzAgFmroKyA3ttD/
         8AlI/su4WL6S3ELusM34QHMVR7MLoct9T+5kcpXFFP4XRwtc9erSMvWE2gZG+VQC/Mb7
         g7plkmluz3a0/UHe8mfSQ2m5AbLnsEnwWyxU3uUHwxZNuQiPeR4WVy1IHd9sQTdT7leu
         q5f6WNRI5Bz01rPv3vDfR73Ilbq+IvD+q5Q1Ams/MYgz2Czo2M/wYwEv2IPSXB1wCGOI
         3L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721688454; x=1722293254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmTbrAU3gNOB0OQ9NMFI2VwuOLJi0QeqBNahkuW7iV8=;
        b=UTg61Q6QgK3S6FSfJk0NyPajPB/+M2jxCWbvufzF8pK1Y69zCnFxeitdK4Q795ncqs
         HSL82bt8anNi4YoiOoglHN7/bOWL6ix9FsKjWNec5Wj64RM/8sulrn9u7MYzFhjryT3T
         8pPXdz0Ys0geE4lGH1EBtWP9QeIEV9akSZyPFk1DZJuH8OTPaRw7KkFmiLpwfDE5aY9e
         OYqtPfh/DB2WUL8ojpCCGO4qmi+G7LuwURi6cljTLQ125/x4Vql32p5tXFawcNfSB20t
         LjuZQK1hEVujtALVa1XX4etuZqqDLDMlGHAVYQkFaiggjC1fMzQlDzWM+WP4iur4r3Is
         nkIw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GtsxALN3geRYQx2JtCRixhKKg4WLQKqb6TQucX6xT5e9EPoLkVKoRVtXOtH7HP1zn7qeTrvDDe5NikjzvjXkNnGfcxHUOJMYl82B
X-Gm-Message-State: AOJu0YwfqXA3WI/K6R9Q1/1RK80zu1zPuPslopfOB4sdqs23COVWlpSS
	TqjYXs2Y/roe1UbGnt21B7aBqprvIm1VB/cu+zINa5d8tLqxpCP2f0l0YrjnVBo=
X-Google-Smtp-Source: AGHT+IFhPPLRczoDUjkta5ysAtpVFDhqe/nxpH7+ApPt+OVQDRFNXfG7wiFo4ZepIHVD+DFBt6L5hA==
X-Received: by 2002:a17:907:d9f:b0:a77:db04:8ceb with SMTP id a640c23a62f3a-a7a9428130cmr28630066b.19.1721688453667;
        Mon, 22 Jul 2024 15:47:33 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7b656esm467520066b.48.2024.07.22.15.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:47:33 -0700 (PDT)
Message-ID: <dedb6659-5084-49ff-83f8-aad39269d423@linaro.org>
Date: Tue, 23 Jul 2024 00:47:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: qcom: pma8084: add pon node
To: Rayyan Ansari <rayyan.ansari@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
 <20240722-pmic-bindings-v1-3-555942b3c4e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-pmic-bindings-v1-3-555942b3c4e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 1:47 PM, Rayyan Ansari wrote:
> Wrap existing pwrkey node inside a pon node, to conform to dt schema.
> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

might also wanna polish it up so that KEY_POWER is assigned

Konrad

