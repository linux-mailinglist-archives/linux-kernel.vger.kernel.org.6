Return-Path: <linux-kernel+bounces-364322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118499D275
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18B21C23C89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982B1B85EB;
	Mon, 14 Oct 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WdIpZPHT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E401AB6E9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919486; cv=none; b=APx+58u4JtvvMqLMr3t505UynIjk1wWXIrW1FFGZ2xbldiM+7IHa6me4fSqMNUm3NTPO/TO9je8RIwF0xJUsC9MNYyXeSAZyExzz2VrklsEKdODSAuEs/22c7oPnyT7YeEb88jCYjiru6qG5kpNIHIwH9rmuW2r7hFVQQ73O8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919486; c=relaxed/simple;
	bh=osM0SsiL7+DjY67zsotBo2EwvCgI73VTuRd5U5RUods=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R36voWG6NAbtbl0ffsyhHAlCvD8gsILLTR3TiTNk7zXCj1rjcEkdcubRnPVp6UNgbrlnqp9kAoQIYclb/JBhFaktcTo6UVbOFHSBrfBaPrtoAfspaXSbSieswl7KmJsIfsdkdDl+mqkNOMVQp0fJD52MuVH7LzvmzPHbLEXsiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=WdIpZPHT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4311ac1994dso33648035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919482; x=1729524282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D33ySCQEEZZa2JOT2vpA/ZgBa7niJV3Ivx6AjZCV87Q=;
        b=WdIpZPHTjX9mEt284aryFHfwm/+t0lKeN8Nav9w1yOazIKN/IFZwEEZkd7iedf+0tJ
         LEsd8ldv+TYmZW2zVRqOA8H70HtqLgQ7ZCee34iH1Nz4784J2ZS0HRMWqL0bwIIWaZ64
         Sd/uzslUAzJf84jrigpsOYlhY+XwykZqI5hic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919482; x=1729524282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D33ySCQEEZZa2JOT2vpA/ZgBa7niJV3Ivx6AjZCV87Q=;
        b=xLvuj0QIvPafn+hNjjjNmG3yNXSxIglS5p3kxyENR9QmpGV592Hrocnast2i509Hv7
         FrtY0fRALt2ppLkAZyfTYauTBB3iWTcVWkNw3xfktHXG1cdXDell4kUAuAiATF49a9YJ
         7FtjcLtfNDA2QqmAMZg71WXfmv8sYouVMnB0a9th3FrsY0mH88FmyGyulY0UIzj0kNpW
         3HaVaemZbpiN/OhcOc9hj9wl5GmD0mrtJS4gnBsytljdHkgK852zMwa8DwP0uIRrplAU
         CydLPk+A5ekqQv4l4USzxsC0KAzOqqRfniDQi4YEjf1ABr6a56d24SD4swJSe/F2ecan
         MNdw==
X-Gm-Message-State: AOJu0Yw68WKZ0FSXWIgISEUdqZpXPnMqfbveXojYv8wVVIDk1zfFqmn+
	AJLn14sZ7B3615YdWE1snoXTKedoLO+N5VTF4AD9U6fgOh2A9Yf6CgHU3E7Wr1r4BwxLyO8dQ26
	EOMY=
X-Google-Smtp-Source: AGHT+IHZbPSHNODLwIpf3ihIfmm5LleHA5VM1GXgzzTbTTqB2g1893n6Bkgh807gi+6zv4o8URYqqQ==
X-Received: by 2002:a05:600c:1ca6:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-4311ded1fedmr101405435e9.10.1728919482368;
        Mon, 14 Oct 2024 08:24:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:42 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Carolina Jubran <cjubran@nvidia.com>,
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 0/6] This series originates from some tests I ran on a CAN communication for
Date: Mon, 14 Oct 2024 17:24:15 +0200
Message-ID: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


Dario Binacchi (6):
  can: dev: add generic function can_update_bus_error_stats()
  can: flexcan: use can_update_bus_error_stats()
  can: dev: add helper macros to setup an error frame
  can: flexcan: use helper macros to setup the error frame
  can: netlink: extend stats to the error types (ack, CRC, form, ...)
  can: dev: update the error types stats (ack, CRC, form, ...)

 drivers/net/can/dev/dev.c              | 45 ++++++++++++++++++++++++++
 drivers/net/can/flexcan/flexcan-core.c | 29 +++++------------
 include/linux/can/dev.h                | 28 ++++++++++++++++
 include/uapi/linux/can/netlink.h       |  6 ++++
 4 files changed, 87 insertions(+), 21 deletions(-)

-- 
2.43.0


