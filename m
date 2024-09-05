Return-Path: <linux-kernel+bounces-317007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D496D839
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E201F23037
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188AA19B586;
	Thu,  5 Sep 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJxiXiS2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A519AA73
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538831; cv=none; b=HKcBdL+/PtaUYf6o9q6f4UuJlPtIhQQ7UWZHQhECQ62q7yL0Dr3P8IUhOE2cJvGyYqZRPZAJaD2FnRpKwmIzwUCSlZTuyialMXYJJ0j37RxU341jGTK082Q9mQstG6vHPoZ56HFSaKJtY/z3Ge8my6NLekqxYdPzNT/MIisr8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538831; c=relaxed/simple;
	bh=B4HsB5JTFcZx/3UmXg5kJYDT+276ogTXuAv93PQoulg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7e2WZvBa69pW42Qj7R3ZSb7TuFwiEpY71YyjI3Wf+pWe3cy+07sEioEVod0yFbySQW1lWFdB6G6xNQ/81X3rMBiM+NMILMOdM2maBi9EpvgBbJGi0NgRamNQdD0vV3p9h4nYWvyPMHSIyrUA9snnJHpcztC410CXlDXm8S5J98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJxiXiS2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42c828c8863so5790355e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538828; x=1726143628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmC0cwbWYy0PINgCEggZvS0/yLWRIChFwqNLu1TF0Zk=;
        b=bJxiXiS2B47uaNewddAvWRBASN4cYDrFJmsznz+72TJyBPyKdJZVFKXpXlihtzhRwG
         KpzVm2VNrSjroOZPjrxwk/OpL/I4vaTsVut5FKsS07rJbgNeF5WJLqOR1Efq6lJ/qsAs
         jcHOF3ImfFWZmkDvm2tiwajgHej5ONTFF2AijXGJtxvUw1TeGAtPDm8WX0sqG3ycemyA
         E8jj51CATjPDy3WrHJ8E9wBTsmVypN5rMN8gAhMInJegG82viFlJeYwg++x3R3pAAOtR
         f4EAQHZfJHi+RE6iTtji4WiwYq6zSg9BDEZshOq/9GUStfkbjiXPURDVT9dNoiGTtpo+
         eWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538828; x=1726143628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmC0cwbWYy0PINgCEggZvS0/yLWRIChFwqNLu1TF0Zk=;
        b=cLP+o1ojN9WoQFXgQvg1KXZYKgDxYvXlu387QnVHyeN/Td8g+oRtxRYKBs0HUQPBoW
         BWkJqhFcB75ySV1cD0TbYX7LPTV1B1YN0QlkiH9LqBI+uzDN/fQ4zAeosmtGzqP1MkBV
         IZkHEFCGx3zpqkwnqc4bEn6KEh8qZAw/8aC1xqGJ5mHWmnqioh+8Lk6mnyw5acqIsWx8
         dzjlDUHOuoFHSnXDmqSu5DweabDJ7uZKWlrwJ1LE6K+X1ZnxBsTwQdcpqo9OKSbsQFPe
         IG3hVoGbssHUF7MqHeHC0Z35Gtv7J1Pu69tsm77SH1ZQzfziUjDncT3osjnAa3NcsaW4
         PmeA==
X-Gm-Message-State: AOJu0YyEBteY2Wvqc0w5vPpgOpHN+zR8mnDWngL8klQZPB1BxftkaZ0C
	nxQ6uDdtCHMVORDWcKTkt+SmCuaifNC2aNGSAZWsuotVNKDu53p88EMfhyAeXi4=
X-Google-Smtp-Source: AGHT+IFOrAJ/BzP2RxpP51QkumzuXBczN7y+owfnhge1Dq8abyly4pAUBmSG7ZpzAcxKXH6Vh+nEXw==
X-Received: by 2002:a05:600c:5123:b0:426:6353:4b7c with SMTP id 5b1f17b1804b1-42bda2ce3a1mr124453465e9.8.1725538827139;
        Thu, 05 Sep 2024 05:20:27 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:26 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 01/18] x86/kaslr: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:09 +0200
Message-ID: <20240905122020.872466-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..e17e6e27b7ec 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -22,7 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
 
-- 
2.46.0


