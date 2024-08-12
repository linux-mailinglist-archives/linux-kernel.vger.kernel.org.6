Return-Path: <linux-kernel+bounces-282918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22594EA87
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6061F2267F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B816EB79;
	Mon, 12 Aug 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="af64i5iL"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236616EB56
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457504; cv=none; b=Q8r5zhWa1CB+5cB+ehdp48GvVGSXNFN1r1AkzVIuqqJCJZza6oWp/UdTJWwuQinzpOcquB0HFb5MHzvJO1QwXnzv2LFn2/iteocGR1jpFOfdJ1cFiyXddzMtYrWks10ahAo3KurX6MC4jnqmeGP3WjTPendl/yd4+rF1jkP/OAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457504; c=relaxed/simple;
	bh=m9iltBGyT0Bi16sfkw4PReJR9Nd8fQjFWqWUcM6Edwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ0xl5dH32rIiX/hiqI024mnUSFkNMuvrn+dwVCIGCRcc3DC3VcZZ7aXgx1WgIpqiO95no+znvuyJ4YUV/kUOFkNl2BiCJ8vms59V/gX9gZUyFVJqMeEstXZDs7KA1JUvIRNbSadYuUEBgCJeObMPw6+04pQfHSIfjtmy8a8Pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=af64i5iL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368526b1333so3058458f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723457501; x=1724062301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LT4OWBWJDMSw8Klzf2pbHQrTca4RQG7pLzuzOgwkSto=;
        b=af64i5iLHkRVIvoFdYShSd4Dp2sF9VN2T9mKd7IvnYXAGqFfA7fJoav+jrpeSn4gq2
         j4UqImA1lFDMrvLXxJsFmJ5JXmchW2gT+t0wr3EO97q/6oLHH1SsFtiNoD8Y/WyFk3/P
         0jEELf1R1NYyreXVpT1/aeCZg5hkCXQV5YMaLlIJ6bLyDYffwsCK8G5vFxWlhWCa7dok
         R9gjT4rDewpYPsFk9CRhNna2oRLPIzcqZ/GjO9Trj0Ga/JDRhsnmQXSqaXOCj86ak6b5
         xGPS61Agih19kLm6oRLQHL0aYUw+YiErz9jR4QOKnbxwuHC2ztn/WuPl3cYI3WR0nQt9
         w+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457501; x=1724062301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT4OWBWJDMSw8Klzf2pbHQrTca4RQG7pLzuzOgwkSto=;
        b=DSHE8161tCd8n524V9mw3J/NaICL1kmzjHETcEAgJHzIOV7fpDK2AGVRDdYuYfXmY0
         HlvD56cghD2t3t34yaw9783SPzJFPD1FY+YezN7mRweWMrhEZf3YS7UgCQ7MsjwB09zK
         BeoIMtSlwubGcxR8JExYQ4GAj4T15dk50YQ91jQhTCis/jM6XBnD2jNAbft/b07mE1XV
         FV0yEFdiKqF/YUIEDZNoGzECiAXRfPSvdp00M99/ukC5z8/ebG8x5uStfs6YRWhnxS15
         bhvcBqVTcpTb5LsazBmdSx3nRCrJVaefrlU9UVihGXeKQnpWbmJZUhUKPw8pFSZmX7w5
         gakg==
X-Forwarded-Encrypted: i=1; AJvYcCVGmree4GnmzY4oMAhdXx+5YshOYXFG8mwoQn0iBKZZfuOmrpD2OEca/L9vdd1PkbHo2mQ+ExXUdoYZ3XFTM1Rlm6bgDen+DEIkEUCM
X-Gm-Message-State: AOJu0Yyv4Y9Fb/5Elux/Ao8yEWjJPB83o6rDD7dfLqLacqWS4tb3iSax
	Cc7X494w9Hz9xUR5i3yxkBrN6g9SKJQIUPUKSptRjdwuQ2zf16RFlo2hk4X7Fj8=
X-Google-Smtp-Source: AGHT+IHxZwuhRnfMslbBFvqQ+342n8qFMtlsUgRIRzxAiFZ11aptWLFXKvHcAy2U8Cw5QOUN2k71FA==
X-Received: by 2002:a05:6000:459a:b0:367:895f:619e with SMTP id ffacd0b85a97d-36d2810977fmr8945155f8f.11.1723457500669;
        Mon, 12 Aug 2024 03:11:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2accsm7054591f8f.90.2024.08.12.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:11:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: nuvoton: wpcm450: align LED and GPIO keys node name with bindings
Date: Mon, 12 Aug 2024 12:11:30 +0200
Message-ID: <172345744176.104566.11404449092805003253.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701164915.577068-1-krzysztof.kozlowski@linaro.org>
References: <20240701164915.577068-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Jul 2024 18:49:15 +0200, Krzysztof Kozlowski wrote:
> Bindings expect the LED and GPIO keys node names to follow certain
> pattern, see dtbs_check warnings:
> 
>   nuvoton-wpcm450-supermicro-x9sci-ln4f.dtb: gpio-keys: 'uid' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)...
> 
> 

No one took this patch and it waits on the list for very long.

Applied, thanks!

[1/1] ARM: dts: nuvoton: wpcm450: align LED and GPIO keys node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/c7b44ed960ddecb3604d1e273494a932f00f384b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

