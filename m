Return-Path: <linux-kernel+bounces-414613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA39D2AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CD41F21353
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6AE1D0F5C;
	Tue, 19 Nov 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjnyBI0S"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A814A615
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033927; cv=none; b=C1KyFMTUIfpgLyaeukwFOMqJtEkaY9CqegtCMIBCsb2rhwbKan/RMBvSPLh7Xv6nNknvj15sRNjhmjNq2lwRynUEmVe1siVbnfVB1ci5/jEspRzDVR5GSykN3oDrnDo8uglDOwLAU/hWHMoUyWvLoAaAAC0A461Iu2i6xW1RzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033927; c=relaxed/simple;
	bh=8J1gZadRMWONZApRH6YuTFtmy+uVcY3RLVI8fTp1f/A=;
	h=Message-Id:Date:From:To:Cc:Subject; b=Z3LqNz3SvyMz40UxzPZfvv4vvPn+B5xJ6jTYD3/QfsgyOMczFFGFn6DlpS8Do5rdEyiONv6hGKdLRdaOIg0HlsdHRmsKDz9xF2TmHJnhZjMdbKOG+HX6rYGMP203ngd6sM9zfC9Qg6O53ZC9Vegv4eYfgunKoy0fVC3Swi6PJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qjnyBI0S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8J1gZadRMWONZApRH6YuTFtmy+uVcY3RLVI8fTp1f/A=; b=qjnyBI0SENa8FUfGXoM/lJApDb
	QELRCxxcvZ0jKgpJbzbc8yYh4JyhcSbZgKnNKW0+h/tNoUaAlzDGgepSRw3l0UuE89M37KhpReIQ6
	Ci6QipDzvav6AkPgmgkTg3rCES42ycLM8x/WXkc9Qa4tfMlKzfGfkElzo//uJQ7Zl+kTvmr1hDuar
	6PW9dcOLvxWspdTgwwKL6SKuEeWHbCZzWpzYqNKASYxMa/Sl1wStrEm3vzvOLLupzI9dLTKbcerwV
	DlZOXmb34aPXOfsrlwpPoUnlv2bUzQcORhVaSabmU+MdG9mxMU/i08q+vjHb3LtIspqUsW36gBWcL
	zOfMUXZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR90-00000004IUE-299G;
	Tue, 19 Nov 2024 16:32:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D406C30023F; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119162527.952745944@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 0/7] x86/mm: Clean up and use temportary_mm more
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

These are most of the patches I had in x86/lazy and are the preparatory patches
for x86 to eventually run witn MMU_LAZY_TLB_REFCOUNT=n.

The rebase and submission prompted by Rik's recent context switch optimization
which touched unuse_temporary_mm() in a way incompatible with these patches.

I'll see if I can find time this merge window to also finish that last patch
so that x86 can indeed switch to MMU_LAZY_TLB_REFCOUNT=n, that too should help
with context switch times.


