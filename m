Return-Path: <linux-kernel+bounces-342502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3EB988FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B81C20C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE91D540;
	Sat, 28 Sep 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PgOz3ck+"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615718C3D
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534388; cv=none; b=D/xZeoCClgRdt3SJEdBWMF2qGt5O2xmMzsNHqFiJEkcU+nWliJyN8dCYG2xybhDxa8bMN13SmSVneFdiH+fC6+hCPGXQycOfDJyMghKzbVrsPUJZqj3LkemCik7JyXWtrcBjo8AAQU+qf/yOLIvPeoXMOf066EtNhfDvTQgjJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534388; c=relaxed/simple;
	bh=lB8EeuHo/CBsDIeCDGwv3mc3alJXaB3uOrf40EgVqcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PO/8/QLnunSoF0VhO8GMrzQBn9Rd2R/hO5rYFf7S4kvSghxevbY3H8lIr2uHbbXllHmArYVyrqyDluwa5y6gQEQ6OSTwijtLaWl2v5rWcv4T/Mfixr0+x7m/oA5Nk/tBPj9QcyeNQ0a1SqiDaQM7wYnOcLbZ7HS5Fknsl//uXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PgOz3ck+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2F9AB41898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727534386; bh=ztLqo6rtvchuWPRBMvUR92kWeXeuJ3yi6/3sym8VWiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PgOz3ck+yV8sEtHP0ti3T6/udquRAj/pFAFSqC6MvUR4uXO2LIJCd8ujPzceOMO+U
	 sK38/lXG+NSUNdzggXrdrT2GTZSL98zkI4TRepJoElM9OYI4Duh7CPOGer8ICZqDwJ
	 d9ZKIlHP/fod3O0zE02J7MHYJZjPvxh0byqyHk7jpcqb2wLAe38Nc7loLPqZh3LWlz
	 cCDSdcnLz9RirJokb8V8jUS61txdvQx3Qu1NmDw6e/f4FBZKMdSJYw2PBpVC1FUYnX
	 pHfJYiERMXnv7WKKE9cD/UwbaZMpZG+myBbo8CfqAor5yHhdRzXw5d4Cyd1DiaqH8z
	 edDvHuLIru+eQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2F9AB41898;
	Sat, 28 Sep 2024 14:39:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: tech-board-discuss@lists.linux.dev, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Cc: tab-elections@lists.linux.dev, Kees Cook <kees@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
 Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jiri
 Kosina <jikos@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Pieralisi <lorenzo.pieralisi@gmail.com>, Amit Shah <amit@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Results of the 2024 TAB election
Date: Sat, 28 Sep 2024 08:39:36 -0600
Message-ID: <87y13bc05z.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

There were 934 eligible voters in this year's TAB election; 229 of them
cast ballots.  The results were (with the top five winning seats):

  1 Kees Cook
  2 Dan Williams
  3 Miguel Ojeda
  4 Dave Hansen
  5 Shuah Khan
 ------------------
  6 Jakub Kicinski
  7 Jiri Kosina
  8 Daniel Borkmann
  9 Lorenzo Pieralisi
 10 Amit Shah
 11 Ricardo Neri

Thanks to everybody who participated.

jon

