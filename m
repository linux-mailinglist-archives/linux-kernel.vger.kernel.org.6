Return-Path: <linux-kernel+bounces-436453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE3C9E860A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5921883853
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6CD15A856;
	Sun,  8 Dec 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="uPlzO+lH"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69F1531F0
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673166; cv=none; b=sMQRzXn6MRwyRYGQ7CKFiBWUMN44nuNViCZ1mTNK1oSFcV8fdNuCMlxd4/6PiUDK3Oc43TeaVaZsomF/0AYLmxbzVvXC+Qa4lDwJ9tRFDqklRaWeKAJ5s9RERVyMeDTOuDSxSaSoPsKiAj9N/JiKBCYnFa4LfQbNyQnwe+hXDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673166; c=relaxed/simple;
	bh=VD4Qw9f43PomdEuM/V+nuiBCc7OvB7jTuKobj+KPUAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muF/ZlWuco2KuvPpNrhyu2d99cWK2vU6z1DFiweNNY0ZXjFyGunBe7IzHCbdQPVXLPytvTK4NanfHe4QFQpef/bFagjGRqQLmCNlHKGDoE/gVhAqeGRIhhMxlLGefXNq8AnvBb4irrOtA7LsihwPqt/OlsGwgymCWk2BZVZ7NG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=uPlzO+lH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53f22fd6887so864535e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673162; x=1734277962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUDshE47cNUIOHz1m9AcokVYqibtX3WeQ/bCIvMGGYE=;
        b=uPlzO+lHyH4SvDo+Xfmhyo/JWYmQkkRgCAcYbtTtHhzpsPcz5qabTBIFJvF8Z7TeEA
         P0jAn4kUrTC/HVYC5mwRJSeeBTSkT4MIBlT3KykkuOfpE4/JMIF8PP+Coxxloba6BqGD
         8AKpVtcF7wKgOOjQL5QjwGIYej6ox8Kba+5rmhuOoyNR0MqVWvi8p/UuBnq9q80OFrcY
         qahTDdNvQCjs2o+warcVYOE6uF/8GuPsRJDUo/92sKNySE6tU7z4LA9OyRFYdWysZEDI
         l3gbO5eFT8R7GSZ8gt3mgy9jhTGYONskVUcuqxJ81BrGZnjxPyKlzV8hQfEgY17zTebd
         opMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673162; x=1734277962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUDshE47cNUIOHz1m9AcokVYqibtX3WeQ/bCIvMGGYE=;
        b=Jn4vMbz9oozbiMrA3PtrweUDk64fN0CoKEzqOY8SdGZrCCH52395PsugIVWrhf/dBh
         zuScwh2MDn2mrxZHyAap+1H9/Hd/+k5BvJVcrVbxob5HqKfQv8l5o7Sb7/IkVCIHCoYw
         2RRJKXRwcsag6OSsLpirHkvEUzhSda1O3HzzOEspGt63A1d8B330gdKIgCSvuFlAaG3S
         AWkU8KjsvxOWxXwVEIBIVzIRrXYNlT0OY5sHHI859uNfMWcGKhhCkTVjsV1T3zEoqXce
         JsVBJoGh5HrD9edA49BY6pE2PlLyTwhGSIg8Zvl2Wtp+1qtieLPtvkZpGW2rIsX1Fzfe
         8TkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVJS0P4MscpMgn7dikeWPZ2gCvpqifWCOmj5lryw6LsU6+GsLq4Rp0mUfz+Fh0JLx6s95KkSzyZTKAUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpk89T8WoPf0jr7UASeFY+dML54eTkOIfg5/eMdC4Jo085n7zV
	I8IVty71t/dU6NblGRHnaxj7hImUp3T4ZDYYGzgF0NmGRfXYwZTSNB76GaNUQpM=
X-Gm-Gg: ASbGncv/WwjQuuRr392SGYOAzDElOnbgEThPAtKss3dlIfZQWmqve1yrFHO+8k7NVRA
	FxmKNLIkZOGNn5MaLSQ6R5JwUPMbiLQH4tyOy+iUNb5OK/JH0YxTLY4agTgp+SSzrOUMbs+H1GJ
	tXHjctlbHWy8uTa+iQZw7G1mI8ErLnjHbXJ3fvsJCvXFU+hqbEesV0lPRZEeMLUVxfp7EEGrQ0F
	tCEtxNnRk/TfIdKCelg+K252w9pPyxktpzuZE8Tg1xnRbmxd3JRehyP+8UQ5PIu
X-Google-Smtp-Source: AGHT+IGHghPkOlkqc7UHPyf5HGz9Q3UJ0RZJYXinXIsqZJ5152lIi0r99E53/dB07JBNiLX9eei6Sg==
X-Received: by 2002:ac2:5b0c:0:b0:53e:350a:7290 with SMTP id 2adb3069b0e04-53e350a7447mr3078080e87.51.1733673161613;
        Sun, 08 Dec 2024 07:52:41 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:41 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 0/4] mdio support updates
Date: Sun,  8 Dec 2024 20:52:32 +0500
Message-Id: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up rswitch mdio support, and adds C22 operations.

Nikita Yushchenko (4):
  net: renesas: rswitch: do not write to MPSM register at init time
  net: renesas: rswitch: align mdio C45 operations with datasheet
  net: renesas: rswitch: use generic MPSM operation for mdio C45
  net: renesas: rswitch: add mdio C22 support

 drivers/net/ethernet/renesas/rswitch.c | 79 ++++++++++++++++----------
 drivers/net/ethernet/renesas/rswitch.h | 17 ++++--
 2 files changed, 60 insertions(+), 36 deletions(-)

-- 
2.39.5


