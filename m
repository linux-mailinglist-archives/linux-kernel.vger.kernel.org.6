Return-Path: <linux-kernel+bounces-216114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CE1909B98
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 06:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565541F2194B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 04:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F1916C874;
	Sun, 16 Jun 2024 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFyPce7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4933C0;
	Sun, 16 Jun 2024 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718513122; cv=none; b=QaBO7n4DTC+r5grRyeaX3Dg2OSlbYKpa/NHU9GUwMtNgPrDRpuyxcOxrkgUQdGFU5+syIMdo/jFiPUungksqY+BaTUyKldoyUiykHiTNcIr4uv3B3JbYBcQpHy1k9Y1gCYnGdzMZVgr3yOKYLgFy6J3Cv3siRaLb+RrP65l3YTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718513122; c=relaxed/simple;
	bh=Tug9r/9sB2whRuKjWf9yY2mNcI6AE7+f0WvRKIKwpeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4pVnlkWPlGB4PP/CKUdMd0Do7rwMPLr4+m31ftKnkkC2inAgnT6ouMas1t11UOPLDKUU7YO/HlnNQ6D5Zm/h7PedtW31X1G2aUJjsMJ7/F7cJAlOqF0Y5p//QI5PCV4NhT4vbZUeUzT5lSoLcbuPePJ9EbWLl5EB8cED2EEUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFyPce7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEDDC2BBFC;
	Sun, 16 Jun 2024 04:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718513121;
	bh=Tug9r/9sB2whRuKjWf9yY2mNcI6AE7+f0WvRKIKwpeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFyPce7MspPPTwvupbaGao7V6B4YAE2AUTZM2Xe0FiJt07EAfhbSEpPztUOkB8V0r
	 UIFGJ4+dvqGYDc9o7wJ1dDas/JGUC0nrHjFXWbMPwzVlxmVkn24haxUcquc23fqYGE
	 K9GqDCJaNV3+kRjFHLmFKwakZ/CBc2m6Oj2UGLSsW17XFGb9AIpKf1G1EooZa9H222
	 434ddxWq2PsH6WjEI0AH6j0jq0+1/GeXngDncNTyHeCasI74b/sHo0nlgrIuOPK65y
	 XfA5J1xIVO7TSYE5Jqc/lKDbpwJrHAWF7VdNA+5apZw3a/wNXfXT6kJDw82oj/JR0s
	 Tg0ijdpUQI/Ig==
From: Namhyung Kim <namhyung@kernel.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] perf: sched map skips redundant lines with cpu filters
Date: Sat, 15 Jun 2024 21:45:16 -0700
Message-ID: <171851309820.4148858.2521638179521677418.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240614073517.94974-1-sieberf@amazon.com>
References: <20240614073517.94974-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 14 Jun 2024 09:35:17 +0200, Fernand Sieber wrote:

> perf sched map supports cpu filter.
> However, even with cpu filters active, any context switch currently
> corresponds to a separate line.
> As result, context switches on irrelevant cpus result to redundant lines,
> which makes the output particlularly difficult to read on wide
> architectures.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

