Return-Path: <linux-kernel+bounces-275606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81500948785
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA15281674
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FB381C4;
	Tue,  6 Aug 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqOLC0x4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D7374D1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910891; cv=none; b=RTaAKrk9DulXBwzAxO2eh0DkRjBEgom6n24l0osII8qmvlqkE0UejXpgFQFbCb44svBBTHPxD7h9Vknr8dxszzNaNexx4sFRf0X+DNYFCH4mpZfihwSOs+4qpF/YL56iAHBw2L+gLWfXNnHePhgcqxFT6j3HFRCJLFCQUKSFYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910891; c=relaxed/simple;
	bh=Sj7lfQGWvEtR7yX9mZKYVaCGXWLFUoNnXGjl2VnaJPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWBKY4byHRibHjNd2MjxR06kfaFjenqeItVVlSUZu16mRTMWj4l6DmJ+OkEGHSei/t7ax0KZSEbAWWSvEBfv/44LKQMP1GQ3gUQZsoYWSUXiqps0exGX4wyL4wdJ5TSdt5NIfL1hFVsMfjAg2oBwW/lnMlurFcdFwhpUzS5xuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqOLC0x4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-672bea19dd3so3764347b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722910889; x=1723515689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=klWRv7jv+zR9aL4I7OIDRLjBsHfroErcwBIt7k9CqK8=;
        b=UqOLC0x4WDgfSwQXe7HSnxMRx3PySMuLFwi75HhU2E9CfcAy8BpgVxyBxiXo1/HTkL
         05SIyCMOo0EPtYDlg37g4+zMPVTYuc+jujGCtLKGknzhBXd6HKsQAX0JdwFPPPkOFN37
         Z08tdIAXdM/kitT7ELiKnSAH5riwJbJ87QIVkAz/yhpRTSwsC3etQ5/aOYFeKFP6MCx/
         mAeVcTOjY+HUWrySsd+NWHpvL6/AOLUHh6k5J5mZ911KOC7PRfo2d6I/feeRH6eirYez
         JMS0DJUmH4vFo0CkvTlOKVnlF9L91p/m6iUnqGKAIir52wwTNwQo5jAFnYZCK+fcF93G
         YADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910889; x=1723515689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klWRv7jv+zR9aL4I7OIDRLjBsHfroErcwBIt7k9CqK8=;
        b=XME9LILP8wfWz+mTXQ5PIpP9myOMOnyNPcnyeAAkxaDKNTwH+iY9dy6U+XTKAb/wtA
         4Bvmvzir48dwik+bHcFb0DRqpHABR+kXC6kBja/8AuwsCgWba/OvlpWjAzM4qf0nPJTA
         1GWu3mNdQGFE9bWW2h2Sokl47F8I22E8bfl1GeysoYa73Hkn9YLmAJRFcdb+PCe2qWUT
         rIU4DHzAuQWqc0veDC6yW7wxTdRFZqIftqR63iIMVJtjMeDWw9g5XSwwHafSWZEr+jdi
         u34PH185aVtBWRSD1BG68d3dpgxLQmWeHAKvW3CqNRk3dI0tiRtV/erGaB4Qyor5deLE
         Z3fg==
X-Forwarded-Encrypted: i=1; AJvYcCWt7MMLorTfZVLG9OXTNb1txEGCS8Mmn9nGhHVvLVXnXsRP5rzHdk8NLMy4spbmZT/2Sdtf2xQBrJI3wkFPko52ddGsIb68CbZ/S7C3
X-Gm-Message-State: AOJu0YxuDDU4VxeFtascojqNaGi0HcfF8o1O4e46HsjXBDRVZQ9Nr76c
	T7wuTanOg3JVLv7ShrlhjRYfCWt/7a9rxvK1pzy6XD8SBx/EnNJmJApuc9YIRWlnT1IKDj4Il8U
	ttA==
X-Google-Smtp-Source: AGHT+IGBeIkNUsFUwrlBhpMmppS6FEO5hkHGCy4Rnvwll+98qZLKAoOlt7677TqFz3cp98ge6KT5O3g57gw=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:261c:802b:6b55:e09c])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2b90:b0:e05:eccb:95dc with SMTP id
 3f1490d57ef6-e0bde283222mr64471276.6.1722910889235; Mon, 05 Aug 2024 19:21:29
 -0700 (PDT)
Date: Mon,  5 Aug 2024 20:21:14 -0600
In-Reply-To: <20240806022114.3320543-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806022114.3320543-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806022114.3320543-5-yuzhao@google.com>
Subject: [RFC PATCH 4/4] arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Frank van der Linden <fvdl@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Muchun Song <muchun.song@linux.dev>, 
	Nanyong Sun <sunnanyong@huawei.com>, Yang Shi <yang@os.amperecomputing.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Nanyong Sun <sunnanyong@huawei.com>

Now update of vmemmap page table can follow the rule of
break-before-make safely for arm64 architecture, re-enable
HVO on arm64.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..25ff026cdaf5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -105,6 +105,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
+	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_EXECMEM_LATE if EXECMEM
 	select ARCH_WANTS_NO_INSTR
-- 
2.46.0.rc2.264.g509ed76dc8-goog


