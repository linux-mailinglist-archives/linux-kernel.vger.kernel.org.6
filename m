Return-Path: <linux-kernel+bounces-284036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A656594FC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFFF1F229B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C71BC39;
	Tue, 13 Aug 2024 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU/HEbWl"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3617BAF;
	Tue, 13 Aug 2024 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519896; cv=none; b=ENUBbZrhhOzB8YgfjDcl6+onNuNt2abfvt4SuTJng7dTuc7mcwYL67YGAetWReZMlplgNuyghBceKLM88NbYZ3u/31SpqejXUl5zq7o930wT7zF8C9gTqLlk55KHUA/F5itFGJmjdFs7/IqlMjbpcS3Vz0oDw8mRQoGpEfCsRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519896; c=relaxed/simple;
	bh=DIHngJsi+zASlV4mTRqqCbVfI+ZGcNW2G4jwrp4yfJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EvJCoqC08iHelBvPXS5MN7lLehUrkkFmiq6SH6AmAkJ2vJ/eQHh+r+dudFVaUG9ahKztiK+dQYK4zeE5/1Bx0rUXBNzeO98Xwxmki87zm/bviM4cob2LgFR5pvNEiXaacK3MeseFpURavASqeib50FvN5I/guu8ny1N3wHgQKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU/HEbWl; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-49299323d71so1902305137.1;
        Mon, 12 Aug 2024 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723519894; x=1724124694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUDbwgFhGBcr+vUo/GlEAcR86shin85qjCegdClEj6I=;
        b=aU/HEbWlA2nE7AyA5Mk4soTTUN12BnedAUMO0JrW2gRJseQA11cSG+RK4zR4bfjUW4
         VVl2G5rDvfz413PGExQfv8A8eRrvgRK07J91MM8JBRbDpEv49i++UpdWziVq3TI6XnSE
         VhD+Nwj9LA0vC4HgPdP1zGBDWVhnLzJS2bKbS5GTrfyyv0YHhbmb9KbbM4+cG230U+5r
         ix68AfuPq9aORNEM6MNRZQgutEmmb60Q8zdtdwiAUnbyBCoxV7E0Xvfnwh6iThN41IFT
         d18cQzWb8v/ZRmJh1hXnZ2p5I192qcvtdCumgsbY69OB1V3ACbPxh5wkB0GNBBkVxwGx
         iHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723519894; x=1724124694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUDbwgFhGBcr+vUo/GlEAcR86shin85qjCegdClEj6I=;
        b=r+Uum65WHAGyczD+R4x9CxYNj2IDUibqGnlkQPaVMFL3hwGc4oeIVo0t/f30CaJFQP
         N4OPBffDV62Ptr5Tudt8f9tt+ppmZdNPQ8RMhrEIjnriHmhj+hPnnt8Dgf9ihHZ5ov+y
         YI3bRqqXtJLQ+bANf7MH/teMn6+DJWtU+Xp99YbAMRZ5M06CzxZP0NQEH4oxIi096jpo
         Ou8Xkeml9trU8aZKb0Nd4RDrNTjbStgupHm7H8Ogk0QV5UGOeQ8EVyq9bhd8qVoVd9iX
         Bt2NX+DU1FXieCq5mH3Tv4OFiQTmlV7tXAzu1bQFYxna+I/F5GoquYatfvNC1OgHU68s
         w8ug==
X-Forwarded-Encrypted: i=1; AJvYcCVK4gagNI3HtfIzBPN9kwZreXZVGiPHH75m6X9Yvlj1zfH06WnuCtuSQKwHIPVb/EVHot3TOGcvtcFsdSwRjeS8/8QfWCnE+d1LrJnB
X-Gm-Message-State: AOJu0YxcaGe52UGVgJky+NFYDt2kkQKF8onpqwL8PwX1T8mJzwQI+YW7
	6PmdKlb+XwSwYYg+lm7B1iMsIAwDY3uZ/PH0052vlpg6JesKlxQJwuxNlou0
X-Google-Smtp-Source: AGHT+IFUbUN9ifK1nocK8/xEg5kdeHYVu9hl9JEtgp2ZrdeoIV8RKo1fOp9zagn6UJP+zlhGQGLnTw==
X-Received: by 2002:a05:6102:e06:b0:493:d3ec:76e5 with SMTP id ada2fe7eead31-49743a9272amr2893989137.18.1723519894057;
        Mon, 12 Aug 2024 20:31:34 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84136709160sm905492241.24.2024.08.12.20.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 20:31:33 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH 0/2] ALSA: usb-audio: Support Yamaha P-125 and cleanup
Date: Mon, 12 Aug 2024 22:31:26 -0500
Message-ID: <cover.1723518816.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support to Yamaha P-125 digital piano and address 186 checkpatch
complains for the quirk table

Juan José Arboleda (2):
  ALSA: usb-audio: Support Yamaha P-125 quirk entry
  ALSA: usb-audio: reduce checkpatch issues in quirks-table.h

 sound/usb/quirks-table.h | 383 ++++++++++++++++++++-------------------
 1 file changed, 194 insertions(+), 189 deletions(-)

-- 
2.46.0


