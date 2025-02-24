Return-Path: <linux-kernel+bounces-528977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DEAA41E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC53D189386F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ABF24887F;
	Mon, 24 Feb 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Jnc6gTSf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A622248864
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398782; cv=none; b=tX8qzxbDimWOLPyQfe3IEGpu/AZZtO0UQLEL+T06PBRftb6KHn+MIXg5zYi9ZtUJQKbcMnm5GhM+GIkWXp1XhFVRUC3+B2Irx03GRqTjkoFC7vERGYlj6zxn5+u9xrCAK3K9Ft2wRgeZtydT82NlVb0SvWdcgnQae5bvq1Svquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398782; c=relaxed/simple;
	bh=+Agf8UKAqGkJL+3vH4U8xbAblWaOBO6N6JdSJ1Tt5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0dwPRZ/CraT45XfjwflE4wmHVlJfCfwzpq3W5BY4zvnmji7xOxFxmNepqsmKUf6ffh4qt7Dd4+QLT4E6WEte9IA4MI26FT7DvcTlFnF21pvkmCZOVkT6D2TeGKy5ip/Knq1Xz64cFUloCPTNr+VWFA58KpBTrQzpRTDUlqmSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Jnc6gTSf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec111762bso54531066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740398777; x=1741003577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo1Gcpi1KHfmTJdi6Pn8yyGXw/q62BzySSHgB6HQ+5Q=;
        b=Jnc6gTSfcUR9TI16u3EpYvVJD3x7xViIIqLxSbDNkqMU2kZB1l3AZ8+7Vl4RgxWDNW
         vSPo2PUQ6tlM7Yn4oB8VqqNE+uXDvF1yhkzQ2r+3RNDW1eM6qDyV1nT0Z57raOlauxBI
         BVMlINeV+SVrhMiSlNEjOwnpCtFUdUuoPvi4JcmkkK9iJAhwTXGCTDmNfYeSfbyhol5m
         XwUSVb4jaRlmzE4FXfW6PyhCunq24odyi32lCakez4OUAs5GNNA1CRpuI7F62PyrCD07
         ScPBTzl57ageKhrBYiRVCMov5jKwpGIGJwFz/aenkbTTHAuzbKTb5h4gt54m3u8a/84C
         j1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398777; x=1741003577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo1Gcpi1KHfmTJdi6Pn8yyGXw/q62BzySSHgB6HQ+5Q=;
        b=nJv6e4TjC3gsdBLRHz6NEwkNxMqpWXQFGGcQVNibdZF2sTTDXik8GOP1R4MVpxf10x
         8OQG4QJCzvzfv2EUaTQPffdQk9u2a9vNOmwPzxZFyPWzM+TKmrgWclOShbtVFIOZDXQm
         IiTc0ABNKE0VfoK7vYOeZ7xB2zbWwTWGIhsGEqBpVrhak4IYe4HxfviOOLYz3b7D225n
         XsWGzFsLvrRUEAVc8DFQ42e7uzpTnrVHtuv0VtJCO9i9ES5lwSqLrRO7IQyyHbMFGP5n
         XiKldX+204YYTeX2qKCazTTzyhfAjIfpa1xkLsrQ/pgce8EUomQGv8DoMwpTuS0oztxt
         W2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVN35TkxxZ8WviUVRFpspDHnTzysoL+WLMQpG+iiIGHQABuu/WRl+QCPDLAg+j2KXioxaRCnSCsGnuofHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZ2XliElaE7Uh8kUFinoihfKasZK8mQdOLu0wcsAVbJo79K3T
	oVxJTvlFuKLl8YvQnB5g6nv/yRTU+zsAYh6AdqVdHjKxQj8+y5OLp/UMnIBx8gc=
X-Gm-Gg: ASbGncvz5UIlC7iPmquWVr0rp1R5aDJaDg4hqqlqA4zzupQxrWLQZv+2bKg1p4fexQc
	QrePiwtGUDVUwR5d65jFpRNk0Psn6Rr4wpQB9sc8SjridZjApeDw9Oebry8f1hRg0Llyn+IIXJ3
	haYFEEsHMF2Dxs5JqsnQrAIFZPZR5ODFqpaqg/M7g0AsoC9mWh6YhCiDlbHESUZmgIrg8JxiYmX
	QfDBA6dXC7HbFrM7H7fw/50s8ofXoUGjkUlV+DuRWHhBLIxWweXFoHF+6M/A7Z7iUP0WX0/KhBY
	+2GwH5UWf0bcmg3kT/oeAYxhoONlFnyLfdAP7+DsUhdtmuVgwnDkFxk=
X-Google-Smtp-Source: AGHT+IGDJzU5NaW2phimEssVYOYVx4z5a+NFOew8SQJlOCu85fp72+5lccWfbGDbcb/fSCXbV+iifg==
X-Received: by 2002:a17:907:7f8a:b0:aae:b259:ef6c with SMTP id a640c23a62f3a-abc096d6e93mr1477881966b.0.1740398777012;
        Mon, 24 Feb 2025 04:06:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb978e2c9dsm1598901966b.65.2025.02.24.04.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:06:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Mon, 24 Feb 2025 14:06:05 +0200
Message-ID: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds some cleanups for the RZ/G2L ADC driver after the support
for the RZ/G3S SoC.

Thank you,
Claudiu Beznea

Changes in v3:
- in patch 2/2 use a devres group for all the devm resources
  acquired in the driver's probe

Changes in v2:
- updated cover letter
- collected tags
- updated patch 1/2 to drop devres APIs from the point the
  runtime PM is enabled

Claudiu Beznea (2):
  iio: adc: rzg2l_adc: Open a devres group
  iio: adc: rzg2l: Cleanup suspend/resume path

 drivers/iio/adc/rzg2l_adc.c | 117 +++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 42 deletions(-)

-- 
2.43.0


