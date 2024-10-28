Return-Path: <linux-kernel+bounces-384269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B149B28DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA10E1C21225
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B101D95B7;
	Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NowObxvY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hn70gjMg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5811922EA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100742; cv=none; b=ACbbcAlN25BJ11KibAXe2vb6+xwC85N9U/t1v3/QRQnHo1+WWjUSD377o1kK2sPYqHCzOwEFIGoi2oPjPfP+7XmxNn4D04FSt2bZZ/2SbW0qS1dchQHOi9R6JVmXZpJvqZTUvd5P0osz9XpQ3OXckUzE3QpRVrcnDTS4IR8e33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100742; c=relaxed/simple;
	bh=MDXngocv7tPdUvz8DqTIpMISjrUpd68bMeQIaHuzXkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esDWS+hmGBwvS/nZY0XY3cExCIZeK6754N7snTBEJfZnf6tiYpQC4YmBuxwbyLJMwFPrtwZxt/ffqMlQyMt4E5M2Hds+VFN5KZ+5x5PEoyGHN4Kk/0N2estxzFDPEKyKzt8eB0E+70NxyrXKh3dzXb+MQ7Q8AgThYiGQJsId0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NowObxvY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hn70gjMg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZR0n1Z7yUnxyg/FOVlgc5mhT02OpYm3oHjnsxlsSzg=;
	b=NowObxvYIfafnnIXpmqQsFE+3S4CcNsBrczgKWEN1ngnKoFXiUluJy05MPzJIvss4rsN6y
	qotder9Xd48g2218LzpopY2UrRuQPh2Q4Yq3qwOFWm0fUsGKIExZdGjeB+hhD0Mmy0JPRH
	jUpbhqyVjDBs0yivmqZgUIBxXBcPaM80LJbazEAJ0wqOArek5z0JGqOMBuKckmmPjxkj5t
	wyxXAtng+L0Vlts3KY6e1ukg2PPLPwSSYq7CjlD65H7QNRvIfIMtUkF4mIGWvebqZreSm3
	wQsKevtF8Znik29HGsV7lZIm/7hibpUHwIj4mRoVeqpT3OH77JgP1VHMaX8Elw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZR0n1Z7yUnxyg/FOVlgc5mhT02OpYm3oHjnsxlsSzg=;
	b=hn70gjMgNdyJBWT+8oSSJ1F07k+ySGkhTGhMm1hw0VuUyKEIdJliWIl2er2roGn1jf9bm6
	r2Jzro686HMBPQDQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 05/31] KVM: arm64: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:38 +0100
Message-Id: <c8a1987ae32ee2596c90fc4403fa767cf5a3f2f4.1729864823.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/arch_timer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 879982b1cc73..92e4fb5dcf52 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -993,8 +993,7 @@ static void timer_context_init(struct kvm_vcpu *vcpu, i=
nt timerid)
 	else
 		ctxt->offset.vm_offset =3D &kvm->arch.timer_data.poffset;
=20
-	hrtimer_init(&ctxt->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ctxt->hrtimer.function =3D kvm_hrtimer_expire;
+	hrtimer_setup(&ctxt->hrtimer, kvm_hrtimer_expire, CLOCK_MONOTONIC, HRTIME=
R_MODE_ABS_HARD);
=20
 	switch (timerid) {
 	case TIMER_PTIMER:
@@ -1021,8 +1020,8 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 		timer_set_offset(vcpu_ptimer(vcpu), 0);
 	}
=20
-	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	timer->bg_timer.function =3D kvm_bg_timer_expire;
+	hrtimer_setup(&timer->bg_timer, kvm_bg_timer_expire, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 }
=20
 void kvm_timer_init_vm(struct kvm *kvm)
--=20
2.39.5


