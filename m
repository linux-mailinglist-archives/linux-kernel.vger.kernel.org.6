Return-Path: <linux-kernel+bounces-225701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E581F913402
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24B5283924
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830116F82A;
	Sat, 22 Jun 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1+IsMR8"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19C16F0EC;
	Sat, 22 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719060376; cv=none; b=PJGbnwblGcxhSpkgn5EOgAezQntHblZjFRcP0JYA3VpEfdHToU7oVVjUhZH67p+ozKkX55HzXaz8B2MKiBvpNJcn9OBrIyfw+CejmMiIREIS1PV0sd+/5G9ArZ2OiNN20sYn0TKWMsC30dQkQZCoLPvNRryIe9ETc/VnoA0H9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719060376; c=relaxed/simple;
	bh=keK1XYJG51HSPMkUrZrJr9eY/iWHfg/MR+unKus+/qU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8gTn2zfJNfAySA9lXgKURIBI5MR+Wwj/CxNYOjv19rLGVQZkDlZUiMdtkF6yY+e6UqsjMlUg9xqIzH/SP4mQKgqzl1Bc3s8j/LI+NKifYTfdXx1tXWkE6uv3DqpQbokpU1y9Llj0LQQws+CvUgqqlDXSRpQeaZsfCH3s9VW3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1+IsMR8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d331cc9feso1264046a12.2;
        Sat, 22 Jun 2024 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719060373; x=1719665173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xtc3YQWwhEs2vXvOR2PH5mI51fSfcNplDTd0O8+xCVQ=;
        b=Z1+IsMR80Myk8fR9EqhoT4gIrBHzGDk7TLl1yL1SjLkMzOxJ+TDT0i541koxEgCNsE
         axnYnFmg3kwhnD3CsRGbms157l2qXpqhDuZJS52s9DOBnkrapeSRgif247ZZ0PRM4v5T
         pmewy0cLtF2BJYvMV63qMSmEQCxrGxDrE16YzrO4O6JCd9CVue9ZkqjuzFdjK19bvKze
         QHUR/eisTWWvJCNNdwKe56Aj5RmqSQac+kC4fb52Bgoris8UYoJfXj/+nMBtX5n2u7UC
         jyGL+XhXWZwwPaY6uGgAgKTQGqzxGVjTlMzBGLS61V0oIP+scmF9/NhCm0bEZp8lE517
         5pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719060373; x=1719665173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xtc3YQWwhEs2vXvOR2PH5mI51fSfcNplDTd0O8+xCVQ=;
        b=EJozq9yOxS2Te7Cz/EkaIxhCpAcV/gr2ZLQFMqLrG9N4FzpOtnB5+cOOCZjcHVaR8S
         oRITpKoI9Vl3X8REsZNPpa7ag14CRUNL6z57kWgJcrXgRxIR6q+qdNSVERT5zO+6953L
         RnJTYakgkVyiGXvsAFLSCMsYUSwkRqlk6wzrD5LvVRC6uZkYUy05D6Vhdw3prjraGF3w
         rETXqyrlevsB6EJp3vPhoShQ+njOO1smmxwlR3soZMiO0N6q1pUcWnBfh2mo6jvohcR8
         ishDlehW1ZphlkARZW2kVWHtauO2Djxpsdjlz6QVjQn97bZFroDQ7T2xkiyavYn1Asl3
         wtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOrX8zy+a+1ExBGLXuDaVszwD/xEqSZRvW0/2tEzp1fw+0LnWzsVEZMaTABEAtTy5wTZ4uWS5bzYUAfUDm8i7j0GGZy/R62JwAAOSOj+MSeUpMUKRXWqwo7T2eUKBgo1LNHHFxJbqYwzEVE2Lg+psAStghEz6lS1RC77ruatBv7xdbGz9n
X-Gm-Message-State: AOJu0YwWGc6j87bnf+LymeJXachs14hUJFJbtQVUHeVdUEPzGWfoUj8g
	CJBam9QZ85YyBHkUL6vKRu4eOShWwSNxkVJZHOrBcKOPBk9jRkV3
X-Google-Smtp-Source: AGHT+IFBzxDcxx1CE0ZViNgLB0t0MgmBfPXQf2y4zveVJIRjgSOlbuN6rI8Qp7AbWoS6dX8BDOzBdw==
X-Received: by 2002:a50:d58e:0:b0:57c:7eb6:440a with SMTP id 4fb4d7f45d1cf-57d4a27397emr231724a12.3.1719060372830;
        Sat, 22 Jun 2024 05:46:12 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d31f33086sm2122853a12.61.2024.06.22.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:46:12 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: Add support for ti,pcm5242 to the pcm512x driver
Date: Sat, 22 Jun 2024 12:46:03 +0000
Message-Id: <20240622124603.2606770-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622124603.2606770-1-christianshewitt@gmail.com>
References: <20240622124603.2606770-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string to enable support for the ti,pcm5242 DAC chip
in the pcm512x driver.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 sound/soc/codecs/pcm512x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pcm512x-i2c.c b/sound/soc/codecs/pcm512x-i2c.c
index 4be476a280e1..92bcf5179779 100644
--- a/sound/soc/codecs/pcm512x-i2c.c
+++ b/sound/soc/codecs/pcm512x-i2c.c
@@ -39,6 +39,7 @@ static const struct i2c_device_id pcm512x_i2c_id[] = {
 	{ "pcm5122", },
 	{ "pcm5141", },
 	{ "pcm5142", },
+	{ "pcm5242", },
 	{ "tas5754", },
 	{ "tas5756", },
 	{ }
@@ -51,6 +52,7 @@ static const struct of_device_id pcm512x_of_match[] = {
 	{ .compatible = "ti,pcm5122", },
 	{ .compatible = "ti,pcm5141", },
 	{ .compatible = "ti,pcm5142", },
+	{ .compatible = "ti,pcm5242", },
 	{ .compatible = "ti,tas5754", },
 	{ .compatible = "ti,tas5756", },
 	{ }
-- 
2.34.1


