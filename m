Return-Path: <linux-kernel+bounces-537220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082AFA48948
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DDE3B29FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33226F464;
	Thu, 27 Feb 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8VWQnVW"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0E1E832D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686028; cv=none; b=XAP7njSCPQdazYh9wwz53omXTnUqfe3SwhlhhmCNfS3e2rUjOgaMfv9m+1uGG5mZrBmOH/YobuhZ3TJ/A+S/52dmII33GM8+4p+St7NmjP4khamrYTc2XMbvnsJzzf4WV7WYFBS++SkQ8gx/l5ATgurX1PgVpKM6ghc5mwgCMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686028; c=relaxed/simple;
	bh=Z1imD4nLMSM1TpzUcHNPyQuKWi5/3r6RBRHqdZrkJbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmmKzVVPL9VVvOpkX1LQ+GXBTuGem9EbP/xqf4Bh6LxGyyB+926OcksK2vruTEF5e8fbMlYJb53oKXOgwJJmCxKTVVZEWJWafq2WcXtxtVOHme+hK39u+GqtBENUIvbVxXHKNKc2i89h97A+tKfmyrZ3CgrI25gE3RsSoCwHZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8VWQnVW; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3fca56050so824544b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740686026; x=1741290826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YsfZmBaPtMyAupU0HUUrIF0S/LhwRl9ecnK+DKhpRw=;
        b=B8VWQnVWtI4qrNn/sj47NhWbR+/qI0NkmCXPrefhoKLjgYoa8QFK1HS5/YgnJwmx2B
         jl6wJcJ6oUucPx9m5a+Rv6XrzX81fObJE0vfJswywsh08vTaTYXOu/gc36LWKt/dFUJd
         Z1Gcme0XfrYWpUzXbHBTfEa1yujQMAqelURQNIKyYQG/uBU69aVK/+zOj6LPk+dRV/+J
         xGMBkCDsOrXgMamk8Z8iSsQrg5B5+ZXI1AluJv+bvko+ho1IVjVFQJyBne/8Dzc7Dt+e
         AolvF85blCrnSD4STlHw/7qRr8UUQN1e0wy/ws3/Z3iVEXS679KioC5dMC0MxOcbz6Rf
         e5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740686026; x=1741290826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YsfZmBaPtMyAupU0HUUrIF0S/LhwRl9ecnK+DKhpRw=;
        b=heRclfNtJzOeHDNisZ2KHcVd/uxtB3DKNnlsc/RWsrLqOAgsvxNxB822qFsfi7tfVZ
         vR/UZ/V1TeIDs45hW8Cf/T7DYwlq6CzRVl82bQU0HKHjtHyDSBJhl1+SX3boubrLM943
         /B1xtryUr7oNqm51AHVqY2all6T5X6DP6gbnSQbf85cyIXA/kKR7JiRuarB0su+rKmKy
         RB3IESxctikf+iEZjJam3jybT4HmM0O9n9VlWoiSWPxOEW+EvkH6DQ2FAw1BwuuWNanm
         4rQ3fKKppcAw6RuNY2Qj3fboEK2CMpyEEAGKuuryOE1Njj0SOk8Nd3F0eyiFGqiQeluh
         ww5A==
X-Gm-Message-State: AOJu0YwWPNlts57zaQUneuxQXTUc9UG86lEptDTG2owDQcsZcRx8CfDr
	1nhPJy6iKGsnpcGbqSRpdrDSDHVPfG/9DPGZur5+zD/5VXb41R2z/w2W
X-Gm-Gg: ASbGncu1rVgCXZyBEpm9uvu7GJLjPTaasbksqfc2ORbDBkmBRclxInrqgsm9HCiJBzC
	V1kVvrZPhOPOOy+0n20OJPJiaPJcpU6I6L+MGYuw1DRPh5kU6TGKd5JGON4LTaecXIcEmINdU94
	k/GNToZHHduB10Rx4SKzLaU/a1hSPPMufFiWnhha6QNls4oSykP82BoMMBadqYL2a++yptR/S+B
	pi244XiRMHuwlQE5VPQTabtzzE/2BcbitixiTbns960VOsQlpe/2raMIh2kKLScFJivHOl/6U/0
	9yqCeKI=
X-Google-Smtp-Source: AGHT+IEC7CV/1ufH17zNQ3pIKbKtW58xZ0kCv57ILXNRgmGnS5O1a8nVNkbTzCeGyOb7P+wTEhjtKw==
X-Received: by 2002:a05:6808:38c9:b0:3f4:1197:29bc with SMTP id 5614622812f47-3f5584ff474mr446465b6e.10.1740686025738;
        Thu, 27 Feb 2025 11:53:45 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f5506c76c3sm353418b6e.18.2025.02.27.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:53:44 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH -tip 1/1] x86/bpf: Fix BPF percpu accesses
Date: Thu, 27 Feb 2025 14:53:02 -0500
Message-ID: <20250227195302.1667654-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to commit 9d7de2aa8b41 ("Use relative percpu offsets"), percpu
addresses went from positive offsets from the GSBASE to negative kernel
virtual addresses.  The BPF verifier has an optimization for x86-64 that
loads the address of cpu_number into a register, but was only doing a
32-bit load which truncates negative addresses.  Change it to a 64-bit
load so that the address is properly sign-extended.

Fixes: 9d7de2aa8b41 ("Use relative percpu offsets")
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60611df77957..f4859516b190 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21707,7 +21707,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
-			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
-- 
2.48.1


