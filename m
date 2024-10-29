Return-Path: <linux-kernel+bounces-386534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C89B44B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F691C21CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900C204099;
	Tue, 29 Oct 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CxNak1L5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC97204036
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191568; cv=none; b=uoqqpYU02lluP8r3Sl0/tTlHBFXVsT4G0g80pk2yF25r9x8UiTspoe0oMkO2njBbHZ7sWJGPvHxnIJFdPI7OcTHts8sy5H4UUQHV/zGRK8P0MjZPfwMG3Qnxx0gIDn4UV5tivzeIdSENeGoGr5fkxF3CsnDj/orQzrArabyPjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191568; c=relaxed/simple;
	bh=oMsPeNDPYjX24/xrsdIKUnroAYKkElkCjISZqScZwOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHQGERw5YPqPdYM+ZqAUDwQx/xw/VZF0MzIFizeUVcdJK7+rdh9tylRFUNBdw51yeghJo1UIWg7vbCG/w9WMV93JCfQGr4g34FBCemw6cQCpmYVhmBLpi+CgrSgE7ykLtnho57TG1oZLl562UCoerF+axlEVdL4E94TSZm1qVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=CxNak1L5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1138554466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191564; x=1730796364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgWCepazzfo33UdtIIMN3k0wsxQsDr435va3n4Xr8tQ=;
        b=CxNak1L5JQf0Yt56A7ip3UAPeRZSXzEMbKxHWHOR0H7db/CrB8pYS/Y3PYLtDo0mmK
         a5eBiGMuoMqqLPh1iLfAhycSWZXgC29Po0z62ifisHe89n3SbtNEO1oW/IPz5IcaC2Qi
         jVWOLkMDuraD04+Adjqh3GXhzxOTjY1W/Cxlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191564; x=1730796364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgWCepazzfo33UdtIIMN3k0wsxQsDr435va3n4Xr8tQ=;
        b=MOHfSyjeLjsnZlxwYyLRtLhbwSLR9gBawyrovr7VOPZ56aR0Lbba3Ocs2PQz58fb3l
         c+/a+G+glxGelbRCnaYkDu4fwz6gVAjLqwUbc52l5ZY9xQQAyc25ngmQ7Re/uEK4+XbM
         TAIHiUpGDK+6hcgK8g80fWbjWuQVhzY7IBAHgfRWaH1Rr4C4EGCJVy/hXlEnsG2aUGcu
         Bt6/cYmr5vwFG9EKGESOnGOOeMLuxVrUyo90hdXNRe7u2KoOA3G4U7FMhCzR6SKFycJm
         vY0huzXV3kLAT3QI0uYGJnBt3EKM2DzzIxHMqD3UswjajxrxU5qtvWog3QUPmNn0SU1P
         6ckA==
X-Gm-Message-State: AOJu0YzBuDijWfTUzWu8TpzBR86PFyQAiXfcI3yq2uJi0AoeTeikToXb
	h+vK/ozcHQ7h3d3iK7+eqND+K6DyWcu9pc9hAsD+c3FJXMORNSzsYOYZFqIs5KFUPNBBQZ0fTnl
	T
X-Google-Smtp-Source: AGHT+IEPwkX0IhV+bKZax/ZDnKCtE6vuHXhCdpPupl5TYU7s9VlSPImd24020c4tF67SdJTKa0gPiw==
X-Received: by 2002:a17:907:1b98:b0:a9a:8263:d2c7 with SMTP id a640c23a62f3a-a9e2b347278mr87267966b.7.1730191564353;
        Tue, 29 Oct 2024 01:46:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:46:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Gal Pressman <gal@nvidia.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 0/6] can: dev: add generic function can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 09:44:44 +0100
Message-ID: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series originates from some tests I ran on a CAN communication for
one of my clients that reports sporadic errors. After enabling BERR
reporting, I was surprised that the command:

ip -details -statistics link show can0

did not display the occurrence of different types of errors, but only the
generic ones for reception and transmission. In trying to export this
information, I felt that the code related to managing statistics and handling
CAN errors (CRC, STUF, BIT, ACK, and FORM) was quite duplicated in the
implementation of various drivers, and there wasn't a generic function like
in the case of state changes (i. e. can_change_state). This led to the idea
of adding can_update_bus_error_stats() and the helpers for setting up the
CAN error frame.

Regarding patch 5/6 ("can: netlink: extend stats to the error types (ack,
CRC, form, ..."), I ran

./scripts/check-uapi.sh

which found

"error - 1/934 UAPI headers compatible with x86 appear _not_ to be backwards
compatible."

I included it in the series because I am currently interested in understanding
whether the idea behind each of the submitted patches makes sense, and I can
adjust them later if the response is positive, following your suggestions.

Changes in v2:
- Replace macros with static inline functions
- Update the commit message
- Replace the macros with static inline funcions calls.
- Update the commit message

Dario Binacchi (6):
  can: dev: add generic function can_update_bus_error_stats()
  can: flexcan: use can_update_bus_error_stats()
  can: dev: add helpers to setup an error frame
  can: flexcan: use helpers to setup the error frame
  can: netlink: extend stats to the error types (ack, CRC, form, ...)
  can: dev: update the error types stats (ack, CRC, form, ...)

 drivers/net/can/dev/dev.c              | 45 ++++++++++++++++++++++++
 drivers/net/can/flexcan/flexcan-core.c | 29 +++++-----------
 include/linux/can/dev.h                | 47 ++++++++++++++++++++++++++
 include/uapi/linux/can/netlink.h       |  6 ++++
 4 files changed, 106 insertions(+), 21 deletions(-)

-- 
2.43.0


