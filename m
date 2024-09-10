Return-Path: <linux-kernel+bounces-323526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9DE973E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFC52836A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DF1A2869;
	Tue, 10 Sep 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="iaFJsHkc"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7671A0AE6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988336; cv=none; b=b0CwIdXzXHSNP+s7VXXzbqsLOZkx0MNLYFx+aObFcF/Fjii2rCr9eykihUM515xGc/uz9YDNzyxP2eXNP2oTibYeSdEYeKSyn17yJt9zPfHw+akP8VsOF1EqTordcmwP7tJCjPe0wankTCrYD+w3lGqZsD8hysD+wZf6l3nMpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988336; c=relaxed/simple;
	bh=hOT5GMQf0sxajN79u9Fwqr5JAKaK+MxmbvRmpGMeX+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cczk6AM399nmRV3piMo9yraIn6x4IBvduSB7NXfjCLPNsQzTOltH1CqUB7LOnbPdBCI++eC3CCquYy+y0Bz1sQz8Y2nk+54P6O7qTVfwGoc3UmlzTjbkDB7C1tBCkEZJ3XSrWzoOgYzp6ew3pt9kgOB+qRHV9KlUcmvmNOr1mBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=iaFJsHkc; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240910171210f5ff5dccff39edbc5c
        for <linux-kernel@vger.kernel.org>;
        Tue, 10 Sep 2024 19:12:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=B6PByLSY8FZFbnkn2wtk4NQJcrlvzZ0S45YsHuEs2Kw=;
 b=iaFJsHkcGSVX6yd3OHlXtdBNWH0RPOvWgo9M6gAPgHcp1dJEnXN+0DO6R9T3MtWmGFAu7s
 xPEz6IeNmsR/Fs/fJiMSOVOnK77wciLG+uBg0O91uoyEjH6QxvtRG4r1pqCmLH32N0mNcyFj
 jffF94PPPExaW0EzVQtUMFWOL1/u6U7t214lKMBin5EwgWO67b4R9SrbWQU6xdmws90VVgEo
 cqOptoECRO5BsC5/vLf7TK8R3NLnkwCiLZ6UDOh4bGTEd1TP3OLwULabv9UT6E9NdqUI8HGQ
 z0DtyG5lMwhBRorMevKiNAtVQWLI8mousd+F4w0I+7yIYnsivjxIEX1w==;
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
Subject: [PATCH v3 0/2] io_uring/io-wq: respect cgroup cpusets
Date: Tue, 10 Sep 2024 19:11:55 +0200
Message-Id: <20240910171157.166423-1-felix.moessbauer@siemens.com>
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
io_uring/sqpoll. It has been successfully tested against the liburing
testsuite (make runtests), liburing @ caae94903d2e201.

The test wq-aff.t succeeds if at least cpu 0,1 are in
the set and fails otherwise. This is expected, as the test wants
to pin on these cpus. I'll send a patch for liburing to skip that test
in case this pre-condition is not met.

Changes since v2:

- rework commit message (remove ambient and worker from title as well).
  Sorry for the noise.
- no functional changes

Changes since v1:

- rework commit messages (don't use ambient cpus, wq threads are no
  pollers)
- no functional changes

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (2):
  io_uring/io-wq: do not allow pinning outside of cpuset
  io_uring/io-wq: inherit cpuset of cgroup in io worker

 io_uring/io-wq.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.39.2


