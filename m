Return-Path: <linux-kernel+bounces-225706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF8913421
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F33B22C12
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF79416F0E8;
	Sat, 22 Jun 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjAaA7tj"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AA1527A1;
	Sat, 22 Jun 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719061974; cv=none; b=oeWcc6lmDg8KbVWMwcCwp7LU0BjBlrcvnVhCkDKZb6aTrIAs6DEWqVFcJHAp/XKthtOMHGOiBWZI+vM/5qYuGVLxWx/pCSHVbp2WYUps92SA3yBsjgf+hsdjd6E67PAQMNHYm3ShjBbzHxIA4nJol6F11SU27ujGu+BAORH6Jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719061974; c=relaxed/simple;
	bh=fMZOVwSkUO7k/6NzpVr+ymgny6UN69nrUxytY4/yDUs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=HYNHRU9xm5BVpWMxMsFcL5PEnPxNQj4Cv15IWsO7lJ3elIccr19hcK/6hFvhei4BKuHNTh8PKJPVNIu8rMenKFGiuPKGXQiEHWqxSSX5mJmAVxo2YvDf43nS2b4v3owO8nhdUveBmTlOJ9RJs2cC3H4RczcfsCfsibLoUXRswdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjAaA7tj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cfe600cbeso3432031a12.2;
        Sat, 22 Jun 2024 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719061971; x=1719666771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTN5xRdMTo257fXeGJOwcxZkvaWjWVZcWAGIdTJL3eI=;
        b=CjAaA7tjyRTk84N2mb8TIOUzmx30wwOqrh24GAj5U9/cjqLXZ8dYYsX5+Y7lTAvz0b
         hviYk6ElqWhSnl0wpEwnqZWj28Wr7bPkDTqlwptB73Cj2rBGQULZefxdyPxnIDVAn7j4
         IhNksdeEfuG6LwCorBvnKwmNHy52YyGMJ/Xo4T97VVjp6A4WTRZDgALyRifY4PPe7AL2
         Rl/MHau9n/Gk0fQQsKbEspbWwCtOAuBO1qjGgxmiQqV0GKzYUtFkI8SUkcQ7h3gQknvY
         +cQTzJk372zxD3iVMaR7Zy8xFg03qRwd78TUVOveGEjaHfCDiL4RwpEzxr6uir8b5nJ1
         w9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719061971; x=1719666771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTN5xRdMTo257fXeGJOwcxZkvaWjWVZcWAGIdTJL3eI=;
        b=UqttBDNNOvwrFgXpjfWmNpnyvpk/awaGtXf8e1Sk+eAnzLfVU+rdvQB5SmPKvt2HHg
         AcLgZs8wZ8SEdlk0fXDBxS0QnukzfRN5XeOZ0ARDVoC+P2wO+AGd041Kwz/0gs/i5lYO
         lBia2C14bSniDIWOsXerH3XHhYDDONsjZAMoTtSxuyg75TqLyF1dRwpC0zVvfAhAZDKa
         Nw30J7WhE0XUMyFJyDmTM3oaiuSv/eLyoyI0Vx1m/DqrwN0mpuTKqsamO7478Xda0dS6
         sLry7WOizCPzUdxU2Q1RWy274hLrKorh0qw0THreRNzo/KOrxYzuKJcIZPzEuNBhIpJr
         qcMA==
X-Forwarded-Encrypted: i=1; AJvYcCXCG0DqEd3kzGAbHuBoS8bQIFPh/eS2LmflYI1wqjBfdCBgcVMr3HS5p/BgBvkVT5ULKDTS4r5OLA/u2cePjovjyjD+iIPW1YPsaWC2Q269a3aqLWm9rqAsWFWKXSi8Eysl928/IrQF2tGalf58wNumbuKGxSR1HJRhLe6wCe03nCPAMx36
X-Gm-Message-State: AOJu0YxuufW/R3/KDvJyNFLWZI25Pz3VzRM1Ku8+5Fmte04JyszfNK4o
	0FnIb1IHEcRzKSMDCQSB3Gf3EuHiP+Xcm5OqrZw/ZQWRUh5EkEi4
X-Google-Smtp-Source: AGHT+IHB5Bz3teh5Z84HK5+rxEUXquqMp40SWEfL2tioAgJRIcWmyz8qvStURlgdhynjRCjs5tO10g==
X-Received: by 2002:a17:906:d96d:b0:a72:440d:35ac with SMTP id a640c23a62f3a-a72440d3626mr8968366b.61.1719061970665;
        Sat, 22 Jun 2024 06:12:50 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf42a724sm197708166b.16.2024.06.22.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:12:50 -0700 (PDT)
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
Subject: [PATCH v2 0/2] ASoC: add compatible for ti,pcm5242
Date: Sat, 22 Jun 2024 13:12:43 +0000
Message-Id: <20240622131245.2607533-1-christianshewitt@gmail.com>
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

v2 adds a compatible to the SPI variant at Mark's suggestion
and fixes the binding patch title/description which I managed
to fat-finger in v1.

Christian Hewitt (2):
  dt-bindings: sound: add ti,pcm5242 to pcm512x
  ASoC: Add support for ti,pcm5242 to the pcm512x driver

 Documentation/devicetree/bindings/sound/pcm512x.txt | 2 +-
 sound/soc/codecs/pcm512x-i2c.c                      | 2 ++
 sound/soc/codecs/pcm512x-spi.c                      | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1


