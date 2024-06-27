Return-Path: <linux-kernel+bounces-232027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4959B91A1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9581F217E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EAB12FB3B;
	Thu, 27 Jun 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aNB7pXXR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="P6He/Ack"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267A1078B;
	Thu, 27 Jun 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477917; cv=none; b=VJN12KknKC4W2Hixbwvxg/nWs433LQZRj+bAPFwcISHi5H+iEswe0Ok3zMX9VUOgu68CpyVDHRT+1Dk3HVXgqxdSgQxkj2O8UUwcKEr7Ni+P2QZZHbxeE4fgd2sKOFllcrxs76ZYoTx5ouC1tiWgjzTW+awtUYUp2ZpBUeWADuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477917; c=relaxed/simple;
	bh=uPM2uk1Tp+ERIhK6rfJ3coa+sWzrd/Oso7xTfRFp8LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1qIkuVLakO43A2eF57c2b8J4DXeOUPAzKE5Wu+MxTT3F2oz332KAxi3RjcKNmhX3eQahKdcJPpuLH1TaGbGHEC4yKKQW7tHGD982QWFxvLPhkJuEqAlAbVvTSHlOFIQvoy/Jf3fg1SaQOcoo2X9sCa3LNAGgaoboF/RQp0XdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aNB7pXXR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=P6He/Ack reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719477914; x=1751013914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qKdL3I466UOarYENCEaVrpgGL8F7/4uronFKf9FxfDY=;
  b=aNB7pXXR1h+sqccDG4FeOyLWpt+6+/zvkXla8Fi+9zEEWzG+IsRglQiN
   Cl74zxNvAk6ZlguH3pMHxBuV2rvsWnR0YI4wu1TQCkhOG27r3MKnAexV3
   YL/zvfvg+xOryYMUn3ptK+MH9bu0zOn7fQ4OtLcsy9KmkaXOUtEkV9RUy
   KxUE7Ndi1q2QeowQoaTUy+vWv1rMSZ0zRBndEOcIejzvWw5wo6czc5Oci
   aKTDSFkLjlFrGuLjZRQB93L99x+Jm/XUXFZdtLqvdD5yE7kqfKt/33bU7
   h8X0jO8UuzZOb8gRdWfMV8OTGhZ2+T3nOe8ifzR1uvxiGJ24h4h6qbXE7
   A==;
X-CSE-ConnectionGUID: min0TWq2QR6LXSFkDkLoZQ==
X-CSE-MsgGUID: pWSdAYrKQwaYjSzI19zzCQ==
X-IronPort-AV: E=Sophos;i="6.08,269,1712613600"; 
   d="scan'208";a="37617935"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Jun 2024 10:45:11 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C9391643F3;
	Thu, 27 Jun 2024 10:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719477906; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qKdL3I466UOarYENCEaVrpgGL8F7/4uronFKf9FxfDY=;
	b=P6He/AcktrGJmS21zJh76T5I81o8oByDLbn7NG5niKlwypx72MnUJjp+p17D5cO12N+PB6
	RxcPxP2SBHh8XL6hsGVoJupCEg6US0tZcOf3KAELOOcW0LnBdk4wBUpUcas/z+6I+0jM/N
	h7brniKkrc8XdQZSQuRkoV7YknmDEcRH9ta3B75jGP5UWwyC5Iv7P91JntIIO12NrGtp3h
	P+wBfFuYTVEBZyc2OEAZn6D7msGPfg7CFLzCZnqvgZinUrdGb8zMEaCHLdnVsVXr/KqcJD
	N9QMTst6s+aoaEOWn7IBmCw5JzCbzltBGeDXVt6TvbRcJpICsQ+VMTGHsRqOGQ==
From: Paul Gerber <paul.gerber@ew.tq-group.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Gerber <paul.gerber@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add AUO G104STN01 panel
Date: Thu, 27 Jun 2024 10:44:42 +0200
Message-ID: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Changes in v2:
- put explanatory comment for display binding before the list entry
- collected Acked-by and Reviewed-by

Link to v1: https://lore.kernel.org/dri-devel/20240626044727.2330191-1-paul.gerber@ew.tq-group.com/

Paul Gerber (2):
  dt-bindings: display: simple: Add AUO G104STN01 panel
  drm/panel: simple: Add AUO G104STN01 panel entry

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 27 +++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.44.1


