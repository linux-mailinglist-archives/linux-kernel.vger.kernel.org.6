Return-Path: <linux-kernel+bounces-428205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FDC9E0B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A79C282B6E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982381DE3BC;
	Mon,  2 Dec 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fco3W0uI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5261FD7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166018; cv=none; b=daaaXSKYT4m77+d2lTAuYLiCRvjsivS28l5jiwEo5SkoyG5WptbN7ksBXBPmMvPOTYBwafL1Tzvug6Pyrn5WU5zv+S1tqnwiU8J3NmXOf6Cs7m2zUrdFQJwta4zzZqOJuaDe5590mAoOpU9SuLnJ2T/I6VPGATNQlhIMHDSZFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166018; c=relaxed/simple;
	bh=T7PybO749Z0HQXamO36BFc8tXpmMHexp/EK155PI1C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYRzY9olaR0qwP1IqwSx9CaQlOnHZ07bbrMdokBc68GS6uM349jrHXrLYxFPKej39PGjlurc5nbtWhfUOOquaJrq+5WRFkJ2bsnHX/Qbyeqd+hkf3v4Up4k7BsBr0feUnhjYxIKh+hwE1FUbCUVFjHiekXStqX+ITi82UnW7DZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fco3W0uI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942E5C4CED9;
	Mon,  2 Dec 2024 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166017;
	bh=T7PybO749Z0HQXamO36BFc8tXpmMHexp/EK155PI1C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fco3W0uI4UoMtHSohqTxRyWRfQwhcZ3REJOKasapYUPqoZWb7PXBKd+gynvCH4B7A
	 tuzdE5DDJgvd3+smA0LdO5p9hQE7jbQ41pHZPydB3dBQPEOJNPXyB1BSnvOGRC8LJx
	 Mt8zVeuMBukv1z8Ltj3KOSTehnoyQSjWrUGs4VMq8WyJ6lBJu7R7t4GG/4BBA+FwJA
	 PbolAb2CnIrUkmDQwc6bpe06WywlyGE9RvatmmZMYq6Tt5AgHuNBOBZfekvekIS4iq
	 fYBMoANioyf8VWPeVmnMKugqNPn1dSoihiwSC/qHX1gENAOJZ+ib8NUoxrxxgE8kev
	 kSW0P3SGzVqTQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 2/2] x86/apic: Remove "disablelapic" cmdline option
Date: Mon,  2 Dec 2024 20:00:11 +0100
Message-ID: <20241202190011.11979-2-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202190011.11979-1-bp@kernel.org>
References: <20241202190011.11979-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

The convention is "no<something>" and there already is "nolapic". Drop
the disable one.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/apic/apic.c    | 9 +--------
 arch/x86/kernel/cpu/topology.c | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c5fb28e6451a..1267b2691abc 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2582,19 +2582,12 @@ int apic_is_clustered_box(void)
 /*
  * APIC command line parameters
  */
-static int __init setup_disableapic(char *arg)
+static int __init setup_nolapic(char *arg)
 {
 	apic_is_disabled = true;
 	setup_clear_cpu_cap(X86_FEATURE_APIC);
 	return 0;
 }
-early_param("disableapic", setup_disableapic);
-
-/* same as disableapic, for compatibility */
-static int __init setup_nolapic(char *arg)
-{
-	return setup_disableapic(arg);
-}
 early_param("nolapic", setup_nolapic);
 
 static int __init parse_lapic_timer_c2_ok(char *arg)
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..6ebed852a9ef 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -428,7 +428,7 @@ void __init topology_apply_cmdline_limits_early(void)
 {
 	unsigned int possible = nr_cpu_ids;
 
-	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
+	/* 'maxcpus=0' 'nosmp' 'nolapic' 'noapic' */
 	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
 		possible = 1;
 
-- 
2.43.0


