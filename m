Return-Path: <linux-kernel+bounces-354058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97D993700
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5091A284C01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038D1DE2D2;
	Mon,  7 Oct 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0+FuOw6"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E51DDA3C;
	Mon,  7 Oct 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328302; cv=none; b=TDfghLLvhm6oCrJTmA11NyMD6lw/QaAK4y97A44nUE82/1AXaztHTrs5CMKwwkxhs5xIqndYf9R7rkbP9Q5DRpDo3n8zxM4qceVjpA57u2NtSoXLrZfHU02a5JoQkKnJz7xOEsK/FR0tUfCcqZa2/0NXLCVkaHQCrWDsuKH9/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328302; c=relaxed/simple;
	bh=rPGBpUDmuluYM3kPA2v2k+S7mMp8Pnj229p7YWfRwxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quPQiJ+KgiUnEPWbB1Iib/lJn7D3lgP3BaWVZL/HdtleRVl9vtQzv0Vz9kevvrZJ5hyHf8oii7go+hYMau5SAbpIXe5j+FoRljr3+/ryjjS8rVvvDCuB3IE0rYjMzYJgi5J6OHOP5UiSjuyEFDtau7IUoqmqf21uN/BcbBT7wQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0+FuOw6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e02249621so961822b3a.1;
        Mon, 07 Oct 2024 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728328301; x=1728933101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vKrILaV3KipAnQWlC9aofkDkZksYMkXQccgQRs1O7M=;
        b=O0+FuOw6MA1HMukF+smTq0/3jbIR407OEundkGnPB+o4fJ3I2iNDxmPjtrBPQtYauV
         mf1yKxvbs2YJiNPy1/3iJO/k+nY9MMsBgslsrD1rJj/qWCe8EvaF0Z/6Vy+3j2KKsiPC
         vxeNBuh0lVxhMMr/m8yJi3B/d+U0sa+NTR5qdbgLv4Ah9Ad8ItNLB0icqvROQefoaRAa
         wpsQ0hdV6+jIo0Oe5cli4DcDUwcaoMKDYJYYzlUSoZq6h6WpRG3YB6hvfeuUKbowPzAb
         gCXZTXFXLOI1ovNgcEvb4Tw/vHApIsI2Oxu2pPwjl6ZL8HQ7LGxghwIKTfAjCsTDZ+FL
         1wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728328301; x=1728933101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vKrILaV3KipAnQWlC9aofkDkZksYMkXQccgQRs1O7M=;
        b=ClGOx84H9z6IrWhs/F1lympLGb79DhEknwSBjufZI5pdbkJV0sDaKJ57SwnUuv6hJL
         C+Lfa6PdCBxc93f3SsvMseGYCPjVOW2WZKGhOeCtEczVqabDeReoW3Ul3f9fwU0GIB8H
         KujS2XU4LeJ+qA9+WLvUpIqIwaeZFRH6LYN5KoQrcNVrTo7Qwc0HkIHxIrShmYh5Ifbb
         ERnYHEmdIjNl7kDhMHFG/r/wST6yiTJI8FmGYIvHTMvgcqNTn3739PNfE+ZpXaA0r/kE
         VKVfKw0e62hCGtnLd5qBmSBczdVJWEK9hkz/vx2BU3PFkif22+loMTc+/qX+yKsCGUgW
         8+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHPj4oCRY1zwABO4Uupw3VU3hkz+NMOODRhbdTf9lep6DfRHQYOOclDTqLN2yfctbcVkJFDFl9K3bvDiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4m5nnDKuzTVXp045bAaMMXjvoIks0/kzYA5sNjnKU8E2J7PlI
	5po7o9MgZNlbzgRhVUUFSmR8fbiV7DS6KO9xM/qIF7WhQbB/ZJy1
X-Google-Smtp-Source: AGHT+IHt2c4t3x6zScjl46pQSTnSV7WKaMG2I62ck+vL7P7P5e6nUXMmEHBm3SNFhAxfzsun5GFGcw==
X-Received: by 2002:a05:6a00:3a14:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-71de22e1e3fmr21909998b3a.0.1728328300780;
        Mon, 07 Oct 2024 12:11:40 -0700 (PDT)
Received: from vishnu-pc ([117.248.56.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6af99sm4740165b3a.184.2024.10.07.12.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:11:40 -0700 (PDT)
From: Vishnu Sanal T <t.v.s10123@gmail.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: [PATCH v2] fix grammar on false-sharing.rst
Date: Tue,  8 Oct 2024 00:42:54 +0530
Message-ID: <20241007191253.112697-2-t.v.s10123@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002100852.70982-2-t.v.s10123@gmail.com>
References: <20241002100852.70982-2-t.v.s10123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix slight grammar mistake on kernel-hacking/false-sharing.rst

Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
---
Changes in v2:

- revert inadverdent mistake introduced on the word "randomizes"
---
 Documentation/kernel-hacking/false-sharing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
index 122b0e124656..eb0596734e55 100644
--- a/Documentation/kernel-hacking/false-sharing.rst
+++ b/Documentation/kernel-hacking/false-sharing.rst
@@ -196,9 +196,9 @@ the hotspot switches to a new place.
 
 Miscellaneous
 =============
-One open issue is that kernel has an optional data structure
+One open issue is that the kernel has an optional data structure
 randomization mechanism, which also randomizes the situation of cache
-line sharing of data members.
+line sharing among data members.
 
 
 .. [1] https://en.wikipedia.org/wiki/False_sharing
-- 
2.46.2


