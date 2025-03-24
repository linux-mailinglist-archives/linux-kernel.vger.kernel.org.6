Return-Path: <linux-kernel+bounces-574438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27DFA6E56A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F23BDD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5A1F1312;
	Mon, 24 Mar 2025 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="a5EijJrJ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26A1E1C1A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850665; cv=none; b=st2ifErfAjBjYKVW32eC+bD7yu8FvrdNSGtja62cxMqJRXAMIax8zN5Cdl2E/jl3TJ/yEsIfyddTysht92VOlh9VUaIA/UIj2UK178v8nqz8Uk7W63HfqH7JxuliT9sGt8Ts9nPFRRCMZCGAHH/rerC/ltvFWxOuqhhzLj3Jy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850665; c=relaxed/simple;
	bh=x/QWNNdQ84ZdZZgbi2Ug1TQkE5jLOUSlBi3kXHYTJnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rtpc9DPKGioHsPgPteEdNRdzEZaVOu+doLO5Kb8gvw41AtVfYQvgnPAxuqpRQlSwAun9WuUbwInRJdWam9lGSYKK1Jw9GTwYEWmI7guo46MECqi5c8IkkyLvAx0oziTKjQIPFNzhUyGW6lummetbc7GCPMFxrIcrFrnceXk1vMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=a5EijJrJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso8758470a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1742850661; x=1743455461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmL+riJd4lYn72ibOTR8bk8FMeky0ZyyKRZN5rYZjVk=;
        b=a5EijJrJbgCxGWTotb9FEIZCle8Brg9mBTEYZmZcHg48wAN/wvhSQXN2jzypGUaZVt
         7wwHNqkg+nbOQkyw01DBV3HF18mjsxpcNGft4M02OvFBjHxN0ayPZWTqKqUTrS0S9jY9
         4yhpDfQYCWQ/xrgaGVNjuzCM3sAXpg/6+tsUukogPVZgq6kcDfSCW1yRXJ11vyGBM9tj
         vR/g2RGEd3tzAgSHlEJPesP06Wgkxc2Bap++3Jno8GwwSjexHrKiAIHOe7dWOWwQsJBf
         3Bdp8eVHBYMnMD+49eWwCNnUZjF/rrgED+JEt91b4U2T8hYUMUjIIyVDUDD0hS6zJuc+
         8rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850661; x=1743455461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmL+riJd4lYn72ibOTR8bk8FMeky0ZyyKRZN5rYZjVk=;
        b=E4ZmbQfJqwc/lJ7wR+vO6xmNJWTe/C3uWVBmw/eIxpOVbJpEdqVnhyPjM8tFNb1Lrw
         Odjg0a1KnfR3BRsxGVHu2qggK8rNwKMXOsr9AjbqD+pJY0yCRTvP0v8KlpulCFIeIRHE
         0gH+vTDiEvvV0SWL0oS1N0RXC6Q+FI7Xr5F/B8aZo7g44akFcUY2ZLW41OsDEhlX66+L
         ZWTbIrfweo4nKkPYlJ+8ko4yvMjx+eafbyuppV1IEbFJlZEEteJe/Y2nkZ4SBxjrmzr3
         TxyM38qNn6T2XebRNMu3Ihwmf5zkrGId5w2J1fUGpUidHER4CKHo2nL5RkFY4V6SrZva
         EbOg==
X-Forwarded-Encrypted: i=1; AJvYcCVjjUP5wy+tsqg0RAGlVW7SEjLYryUHYevZTPFg6LR9SnnG3g7yNECeBMqZUQOdNg5pwEeNl3ZBJlbXN0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNinGHNvbjNby0XOV/HP6KVv98o8EZVnv4ZLTGVK9Ckt6m4Gz
	CeWj4AXuPf/syY9RppWK2fXUZQVmc/VTpNcD6ugSQa2e96o4+oUqeLQW98hVQ8c=
X-Gm-Gg: ASbGnctivNBcehFbXTTsgaefNRiNBoF+m0Z+tZacGJKyrcRRTHPboU1Zu96Y8JJ4FJ1
	C3quijKbfO5b0J7XLYVeZA3Ms5vUfa7IEY0BHq+sTiObXzcYYlEcs98y7168bYva5v4jPkPtiWM
	DNa1HU3R4xCuLqiMq6q5fIsjsxOMLIsaC0BDlcPu8cUnPpsxf/7e3altfjN5fjp1ksmof1F3gLx
	cAmc4QAs00rpjt9ML/DGgldm2Q2C1qhz3eENXaEaS/lfAFPIwohm99NUdTlxy67ccNpu7vtZ9ei
	iFdYl8lkxayLA7ed2FJ1Pfu09vp+Y3WnV7zTZ454IHxyVtpS5UlvlNJt5PJtDFTRUguwKda5KJB
	7jxOzv1zB4cdf
