Return-Path: <linux-kernel+bounces-223945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D43911ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14411C21F95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789F13CA9C;
	Fri, 21 Jun 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQN/qo1+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBB15C9;
	Fri, 21 Jun 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949672; cv=none; b=gaCKFAzgtL55Tl/PyN+oCPeveo3VQfSeyx0L7JxTzXMkW8DOZ1v5gcD8hFWhQKnq0LNbX8nmJ9eVgknB4GcHckOzVDU95cZgsd8qaEMdgWrttNEoKo1ZuFpwHQS0PZ7N4XZslNC5yA1yYsBgAC8O70NwBBwbDBcuyRIv0BxUe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949672; c=relaxed/simple;
	bh=dfWvttQaGIGTWIV5AXSPz03fQi69sni/dZ4kluIIggo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvIwllrSwWz2D9sfk1qOF05vL33vTHIwN4R2q5CN+yT/uoPePNn5dCloxTwr8BjLkl0sIldj5HnPZ35s3kZaXeJAA1BKo9hkBk0gi/Ujq5Ijx7WI5ykUyfAE29Tq+8mH4sDjujU2BZTasV7w+uOBkk+vosq7Wp+0GLAOXbiauSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQN/qo1+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70656b43fd4so70376b3a.0;
        Thu, 20 Jun 2024 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949671; x=1719554471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfWvttQaGIGTWIV5AXSPz03fQi69sni/dZ4kluIIggo=;
        b=mQN/qo1+QszysOAxIkseo7dCheejAzXyirc0la6xMuD3eDC9KsmaDNChrqaqeEdK+S
         srY6/36Vlf9UWmNk29bdhHkDpLOld4csVDssFkfo0p51McnWuSzxhK6VI2VJFyTPtFfh
         sRN4+2X/YkZJMLcvZ0KcUV/Rl2nsGwV3LZo5MqdftfA7tuqxbdTKizJ/TxfZqgbBI4yq
         aS2U6l/FyBOlbZtckAH/fa5S8ZgO4k4kuVHujCK9Qa09+8XUOkChI3XMC2SmT2G7ZeAz
         hO1NG+dg2JkCE9vaOVTUZ05TfC4ekkIBCyxj6jq4oXqo8IflCRq7KkRNCTnMOc6uMkAG
         O3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949671; x=1719554471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfWvttQaGIGTWIV5AXSPz03fQi69sni/dZ4kluIIggo=;
        b=U+BVV1g9e7tBqnAh9g63yYBFwSTiZu4Gjw5of0z3dEJAty+bEcBX+GGjbdxmcAOEfC
         DN9HIKV8NJhM9xTps1RPaybd8V8v7IQ1m2H39cRLbO52B+erlh8Lhkv+vvToaxZFpswP
         qI7wsLj1criWn4/wbNDWoWF4O86GJZOGkTcbqVUxTQ7Bela66SpnqsP1zHMJsTqSOuIl
         fMh7IMpvPo7cjPOF0NP3vP+vC4n+CdgezGogU9w/2Ssca0x9JNsA/+/UHPQCK8PkoAoW
         QW9H7Hb6tZXBHsHeLlb2bHi+0R0Gb88aQKcj40seXPveOHCNGkqeKZ017HWfrdkFhcJV
         5Kwg==
X-Forwarded-Encrypted: i=1; AJvYcCWNxcV7lGTLWTDZIkZBQ5wWxPlHQ4lxOVFg9Jki1AGGLFUgy6+sXYGZZAr1/gE8UFlkeVxMg5t/4YaDweZENCzsshwv8u+nhxAKbovMZ/m9BRuf2grIEm1IHhoCy+ZgvLImY/+LVpzqoX9RL+o=
X-Gm-Message-State: AOJu0YzRI9V+SNBhPeMkS/R1gw4+F6dVrD6/braZdICTxkTjncTa6dB7
	U8kHlDlnLTrpaAsfzX0mjdb2PbzKuoHEXr732ko4K9eBm7oTrLowrRhGVRQBhNz57A==
X-Google-Smtp-Source: AGHT+IFuwRd3Ggd1n6UBRnPemQuxNigwRTWjaO1bP8ocgMqSiPj3l2kFLB8Dd5y2EsUA1U3ocuwr7A==
X-Received: by 2002:a05:6a20:2e13:b0:1b7:1ede:ce45 with SMTP id adf61e73a8af0-1bcbb5cd3d6mr7432300637.36.1718949670383;
        Thu, 20 Jun 2024 23:01:10 -0700 (PDT)
Received: from ?IPV6:2601:644:8500:e0b0:864b:f5ff:fe5c:59a5? ([2601:644:8500:e0b0:864b:f5ff:fe5c:59a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107ac5csm607562b3a.34.2024.06.20.23.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 23:01:10 -0700 (PDT)
Message-ID: <47efb34c-4aec-4aee-88de-35f759bf5be3@gmail.com>
Date: Thu, 20 Jun 2024 23:01:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
 Sven Van Asbroeck <thesven73@gmail.com>,
 Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks to all the contributors here! Works on an msm8960 (armv7a) device! :)

Logs:
https://pastebin.com/Y7NGzR9Q

Tested-by: Rudraksha Gupta <guptarud@gmail.com>

