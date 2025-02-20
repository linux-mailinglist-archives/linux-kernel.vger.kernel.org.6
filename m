Return-Path: <linux-kernel+bounces-523504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0B6A3D7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9390A3BF030
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8A1F151E;
	Thu, 20 Feb 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6BCLfmW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAEF1EA7FC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049186; cv=none; b=O9u5RSNpaarLEbW3yq2+TPYGsWWwNxeDVt/7nbZWBr7dUTd5oThkxmiyrRqxb2JoMlMfHyp+BN0RAZulx0UlcK3qUeck3of5gPS1/Iw+c7kJiX/PMGVBKrNpEVq2N/jSlUspAaku3APOBiEXyybyvG3KGDjFID1EfByhu6WAQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049186; c=relaxed/simple;
	bh=Hq+lcScj3/h1iEKRxMa/1ZGnirQuXYtvzF7IQlJoFgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/1oZMDOpxFxqcZciyN9/Y0zpi5WCfT8FR2gudQlUFeUgTT+dqMV9qf811VY1hAF+Bt5jqpq2fNwiVKBdm2ZlQ6d0nECiPA6oiUmvyfWnLysbOg/w61LrFAm4IjuIaPYjciynXrqoOaJV4fvvya0r6UikiGKW2v8TZrVGb6avHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6BCLfmW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c2a87378so11191455ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740049184; x=1740653984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3ZauSCmlWOF0R/ee8Rh65K75L8Y3Jklu1pUfuh4eWs=;
        b=f6BCLfmW3amEbmo3HkvfsQYyyPZDB96eEBV9CanZCfzqtWv2TgpEqMdlKzdKl4G5Ft
         Qo6GlRzjsXVPVL+y7RUfY2GtZzL2Kgdpke9LF+ohl5lP5NMgFw/wL5mOdMB7sz2yR5kI
         smnkJaQ1X5spRVkjMAJz3Fg/B1Gvnm9AWXbNMg0gLqTB0KltQXqvDxHt3gGu/jIPAcIl
         395EB7xXEJgbeD9qN+D0a2L9i7zwFBMQFyvf8GKj6Zm6KZ4eigb+2Ak+KKBLzck2TPga
         dqRAovK4Ifa8uhu9ie/vzZMnWFfP99Y5/AHkAh1KD0nsLsxDrTUnXDx9NitqYEnz9xgA
         ynPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740049184; x=1740653984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3ZauSCmlWOF0R/ee8Rh65K75L8Y3Jklu1pUfuh4eWs=;
        b=I24jATrvK6zxjrTK3ZQmJopedX+wRfol6Sy/7zDtaue5mEalinHPXUyBq8l0oR6xHj
         YundIK+NcZG0CO8tRMSRfEazvp0izAcO+tW0yj0HpdZ6bE9bqDOlLh48N3f5zODU+ZC9
         ohkBUBoPGjHIVOh/eKUte2etLTSYp4/CXYrI8FIKiMYkoUIGizCrtiic1KaDNCv8n5Hm
         HhU8u/WpvPuc5seYv1NGHXiXE6HTGKlZdqMEK1+b5i2JLjfKqqzTnJf7bZy0wwWO/Fhc
         ReuNC+Xd16PO/EmLuZEgQ0IBQpg5AK6oRUVUYSLTLKsVTYDyf/OfHi3UXpHfte/M1UEa
         ZI5A==
X-Gm-Message-State: AOJu0YyqjOuTrb7K/nHOUwAL1jFJSN7D78rtoF5eWonigOhzXAhJd1LP
	z0frEZxyubhfSFgKJd3YBkzOfUUu6oGJ3uYBO7rz5wHRw9fuTPLRYNafE2gj
X-Gm-Gg: ASbGncvdJWdqhPBdKkBj7pxi1s8RatMHhSgIkX3Rh/mmFhm60s2IjvIvhQ/LYpfzvNr
	WJ9Ok6GoMBjQLhZFhGKk2XDokfvNddwzadmATk6cvr0BKLRoyrJ1pzsRqDWzIqeCFlC/lrzLRQf
	DQtuR5G0H6VjR/lRCPYEO7AMGYXoPXTVnz6xJEAsM10wQ/TsD19c0SubkRFHprhNriGCFLotqhV
	ALsU7aKtFo3VtQqamVrGrp0PnmpRDihnI7+wllDxzOgdbajtQIdUWiR7gNL3kf1wmD5HpZUWugJ
	yqeSqDBadYFu38Zb2LMjWPXsAB3IApgTCRG6gy4=
X-Google-Smtp-Source: AGHT+IGlivqRo+sIkRA0kH0tZP+S0SF8DCOmSoVD+UaMbG/UIhhVAS6E8crmJQm6+2ygb16KbqoZ2A==
X-Received: by 2002:a05:6a00:92a8:b0:730:9424:ea3e with SMTP id d2e1a72fcca58-732617bfaadmr31555798b3a.11.1740049184173;
        Thu, 20 Feb 2025 02:59:44 -0800 (PST)
Received: from ritvikos.localdomain ([49.36.192.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732752034e0sm8388021b3a.138.2025.02.20.02.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:59:43 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 6EA78E7C4B5; Thu, 20 Feb 2025 16:29:40 +0530 (IST)
From: ritvikfoss@gmail.com
To: linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] scripts/checksyscalls.sh: Add usage message, fix -Wno-error
Date: Thu, 20 Feb 2025 16:29:40 +0530
Message-ID: <20250220105940.5241-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ritvik Gupta <ritvikfoss@gmail.com>

Currently 'scripts/checksyscalls.sh' does not
provide guidance when executed without specifying
a compiler, instead it attempts to execute
'-Wno-error' parameter as a command,
resulting in 'Wno-error: Command not found' error.

This patch adds a usage message that is displayed
when no compiler is provided as parameter to
improve clarity.

Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
 scripts/checksyscalls.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 1e5d2eeb726d..14c04227c96e 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -10,6 +10,21 @@
 # checksyscalls.sh gcc gcc-options
 #
 
+usage() {
+cat <<EOF
+Usage: $0 <compiler> [compiler-options]
+
+Example:
+  $0 gcc
+EOF
+exit 1
+}
+
+if [[ $# -eq 0 ]]; then
+	echo "Error: No compiler provided."
+	usage
+fi
+
 ignore_list() {
 cat << EOF
 #include <asm/types.h>
-- 
2.48.1


