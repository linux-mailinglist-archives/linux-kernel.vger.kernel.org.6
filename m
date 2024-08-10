Return-Path: <linux-kernel+bounces-282044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E5794DEDD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA37281FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78B7142621;
	Sat, 10 Aug 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZHR5cSXr"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6B3AC2B;
	Sat, 10 Aug 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723326939; cv=none; b=t/db0tToMJ9WaL9shrWpSze/2uN8jenEamh84AQM3nZKXXVAnoc2ieEj2dn3cMu2OuoNwpeISVbXY/bpTZReYtkQs28eoQcKt/pbOXPKySlud7eq/pvhiTRV/MdbdpooQXLR3OYFRg2qphUHmIpv6AOrOaGygCBIc0GMgM6zoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723326939; c=relaxed/simple;
	bh=MUN8hJZBvUsv9hOuGxfHs6O/XXcOcIX7/oOxXRy/PG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZ5DX2cP188WYu5xD/iU3eEu8g1zb6d9tZ41LjW4S4We0GUVs0Nn5hq6HecrnNQOFoiv6FI0Oo0KtildZKcqcHhe6VmekhCO9WWjQMJ4o6itytErrmyXFcdf2B5iIWOh39so4LRrBHC8ee7u3PY0ZRVlMV5NiP4PUmUcs4Stnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZHR5cSXr; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2BEC6C0000E4;
	Sat, 10 Aug 2024 14:46:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2BEC6C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723326380;
	bh=MUN8hJZBvUsv9hOuGxfHs6O/XXcOcIX7/oOxXRy/PG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHR5cSXrP8pWd9eAS9BmvQyflGczrTQJd8t7EcVZOLzSWwBgj/ixIvgajPG1VZhfP
	 4Zjt7D4PWUCB/AspQQaH5irmbfwKwVdVzih2HCbQ1wT+BCsIPwMyZc3ilX+a/bLHFB
	 k0lhjqqq8yoSFlqP11tDC8SD+wniN4fu1Zg+Hpno=
Received: from 7YHHR73.igp.broadcom.net (unknown [10.230.29.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id D0A8418041CAC6;
	Sat, 10 Aug 2024 14:46:16 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	arm-scmi@vger.kernel.org,
	james.quinlan@broadcom.com,
	justin.chen@broadcom.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 1/2] dt-bindings: sram: Document reg-io-width property
Date: Sat, 10 Aug 2024 14:46:20 -0700
Message-Id: <20240810214621.14417-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240810214621.14417-1-florian.fainelli@broadcom.com>
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SRAMs need to be accessed with a specific access width, define
the 'reg-io-width' property specifying such access sizes.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 0922d1f71ba8..18e42fb36846 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -101,6 +101,12 @@ patternProperties:
           IO mem address range, relative to the SRAM range.
         maxItems: 1
 
+      reg-io-width:
+        description:
+          The size (in bytse) of the IO accesses that should be performed on the
+          SRAM.
+        enum: [1, 2, 4, 8]
+
       pool:
         description:
           Indicates that the particular reserved SRAM area is addressable
-- 
2.25.1


