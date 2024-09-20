Return-Path: <linux-kernel+bounces-334114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4925F97D2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BB1B247A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1B143C77;
	Fri, 20 Sep 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="Wm2UNUZb"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F713E881
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820724; cv=none; b=sfqnhKKOFM9z6mPKpmgndC9P9SBxVc4S75ekGJyEG+sUJQlfglZaVSC9boGZUqDNEldHNQ4gBDNL6cbtNTmlBehsF47zzAPiBLOISreg3gJIEF/zqgDo6ycD+OBndKz3ueQWC7SUEVq/KkC96mr+dbjhiqKszK8m1+4pRImvbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820724; c=relaxed/simple;
	bh=iYZ+C7M34RCZNZcRTIUI38AbczYVHsHA3GjoMKHO7vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0jqXrPT3IgaL5gbZ8DRxi36NRVFqCx/DUDr3/4WBZGBmaYqjMeCsgdUwBYEB0yUeShs5t/Qe2eqEDb5ey4Xu7S9MQFJuJ4E7Th4v9RyylV1wqFiU8ppS3pO1Yud57xljJiupSPIWlF2wA0xAUmOtIeaPUnYCeg9TvC4A1yGYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=Wm2UNUZb reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cyjl11zioga8O08AuDApD/N15POhIL8GuoayOO0MSJo=;
  b=Wm2UNUZbsSz0id3tz6Own3f/W5pCPXjxSiibgfa3GNdEHxKq+3q2KKa9
   lddEiIw8oD9tuiGexXbMyuMbyqXo/c/H1ODQIo6TJf8NK3vn8ONLGQjSs
   ag47Oeis/9aVY4G7gz8xn9s1rHlTYK0mY+25w6DBp87dGy1VUg9LKq1zR
   smY6goMpYgiTP5grCPKXRYKtgWorZfyhkRrabwcvvIRwS6NrhEPXKc8Ry
   w3YxpJt62ebYNMmqnMl5M9C5C0uZ0mmUWzufYIeRCaO9PNOxKb2QMfzlU
   MUbwuS2L9eECf0zlDgclC2/giLdIXFSzsvHyPAI3WrRLShzcklf3fDgHS
   g==;
X-CSE-ConnectionGUID: QQzgZHEiRKKggNelztubbg==
X-CSE-MsgGUID: FMVweCoVQO6f6/FH6Sj3MQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 20 Sep 2024 16:25:10 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48K8P4PY024274;
	Fri, 20 Sep 2024 16:25:04 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 16:25:05 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, Hermes Wu <Hermes.wu@ite.com.tw>
Subject: [PATCH v2 0/2] drm/bridge: it6505: update dp aux function
Date: Fri, 20 Sep 2024 16:24:49 +0800
Message-ID: <20240920082451.9240-5-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240920082451.9240-1-Hermes.Wu@ite.com.tw>
References: <20240920082451.9240-1-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPEMAIL1.internal.ite.com.tw (192.168.15.58) To
 TPEMAIL1.internal.ite.com.tw (192.168.15.58)
X-TM-SNTS-SMTP:
	8978556ECDD5E1C9AA890D66EB7EF1F768CDF67A36252FCE5C8241E842BC42572002:8
X-MAIL:mse.ite.com.tw 48K8P4PY024274

From: Hermes Wu <Hermes.wu@ite.com.tw>

This series change aux function to support MCCS and fix HDCP CTS

Hermes Wu (2):
  drm/bridge: it6505: HDCP CTS fail on repeater
  drm/bridge: it6505: Add MCCS support

 drivers/gpu/drm/bridge/ite-it6505.c | 343 +++++++++++++++++++++++-----
 1 file changed, 292 insertions(+), 51 deletions(-)

-- 
2.34.1


