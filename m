Return-Path: <linux-kernel+bounces-263020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C352D93CFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0654B233BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C692917966E;
	Fri, 26 Jul 2024 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CxFFVRmF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD117920A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983801; cv=none; b=ctncAT0IV2ck9IiaDyXeGPWnFlNPP3a6ZS4rtjHuO78Qu97EngCz0WcEjmqOdyQq6dC0E7+k4qdbiqIFIgY8AY9d6VwL/kw6l8C60a5McP4EsHgKfp8S4JIdjd06Ulu60iHnM8Pw8K5pUyPlhDMtdVaf6oAeU8qSZ30G5rJcti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983801; c=relaxed/simple;
	bh=kmSTht2ay/WaraC9QeCfGlPsOABUHyhKUYCSzPBi1L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pmhKDuFO+oGe+1oVmkUZSQHHQVg7cqlyvk2qt87JSUMZJGoS4bEEKJ2Ex3JlguCXBNL5+7Ahwd1OaEQO8qH8kfWvJkxu3rx7X73MHzyjfaJl8FS33JnxlwF/FhWHn/T0ZschQLC4TdxhFGFqA2sbgg7CihY4JLGoW3DWMQuNZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CxFFVRmF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso632453b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721983799; x=1722588599; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3dXGB9M68kLUD7MhXnrJa0QNMQINVnKrW/fzYtIxsFQ=;
        b=CxFFVRmFHFy6MxsDV+oQVaL+MsLkLMOD65lg+QUK/kYEnqJ1Ffku2st1o6fh3cQzQ5
         cZanjUhP+a4FgL/X8pwVdI9k94GbgMgYGY7LushkSGYr2wxZVV1DkxdQNiXh1r1JDBS9
         44SSz/fTCrDR5m3ObmsqFCe4ktHzR7irvZQsC1cVi7IRJJ4nQT7RRxIR6MtJZbkODvag
         0aT06NpshgvmPRSZkKTXdyBxF3XcdjttW2TFyv79FVsJob1tLD6NomGLmnm7Q8DTsPsy
         QwzX7S11KTAsrUF40PN/msYGaU0K16ALDjy0H06GhTe/nUfZH3r6a2ChWohMjt302b1W
         H91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721983799; x=1722588599;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dXGB9M68kLUD7MhXnrJa0QNMQINVnKrW/fzYtIxsFQ=;
        b=uwZ7NNsc+UmVcLI8VJFh/Lq1mBCh8V4Ts/a+cnNLW2USuH0S7+F/KkF+/llPLp8jl3
         cuoOFgN11S4hKnlIHs1EnP3snS+pv4jme5z3nOHGZzh4VikzVLKwvEsRZC9mbGcGDMMQ
         SstWdaWzHEbsZNLObOYt3zPfy6XeABnRUiqtqoW17UV3cIrYRqzTHdafEAdr2NO3HmMy
         GcQZCOeTUiNWoaR6zgFEya6e/IKITMv8d2qo+w534NLL/kYFDmo5S5VmIsxeW2EWPkUi
         KYzN93FeeUZaW3z3SOp1QcuD779LtDSmVk4ySILSy1BI4ywqctMRpI/6T2HW8Xzm+n+b
         8HkQ==
X-Gm-Message-State: AOJu0YxOBA7hHc+gNHOUx8IoUYT5LzSBj/Za0OoaWw/piLSZ+9Zts336
	4WCOYLY8IkJGL3Q+NrbBtglVJZTYhrFvzYv2dIyao8c7S84xhJMhwvJuWDJo3mbthBYsEsBscTW
	ElnZFumHEJJqahyfJjF2DsA9lXlwCFOE7c8CjN4uy2nVGR/0CcTBKexu0Wg1MEJqzA1EYbh0giO
	Xdcrz+6z9D3YfU9m0enq+VW1+nHp1R200qkOZcfL3JYoJ4PW384/Y79A==
X-Google-Smtp-Source: AGHT+IGznbiFSiAI8Fl6vXmZOoRo3AgApK1TPweDDMBRdHNs5h5IX0DOrE9eMPt7tTokhtzC2+Ebew==
X-Received: by 2002:a05:6a20:2451:b0:1c4:7d53:bf76 with SMTP id adf61e73a8af0-1c47d53c6c7mr4526810637.38.1721983798630;
        Fri, 26 Jul 2024 01:49:58 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816db18sm2049645a12.33.2024.07.26.01.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:49:58 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v8 4/5] KVM: riscv: selftests: Fix compile error
Date: Fri, 26 Jul 2024 16:49:29 +0800
Message-Id: <20240726084931.28924-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726084931.28924-1-yongxuan.wang@sifive.com>
References: <20240726084931.28924-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix compile error introduced by commit d27c34a73514 ("KVM: riscv:
selftests: Add some Zc* extensions to get-reg-list test"). These
4 lines should be end with ";".

Fixes: d27c34a73514 ("KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index f92c2fb23fcd..8e34f7fa44e9 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -961,10 +961,10 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
-KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA),
-KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB),
-KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD),
-KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF),
+KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA);
+KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD);
+KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF);
 KVM_ISA_EXT_SIMPLE_CONFIG(zcmop, ZCMOP);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
-- 
2.17.1


