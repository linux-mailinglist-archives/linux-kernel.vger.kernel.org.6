Return-Path: <linux-kernel+bounces-527163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90BA407FF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1343ABC81
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E006E20A5F1;
	Sat, 22 Feb 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5rMLQzS"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C071FFC5A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224495; cv=none; b=inRuZK4d26EcPPyTUFPrtyiCQVIQiWQku+4zoM1vVGfsj9W2NZVKMO2upWIcXFS3yl7C5raDgAq78iHQHo7km/CAxO87SB6ebdCKApEDCCtgVkdPU4h/dMraZdA/8mHLJ+frs+6LnCyZSjzdy1WhllCca8LluhmPqr0C+EIC/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224495; c=relaxed/simple;
	bh=0eo+dpDy0u5yQPp5P4K2//p/JaR4GQuP29JV3GjQaoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9Rbz7Eweu7nFbIQi3lJ96ovav/dAV1o9JISldEw3dGV/jZfaInqGLbHQ3ZthQFlQdt8DpAeatOjG0vH21gbg+/0/3nuIxKu1yNJTB6y97CA8iiU41kH1T2mP1rw4zQN62qLpL02x3SR2a/dqMxsFdm64vFH3KaIQAbYZnhHUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5rMLQzS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5debb4aef2eso474333a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224492; x=1740829292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoSZUQ2VMWFtlgAIDLEnV7B9Mgl5ZO2Q7HcxD/gCGf0=;
        b=F5rMLQzSScsWihIKdvc8QTVr6HTx/bgnWTbubCniUbhDBv0REjDskNAMwMZIhUsUmv
         9O+IZ9xNA6znZozFeeGVrsRRkFJg0jE1QwFvrDlA7rDahYqET0N3vEHMS5xnJFn5Zspl
         L++P/HokhtOMIzoTPqqOmNe4m/gpC/FwRi7tpjEU9Pp3sqBKo7U7rxSYrE2CKWqKxrzd
         BimOtcUwPvtonkpy3VPJ4Ejt604enlpCZKm/njeS7Zr/ycZojzrQYxAy5n9xp2w0HDx4
         w19WOQoGGaLQYbhopOx4zH0oTXvEhggFo9yu1XbqswLx7sQly3Exma6I5ZSxYsA3633n
         lvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224492; x=1740829292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoSZUQ2VMWFtlgAIDLEnV7B9Mgl5ZO2Q7HcxD/gCGf0=;
        b=o1jAghnlgDCqJN/1tOz/Rl/ZTPgO33nbpn5XYsT0fhEf5Qk5iWRc/2NdF1hJj7mCBy
         ZwI8HAjeb4vpBp0HDa+657/HC2fIqHJFXLrR5+MbujhcJvpsmrFbrbulBNa/+QtGtglQ
         5Tm2jnZ/cvLk6Jl4kt5wZKqZrA3ingq7oYsihZ1HGZk9GhP+/mx3qzQHmWnRGxqeT/rV
         CLAQDgs8TuS5Oka+DExw7ZGRcIBk8bCeIYVe+gBL5hBlev4Za+6Bkvh/aSyEYNP0U57a
         ne0ArrDXi5ufLCnLpWV6+11X5UzghBg/geDpA5yhXgYMLgeEdBabwcVLkm3YbikECEs/
         YmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyTkbpfEIq87SPkwO0OM5TuQVr2UHJii9ncq0nBFI7Xwap08XBCJu7E6WkU2JG3dRT9AkRj4VevROHKXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlj1dnQmXwKYqDm0XvIAQygfmEaF8MPdbKDi4ndoSLQsz+5SX+
	ZWrIrbonlxfoDQ0om/ZDcX/HUeR8N+Fzzd9CASDq2EQBE7cwu7AS7utLolrLyPc=
X-Gm-Gg: ASbGncvHBwQzrpTz5OzEiC3sY4LoixsQI0bQ6r5625eDn5l4iCE+QT7GOXG7tkec4Qe
	WQtLdE9KUbht/i19pMH8nA8ao4cA4tnXYvDAGF4o04xOq5zO6P34+/zeb4OWrgcGV1K32+RoWq6
	FurR4Zth+ALQBjTM/meo9iGn4oDHmkJpDlx+JrAo0ZGWjl4qfwcn7r3Bdo1Vr03VvMuFNNt/v96
	dAwcSYpTTEc5Xw/6isql4meayFWIIgS0vLsUyuOjf0Qvg7x8Nsf1qX4NLRJqFYrW/YHIVZ2gM1K
	8aeCk+tVcQ6E3TWGqANCvOkW/i27ry/BnkOsAbY6ZFhZQxmzp2M+o7oJzj0C3dUBarC6UzhrasQ
	=
X-Google-Smtp-Source: AGHT+IHwhMxegxJLpOX8mxPkjYTencEu7XqqUkNBqFCyXK2r+OfVJTBxshzlcy8+OorXLkNnvmH1IA==
X-Received: by 2002:a17:907:7f28:b0:abb:eec3:3937 with SMTP id a640c23a62f3a-abc09c0a42bmr227118066b.10.1740224491862;
        Sat, 22 Feb 2025 03:41:31 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232275sm1833180466b.31.2025.02.22.03.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:41:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ALSA: arm: aaci: Constify amba_id table
Date: Sat, 22 Feb 2025 12:41:29 +0100
Message-ID: <20250222114129.162794-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/arm/aaci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index c3340b8ff3da..243965615ef2 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1061,7 +1061,7 @@ static void aaci_remove(struct amba_device *dev)
 	}
 }
 
-static struct amba_id aaci_ids[] = {
+static const struct amba_id aaci_ids[] = {
 	{
 		.id	= 0x00041041,
 		.mask	= 0x000fffff,
-- 
2.43.0


