Return-Path: <linux-kernel+bounces-440041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A519EB7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C310E2826C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76EA240365;
	Tue, 10 Dec 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Oum+znJo"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03323238A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850649; cv=none; b=lrRgOrXqLmmayDOcXqPjNCsvVAcB5Pk6xAfKit1YDrso5Y0tE10rZFnXAbysK4jEl7fTogh7+nLUArRFsG2naXMOA3DFcTP46TTaEHctg1qa8/aMpJb5ETQic8KjuyuuAumEisupplyq1sJV4LwJt2O8PXIgKaCO2CvFq/HiQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850649; c=relaxed/simple;
	bh=NtVph11BLd+x3z/1Zok/7JAFGIkvZxSriGpx0rha4FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJ4EvKCg5OsGZdciOvADXgCSN/XsIGNbUmmi1o7JHyYRgHQvYkGuen0mR8flWhlvGnHEaYfWUv69J77oV6nKnVTzRcW5oQDR8ZTQH9WFm8KmoH6675/cYCqvq3pwHism1vUKLJrNEcIyZAe5Ov75pFHhjkSoJmVUFl74M0YXtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Oum+znJo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so4671211a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850646; x=1734455446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzloo09Dgg4guioxkvLZOvAnsn9Efhp0SVwyR1byrx8=;
        b=Oum+znJotR81/GL+s9X3RPKW5dG7Pck33ayCgAliJEErevbuKFkHniF15QcQxdR1Lu
         vF3o8AhuF6Ny7cyQFsEuNwdPc6trLk/EWN7ujzUcFmQaHysDSPF6A1ZhxolQstOajJiZ
         ZnKbRxOk3roMK3Rz+yycNhSsGq6SJ3gksF1ieic7eNUH5/N3IdtUd70i8hCLfbbCAcfJ
         k80F0Quf6lF3FZxetKrqqw0wS0zJMxdVFKF3jdUSgL1yV+xE9tpT43R43DsKI95fJPvs
         EC4e4vq9x+nXRpvQaTgPqeslzokVL1S2fr6vO7ngkTGvpUSiVxsz5w+aWIRSQeFrjF6q
         SB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850646; x=1734455446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pzloo09Dgg4guioxkvLZOvAnsn9Efhp0SVwyR1byrx8=;
        b=CQ59k9vQGdzAPmQsM2G99yqJ/TJiPbC/KLre6hEeVt3cX8+Gqjx+E8RBO/qi1L1nJ0
         pAZ6osqvE9b7e8EAm11VMorgfthZcjZ+/U4VjUiOuFbJYyxeaFS+ufqvWuNjdX+Dv+NN
         mbF6SeFcB3NoQcB7RVj9nIosrF5i6VdJnRy92g8342HcKcPLmK9Dt2L9dYFdWZJsMd7c
         JFK488MrYrmAyspSms7Js9ebwkfIpSDmgYoKwsZz2TDPz4U0B9eUldL9+lgkUoq88B4I
         aat6chOgTvqFxMtvUHKzjaZ86u45cutCZDnWS5bKZk0cwbi5JWFbxGq77636n/cHHOsz
         2PVw==
X-Forwarded-Encrypted: i=1; AJvYcCURHodmWqWYm2HL/I8hrTaar/xResziLnpcbMQIm9TtMsN4G3REveijWvhWKaB5jg4O1SUkRThBKIPqLhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWzy2+99ipV9T8KLJolI+A7XwFxDwZ/JPwN8f7AW5KmJOJD91
	HqZZ4AzxziPWPNyJQqHlsXKjftpQY5lBLpgvNvj1bSqiWsIMZrZl746tqUAKwnM=
X-Gm-Gg: ASbGnctbtaTO+Dv82N6NfIuA/cFiBYnsvJAjY+9E2Ch0ovE9HXxRTXVVyU1PClM5Bp/
	8tqo8bRy2FT62zVjNbhWZ6aP6nxagxNSQYttLanj54sZv3FP7icXwgUfYE25N/VgC9qvCR9vh83
	bSbE7EeMYNhpJfFNx5RqjNXl8Y5KyhfRoLV5XxQ0Y2FDGQwUQ6Kq99TF5U7Yd2ItwCkHkyWwmZj
	mWR0w5tc+74tWP8CGo672O+EZwZ9lxJ3PywFUYRpsp3MEhR2WbCwYxQlagV9W+X8vU/shmYFTH7
	ySzhr34iYU0=
X-Google-Smtp-Source: AGHT+IHu+/x+M8u5QIMjQ6egtfsihnsclgAo9NZ4IQV+C7GzhzYxCnvnX8xs1AndpKM2ie6VGxgEag==
X-Received: by 2002:a05:6402:3591:b0:5d3:e45d:ba91 with SMTP id 4fb4d7f45d1cf-5d3e45dbbfbmr13230055a12.32.1733850646516;
        Tue, 10 Dec 2024 09:10:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:46 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 18/24] ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
Date: Tue, 10 Dec 2024 19:09:47 +0200
Message-Id: <20241210170953.2936724-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Remove the DMA description, as it duplicates content from
../dma/renesas,rz-dma.yaml. Additionally, remove the MID/RID examples
mentioned in the dropped description (this information is already
documented in the hardware manual).

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none; this patch is new

 .../bindings/sound/renesas,rz-ssi.yaml         | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index f4610eaed1e1..5b42eec864f8 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -57,24 +57,6 @@ properties:
   dmas:
     minItems: 1
     maxItems: 2
-    description:
-      The first cell represents a phandle to dmac.
-      The second cell specifies the encoded MID/RID values of the SSI port
-      connected to the DMA client and the slave channel configuration
-      parameters.
-      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
-                    MID/RID value of SSI rx0 = 0x256
-                    MID/RID value of SSI tx0 = 0x255
-                    MID/RID value of SSI rx1 = 0x25a
-                    MID/RID value of SSI tx1 = 0x259
-                    MID/RID value of SSI rt2 = 0x25f
-                    MID/RID value of SSI rx3 = 0x262
-                    MID/RID value of SSI tx3 = 0x261
-      bit[10]     - HIEN = 1, Detects a request in response to the rising edge
-                    of the signal
-      bit[11]     - LVL = 0, Detects based on the edge
-      bits[12:14] - AM = 2, Bus cycle mode
-      bit[15]     - TM = 0, Single transfer mode
 
   dma-names:
     oneOf:
-- 
2.39.2


