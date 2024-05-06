Return-Path: <linux-kernel+bounces-170256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F688BD431
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE911F24323
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF01586D2;
	Mon,  6 May 2024 17:53:22 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19949158201
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018001; cv=none; b=HuivpmJPGelXQRYA1cYmTBYL1GQU2NJkYS6o4EliPWvHQvUia/k+GXkgwClCcPcVXVAHAFT/E1oVnejAwMWwXF/uUuXJygmgALicsOQWqc7r7OSBHB92nvOjn01JjNWQ9vjHrYyFlth1JWTkHzOuNQZ3YS6t0gEKw4vvDtnm0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018001; c=relaxed/simple;
	bh=dZJITMfil5sj6ftzFNXFv4mw2/ZCBeNVf6ycyded6vk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m64qGPO6mSqvJ3jaP3tVqulyl/PLCXDca6bQFi1oES5ePVXsMIMGJNuP9nPvnv8fjMmLwzxTQFZVYed2b3CQsXVgRaoIpBQJLV5oP8y3GPIZbksK++LPM1ro83z1tjyIKjA2qruyLZVdjTXXDr6GT2E06dAGr0bN55bu0pAt480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 43F06280067B9;
	Mon,  6 May 2024 19:53:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1E7C5AEB3E; Mon,  6 May 2024 19:53:10 +0200 (CEST)
Date: Mon, 6 May 2024 19:53:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: coccinelle matching of identifiers
Message-ID: <ZjkZBvuXlZAodPAU@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear coccinelle maintainers,

Linux kernel commit 5c6ca9d93665 ("X.509: Introduce scope-based
x509_certificate allocation"), which is queued for v6.10 in this repo ...

    https://git.kernel.org/herbert/cryptodev-2.6/c/5c6ca9d93665

.. triggers scripts/coccinelle/null/eno.cocci:

    ./crypto/asymmetric_keys/x509_cert_parser.c:69:9-15: ERROR: allocation function on line 68 returns NULL not ERR_PTR on failure
    ./fs/gfs2/inode.c:1850:6-12: ERROR: allocation function on line 1842 returns NULL not ERR_PTR on failure
    ./fs/smb/client/cifsfs.c:1186:6-12: ERROR: allocation function on line 1173 returns NULL not ERR_PTR on failure

The first of these three errors is newly introduced by the above-linked
commit, the other two already existed before.  All are false-positives.

I would like to silence the newly-introduced false-positive and have
attempted to do so using the small patch below.

However the result is that *only* the newly-introduced false-positive is
found and the other two are no longer found.  So the other way round than
what I'm aiming for.

I find this bewildering.  What am I doing wrong?

FWIW, coccinelle version is 1.1.1.

The newly introduced false-positive is triggered by the statement:

    assume(!IS_ERR(cert));

Which is a macro that expands to:

    do { if (!!IS_ERR(cert)) __builtin_unreachable(); } while(0);

The macro gives the compiler a hint that variable "cert" is not an error
pointer, which prevents the compiler from adding an unnecessary check
for that condition.

Thanks!

Lukas

-- >8 --

diff --git a/scripts/coccinelle/null/eno.cocci b/scripts/coccinelle/null/eno.cocci
index 7107d6c8db9e..79112d51bee8 100644
--- a/scripts/coccinelle/null/eno.cocci
+++ b/scripts/coccinelle/null/eno.cocci
@@ -26,10 +26,12 @@ x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache
 @r depends on !patch exists@
 expression x,E;
 position p1,p2;
+identifier assume;
 @@
 
 *x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
 ... when != x = E
+    when != assume
 * IS_ERR@p2(x)
 
 @script:python depends on org@

