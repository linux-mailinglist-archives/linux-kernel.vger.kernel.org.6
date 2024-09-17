Return-Path: <linux-kernel+bounces-331491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC3697AD73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB67C1F22E91
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251B315C138;
	Tue, 17 Sep 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+yeMOKm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubhbfIPG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752D4594D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563673; cv=none; b=Z4uuJMsJJ2gVl/Ssj2dpJ8r3cQ27tH0+wLCQIusGFJYHbggQH+9HUCA62Bj8CUjd36ZHEcCjN77pjcqb0X8agwRcA9bb/Fbkvp5xrTMdkS+Th6aQyckjokxvc7U3pQd9sWGnGwKFqmeaPKO1BEipN28KZf5C9aSQujZGIlGkhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563673; c=relaxed/simple;
	bh=FfTt7DakWlYcn7oVa9+M6Q8rs2NTO2qcMODpYcRd9BE=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=BHoHYLOgypJXQCi3UksyhJ/Se1Kpbpl4zitrWS7lI+NZSh1Wkljb2PsbN7jBw6avn+nKLbwg5Ri/dZGPOAmrLZvTAuAT7RhBJ8mNiCUEnybcwXXdVJ69a+zuzqBBVnwhu3KzPGEUdOxmlZBM+giZGAYdEU1qFd7jd1zLwFhPcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y+yeMOKm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ubhbfIPG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QO+79JE2qWdTWvYywoNt0xVeTazweViRmroElAj/tbs=;
	b=Y+yeMOKms1U6kxigztCBsg78/lttFn9i8lDlakN9ocq2mie4zbLHmlY79SO1jI49CVnhjl
	5RJ6G/7w5vHSwKBVCTe9cZnABAY0mh3jULC1wzdbqdv2IeB09l+aAlQw0/XOD0meL3Fkuh
	09FT7mGdmSQYARhnC7dsyBbZ19jFtcg4thABsl3HcMAXn4bXkMHbwPkSiOqCsbIelRIyNe
	HDVjcNtoseh937ylQqguRSubT99mwiRnwRLtV3QGn3vOxTesr//CxAYDJuAJeWjy+wgTyu
	pf764MuHGdrmHsJHNnvZVObMb22GhgYXcydMESmZkbRqLnxnQKl/nFj/XYUjBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QO+79JE2qWdTWvYywoNt0xVeTazweViRmroElAj/tbs=;
	b=ubhbfIPG+raaw4bckZKkq8q3bmD+t3ftokufnnLw+7IjeJ5fjPmusfIXctuQIilz/C1Zdx
	l7jQxNr/ME9vzMBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/domain for v6.12-rc1
Message-ID: <172656366281.2473758.10766953231775492818.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 11:01:09 +0200 (CEST)

Linus,

please pull the latest irq/domain branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-domain-2024-=
09-17

up to:  74c60a96ef6a: irqdomain: Remove stray '-' in the domain name

Two small updates for interrupt domains:

  - Remove a stray '-' in the domain name

  - Consolidate and clarify the bus token checks so they explicitely check
    for DOMAIN_BUS_ANY instead of unspecified checks for zero.

Thanks,

	tglx

------------------>
Andy Shevchenko (2):
      irqdomain: Clarify checks for bus_token
      irqdomain: Remove stray '-' in the domain name


 kernel/irq/irqdomain.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 01001eb615ec..1acc5308fcb7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -130,8 +130,10 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
=20
 static int alloc_name(struct irq_domain *domain, char *base, enum irq_domain=
_bus_token bus_token)
 {
-	domain->name =3D bus_token ? kasprintf(GFP_KERNEL, "%s-%d", base, bus_token=
) :
-				   kasprintf(GFP_KERNEL, "%s", base);
+	if (bus_token =3D=3D DOMAIN_BUS_ANY)
+		domain->name =3D kasprintf(GFP_KERNEL, "%s", base);
+	else
+		domain->name =3D kasprintf(GFP_KERNEL, "%s-%d", base, bus_token);
 	if (!domain->name)
 		return -ENOMEM;
=20
@@ -146,8 +148,10 @@ static int alloc_fwnode_name(struct irq_domain *domain, =
const struct fwnode_hand
 	const char *suf =3D suffix ? : "";
 	char *name;
=20
-	name =3D bus_token ? kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep,=
 bus_token) :
-			   kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
+	if (bus_token =3D=3D DOMAIN_BUS_ANY)
+		name =3D kasprintf(GFP_KERNEL, "%pfw%s%s", fwnode, sep, suf);
+	else
+		name =3D kasprintf(GFP_KERNEL, "%pfw%s%s-%d", fwnode, sep, suf, bus_token);
 	if (!name)
 		return -ENOMEM;
=20
@@ -166,11 +170,13 @@ static int alloc_unknown_name(struct irq_domain *domain=
, enum irq_domain_bus_tok
 	static atomic_t unknown_domains;
 	int id =3D atomic_inc_return(&unknown_domains);
=20
-	domain->name =3D bus_token ? kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus=
_token) :
-				   kasprintf(GFP_KERNEL, "unknown-%d", id);
-
+	if (bus_token =3D=3D DOMAIN_BUS_ANY)
+		domain->name =3D kasprintf(GFP_KERNEL, "unknown-%d", id);
+	else
+		domain->name =3D kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token);
 	if (!domain->name)
 		return -ENOMEM;
+
 	domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
 	return 0;
 }
@@ -200,7 +206,7 @@ static int irq_domain_set_name(struct irq_domain *domain,=
 const struct irq_domai
 			return alloc_name(domain, fwid->name, bus_token);
 		default:
 			domain->name =3D fwid->name;
-			if (bus_token)
+			if (bus_token !=3D DOMAIN_BUS_ANY)
 				return alloc_name(domain, fwid->name, bus_token);
 		}
=20


