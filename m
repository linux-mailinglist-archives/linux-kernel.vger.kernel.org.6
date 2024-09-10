Return-Path: <linux-kernel+bounces-323242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560949739F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124B028AAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B9196C9C;
	Tue, 10 Sep 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="TRrGEo4l"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8218EFF9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978816; cv=none; b=hql1p+c2kSnSRrVHfebG7M9LyJblNVJa79J9FA3FtJqCT3uz2NjKtl9JyEGdniKqf6MRNPZya546u+5wJoTIODSPZcjalENBwrZ+Z00TpSvf1437uFmKhHCxcMhzw4NO+ua0HH+m4yCRZdsl7H+co6r/BXEYHeJ0ge1JuPI9BG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978816; c=relaxed/simple;
	bh=poE8grF23H6F7X6kladvopyA9WzGBQJEyFVgCwLsZQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gUv+01PYy9cVfmvRq6A6Fz0R+yabYNIXDAa/ocpc2c5Hn8P2y9PGY8b64/m9phDA0Tb3RzF1gTR0451AN76PWei49dAMdXkB3g68fDHo0Dox9+0MLfhcTcugULKfXOk+6yp7kLna+cK4HE0N4Sijsv99kiQ7YXjEeUPzbFwDJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=TRrGEo4l; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202409101433297afcd7be3acbc62ce5
        for <linux-kernel@vger.kernel.org>;
        Tue, 10 Sep 2024 16:33:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YhEk9dDDTR4Esasd68P4fshsCaDrjR3/+F0dNLo1y8c=;
 b=TRrGEo4lTdKAcEt7WDLBAJz+Y09fpohs3hI/QT7+E0IZDpaV422/VtQbok/drlU2vdFW9x
 Z5Z26hUFvrIFu228o1URCSF5fJqMGY8mC6cSSd7M65WWDUzEVbmKyEYjE+Lbv+FgrzXWZyRa
 XonRCtlanYnHT5dLX3r8TvCPjN7HEDm4ZxJKFAQG/Ygs7p1qMJg5z6Qrjr44GMDL9AAESA8N
 lhCo0W5gAlTA0AN9Xvr3YrA7tRHl/a8hhWIEAVh67RA1d9oxIlltM2q8zfMWUrMwwaxtbEfe
 YMvYQuGGjDw3ca9aer5lgz6DDjdbqJvXu58g+v6r1LnjZSlIbmilQ25A==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 0/2] io_uring/io-wq: respect cgroup cpusets
Date: Tue, 10 Sep 2024 16:33:18 +0200
Message-Id: <20240910143320.123234-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

Hi,

this series continues the affinity cleanup work started in
io_uring/sqpoll. It has been tested against the liburing testsuite
(make runtests), whereby the read-mshot test always fails:

  Running test read-mshot.t
  Buffer ring register failed -22
  test_inc 0 0 failed                                                                                                                          
  Test read-mshot.t failed with ret 1     

However, this test also fails on a non-patched linux-next @ 
bc83b4d1f086. The test wq-aff.t succeeds if at least cpu 0,1 are in
the set and fails otherwise. This is expected, as the test wants
to pin on these cpus. I'll send a patch for liburing to skip that test
in case this pre-condition is not met.

Regarding backporting: I would like to backport these patches to 6.1 as
well, as they affect our realtime applications. However, in-between 6.1
and next there is a major change da64d6db3bd3 ("io_uring: One wqe per
wq"), which makes the backport tricky. While I don't think we want to
backport this change, would a dedicated backport of the two pinning
patches for the old multi-queue implementation have a chance to be accepted?

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (2):
  io_uring/io-wq: do not allow pinning outside of cpuset
  io_uring/io-wq: limit io poller cpuset to ambient one

 io_uring/io-wq.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.39.2


