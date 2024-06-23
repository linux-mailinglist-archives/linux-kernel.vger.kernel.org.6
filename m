Return-Path: <linux-kernel+bounces-226115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7576F913A76
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DC31C208BB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462818132D;
	Sun, 23 Jun 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdIezSi3"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAEE84D11
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145322; cv=none; b=smNT00RiJoi5iBkWPPvVPNoO1hWg9IxHRULikyFEbANa0VlS43GLxAbbjBd8ZT5N7GjMhyejjzV1JiINRX8UM9cA8iVWGB9drIWWg0tSVJGuTrC3kmECp9A2b02JyS/pkCjxqQxnz+F0sUqV2QL69z3f07u41vjFEMZOgwK15vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145322; c=relaxed/simple;
	bh=QLyVxh3PM16EI0Yg+KsAxE5zNNRLSRF/Qah36B69MsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP8LGRF+w+x+0+WM4z7C0WLAjcC8X7FEYHpzzF2hA0AYl1L06WTPW2wn/I9Ozp65K+su+hmxnzdspYA75yojwkWlvwE/ZxqnrGTww+FXIJ1AxVkj4om4DzKPZu0w56cl92L+aTPP4PeuxriRRY0Phftw4KkGBi5lJ6x1TICumX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdIezSi3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3645e9839b3so2570620f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719145318; x=1719750118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgre2tmf9SXFj2cqbgPVUjh3Eed5VaGUQC0zWeY+boU=;
        b=fdIezSi3MWw9rDC5ddm7iE88WjF1FvKv86jDlnzlEYkYl3TiuuurD1dn7X4cJOo81F
         zmCdtLwkElQ09JKDztIoKFi0bl9DsYH0biHV1JCbsl6/AJxoHunv+r3nI0vKgAUrHYrw
         t4uhonOXL35cT14ze0eTB5ION3jAw8E9HJwH1ZKfFHTYH3TuPZ50k+NCe1HpiMuoH2K3
         Qm4ETgaS2jlmOqhoqjWKCRMF2k6M6RUUKQ5ZHdYJv8edI+BDXmVwUkxdm6+bk9OYANCD
         raPhK1zvVb3mC8lwskSNLEQVa53Xu0s9+Mr67fe1MekNro5vzyJEt+JZsGRLXvDbsA0r
         TF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719145318; x=1719750118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgre2tmf9SXFj2cqbgPVUjh3Eed5VaGUQC0zWeY+boU=;
        b=BLwi03TEZkaf4Pi87ffNZpLw9FWPQ8SgoAqEzRolTsBlDiKwCom7OpRhL2EB/orTyi
         zFFUj53hyHpDliJRLF5l0K/V9t9TuYfYX1w/RvSnYVlJ7bxpjWrcADO5KclSE9Xl1axn
         qE+Z3DblChvvT7klCeERLlZZJPjPdclM/edAN5XcO2lZAY5qVsF8HQJQAe07tBZ1N+/B
         bDe7FEMSzI0tPnWhDwzYL+M/fC1hrnPOYcmzuZsysK8DbuLbZqg1hUsAY6T4FdYXlvat
         ARTNt7eozmC+K+K42Olsn2FdXc7kH13lSVt9Nt2OgXYWabYuhJcEHIcmalYFz5QrotqM
         CU2w==
X-Forwarded-Encrypted: i=1; AJvYcCUSdHjg8aCh4s590Vx8i4V46o2/Tld2aSSbn8kBRcNgMO3IIC3LHqTV2XZu6DKBsxaKwLokCsAOVYslM6/trVX1NjOhzkC3cItj9HWu
X-Gm-Message-State: AOJu0Yz9zaVD4YdP/QOjkHTM2O7HyHZtyi1rexz7eUY4sjr26W+S1hUx
	Tu8Z7VOf3HuTUE6GAOpK3xuAE5w2tR4xKM4uwrgyiC+9cflfjEDBFrseNHXgGf4=
X-Google-Smtp-Source: AGHT+IFkOrybExCXqw1aas/OIA9pf7OdMxt3VXdHbfkpFMy1QVq0N03E8F8aFd71i2/Z+mUXEfAJ0Q==
X-Received: by 2002:adf:fd87:0:b0:360:81d2:b06b with SMTP id ffacd0b85a97d-366e79fdfbcmr1251813f8f.18.1719145317888;
        Sun, 23 Jun 2024 05:21:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f693fsm7197553f8f.69.2024.06.23.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:21:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
Date: Sun, 23 Jun 2024 14:21:51 +0200
Message-ID: <171914524817.46635.13681344434936708370.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531193115.3814887-1-robh@kernel.org>
References: <20240531193115.3814887-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 31 May 2024 14:31:14 -0500, Rob Herring (Arm) wrote:
> The standard node name for I2C buses is 'i2c'.
> 
> 

This one is waiting for 3 weeks and I think it wasn't applied. Let me know if
someone else should take it instead.

Applied, thanks!

[1/1] arm: dts: aspeed: Use standard 'i2c' bus node name
      https://git.kernel.org/krzk/linux-dt/c/11afaf16a6540754d618179bd01791fc03480146

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

