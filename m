Return-Path: <linux-kernel+bounces-551852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D79A5721F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C097A3574
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA20254AED;
	Fri,  7 Mar 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ezTlkzZC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55054250BF8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376300; cv=none; b=HnkLgcSOR6fhEDkJjttr9W6nVDA/6X1GNFc0e6GOKqJ/cBvx5Y5TGNt0PTLU2QyqVK8A0EB3fRVwOR+oKQasNL6FcAZ8utc12ikbc8Fr8iBW+uKK/pqq3TqTTQdmbxy4DXXibGouMdyNVy1dc6tRBtActVkokIzou/XJCNH/9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376300; c=relaxed/simple;
	bh=/3hNA2Uo+0p5qHAkZX40MS4jjODKDMpTpstTj+3Vgc8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=gvySvIMWtAlVUCpHM29HvJ6re76G9zR4qasLSuPO7MCX9CQGe3Qxub4eMrt4OLfmSXaRW1NPHX/i6J/zHCRf0FuWNeWE8Apjg1o08cBQp60bIDT3snCN7y+sUP4uc/NmYN8mg71KrqyM47YtIQ84lBhxt1AF3ppCbw4XSnxJEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ezTlkzZC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XGauN/Z8AN/QXf9GVlFLc0lHdL7IyFuvPpvwm9DWHWc=; b=ezTlkzZC+ggW5Cln5xhjC7Szxm
	d99VFVMZWJDNnAWgc8xKEHCjxTR+far+1Q5NuEuevKdeaWEzBeZsrFqujTYFrfG4ECqaj/bPNhuRp
	Bs/af6CokatXlxfeNU3KLQc6B5jKZUUgAAmMqPIi4cNbWuJpxLpbvDvkI+yr+pLJd58Sm3RWrHBrl
	/ZZ5O/wTaDXJbJhW7t8FJ2SlymvfJ+EU9wgwrGxxY3B+M8H7g9bPG+1FaYJK9nrYiiVF00kLUQseZ
	+RCOnRbHPkzgSXqWY1RYAGnGa1z7Yk7om3sz5/2OGkMJfCF7c5ctoNsZbTnaF/2ZwxEmHHXwuKLOt
	uU1Unh5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdWP-0000000EKgJ-33V3;
	Fri, 07 Mar 2025 19:38:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 055CF30031C; Fri,  7 Mar 2025 20:38:13 +0100 (CET)
Message-ID: <20250307193305.486326750@infradead.org>
User-Agent: quilt/0.66
Date: Fri, 07 Mar 2025 20:33:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 ravi.bangoria@amd.com,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH v3 0/7] perf: Make perf_pmu_unregister() usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

Much smaller this time because Ingo merged a whole lot of the preperatory
patches, thanks!

This appears to survive a few hours of perf_fuzzer combined with tinypmu testcase.

Patches also at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/pmu-unregister


