Return-Path: <linux-kernel+bounces-384264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A179B28D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200D31F21FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B1191F94;
	Mon, 28 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j7NJ0eXt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pvr256dP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15419048F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100739; cv=none; b=pWOa11VqheHykPwoz1IQwtxl6z4An1tFEgwk7ayM4uRYH+4i5XMxxqb83xQe3z1JY9az/Nn/VmvoFgLbD8RZksXxaXXHnpIESHK0OEHPiTRXd1aWHzIOyNpH+74EvP0IWUsirNLxQkv3j0ZPL7F+GK0we+w2ySsGwkgZLNXInhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100739; c=relaxed/simple;
	bh=fM4326lBSlyItUCyDsvky8XLESJ8Yos7plcqwTdqh/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNojAzJpih0jxjxGUDODceIScIiv3fXwN7q4m2wyJ//KR4va4dDZ0bRA8A7ooPuyupXIJBCqyGXpiQt6RuDc/+fzp58l80UJu1L5QSxyWanFz74tAhB8D8YkBawrea8c9a0AfMPeVRP2JAnTXzep18fOEMaANXcwyb0y80HX6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j7NJ0eXt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pvr256dP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54OvKsvI4pcx+jFe2hba+Pmf5q/X4eFe1wCaotDkyFc=;
	b=j7NJ0eXtcOZRq3ZpXc/xcw354TX8EcPCP7CH5CWdys4lFUwIHlKZGmvcpD03ak9fh096Yp
	WjhtJSEImM/SYhDl4/1C34470XrZwiuYDDVnJDre6KaUcrH+ZHOixTzCZ2eOWcjrBsM/MH
	ZwOJknNkqfZvf8rffR1syq3sW1Xp+wxrEFYwTIBu59njGssxHXsnExLITb6J/97rwkeQin
	APUguyWnIHGAWVx59fx4ctYhiql248udkV1Q5A8iRjgceT+4BydvsMHjTmKjdrWpioQuwy
	JJ5o8QbqzoD93zA3BT+/DdcTnVVSXMMsijlH2ruc+fWdeLHV6GOP9rWEFdZMwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54OvKsvI4pcx+jFe2hba+Pmf5q/X4eFe1wCaotDkyFc=;
	b=pvr256dPPkwfpTLYBWFYX3kvalpn8v9pn42JGtvtXTbHNVANm31dj0IKMFUbxHo8gsL7rM
	7OMYnNYGmwDoNGBw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 01/31] KVM: MIPS: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:34 +0100
Message-Id: <befa6be131e66c759d38ff2fd591ced9db068491.1729864823.git.namcao@linutronix.de>
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/kvm/mips.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 60b43ea85c12..cef3c423a41a 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -288,9 +288,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
=20
-	hrtimer_init(&vcpu->arch.comparecount_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	vcpu->arch.comparecount_timer.function =3D kvm_mips_comparecount_wakeup;
+	hrtimer_setup(&vcpu->arch.comparecount_timer, kvm_mips_comparecount_wakeu=
p, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	/*
 	 * Allocate space for host mode exception handlers that handle
--=20
2.39.5


