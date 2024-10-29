Return-Path: <linux-kernel+bounces-387701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C49B54EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2132A286BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03820969F;
	Tue, 29 Oct 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jC/KVKI8"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495F208237
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236742; cv=none; b=jV3ImlwGREjfFGhvXtYPZ/PWnpBwcZUGJkMi1ChEjkg/fRgP/XKdbmqq38uk7WBl44TC1Z9tVb4P89131E5jkLFnWsik8C4QNk4cu27DchfQ2FCQaUj5ts8aKi/AtbMA8+kRbCj9t1oPzFlrEHyj+ewQU+rYdNF2TJdbdWldm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236742; c=relaxed/simple;
	bh=nyRP91hJ2h28G4QDpbeuqnCAv0dQZ+JWN4ohEZnCg9Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dohhK0n1+6fkzlWRPwOE31Ks+Yhl/esMRSwYMjtKq+iVYSCslJdzYCLUbdcprmzr/Zv3d6/nEhdOB5aSJlU4guyUeHanB/ofVtZJDW9W6yS2omqbbe/eNXMtaR9iKg8nb8iDxwG6xC7J81wLhqt8LgInQwj6WjIcfIfrAwgFXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jC/KVKI8; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5fbc40239so3410304b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730236739; x=1730841539; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRQx5N+DwrT4EUE73rmqbI0LhD3xdcyP7bdqkjI3R9M=;
        b=jC/KVKI8rfq8hPcvUY0gpc0jFKZZ7BheQj1pduMujp0CbHCsx5qIXTFBFZ1a5FLQO4
         ZPBeeSJiSL+hW+tLGYCmOdr32FGrDfaGCXtlpe02rUr1qCCtTwXjMXWNK/xwMjqmNBqY
         SkwVSRnkmQlxkAZOHug5preANFLEritSqBIyy5KJgkh3tYI3scs2Ynewzmes85yguwfO
         t7H05zL19phAhfX30CkpTpH8WawQj408P4AvBXZimRLgl867leApmOx+S4ry5ExJ4eid
         pmkb2D73SiNgaJ5l28hPxQFsKEwj2nrfFRqy3CzYg5nM244WIj3LiPaXdQJIlZCQnq8N
         NIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236739; x=1730841539;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRQx5N+DwrT4EUE73rmqbI0LhD3xdcyP7bdqkjI3R9M=;
        b=IyyyKmlTbooJ0+uVsorZQzQMSDChPg19FqrmvcZsjaSNY6Bh4Zs54R3zeuGAOfA5jF
         sbFRNe7+tPIdCVY2SZkzN+uRBqpu0MrxPQGCUop+2xR5VG6Uetib90l/5+nI5sfJ4dBQ
         VOZqEOr4G0ORsnrczi+yxEAb/sL8HpPhIjov8jxX//8Yn3XxeBx4nIjn/c8p+rGhm7Qp
         C35xCjvEq3PwDfOsd4UMgDyGIw9MVVadBQ77T2N6ZdVGWFPhro4nAcXwSqjrVA88aHoD
         PEU0Xihf/g/kknphTUesPHdd9ncGlIc0zm+ghSN0ClY6Yka2jtapVOqiYFRhNMRtlzVI
         KS6w==
X-Forwarded-Encrypted: i=1; AJvYcCUjzf40z3j05QepsbMlOHjSiil+6hMBU75IzrGOlQJ9FfYOaoUXHwsFCwS3hcCmHunrOTqO6lYP1gfvxMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ex20yZcLnEhuPBdTRKDEKVTh7bopqDOMyhyBw2vxSEsn1d+X
	hR/LI+XOaAbCz/nSgccHBWumXHpvnD+W/4sP1+SxeZsFXDb/EUFAqQCTysvgA68=
X-Google-Smtp-Source: AGHT+IHarjmcG5SOG2UGfwxdr6/AxJKyyOUJZwOiJi9PYkdpyAMO388rpte7wKVQUeAKOJIsDpfwDg==
X-Received: by 2002:a05:6808:14ce:b0:3e6:1fb5:8f50 with SMTP id 5614622812f47-3e63823e27amr12237373b6e.5.1730236739578;
        Tue, 29 Oct 2024 14:18:59 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6325b87ecsm2280559b6e.54.2024.10.29.14.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:18:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] pwm: export pwm_get_state_hw()
Date: Tue, 29 Oct 2024 16:18:48 -0500
Message-Id: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhRIWcC/x3MQQqAIBBA0avErBNMCqqrRIjlpLOoRCUD6e5Zu
 /82P0NATxhgrDJ4vCjQeRSIuoLVqsMgI10Mgou24WJgLu0Mb3f6+KU0GGWIKqK0ifWL3ppOD6r
 lPZSD87jR/d+n+XleHq5AvG0AAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Guillaume Stols <gstols@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Calling this v2 since it is a revision of the first version of the patch
from [1]. I have split it into a separate series since the SPI offload
work will likely take longer to finalize and there are other potential
users of this, like the ad7606 driver that I have also included in this
series.

[1]: https://lore.kernel.org/linux-iio/20241023-dlech-mainline-spi-engine-offload-2-v4-1-f8125b99f5a1@baylibre.com/

---
David Lechner (2):
      pwm: core: export pwm_get_state_hw()
      iio: adc: ad7606: finish pwm_get_state_hw() TODO

 drivers/iio/adc/ad7606.c |  8 +++-----
 drivers/pwm/core.c       | 40 +++++++++++++++++++++++++++-------------
 include/linux/pwm.h      |  1 +
 3 files changed, 31 insertions(+), 18 deletions(-)
---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241029-pwm-export-pwm_get_state_hw-8bdf15d9a408

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


