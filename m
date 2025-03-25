Return-Path: <linux-kernel+bounces-576172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8EA70BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CD7A791B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982018CC13;
	Tue, 25 Mar 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry6DkxXk"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37C18A6A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937495; cv=none; b=bTqxigzyR4OeV+/l9SncSUcexHb4T34H6w9WoGIK+N3YWToYjvXJVs7BEaALfhPFVpPG11pkYw583UwaZEskDoDPPBLhTF0n+C0Ky67rAxb10Zf5VmhBiRT/SNce2rEBmOP3rQfahCcFuaoDQIE3FVuReZR+eHwOjiJgbRrYrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937495; c=relaxed/simple;
	bh=kYCJ1vNNmu4cnX3Zv4N65BeeWCJFNxqzoBhji8GJHME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjDIa8CWfs/SYzbGZKlG73IWeWaQmPKREyc37+yQtNYxDnfua97HsNunmp9R08xKzw4elsdbNBT1n5NhCTl/nPpjI6RfeF3Jl2mSbpotmMza7IEOTFgbMlgfXGT5SMXkrrw/8PTtZ9aRG74IX6nvJXVUhyJqQFd2l/FeK2awtdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry6DkxXk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c559b3eb0bso302424185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742937493; x=1743542293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YORNRy4OTXMv3Yhi6ofZ1+35f+Xdz3ifIja4azR4a6Q=;
        b=Ry6DkxXkUJ1p6XgqzHK3cxYYTqWXYdZ+sWD913E2/TKukPreJ0S9HEe6QWfw2R31pE
         qvyvLdP4/yiHmgo2Qi8c3ROZrSe/j4JuXAxqz+ZoImsKfHTBl3St3N0J7et6PbRmu7AZ
         hO1Q/Cd6nwZMbMKWE3bW0UjHXxNAFqIlSo1l6p6qutXXcV26JX0KrmQU0BU5fIn8fjzy
         kVsK4oWmHPUjr5Q+8jqnlcAW+y5CA7bdCNK+xjoyGa2vX7MvyDwaPSc5lTWSFyOTt5x8
         MBSF8jYQ0yiJyilM6yadjump1dt2XklgZXVP1ZikTCB2nvioSLwYYUQD4TNMR61z3di1
         9fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742937493; x=1743542293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YORNRy4OTXMv3Yhi6ofZ1+35f+Xdz3ifIja4azR4a6Q=;
        b=UKcKz080ZA5sssP4v4/nZFHpijGsG6/mxmYqW0lXre35PJftkfC6C4k8kZVmGXOWc3
         SF93AJFzhxLZn2tJHpBgMiaGLUJVt46LoFfRoH5qAwiNgZFrMn8kj7DbTeOXgUW6oQcy
         whQyEwFzVClotzfvkQATGbcBVOAp4XjhohcBARbxNUAjYrXTeHO15bV1KKZiQBLAfArU
         3QIn3Q6f4aQXbx9iOkQV42TIBR3Mk3bel2z2wmeUDc6b93m9TT2DXin41NBF8LKW1jdP
         KH1aMjTGuo699YKxCGzahIKP2E0Wu5KfhIq+kHrDYf8S4gZd7X06TLihdh07O8vQrrrz
         nOQg==
X-Forwarded-Encrypted: i=1; AJvYcCWtPTJ1iV5S41fvdQkJ8DzLDhxuRN+qd70ehjFOOa6V6pGTL9mVwSOqLffURrwb16wpc1pbBSanK9Vg8uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5MAccCc9im7GLpswxIJA971OeWcIzzCNIwRuU3w7FOcEms1k
	ANa3noOh3/i2pgqrt4mZp/zgyGHQwo+vWfMyNQhGAdOoWNGjHXUG
X-Gm-Gg: ASbGncsPmqbqBvTSzmONgQPkU4KlYy58O/ByRo4QjQHGHwP63iOI0To7Sikz7gHRANY
	Z0Dh/aIe8PSNG8tkwzR9BsVWuUKNIrxtifBswVQnuVvK2CMMdRn53qcjJsdLXjM0Eqb4bwuQ46s
	MLVGsMhhU+mSIB6sHEDZVpLT2TZryRJ9diPQCvd8KqWo5Zw0I2OAcMi9dRkFqewwkrHpGd01O68
	XnkJWo1bzmUy13S3JRYOWAgCcWJaWbhDMG1jd5NyXrFDSWJQIMh+XhMUtzkty629VxuJBLgPh1P
	M3Pdrp3KoB7D4XVDd8uPKxCXYi9V4MTR3oq/H9fFrJc6vC73l9TTXIwhlExBnwKcqv8wXhQtlaf
	D7Cs88OiahoCUPgQossw=
X-Google-Smtp-Source: AGHT+IHr7MEJqWj2AbT6Erl+Fujw+8uJX4cGimN+hCDY0WysNw8kbTVhRB2c+75HV6llOMRnBSRRgg==
X-Received: by 2002:a05:620a:19a3:b0:7c5:4278:d151 with SMTP id af79cd13be357-7c5ba211387mr2958874585a.43.1742937492920;
        Tue, 25 Mar 2025 14:18:12 -0700 (PDT)
Received: from localhost.localdomain (c-68-55-107-1.hsd1.mi.comcast.net. [68.55.107.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b9348308sm680685485a.89.2025.03.25.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:18:12 -0700 (PDT)
From: Brady Norander <bradynorander@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	u.kleine-koenig@baylibre.com,
	Wu Bo <bo.wu@vivo.com>,
	Brady Norander <bradynorander@gmail.com>
Subject: [PATCH 3/3] ASoC: dwc: always enable/disable i2s irqs
Date: Tue, 25 Mar 2025 17:18:05 -0400
Message-ID: <20250325211805.2099278-1-bradynorander@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a42e988 ("ASoC: dwc: add DMA handshake control") changed the
behavior of the driver to not enable or disable i2s irqs if using DMA. This
breaks platforms such as AMD ACP. Revert to the old behavior by always
enabling and disabling i2s irqs while keeping DMA handshake control.

Fixes: a42e988 ("ASoC: dwc: add DMA handshake control")
Signed-off-by: Brady Norander <bradynorander@gmail.com>
---
 sound/soc/dwc/dwc-i2s.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 57b789d7fbed..5b4f20dbf7bb 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -199,12 +199,10 @@ static void i2s_start(struct dw_i2s_dev *dev,
 	else
 		i2s_write_reg(dev->i2s_base, IRER, 1);
 
-	/* I2S needs to enable IRQ to make a handshake with DMAC on the JH7110 SoC */
-	if (dev->use_pio || dev->is_jh7110)
-		i2s_enable_irqs(dev, substream->stream, config->chan_nr);
-	else
+	if (!(dev->use_pio || dev->is_jh7110))
 		i2s_enable_dma(dev, substream->stream);
 
+	i2s_enable_irqs(dev, substream->stream, config->chan_nr);
 	i2s_write_reg(dev->i2s_base, CER, 1);
 }
 
@@ -218,11 +216,12 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	else
 		i2s_write_reg(dev->i2s_base, IRER, 0);
 
-	if (dev->use_pio || dev->is_jh7110)
-		i2s_disable_irqs(dev, substream->stream, 8);
-	else
+	if (!(dev->use_pio || dev->is_jh7110))
 		i2s_disable_dma(dev, substream->stream);
 
+	i2s_disable_irqs(dev, substream->stream, 8);
+
+
 	if (!dev->active) {
 		i2s_write_reg(dev->i2s_base, CER, 0);
 		i2s_write_reg(dev->i2s_base, IER, 0);
-- 
2.49.0


