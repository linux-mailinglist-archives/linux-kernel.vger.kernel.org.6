Return-Path: <linux-kernel+bounces-179727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BDC8C6449
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F82282C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DF5D8F0;
	Wed, 15 May 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="npYiJQdl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BD59B4E;
	Wed, 15 May 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766721; cv=none; b=idh9JtGqTWSUWQLVyM0NJ6vC9z9GhTb/8CAwm4GtWp7yrhQ6GZ16vGqMWZjLWUe1y6VBZ7xDB5fZ+SezqPYdmIrNgPMn38W5Wuj+BhTHpIbbx36+rgHUCdvBeuLSSkHHBS9PdQU/3Cr+9Br5Cb+oQzk8e8kSVMvZrTegTgM9jnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766721; c=relaxed/simple;
	bh=FQmJYe+t3TB09KQP5/OTgyLFe2UjzH7oBlp+18F57Y0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/tJU6KUA2akPjMCK3I3Qfoi4RtYEpgN+KLdTwGHUc060NBso2dW5sfeWLtHYJoAoVl3PbxUYgBZN7ZfqrFQn6v8lp1k7/+1GdGTGzpI62K9HXWXN7zeoQ9Pyvw/pAUDSLmxpRBXVR22tTtJCzVoKHNfWPU6frR+QqpUVRXbc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=npYiJQdl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44F9pZ3H021110;
	Wed, 15 May 2024 04:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715766695;
	bh=TTtDbejHhU/YLTRsCjZJ8CwsWSoEHZiI+EIRKdBG1xg=;
	h=From:To:CC:Subject:Date;
	b=npYiJQdlRnoud4rMZaX76x2eVIHbhjCV9QvW2Sx7hUSUBYc4HZXnV0lT0OfOVBPkG
	 QD7CuG3mmZ4zSbFP2PIpGsuEJ0ACn/zqtkaWWhXvRocx5+zWeDUy0IK1duUOQhRswm
	 LyyUSQpBugR3hR/vu9Mr3s2MqJzlHsTa6iosJS6o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44F9pZ78001273
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 04:51:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 04:51:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 04:51:35 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44F9pY1d125240;
	Wed, 15 May 2024 04:51:34 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang
	<quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie
	<airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Liu Ying <victor.liu@nxp.com>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra
	<j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 0/6] drm/panel: simple: Add Panels and Panel Vendors
Date: Wed, 15 May 2024 15:21:27 +0530
Message-ID: <20240515095133.745492-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

Picking up this long-standing series which added support for Microtips'
and LincolnTech's dual-lvds panels.

Microtips Technology Solutions USA, and Lincoln Technology Solutions are
2 display panel vendors, and the patches 1/6 and 2/6 add their vendor
prefixes.

Patch 3/6 adds panel specific compatibles to the binding for simple
panels with 2 lvds ports.

Lastly, patches 4/6 through 6/6 add the timing parameters and the
compatibles in the panel-simple driver file.

This series has changed from v2 in that it is not trying to add a new
schema for panel-dual-lvds anymore. There is no requirement for that
today. So patches 3/4 and 4/4 from v2 have completely been dropped. And
in their place, have come new patches - 3/6 through 6/6.
Patches 1/4 and 2/4 from v2 are now 1/6 and 2/6 respectively, and I have
carried the tags provided by Laurent Pinchart and Krzysztof Kozlowski.

Regards
Aradhya

Changes in V3:
==============
  - Drop the schema for "panel-dual-lvds".
  - Instead add the panels under schema for simple panels with dual
    ports.
  - Add support for these panels in panel-simple driver.

Changes in V2:
==============
  - Rebased to latest linux-next.
  - Made dt-binding syntax corrections in Patch 3/4, based on comments
    by Krzysztof Kozlowski and Laurent Pinchart.

V2: https://lore.kernel.org/all/20230124101238.4542-1-a-bhatia1@ti.com/
V1: https://lore.kernel.org/all/20230103064615.5311-1-a-bhatia1@ti.com/


Aradhya Bhatia (6):
  dt-bindings: vendor-prefixes: Add microtips
  dt-bindings: vendor-prefixes: Add lincolntech
  dt-bindings: display: simple: Add Microtips & Lincolntech Dual-LVDS
    Panels
  drm/panel: simple: Add Lincoln Tech Sol LCD185-101CT panel
  drm/panel: simple: Add Microtips Technology 13-101HIEBCAF0-C panel
  drm/panel: simple: Add Microtips Technology MF-103HIEB0GA0 panel

 .../panel/panel-simple-lvds-dual-ports.yaml   |  6 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |  4 +
 drivers/gpu/drm/panel/panel-simple.c          | 96 +++++++++++++++++++
 3 files changed, 106 insertions(+)


base-commit: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
-- 
2.34.1


