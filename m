Return-Path: <linux-kernel+bounces-366527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B927E99F6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5111C2359C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCEB1F81AF;
	Tue, 15 Oct 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TvHB2qpI"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9B1F76D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019434; cv=none; b=MVSAKOpZcW5jmprCQvMJtskcqYKp+qpxtsugbrKiSXB6zVT8wzGCJF59m9J3Z7E96GPMr5IT7UMa/qoY8/mw5+SM0m37uHHZGCuNvohK7x9aycr9rQ9jdF2GrsqdmOAouQURi48eIOd82ZEYYHilYngG1qAB1sWwfSdvyixWnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019434; c=relaxed/simple;
	bh=zTPehKPiGJ8uc8eamsF4ApdZreywLo9KjOVlaMT8zCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjfxcHns03vX2z/Ynp4k5fDJkOui4M+1nGTGU8PR8HhRsj4FBGQYitcfbZODiooNMT49SssmjWyRZd6saO9dq2zAsfTE+h2rEhRmSCYcQZaV4nf75IA1MvTtecr6B0rQyq1UHFWZfTIm56FrTxC2iX/cK5UsZXy+GlCLXxMLQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TvHB2qpI; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFg2N9YzlgMW3;
	Tue, 15 Oct 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019429; x=1731611430; bh=LlbN8
	fEKFiaYt76DPdWX+8dI6iXGCc0rnW7U7UW4744=; b=TvHB2qpIFY3or6zxqZVm5
	AIgtvaupXyI21cowk5v2WrBlRXGTsCK2nFuNfZgcA9uQp46LiQHGCQAmZNRaayo7
	RqjOz/5gXuZ/KaFyBKTKQePQJl6SUBN3faqZGUXgWbpV4L+yBBFCVp5tPRF0uU5S
	47o/HsFx0aWSqxJVcjYS6Ki7G0osoNdMaYiuo97rPXLpErG34792txxzeFrK1Kk7
	hJiGQnHEencfzvDbh5pBaX/aTWvXxjg469DfK9Ub3d6zkFy+H+oL/1sR+S173A6V
	oYcTnTwwLr01fwJ/hp7rQJ8YcTPLOhcsVE56uQzGRcQht9JgQKok5jDZz9Pjhmyc
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4r7H_nvKU7k8; Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFZ6XhLzlgMVx;
	Tue, 15 Oct 2024 19:10:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 04/22] powerpc/cell: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:35 -0700
Message-ID: <20241015190953.1266194-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241015190953.1266194-1-bvanassche@acm.org>
References: <20241015190953.1266194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/powerpc/platforms/cell/axon_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platfo=
rms/cell/axon_msi.c
index 28dc86744cac..d243f7fd8982 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -112,7 +112,7 @@ static void axon_msi_cascade(struct irq_desc *desc)
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
=20
-		if (msi < nr_irqs && irq_get_chip_data(msi) =3D=3D msic) {
+		if (msi < irq_get_nr_irqs() && irq_get_chip_data(msi) =3D=3D msic) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] =3D cpu_to_le32(0xffffffff);
 		} else {

