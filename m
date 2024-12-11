Return-Path: <linux-kernel+bounces-442186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEEF9ED926
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33DD1652B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF61EC4C4;
	Wed, 11 Dec 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVEY8Hdc"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338181DDC29
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954257; cv=none; b=XCKDZG/buvwVdsYlgz3vU9ngBJy/5mL0uX0LPTEIj8tJiRfKhEst4i4ny4D450hdI3lNQRJNYkCFNUAIDuFIXwoJhIesQuUxKFIzssgQunk/fcZYKFMPn3ZejYeCCiPvjnmFc6BZKC5ngKYmZisjMmlsoVAfoviQdISHSLhprC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954257; c=relaxed/simple;
	bh=NoocTxI69ryT8lgZX5nyYh4EyrV+I82c3ZNBMnlnPK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDFJwel6IwXQ69flgU7ANwZ3nbhVNq4GgBVHyQtJLZ1iMAVzcdtd7OkZOG473mCXXB8k6FIcKDP2Z9gT0UvQ1gU9evfofSK0N9oynQ0ylTBlMGJ1a8DaoGKF515ThyYESPsSjLBRNgwmTNlQq+x7DO06AQeE7p/MN2JYcQNHE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yVEY8Hdc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e87b25f0so730323f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733954253; x=1734559053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiMsT5ZPIfov52Mx3AVw33KMoPobt05c+bdtT6TpK0A=;
        b=yVEY8HdcZOYUsY8g7PVKHe0lDXk3YDPcwh9j/FVqXDQeuG5JXI9H44c7FvUgkzmnXy
         Vi0zZNrR5+QCTiI48idYjYWHFk/+VXfP20fYQ3I/jDnJJhLjJ0TBxIHl7fuSd+7EMkas
         EZ1r+tnMHEiWKvbWve0zH19pvHXHVMV8Wg7FOBgM/POhelOnRZ4GV0EjBjDgAConf+ql
         +Nsa+qUvY03LKOy+8ZSWMZp+hs8UMbG+PQrvQ4dkVc9R5XhCJ7l2SuQ1tjWugIzkf9rA
         Zh+nhhf5We/++/Qiy8af9tEdSuZBsAPq3YIxQiKKIkPxJ9J/l5dZb8RMiD/QxvDTkMFf
         XokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954253; x=1734559053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiMsT5ZPIfov52Mx3AVw33KMoPobt05c+bdtT6TpK0A=;
        b=APOQzhVDBz4/clmNvtnQBbxMUD/Wqe1MtAm6l46S1jWE+T9oMDcYV5mA7Az9e1k5PZ
         Jl9hmPMyjrUhvTrGPwvZZeE+mAHxcqpLfhGWNvUibCCHvmUr8u/vnuA9qA9PnIVDXHV1
         Yb1NqPAyCzNeqgJyw5KV58i9v3ulG+D5wCs5+I14IfMEPBWQ6ffjiBG5QJKNOT1BumhT
         kc29kJZ1qmZTpwSWfAMedQPXvQklPfrOYmIgV8MlGHQbjFLb058cBwOeHmJkImiyXqg3
         Jkv94ivz5GRxApanuzQ5f3jIK5dWmj1KyVNwh4Qzh6nXF/xAsy38VFx40dWw4k7YCgYw
         4xiw==
X-Forwarded-Encrypted: i=1; AJvYcCUAfNaTHaLFa2Wry9C3GT5gC9tQX1DYCl+CpckMCNne98RmUbUx+wck3rZD8T7v/kTPKu1jJvSTgTQoRtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPa8haoEByrvi4jFq8GO26t0ViYnQ3ptupbUUiccr53Ep40jTG
	0H4I/Rq8LsVx0QUe7zYHivculNHTmnFuWBnhiemP4FxXmfJhOWpR1WWUyU6+rIc=
X-Gm-Gg: ASbGncsBW4XQXZrywZIRFFRhQvnY4CF/RRKIcona8eBGxn58oFTeO+/wSBOIjZJoe17
	bhoAuVTUezbzbyf/hM/3PZ1KS4q/Pr4QZ4gUs/t+OM0x3IfrAarL0t3f6B1Mcprg5tg01DisGrg
	//evk52mTS76zmhYRcL8YgJ0SKKAHwoXqdn+eIHxBp+sYL8z+0XWHr3LBe1wxpkl5vULfuuIWdd
	CYUZ+IdA78gttsSPNvraXPV5VbBpaNLmO2lWoTZ9qiODOoIwj9s4L7fwiT7FapJTcI=
X-Google-Smtp-Source: AGHT+IFFp+r/vdKuglbxh8YThlHAVZQ6EWL6sTWl2g1jqrOQgWrFNPXYNjeb7DaZjcHoAt35YUmQpQ==
X-Received: by 2002:a05:6000:1543:b0:386:2e8c:e26d with SMTP id ffacd0b85a97d-3878840808emr704391f8f.0.1733954253597;
        Wed, 11 Dec 2024 13:57:33 -0800 (PST)
Received: from [192.168.0.27] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361d1cd906sm33498175e9.12.2024.12.11.13.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:57:33 -0800 (PST)
Message-ID: <138cc2e5-6b31-49d9-b70e-400a3f3c3bfa@linaro.org>
Date: Wed, 11 Dec 2024 21:57:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] media: qcom: camss: Add CSID 780 support
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-16-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211140738.3835588-16-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 14:07, Depeng Shao wrote:
> +static int csid_configure_testgen_pattern(struct csid_device *csid, s32 val)
> +{
> +	return 0;
> +}

Could we avoid this empty callback by checking csid->ctrl in csid.c ?

If so, please make that change.

If not, it's fine.

For either case.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

