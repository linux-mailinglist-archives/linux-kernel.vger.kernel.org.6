Return-Path: <linux-kernel+bounces-342141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D1988AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C140F285397
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B711C6884;
	Fri, 27 Sep 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nAAbdgKL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0D1C2DAE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466664; cv=none; b=cdwoMtmnaA+cPnItxnWSAwZrqacQMI4/WC7ARzx+AuNN66TdJ06xOUX2+senUaK0ikg0LCXP19gf/P17uwE6OYvn/0pk4fkSbo1NrG7o6oajDEn/c/L5XVQtDSBO1dNCVcyuMsWKzv/pTLQymboD72wGn5y2DzmB0vJ2Ul1OkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466664; c=relaxed/simple;
	bh=vjfobNGjDxZJwbeoKPauZy0VzoBeqChWSeJtnqN/6Yo=;
	h=Message-Id:Date:From:To:Cc:Subject; b=Te47JAKrWzDyr40NO5jsoC4q24EA9DuyH4tW9jyW8IPJq2xleUDzdt1WmBQ8JCWpH09ha/RevArr4h93d5UElqgt+ScNhgsS2r0QwmWp3nlVcSjnHlKj23+izEkOARdAyPsbvg2l7OoF5jJKzrxc/+j7xoUCKyK3R4VRaMwgt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nAAbdgKL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SM7YuL6FqBtbbREmJXvS1jsWOZFAE7p/uN71rWtrImc=; b=nAAbdgKLTUjQuoVGwk+n1ScJt1
	mA1xsD9qRQuOiMgL7je5RFgBtumC7kvub87xguvwG82mBH2NVz9yAm+7n/e3ePC1RdNHfiXLb1M2r
	cJV1PTVW5/w/hf/pz0gaQXgroRGZ20spZeO/qxxMm2qsHPR3LDEmJRZGGpDFI01CKdXBcP0NVUImk
	ExtXVgFpPSZP3Hthc/itfaaYeH3RACA0oSSVhU6SYA7MlgzItec0EmJHVKD41D+k7CfjCSATEbV7T
	/SscaMf1D5gvTIG92vwnTLkP77/aHRMhUmLmAFFd0s6JeKqYpf6flSpWgRUvuQ8zW/84+CTEh8pcj
	vYw0yN7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzF-00000002Onm-416l;
	Fri, 27 Sep 2024 19:50:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A5507300848; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194856.096003183@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:48:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 00/14] x86/ibt: FineIBT-BHI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Hi all,

Since I got back from Vienna sick as a dog, I figured I'd do something simple
like rebase some previous work...

The thing I picked was FineIBT-BHI, an alternative mitigation for the
native-BHI issue, something that I implemented somewhere late last year while
the whole thing was still embargoed.

Specifically the paper mentions that FineIBT should avoid the problem, but
showed that the IBT implementation of current chips falls somewhat short of
the desired semantics and there's still a hole.

This here scheme (by Alyssa?) closes the hole and performs favourably
(Scott?).

The major stumbling block is that it relies on a compiler extension of the
kCFI infrastructure -- and while I did me a llvm POC, a real compiler person
should very much take the idea and do it right (Joao?).

Notably, GCC doesn't currently implement even basic kCFI:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
  https://lore.kernel.org/lkml/20230325081117.93245-1-ashimida.1990@gmail.com/

(an interested GCC person wanting to help finish that patchset and add x86-64
support would be much appreciated)

Anyway.... obviously this wasn't at all simple, nothing ever is.

The first many (10) patches are massaging/hardening the existing (Fine)IBT
implementation and all that should be mergable without fancy new compiler
stuff.

The last few (4) patches, starting with the llvm patch, is the actual
FineIBT-BHI mitigation.

The kernel patches are also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt
  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt-bhi

The whole series boots and builds the next kernel on my ADL -- using the custom LLVM.


