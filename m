Return-Path: <linux-kernel+bounces-238252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C5924775
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A9E1F26A81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3261CE0B9;
	Tue,  2 Jul 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVexMKDA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A031CB320;
	Tue,  2 Jul 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945864; cv=none; b=Kzsb5HkHj7Ki9ufWldb1FZd5Qld8/MRYUeH7LqXQXJjnWWCYdVuvGjBl/AJ6s9zAmuedzftOQaAIlgmsa1yBwauqOWkR0TSF8j8E2cPbfbq42xG/b493m+c3oKoEwybY5RGtIR/N1hFPCSB1HinYNEL4Hnx/2bAmZ8kKvdd2sVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945864; c=relaxed/simple;
	bh=Js2g1rc6r2mTXHRGQ6JfgAQN7WPziZPvIQHY4wG9sEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IONEMvd6NGzm3YMt6nWLo1QYPsVQeAsw819Y+TZP+tnWl6oFXtYu0g+k5ug9FIr6rUm8hSX/L/WGxdIQFZBk9j4m3xcNHRkXhtnUQTc4CMBQUMAenf0YwbEFisfEYA05IFxbhn7qH3VNuj5xEb6BxJpyEgi9lOIXtxVGYdzm3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVexMKDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5CEC4AF0C;
	Tue,  2 Jul 2024 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945864;
	bh=Js2g1rc6r2mTXHRGQ6JfgAQN7WPziZPvIQHY4wG9sEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVexMKDAS7oJZL7UxI7g9sC2355dlngjBG5SCllMEWMlnfdas6+OAomIafSlmCiby
	 8+KRSMyjSeoGXsYgJv1jJcx3CmjsEOybFjVAXooEBYBtpnedTodV7oI/ic7l4GwYz9
	 jmIEo5nJrZ1HDqswDzHpubSA+wjszYkGoAkyD0K4fVjD0AvV6MCMXabyrJKjhzkAQp
	 OrME2yqlTtTDCQPiKQNG64ewiUNlL3bpqvfKhRnQ6CrUvxMQeLyEmz0FCQLpoUx08p
	 2OlsPD6xGB5EQCmT+3aJxowvIfOiESqzvOZHFuBXxLmm/nlQIY22AtF6pFfiIu/Ftf
	 nt43gw2QjNXFQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v2 1/2] perf stat: Fix a segfault with --per-cluster --metric-only
Date: Tue,  2 Jul 2024 11:44:20 -0700
Message-ID: <171994580797.2905908.17252651084023923233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628000604.1296808-1-namhyung@kernel.org>
References: <20240628000604.1296808-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 17:06:03 -0700, Namhyung Kim wrote:

> The new --per-cluster option was added recently but it forgot to update
> the aggr_header fields which are used for --metric-only option.  And it
> resulted in a segfault due to NULL string in fputs().
> 
> 

Applied both to perf-tools-next, thanks!

Best regards,
Namhyung

