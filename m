Return-Path: <linux-kernel+bounces-551332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07554A56B33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDB3B47DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088E21C19A;
	Fri,  7 Mar 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wxd9Q4Ml"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BA21C166
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359991; cv=none; b=D1fbKwcxeOjzkvRMg0zEWesKG31tw6gXP81fxFFlD5IOZcpnhtJHX2r6/bor1fLOBvPcyFGF00QUXq/o/7LHWPV1xqJTFHqB9l6xUA8SwlDxxdF777GZQEEq9iKhD0tZC7hXpeaJ03nYoVpkZVmuIqwx9ZGaPoDEKCA/88730Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359991; c=relaxed/simple;
	bh=9Y/Y73m9zuvLRA6vGtkNTS7BPX54Zx9NPuwy9xoTbQo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m79GHlrQ8V0m1r3gbWPAH/8RcNWz6JqoWvu9lGqikc9DoWq4M56Okx+wsQS8tvi/nithiIvtn15pnR0LYidnqXAZ17BCOpN2/K+MaEqsiizvjBT3rLckWnpt4TJK8s8hDS5NmgLu1hol88liNV20bdxu4ZofgTY4uZHe61HxNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wxd9Q4Ml; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912387cf48so63369f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741359988; x=1741964788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iArDif38+fZWZHkgSuOxfgSy+rEDqBvDc+u/YR4aXK4=;
        b=Wxd9Q4MlVmNFiwwtrfqzzFBBOnHB7G46pBet8K0p9sePNyrr6/7UwxCZQQEV7OlTuO
         qR83GWnJ7XYmaK/ecey4kFtw0xG/+H70Xq9jZoXcDeU8SFH5OFyR46M7ep0RFez4Dc1w
         pZKHEX7BxLg5kNIkmyASxTi89/lr5hEMDZkCpXDFHlB1Eqgfd33DSVoGxRDECSfFZtTN
         xVHMABYa7cj5GLnUjb+TujiurC+PNun83ubzA1DINnvS7aMWh/N//TNXUfSWmWL8zBv+
         RJjq4hvbwr1SWz//MwkvsiSbCu4hIYFRnrbOdlCEmmnkKzQaqeEKf9E1sef9q67rRwzR
         oekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741359988; x=1741964788;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iArDif38+fZWZHkgSuOxfgSy+rEDqBvDc+u/YR4aXK4=;
        b=LdaXCX5JhAQsKc+i3QzfiVuQPt1CW7Rh5dmTuid418lfYlyoB2WfgmWVclRQKp/Bqc
         MghoRj3K4CFHFV3fLUmNOC93tTBH11TZ7qhn2nINiifZIMuJparHuApt6fscE8wzvt8T
         tjaZHvGs5J88IPnysEBXu1Lm2K9o+izKsTtu7lpB3mo+ijND45CJxWHVuHu1rEZE/ud4
         Z+jpQC/ZtFPa2vMABj7xzMuzREk57Jh5o7+4AkJMMBrM6LQ4CVfKnXZcUMTVmqhnT+lG
         GfMak56v7OP9xZLyZaNh+5vUIwf67Xgv30oDOYOkOdmIdp3fkM8G/BHAV554pfnlUJ9F
         47Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWml7zxlx4Yr9h5cVgaBis+XJtCs9XQEpJhxFUp33Befd4/PFVo3xOxzAHCQ/ZPk7Yvo3JBhQHza2elbZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/k+8rmkASt7BgoQGk7R1l4RXsa5+ZjM7Z6pg/YKoj/czxh7It
	K6nsIitVI39rzkTCzvAjQw1Zlg0sMhO7amd4KaXjQp7Nz0IibUSnMyu12pAE3vg=
X-Gm-Gg: ASbGncsx1nLwavPhB6kWk2iL3EqR5SunMy6zNoalP3zoVkFi5/Ky7ojkDRIdgGK0Pel
	JtpMvm3pmt8IzG6VpQLG3VzKEsU8A1yi2A902elmpfburUVLKNlosn8aUMNN8/L8z38IGicS44t
	NwUDuHtZtvUXZTWDbhuuKssKnZ3ZXjEbsKZEAY5iRtMxKc8mrUDYGbslmqUfpOdBHACpYrHPNeY
	qvM9npEPRmMlqIZacBssoXIHsY8DGbPjxqAd1eB++c2cEh8JiPUPjF+AW2SFSKzbRWoHw2cOKPY
	eYlG0pJLYg532M4gJ5yMbl/4B7SiSMkpxC4Pqtz39QTUF2ZOwObM+5lTOVwv
X-Google-Smtp-Source: AGHT+IEepjQ7imgYoD7q4HWijAiTHHIHKB+RaF8r7Ya6WdH9B4Go9g4Q6bd0zl6386Q12ZEaV7KLTg==
X-Received: by 2002:a5d:5f92:0:b0:38f:2b3c:569e with SMTP id ffacd0b85a97d-3913a8b4205mr53814f8f.11.1741359988167;
        Fri, 07 Mar 2025 07:06:28 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm5694633f8f.62.2025.03.07.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:06:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 linux-fsd@tesla.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250219085726.70824-1-krzysztof.kozlowski@linaro.org>
References: <20250219085726.70824-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: gs101: Change labels to
 lower-case
Message-Id: <174135998630.202917.16887190642980215810.b4-ty@linaro.org>
Date: Fri, 07 Mar 2025 16:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 19 Feb 2025 09:57:25 +0100, Krzysztof Kozlowski wrote:
> DTS coding style expects labels to be lowercase.  No functional impact.
> Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).
> 
> 

Applied, thanks!

[1/2] arm64: dts: exynos: gs101: Change labels to lower-case
      https://git.kernel.org/krzk/linux/c/73fd2bb607387a77b2dde43a2c47db2b71c65a96
[2/2] arm64: dts: tesla: Change labels to lower-case
      https://git.kernel.org/krzk/linux/c/056106b030b73c7d53749469bd1cdbc89b4d2daf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


