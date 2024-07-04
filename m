Return-Path: <linux-kernel+bounces-241696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9F927E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5827EB23701
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAF613D289;
	Thu,  4 Jul 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZML/0wn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05952F23;
	Thu,  4 Jul 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123058; cv=none; b=b8Pqxn1PYhwzr8M+t3XyL7lnIvnE/NhZ54irr3BPZ0razKFu7EaHVCx3ft57NliBgMPULZw+CSm3Htx6+yEhNmtflRcsN265hxvx/RubfoVhjRhRZBECEAeD/L8WPNs5krbUtJE3XdivNQ27wMM5yudMRsBhXbJFtXa10VSjlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123058; c=relaxed/simple;
	bh=31fAkgTaScFRc2itOPGOEvyV6GsdONtUkGifgrsCSPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PV7kEd+aDoXEu6nSGqI5AccV5I6FC91K5KrrnYYDb4GvnHPZdmUmf9xiTriuANwnhiEJ5A+rV/OkqTQXiv1q5r7pLvt80aaPM5xB/w4P663J4VQ/ttXxwFr80qzXXeYHC+lMRE2Ig1ZJdA94fvhYlMLvbzfi7mSvGB5NAvQFWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZML/0wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B38FC3277B;
	Thu,  4 Jul 2024 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720123057;
	bh=31fAkgTaScFRc2itOPGOEvyV6GsdONtUkGifgrsCSPo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jZML/0wnaVDRjxteO1OmAGJxU8D1C/88ALvOkQJwbtOOGN/Dfp6f2n+Kgix1MpDdl
	 OZbg34VbWOn+YuMY6T7uIG7W8fSVVJyuc9llMImM+8tIqBSfzOCcBb+0yqDCv6gZi/
	 00XblfZez9h8kKW0QHBe7r+sVvb1S6qiS70PfchyV26OlRFe8r7aU8OpcDmjANABxs
	 bXDM4+V0l09wz7u8mIdSL8qMnQAzVgbnMG93sutfi3j5dErIxll9vzvQWqZOErm4HM
	 XtFDcTDsK4/5sOJZyECXM/jpUPaDKCNIb9HtlVl+32/b8Qo+MXx/Gk/b6vHx5S6c7z
	 TGwufRHc5nMgA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steinar Gunderson <sesse@google.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1 0/2] Try to avoid some qsorts
Date: Thu,  4 Jul 2024 12:57:33 -0700
Message-ID: <172012303630.184013.1986960651509995819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240703172117.810918-1-irogers@google.com>
References: <20240703172117.810918-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Jul 2024 10:21:15 -0700, Ian Rogers wrote:

> Reference count checking doesn't work well with rbtree due to the need
> for counts on each child and parent edge. As such the reference count
> checking changes removed rbtree and replaced them with sorted
> arrays. There have been instances where sorting has been shown to be a
> regression:
> https://lore.kernel.org/lkml/20240521165109.708593-1-irogers@google.com/
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

