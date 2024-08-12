Return-Path: <linux-kernel+bounces-283037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16094EC38
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02C81F22605
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7B17A587;
	Mon, 12 Aug 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVCWQfrP"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DD178387
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464004; cv=none; b=eRwlMXN54od+vaHm9iTym4uFEwy8YiNjV0XYp5vyceUXh/YZTDTQPGK3FnDhemQXfXh15O58n7Xi8RGuc9W6Lu3xYKvd+PKg6yN32QYU74r/eqK5NGytsM3CoR99hQ4LdNpP5c4Fvx5sQjx32J2KLxrPzAXNfJTESYcr9Bb67Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464004; c=relaxed/simple;
	bh=y0S3xQjkruxUj/Chc3SsrTEw1JQcaPlDIEiQXmm0SEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+5k7qdRvCMQz0DNReOAhqF7sF5R2l9LvTtA6pfBMMvAgw3oQ7rZRwFTqq1UVtHdW/bHEBY8iIhlPM3v4QUEIobjatuFPFLXQNf/nVoAB9nxI3i4ds2ysA1JWZuEzmcg0xtub8jMTxI5n3V5ZeG/FpzbVTkNh7Qbl8kxFnSGUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVCWQfrP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso1940795a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723464001; x=1724068801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJLe5IUAL1/xG0v/qE20AqL4y9xZWwRXykIQj0IeARs=;
        b=jVCWQfrPLl6RkiboAWlyDhAyFo/UAKhzrrI1ZdvBu4jNvQEs2ymwohsibyVnqWMCP1
         v7/1QMFzJWNzj5BqnmnAgCN5A2IFfAZr4KEn3kIR+3IA2rzGazOAGNGYDtGTE/HGX7lQ
         gcRGMsGkGXYr8MXMhgVe2ihdWAb2w1L9evahLfehNAkVd+XX0Miz4UN9Em8HdEUnQYdH
         Q1DCbe0g1+iYE26Hyp8p7fvozw+5MAyZKkXqyqABSBYNXMxpudi9Qx5FC2ge7Uz7Fk+B
         qbukxJp4N8alutT6H94wrKD20HLcybSPP96Wgu0LpFa+xjvx9GwXOaHB4hfTUdPD3k+j
         9AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464001; x=1724068801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJLe5IUAL1/xG0v/qE20AqL4y9xZWwRXykIQj0IeARs=;
        b=UtH5IDu4ir2PgDzxSWdYcatau6dWvGbLX6MNSKBRYh93tub4qwsPEewo/6YxzTNZ95
         MqKdFHD1P7SRc4oSVmivRDyRl4urq0/xcTHNETY6cxk8GCG/PqewiWxD2zJQ7i20rTZu
         DPPOG2hpxRJ28Xd8F1G4jUUaPpJ3bIbr5xKGnuKV6OgLVcuMji1BWqr+edSTcgC82Ngy
         KguEtDDmVm2mnH95Ak55bnNh/KCiBMHp82csbdb1RjFUx0PezOIblIg9FBhBmO2E9QD9
         j4enNJgyA3Wf/uAK80jSKoeKrgcS9taf6RpZeSfqcN9ps2/TAQcFukP1yJB3Ea5gd3kZ
         BqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTiIqvT+BWS6XrUn3o3JbtVTuXgLyjQLqiMHJMhQg2R7ON3vdCpDJONMMu8krzUqwsOdzV81qzK3UtM+EPBCn+3BG/J9Yn7XWNLQfd
X-Gm-Message-State: AOJu0YyrbNipxEZ/X0VnKRpkp8WwSx74a1YFzWAK8oCKRXxk3Bnid1qo
	CH7w5/uT/7JNSXwIWKbHYR3Nqw45QQtL8pR+hUKznzXgpL+YDBmr
X-Google-Smtp-Source: AGHT+IHLf0wX3sTf+xZ73mLemXQoM3mULwR0RMBbNFiKu9Xs4bJxq0l9b69j/UaSYylfIRYCAo7wzA==
X-Received: by 2002:a05:6402:3552:b0:5bb:9ae0:4a49 with SMTP id 4fb4d7f45d1cf-5bd44c66a3amr11213a12.30.1723464000709;
        Mon, 12 Aug 2024 05:00:00 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e04aesm2055970a12.76.2024.08.12.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:00:00 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH v2 3/4] percpu: Repurpose __percpu tag as a named address space qualifier
Date: Mon, 12 Aug 2024 13:57:37 +0200
Message-ID: <20240812115945.484051-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812115945.484051-1-ubizjak@gmail.com>
References: <20240812115945.484051-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch introduces per_cpu_qual define and repurposes __percpu
tag as a named address space qualifier using the new define.

Arches can now conditionally define __per_cpu_qual as their
named address space qualifier for percpu variables.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/asm-generic/percpu.h   | 15 +++++++++++++++
 include/linux/compiler_types.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c091e09046c5..5f85d7ba8e2d 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -6,6 +6,21 @@
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
 
+/*
+ * per_cpu_qual is the qualifier for the percpu named address space.
+ *
+ * Most arches use generic named address space for percpu variables but
+ * some arches define percpu variables in different named address space
+ * (on the x86 arch, percpu variables may be declared as being relative
+ * to the %fs or %gs segments using __seg_fs or __seg_gs named address
+ * space qualifiers).
+ */
+#ifdef __per_cpu_qual
+#define per_cpu_qual __per_cpu_qual
+#else
+#define per_cpu_qual /* nothing */
+#endif
+
 #ifdef CONFIG_SMP
 
 /*
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f14c275950b5..4c5917b97bc3 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -57,7 +57,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 #  define __user	BTF_TYPE_TAG(user)
 # endif
 # define __iomem
-# define __percpu	BTF_TYPE_TAG(percpu)
+# define __percpu	per_cpu_qual BTF_TYPE_TAG(percpu)
 # define __rcu		BTF_TYPE_TAG(rcu)
 
 # define __chk_user_ptr(x)	(void)0
-- 
2.46.0


