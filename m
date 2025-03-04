Return-Path: <linux-kernel+bounces-544411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A49A4E103
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC66E3AA07E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65C20ADF9;
	Tue,  4 Mar 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AI1pm/+3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD8207A25
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098332; cv=none; b=X8SxfQT/9/tj/Yrq9R3L+r3xj5UVP18LoJMyo0KcsSNQrI5lqQfK9OHq33EzVLkUwtnZ14hDtvURn5KpW+kmNaLgLsuB0nxiZs9h2cls4pNLAjpTwVXH3sgqUtz3INodFqbyIhG7CYhHHn6LQW8wxRaxWjpeJN6y1gyZH1D7SJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098332; c=relaxed/simple;
	bh=ujz9v1TX3Nc4XTXIke+2tQHY+Eu+Ye3qdsfhSar0qgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uQK56MhKQYENiiVjLuzGBxUID0Q5f43jHBKnK5NgoM1HGWc+e6D7QKGuJ3SxwCiKdANGV/PBp3eoyvDmOXuZsUe5hriR9CZlK8e8zOloLM7sA0Z/0KFkcj8NGavF7pZjG2JVyxXznVcquiejJQHMb7UauDuJATZ1Vm4+JYAK5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AI1pm/+3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ba8bbeae2so5231635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741098328; x=1741703128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bLOuvI3LiklO1AEtCigx8K9DH5XZ+IuqwfMAm3GpGE=;
        b=AI1pm/+3luOaFaemLg4qnvg4FWNlZhSgktqf97M+9H/se8vnmxzu0UH9qAnfzHm2u0
         58V4edJ+0ZZ1VwOOiQ9VVP3DdQZa7msvJiHlUofllNBlSqwcUpJhYx+C0SjtIdqZjM2/
         UMjxHxWhB1m6QATP7q2mjWwbqI36XjvSS9pWElGyCY9RlYba55pXusNZSkULqheMbU0t
         g0/FbH8tQZdvEWEWB823GE1/gk1bLljRpDVvH11XoYMa+a7GJgc8Yto/FsIcAeF4MpeW
         ImEYILtOybL2Hk6eWEGspUiwqpTCOsThYwDtACge/RRlKm1/gmTZNinKQoA1eNp1RRYa
         VBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098328; x=1741703128;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bLOuvI3LiklO1AEtCigx8K9DH5XZ+IuqwfMAm3GpGE=;
        b=TYfHI1ME30mGxN5JDPAsuWuIea8qbasnHheyiofVGJrOHGa0JGDlW+ZSf7UQzn/Ows
         wlDKrT1pI2mDgFhCNfxXgOQr21cm/rkXxd4D4WZDUZ008Gx/vskGmkTdMkKJQiaQTkOC
         iMoSiSMxJn3utmYLz9AEq/X5zlDCOKTN2GgtE8cJIFncz3IbH10uBQGEKDfky7YS9LHr
         qSB1TSnwJc+AMDj8uyLxW0Ybcu8/9u02/YsrNSeWqhj8V8pOk7y5maqP2s20FEDNiSuh
         igClYrJn9YgZKsqjF+ZcOUPrlyNYnsgnFMfQcz13h6Kd03HFGqpVxV/aKmO2PuuPI7PF
         JDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDgR+lpdDzsjUCluGPczK0Q6AtDxfUicqVvADreBvOyg6uj6O6ZxuLrCrxbxP1eIW59Bo4gcKfo7A49N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx41a+ffcQ7IK1CXaSfShvFeO6zi4XfZ23s1MamQmj7aJ9DIMtc
	KEfvjpfKDTKqlTr/HSjZrsuyyFW+97cr3sucXs4l5Do2Pb5pcQxSs5o3s/rafTQ=
X-Gm-Gg: ASbGncvbDu/8dyQZeoP8rT4yjX1x3RA6gVgO7mRZVQkEvbuTwsj/V7K/SZloS+JQGIH
	4ejV1KOf8KdIgJkJJd0nw1EFqcorLS6kqd43GbNSQf4kQ8/JWsSdJUIZGWMoxyBXzyP6byNhrL3
	CunsKsFTzXgu0k7Tc5KXrAUgwT4HAyL4GyJU2kQjFetEKau0NxuCAiNC6uOys8b9y2idjqN0uaQ
	jef4C6WkHJMsm0nbQxVzH0I7N/rjzInIEwudxjNVCAdB/VN9VH7HUtYC/2RFMxX5wjIOw9GPf+5
	ofAdedDlrsPhG3wVAvoDq7MEpV7AJqEmry66g1WR8Evf6hh++uFULoPzunmWDwQ+
X-Google-Smtp-Source: AGHT+IFgyOmLhLikpKp5N8eKIBSRJawsxNl26KKF3wSiDL0Iv9HobJOAB2sCN6zFy0EWNUnPM86RFw==
X-Received: by 2002:a05:600c:1c9a:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-43bc844a704mr21199545e9.3.1741098328217;
        Tue, 04 Mar 2025 06:25:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc9c10f6dsm42069505e9.24.2025.03.04.06.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:25:26 -0800 (PST)
Message-ID: <2b8f2c5c-eb06-462a-8fbc-9eb28866f49c@linaro.org>
Date: Tue, 4 Mar 2025 15:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add ES8388 audio codec fallback
 on RK3399 ROC PC PLUS
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304104200.76178-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250304104200.76178-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 11:41, Krzysztof Kozlowski wrote:
> Devicetree bindings for ES8388 audio codec expect the device to be
> marked as compatible with ES8328.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changeset depends on bindings patch being accepted to ASoC:
> https://lore.kernel.org/all/20250304103808.75236-1-krzysztof.kozlowski@linaro.org/
> 
> Please take it to the same or next merge cycle as above ASoC binding.

Binding was accepted by Mark to ASoC, so this can go for this cycle as well.

Best regards,
Krzysztof

