Return-Path: <linux-kernel+bounces-449867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A19F5721
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8533E189125D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F21F9ED1;
	Tue, 17 Dec 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="rITcCvWy"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B111F9AB1;
	Tue, 17 Dec 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464691; cv=none; b=U0EUuwkIZ9UwagOYOqT+M7YxRaTLK9ZBytgjp8uh0u5hhBRjkw5Xg6HyjfN/fdul0WNT9T+uzl8poDGU7PlB+smfvdQHyBLVAOXrP1MWtg1hweHHYOdzyceH2lMRFN1xnm14q3qn/HXZZbxPiODKjSIYK76rRpTxwWqAzlOxjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464691; c=relaxed/simple;
	bh=Xjzhl5Kl2fzJFUBGzDTEeE5m/z/iii2XRHFZlX7lMGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn2ywPot6ZoCb7X7XiwsYEAecthn+nVFPPUfHPMEvnjvPe7+D2VtL9CbPMJTN7q5MO4VJssqLmxQKcY91aIup8+D9RhjnPl+i6a5rrydkbRT8BtzR5G5crY7kmwpO1GWnZTW7hh4cH3n2yUaq6aqsE+376YTsWWmLuC6HhhxVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=rITcCvWy; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A4C52C00280F;
	Tue, 17 Dec 2024 11:44:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A4C52C00280F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1734464688;
	bh=Xjzhl5Kl2fzJFUBGzDTEeE5m/z/iii2XRHFZlX7lMGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rITcCvWymgfI0li4BabB6Yog0Sn35TreNeOf0c3DqQwDXPQ3eWK8xqSU3RqMwvuGt
	 vFXnTNNjmAGTT3nikc+WfV04OAjvZQc9uu0NpqJv1Milnk0/Z+pPQJ1zvL0PSVvguH
	 jeBsyey6u9f6575J24Fp9iMmxFcOOoZdUU2r2OXM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4E3D018041CACA;
	Tue, 17 Dec 2024 11:44:48 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org (open list:MEMORY CONTROLLER DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH 1/2] dt-bindings: memory-controller: Document rev c.1.5 compatible
Date: Tue, 17 Dec 2024 11:44:38 -0800
Message-ID: <20241217194439.929040-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217194439.929040-1-florian.fainelli@broadcom.com>
References: <20241217194439.929040-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the revision c.1.5 compatible string that is present on newer
Broadcom STB memory controllers (74165 and onwards).

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
index 4b072c879b02..99d79ccd1036 100644
--- a/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
@@ -29,6 +29,7 @@ properties:
           - brcm,brcmstb-memc-ddr-rev-c.1.2
           - brcm,brcmstb-memc-ddr-rev-c.1.3
           - brcm,brcmstb-memc-ddr-rev-c.1.4
+          - brcm,brcmstb-memc-ddr-rev-c.1.5
       - const: brcm,brcmstb-memc-ddr
 
   reg:
-- 
2.43.0


