Return-Path: <linux-kernel+bounces-176731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6A8C33D8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7DF1F21562
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13B224FA;
	Sat, 11 May 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CRRocr1W"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4C1CD11
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715463250; cv=none; b=MwkQDrv1EYGSwn8gj+cuhPmgq5uH9WCHni/CA8adfAo6Lgo7IhwNU/ZjsVNjEai9j9hym8HMjRjsKxyyrF8LtKN95tHtkQDN2WS6/Ru2hvTmUTsEhCXHKLmIB74lJp2Tfpr8A3GrOYmjBlaYGctkdJTK4+78QeK0iN39EellTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715463250; c=relaxed/simple;
	bh=NvjFLOuyZcKwSs83kgKRguywNOQb45rJ6TDp8yFSFkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P999odjFICFOjwzhW+qqsiUupW8nfh5bWtP+T/juGe2YKVJNULzxFQ0tE6PzTStf8PpEC7P6fWyHLOASYkn7m2qOe42VzbxmwjecSzZF/Fr4kssMQRk6ZGhr4ps9gBS9aJJ6UErNDfDikT3ONU3vNcFtGFogeznaKOXZWjL2i68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CRRocr1W; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34f7d8bfaa0so2197829f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715463247; x=1716068047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9emgUyAJtwAbObZGlwkz1l4VNKCq8tIChis3cCxIwiE=;
        b=CRRocr1WjR3uNYe7men9jti9VtgPoGEZF3EBKnD51PNPzKxBMha8bs0HcqoodzqDH/
         dJQJE/ovlnGghqkqpE7ZYi+5G0Djq8HjNBo1dHZ18qIj0QqHXVfiR2IpX80vMLyDG6YL
         /VLbVRVulaUofi996IG+vLaOhBgBqFTdvkkma3vnz3JdxZZGUfDOu7QrtNDOtf0Uy02Z
         YO/3Nxx/ijhyeXDgCmuVwKw+CxBsMc1d6fL28Ludou9jleVp0syr4qMsk4DXk6gjzsQB
         HQEiXPXMVLq+lnoX0413k06CtrJEJRolpPCJRj2qyHK7aNDliAbnZ2LjAHlcOZpXtifg
         JVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715463247; x=1716068047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9emgUyAJtwAbObZGlwkz1l4VNKCq8tIChis3cCxIwiE=;
        b=X1ac6MInZuQW8C7PbKgLEUI5g2BrBh6qosBCgvAjWtb4SSwynT1gLGqmx1bnnga0u+
         ++h6NTH8ph4oxmAdB6AsA7q7awUwyPScoTE6IeLhv6jABNlBbzcoxDjGZ2ykkHplMnfp
         Dr5QEnsK5iBmuOPcFwRAI6LyLVGUFfWiX/+WOYNZtneyVFWTClQoUuhHln4+xEs29vMu
         j/YLHQJCcPJdVmRwtcRGQGdGxMMSd0zJQdwXt2dPbx6cat9nsG6RmEckCpFz8QoWiz7o
         g+2zWPN/VgoRBxK5jifeus5HJDsNrX+tK7OVsCUL2xAzsoAqwflDPLuSwuK50EC25ZJF
         ovhg==
X-Forwarded-Encrypted: i=1; AJvYcCU+lXl0k/BMk/8IsjyMrI8KOgcK9Obe5BcLAzYHzLnp9DQ0MDX0CM6OH/Rsyt2h93j0D7H9cNAns9+qGN2N5R+qO2MSynoCL8xzfus3
X-Gm-Message-State: AOJu0YzJ3fdUlGNwv67kh+u++2yOJ2CveAvIPwQ/PigZOc9U22KgUM03
	OdQpv/vPLim02p/Aou0bO/Pn/8hODrjryjP2hHVQiGhnYMJJ0U4iIt9z5UAIlfA=
X-Google-Smtp-Source: AGHT+IFztmk98Zb+aKIGHwMouWlthssEhoVtuZRe3Rfhc6jFzedwa/wWeKjRwuFycvz/95KxyNHiJA==
X-Received: by 2002:adf:cd8a:0:b0:34d:a0b5:3c57 with SMTP id ffacd0b85a97d-3504a73648dmr4183219f8f.23.1715463246862;
        Sat, 11 May 2024 14:34:06 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896b00sm7573613f8f.45.2024.05.11.14.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 14:34:06 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] Coccinelle: pm_runtime: Fix grammar in comment
Date: Sat, 11 May 2024 23:31:19 +0200
Message-ID: <20240511213117.2710-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/does not use unnecessary/do not unnecessarily use/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 scripts/coccinelle/api/pm_runtime.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index 4b9778874453..2c931e748dda 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/// Make sure pm_runtime_* calls does not use unnecessary IS_ERR_VALUE
+/// Make sure pm_runtime_* calls do not unnecessarily use IS_ERR_VALUE
 ///
 // Keywords: pm_runtime
 // Confidence: Medium
-- 
2.45.0


