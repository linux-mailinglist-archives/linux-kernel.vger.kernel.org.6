Return-Path: <linux-kernel+bounces-419169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDB99D6A3F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983211617F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F813D53D;
	Sat, 23 Nov 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xT20aQ0y"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBF17C2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379944; cv=none; b=qV4KMUxo3jaxxfYkLYEIV+nqpi0qNzGY/cHM05Gucty7EimRZ9FWr2YhJXM8NLG8xLeZ6+fEZbXUEgBgee+2iQdWlg/msqepx/JOc+8eCM8uSlONo4LR582sv7/d2RGsyGzH2eWDkcIrhm+8ImQP+G1I8UAqSQAkSrS8awQTyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379944; c=relaxed/simple;
	bh=rNNmsD7N4E0pk3BrL241iEAIRnrtc3G4gj5E/0zYltU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoKh2H7ajmI6Y/XZS6Iugj78+rNWlvZCaCBSiCSjhk4MY/gevlm2xABKZ5bt0/1pDahvnwZMvVazOy9p1Vd2F0nZdLh37e3MCiCCO4TJhOW0C4WOhrSOjYrPbyQ9zhddrXma0lPUXru6gykoiqOu/30bIfBi3JkcwiNND/lDdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xT20aQ0y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d796a57eso3012615e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732379941; x=1732984741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lwSLyeUAJ7Lv03nB80oBxIAegSFu8SZ85FzNdjJUlec=;
        b=xT20aQ0yNK3Lie4G2SEFtcUI4AhglB+K1yNO/24qdVNnXvpb2928rJZUoeW4Jrc7Rh
         4eXAjFXwIOQX6aMJQc80F+Ri0VmL0mbLoA5WFKpBRjozW1u8W4UUMsVtSUOG/92nCemT
         b8kZ02nqaEMIbcAIHq4Tj+I5EMqW14cq27aabPzpeQwm3SVnHdZYq+vivFOo2F/9STo1
         D958oQsRAIZ4rErd6HIbDubIQ51Y1VvWZ2naZdr3IaCsvLZYlmH4PEOwFOJRqm8Il0E+
         QVmK5Wz4KIdPkcNtaWJuq4Qg7DOxsI4QbuAjAcPn8IiFyBlkvHOez6UkZ4T5EOFk5/HR
         GHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732379941; x=1732984741;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwSLyeUAJ7Lv03nB80oBxIAegSFu8SZ85FzNdjJUlec=;
        b=C8/EY0CB5HVKM1IiP1vsEK/fEu12chgVv9QhHvOe3gayfqVb5G2ae1E5tgQ6Ua6QH6
         mKDgL4nNdAZSyLYf/yzLOCJvLuX1TM5im6XdvTSaWRSy3um4Vb5oGt17QpP+13aizet+
         K1uHZ8AXK8lMxAKCXqonbg4alg2ntsuaXUTLvDBBQ5abq6cxMuYcETQKIw6bjZOda1aH
         37WQo/gfN5H6JOQ+XF23Wsq3eVXY5HymtV1Rz1J3JVegk4d0LdVU0EatgiEgID9cuhkm
         Jnzk7fX00FYHmXZikRYWQYDHbXFqmYweSC/f8lyg6Amc4tyO9eH51/csZfBaMiVxQTgi
         hrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ibQIu1IQm0Fvq+H4n5laM+Tjfk+zT0q0MPb092qJUzsp2v4XHDsCv3Dpfqo22CUFnTxtxlCiAc5PR6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RvAxDFzWz6EKcdIhpgtCDQVHICXwCa/adpGFIkQw78nG3MeT
	adPz3CtGswHorji9lWzaH9RcNVj2AyxGvlZNNet4OWFe5Vp4ypRBYYCM8sDhzOY=
X-Gm-Gg: ASbGnct9zS+eKT1pJD3H6DDC6HXXPFzuGQcXw7bBRpmlGUZdcSsG1lekaw2TTz48QIK
	16fRPPWguNzvYx8q8fiY/LhzzVseLK9n59rVcpH1sMPH74Lb5ty6cRqiI6kkuH7MCQiS5X5nKfV
	x9Q3hlHSAptEMAJkgs5a0U8w91GaLyQAXdlrl9l5Rtj4ui13RTnVk+hLOaiZArdqwhN7jC04xOK
	rYgJEVVbGKUVve5NY08p6ic57HSQ3mWoe3cxvKxc2AA2vVu3PoEY8aMwKh0h05QnYQWFw==
X-Google-Smtp-Source: AGHT+IFw4ocfNZ7TKRf/M8A709O9rR+DfW8weDpRGUvmZUsUMk0Cbe37DsCHCsF96KUmy6y5McM8gg==
X-Received: by 2002:a05:600c:3b93:b0:431:4983:e8fe with SMTP id 5b1f17b1804b1-433ce4f52a2mr25269335e9.9.1732379941304;
        Sat, 23 Nov 2024 08:39:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bd7d7sm131732985e9.13.2024.11.23.08.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 08:39:00 -0800 (PST)
Message-ID: <4d16b207-7bbd-443a-ae20-3148bd70a747@linaro.org>
Date: Sat, 23 Nov 2024 17:38:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: dts: qcom: sm8750: CDSP and modem
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2024 16:26, Krzysztof Kozlowski wrote:
> Hi,
> 
> Context of this depends on my audio patches:
> https://lore.kernel.org/all/20241101-sm8750-audio-v1-0-730aec176459@linaro.org/

I forgot to link the bindings:
https://lore.kernel.org/all/20241122085623.19988-1-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof

