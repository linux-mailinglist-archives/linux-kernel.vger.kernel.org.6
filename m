Return-Path: <linux-kernel+bounces-225699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130C9133FE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889B01C213BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6990816EBF9;
	Sat, 22 Jun 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScVxsZKh"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F51CA9C;
	Sat, 22 Jun 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719060371; cv=none; b=dxXnrs+7OJ7Z0zdBb3r4TZJCEbs0ONbzItKfcfqtnVAQo61kGkYdH+o6saFZ5DwCsVfLTQr6VDcF78Mnz0c8OQZRl4nWzMrRUnFYbM/B5Tq8SWYdKqfl5wMsKl3OZZppTwki4SjUMqCA/u53OZrVm4q8xIknehLrPDyqUWpWuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719060371; c=relaxed/simple;
	bh=j5hoJYoMKSeN68PQ+0IMQBerfpAUDkUHtQ+qPa7GUp8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nw2UuY6g5k1ep+nt/5Y5l5zvdqPR4D++BijCguzvruSbJsjn7ONHdu/xvSXZfoMtqR1T+O8eUVNsY6MhISeblEl1cNX0pNP+PvnyqN8BmqHWhEEfU4oOuPtwQvYHbynjhM0PNHiLqpHKRHr2RXxJPCcHWDpitGBJ2sAGySFhI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScVxsZKh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso2517312a12.1;
        Sat, 22 Jun 2024 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719060368; x=1719665168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHeugCYvp8fzC+q2GNZHm0YL0KES8S+qA5+Z5NcvAl0=;
        b=ScVxsZKhfii1YNOI/Q156uVqmOm8rya6w0jwcF/w+rl5OCM2WOuiif/FaMXRARdkPv
         fCypuixccg8c2rSmJTsK3lapXM3NxvHSI71ubN6ZElMM19NyVqE9HF98VRIvpsnkXl9L
         c4yzNdnrrV0lStS4Fe23oaNPeQGph5cVj+bCd0ceUZS63uGf3zPg/LS/qJXuJKu4+Ied
         7G4CAmwzBylNnPmewPO4fJgpkVaDn27ccIvYshoJxhkJIVWD0XRc2u4h3yrELf27XsD8
         OWCr2OhH61AxKCjopNeOc+yrLVgruVHb4bQmkaB4lMT4FL71MzKCjEy9BgnkbnhuIzJq
         sA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719060368; x=1719665168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHeugCYvp8fzC+q2GNZHm0YL0KES8S+qA5+Z5NcvAl0=;
        b=KdQZM9E3ES91cu0BX+hhfjkmR6OO0Z6OVYgyf7HJH3s4usUsQ0Re9gvsT8jjKAkDxp
         hXqvxACBLOXsCSjZSo6VEeDm5dPXgbzGssww7FP4TV9FC3Dubr79YM3UmwN+DE76SRUM
         ieS+CZbx8MBzgNuYdriLlopU2YyCZwxIL/9/GptJPsZu+F9Nwtz1+FtXWjp6liTMFqbe
         3oWiYmR81BZuwJQ7w1PPMlKBTv8sgJFI+wAILEzCpq+krnfR73II9xI6bZO6nJu/bISG
         yKvQeMCid+DeKSaIqKAjhPusLZLZlhuHTTGsW4++IIDaflstma42987hF6uMsHR4Pyv1
         qMuA==
X-Forwarded-Encrypted: i=1; AJvYcCW6t5vsL12ZFD+RJeV/PP5Fm1ZjoVvbeieltaDu1m3kUK641Z7zKPAVQQ6WhElQOLsbFldCf9N4Af5HhQRC+RGkskxTMbTk3BDZeUOEyNBvOQs3ZNoZG0BeZDxvW5k17q5TvJNB68evi4FqVo6oTCEH5LztungMiYQi77p8fySCOIRfZxd+
X-Gm-Message-State: AOJu0YzOB5dSq8n1htDHzzrJ9g2N9oKYY7z7E8GZtWz63WPYffc1cegM
	NGZX8si7OpYEaKCUO75K80fDbExgELqscpmRu2+0pTVMfj4vxH50
X-Google-Smtp-Source: AGHT+IHhU0OmigKaPH5wvUVtPVqpNMfKaC2dTNLFNkgOjpiCVtyhuqi+ngksHV8C90I/5T0QQAt0Wg==
X-Received: by 2002:a50:9f66:0:b0:575:954:7ef with SMTP id 4fb4d7f45d1cf-57d4bd56636mr9334a12.3.1719060367739;
        Sat, 22 Jun 2024 05:46:07 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d31f33086sm2122853a12.61.2024.06.22.05.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:46:07 -0700 (PDT)
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
Subject: [PATCH 0/2] ASoC: add compatible for ti,pcm5242
Date: Sat, 22 Jun 2024 12:46:01 +0000
Message-Id: <20240622124603.2606770-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update bindings and add a driver compatible for the pcm5242
chip used on the Odroid HiFi-Shield2 i2c mezzanine board.

Christian Hewitt (2):
  dt-bindings: sound: add ti,pcm5424 to pcm512x
  ASoC: Add support for ti,pcm5242 to the pcm512x driver

 Documentation/devicetree/bindings/sound/pcm512x.txt | 2 +-
 sound/soc/codecs/pcm512x-i2c.c                      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1


