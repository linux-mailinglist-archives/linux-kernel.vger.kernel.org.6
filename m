Return-Path: <linux-kernel+bounces-238255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5912C92477B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB610B24868
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0C1CD5DB;
	Tue,  2 Jul 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdzp6myD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12B1E4AB;
	Tue,  2 Jul 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945899; cv=none; b=D4IZR5amQkDb13+lrxlZC7hKvgLs5jiF/Yk3zVeFZJvxBS2cViVzsl56a7UHm+uMMPBlMiKNrzeA65FEazym99kKaXaoqgWtxvNgMQdBmBNCHsDWfNsHR6Cp6sySr/h4FdrCzr+jvihfJo8jJ8OGSycy9vZPBrhHZ7KPEpW//pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945899; c=relaxed/simple;
	bh=hUjCSF9rj4z68p35xIeexbqV/LPty6tCMT/hyzKQP5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfF2zODf7mnx50a29CpAK2fBb3RMIrNIdA/EEpmMYGBxgSFHHUVNsgqZt0NjufYAEW82ZT5br3Z8H2ukhYI0zNGlkfHJjTELX0vmNRyOJ2C63XBRU4CozOVLvwOtXE/99USsib8hdacTI2MbQJmcy7Z6bK82+JelTtQlRE8/7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdzp6myD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FE4C116B1;
	Tue,  2 Jul 2024 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945899;
	bh=hUjCSF9rj4z68p35xIeexbqV/LPty6tCMT/hyzKQP5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rdzp6myDpNGu8NovNGMuBRLwO1RbmTRbgIJeIz5U6wj1SRUU7l53kNcLbb4UyCwXJ
	 WLJoIWBShWbKb+R0MBqHE3bLRLG8oVM3IB5+C+1nCHlahg5rjIJEm5npT1ZPa8ICsb
	 Go4KRPju9+841e7BIsSU5CntDBGaXSse2eXyAM0hTkwZucACFr4dJzZTx9V3Wm6bs/
	 lU3VaDSJJaXOuXkOhlECkSpmEQn5dEk+/DGnq1cTWVWPpbH0elx6NuASjxRRCRSzUQ
	 knKkwL7VmI2vHpZV3Ob9QaY+JjE6445TNXUfmQuCdEIfeU8SeiFGHlhhL6ej7ievde
	 sq6LJhIoNL+vQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@arm.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	acme@redhat.com,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf sched replay: Fix -r/--repeat command line option for infinity
Date: Tue,  2 Jul 2024 11:44:57 -0700
Message-ID: <171994588115.2906516.12700202643238023170.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628071821.15264-1-vineethr@linux.ibm.com>
References: <20240628071821.15264-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 12:48:21 +0530, Madadi Vineeth Reddy wrote:

> Currently, the -r/--repeat option accepts values from 0 and complains
> for -1. The help section specifies:
> -r, --repeat <n>      repeat the workload replay N times (-1: infinite)
> 
> The -r -1 option raises an error because replay_repeat is defined as
> an unsigned int.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

