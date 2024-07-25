Return-Path: <linux-kernel+bounces-261613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D1293B9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7731D1F23E56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6446B8;
	Thu, 25 Jul 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk2drqhw"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB27139B;
	Thu, 25 Jul 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721868483; cv=none; b=j2YTz62G9y/aMM8UflU5jl1uVkQNl7DDZbakhXCpECHkapbhSTNosThrWwrdjFg/wnLsaPueaakX9W5EY7uBFIsKjSn3HrsZ4ayqUv5lyW2uXEX96Z/pdtIhUzEY87QA9eVGeppttuCQXCPbST1UW6+D0Zg3rmaaO26SQffbaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721868483; c=relaxed/simple;
	bh=yxIZcJsJmuqolbROCdFHCZAUkoVGiMNocSbQBZmgpf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbkRy4hxoPW5P1/AOCm15lZONqZLydP1qutzgSgr+VEBEcjNuGTy7wIEipGhF/LSyCLDE+UZPt6uGQrQMLFiRt+xDbfFQ4EOkAhWURbhz1uSyLQHwdlQbloyh4ukiBPtOygDSocniUE19HkFTQqYXgIQsKHRLOaBgt+EDeYGbOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk2drqhw; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4928989e272so130569137.2;
        Wed, 24 Jul 2024 17:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721868481; x=1722473281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHKWUDPIV4clF6YOoBaSMKxb/Zv5MDSd4xPKLGghseo=;
        b=mk2drqhwNoHqy4koZjAH65U5ayPmOUyumPul3moJZX/Paxnn+1V/8dXKC75U4fofhv
         HoosSIeWejY49kMi9znMIM+iJAkjlHhd+FIo/106zYxuQaL9lnvRYqfs8GyCfFwWpgAr
         BHUgMjF7AkhJ5DW77HSyZVXMg6VymZPY6mwiBH94503cxCSZeAefPAWvsSnuAJo/Erde
         ZHBUoPfeHEvjcOO9v2pNhz4G90JdMQjYjN0W5j10tXJpflUvOXbt5laHp81GmNP3BZX6
         WAtOF1D0cBNzNe5+1Osf1CiVzoYJaKOdlaYPjg40jQU/++08kRuSwT61MXRT5pP05nSw
         Kkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721868481; x=1722473281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHKWUDPIV4clF6YOoBaSMKxb/Zv5MDSd4xPKLGghseo=;
        b=hsU/gFOVgRYBsk7HKecCtcRD0ewdgGm1Oby3E9Y9PBXxbbiUzrVoOktJ6c4Bf7PFi6
         kF3NsgcXVGte2sEBgugt87HCku6GIQSqgl+PAcZlmIJrkAFx9qwT7oPJZXIc99+WRmBH
         Oeg8HD/ytBnmI9m2SnDoikAF6/6/O+Mek6cOmYhQPthvDaSVPNlXQjpP5l2Vm/B8vFZQ
         mL/UuI/lcO2bkKlawykmipW/6Pdb5TQjml4b9Dmaoi18EzrAjRZ5oWjKRY3wRhRbGVpm
         ulDsUhqrnWqsCDcPHgVlw9JQfA+9mEcRQivhmDVTyAkLmVqJZO77q+TVwYRjAxnsvzJM
         rQiA==
X-Forwarded-Encrypted: i=1; AJvYcCWX1hkWYR2IRzFzEQPzgX2HmrF8gw33ojIacMMJ3UlR9b9pmDxPua7AroXsL8GprMfabMU6WythIZBeTtV6l738dgO+OuSGWBh10QNO81YW4D1IhpmS5A1F/KXhvxkB3DZz9lDSg9DhQw==
X-Gm-Message-State: AOJu0Yx1OYLEECdXIqQJ4W3i0ce7lYHtc7hJO3y84/R1v59s5YL2+Fl6
	NRX4kVCYeXdUhSZ4S6n5DHdRlh+0e68plWr1Wq4TY95jeNN/KcuU
X-Google-Smtp-Source: AGHT+IEk+USncAJXYQ/qAoPZDDO3Y90etc9xEl5EV1x0/2+kl+CiyTfU1zbBKBON3fuy2iBElf26HQ==
X-Received: by 2002:a05:6102:3fac:b0:48f:428a:2379 with SMTP id ada2fe7eead31-493d65425ccmr1622793137.30.1721868480883;
        Wed, 24 Jul 2024 17:48:00 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d74353e6sm19339885a.87.2024.07.24.17.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 17:48:00 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: mehdi.djait@bootlin.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add driver for Sharp Memory LCD
Date: Wed, 24 Jul 2024 20:47:01 -0400
Message-ID: <20240725004734.644986-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add support for the monochrome Sharp Memory LCD
panels. This series is based off of the work done by Mehdi Djait.

References:
https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf

Alex Lanzano (2):
  dt-bindings: display: Add Sharp Memory LCD bindings
  drm/tiny: Add driver for Sharp Memory LCD

 .../bindings/display/sharp,sharp-memory.yaml  |  97 +++
 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/tiny/Kconfig                  |  20 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/sharp-memory.c           | 741 ++++++++++++++++++
 include/dt-bindings/display/sharp-memory.h    |   9 +
 6 files changed, 876 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c
 create mode 100644 include/dt-bindings/display/sharp-memory.h

-- 
2.45.2


