Return-Path: <linux-kernel+bounces-393344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA51F9B9F79
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7079E2823AC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09125187355;
	Sat,  2 Nov 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUQPjz/x"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8ED175D29
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547765; cv=none; b=ruHtL45hZXyFXCXeYDX2q9YtJyBz0VoU2KXL/B4ucUu1BFh4tBDiN/EXLjjsSnIoALdtVqC00Ih2Ta/f/j1S1lb3VuiXOmL6PgQrDg5fLOibu/Ep8mIFpP53Dd9MnuI9TtXuCPXk4cmPn2gwcKg2MV56fO1zm8rhz5D8FSdMQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547765; c=relaxed/simple;
	bh=uwh0C2cyEDzgLbf6xiS8x78uyQsu1QgW0Uuwn6RrDrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+zHeHZ2+f2Aco9FAvnUfErBBTq4LYTCQd0XreUi4aZGVkVJQXFUQ+Xo51i1l/nqhZF9G7W5R+pOH9IGFSzlcBAiOMFd8uPNyBYxnDCkYDRzz0AypVsr0OX9XKegMM+OSx5bJpDYsAx5zeruX5V6+7XKdx9VEHx/AzjrEijLyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUQPjz/x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43193678216so23321785e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730547762; x=1731152562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTbzwY9IrWSX0n7ADNCULpJIMjPNU6Tl2Z09wShD6Ug=;
        b=eUQPjz/xHmxJqiAY7swKjvwDWCkyOSt6dthOKWf/VvCwlTM117tXlZGUqqWuVd78TD
         mvm8RMQ/GrbVixovdPFgaQiYFSMj+JjcWwfsydY9M9M0jz190dtQ+mk0u2Plc1qzc/n+
         BIopDRFFNbQGb8/w0sPXwyiUCKle9CAZYLi4p8ZfdHq7VE1rge5LBoQB48tNKOp0X2Dr
         NlJxYPIzcnGO1ksUs342gENMzEXniVR3rC5FeYk0btbAvKSYX7YPkpSmDuf+x63AWLou
         Cuu2zQ6tWo1SS5v8gh93K7uQWA8IoSslGJZUMWQAjmXsKpUzgntp5gNJQw0f81If/lQk
         XU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547762; x=1731152562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTbzwY9IrWSX0n7ADNCULpJIMjPNU6Tl2Z09wShD6Ug=;
        b=s80gqz3NN+/UOaBY7b2OVf0hCdKwW4M9efPMksnLmOn4cocA2gkun3Ey0/ibKvhwuM
         Yqib19LuA/95dtzaO0ESCeFDASLMNGnj7tdIrNGtA4UrjQiqMYTgzbaPqPj7LLFqRp4C
         9ej9hSi+/QimQaWhAAsiNEcrD9LpB9tMWgFEQ3qujcwyNvWiweSdrvNwytJS7EFddAKS
         icFvjZ58TQJPYkp9ihla5Wa8Saa0wdDirVvtmI0U3TrScrjp9D22F3z66wZiEUsPX/ah
         50jhN8psN41dteqFLP+bwgMuYldxLnZh0fUbI1rjQJM6Zw8Ij8JGVZpadKhnRCcogh6t
         Qa1g==
X-Forwarded-Encrypted: i=1; AJvYcCUigvPHKqJnGxvD0811rEyo5oHGFAcvuipF/x3q7bBOLtNN4jL64Syf6hjhydObkCGjVDbLcwkmwT2oTo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScpR9Up4HSW5bYeiL7PU4FoMEAH4/CgWWOWLfoKRqJEbODqmO
	VaNjDC3ziGt7uzsUAmNkBLUCZgOxCULAemAKT+wbL0MqIaRt2CWkNWVvsUHDBq4=
X-Google-Smtp-Source: AGHT+IGbiHgc1qY7IS7cNGp/UxNuY1r5J5mkWHiZZvRQts3BNsDLBxAUiErlh9Rewy9S2888koSy5w==
X-Received: by 2002:a05:600c:46d4:b0:431:5bae:c600 with SMTP id 5b1f17b1804b1-4319ad2f063mr242581585e9.34.1730547762079;
        Sat, 02 Nov 2024 04:42:42 -0700 (PDT)
Received: from [192.168.0.35] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852fdsm92023115e9.34.2024.11.02.04.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 04:42:41 -0700 (PDT)
Message-ID: <95e3b7c2-8db6-439e-831f-c5b770c56078@linaro.org>
Date: Sat, 2 Nov 2024 11:42:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] media: dt-bindings: media: camss: Add
 qcom,msm8953-camss binding
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241102-camss-msm8953-v2-0-837310e4541c@mainlining.org>
 <20241102-camss-msm8953-v2-2-837310e4541c@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241102-camss-msm8953-v2-2-837310e4541c@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/11/2024 01:32, Barnabás Czémán wrote:
> Add bindings for qcom,msm8953-camss in order to support the camera
> subsystem for MSM8953/SDM450/SDM632.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>   .../bindings/media/qcom,msm8953-camss.yaml         | 323 +++++++++++++++++++++
This looks better.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

