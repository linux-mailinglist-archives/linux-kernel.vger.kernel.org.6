Return-Path: <linux-kernel+bounces-341998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F030D98896A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAF81C22953
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5C1C1745;
	Fri, 27 Sep 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OngA4t2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5AC3218B;
	Fri, 27 Sep 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456426; cv=none; b=d+C/nlcXjjO6zgRxTYEace87Zs6VfYjj6OWUp7ixxxZrUcd0qxwGObOQOP6q2PADbetkDpbH2SFP+NYk9Z1RB+OPLMH5hzNsQgjjwsFZrVtUWAIIpguiYaNI/SKrFWByosqvYBotiMVnrjw3mX+E50e3G3KCqmgSiaorFfhyOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456426; c=relaxed/simple;
	bh=dwUnyxfa5kYaO7PQJiK4BIUR+CDbP0ZO5jGWXvbbblY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfTEwCehuX4WsDVnw24cDSyLw24Z8B20UIMKIm1hZxUCDqsuBNb1/5i7sxNZd3/tWJtOv9myBXUdo1e3B5ZiYrP51efnUpF6cc/qyR9M6BkBFjpl1Rie/4BpfSWveMeAGvCLK9/AIXRR0MV4BnLQrE6008Hr5FGIhDYFXzBZsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OngA4t2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD28C4CEC4;
	Fri, 27 Sep 2024 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727456425;
	bh=dwUnyxfa5kYaO7PQJiK4BIUR+CDbP0ZO5jGWXvbbblY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OngA4t2CmVQyTgcxA3F6+RjRySu914yPHh/aN5WShCgczH1rvib0h3YePAfdJZQ0Z
	 m+MwDpRk2UkRMu7QFrpVC7Zt1ahQWcmVSXTUAjWtYKtRIUhV3nR/4H+TJf6VwPpORV
	 oB7/LSslwA1NtgiQdmT2+BrBXyClPxdZsxx91QFRbgGYq5CF/rKYBA0oWN3Vs5kyvg
	 XYwwNxS18NGda8u7ndn8VvNj8yB5Ukdx+eNjn2k/kIlCwdSuSEdaLXpblT5NPuFKnL
	 1BjW3jX8OJcgjjLCGvstT3zrfgiMibG2ZTCtD0WEZmRQoR5hpFDxjr20vo/j/af43J
	 2nMuWYcvub9xQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Explicitly specify install-html dependencies
Date: Fri, 27 Sep 2024 10:00:22 -0700
Message-ID: <172745641224.248656.17860675088257717109.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240915-perf-v1-1-cbfd9cd1d482@daynix.com>
References: <20240915-perf-v1-1-cbfd9cd1d482@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 15 Sep 2024 10:34:29 +0900, Akihiko Odaki wrote:

> install_doc of tools/lib/perf/Makefile invokes install-man,
> install-html, and install-examples of
> tools/lib/perf/Documentation/Makefile at once. This invocation succeeds
> when make runs in serial but can fail when make runs in parallel because
> while install-man of tools/lib/perf/Documentation/Makefile depends on
> all, install-html depends on nothing and can run ahead of all.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

