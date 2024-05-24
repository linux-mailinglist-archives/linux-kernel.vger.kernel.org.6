Return-Path: <linux-kernel+bounces-188399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8718CE186
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DDA281F22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142881272D6;
	Fri, 24 May 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hjOwmlws"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016328625C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536003; cv=none; b=f6m5gILYC1mCjttg1qQhIjBMeaHa+z/46sXVMtah/Wz8lyslxUL/QCFHyUAKMt60kPwRKLojJCJzLLj9vZr/y/tOPxd+0uwwZZsF9kK0vHKFyfk7EftbpS8MJM6LXwFPmGyMAuAQO3o0GLf6ZIRfltanGEvx4CplxRzpy7iIt0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536003; c=relaxed/simple;
	bh=DMe70+xhBoIO89Uo3abpqRhb+WCdKaNqWLH49X38skM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mIan78ZGBrEHDhYxqQxprD6wAtNys0cAWKGNLNa+gQMqkygW7kTFshLTBmGRZGCjhb0KDX1zyW6GQPiLQcF/AnSQyhcqwdq6GWbbELrUofo9ECAOu3MHFLlSqpRS6xcMNV3Jfwb6xNW++k4mMFJBhFA2JGdjW3Y8FuFRNvqUTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hjOwmlws; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O7X650044481;
	Fri, 24 May 2024 02:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716535986;
	bh=Hs5v3WOjE+iyvTaBgZAItEGIUyDtSVd+UbScrF+yyFo=;
	h=From:To:CC:Subject:Date;
	b=hjOwmlwsqoOvz4PMf3lUoISgg6iNhBpghqEDsuG0/DLqjVl7jRx5LTat5RlPyXKrP
	 gROW5h4v3Vw5bKX+HjAGQmKgIBJyXGJ5gZ7Zal657T2hvwB4Bu4SnXt4MSApltCnm+
	 8V+k3hUeSKbXQgx69AVi5WteQCMcz6KteCHoZHwk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O7X6Tq033554
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 02:33:06 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 02:33:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 02:33:06 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O7X5dq121659;
	Fri, 24 May 2024 02:33:06 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>
Subject: [PATCH v2 0/2] Add mode_valid hook for sii902x bridge
Date: Fri, 24 May 2024 13:03:03 +0530
Message-ID: <20240524073305.107293-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently, there are no check to validate the modes in the bridge.
Add pixel clock check to validate the modes that the bridge can support.

Also add the mode_valid hook in drm_bridge_funcs structure to take care
of the case when the encoder attaches the bridge chain with the
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag in which case, the connector is not
initialized in the bridge's attach call.

Also add this check to the atomic_check call as suggested by Maxime in
v1 patch.

Changelog v1->v2:
- Add KHZ suffix in the macros to be more clear
- Add the hook for drm_bridge_funcs as well
- Add check in atomic_check dunction call (in a separate patch)

v1 patch:
<https://lore.kernel.org/all/20240408081435.216927-1-j-choudhary@ti.com/>

Jayesh Choudhary (2):
  drm/bridge: sii902x: Fix mode_valid hook
  drm/bridge: Add pixel clock check in atomic_check

 drivers/gpu/drm/bridge/sii902x.c | 43 ++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

-- 
2.25.1


