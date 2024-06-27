Return-Path: <linux-kernel+bounces-232951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A491B06A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D0A1C2201F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B919DFB9;
	Thu, 27 Jun 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="EI6CwPpv"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1319DF7B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520289; cv=none; b=T78wUAy2R23Fi1xJ2PStNSz6/SKeJsntuz4vj4H3Q3z4HVXJL7Lg19DxMA0ySEifAFcuuWz87yUC4NH3avHaNcVtDMdpepGnfEiIdkCUvwXZeTdT9a707HWKW2+gcQXi8tV8Uh2VkYjOUAh+wJcoc9uGG4sx2oceNVjy7SrWth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520289; c=relaxed/simple;
	bh=G0WTYo4qP9foE1/URRqaLrqkSZwV+fn2RNfJQbD5aYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpq64xEEYpFQDzAk875F3zBDMjfa1rkpeK/fxnG6Fgd/C/JMV12NeE86O7vIdZtyfcus9VgMH8XmYF1sir2HchEMl0/pXpIZql88pHNapIQof4iIBC29XW/bFGZTLxPg9xL0DXnYs3xHZfT4v0BZldudlJAUgEHfUR/Q+4aqpbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=EI6CwPpv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7065e2fe7d9so5006156b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719520287; x=1720125087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+Rrq4z5wBKoFsylLRmebiYlJRSKIFHwRm0eKDi4f2k=;
        b=EI6CwPpvvPAY+f0sPEas0PzR8fO/QpqybomDM/6pAKHLneC93sYD+jMY4lST232jFd
         /CEvMb9Kvf4O/gW1LVdXBZsY1qKjCZg6A20FpErhuBN9HnXgBi7oEArnllW3ooDONQN8
         hIs0cJWs3O9/ZcxCwULJ4XMt9fA5D9ASRXz0Ly038/JGTu/+SWvJNp1TbIWoIl9eSsRw
         kTu7v5Bw0HqSM6zxxgzNW9No+gV5oocfe4pb6ljgl43mvVD0Unk3Hjp9J9GvNcvT/MR8
         0kD/jbp2Fc/Ssrozp4hSY1SjK1SJTCsDqZ8TUsXp50BSQVgCw2EbBelJJR2TvMDnumb6
         y9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520287; x=1720125087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+Rrq4z5wBKoFsylLRmebiYlJRSKIFHwRm0eKDi4f2k=;
        b=lCO2VxmzY5fkI46Bkb1Z88E3OfCa7xCwUY0AUn+UohvLduE62/KilamZws4dwbC25s
         gBq38gcdCQ2Ds00H52pQEZAktreUegjZ96bGBfv9c4C3Z3VklZ31ZANaK3+DMrCP8zCG
         +Ac5mLT+mGMboe6s5CXz+oavOWRw6n324S9GZJWxN84UHGb1NtWNhkQReE6fQXZirBQu
         sNYc/J4APKX/ti4v/mE5xmbdbvTmYXDVHEmSUqrFSRt44rD2aDDVIlSj8JtFIKhGlNYD
         kCaIJOYwhpYkx5ttZEvINqzY3AbjOiriV6KZVZFExMJERZtrIVMV51/EwybzUmW+pW1W
         dy/g==
X-Forwarded-Encrypted: i=1; AJvYcCX+gxnIkmLTh8mIo3lSsUzcyJLRAHJP4FCHmLXkht1RMC73L3/Gpc9cLyMmZS3WHEKE8OnWGEH0aoZDJ4IBNAty3hh5D+aIcz5r9Riy
X-Gm-Message-State: AOJu0Yw8GqBOfRm0IkBo70zfWJwO96nsNqrodNR62s4RuM/k2jGKDGjM
	/Gh4eODeYPMyyoWdBctFsy35uTMBu4YZ36EnP2GJrKTdJlSY1VzldRQ6/jlkTw==
X-Google-Smtp-Source: AGHT+IFMJXadLHQE+Cb+jpmMYrytbtyKyWJkkx8KqsgFqeRNohho9BiJ1+P5+/28K0M9UUx7cARIVA==
X-Received: by 2002:a05:6a00:3c5c:b0:706:7943:b9aa with SMTP id d2e1a72fcca58-7067943bb33mr14396933b3a.5.1719520286768;
        Thu, 27 Jun 2024 13:31:26 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e63250sm140514b3a.29.2024.06.27.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:31:26 -0700 (PDT)
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
Subject: [PATCH v3 0/2] drm: panel-orientation-quirks: Add quirk for Steam Deck Galileo revision and re-label the Deck panel quirks to specify hardware revision
Date: Thu, 27 Jun 2024 13:30:55 -0700
Message-ID: <20240627203057.127034-1-mattschwartz@gwu.edu>
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

---
v3: fixup inconsistent patch versioning across patches in v2
v2: fixup patch 1/2 commit message

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


