Return-Path: <linux-kernel+bounces-234535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8E91C7AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9966DB2845B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55978C83;
	Fri, 28 Jun 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="eZmZUHCe"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0217D3E4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608329; cv=none; b=StUeCEdFppXkHopI4U3xkjx9iSau5Sor9Tkp4h1EkL8bP1/eAoWAM1XYJVk8AnSwaMfVSKgY0XFjnT1M4KKmz+nds9z6EGMAPxjfoZmHqobUqp1cb/ee6GuBLxPB+XUsDhHFNfqEWuijMmryV6xs8RHskZQeqL2MkQydLg2Jlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608329; c=relaxed/simple;
	bh=/h7K0AMUZUdmYSayD0euL132NkxEKfP43Q/+mQvmtTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4LDRRJ+exgn2OCjk1RVYQqQ6CyYPS2JJUvjUYJFcRQ9voAMd/rQA7ih7TnCgPAFFjGJ03jTTWqNmm8GZJnlL3XsE3a4GC6xNJtbXDOl7p9DYSn28W9S7gu0CXFIJGgEwyDAwt9wUH60ZchCHgT3UTM5Mn3BAmPXrzox8F6NZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=eZmZUHCe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7066c9741fbso891652b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719608327; x=1720213127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl72+hEsFj3IepAaeWSkRE5ZSKXOhBsSp9DqAh9ZaTA=;
        b=eZmZUHCewdWK06XMQ0wIFfjibjz3Eok9yJ+/DFWG7irVyFB/4TvxFmTYIC5V5Mm+VE
         GG6wv/UPg4BxPhlVZUS2nYF1Jhj5upGVlJ2KTp/wgZ4jA0P4pSzfXnCQCUPKsFm9j4sK
         E2zDDlS778rHp4TAHimi6RotODkzcTU18pNoJ8l8DR7rRTl6L873Jqlm3oG5EGEj/qnu
         ZCACDGfJvDb3bT+iX4Arek29qteL6mO/8EfJt7fzDRZKOEkrsr8Etv3oV2YQ2b7PRe0C
         7dx7Oxkw22I4w4OIgnX/l0vS0K8PUWrJTv6NbwVG+ONA8PBAAAjY5FdjLKFFNZut5+t3
         Zghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608327; x=1720213127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tl72+hEsFj3IepAaeWSkRE5ZSKXOhBsSp9DqAh9ZaTA=;
        b=vOjnwiki7JMy1K9+NK04Xn4+3/lyH29WsyCbiP6mrtBeav4Sg6yTzzE7xwBB3VS3eh
         KTRnBfT3SEd2DRw3iojaMGBXHJpRBOL0ttb4GtydQYXJa1JAkyED88y0GMw5mZ3LA0g8
         F2Pz+MWhBlFABBfy7bguGheMrKh9K+2ZQq1qwBaQNZLHR5FpYIhAT4kDakgcD9cb3IA2
         mbMGBtKeQmNV8g7d+f05HM5XQVBSBzy3Wh8xKz/hxr04JLJ7ue0NRhHdMS0tRIJAoUdD
         wSPoryJAkaV7CYgJmB5LZN6rFKOZrp52AM3eH63MvvJUvTelsahG/ItFzdgOEtH0IjXq
         AX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS4Kgtd3ES28tYho3jy8JoFFEJrhEPY70BYtWNtdYtXi0hfCIkqCuRnwC4kUF43nVte/nZmD5pwkgQ6+6zJxvjdRK2HrjwptT6Xt5P
X-Gm-Message-State: AOJu0YzxkeYcnKxbbqfl4e4FU2q5AyGLdGb2FZJqX4VkJzbT/WVfnSlF
	aTD7/9LwdMnnMalvoeVYIRUft7vB794p4bPYokzbQyvL9w0NyU/FEEWvWdb1OQ==
X-Google-Smtp-Source: AGHT+IHF4vbD9vhOn3SdH4o1mgyyRbgjnnJ+BfvI8KX26iICPEspnmI2UBgYDwJRc2VgEgWvnA73mw==
X-Received: by 2002:a05:6a20:29c:b0:1bd:2894:4015 with SMTP id adf61e73a8af0-1bd289440famr10062918637.50.1719608326894;
        Fri, 28 Jun 2024 13:58:46 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568f4esm19709635ad.191.2024.06.28.13.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:58:46 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <mattschwartz@gwu.edu>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <mattschwartz@gwu.edu>
Subject: [PATCH v4 0/2] drm: panel-orientation-quirks: Add quirk for Steam Deck Galileo revision and re-label the Deck panel quirks to specify hardware revision
Date: Fri, 28 Jun 2024 13:58:20 -0700
Message-ID: <20240628205822.348402-1-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series of 2 patches. 

The first patch is from Valve's public kernel 
source tree. It adds a panel rotation quirk for Valve's Steam Deck Galileo
revision, which has an 800x1280 OLED panel. The previous Steam Deck panel
orientation quirk does not apply to the Galileo revision's DMI. I have
added a short commit message and signed off below the original author.

The second patch is one that I authored to clarify which
device version each panel quirk applies to now that there are
multiple Steam Deck revisions.

---
v4: add missing S-o-b from original author of patch 1/2 and re-signed commit
v3: fixup inconsistent patch versioning across patches in v2
v2: fixup patch 1/2 commit message

Link to v3: https://lore.kernel.org/all/20240627203057.127034-1-mattschwartz@gwu.edu/
Link to v1: https://lore.kernel.org/all/20240627175947.65513-1-mattschwartz@gwu.edu/

---
John Schoenick (1):
  drm: panel-orientation-quirks: Add quirk for Valve Galileo

Matthew Schwartz (1):
  drm: panel-orientation-quirks: Add labels for both Valve Steam Deck
    revisions

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.45.2