X-Google-Smtp-Source: AGHT+IGJ5Jkgg8cGpDgOqjr54pJZGIZgx+uLuozmAB5iji1PofNCt1obvYaUo/uzYo92PG04DdE6Bg==
X-Received: by 2002:a05:6402:2753:b0:5d3:cff5:634f with SMTP id 4fb4d7f45d1cf-5ebcd4f3255mr14044465a12.24.1742850660772;
        Mon, 24 Mar 2025 14:11:00 -0700 (PDT)
Received: from wiesia.conclusive.pl (host-89.25.128.123.static.3s.pl. [89.25.128.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0e0cb6sm6537097a12.79.2025.03.24.14.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:11:00 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>,
	Artur Rojek <artur@conclusive.pl>
Subject: [RFC PATCH 0/2] Nordic nRF70 series
Date: Mon, 24 Mar 2025 22:10:43 +0100
Message-ID: <20250324211045.3508952-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

this patchset introduces support for Nordic Semiconductor nRF70 series
of wireless companion IC. 

Nordic nRF70 series are FullMAC devices, which communicate over SPI or
QSPI interface. This driver provides support for STA, AP and monitor
modes, in combination with up to 2 VIFs. Throughput of up to ~16 Mbit/s
has been observed while using QSPI.

Patch [1/2] adds the nRF70 driver.

Patch [2/2] provides related Devicetree bindings documentation.

As this is our first Linux WLAN driver, I am tagging this as RFC and
looking for any sort of feedback, before I turn it into a regular
submission.

In the meantime, here are some pending questions that I have:

1) Nordic gave us permission to upstream the firmware blob [1] required
   to use this driver. As that needs to go through separate
   linux-firmware repository and is subject to different licensing,
   should I try to upstream it in parallel with this series, or does it
   need to wait until the kernel driver gets in? 

2) In AP mode, for each connected peer I maintain a pending queue for TX
   skbs that can't be transmitted while the peer is in power save mode.
   I then use a wiphy_work (nrf70_pending_worker) to move the collected
   skbs into a single hw queue once the peer is able to receive again.
   This means there can be multiple workers putting skbs onto the hw
   queue at any given time. As this scheme relies on the wiphy_work
   workqueue, can I assume that multiple workers will be able to run in
   parallel, even on a system with a single CPU? If not, what would be
   a better solution to the above problem?

3) nRF70 hardware communicates using byte packed, little-endian
   payloads (documented in nrf70_cmds.h). As these can get very large
   and complicated, I decided against writing some sort of endianess
   conversion scheme, and simply dropped big endian support by this
   driver. Is that acceptable?

4) Please put particular attention to the wiphy configuration. I am not
   100% confident I got all the flags/features/band caps right.

PS. checkpatch.pl spits out what I believe to be a false positive: 
> ERROR: Macros with complex values should be enclosed in parentheses
> #5914: FILE: drivers/net/wireless/nordic/nrf70_rf_params.h:85:
> +#define NRF70_PHY_PARAMS \
The above define is used for generating the nrf7002_qfn_rf_params array,
and as such cannot be enclosed in parentheses. 

Cheers,
Artur

[1] https://github.com/nrfconnect/sdk-nrfxlib/raw/refs/heads/main/nrf_wifi/bin/ncs/default/nrf70.bin

Artur Rojek (2):
  net: wireless: Add Nordic nRF70 series Wi-Fi driver
  dt-bindings: wireless: Document Nordic nRF70 bindings

 .../bindings/net/wireless/nordic,nrf70.yaml   |   56 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nordic/Kconfig           |   26 +
 drivers/net/wireless/nordic/Makefile          |    3 +
 drivers/net/wireless/nordic/nrf70.c           | 4671 +++++++++++++++++
 drivers/net/wireless/nordic/nrf70_cmds.h      | 1051 ++++
 drivers/net/wireless/nordic/nrf70_rf_params.h |   98 +
 8 files changed, 5907 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
 create mode 100644 drivers/net/wireless/nordic/Kconfig
 create mode 100644 drivers/net/wireless/nordic/Makefile
 create mode 100644 drivers/net/wireless/nordic/nrf70.c
 create mode 100644 drivers/net/wireless/nordic/nrf70_cmds.h
 create mode 100644 drivers/net/wireless/nordic/nrf70_rf_params.h

-- 
2.49.0


