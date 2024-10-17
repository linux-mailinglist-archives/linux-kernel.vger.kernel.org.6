Return-Path: <linux-kernel+bounces-369484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD669A1DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AFCB244A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299A1D88C7;
	Thu, 17 Oct 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="afsw8czs"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A71C4A3A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156331; cv=none; b=peIgcGmYTk1167P6hhwhhuI8ZQukH6c/ldpkvo0p/821wzRDg0OOxd6J/ZnK0B15LUufJF7PTZyUqLTdVXM8ahwa87TfDTks3ZmwXEfUfl8aVd+RptMM99jewDVdjjxVwpiX0KkrR4V7xbV1NAa5MuZBfPs3kG69U/2yj4X/MTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156331; c=relaxed/simple;
	bh=p9lHJGDnOyVNG8VW73a+G3JiuEx6zQ94Mj/zJcCD5Ho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OqzuDEvUmZQMJk3kTjd/2sys+u8uPVHlmXXt+UtuEqvYgSR52zDMZZ/mli67lW8qZqa/qDJlbG6uj1r3d3tdrgTWyWQXBWccPxW9jgsICNeCRXhh8YIUg6VtwaMziZMH8hp3WEvs+v6/GllBhlBLn3aFDbQDGLazyC9yy27OuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=afsw8czs; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1729155405; x=1731747405;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p9lHJGDnOyVNG8VW73a+G3JiuEx6zQ94Mj/zJcCD5Ho=;
	b=afsw8czsyWC5+mdJ5AsMVelrB33rCVrzr+NVmoumXh87wYUqS8cEMuDJsNX3GT+v
	igpji+/teN/pyk55NiCLP990xIMYLTO5AGZEfdZ+hGgRwPlzE1lGXPY5m1jFdkOr
	r/BaGc+NGsfcvXqH61cM1cI4YSlzPNdB4UoAXqoRUNE=;
X-AuditID: ac14000a-4577e70000004e2a-86-6710d14c6578
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 21.81.20010.C41D0176; Thu, 17 Oct 2024 10:56:44 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 17 Oct
 2024 10:56:44 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<bbrezillon@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v3 0/2] Introduce bus-width property for input bus format
Date: Thu, 17 Oct 2024 10:55:54 +0200
Message-ID: <20241017085556.3045686-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWyRpKBR9f3okC6weUmFosT1xcxWdxf/JnF
	YnXLdEaLNXvPMVnMP3KO1eLK1/dsFs/nr2O0OPnmKovFy1n32Cw6Jy5ht7i8aw6bxcKPW1ks
	2jqXsVq833mL0WLSvJusFv/37GC3mP1uP7vFljcTWS2636k7CHvs/baAxWPnrLvsHrM7ZrJ6
	LN7zkslj06pONo8TEy4xedy5tofNY97JQI/73ceZPPq7W1g9Np+u9vi8SS6AJ4rLJiU1J7Ms
	tUjfLoEr48GUeawFd9gqFq/qYW5gPMbaxcjJISFgIrH/9x8wW0hgCZPE7/0FXYxcQPZjRokX
	15oYQRJsAuoSdzZ8AysSEfCTuPVlHztIEbPAJmaJz693gyWEBTwlbjztZAOxWQRUJTYevgHW
	zCtgKdF3YgMzxDZ5iZmXvrNDxAUlTs58wgJiMwPFm7fOZoawJSQOvnjBDHGRvMSLS8tZYHqn
	nXsNNSdU4sim1UwTGAVmIRk1C8moWUhGLWBkXsUolJuZnJ1alJmtV5BRWZKarJeSuokRFJki
	DFw7GPvmeBxiZOJgPMQowcGsJMI7qYs3XYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB
	9MSS1OzU1ILUIpgsEwenVAPjkovnXG++79l4tKd+vcldM8W55zWuHLZzfHmKJfs1B29K8SXz
	/buap2yYqC747+oTyTwLi9BIXeYNGzZIXNZ90XnCi1M87GVvbN2z5PVHdskonP2roZ7JeJ93
	/j/J7mamhg8LPJ8u4nVLEGS0ZrBa8GLi3TVt25i23pB7wPxvRUiK23xdxtMySizFGYmGWsxF
	xYkA9FwOJLoCAAA=

This patch series introduces a bus-width property for the SI9022 HDMI
transmitter, allowing the input bus format to be configured based on the
number of RGB input pins. The default is set to 24-bit if unspecified.

v3:
  - Add Reviewed-by tag from Krzysztof
  - Ensure bus_width is set/defaults to 24 even if an endpoint is not defined

v2: https://lore.kernel.org/lkml/20241007085213.2918982-1-w.egorov@phytec.de/
v1: https://lore.kernel.org/lkml/20241003082006.2728617-1-w.egorov@phytec.de/T/

Wadim Egorov (2):
  dt-bindings: display: bridge: sil,sii9022: Add bus-width
  drm/bridge: sii902x: Set input bus format based on bus-width

 .../bindings/display/bridge/sil,sii9022.yaml  | 15 +++++++++++-
 drivers/gpu/drm/bridge/sii902x.c              | 24 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.34.1


