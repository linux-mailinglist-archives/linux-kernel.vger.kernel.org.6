Return-Path: <linux-kernel+bounces-188560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9189D8CE394
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6362823F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20185628;
	Fri, 24 May 2024 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nurBZOw7"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507DC85272
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543332; cv=none; b=dzu1QH/pbD7lTwYpUDRvwuOMkgBBOm3Bw6Bs9ZnA3KDDWvJyJ7DDwGTfsBCIkqBTr0ODJiFm/KaNEdjWRX65vW1Wi1+Wh84vKn2FYvBhkpQnW4LMzzNFYLdoGXY0ywDXni54mWe1JO+a6nSnJNEdI84/ABoWyz9EeiDF92o4XHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543332; c=relaxed/simple;
	bh=wmyJNeDE8Fz8mOGzmbzTS3KZQkyuTkwlsaU3KPEYjsY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s0/J+WOezyX9KLx9duUfnsMJWAK5c24W3C9R7c6+Db0jCCUWcyeTFSuOiQ1eyW8pNbn4itXl21fZDsugo3KFDWwtibUsfjbH+4Cv39ttSofh8aAe6zs4y02tj2QnUC3i+BpXL2XWW6Ck8d4sUivcSuxu2BtRRAq5WVsXTREmX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nurBZOw7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O9ZBKH007431;
	Fri, 24 May 2024 04:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716543311;
	bh=rsYvHGCDHB4V1mOmaVnCjAvN1QUmRTqGqmwmU0aE0cQ=;
	h=From:To:CC:Subject:Date;
	b=nurBZOw70arpuTbCcL2NNx5owa7uq9t/uJYSuXVuEVmKNgtA0XrWx9qR4Zpkp9zN+
	 9WUJDU+crHagP+Hczv6G41zPWepp/2wF8jWiVi+EGggNk3OS+y8sBXMYKpPByeFs9C
	 a8o53FFueThIdOpFQ1je9RdlvoSDdWLs1E3FznOM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O9ZBgU053938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:35:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:35:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:35:11 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O9ZAXD060455;
	Fri, 24 May 2024 04:35:10 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <sam@ravnborg.org>,
        <mripard@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>
Subject: [PATCH v3 0/2] Add mode_valid hook for sii902x bridge
Date: Fri, 24 May 2024 15:05:07 +0530
Message-ID: <20240524093509.127189-1-j-choudhary@ti.com>
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

Changelog v2->v3:
- Remove newline that was introduced in [1/2] and later deleted in [2/2]
  in v2

v2 patch:
<https://lore.kernel.org/all/20240524073305.107293-1-j-choudhary@ti.com/>

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


