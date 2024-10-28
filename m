Return-Path: <linux-kernel+bounces-384267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDB9B28DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5941C214EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F431922F6;
	Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUtp9bVq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTWiHZHR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA01917ED
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100740; cv=none; b=Vdi+O3vslPMH8gE8rYVMsUw+L1MEbfG4fEWESvuiONxQNDkk+gCfp9klZtOofgEQk5lU1nXHBdYj6PMEZ8EBVuxdmJP6Sj3MOiywZBsrtuf6vYMXDZEd6pfm5aPapSwH8VBj6yHwJ7tfoskrYmFQswlc3UEcKe9+iZJ5aTrPNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100740; c=relaxed/simple;
	bh=Rf9etxNcd7hdI3Iu99sh6LQdxOGRbsp9nDK50ELLggk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZXj9iiKo8j+MitT2iVyrbYUgN0cAfuvTpuAsmIBSpp+eeo9J1jnPjDpkXN2T0lbZ/v5N0mgJ5tghlqPdBaf2gV2+nEg4p81Yg8fFJ4wGQvmHtBY+39p6/Xtlcdln/IMYlMosaeP2BeTRnVrYHujX4BLeU+k3xV95CQHKh2MsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUtp9bVq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTWiHZHR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcoPPSyL5mtK+cYGy9W3PxhhXEc0Thmk/MBB1C+VQRE=;
	b=wUtp9bVqeJEhO+VTnHds8Rr2VrmeSl1TRjNEpYuvzMdFykTB0HCOkHs3rHRCVPKcruuhJt
	CR9sCZS1ZuH8VhGk3TR7YOc4LylC1xp3DM3It2WqQzNa8NyNanbJBSNAIQNQBWTRgKr8AL
	dJo+Ldgd/loB4q3FbfSv1LkvwnONIZ62PUXLqkX6j2GUy8Imp1b8lWYypbRnNr0NNF9eho
	csgzA7ZbHS3o4xRsPsX7tJfrvdzLzq4PF0Kj/HgC97RPJBTgVr2urwNOfwu0gtTN82sOhh
	6d9jpRR8j9cFiJYJYHg0c0EeGEX6ahVfnInpOjJrIv2f+zR0/vRk8+24uDKKwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcoPPSyL5mtK+cYGy9W3PxhhXEc0Thmk/MBB1C+VQRE=;
	b=aTWiHZHRCH37XJc6Z27pg73rY+UQ6lr3R2HzLTVAh9AqZ7VRnk4yeB5KqOlOZ7T+JVcmEh
	w//HMFZV6mdnJ7Cw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 03/31] KVM: s390: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:36 +0100
Message-Id: <b679f234d1de853d5ba1ea482d971073682be57f.1729864823.git.namcao@linutronix.de>
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
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 3 +--
 arch/s390/kvm/kvm-s390.c  | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4f0e7f61edf7..3c8685ffea62 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3174,8 +3174,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	gi->alert.mask =3D 0;
 	spin_lock_init(&gi->alert.ref_lock);
 	gi->expires =3D 50 * 1000; /* 50 usec */
-	hrtimer_init(&gi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	gi->timer.function =3D gisa_vcpu_kicker;
+	hrtimer_setup(&gi->timer, gisa_vcpu_kicker, CLOCK_MONOTONIC, HRTIMER_MODE=
_REL);
 	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
 	gi->origin->next_alert =3D (u32)virt_to_phys(gi->origin);
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bb7134faaebf..4ab20ba0392c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3896,8 +3896,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
 		if (rc)
 			return rc;
 	}
-	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vcpu->arch.ckc_timer.function =3D kvm_s390_idle_wakeup;
+	hrtimer_setup(&vcpu->arch.ckc_timer, kvm_s390_idle_wakeup, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL);
=20
 	vcpu->arch.sie_block->hpid =3D HPID_KVM;
=20
--=20
2.39.5


