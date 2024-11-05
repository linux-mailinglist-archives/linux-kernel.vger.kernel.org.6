Return-Path: <linux-kernel+bounces-396726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2B9BD153
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0868A283374
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8BC13D881;
	Tue,  5 Nov 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnpqSMij"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD81684AC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822302; cv=none; b=n63PSjRe9ZQCrJsbl9invGZQMj6i3QKJHFvPjFjvLDbidOtf++K7McpHKIQDcShd5XejKmLAaFO20t5aJDFqTHPodjdQlW4OtMbhtcrAwVWh+5x+rf/bpsyP5DmbyRa3iCiSijkpEhJbB9DGdTohqp0SeWzFFidj0S5KF8h3hIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822302; c=relaxed/simple;
	bh=C5MS93fImdZxHD4p7/Pkreols+ipmbOgNAHJMcHx2yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okbyKNU/E2XQCsOCFDTrGN5tub20CqZDh7tBm/XVHiWsDg+crKMT0WOABxera0rBu3q52izk2AkFb8QKtbWV1que0N6ZRG83yNu8BarVlL4pnnWUTEHrJYLqEkgPyR4O6rW47Z6+rsBVJ2bxBDYeqmI+6cn38XLh4xU3FeHThoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnpqSMij; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so48317826d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822299; x=1731427099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnt8p1LQSCyPDZC/m5+ANJzjUqJreA4g+wlCc2Z5tNc=;
        b=SnpqSMijUfBP5j70zYAFLETHp74G0zUZUx4DIKtpcOS4f0zP2J3r95iapzf6g0cOIM
         V5hIDbpLbhZgd1q3Ixrb3Fck5EMK6gXPQvhBbJlD4j+BJ+6IS74cLlkI3Pipep9lSOSc
         qsM5Dmux3URdEPm2sJWePPwK2ocF1lkDVPNrtkYqlX/zJ6Ew5gd7DWKEuMGX/XyYEklh
         wlUA0MuRa1Q/alraEmAY3lW18HJc4VEu8KHjdtxJmpGmzvRNmsVS7KDObmktamqkztYE
         nrxRyUWdbg4LmHNYYfXdWx3MI/xBwY8EJga2MPt4V2AaorkuBYumv+TF5PTYJdkKJQiM
         L6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822299; x=1731427099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnt8p1LQSCyPDZC/m5+ANJzjUqJreA4g+wlCc2Z5tNc=;
        b=FVIaNCYVxsnigIaOnattNQ0MkE5TAMldmS2uIP1Qk7BXwOSFtoXP+LNwuhTuNJy41a
         ddAp7Y8vm6Z2PrkV9GsW0ecYb6so+Ki3Z70wE80tGPLKSy0Mticml2KFarg7PHipQQ0S
         7mOZpxiihBqT5S0+eZ+xjoVjsBaO/Fzz8XAFsc1t0Y62JLre1gOoMT4nudICMOzmJwJa
         YpaF4+1d/2U/GMMR9bwSeZu9sYqoR+7ecLIWmG9Fn3eNnsSuqKt4Cg2QiMEXIV0wkTU8
         f52NiTPcJ3CXCHBfUsxFS2FtZwiwivTHqJLencXQx9yubCyY8ZGoBE4r44ZoBiGc3O4+
         kxGQ==
X-Gm-Message-State: AOJu0YzJbLU4s+3onnCRxg8S+71tH8IxsMcyCXw5BXX1fkPBhfBj6hqy
	zCEPwnRmAXOuBvg9heM+g5g/1rpxIJtAo0OPwHTuOeD+uBEV481KNK7X
X-Google-Smtp-Source: AGHT+IFoChsQosbw9PPkr0fRJBCDyQEHPO+vqMCXdORDQ80dF+Em/aubdAPmSAWl8ig3vUtGoAudWw==
X-Received: by 2002:a05:6214:bc7:b0:6cb:f904:4633 with SMTP id 6a1803df08f44-6d35429b1b7mr248681566d6.9.1730822299151;
        Tue, 05 Nov 2024 07:58:19 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:18 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 04/16] x86/boot: Disable stack protector for early boot code
Date: Tue,  5 Nov 2024 10:57:49 -0500
Message-ID: <20241105155801.1779119-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before userspace is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f7918980667a..f42c0903ef86 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,6 +44,8 @@ KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.47.0


