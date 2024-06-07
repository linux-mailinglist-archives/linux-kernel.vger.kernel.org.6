Return-Path: <linux-kernel+bounces-205551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D268D8FFD5F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB1FB23529
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A42156C49;
	Fri,  7 Jun 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VRJ8866w"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FA14F9DB;
	Fri,  7 Jun 2024 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746144; cv=none; b=M3fAdvLgFuPIEcco+L6iU/W6GLOkN7jvnAf/O+7W4kKrMGSBc5zafEWseLgRPzYBJxpTGMFY/mLMadjf+UtLP9vDvQanWYfmsKet3vgzmwz8zAdGHztMFuE4bVgRRVrR+OZjlePIgigm4EV4BuaIAPumjXffRl7pZ96oRH7vwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746144; c=relaxed/simple;
	bh=5nyKyZ5l3oYQyopuRxLzLGXUF+zt0bA2UFBs5Qu4qU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=EgQOG9MM0pZyIONKaqlftChjxzJK3Vw6ZCU0wE/PEZhwA++u3MF8JW+FgljxgirJRaiw7d6Zs9ioRsC44gZ7IRIUqJtNNb6HX7vJjH5j7nDAEwZ4sdFbLBeGvBv1JMoCql6MIvEwATOmE58kOMWKMONBRaQlqyh4s5wxTIcT1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VRJ8866w; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2932B60005;
	Fri,  7 Jun 2024 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717746135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jUXXvNXe+C/jOh3YV5VxVlFc3LXkrVLLL3kJVjOEtK8=;
	b=VRJ8866wn3K8YBYmquleHT2DsHFIAGUoc0ZefQe+tP1DHkSi9OjqSZSyGkPD2BDVuizoYF
	JQ8HdTfmzsBC1qXGuyEcuXZ3MPOh4lu/UG2hL499U5B58gsvRVCOAXqntUqDE8nAKSTsyZ
	eNe8IYdGZqa8PXB/BDzh83C1+8mt2SomOCWOGRC0jY5Z8Nqke0rCRaOywyR5qytiPSVuXT
	tHizYac5fKd40IMedBLxid+Q2d6mBh7lZ9w1zXTQGiMPdoJ3+BYU5Mx0AkAZE5riMxOl2/
	8VsENiqcvqn2N8BW4BAYl0ju25tp6nrdEclGA8Ufc5vgMBhwZtMOuWhguTJGWw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] ASoC: dapm-graph: add component on/off and route names
 to graph
Date: Fri, 07 Jun 2024 09:41:50 +0200
Message-Id: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL65YmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNj3ZTEglzd9KLEggxdi1TjNHMgTjGzNFICaigoSk3LrAAbFh1bWws
 AhDPSuFwAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series adds some improvements to dapm-graph in order to produce
a more correct and informative graph.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      ASoC: dapm-graph: remove the "ROOT" cluster
      ASoC: dapm-graph: visualize component On/Off bias level
      ASoC: dapm-graph: show path name for non-static routes

 tools/sound/dapm-graph | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)
---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240603-dapm-graph-8e3f7e3fd692

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


