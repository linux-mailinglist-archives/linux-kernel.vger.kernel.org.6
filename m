Return-Path: <linux-kernel+bounces-527243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D2AA408CF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A741D7A5467
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415178F29;
	Sat, 22 Feb 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ALrG3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC61F5EA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232118; cv=none; b=chZN+lCb15Xh4Gtl92iwLrUuJq9IkCB/TVhyxJKUooehBPFUJVyeYvt4apHP0MCyXMwTPSL7jqag92S0Xa/l+jJFp57MCGBNFWlnI4rw8RseoQRwqSPU0jygc2KlXF3byHldQ1Eac8XhWlXfRFbqdKdb55jcfpuwVoOAlfDQBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232118; c=relaxed/simple;
	bh=oqs8rRU3ZcMbaKyCjUdQKB3T+Sm6Q4BIerRo3+G2wNM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bgi8hLjbQDlVRHeAL7Xvw7uwdaK/FDsagrkHPzWGtyRkmUjpv0YqwbyqOB/Yux6YyxSU+oC903MMLnUuE4Q0w6c4YHVWJhc2ZQktKoncPt0FAxXb53ceDRT8bJnPU6Yqlqp6VJO6tsI8dGVGBovJjSGfk/LV2x9JerZDA3/A8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ALrG3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D1CC4CED1;
	Sat, 22 Feb 2025 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740232118;
	bh=oqs8rRU3ZcMbaKyCjUdQKB3T+Sm6Q4BIerRo3+G2wNM=;
	h=Date:From:To:Cc:Subject:From;
	b=Y1ALrG3SC6lmZRjBiS8uRdgR1UwtIdzhA1dnmOAu/1bFVxSiIjv4YramrJAXN9Cgw
	 3QbDqxjr96ntVLyqX0m3ArrF/EGMkyOM4JmZlq8swngubZhQ6p/znti2VP6sTM3BZ1
	 zu0tuKjF7g5Ob6Wwl+S1xXkEc9uMGJgHB1lgLEhwZYOWFfe/hAwUMm5KKglQuVqhW8
	 YUmVZvpYtUKbWIvDkYYR8m3kWBj8gXLgqCZVyYqlE+Jn7GT/YCRE9SFu4Sy9vP5TjD
	 hwR7TD6pkXTLeJlY5PYO/6UBMLT2A6T1p2FjdTEiLxCxIzntFFjwaer3IC9u53QvGQ
	 tASdfcdUSxR8g==
Date: Sat, 22 Feb 2025 14:48:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] IRQ fixes
Message-ID: <Z7nVrujho_tqIt8S@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest irq/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2025-02-22

   # HEAD: e9a48ea4d90be251e0d057d41665745caccb0351 irqchip/qcom-pdc: Workaround hardware register bug on X1E80100

Fix miscellaneous irqchip bugs.

 Thanks,

	Ingo

------------------>
Artur Rojek (1):
      irqchip/jcore-aic, clocksource/drivers/jcore: Fix jcore-pit interrupt request

Marc Zyngier (1):
      irqchip/gic-v3: Fix rk3399 workaround when secure interrupts are enabled

Stephan Gerhold (1):
      irqchip/qcom-pdc: Workaround hardware register bug on X1E80100


 drivers/clocksource/jcore-pit.c | 15 ++++++++-
 drivers/irqchip/irq-gic-v3.c    | 53 ++++++++++++++++++++++++--------
 drivers/irqchip/irq-jcore-aic.c |  2 +-
 drivers/irqchip/qcom-pdc.c      | 67 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 119 insertions(+), 18 deletions(-)

