Return-Path: <linux-kernel+bounces-558044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD072A5E0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AF71757CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E315256C94;
	Wed, 12 Mar 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="EFjXtP9z"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FF254864
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794376; cv=none; b=q5/Wizso1sfmZbzN086VDFQ5nqBppQdjL280Yz1tvWJ3rcpj6z3aJ2SP+GrpRbwaAY3S7gmx7kasDwDw1HsrlQxFIsW8ZNixUtz7sH/GW6w+6eMYdUPLA3rTbFS9yqaZOACgrgrzCJrUK8sk+JmP8aLErWMyervw2188tAEXonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794376; c=relaxed/simple;
	bh=RMhS2sjhh4e3IfmFUCYCZDan+fpWY2ntAaWVrW8ASgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4VdTsTqF7L9RS1AQyqDytf4+bxXKPVsujDh8OKf1ap2UbP5RAUcs5QcVz+OKA8XL1Yjx4Ivm2tEj/Vk0i1AS2hI6xwusyHqaJdZ0ifWAyXfU3WJjEqJR+TgfP2392eyFcgRS4tBeZd3yaJ+eaTlDPZuh33xU9JQ75TVFgFlS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=EFjXtP9z; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250312154607e2ee4e533281385c07
        for <linux-kernel@vger.kernel.org>;
        Wed, 12 Mar 2025 16:46:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yZ0hqVu+qoqJ5gOLuAKvUAj9SEf7RKv4cE8IhbeX2lY=;
 b=EFjXtP9zjay7VVnBCX4yNfHUn1XPMi8FQ9DmV08LiwhH5GLmGcSEta9/OqWP9ZjZto1OBf
 5BxToPgsJ3C2/0M5F6TYbUclakNJR/U+JihDrVfHWZx4iXV6JQzZ+Id+9PjXjSzyvNtr04mI
 wvH0KA8RXs0PeOH3ZGlGruuxh62yzaZon/Ic+r21dzlDum0xW0Ym0TLrbAcwzkp1NGsMQwZL
 aRLnGK2ajG8PuusYQ+fyR6trigTdAKgt2Zy3ozHzL0LWXCGs3jA+bNiZvC9wjy61jsNnZnoA
 ZUhLgu7MR+w2jKWfb6ozLh+MC9gmYsk7XCdQ8pxNoGoYspSe4nczm3sA==;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Wed, 12 Mar 2025 15:46:02 +0000
Subject: [PATCH v2 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-ivo-intel_oc_wdt-v2-2-52d09738cd0b@siemens.com>
References: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
In-Reply-To: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
 benedikt.niedermayr@siemens.com, Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741794365; l=849;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=RMhS2sjhh4e3IfmFUCYCZDan+fpWY2ntAaWVrW8ASgo=;
 b=qLdDiUab6U7IFBbaPKeHTrO0ZnvzKxoH3mtzUlzkY2hpOs9P8vR4w1WhLufP/epXk7nUwGP+k
 0e2M22UIHDPB2vA0f6OjTzddVQ7VPNtXJVDUJ+zRydhTjx5JWzrSYw/
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

With the kernel having an ACPI driver for these watchdog devices add
their IDs to the known non-PNP device list. Note that this commit is
not a complete list of all the possible watchdog IDs.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/acpi/acpi_pnp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
  * device represented by it.
  */
 static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
+	{"INT3F0D"},
 	{"INTC1080"},
 	{"INTC1081"},
+	{"INTC1099"},
 	{""},
 };
 

-- 
2.48.1


