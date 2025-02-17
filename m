Return-Path: <linux-kernel+bounces-517182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1EA37D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C371894971
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30E199FA4;
	Mon, 17 Feb 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CxbrPuFE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5711AC882
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781918; cv=none; b=Caq+x2ALPMK6bloNEHQ02rk0/IdIgbiKJdUYpLbPc4hQnOaIhRAR89pMwL/lhOrplGh5ImDcDuzzWxQ0pL/JpU6T8PXRaoVZ8t19lqzrSG7ktAUwbwgh9VMYqhnVoNf07FqIQ0cOtY6y+CwNnm6rHDmdNid7qE0gf+hd8Tbr7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781918; c=relaxed/simple;
	bh=4KWL7WT4m2P9Gzuj6XBNp3VWAe3nw+1IhcUCc4X7DHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzEFioBMInTKhe2KuA6JsTHPQUcRqFY3UWbr+nOPLaW+CnP1CGWjZLfScZoOKTkKgIg9VOtGc6r7IVStEIUFKv9H30o2oxjrmtrf6NwnwXNR4CRCz7m49XrQynrHn9Ww5FYHJamTZhvOqb5EAS27avG+Oh4JCMHXD1DpZFCHUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CxbrPuFE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f31f7732dso1285300f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739781914; x=1740386714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUiohrMXynF4IhELzrFmGh0geLQ0Ng2lOgwpKuwejQg=;
        b=CxbrPuFE5cerjU+oX0UCAN6SJlWfaT4dtNFADNy9//P0fK8FV1y/bzJntSwlQD9wSt
         Yl34LsKS91cH8ma9PYaSo1qsY99yz9TPxslCvW0ZaJU3tWX+eRV2pIHwqLkLT9VGmaYH
         molh6ZwTLG2WPSnjSJbsTiB2ZBvuQqac0i12lE478Uj6Edvf2pZa8wuE70P2kRRy3RPu
         n2s+igJ6YDEQvEHa9XDlFGXE0K2VkE3tnOynClSCw+FKiObkJi+vf2xIpkETdo7VY1qR
         vgtNcK2o0bgvVTuweXHt9cHvGH1lZHOVSVhtp9040a1hL95uO/mBuf1IovF8qoWs5mCE
         3MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739781914; x=1740386714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUiohrMXynF4IhELzrFmGh0geLQ0Ng2lOgwpKuwejQg=;
        b=NwAKD3ct1AlRXIkUqCh/fA8IF46bGJMNzPfTVSnU6d4HXYyXGtvP1WbThPfjv4JeGo
         xRbCkqAHLG7VYl4SLqcq+gmPkRcsKn74oY3UhBYYUNncltMOuL2MFJUAgWsJI2guBt7w
         gFCwDthvREP0LX7IkIajKpdiw3ZSZjrzPLj2RXPqGZVEwQeMVCZXo9xoy4UG/GMvoYVw
         IAjqIDUlV2JnwCyV3MqnccD1FmGhZ1lhcPdfETr417MCFnxM62m7yhZUjcyiL0vPUn3N
         6pxnEh9loT6vuT06U7TRNP9C1/msXqc3Tifwd1rXJ9+BxPmNcU4Z2h3hu9AA8Kw/AK9j
         FNYA==
X-Forwarded-Encrypted: i=1; AJvYcCUNFct5XHysseOvJ/qv8s7HGgK5Bp9AGmv87ltmX2tb7sS7UhJQqCdOTSIQmmJ2+RVhsU/65MZkOJKSoCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU4U8bVr1eRpLPz8JA7W5o7Y46WLGW5vuVzmLpX0yWpwH2rfa
	/Xq1IJAy1AxTloxnnir2X+TIxEbFOl5+My2qK7BbnWnHXZE607xLB+p50wRlbjI=
X-Gm-Gg: ASbGncsml7pgohSbtNpV/mbKbFApL9priE283T8kerN6gA7JLlPbwp7FFtI6E0TAYP4
	yyMJaPIMHSI+Ig4VTkQny+tZSZshF7KjmfFamKEPR9kpaaN/XwQUvHwG6K2Yg+ZsCMTT9ujYTst
	30Pvi+WZR1sWdZKfVU8+uQx6Lklvvkv9H2yxO2jd2fxpK+P5ymMjpMUM/i3SlXGADMWpTKWl/nL
	lVJfwr7w2+rAxovqsgW/kBJu53qebHxL5geGZ6mZxfRpu+tpGmOzvJyP0xuMXty3mvNjBZ0e1JM
	gCA=
X-Google-Smtp-Source: AGHT+IELeloq+YGu7jeWFNzVErrIwYQyO3BkZOQqDo2NauOC4G+f26bXlMmY85lR2Dzf3d+ItLp71w==
X-Received: by 2002:a5d:64a7:0:b0:38d:ae1e:2f3c with SMTP id ffacd0b85a97d-38f33c2886emr8174108f8f.25.1739781914336;
        Mon, 17 Feb 2025 00:45:14 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4491sm11387499f8f.7.2025.02.17.00.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:45:14 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com
Subject: [PATCH 5/5] riscv: KVM: Fix SBI sleep_type use
Date: Mon, 17 Feb 2025 09:45:12 +0100
Message-ID: <20250217084506.18763-12-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217084506.18763-7-ajones@ventanamicro.com>
References: <20250217084506.18763-7-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spec says sleep_type is 32 bits wide and "In case the data is
defined as 32bit wide, higher privilege software must ensure that it
only uses 32 bit data." Mask off upper bits of sleep_type before
using it.

Fixes: 023c15151fbb ("RISC-V: KVM: Add SBI system suspend support")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_system.c
index 5d55e08791fa..bc0ebba89003 100644
--- a/arch/riscv/kvm/vcpu_sbi_system.c
+++ b/arch/riscv/kvm/vcpu_sbi_system.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/wordpart.h>
 
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/sbi.h>
@@ -19,7 +20,7 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 	switch (funcid) {
 	case SBI_EXT_SUSP_SYSTEM_SUSPEND:
-		if (cp->a0 != SBI_SUSP_SLEEP_TYPE_SUSPEND_TO_RAM) {
+		if (lower_32_bits(cp->a0) != SBI_SUSP_SLEEP_TYPE_SUSPEND_TO_RAM) {
 			retdata->err_val = SBI_ERR_INVALID_PARAM;
 			return 0;
 		}
-- 
2.48.1


