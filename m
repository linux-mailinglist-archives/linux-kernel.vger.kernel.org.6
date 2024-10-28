Return-Path: <linux-kernel+bounces-384266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C19B28D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A2028209F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ABF1922F0;
	Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJAxSFkh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fnwSt15+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5D191489
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100740; cv=none; b=ZIp5t1KB48MMZoH56oElaLUGvFytl6FYACoGydXPt0jY3U+/WX0LA5nT4BWPS74NURRqPDyb7tTf9sm659rkhGorqMBEdWZtpb3j9AxAXG4IhdNPChFVEh01ofqqqZYaw29LgzstRyE/GE38B4N7vNsiKXo4jI34RNRqe3OMA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100740; c=relaxed/simple;
	bh=uOTK8RK+qfQgPko1/kcfrp+dzTqwlYdG2SYVqyuVRVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqolk7eIxqSnXIJsbMiZGcE63M+mTpqSTbGbpgrlWNTpLJJKWsIjrMPoWVGxTLcUmWyT45h6PH+71bXrIn7nFJ8cmh8W9TKPemOlr3w7PDNk43rCNS3nzdctE+wOgahY5kHxhDZxEeh8Zm0WsBi44Cma49LvcBE7//i79zuC5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJAxSFkh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fnwSt15+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OaCPpaLXjT7nuaYNyzJEa7vwLha/LCJBeNJ/YYGThk=;
	b=iJAxSFkhI2ABfuuCozyySBhqF1nLpILkun7AdGnUB+9enkig4FKf2c3shVLOR9aeJ/+KSV
	CtwEIFRy7BdYnEcqgZvoKEEHET3JUJKNF6vLdPZ2i5D6SJ5ivk5HPZcvUsUPDGTah8pTUc
	q65HcY/DdGBGXMfB01MZRKu1yt9YGMG9mz1T7i6eZJwNdXamM17Qu/MBVZ2e4IKHMnC2m+
	IwvrsQH2C42BFp6NgYGnHozU2k8rUzDtApmzCutyPOvO/MaDfgl9eEo1F+D80VJCiXWR9v
	DYm502KIONVVkGP0fC0kPogNsSPW4w5W6MkJqD+d7GO5OebGelvfk1oeJHSDQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OaCPpaLXjT7nuaYNyzJEa7vwLha/LCJBeNJ/YYGThk=;
	b=fnwSt15+ep0Qqur193vbge3nr9ZoG42pgnmtVKxOXS2NeVaThOTtdYhgHf8q97ffh11IZf
	Uj9ogU7upwJj/qBg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 02/31] KVM: PPC: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:35 +0100
Message-Id: <83def641c1117ca6a1ffdb0c53813de97650fc2d.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kvm/powerpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index f14329989e9a..e6269ba3a839 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -769,8 +769,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int err;
=20
-	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	vcpu->arch.dec_timer.function =3D kvmppc_decrementer_wakeup;
+	hrtimer_setup(&vcpu->arch.dec_timer, kvmppc_decrementer_wakeup, CLOCK_REA=
LTIME,
+		      HRTIMER_MODE_ABS);
=20
 #ifdef CONFIG_KVM_EXIT_TIMING
 	mutex_init(&vcpu->arch.exit_timing_lock);
--=20
2.39.5


