Return-Path: <linux-kernel+bounces-541850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA8A4C25D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC8F18921D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED52211A0B;
	Mon,  3 Mar 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUJF6Gwl"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEA1EEA39
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009762; cv=none; b=boO2eI4E36iyDcNa4pLZVkB/GterO0pblYfDkxgfAtxSL5tWw5oV5wrFDd02peCyna2TcmPeFgEqzgO9nMIknVkg3ap1BnrpqSJeQ5u15HJnQsQ006eLjcxAk3llnXLlCZKs98WqGt5ICogx0ebsP7CtExWm22hJoo2gFZm38Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009762; c=relaxed/simple;
	bh=4IR6p7pNM2EuGvYPhWLiNe5mtdOsdfBLuftE3zMrpUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/VMo34HMrDmnD0YvmseTskYVUF/doadwb7FHTj2uHG6yinkhaVHrW0SI/1dsBBdmKMxK3hnV8Xjt3fimmziFGwjI2mvh8FQNS3R6f867UM+8dzu7mxE+/J54CW4zhAjpUZwEkBNdSM+9VCrxbjzz7crpwYyf7bpgBwI0zseVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUJF6Gwl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so40956915e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741009759; x=1741614559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCH2D3zWQ9aZiVELC6JRI6HE9Q2yLkwG8BJVBtYm7QE=;
        b=MUJF6GwlcL/5MssLvweza214A4RDWSi823ZKLqMLun3jf6W0S0WP7iGdV1nyZ2Powu
         Y9YYNx4p+6uuL66uahvEhb/brv8aQLyY6ZkTC8rj5LF+KERQJ6WFs6LsEJ3BVvYPpGKx
         G8u5RXktCxyTFIXkU61iiRKIbY6wHR1AhmL8ubIOWOFjOOsADv2COLiMrCWaaaulWn5R
         yyxLKZMX0GmKsLrkic8txQQng9r10F1QMOyzeqx4LAe7O4O3w6lBPiMQB460zJ9dC/ve
         YIjWLnQ2Y2xERzVwY433ua7NJWmCiTi2NgK1ItD2i67Vp8psEdwBhJzf3Dq0T1amPUhG
         QIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741009759; x=1741614559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCH2D3zWQ9aZiVELC6JRI6HE9Q2yLkwG8BJVBtYm7QE=;
        b=C3VTnYJPpQaQq0lYWIVN4VgiWxR/F6BRHFzdW/JrM4AiBwvPCPORqPkTegsBHBzav2
         ZXkfXlXzoN8fpW3JvR/qprca7LTaWpUKRi5oa7br6nTHFmYS/EiCxTYW4smBMwtxs5hv
         OOkYP5t+6H2El2debxIMSHJRPBHWCFEOE7CfX9DwlbPaIl3kIxTSNkT0+G4jJlUEsaAK
         vp1EmQWhHEpLf9t7B6nBEA+Jtj90ODj+mFAGzf3d6hZE3+HmfBYXPcMPYOkcCSLiVqkb
         vEFMAv62pwhJ5RDkJEtLSICM5r1Z94GUOFVurH2JVRGFNdderYnRk9byriia6caSm06z
         fnSg==
X-Forwarded-Encrypted: i=1; AJvYcCVcHthK5TSZDZxKE4ycdV0hVZgCyZu/r8ASicOe+ShXpWDJHM01Hx8xCTDGVUSxD1FOHxpYtH4p0Jq3uL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs86TADIPQalxkIhp2+L/tKEmC8CMAI+9WaCou7MA95JqGeIRe
	J0N9YqeXdpShLtgh3Xknc1l89d/SHA/3ILzYFhVRbFRRnD5v/HKC
X-Gm-Gg: ASbGncvG8Sy0Ssti3hNBlBpFWYvPHJmb3kZ2iXAOmAGax5i2+ZY9HxsUv+pM4La0iRy
	sONQ3ChasH1DqL8Mbwnh5MPOkRgiFNntdi9YaHP77En3fyCKe3Wi/GHf7lXwf/0ld9aH0Nid7ow
	L7zAVbpVKd3zc4rr8Vduc7yOKMmiaNBxBEfQ65PgJsjT08dwUzcokkNeAsEkwWk+wdJFFMT0991
	lTnddNAe9kbDjn/OCmQVipxGYomijCgEkAB59Tk+K6aA5yZbygjmYliYAh0gwrSE4/KelS7/hbM
	B74C9MnLTAD/LgiE0rdWm8d8EKQe/685c/X2eaGPdgpLIZgaUYClQC9tctBp
X-Google-Smtp-Source: AGHT+IHLaSEcOTw3V4i2e2ceWC+Ez5DIHnXoolAHJQuzna6++JTHe+PFx5OS7DUmzgpMLHxqdoOvuw==
X-Received: by 2002:a05:600c:45c7:b0:43a:b0b5:b0 with SMTP id 5b1f17b1804b1-43bb3c32654mr54557535e9.4.1741009758623;
        Mon, 03 Mar 2025 05:49:18 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc24a51bfsm36166765e9.10.2025.03.03.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:49:18 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] signal: avoid clearing TIF_SIGPENDING in recalc_sigpending() if unset
Date: Mon,  3 Mar 2025 14:49:08 +0100
Message-ID: <20250303134908.423242-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearing is an atomic op and the flag is not set most of the time.

When creating and destroying threads in the same process with the
pthread family, the primary bottleneck is calls to sigprocmask which
take the process-wide sighand lock.

Avoiding the atomic gives me a 2% bump in start/teardown rate at 24-core
scale.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 081f19a24506..4727b108d842 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -176,9 +176,10 @@ static bool recalc_sigpending_tsk(struct task_struct *t)
 
 void recalc_sigpending(void)
 {
-	if (!recalc_sigpending_tsk(current) && !freezing(current))
-		clear_thread_flag(TIF_SIGPENDING);
-
+	if (!recalc_sigpending_tsk(current) && !freezing(current)) {
+		if (test_thread_flag(TIF_SIGPENDING))
+			clear_thread_flag(TIF_SIGPENDING);
+	}
 }
 EXPORT_SYMBOL(recalc_sigpending);
 
-- 
2.43.0


