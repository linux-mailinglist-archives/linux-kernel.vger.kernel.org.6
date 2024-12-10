Return-Path: <linux-kernel+bounces-439356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2019EAE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1064E168452
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5B19D08F;
	Tue, 10 Dec 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dzc69xfQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jYD5flwe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8A2080D5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826861; cv=none; b=I1knexBfJrq4gvr4HCpyTH4bWCjN8Ppe/lGdcCbl829KiiRslcstt45cygDTBVz3Vi/ktzXd5D8GmYxhZ1q0+s/7EZlGzoydsTZZM8KWPJxh6k/NMvBh2zimmjS5jTiFLJ4yvoljM8tk1j5db6P2d4M+S2ijFi3U1/ximou3pe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826861; c=relaxed/simple;
	bh=KRTeLC5ZJhLeAcNruUPzCpQvyrEU2oMR+PrDzurcda4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A4nvqqKc6kHaLgBwDTATThl4JaMC4NFkwsN2yVuwns0Ek3tuOoh9bO3na20ONBqOCmdTXJge/wIV8bfq448e/80oe13NOtKC4oWWpWZAVFaEkK7yyh978F+rWKBV/QoGrelRgU2gXIeS+CI9LMS8HIpdoahjjrhLxa3iiMhcZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dzc69xfQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jYD5flwe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210103335.437630614@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VKJDVibaFNX2XMzoNIdJWCjP6hyGiA9FSsEH64oOzvg=;
	b=Dzc69xfQiiM3L6gFeMxYsA6dfuK5Ww9qmF564w0JvM5pgbpif1mtFuhaISqdH01YjfqpIO
	nXBtTawxxZweTx9ej5YM0ZQpRYcBi3VsQ3Rb2ZXtUjA/vJDxIcOC4upyHtDije2PVhHRFU
	oHH491gmq1mUm7oBDMrJ9OrULt5pb/epvY3LXTvXFSdTQJM9v0E5i17L2AxLjr0H6d/IMB
	WzaIJggILIdjIHXFYY+2QU68b33mW4efAKOZ7fYlaUuFUzFb+v720Gpo5CpnchtUF22+L1
	9nf9vC0ChAjY5hX3eXnspYwK3rys/NYcMCqn/MMa26w7NIExu1kDHxKJ/Pp/yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VKJDVibaFNX2XMzoNIdJWCjP6hyGiA9FSsEH64oOzvg=;
	b=jYD5flweEkD8yOGSA4OE7SMxBnPGXq4A+SPeyWCBkPl6I8j+Pyckal5jM8R6eslAnYd+R+
	zuvg7Qtze7RlnsDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Anup Patel <apatel@ventanamicro.com>,
 Brian Cain <bcain@quicinc.com>,
 Vineet Gupta <vgupta@kernel.org>,
 Wei Liu <wei.liu@kernel.org>,
 Steve Wahl <steve.wahl@hpe.com>,
 Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Juergen Gross <jgross@suse.com>
Subject: [patch 2/5] hexagon: Remove GENERIC_PENDING_IRQ leftover
References: <20241210102148.760383417@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Dec 2024 11:34:12 +0100 (CET)

Commented out since 2011....

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Cain <bcain@quicinc.com>
---
 arch/hexagon/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -20,7 +20,6 @@ config HEXAGON
 	# select ARCH_HAS_CPU_IDLE_WAIT
 	# select GPIOLIB
 	# select HAVE_CLK
-	# select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()


