Return-Path: <linux-kernel+bounces-430380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6569E3037
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232972838FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84C1FA4;
	Wed,  4 Dec 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYQCVK1K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC12632
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270619; cv=none; b=mE2ddr5N4DwLeeO5apXjXllIpqa6jcCuYKtG66iVcOC5ApCXXrEEYVXd+GLRg1JZXiyAOBWguYZpMrtIDKM8GHn/ZdRprKwS5KevuMSaXyGvLmaK7NJdWYdz1hmw1kE6akmSuCzVtiHfHLI8ctOQOe+nbS4oVWXN3TOyOG89LqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270619; c=relaxed/simple;
	bh=F6/Cre7zfwnOLEJf/mLF5+v8rUNC6yHjC9UKQxhb4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qK6KX/tFursmgQvV2GBC0T2G21f5/atOYlH0Ch9VfNPB8RRaNc+ldd+DnXwH7+k6jrbH7JhYFhALBy4/+5JqcVjskLZpeawa4ijmSvuJTAakdC33fwCgH2NbI3gEg42cyNLee3V7u+G1LK9LHli0lJEYZ4HfBsnIPanT3LRthAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYQCVK1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13E9C4CEDC;
	Wed,  4 Dec 2024 00:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733270619;
	bh=F6/Cre7zfwnOLEJf/mLF5+v8rUNC6yHjC9UKQxhb4bU=;
	h=From:To:Cc:Subject:Date:From;
	b=NYQCVK1Kg5FH57I7531yYE3YfJ7/T8M7+PE458phyECI3MpqpTtaCPD7imoCCskeg
	 owYESgK9mQgyHYKcRfl8gatUgOL9sl6MAEXQV7y1P3UPvMHpPPsDOFY41LTWjuRnbO
	 4xF6lm5/H4Y5BV1w4LGEJiRM3k2VlntxRlczy9ByzbshmfdFFvM5OztPGRI84lamJe
	 aSUR3A43nyHBB/s5JwQHO6HFxeh4qGgUBMDkGoT1azIQ3tHOfAn20yR5qcBQ6HvS9l
	 wudWCEf9bX9/ZswYCOlcBIySXJU7LIagYwdyum4QhIpKjknZrmg4mHIREWGqW3kQnS
	 mngbrMdeJmMnA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Don't match device with NULL of_node/fwnode
Date: Tue,  3 Dec 2024 18:02:59 -0600
Message-ID: <20241204000259.2699841-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It recently came up that of_find_device_by_node() will match a device
with a NULL of_node pointer. This is not desired behavior. The returned
struct device is also not deterministic.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
It would be a bit more efficient to check this up front before we
iterate thru devices, but there's a number of users of these functions
and this isn't really a hot path.

I think at least device_match_acpi_dev() and device_match_acpi_handle()
should also be fixed, but am not sure about the ACPI side.
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 94865c9d8adc..87d50c5f710f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5246,13 +5246,13 @@ EXPORT_SYMBOL_GPL(device_match_name);
 
 int device_match_of_node(struct device *dev, const void *np)
 {
-	return dev->of_node == np;
+	return np && (dev->of_node == np);
 }
 EXPORT_SYMBOL_GPL(device_match_of_node);
 
 int device_match_fwnode(struct device *dev, const void *fwnode)
 {
-	return dev_fwnode(dev) == fwnode;
+	return fwnode && (dev_fwnode(dev) == fwnode);
 }
 EXPORT_SYMBOL_GPL(device_match_fwnode);
 
-- 
2.45.2


