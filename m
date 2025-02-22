Return-Path: <linux-kernel+bounces-526822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F86A403D8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573633BC3AF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA3C3232;
	Sat, 22 Feb 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2FMtFgT"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E6800;
	Sat, 22 Feb 2025 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740182830; cv=none; b=m0fdv8woe1ervBxEyUtByS9O5aZsni3Uxf+KFdAhLA1Cc/ujrU1ETWl6Boxa7lpd78j/s60mw9k6+9/+MtPhZR3IJFldGa45FJxhmp6o+YDp6oCPxmujshKpb749BBlJCjqCZecWPDinRAhcOaEvFq9j2KKY4E3xSJTRf+3JTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740182830; c=relaxed/simple;
	bh=7z9nzAGaM/cFnXC/bQkRf8mSWYPHlouc0LSnV+HXSGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sazGoiCKseh7QqFhxlVtKLJrdVbmWm58nm9+UK5rdyEJjUqN4RNtBbRtTSRIuI/PZtdE1kOs1I/+gJGob1/VTuGIVITSXUtrCM3h5RO/bRpeU+TrtI4AZcHlixXiFp6+PmqzmT7hvoFdH7EBdHK4Cvz89RAejPgst6vPtgW3orc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2FMtFgT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so5372112a91.3;
        Fri, 21 Feb 2025 16:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740182828; x=1740787628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MswCAZSr11JhdHu1wpbuxpiR6tFA6D+Bi7/K0hdahk0=;
        b=W2FMtFgT2X4ovTbDwUJUnI+rDnt/qemVXusabFUq0pmX+WdJkoN41nGnsKpaOjHAsm
         RmhNu8ixPXcW18iO7XxF2NnthSCxppK/yi9TeMxGCxu2WCPVkwcf+6hhNOMRB4I74OA3
         Qc9AXlQioNZ2DFIBCO1lvKEgtUTV243MoV1zONLQnv5eL81dfRWCazF64D/ZuvFrI0IN
         NEAHB5yh2XO0KM1IuFkIWzosBFG4XCdp/M5i3zDxH7uAQ96numVmW0RduqnUie1J5tG0
         JPTF7PqajQm5RsUemvGaaNC7YtB3tgD/GwMSA+Bn7SepYn+9pIzOE4jAkgpFh0rMIxgg
         WBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740182828; x=1740787628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MswCAZSr11JhdHu1wpbuxpiR6tFA6D+Bi7/K0hdahk0=;
        b=wkryXBEzVYq+bc7Y94j1Weuasdw/sMBB24z//VD7JVzmHJYPWaEc1n58rh/qTsggvs
         UzTkBRT6+0si50W9HB++lBvAPPJ+wMz1rIzRe0LOh6DUILW1Y51pdbrYBndJlAf79BK6
         oLOg01J12XEOLySaAcur22y0mtd6kiGiXSyjmITUPxz5mHdGISO24ECpEZ6TqOW9Zp2G
         deZGwJUwiZk2w72ZBC/65h4DZTIaOhYlVIHKM/82HwYMkh9uuXz2yThnmQctZlcJO/Q/
         JVeOiAetBqh25uddbkEa3PWc7sfYu4lo9IXgfXgVFI1NURwaAmbJJ/EG0fF9umUPvtDW
         XTpg==
X-Forwarded-Encrypted: i=1; AJvYcCUERFO0W6Wyhpbgos1l9l1946ouQrVMhfwtpFMr9Qxn4r9+8MbTyDlfOD6oFER3Wvp3zGTrtTyXRbRP1o+a@vger.kernel.org, AJvYcCX8t1EVxl5HftqpAML+d/dlyfBOsMpqfaEefPWeBD7ww9Tq1S43eJ7ZcuL7q6yqU6FVno+XfZRSpDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQwp0TcUVGuXpivSbo84PngB1uTDP9lDlE/3gIhr4E5BRpnCe
	iqnukgZaBs0rQwphrEARpwH3OSDg699zcJpV8WYpr2tsuNpK6cSL
X-Gm-Gg: ASbGncuASms2rHhqHSyZSoH2hb1b3T1fazp//zFjutR8pKtNUTy7nDmpvvyNvNy3bRg
	U/UyDx9Or1abqC/g1RtOHMayX3LvEqCGVoOHhJ/SNp4+/+uf8ipIRekjc3AtbhGBlms7CXNLLtD
	06d+oR7tR3z3GwDwzbdC7GCTyzf/tnXz5C3yGxgVvC3AwhlCEoVTlFERPbc0HivQHE+PHynMpYJ
	YO88WLCNiWEKH1aseKWOakZNoklbBIO4/vBf/AH6/1evJux8Pzw/ixd8085M6+CFe6GXbbXXSIa
	V/Jz4+Iv9v+vU+ghz/i5aQ==
X-Google-Smtp-Source: AGHT+IE+JUzncJ3icMuuqbvaTXRAsotDNDLEJLaGIzMZ36tKqpWXYEDIxlg16w83TwVii4xDF7xHAw==
X-Received: by 2002:a05:6a00:3d0a:b0:730:888a:251d with SMTP id d2e1a72fcca58-73426d9ee22mr8844925b3a.20.1740182828276;
        Fri, 21 Feb 2025 16:07:08 -0800 (PST)
Received: from dev.. ([2804:14d:887:95a9:5a0c:64ab:937e:e751])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73261ca7831sm13053223b3a.104.2025.02.21.16.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:07:07 -0800 (PST)
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
X-Google-Original-From: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net
Cc: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] drm-vm-bind-locking: grammar fixing
Date: Fri, 21 Feb 2025 21:06:42 -0300
Message-ID: <20250222000654.137621-1-leofthirata@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes grammar issues in the VM_BIND locking documentation:
- Corrects adverb "also" positioning in the sentence.

Signed-off-by: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>
---
 Documentation/gpu/drm-vm-bind-locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-vm-bind-locking.rst b/Documentation/gpu/drm-vm-bind-locking.rst
index a345aa513d12..05d1a4e0d754 100644
--- a/Documentation/gpu/drm-vm-bind-locking.rst
+++ b/Documentation/gpu/drm-vm-bind-locking.rst
@@ -362,7 +362,7 @@ while processing each item:
 
 Due to the additional locking and atomic operations, drivers that *can*
 avoid accessing the gpu_vm's list outside of the dma_resv lock
-might want to avoid also this iteration scheme. Particularly, if the
+might also want to avoid this iteration scheme. Particularly, if the
 driver anticipates a large number of list items. For lists where the
 anticipated number of list items is small, where list iteration doesn't
 happen very often or if there is a significant additional cost
-- 
2.43.0


