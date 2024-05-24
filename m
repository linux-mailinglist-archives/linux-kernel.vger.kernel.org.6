Return-Path: <linux-kernel+bounces-188608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ABD8CE44A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CB6B2218C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DA1272C7;
	Fri, 24 May 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FFWFJxig"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B92126F21
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546823; cv=none; b=OiqESYnomHjCeGNYZ4Xwyw9i7xFCVNH/aqa0S3I09PeLpTFJ4HDMp03GSfFnkGmGoc4VLro4h/r+5SJgaFs7ltXfq6qeuYqWaQJnvbW+KWascEYyFtk7zj2TnZBijqvfdFQPVyt4iRYILWF4ql8ZM5ldMsTseSAWR1SFmY6rn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546823; c=relaxed/simple;
	bh=N6ieQ+j4rtNAffybDQsnWUb/Fs4e9FBvC6y3ThLmXsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QPkgxuCV1bGkOEsuIIal7SuXaHHoLIx4kZ0TMN+gmvO2/Ax79zY5jmlKLGlwrOT+fpNMWBx/k8B1tbH1F27Oo4QO2htV2vBtddvFh33TR0e6sH4fjvQWgg6ppPwc645TAGH2IoDC12uaSFdSOtQOBrCkRmeefsj0vfwUngRpZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FFWFJxig; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-68187c5534cso493544a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1716546821; x=1717151621; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymkmfLUFinfhQ3+TDmLUw1ksts6DHkemJ1yTbP87LC0=;
        b=FFWFJxighLQ8CaYKxukHxy/G8frk7HV7ClIYB4B6tXHvaugLmxHIiiX9LfAgvisch1
         YRiJokwwusksfBLCf5eA5CWtXoi/ibt7td1pWlwYREURq3Oq01o7EpnTMV8QzBCqCUjd
         aF9w7S28PYx9SPpOOSMwN0pUfDYpciirpG3DMAhM/qa8IP7ciUqXFJOPehdA2g0Nb/yg
         BKUqmUcWyIxN1noVMlIOMLfMaHGepzvkCKQl+HprCOsh/cLKdrXoGqiheMkXRxthRXJB
         XgEEub2wLQ6+yyn3IEwio8/4zRdtG/vj8X0abjRkiGFQGoeYpyE+0eHSjD1LLLLrUGTZ
         pR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716546821; x=1717151621;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymkmfLUFinfhQ3+TDmLUw1ksts6DHkemJ1yTbP87LC0=;
        b=C3y8l3leN8UxSzaXqS6ltG6lA1rp6i3YAdE7wkicddeuIBMF/EDtcofIpAv9dBh6kP
         3aw//1fz89rJsIkyaeassafQ5FairQYZbfFPEuH6paKiBu4MqBGK3z4OIRqzFY0gJ7c8
         PdvrzlGPBTKty9ELZutKVHmCjzqrppNUuOzABcuGtZepv5gQvimSLWNzSWBrJ0nJMw8E
         OBp0m4CBRRL0ZZn7WW+8A1bSoZsLLSMhgPLLNLLnvkFo9OS5nl6Bbci9TVZYIur34O2s
         AifaW4XbQkr1PoTKsy8+DCGfsrWwuggNLF1rZzBRIjKNEblCAMNNBN8fjYj0b6ZekOx5
         2eHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9llWrHFnbK+OM9z1ycktw/J/4MYSK85TM6CPT4+y3GhiFhZs7knnAe0kjTIX7QMwAwSLkn0juHEuKf0M8s+2TAb7kRDyKzAMaraFJ
X-Gm-Message-State: AOJu0YxzDm7NNi9QEltTYgtQMSrdMUvli/5L1yUpupoqZqGVp4IYJ60N
	6MyEVfROjjKjAwxVKNAj8MovQefD1XQX97VzWI0BVMOABBt/Tt2xmMScgLKwmsU=
X-Google-Smtp-Source: AGHT+IHxFW2gDsXCi1JB6IcnARVviEQ8KpdJHHbgbAeBuxdOzZ+lkUts0NLoKaacIMyi2TPJR7Frng==
X-Received: by 2002:a05:6a20:2d14:b0:1b0:9b7:bbe3 with SMTP id adf61e73a8af0-1b212b7b0f1mr2711881637.0.1716546820772;
        Fri, 24 May 2024 03:33:40 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c756996sm10936625ad.8.2024.05.24.03.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:33:40 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 5/5] KVM: riscv: selftests: Add Svadu Extension to get-reg-list testt
Date: Fri, 24 May 2024 18:33:05 +0800
Message-Id: <20240524103307.2684-6-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240524103307.2684-1-yongxuan.wang@sifive.com>
References: <20240524103307.2684-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Update the get-reg-list test to test the Svadu Extension is available for
guest OS.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b882b7b9b785..3e71b7e40dbf 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -44,6 +44,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADU:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
@@ -409,6 +410,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(SMSTATEEN),
 		KVM_ISA_EXT_ARR(SSAIA),
 		KVM_ISA_EXT_ARR(SSTC),
+		KVM_ISA_EXT_ARR(SVADU),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
@@ -932,6 +934,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
+KVM_ISA_EXT_SIMPLE_CONFIG(svadu, SVADU);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
@@ -987,6 +990,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_h,
 	&config_smstateen,
 	&config_sstc,
+	&config_svadu,
 	&config_svinval,
 	&config_svnapot,
 	&config_svpbmt,
-- 
2.17.1


