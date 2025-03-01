Return-Path: <linux-kernel+bounces-539979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D0EA4AB8D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DFF97A6A20
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDAE1DF985;
	Sat,  1 Mar 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBjpVbat"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915081DDC3A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838406; cv=none; b=B/FJObxrBf4ziDrkGIXAu47oBkcoDTBmU9i58HIu/N9VLWpho2opHzKRryoj/zRmNB5fmydbJM8iUTDIOgr7rTraOMcaQE0dFqrLOlrzLStfoPn6k86t0B7UGfJljZASdoUPbTocSHbnYJVIlReLnx7J7nKpNDmOMMfOqMtYc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838406; c=relaxed/simple;
	bh=jiT2JUaC/QAsy28BOMROpUvqNfVZo9Bo2xs780cMecE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EelQ8S1wB/bfSseUlh97zKlqIwT0Iwejlc0eVTI1er/qNKjpLMfXT2zfHyAlr3Qcht4VQdyRGbioj/8BClAvEpFO0gnW2eapjO2cVfVZX9Gec8VvmoqxkIXbcRofw+S39LcTezuwyUSixlXqobxdR4v3oX1nxT01qPBoMRsYXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBjpVbat; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so508707a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 06:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740838403; x=1741443203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIMmXa+05o7cFUzmMY0oE5JLkS5yaur+8NGSr9bhuis=;
        b=IBjpVbatbcjKVLmf6CvUmzmS+uHgTWROXMEu3RIB/VmsnvYnDVGxWpkGvq38uQtV7Z
         t1XaciXjApqJai78XgeHW6H2uNFmpOxaVR0zqxuEcTFoWvlSzP2teiHDrdVaMhm3BcDf
         CpRGpTXNORHjs6N2jV8Q5XKLuhjOkBeNOuSRVMzoOT7Wg2cMyp8EtkFVdkLOW7OdkQYo
         YRI61pGaOyDYXka2XLFfSBs5trPfH+9n6pFSfBp1X9Y1P7ecNId3ajouI2vQQchVTXhy
         DH/FI/aRiN/+Mkp4AUscWMzrXq8nolB6SieQJdHiSCBfpKIZ1J9KmatpcVid/noyUubB
         V0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838403; x=1741443203;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIMmXa+05o7cFUzmMY0oE5JLkS5yaur+8NGSr9bhuis=;
        b=leZWcsHFydtltlEp3Ub1mS3Vned5RxqyhtJwyqE7p5MSvD9jjQCYnYUH+V/f/uaRhU
         24QUom7NVLe3ZG69GmZRvB1hISP0kGaZDvY6nQiX+7eUKhn+q83PGy+9F7HAUwVcgPag
         x0aJ3peW2+yYiQ++C4mFEwv6TbaSt56ViTjH44rsUbCthHgROzt9ORaxIkaA6ZVZqOTq
         tLPk/PTQCN7tZD4y11M7JmeJrZ2d8LISrDSioEUzndTLeB0ZKLlDAqtfUB3z5739a1J8
         WOvsxNdc6Gn9La45r0OqYuAikdeMHP7H8Ms8VJAMoo/ernQhdQyGiisVnIPOncJnz9QX
         5IOw==
X-Forwarded-Encrypted: i=1; AJvYcCUT1274fEpn7tST8QX9/uG70Yp9Od3UdqFyx/3O4/sG09UUrFHtVyNgB2Tp3RC/0AFvhU8bbGH872U1cTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVVE7/cAvvND3X8gXIiKI3y4iq8hSRt6IoNJ9bR2Ex1nR7ZS4
	KWphdd+4rfLlndWtK7sIFS7uLfdi7DLr/X4SmGDdj4EpJ/LAtrYruP+dLHYxV1M=
X-Gm-Gg: ASbGncuinpTNSul92ZSFZxym4I7UoZKrqsvedXBnihByshUaaoGApEd/qoB0OizJ61O
	ZXIC3kwErV4IHIPmYwoUKoC3t3cG6n4wtx9N5FLRV7CWt3oEf3jFwVijcLGDXS2Y+yRhUP33WZi
	dh/APi1YsjqPtvMNbZY8hBiEy0676eVHxpNAGxq2vyvgGwnzZt9gE+K0zFQ5gvS014ClgAH6Pog
	5h99Im3Lm7zNha9gKsheIqR9nfOjy38iY/cv3V9k/W3t2a3qxKN/qifemzUxPjUtMRjkA/6rDsH
	0jRDE+BSZiB5E11eoYczLIfkwuRAl7XXQcRmwI3tnCbsBYVqabaKoT3bkZno
X-Google-Smtp-Source: AGHT+IHamdT8SxBWV4TfuLdPou3W8IVb0ZsVqTsHbzvccKkfVKbSEv939NC7kdF+ka7ZD+Wv5iaqLA==
X-Received: by 2002:a17:906:d542:b0:aa6:ab00:7b9d with SMTP id a640c23a62f3a-abf27360ac8mr179019166b.4.1740838402656;
        Sat, 01 Mar 2025 06:13:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9cbfsm485532366b.14.2025.03.01.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:13:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250223115601.723886-2-ivo.ivanov.ivanov1@gmail.com>
References: <20250223115601.723886-1-ivo.ivanov.ivanov1@gmail.com>
 <20250223115601.723886-2-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: clock: add Exynos2200 SoC
Message-Id: <174083840012.17657.16502862587559253626.b4-ty@linaro.org>
Date: Sat, 01 Mar 2025 15:13:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 23 Feb 2025 13:55:58 +0200, Ivaylo Ivanov wrote:
> Provide dt-schema documentation for Exynos2200 SoC clock controller.
> Add device tree clock binding definitions for the following CMU blocks:
> - CMU_ALIVE
> - CMU_CMGP
> - CMU_HSI0
> - CMU_PERIC0/1/2
> - CMU_PERIS
> - CMU_TOP
> - CMU_UFS
> - CMU_VTS
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: add Exynos2200 SoC
      https://git.kernel.org/krzk/linux/c/6662c09c0ddf10ef97b430533bb9e2f0a8fbe471

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


