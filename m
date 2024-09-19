Return-Path: <linux-kernel+bounces-333317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0897C6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE301C2350B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F324199FA6;
	Thu, 19 Sep 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="Ydd7ddqK"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06F199E8D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737615; cv=none; b=QcqSEKR0fciliFoaw5cB3I45xc0hcN96BgAEpdO0a4X4CmfNJwrvxLzxZx39nZqbcoiINCad8tgEZUEu/Z8cfaNoIy+wRUMEbk3j5t3X5NFNnwoIBjNJGxi7D04hVvo/cRFOBW1fbRFT7OvesnDb0U5wLnVep+P5ITipdGZt8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737615; c=relaxed/simple;
	bh=5wMDB4OPz3COGTuM93h1ILfXitqkNNaHdStkIY1/6/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kPzju4NhYF8pNMVh2ccPnhUmevLUALHZok+gegxDFvWDDdK6g4Ktu0pqq35fivXDtML8jsd/6R1LjpeqHwjVrZMrDJ3K9D5fiGwLQNcrhVxhjsLERYJS3Q0i/PL1TA0uyTJbZYuYJQNpAjfLOpuITwIuD1dv1weYMlPpgNCGGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=Ydd7ddqK reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vPt+To74DmgnbmEWmfloIsf609b19hv6wfExzjJ4nZ4=;
  b=Ydd7ddqKjYj3n2S07UPez4wHhS4zZF3iqe92rnPHXYtgfeTFUzdgOFP0
   e1cuOGPFHKB7WR+dTnLut0EIakgrbcTUbvHnhnmBnoaWJy34X7E1Zb+wh
   qPrjg1i89uKWCYe++SW1Pk21AAJUB0rgD+aXnmBhSaCLcIYCZ+jhB2s/N
   d9c1nTpN7d20XqS0dQsazAzQKC7nsFZYQ1qKMk0CoRyOw9tqW1MCgoJ70
   L6JNUxheAubE/6zCZZ8NLmDEFoHqQm6crkmRpHwKyhHVI3mLN2oX0eojO
   IOwXvjmN+8Ovlfljl9lwPodfu+CQ1mEMK6MqOclBY3gNY62r955lPcLxa
   A==;
X-CSE-ConnectionGUID: RAeOzic4S0q53+pWpFKmAQ==
X-CSE-MsgGUID: dlSz94oyQpSJGhD2MegUCA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 19 Sep 2024 17:20:10 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48J9K4AY051461;
	Thu, 19 Sep 2024 17:20:04 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 17:20:04 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, "Hermes.Wu" <Hermes.wu@ite.com.tw>
Subject: [PATCH v1 0/2] drm/bridge: it6505: update dp aux function
Date: Thu, 19 Sep 2024 17:19:14 +0800
Message-ID: <20240919091916.1484-1-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
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
	ED49CCEF2B8117D7D54482B1CBE584045A64E892F10997E0EC16F39FC91376582002:8
X-MAIL:mse.ite.com.tw 48J9K4AY051461

From: "Hermes.Wu" <Hermes.wu@ite.com.tw>

This series change aux function to support MCCS and fix HDCP CTS

Hermes.Wu (1):
  drm/bridge: it6505:  Add MSSC suport

allen chen (1):
  drm/bridge:  it6505: HDCP CTS fail on repeater items

 drivers/gpu/drm/bridge/ite-it6505.c | 343 +++++++++++++++++++++++-----
 1 file changed, 292 insertions(+), 51 deletions(-)

-- 
2.34.1


