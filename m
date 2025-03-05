Return-Path: <linux-kernel+bounces-546408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1CBA4FA4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4626B3A6F48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553A2054F5;
	Wed,  5 Mar 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjLVv2zL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406311FC7CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167460; cv=none; b=MJtNv4ym8RAyw8LFQZCnzYt5Owc4iaP9bawAC+60iUdY9owNWgjtKL8ePMVSmGppfyMMfeN/RMKoWCEw3j8ZmV3EYZCA+CbWiiqvflYkGB/qfUntNTYTRE7DgTOpdlSVTYBDKGilgzwYwVA+Tp071JRXp7UpaKv5I2Lf84/zY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167460; c=relaxed/simple;
	bh=f/YM8elcYOSd+yUfoQceb/I+xg93FNhGvdv8uLMVd/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rneLtUKRY9NoEw6xlTGky1fDIqYNyylNYRJk6ew/6mcudfxeCf53yUXmhkVAlSV2YNnltzXvEEp4aWoofUhzY3WYCUO4+YfS2Z0pKqy0NogBRaaVXTbKjcc/lG9Wz5OWshQFdAxDBkYthyGGn3q8aasgfArG9Jn1/mbtiv1M9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjLVv2zL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bc638686eso3617225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741167457; x=1741772257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlMAIxbaLxEVqrgBKFsUbTgWZrSdfR0A9Q1RePUhWM4=;
        b=jjLVv2zLD8XMQF7Ym5DgkTtVaFISxzWVRxbZA/kVlKdKwIJ/tQndEMXhbIfdWb1OzH
         mzjkb2RAsZKlZd4sv3QwcmKFOhR9EfgA3f8o+NPzUT8N7P7U8wvTTSawtwJ9l9EXXi4T
         aoXDpqJJl5R7RTh8lilcKUZ//C75+g8AvjlTdgzpNPoWLrNcLOmISmlpK2Q9+i9KoFMy
         gusNaIqZqFZqn/AhCPIlKuQ7ZQaUuvedMA3dgPABfiT2VzKfRDVpsllsnyC2JOCDoGYK
         FtVmNJMRx4alWDmb0TVAxiYVDpRRI4Nmsmk41LZhxQyVVm1fuNOCBtWhKjbDo66eb2nK
         l5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167457; x=1741772257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlMAIxbaLxEVqrgBKFsUbTgWZrSdfR0A9Q1RePUhWM4=;
        b=XAnoisHzbaP0NALYQu7OkXBrQ7TN0Mr40RFfAC8pRbT3eow8Q+IuD87rda8VcgdXPH
         ULiGzSkV9gvek5nQm/wxklwJ6Lh+kYu/HkeYvq4YudPrxwtV6bky2YuqsW9wzfsECZvl
         9I5p0UJzJ9Nn2CeO/Z9rT5RftXNHFprPfMy4H7zLZmgnWmSUuGJlU72e62Y7/ShXSTe3
         LLj1No43hx3qf+4+reFxHaTJ4ED3DxABfKMOUtCeQRd2rgREBNnKF4RNvfNF5OkqPaSl
         og82ksFhYSy4g80nwKxKiGAjCAFpnSt8rXHuGTiXZsMmQZ8QTPREHP7/vy6pOf6i3bpB
         jKGw==
X-Forwarded-Encrypted: i=1; AJvYcCWf50F6y7OyEFTW5DCoqrKedTV8O5xEiR2AW8Q4X5/qzwwjFn7KxWLwyApL7aTbJsL+Hyj8rKhAT6sypGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Spk/2lhsDR79BbQPCGmfaSvz1RpadUxSGeTXZ1ioagN3FNcW
	LzwhDDBY8vr6qH4DqNt7/kagrmnLi+rV6e5lt43uUZdGiK9ocbheA4SHy8w46d4T0rrtCDuY3sq
	q
X-Gm-Gg: ASbGncsT4or6hc1KlvYFgsT/NJIXw5LCi5bX3+ypBZEfvzROQ02kiBolhR0eAm0Ai9N
	ZN5uitjSQT1eCjenqT0xuj2Ek+aBvaFFbYyNHngteLoPtPCiDtsGYWPiKFvLyCHdkah2U8emtoJ
	BAkNj/ziIPp/4lt/MgesOqxvI+N3Jx3tgmBnYdxunitxorlOC5sPTm79PCPY8heNSuUHzpnOBlm
	IKkxtT4y58XHWhaIEXzKo+5s25sVywDjw1CH+VPTFHaozzzwhcgvFBXP7XhC/4m0TRAGjNrEJC6
	7B3z8X4LqQlEEqOJy0BD6GekKntV4BREuX0T0yCdQFtIdmYwPSqfp48HuwprSJ769n6APNBOzic
	kdtfLtLVeHA==
X-Google-Smtp-Source: AGHT+IFmN6TeDKmjpgD7xPBfMAW6BMdRHuVJd+Orgg/yUW6nDI0BKPDiyYdeZaHiB3YJo+Czk4nwww==
X-Received: by 2002:a5d:5848:0:b0:390:ef45:1a36 with SMTP id ffacd0b85a97d-3911ea413a4mr1912238f8f.19.1741167457477;
        Wed, 05 Mar 2025 01:37:37 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479609asm20159886f8f.2.2025.03.05.01.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 01:37:37 -0800 (PST)
Message-ID: <38257fe8-e592-46c7-893e-e61ef229a607@linaro.org>
Date: Wed, 5 Mar 2025 09:37:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Reup: SM8350 and SC8280XP venus support
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
 <8cfaeb25-2657-9df4-5cea-018aad62f579@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <8cfaeb25-2657-9df4-5cea-018aad62f579@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 03:19, Vikash Garodia wrote:
>> This series is a re-up of Konrad's original venus series for sc8280xp and
>> sm8350.Why this is enabled on venus driver ? Why not iris driver ? This needs an
> explanation on was this even tried to bring up on iris driver.
> 
> How different is this from sm8250 which is already enabled on iris driver ?

Ah let me parse the previous feedback, I don't have the full context of 
this series in my head yet.

thx

---
bod

