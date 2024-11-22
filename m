Return-Path: <linux-kernel+bounces-417950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B79D5B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B8EB2205F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C22198E7B;
	Fri, 22 Nov 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="fLWB6DLX"
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400B188588
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264928; cv=none; b=XlXFGoXedyDy2791pazFzzJmW+FE/nM+SRFLtFKUGhWOhTnRifNwMpkLn96LN9wJPm08xJqFqRjYsscpRSihyiNtvD5KRnHEw3q3zmqQFfIRGF124UEVlCKGU/1R/wqRFokNx6vU+KAxslfr9AZw5cGWfVc2P8k1Q1QIWSrVCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264928; c=relaxed/simple;
	bh=lbGB7IqyGqRJnbeGbuDSS1RlVZkgBlJN4RI9PK5cJOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/P/eqsgUvzqyWANUapyAw4j+NBzzEjFrapG1qqyErFHtZQmD36iTrCIGhNr9gV8m30osF96DQL0aWwoLsOa4m9GuC4IH9gen0MbXIjG4EG8Ab6LHjkuC5AcF+SpVONs6KBRCq2SdMb2/f0HkOf1PWfugkMNg0uGRfCsm8As95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=fLWB6DLX; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-4314b316495so15824345e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732264925; x=1732869725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nGyAp1GyhYl2oD3HxN0dzLUQsgdlrr/vXHVyJmj6nM=;
        b=fLWB6DLXO7fihsjt9Zuq1RK5T4Opm61IhBJkjHUyMwjJymGzpC6pnAA9E8rn7K395L
         HLEd2xKkHrlNF67pWE/Vqs16Fu0i0WixEPCVbI129wI3COObYjyjSxz2svaMwTJOKDxv
         G/plVqU4It0EllPDPXbG3MDhAbQEWqjSaabiKfUJtobvnbIOGjlRabzAzRBb1oDbYM+I
         diK1ndVVbNd5/yYeCmaHUlj/bvHNEtDhcYnixahh+OMDUMZoIrYEXtpFstqITCfLu/7f
         JdclFWWNAG2ChQGM04tlF+esR7WDyGrR94qYTFMoRj0QQo4dh7iL18JZ7n5g6vy0PT3w
         5Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732264925; x=1732869725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nGyAp1GyhYl2oD3HxN0dzLUQsgdlrr/vXHVyJmj6nM=;
        b=CR/VL6kt5EEiVCpJB20Q0kVSCmDFzQXFyu10QMCQKgG69Yw5m9Jc/ooutcDQfTKKFr
         QDMZDUytV6yy0i1V93POhSKUKSTNaIkbnyJW84OGhfwor44Dfw8op2d+Udm7mYnI53e4
         +avEc5ijU+YuAjARacfEZ1DOyeR035TDe7/7ufXtqSrXjhVzpebrr7a6hzKgaiCXaFK4
         Ie6iD63S3NvnGssM2Agy6ZGZDIWh5NyNf6Jm0xCV3BpPKX0X6Gfu0HkPdTr0czpWYEot
         6kJ6Foba23XtU6tDp8iwfU3ZASE9kz4yA2Dzr+pROge3fTIVYIT7aITFnVnjvI0jv9H+
         zDww==
X-Forwarded-Encrypted: i=1; AJvYcCUVWoKkxRftmrGUpvIg92s8K5NDTzH4XGiWXJTUN4cQJ9SxlxiSqOSL+h6V0coQHfar6TE9vPq2Q18yPsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObtG4AhZfhqQmRzxtVlupvUeCzNauPpsbvQvu43jN4JTBQrD/
	jwFu/SAXVogH83GErjEKWFi84mqudzzED03ZTpGwSRjU8g1VLzmfxAeSIjYRUXsGjH7WOVhnf+t
	Ahdw65tsMBkQXi8AQgbFxqalabKnzDMsu
X-Gm-Gg: ASbGnctESsHIlOqmVogEhRPE/+CNwnc8UppTtmUT4ycz6CqZVM2X7XXzrUuVnQxLx5T
	RyMg6BvrKHiqWEDVhgMxeJzzwerEMDqncQ5dfHCXJqZxya/dkeLfAI1xvMVrxGrd+YvoY8AGUQx
	jSbBgNcX+voII99uwS4g70uHTay6wfRbZkLaDW2MEXcGSXnmn7KBrX4nOIrk4+tBKc37KFAoNK9
	3VSXqtwKNPihbMbRIiMY3asSLcaBnIjASqfU/0JxNbFGf5llXr8vWYeUBfzYb71bg==
X-Google-Smtp-Source: AGHT+IGBo4ecTR47OQ69Kg2GI81fRJ/qHdvasgczFr52mJYtJ+jTJ0+xjnYcKX+CiPOYOl/EB0d0tWUhUZ4W
X-Received: by 2002:a05:600c:1c09:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-433ce4248f6mr14397525e9.8.1732264924627;
        Fri, 22 Nov 2024 00:42:04 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-433b45d1d3fsm3770515e9.25.2024.11.22.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:42:04 -0800 (PST)
X-Relaying-Domain: raspberrypi.com
From: Naushir Patuck <naush@raspberrypi.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jacopo.mondi@ideasonboard.com,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Naushir Patuck <naush@raspberrypi.com>
Subject: [PATCH v1 2/5] drivers: media: bcm2835-unicam: Allow setting of unpacked formats
Date: Fri, 22 Nov 2024 08:41:49 +0000
Message-Id: <20241122084152.1841419-3-naush@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122084152.1841419-1-naush@raspberrypi.com>
References: <20241122084152.1841419-1-naush@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When matching formats via try_fmt/set_fmt ioctls, test for the unpacked
formats as well as packed formats. This allows userland clients setup
unpacking to 16-bits from the 10/12/14-packed CSI2 formats.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index 36fb186a0421..d573d4d89881 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -547,7 +547,8 @@ unicam_find_format_by_fourcc(u32 fourcc, u32 pad)
 	}
 
 	for (i = 0; i < num_formats; ++i) {
-		if (formats[i].fourcc == fourcc)
+		if (formats[i].fourcc == fourcc ||
+		    formats[i].unpacked_fourcc == fourcc)
 			return &formats[i];
 	}
 
-- 
2.34.1


