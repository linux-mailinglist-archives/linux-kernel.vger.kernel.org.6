Return-Path: <linux-kernel+bounces-257939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2293811E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A691C215DD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F412CD8B;
	Sat, 20 Jul 2024 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="P/K+5vIq"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212D29AB;
	Sat, 20 Jul 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721476899; cv=none; b=X0nIHtbAC5+sMzHwvwWdDaPFEWuLR3xCE9k1rv1aHFYLJ0zPu2pu1an3H433OdSMCqYNMdEYbCLVB5A636Utxs/yV6XXRFnu0A0VIlG+ULPvOkNmMk3DttQXZJLgjQqhf7VMd8JulqawMAPQT0sdM8jWaiYUCcm77QE4atwBD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721476899; c=relaxed/simple;
	bh=Iw9y2d0xFri5phiwup3bpzFl+d63hYPOdu494DRNOJo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kDoHGT37N/TykF64U+xutn+gJdP/AkjmEm8Ro1OmeIjM3Cj7kjpNMPlW9M2q0bKtEbpUvbUTteaI6cDMyMYBDZzSONDtk8TYo7JIKZNPWEtus9ihKNXc+v3+89Nu8/C6SRRcUJB2ffFwLfUKoZxvV6vzei+k0hz/7oZlHO3X6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=P/K+5vIq; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721476889; x=1721736089;
	bh=Ulfjm2ICHJErTUPJBS83uOvGY0WbQepmua4xjo1vleg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=P/K+5vIqWwOzwwXwYwUwwfOlMOiNBFuPbFh0hf3siSpEIDisqge6OL3MN8VYb59MF
	 xBJBOrgZcERyXR/ADlf0peUTCMpiwwddp43xNjdBF3aO6ArRck6Mc0wF3VSIVRSB7I
	 pELJx1eTuhySTpEwWdAtYLPXy9nf9wRStSS0GkSVc2IrGx8KMM2brHVrUjK/I3nykh
	 RoCSMEw5Of10ylu2485xEXyWbLVobbYQf49K6oikP4HPUDOX/fIJa+qGK7fhVb7NVP
	 9I+1uRcu4b/LpD9QhUt5rqTmJSpCBfmZQs8WVgUY7m0qhynrGF7EDBtVi1E9VfOmJ4
	 C7vlKwSQ66GzQ==
Date: Sat, 20 Jul 2024 12:01:23 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH 0/7] clk: clocking-wizard: add user clock monitor support
Message-ID: <20240720120048.36758-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: eb94335087a5eda15217fc444c8fe79811588381
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Improve utilised clk/notifier APIs, making use of device managed versions
of functions, make dynamic reconfiguration support optional (because it is
in hardware) and add support for the clock monitor functionailty added in
version 6.0 of the Xilinx clocking wizard IP core.

The combined addition of all of these patches allows, for example, to use
the clocking wizard solely for its user clock monitoring logic, keeping
dynamic reconfiguration support disabled.

This is currently untested on hardware, so any help testing this would be
much appreciated!

Harry Austen (7):
  clk: clocking-wizard: simplify probe/remove with devres helpers
  clk: clocking-wizard: use newer clk_hw API
  clk: clocking-wizard: move clock registration to separate function
  dt-bindings: clock: xilinx: add description of user monitor interrupt
  clk: clocking-wizard: add user clock monitor support
  dt-bindings: clock: xilinx: describe whether dynamic reconfig is
    enabled
  clk: clocking-wizard: move dynamic reconfig setup behind flag

 .../bindings/clock/xlnx,clocking-wizard.yaml  |  29 +-
 drivers/clk/xilinx/Kconfig                    |   1 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c    | 346 +++++++++---------
 3 files changed, 212 insertions(+), 164 deletions(-)

--=20
2.45.2



