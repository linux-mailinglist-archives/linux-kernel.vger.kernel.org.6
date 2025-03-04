Return-Path: <linux-kernel+bounces-544092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4BA4DD56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D81894F77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250F202C2D;
	Tue,  4 Mar 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Qwji6+5/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DB201100
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089622; cv=none; b=LsZBCb5fMgl/z057rMz04hz9JHEOPy4fbFKHkd+XKS5xEmnnUwOMtJJkAm2ZmBYAt1dScNaNncFiYFDncOCKT5nliHwp7qVfzCHVjLaPlz1XrpMQmXy7PqWNf9rJhJZTkF9/kNlfV5i/wqh3eqr/bABKDJNYiBO2+4LIVk6qG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089622; c=relaxed/simple;
	bh=bKMa8fqW6fjvU7IC3trRLzO9pEfTAhYdgpAHUxI/OBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7jbwvhYdp7PPhz3oPMhQxMHFR1BD/MaEhoBGHsk3WHE8XiwY/KUUGsvL088cmp21xEFUzNcF5WLNxPv4BWj/9scQIS+DUPs4yzH7ISDDIoGuvbmwMa+8zJYUgsmHqFlqaKZsenGnuG/3FZyjy18oZE7pBENgGVjoFLuxFif7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Qwji6+5/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso602825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741089618; x=1741694418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoVXTPIMs1CQCffXwitKYw9GB5bSc15mRPYc+pFsBJQ=;
        b=Qwji6+5/VTF28jPBNsvck4WH3bCdkBox/CpQySMUy7f1cBbLWvx1jM/ZrmFqbRptvg
         Zhu5mDNts4HG8s3mpw0Zxm+RbuIzJ89+0cf16mzFHjljvH1mW0FpF28j/I2iWgjRfKW1
         ldhGibk7eZRbyzJRE+Xj9G/9gZp5EgpuHPYQpdHwWpJv2KLDAW+xgAo/joq+6viz0/4D
         ihXMRIR4K4vaj0HYQPgQQKGK7TXOSa2e2OqGG6kzd5gl3xCkoshbbDFYNlE+2jG6xZXr
         sctRpjnTDNJhI/UEAxJT2boTewuQaowVIz19Oq/K3kN/3xT14XMlXe8+e4JMTr/7n+A0
         P0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089618; x=1741694418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoVXTPIMs1CQCffXwitKYw9GB5bSc15mRPYc+pFsBJQ=;
        b=gJ5PaacqdrBAYA79lxIEZRGezT6IqDmN0F8513udUdRk/gYMNUk+YQBLN0wOjwwNy/
         aDh0G9PuXchdslvQw/tOzCG3atxyT5tkftmjPoSbjhodtQdRIlk9M545gVsfAo7Dp9TG
         P6b7zJtQHNumEaRnfrNoORvCHCIfgwaqr4NfoaSWdClu8U0P2wjS6Sbxk2rkmK9dYepK
         Zd31WZeTe/383VrZ+nLg7BwoBgi8kDJJ0nBFJ4HwJeT7+rACbOL2DMQZD1B8aqSuj754
         E+0H/IQR9TO3L/eeYCAf5aZqwpMzGFVnDJRlBnWBmDXGb7/kJzO0Pg/C7CIWmvmUSJfK
         ahBg==
X-Forwarded-Encrypted: i=1; AJvYcCWcHVXnj6kfP5Puc2pxvGGewTYXXgXjBl68pxCInbI48llrQzEdv2S/vxMfI0yqD34zh8PEjlx3vGOXGwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBc0PaIkEEG8YOwTqjGqNeEBeaGykPN2UKF11MQMInZXaMPDd
	MLzYcqCC4DXUwT4xO7HgiIwXFC6HYAA58Tz+vb56yxuhJt4mAmDQRw7/g+r4QpY=
X-Gm-Gg: ASbGncsD2t7kU1PHx6ttDKiUfNDoMGpWksR+Baq55SZj65pWc4d41/AxRBPerIIS7GG
	5fHqAEGvEPiOIuL+Mn/V4fF/Ia44S3HF0RJO84nJLTjykNs0ZVDcFQqjLt7KdWU6xZHAPmzLeed
	6G3S4nQtRxFA4wErA0mQlyzKd1r8IcHxkZBd9LAQS8sWGLwsQ+y7Ih0JLqoFLEwUvt+yM7o4x4D
	QgLrNKzC/ymIOieuifL2B42lk8+ouz2FVg5i0rMuzfntPMVx6Jejj7qwpCmbvpogeGOORgVJaoo
	VZaLlLCHaLOBwKyHVtuiq6kC1UA4xHqn
X-Google-Smtp-Source: AGHT+IGSlj+jarr0JPc4Azcvd/gVJrRnnAK8bPpcD6KvNf1uMYM/W8wrPief42jLDcp+dxdCRnmVUw==
X-Received: by 2002:a05:600c:19cd:b0:439:8346:505f with SMTP id 5b1f17b1804b1-43ba6747836mr129232375e9.20.1741089618179;
        Tue, 04 Mar 2025 04:00:18 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e13fsm17295914f8f.100.2025.03.04.04.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:00:17 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 2/8] riscv: Fix riscv_online_cpu_vec
Date: Tue,  4 Mar 2025 13:00:17 +0100
Message-ID: <20250304120014.143628-12-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304120014.143628-10-ajones@ventanamicro.com>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We shouldn't probe when we already know vector is unsupported and
we should probe when we see we don't yet know whether it's supported.
Furthermore, we should ensure we've set the access type to
unsupported when we don't have vector at all.

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index b7a8ff7ba6df..161964cf2abc 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -367,10 +367,12 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
 
 static int riscv_online_cpu_vec(unsigned int cpu)
 {
-	if (!has_vector())
+	if (!has_vector()) {
+		per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
 		return 0;
+	}
 
-	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED)
+	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN)
 		return 0;
 
 	check_vector_unaligned_access_emulated(NULL);
-- 
2.48.1


