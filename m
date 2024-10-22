Return-Path: <linux-kernel+bounces-376826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA29AB65E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7B81C230A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28A31C9DD3;
	Tue, 22 Oct 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="HRXpi1lO"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F412F5B3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623741; cv=none; b=nA7p59MDvoqdxzXUUwmerG41m3S1oNSwIYCNkyEpEwFW8OtHtvhsPCuQ4wPBu9m/YNVvI4gIjcoNFIE6Ey1Rm6GW860HYNkChSw+6j2f+BfE7vYdRUdneC7SK5+BrgJhDnEdAyEMeRXd4lnhq9NIHeYfPQAvd1iomUzxg9G4/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623741; c=relaxed/simple;
	bh=rcAJJoYqgcI/IwSSwpLSA9ygpMw6mEh10rPXMsbA6YQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ra2CCjCq+i1fhNUCXk00jI+3I2owOX6LPKRwKnkPdrj31ufXEHS0dkeh9b6Ij58Y3lhXD9ajQo6IbdMOld2zY0ubR+bNDrqCy64Eu7IejtqAEVQXiRwRIAXAafhh020fGuDuX1O4J9EQkJ3dqGJrapYpZmFN5M8kNSQKQqaKyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=HRXpi1lO; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 52FBF177102; Tue, 22 Oct 2024 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729623737; bh=rcAJJoYqgcI/IwSSwpLSA9ygpMw6mEh10rPXMsbA6YQ=;
	h=Date:From:To:Subject:From;
	b=HRXpi1lO/Ymji76Z/jKvfukW4BJ6UFdYFnHTH1VgF9+PhFIdYDRjiVz7vv+wsvSd+
	 Z7dZB2LCbanzq3mUNJaxPbGR37UI6QmcFlO10ygPOTqm7Fxe+0gsLImPkzj/yGgJS5
	 ZURxuRgacWCxJoAcsbbgAilgPFDGWVLLPMXuzgWZIm1q6TdXe1xqSd13fmWZ9zomh2
	 XI6sUNhL/gfNjJ7Byg0fHUlZYRQ9YyEV1SGvI/9g/SrFcTUSXtvpL66MAH7ChXYvnW
	 oqDMlVfILaYEBIOqbP00OIrCwyXYuLc/aSTbDbNv12iCtX1TVQMwxuaq7JFfU0dDN5
	 0r2eLO+puIcPA==
Date: Tue, 22 Oct 2024 19:02:17 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KDB: Fix missing argument in dmesg command usage help
Message-ID: <20241022190217.GA846685@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: Currently when running "help" in KDB, it shows the "dmesg" command
as having only a single argument, when in fact as can be seen in the
implementation of the command (kdb_dmesg) it accepts two arguments

Solution: Add the missing argument to the usage string of the "dmesg" command

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f5f7d7fb5936..5f56ade565a6 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2827,7 +2827,7 @@ static kdbtab_t maintab[] = {
 #if defined(CONFIG_PRINTK)
 	{	.name = "dmesg",
 		.func = kdb_dmesg,
-		.usage = "[lines]",
+		.usage = "[lines] [adjust]",
 		.help = "Display syslog buffer",
 		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-- 
2.39.2

