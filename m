Return-Path: <linux-kernel+bounces-516282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379EA36F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A7716E33F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E11DD0D4;
	Sat, 15 Feb 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlP7JuCb"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB78B672;
	Sat, 15 Feb 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634874; cv=none; b=mQOxo8ayAPRz7z2ZnpAQSQTagIaMyX+AWqiCFgK/tRoQG7yd0C5zfZA5aQN2TK39FkYa2Q7rBYhpkKfnY0/zg9JhSQAneVzZaavwRTOzjPfjYaC0j69ehQZbXmrxcpkD77b+TpkGzkStguN6U/F8MHn2ZCV/XYTR2zKm9QmJcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634874; c=relaxed/simple;
	bh=26GYFrHbr7JggtvPQTzzFsKlQey/lVDmwjCdKwDC8b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrW2FA7oibmXHltGLLM7FEJi5GZZWHwFIXs7h26TpKC/p+OdRDNsTqDomNTQNBbi91BiHNXGxYn4/QKZSbcTnDm7807bG/FVNRc6+PeZ55wrlu5xg8TdfzttGmEMkFcl4PSV9u/sid4sezydr79nX7tdm+pvjakFCKQ8ITMo2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlP7JuCb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220bff984a0so53573855ad.3;
        Sat, 15 Feb 2025 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634873; x=1740239673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qpP+HFn0u8S2m2Ngj2udrNOWfIGZJrWyc92xDPpz1k=;
        b=MlP7JuCbZO9kwAb+20yxbXjovzH6YWsxpp4crYC7f/qmIhq3/k0CiE/1cQtQx04Q8u
         rtLPmxWuWOWF3XVALfOtA7S7Baj2ENbAcjxOLPWMbZ75Eol+PuB3XFS4aWhYcjtkGhiE
         gkFIKkhN++cqkkq4lS9KJpxkXjkhDRg8lAvDoc7CWXajl/sVzNNff/Y74cucihAgn9iS
         EdXrVT8SDfzazF+x3osdJ0S9AFm6hbZxJL2SBbOqZN5wNHIy4fbhqv/PylarSmmrrk6T
         7Bmp/FDW6CSTmgw32C2qKePR1kbFyTHMpsGQb0eso+dvGA+TQe26u0y9p7P5URmrwPLF
         dgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634873; x=1740239673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qpP+HFn0u8S2m2Ngj2udrNOWfIGZJrWyc92xDPpz1k=;
        b=Bbqbk76G4dWMdTNroWtfQJ7N6D1Lh6cuT425SFwF61Tx9e3YyE+2pP5O9Y72mD2L5z
         9rqTm7980lH6ATnk5QOZsAm0DADok2qUguRpxKEgyvAcXAEwSJo1x3+30k4PAR5saWJ0
         /vg5WOuUo8fjDLYZPLLCFKEYXPlGSaQXgRE6c2d1QMO3MKATC5vYJPc7d9XJIvMSyGI+
         OFdIYMYYS6k8G/Gbt+l3ktvMbcDx6Rs5SQEbrAgoXPE5ogZDCV6UOGtqtIvDJQIx5N9R
         uP1U6pNLfFiuiA5c2Rft2/3fJwIEQqEmrw20lvS1zeWmUFh2o0r9KEc2KO5OfNOwixY+
         w6IA==
X-Forwarded-Encrypted: i=1; AJvYcCVqz4bWppk3L1cfnqSM/DSDHks9SBcRCO0V9+i7PW3ffQacGQn0nAj7YEh4u5eIsZn/59EvL7zv+eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhJlcFuaNx5V6VlUKqSgqI0P4M6jh7Z00OciP2M4eoWq/UG/r
	E7iJ0z2otuXE7HQkuKPes9jtCcORQ6wC7ysEnY+XV74/rOpt3YCc
X-Gm-Gg: ASbGncvc0olO0In0uedDT2Slx/qRi+YzHsbTFn5BhgKBYIfqL2sYPAgWGQTVeCs7YjS
	0rjiIf7NEVhYD41KVltdQX1mISHeHPuKwaTxhuyAOIl1eONmBu6PVdS+JGC/YQmYLtd2wawFvnz
	Gi9YhXuKMMM2WY+vHPwRXTe1KuSvnWTwv62yTLg5NWSpQvbPk30j6iVLby6oktqFYB3doLuZRGc
	mGT9vEU165e4vyENETS5Gmwts9J7o4Qa0akIImgcERUwtP1/qGUSyZzpx9LTafVIz6gfvofEBU3
	FGBlnJ2TwQQuL/xAzG1X
X-Google-Smtp-Source: AGHT+IFAPKdfxucRBcn45GGdfBU8PyxpnyKhZaNIMTaIZpbuVMsg2IsHifoUa5smmNzE8SEk/2/gng==
X-Received: by 2002:a17:903:2ac8:b0:21f:3e2d:7d41 with SMTP id d9443c01a7336-22103efec37mr40681135ad.11.1739634872547;
        Sat, 15 Feb 2025 07:54:32 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53492d0sm45286395ad.35.2025.02.15.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:54:32 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: akpm@linux-foundation.org,
	visitorckw@gmail.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH] Documentation/core-api: min_heap: update for variable types change
Date: Sat, 15 Feb 2025 23:54:21 +0800
Message-ID: <20250215155421.2010336-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation to reflect the change in variable types of
'nr' and 'size' from 'int' to 'size_t', ensuring consistency with
commit dec6c0aac4fc ("lib min_heap: Switch to size_t").

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 Documentation/core-api/min_heap.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/min_heap.rst b/Documentation/core-api/min_heap.rst
index 683bc6d09f00..9f57766581df 100644
--- a/Documentation/core-api/min_heap.rst
+++ b/Documentation/core-api/min_heap.rst
@@ -47,8 +47,8 @@ Example:
 
     #define MIN_HEAP_PREALLOCATED(_type, _name, _nr)
     struct _name {
-        int nr;         /* Number of elements in the heap */
-        int size;       /* Maximum number of elements that can be held */
+        size_t nr;         /* Number of elements in the heap */
+        size_t size;       /* Maximum number of elements that can be held */
         _type *data;    /* Pointer to the heap data */
         _type preallocated[_nr];  /* Static preallocated array */
     }
-- 
2.43.0


