Return-Path: <linux-kernel+bounces-524827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316DBA3E793
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DCA19C0728
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543091E9B35;
	Thu, 20 Feb 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPHlDZmU"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D01EEA5E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090888; cv=none; b=rhrTuhjb69U5qr6nOA3X/d5Oj30G5Z0C8dYd4xQQJpJ/aCwV1tUtMQzTE4wHIBA3N4VITCm459BAWYRxi4VkTdy17gPhSwhrJMGd7EQiHsduUZBmGr2btuJXZmd43F6xok+sY9J8kvuuIL6uqTZvOFwwW29X/MZoghcNp0ULNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090888; c=relaxed/simple;
	bh=mR0mUeFeZCaF51isva3tjv2Z2QlQmyqjWpLJF1WjFwY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IhJHqkC92Pgrr/NY5JjSqJ1tEHiNFr/HqAZocxmo4yRjkBAK91rSjxbrixLwj1mf6Pz5oAXYGooA2dBbclwbl1Mv47qFGSptwQdWwW5ZgJ7Jx4sV1QNpwsx9TCbYseofFPjNMk7UJfrYfFXM9y6p0nCwvwmYpDhdxAwyCGFLkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kPHlDZmU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so805064f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740090885; x=1740695685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phlci97ebZekU4b5KeuZl5+WtfcQbkZeGNBOFT410xE=;
        b=kPHlDZmUuUs7QGBqV6KjCYFqfNpz2qJ77uoakCxwFgeFB5X81nLcy7/LmS+m9EB80U
         pbVjyztOZPp4wILnTpTMZMqnHRPSoMyV6+R8shCqu7+W2J1u/Q3TjS95J1no6IS+Rk6e
         9cdr10K7z+V/CW1O+YeSuogcXuYjEtgTaH7gbmWH11VS/IawaPck2aNfPol8LEbGhIiW
         Kcu77cwbADo60cOZ+mLDVLimaV6M3Yri41eeq3Rkn7AA+JIdi5lhDXECJExNtfHyXqPn
         DduxwBZyG23oiLr4FjclUgriyomgaGo8j3k9SOoTZTAEGe9SgDyEL0+6pJI3J7qnAXyd
         K7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090885; x=1740695685;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phlci97ebZekU4b5KeuZl5+WtfcQbkZeGNBOFT410xE=;
        b=wQO7khkhr9gH45jaoHkhivVV0nq7MUPtafXa6lx+pdTp0ZqGQ5rXKUS9/hpr70Y9QI
         svpCUioH7kfNrW/fa5oVrEgfiYAnDX26nPPNW0dENwoyOH5SlmDRKAYF+0bsKakFjLw1
         MnahZzks/9a4PFCOa24CUXJnKGvwth4ezvFiCPKAwigFgkSGEp/LFEBVrg+4eg8coXDA
         NtIdNOthzyJ2JdHpBSpedNL1PQIOfDxfoAtHkNhfT3Qc9iv7ErfBPEsKqSMjE6f9Ek4C
         TuWuY8qZ3RvUEz1+MqcgyFqDYlVv8ijv18D/H3azADSU8sHpi/7z4RcPs2zyibM06iJt
         3pFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp/ErBq+6qi/pBQOYdgiTDmlQcbWx1nONHNrNW53FSf/+M89ut1ai8RpR+m7XdePflYBMLTWCmMOa+ey0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrnUZhCIEC2dNN6e1rKUU84GT/dNUwAOaS9ieE36P0LN64PIn
	UN0zISfC2SiN1PICWpSGPn8W5CPg8NQi3EMRzRLXIVnDdkcTJmgHjJ4J2Uj0QN0=
X-Gm-Gg: ASbGncsf9Yv2UHXVeBIWD5rQtE8lI/GIMb/f6KbWZzkzjNMn+73K9W+FUwSvSujsJPb
	4nHABVO+LYk++Kzgyg0atTKFl6NwXJiXMCGA9O03Th3Duq4m1a2Hg5RYCoSDnnWfTionBeMY8kC
	EMKp7U0Z0pa+oGJI2bkgJtVP4ka0r/E99zIrw1Q5WAAbG1vWeHs21zgBJ/HZcOaaWHQRTJhIDeG
	YusVm7U/FZolQY5AQPOPXxltddmgQybnmFj1iOhdsuweG3Fkiz4Bdg9rn+huomWKU4i4CKNzwDD
	Anh9vppeYgH+5ZdD+7d5GJSevJLuDdQsBSTpDy80kvXUdHrGHWILPJJB
X-Google-Smtp-Source: AGHT+IEiEoJK5yBKqQlvbOAtC7qPbenK5M2XniNaSRU80N9OG0U+b3MWoNR0jG3TB6eA2sEmMFi/zg==
X-Received: by 2002:a5d:6d8c:0:b0:38f:4531:397a with SMTP id ffacd0b85a97d-38f6e757a02mr842468f8f.3.1740090885393;
        Thu, 20 Feb 2025 14:34:45 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm22129677f8f.64.2025.02.20.14.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 14:34:44 -0800 (PST)
Message-ID: <4c89d0a0-c0f3-494f-b85d-6c1d5041bba8@linaro.org>
Date: Thu, 20 Feb 2025 22:34:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
 <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
 <huluiiaqmunvmffoqadrhssd3kl2toutqtcw7rzamv3sqdglsf@7lz66x4sj3gv>
 <d4c4ecf0-9094-4341-8711-78a48e5d1344@linaro.org>
 <d444f1fb-42a0-48ef-83bc-d5aab9282b22@quicinc.com>
 <gzjyyl2kzv52zsewn5zf6ei65fymyi4pspvsmsjaqj5sklfxvc@bkg46saulni5>
 <fcc31cc7-67bd-4102-a53f-ebe66b4fd1a7@linaro.org>
 <3da96df2-1127-49bf-8114-282cc488c194@quicinc.com>
 <6b0684a0-a519-463f-b7be-176a4752a786@linaro.org>
Content-Language: en-US
In-Reply-To: <6b0684a0-a519-463f-b7be-176a4752a786@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2025 22:31, Bryan O'Donoghue wrote:
> It seems to me anyway we should try to push as much of this into core 
> logic to be reused as possible.

But there's no valid use-case for doing

ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);

in the driver and then conditionally doing it again in really_probe().

Its an either/or.

---
bod

