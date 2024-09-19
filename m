Return-Path: <linux-kernel+bounces-333291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5397C677
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9FC1F23A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA47199389;
	Thu, 19 Sep 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wSOpN+V8"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9F12E48
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736362; cv=none; b=BbY6LeVvJUhbnTK5Eekb/Q2g/dUWomGBdo4azFF1i42BgDJTrzcfWpvXRDMEBZIkCIwvLfUAAKN1soASZFxYeYggnSJM6P5aOJqP3qFDsIrlbnn38glPM7IhziDTCk0p427YUu0m6Ib/DkyKdK0tXcO04U0zsPpAb6sK2Zyyv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736362; c=relaxed/simple;
	bh=gELVqvyqcJInyr8E7hFzpzkNi+tcnEM+7zPPHqXS8a4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRy32Onvwf6A2xt3BhLvVpR6PozEeT3ECLyrDiXs4XtlAwUspzRWLTuLuokkvC+CfHdtQsLhi9gl8XiJa4sr4vxRtplHyOg43Ci+DXvnawCF7nLXFYhDKYDS3i83hCPIJplBrsUaX705b6nq7IfMUWKweB5sOU2+nHoKMzEOu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wSOpN+V8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718816be6cbso448290b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726736360; x=1727341160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gELVqvyqcJInyr8E7hFzpzkNi+tcnEM+7zPPHqXS8a4=;
        b=wSOpN+V8gFi0Mpkzw8xCb9Tl4fqma9+DcfEjcswbq9RGnuj6HGZbqLYYuBZBpL3wnb
         mP2GH1M9z908073TNINTI3TGxKDRbQLU63ju35/sWymUoCXeZokQVjWRcqrAmBvGyrBU
         93rN32wfNi71qrJMQqAtt0hx248gV4us+zofHmJbvbvLUGxwuZcJ8Ye9vIwaxN2anHaq
         qm8V9zVPaYQOV5yRj5Ir34mzIxpO3GzxNZf6bHjkibph+WeTXSYNyIVDzyL9Rbd0coNi
         Xn6rOSn/AWKm0OFfENgVSQ1xWNEqtIywmWP4+oI8GvMUDBtOrW/SiToQkpAadwmhZqpJ
         y5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726736360; x=1727341160;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gELVqvyqcJInyr8E7hFzpzkNi+tcnEM+7zPPHqXS8a4=;
        b=jIaNHmuO9FL8q7aRqFV1xGeuVhKG/88pZH8F2qjpV7TOf3uuC9KTTeGZ8cZr3AqtRu
         dsnJaiGp3nDQ4I8MwmVEE+S1AR804EOhBbo+OSccoU5Pi2adHoS0W9BStTu/vtWs7+kH
         l6AEtvnxIzs1/MitgPnamWDnCbGAtjKAYp6okeWYHtCB8SMAvrWVjEvLC01Hf8rsjM3m
         +WHPaBGrt4IkSMrKxMLXQjdBeGlQ7w736Gxfno2TTQRySeoU8kraIiGn4yGNxlCTHEcz
         AuCvM4u8MaQgSgS27CGAaJSFbXVTfQoAeZV6+UdubfuBkwT3lzgF2Qo+4BByV2uV3m1L
         3NRA==
X-Forwarded-Encrypted: i=1; AJvYcCU0IEYbvS8qocdKZNT7cUss9y9443ng68rSySOuhxrqd0EjsYQ7gFFnqM/855Ct5z3kwSOb+0exF8g6m5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjR4li08oMMrPEvIHEslRearfkXSB/0YmtbrGYQBG4TdnOFA6
	QExWZ8/MQdFgd4caQOOjE9g4crMHSLVjdM4B53yNnfex4yYz4BJA3rA2Aa2sotZUZ0v0VUjDres
	l1UG9vtxXpxfEU3OmPNkCiValZycdjgYeRGNSTg==
X-Google-Smtp-Source: AGHT+IGvZKhZ+sgK1EVS1v43hs165nAjaXCVBqA4ql8mlkaKawbV4Lhi2ui4b5YR+NQKc/pd5URgnIZnstCpvwceHIs=
X-Received: by 2002:a05:6a00:c88:b0:717:fd98:4a6 with SMTP id
 d2e1a72fcca58-71926082587mr37728842b3a.11.1726736359963; Thu, 19 Sep 2024
 01:59:19 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Sep 2024 03:59:17 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <87msk49j8m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
 <87msk49j8m.fsf@kernel.org>
Date: Thu, 19 Sep 2024 03:59:17 -0500
Message-ID: <CAMRc=McEWWm8N++4a5LMCAa0GWsQdi0KuSpj3ZuS_he=H0LP+w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sep 2024 09:48:41 +0200, Kalle Valo <kvalo@kernel.org> said:
> Krzysztof Kozlowski <krzk@kernel.org> writes:
>
>> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>> v1 -> v2:
>>> - update the example
>>
>> I don't understand why this patch is no being picked up. The code
>> correct represents the piece of hardware. The supplies should be
>> required, because this one particular device - the one described in this
>> binding - cannot work without them.
>
> I have already explained the situation. With supplies changed to
> optional I'm happy take the patch.
>

No, silent NAKing and needless stalling is what you're doing. I responded to
your last email with extensive clarifications. You're being told by the
experts on the subject matter (Krzysztof and Conor) that the change is correct.

The change has no functional impact on the driver code. It's also in line with
commit 71839a929d9e ("dt-bindings: net: wireless: qcom,ath11k: describe the
ath11k on QCA6390") under which we had literally the same discussion and that
you ended up picking up after all.

Arnd: I've added you here to bring this to your attention because it's somewhat
related to what we discussed yesterday. It's a change that is very much
SoC-specific, that has trouble getting upstream due to the driver's maintainer
unwilingness to accept it. Is this a case where a change to DT bindings should
go through the SoC rather than the driver tree?

Best Regards,
Bartosz Golaszewski

