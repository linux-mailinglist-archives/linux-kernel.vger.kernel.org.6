Return-Path: <linux-kernel+bounces-396357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2489BCC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E02282A20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4501D5145;
	Tue,  5 Nov 2024 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VA8RVBja"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594281D4607
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807272; cv=none; b=MWjsw2wWaeyR/E+XQ7OKe78ER4Ukx4kOiQr204AIzYwOM43AvgTJ2FGh/WbVyqTcek3pYlnISj7AzZECazpbdXjxqVURuYusK/Q6YtH8fzP/09hEAt1lE3/t445sOSzAL6+r4vcbPHwpHfh4JsS1+82r7jhJCKJoK1q9tNGiYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807272; c=relaxed/simple;
	bh=aYOVC46Cazrt1Axdw38Y3VFYmwtPX3K4NAC43AXYDAU=;
	h=Message-Id:Date:From:To:Cc:Subject; b=tLQMufCe8UpRBId9gVQbDYjG/jj7W0+D2EeGVCUR9hQ8Um0KDEI+ZOT96Rj9AJChWaThXjNxxnyaZ3PfV4lZGI1kGZ4YEUsGkyFNUplgfp9wz/NT8E2bgH8TovXSl5RjTUyh/ZkYOueNdfhnP/1wiG720045x2d0A3kn/lRX40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VA8RVBja; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gEihkgVeEZGLIJKyL++s1jkTY0FxHURxWxJWyyplJG8=; b=VA8RVBja5hxAU0WKygXb8R9uoP
	BsB0ypLxuLY0pqUg4TfqgKMezkV7XgVz7jCHYcYH4JUMeOhoijgjpwcc0ozUGBmoHKkdXRz3Xmu1s
	oRxV4wSp1BHlOa3rSD9VDRuorLN/2URZPbE5RbsNyhEvl61wpuHWzBFJwCyotyZHYiDIOlW6seTqR
	6BVEVRyjfdFUm84wR3pOt8gEZSHNVaSVt8UZnHGydz3o7Mzunzn+SAVps1ooaGSImWomhnU1ZkN5z
	d1ceQkusLDxmfRD0J/JtGL70iYC1iszbean7ldOLNuMg+WMCcU1H25JJkB4xik57RHkr88YmfhrAJ
	cGEGGrng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2E-0000000Bjjl-0wxQ;
	Tue, 05 Nov 2024 11:47:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D87BB30068B; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105113901.348320374@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 alexei.starovoitov@gmail.com,
 ebiggers@kernel.org,
 samitolvanen@google.com,
 kees@kernel.org
Subject: [PATCH 0/8] x86: kCFI and IBT cleanups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

This is the 'safe' set of patches that cleans up a lot of the kCFI / IBT
things.

For now, I've dropped the IBT+ and FineIBT-BHI bits, we'll get back to those
once the dust settles.

Also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt


