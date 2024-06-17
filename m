Return-Path: <linux-kernel+bounces-216927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC290A8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5971F238BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F0190476;
	Mon, 17 Jun 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IG3n5ZRu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGxj422q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IG3n5ZRu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGxj422q"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2195171B0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613918; cv=none; b=KfZmocZQ1LJVjs4c4K3aTP/9xA5TYpK+hhQK0mA5epY8xM9gOzHcX/8guhn/tgl16CsVwiinXkCOonzThRrazND2w2a8rbNZjxOYyVlS1vYdkU6X8nkFm2k+4QBJqLZkVW5A7P3DLXAZiw+w7KD7RGttSWj3jSwycKgpaeGQFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613918; c=relaxed/simple;
	bh=SVy6OHg009Swz/Sd/5Eq8ZRM+95wiya89k/TGyFhoZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qb4AEyfYIifxbW29eBDSiKlf8LApyornsrCEEx9WnMisFzWmwjSWVTdBmI39dG48Z90IWOhBCMFkFOGukkbXfmO5rBzfbutWRNAjqmgEviDaxVQvQGZPyKAKbfC6TJ0MuROdvFxAI3VhDQaqe18JwJzZ3NBrY2xsJQ+qPvc6Oz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IG3n5ZRu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MGxj422q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IG3n5ZRu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MGxj422q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DB3337EB3;
	Mon, 17 Jun 2024 08:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718613914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwvYyUU/I6y6bG2CMrgFpa1GqXf9BHj+GbL9duN551g=;
	b=IG3n5ZRu5Z5tl+D0upLaiXWlLrYpj6FX5+fBdZ07KSMl/pxXzyY/9o6nXqI77Q05+QbmBg
	7ICikjY5U3qezGt9Gm1c5Mf/QiBzqARr48Jr3yT1l/2K/YiFPtsQVn+vM3757ii9U9WPO9
	BapsUUMJm55HFfbatJvsgvSagC5n+TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718613914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwvYyUU/I6y6bG2CMrgFpa1GqXf9BHj+GbL9duN551g=;
	b=MGxj422qJlzIfkRVj7HjHfvGpRig2iq2frrsAp6FArrQqL6RuD6LiVAtV/bcgjza47cL32
	HDe4djyBDQbtsLAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718613914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwvYyUU/I6y6bG2CMrgFpa1GqXf9BHj+GbL9duN551g=;
	b=IG3n5ZRu5Z5tl+D0upLaiXWlLrYpj6FX5+fBdZ07KSMl/pxXzyY/9o6nXqI77Q05+QbmBg
	7ICikjY5U3qezGt9Gm1c5Mf/QiBzqARr48Jr3yT1l/2K/YiFPtsQVn+vM3757ii9U9WPO9
	BapsUUMJm55HFfbatJvsgvSagC5n+TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718613914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwvYyUU/I6y6bG2CMrgFpa1GqXf9BHj+GbL9duN551g=;
	b=MGxj422qJlzIfkRVj7HjHfvGpRig2iq2frrsAp6FArrQqL6RuD6LiVAtV/bcgjza47cL32
	HDe4djyBDQbtsLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04E3E13AAA;
	Mon, 17 Jun 2024 08:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G44PNpj3b2ZTZwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 17 Jun 2024 08:45:12 +0000
Date: Mon, 17 Jun 2024 10:45:09 +0200
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko
 <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley
 <joel@jms.id.au>, arnd@arndb.de, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] drivers/soc/litex: drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20240617104509.70c447b3@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[antmicro.com,gmail.com,jms.id.au,arndb.de,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

As a minor optimization, this also lets us drop of_match_ptr() and
ifdef-guarding, as we now know what they will resolve to, we might as
well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Gabriel Somlo <gsomlo@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>
---
Already sent on: 2022-11-24

This is one of the only 3 remaining occurrences of this deprecated
construct.

Arnd, in December 2023, Gabriel suggested that maybe this could go
through one of your trees, as apparently there's no dedicated path to
upstream for litex patches? Thanks in advance.

 drivers/soc/litex/Kconfig          |    2 +-
 drivers/soc/litex/litex_soc_ctrl.c |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-6.8.orig/drivers/soc/litex/Kconfig
+++ linux-6.8/drivers/soc/litex/Kconfig
@@ -7,7 +7,7 @@ config LITEX
 
 config LITEX_SOC_CONTROLLER
 	tristate "Enable LiteX SoC Controller driver"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on HAS_IOMEM
 	select LITEX
 	help
--- linux-6.8.orig/drivers/soc/litex/litex_soc_ctrl.c
+++ linux-6.8/drivers/soc/litex/litex_soc_ctrl.c
@@ -82,13 +82,11 @@ static int litex_reset_handler(struct no
 	return NOTIFY_DONE;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id litex_soc_ctrl_of_match[] = {
 	{.compatible = "litex,soc-controller"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
-#endif /* CONFIG_OF */
 
 static int litex_soc_ctrl_probe(struct platform_device *pdev)
 {
@@ -130,7 +128,7 @@ static void litex_soc_ctrl_remove(struct
 static struct platform_driver litex_soc_ctrl_driver = {
 	.driver = {
 		.name = "litex-soc-controller",
-		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
+		.of_match_table = litex_soc_ctrl_of_match,
 	},
 	.probe = litex_soc_ctrl_probe,
 	.remove_new = litex_soc_ctrl_remove,


-- 
Jean Delvare
SUSE L3 Support

