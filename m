Return-Path: <linux-kernel+bounces-232820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B234591AEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E741C2251F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98719AA4E;
	Thu, 27 Jun 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="REFeHLPp"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3B17C7F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511212; cv=none; b=XAKG+PFwXm84+2zcp/b1EwazjKSiqKojlSQY4mABEW1BG9zM2aRi7H20G835DW7jo7bQf4UiMENyrVxEHh/DuwjZJXvRAYCAfa7SZqLXguCXbD1HxDHFSsZKI7tjKXP9Rt318+1GQwP3qBhQ4dabYumK4arEtdX/jvKay+OCu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511212; c=relaxed/simple;
	bh=7xxqpt7WS3WFYqDszhzWeY9kt0I9RzTwvvCF/qmBpxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uAFnnXBs+798NGrgJuPhwN6QLuxcbz07f8AQOdFczWDsTh/g1aVhbKLZYbKNDT6PEr2hPLsOkvSwGKl3jo9jbcXF8NPkzkp1MB5EO7WGc0RQtdScgIrK3vHVQAQ5xqci9eIic6PjG2YUb27sr+f1utXxkFw8i2r91pnxajP/y60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=REFeHLPp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70679845d69so3713687b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719511210; x=1720116010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/hg2HWwWebYgYxWqneD8sQQi2ODBnC38KdnXYrS4po=;
        b=REFeHLPpK78MeGOz18dg9+mkRr5Stncq7SkKkWPPaRYeusmwzZN4yksAZaWjTTbKou
         J5J1llDvBV0i6IIEdCGuNKF/BBju2rQT39lsyUuWbnL2i15WihPKpOhe/PNtZR71bT5p
         +XiWIRFI3hzQarpx3KSYWrl6tRVrkH9WjaPjaSkNeLvhxtrkH26QtJmRWprVp0Mj6EzA
         LKWwKdqNPzjC/VuSaAUAHsoJtSmvO2xYD4njcb0UCAGWopiivDodBVztSp8X4BOZWRKE
         kMLbP1vC8fRoc9Rit+PJuZP4IpzzBRZBYLNUhFHn1xikhsgNznBMpBD0ohW2UKNhabPe
         jJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719511210; x=1720116010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/hg2HWwWebYgYxWqneD8sQQi2ODBnC38KdnXYrS4po=;
        b=hYaiCdW1opblDUWqzk3dN8KxC5OBqeDqG2F505O97WHiqnV/3wbnz7Qg8pGnrkbrjv
         lYCYVilWzFqPPMNNB7dGN4kEmHCzuY0OgQTndhujMu+3IbaoqmyTRbkK1e1BPYDGt3Sw
         pGmuk5yOtYWTTEzkLHsCzDUt7qbVt9ABvz4n7BYaSbKiQ3sK8qn57LlJbMg41uXGhG2B
         QkK4tcj6X4E0r13B6j6WrtSEbgfVMmpyu3PxQvscZSc2//GJF3Xk8l4RWrlTl/rWJnR+
         eCnv+5mNaQMn7vUHzeIYGGxX2kzA7kQNQh9xXOUpX/ZM021W7351PhbnsGwBE1DuF0Pj
         dKNg==
X-Forwarded-Encrypted: i=1; AJvYcCWZNoPHRy5R8RAgX/ZySnsG7ySGEy/jTm0EAClk7oIa2YEqZraw4LLBZJnDGZekngehHmhnbrp/bZytDzLdj8t1kPS8FT36GdvEzFX7
X-Gm-Message-State: AOJu0YycZw4rTCaYCTE0OYV7LK/H8yqqwbDxLe9c1uzJeWuGQ2T81G10
	1Fd7h2CKsE6YUEjTQZUu8qpkurVB0ln/5yOMaGPyM0ueMcl1rkz6JDzgqsN1Bg==
X-Google-Smtp-Source: AGHT+IHpiobjYruEkWsJ/A/xmkyPjOBLIxBVKh+aYY3IP4fHA8HQFI4CEmsyjh9D3v0v6wGraCyWeg==
X-Received: by 2002:a05:6a00:c95:b0:705:9992:e7f2 with SMTP id d2e1a72fcca58-7067459a63cmr18121040b3a.12.1719511209837;
        Thu, 27 Jun 2024 11:00:09 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a352c0sm1718018b3a.171.2024.06.27.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:00:09 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <mattschwartz@gwu.edu>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: John Schoenick <johns@valvesoftware.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <mattschwartz@gwu.edu>
Subject: [PATCH 0/2] drm: panel-orientation-quirks: Add quirk for Steam Deck Galileo revision and re-label the Deck panel quirks to specify hardware revision
Date: Thu, 27 Jun 2024 10:59:45 -0700
Message-ID: <20240627175947.65513-1-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series of 2 patches. 

The first patch is from Valve's publicly available kernel 
source tree. It adds a panel rotation quirk for Valve's Steam Deck Galileo
revision, which has an 800x1280 OLED panel. The previous Steam Deck panel
orientation quirk does not apply to the Galileo revision's DMI.

The original commit is missing a Signed-off-by: from the original author, 
although the source tree is available publicly in a compressed package 
https://steamdeck-packages.steamos.cloud/archlinux-mirror/sources/
under the linux-integration-65 name in Jupiter-Main. 
It is also on the public mirror 
https://gitlab.com/evlaV/linux-integration/-/commit/d2522d8bf as the
official SteamOS GitLab instance itself is private.

I was told this could be submitted without the original 
author's Signed-off-by: if I used Suggested-by: and Link:
Please let me know if this is incorrect.
I added my own Signed-off-by: to the first patch as I was the one who
added a commit message explaining the change. I did not change any
functional part of the patch. 

The second patch is one that I authored to clarify which
device version each panel quirk applies to now that there are
multiple Steam Deck revisions. 


John Schoenick (1):
  drm: panel-orientation-quirks: Add quirk for Valve Galileo

Matthew Schwartz (1):
  drm: panel-orientation-quirks: Add labels for both Valve Steam Deck
    revisions

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.45.2


