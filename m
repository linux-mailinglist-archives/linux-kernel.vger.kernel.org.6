Return-Path: <linux-kernel+bounces-237035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D01191EA27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5581F21CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C3016EB7E;
	Mon,  1 Jul 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pydKs1D9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAB83CC8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868970; cv=none; b=NbFEE5Bj5pRLZv4P4fSRNocgtWcP/YjVhVD53N+AyufCLsdEtJqub1OYjEiwQ0aZj4+/9pmb4OcAE06NNHhwwDqCySyEKvIdIQvd/9UTSgdhEmxCfgm+436thvHE3S6GEnm5L4Q5iskQFzmjl62xQeCAsYOqC1BqMoacle6xewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868970; c=relaxed/simple;
	bh=C6hwA9WiWjI0vwhBnyO0uhdnyGgmsDABKgj/1fPvRuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FxPoT54kRfajABh2povuHl+nnNx6AsY5Ek6c7Ds2EZ0HT/Hoz2frHSy9u0HY3TnJ/LNdk8a2l2fkVV0XPBELTWaNUNSWAseSVnkwHKFB3gbMRQgxBrwyvM5JKVrFKU0zyvl+RyjwRS9N2qdL0rkUcvtrcWw9zRse2Z7cdEBRE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pydKs1D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F6BC116B1;
	Mon,  1 Jul 2024 21:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868970;
	bh=C6hwA9WiWjI0vwhBnyO0uhdnyGgmsDABKgj/1fPvRuc=;
	h=From:To:Cc:Subject:Date:From;
	b=pydKs1D9zRPayuKgORFFuOehtBOUm8Pl4LE570qTwqeGQIoaqm2GCgpLW91pe0huJ
	 KclKH0+GZODByg7VQK5PH4bh3LESJJjZ1r/7FeZgMa6zfU6EsIcin9FCUrpFVFBPG2
	 kLZtY4/gw2Yq8WRkO0n7D6x45HLxbdN0zN9Z5kgSw6/yWYeXAwxQ4xw3cL+gwW7MbD
	 F1DSD44cKn2QISdLgzfKDfKF+OOa2b+vc2HdgZjHzmZWOQEmqLJv9jEfxWbq9Ejn8F
	 VqM9dpmNylbeL9qJPGX/uVuLSsfpLcwosnmxEmDCokaSqTUCPn31Fa/qX928KiiwCh
	 xzVRgVrv7rWHA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linuxdev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Quaterly News Letter (2024 Q2)
Date: Mon,  1 Jul 2024 14:22:44 -0700
Message-Id: <20240701212244.52288-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello DAMON community,


Time flies.  The second quater of 2024 has passed.  Let me take a time to look
back what happened to DAMON community in the last three months and share my
humble summary with this quaterly news letter.

Highlights of Highlights
========================

DAMON gained a feature [10] for CXL-based tiered memory management.  HacKerMaiL
(hkml), a simple mailing tool that DAMON maintainer is developing, made an
official commitment [12] to support DAMON community.  DAMON has presented and
discussed with more people from OSSummit NA [4] and LSF/MM+BPF [7].  It will
again be presented and discussed with more folks in September [10,13].

Please read below for more highlights for each month.

April 2024
==========

DAMO v2.2.8 has released [1] with memory footprint monitoring feature.

DAMON news letter for 2024-Q1 has posted [2].

Using Oracle's awesome kernel configs comparison tool, we found some dsitros
that enable DAMON on their kernel [3].

DAMON has presented[4] on Open Source Summit North America 2024.  The third
in-person DAMON meetup has also held [5] on the conference.

May 2024
========

Access/Contiguity-aware Memory Auto-scaling second RFC idea with example
implementation is posted [6].

DAMON's status and future plans have shared and discussed on LSFMM+BPF.  LWN's
summary of the session is available [7].

Memory managment subsystem pull request [8] for Linux 6.10-rc1 that contains
DAMOS young page filter has merged.

Beer/Coffee/Tea DAMON meetup has extended [9] for reservation-based ones.

June 2024
=========

DAMON talk for Open Source Summit Europe 2024 has been accepted and
scheduled [10].

SK hynix' patch series titled "DAMON based tiered memory managment for CXL
memory" has been merged [11] into mm-unstable tree.

DAMON community got a simple mailing tool called HacKerMaiL (hkml), which is
officially committed [12] to support the development workflow.

A session for DAMON at kernel summit 2024 has proposed [13] .

Previous news letters
=====================

- 2024 Q1: https://lore.kernel.org/20240402191224.92305-1-sj@kernel.org

More Past DAMON News
====================

If you're interested in a humblie list of more DAMON events that happened in
past and curated by DAMON maintainer, please reach out to the project site's
news page [14].

References
==========

[1] https://github.com/awslabs/damo/blob/v2.2.8/USAGE.md#recording-memory-footprints
[2] https://lore.kernel.org/damon/20240402191224.92305-1-sj@kernel.org/
[3] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON
[4] https://sched.co/1aBOg
[5] https://sched.co/1cP4G
[6] https://lore.kernel.org/20240512193657.79298-1-sj@kernel.org
[7] https://lwn.net/Articles/973702/
[8] https://lore.kernel.org/20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org
[9] https://lore.kernel.org/20240519163329.150340-1-sj@kernel.org
[10] https://sched.co/1ej2S
[11] https://lore.kernel.org/all/20240614185328.BA2C1C2BD10@smtp.kernel.org/
[12] https://lore.kernel.org/20240621163626.74815-2-sj@kernel.org
[13] https://lore.kernel.org/20240614175504.87365-1-sj@kernel.org/
[14] https://sjp38.github.io/post/damon_news/

