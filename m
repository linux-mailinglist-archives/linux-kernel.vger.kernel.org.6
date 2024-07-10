Return-Path: <linux-kernel+bounces-247466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7092CFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7B21C23A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE50190049;
	Wed, 10 Jul 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gNkQsN12"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4FB18FC61;
	Wed, 10 Jul 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608650; cv=none; b=pMQIhI17+URqm+yezYmSlABeyNlvV8pBFJaal8xOk+YXdBB62mCeO950eQp1w4C7uGKU94Wg3amrkPXKTpDfhjq0hdU5DFVR5huk9qu3HYdVk1ZreyrIq8PVg3sw7XMm8baSX48LR/esU84ipqRiWosXQn9l2T3NY+FgVmuJDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608650; c=relaxed/simple;
	bh=FlX1+w93lB8zvcMp18OB5EDWF9p6KvhUpbHoFQjJfG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lyxvIs94wfrY76xxPQ8n86cZyX3QT11+2E3c+h3HHpuJK8KYxulLTFLE2Gb9gQg4b+u+BDhIK3fbweXdAFZ7QpQD6wW0GCV5aE7lxRAip814oon2ee7W6RutYfhlO4GdQvl0pP6/6L9NPFwpZNFwZ5hIwQtfICLbwJc1XNCJaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gNkQsN12; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720608644;
	bh=Sq7A/5BKly+8nmwJr6uA8HAvkZyan3OjiLaHZGsUBSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gNkQsN1224trz3k4ZWtlSM1G2KLEdd/BtBlc5HWriCQ8icpbMXsA06qGyoYX4LDO2
	 NM5UWiPY1/r02uvgFChIZnKZ2prBo6qFY9ruKG91mEbhpfuXQD3PlXTjZOI4XgJyEk
	 ILwDsYRxvQDkAzvSTWdTntj6Tq1wTT5JdQzkOekLokSjdDUi9DaaMfQ/P/E0P7Xhcm
	 eYChzWePjRQLpsfH51QBI6UjFNwfh5r/5Bpu6wwMI0m5rd2VkbGwthVyBlJImTVXq5
	 gHDSg22GwdMTWhYmoyHbUFJXVapTWqKd6suvRvPKpyQ6seUhUf1s+tu2v4XaOQjA8g
	 arChLBtLNmvaw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJvlk6F7Lz4wZx;
	Wed, 10 Jul 2024 20:50:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Jonathan Corbet
 <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/powerpc: Remove retired CPUs from list of
 supported CPUs
In-Reply-To: <e33ba7b242a104259fbcf1a4d4bdb0f1d1db6882.1720539170.git.christophe.leroy@csgroup.eu>
References: <e33ba7b242a104259fbcf1a4d4bdb0f1d1db6882.1720539170.git.christophe.leroy@csgroup.eu>
Date: Wed, 10 Jul 2024 20:50:41 +1000
Message-ID: <877cdt5xmm.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 601, power4, 401, 403, 405, e200 and IBM-A2 support was removed by
> by following commits:
> - Commit 8b14e1dff067 ("powerpc: Remove support for PowerPC 601")
> - Commit 471d7ff8b51b ("powerpc/64s: Remove POWER4 support")
> - Commit 1b5c0967ab8a ("powerpc/40x: Remove support for IBM 403GCX")
> - Commit 39c8bf2b3cc1 ("powerpc: Retire e200 core (mpc555x processor)")
> - Commit fb5a515704d7 ("powerpc: Remove platforms/wsp and associated
> pieces")

There was also: 468a33028edd ("powerpc: Drop support for pre-POWER4 cpus")

> Remove them from the list of supported CPUs.

The CPU families doc is not intended to be a list of supported CPUs,
it's more of a family tree which includes the currently supported CPUs.

Even when I first added it there were CPUs mentioned that weren't
supported. (I realise the paragraph at the top of the file doesn't make
that clear)

I don't mind removing cores that are unsupported and unconnected to
other things, eg. A2, e200 and the 40x.

But for 601 and the early POWER cores I'd rather we marked the
unsupported ones with an asterisk or something. That way the family tree
still connects and includes all the history, otherwise I think it risks
being confusing.

Or maybe we use a different box outline (~) for unsupported cores? eg:

   +~~~~~~~~~~~~~~+                 +~~~~~~~~~~~~~~~~+
   |  Old POWER   | --------------> | RS64 (threads) |
   +~~~~~~~~~~~~~~+                 +~~~~~~~~~~~~~~~~+
          |
          |
          v
   +~~~~~~~~~~~~~~+                 +----------------+      +------+
   |     601      | --------------> |      603       | ---> | e300 |
   +~~~~~~~~~~~~~~+                 +----------------+      +------+
          |                                 |
          |                                 |
          v                                 v
   +--------------+    +-----+      +----------------+      +-------+
   |     604      |    | 755 | <--- |    750 (G3)    | ---> | 750CX |
   +--------------+    +-----+      +----------------+      +-------+
          |                                 |                   |
          |                                 |                   |
          v                                 v                   v
   +~~~~~~~~~~~~~~+                 +----------------+      +-------+
   | 620 (64 bit) |                 |      7400      |      | 750CL |
   +~~~~~~~~~~~~~~+                 +----------------+      +-------+
          |                                 |                   |
          |                                 |                   |
          v                                 v                   v
   +~~~~~~~~~~~~~~+                 +----------------+      +-------+
   |  POWER3/630  |                 |      7410      |      | 750FX |
   +~~~~~~~~~~~~~~+                 +----------------+      +-------+


cheers

