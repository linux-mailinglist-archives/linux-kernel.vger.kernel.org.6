Return-Path: <linux-kernel+bounces-400530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A529C0ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F12F1C20D90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99787217469;
	Thu,  7 Nov 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGnGKLzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E2217308;
	Thu,  7 Nov 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007574; cv=none; b=PyEO6wmrErmtFgJ+FuKbQSCJ4c2jcA0ZSuJAaNH48BnKsZFQpqM1LDPHBs2FVT1ip2V4PhySudiTytFL5oFbywxmN8oh6zPaykXFjXVAW+Mi8t1Hhjpr3UUXAlr7zjRIg+pF0bWn8Jcw6nyuDxaV+L/GJBWVqyPjLFuN+GE2hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007574; c=relaxed/simple;
	bh=MYe6dBsPj/SR7ngyX3M8wOp+3kZuXIAlaA1WzhknWLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rAW+8+D2rCU/0YSBVaqdytJeq6ruAta7S6otFPc+Ef4JoHy8oWEL6EGReVIK5Q6EMM/IcHd/SlSwMMms7vJk0xJLLnfvj+AyMW8Yibc+8YLtCroKec80znyeUz9+PcVrJtqZRwmgmeaoNzaByWpuwjMRp9R/TkBGtX8Gfy9jWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGnGKLzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC5BC4CED0;
	Thu,  7 Nov 2024 19:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731007573;
	bh=MYe6dBsPj/SR7ngyX3M8wOp+3kZuXIAlaA1WzhknWLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fGnGKLzp1fk8AP04Rhw6TsRJvClOMu6UgbI8h1uJGg+7QwLsWiq4iBSjh0Isq+gBD
	 J6ANmNx1MryJv6iMK1k3/oOk8Yp4uqpmblef5StZW7NqhL2YJ7UovF4jT3QxcXaxmi
	 4eHjaz9/da9C14fF6SizJofCMemjmwljpHns3RXl5b7rW6yshbQ0SXXxXGBkyBWb/l
	 KT0eRsWT7iSBuQcCeOWbGVv0SKmTL9Jz5CpApSFhF5N/XBE0+iVv+WBXOzn9w5uJp7
	 bly5tYCHq4UXTsrYFD78AQovNe3zwfS/QnM9BvZrXnKygdKmMwv36qN4l9enQHnAYX
	 EM3VnSrM04bDQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Haiyue Wang <haiyuewa@163.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20241106121254.2869-1-haiyuewa@163.com>
References: <20241106121254.2869-1-haiyuewa@163.com>
Subject: Re: [PATCH v2] perf tools: Add the empty-pmu-events build to
 .gitignore
Message-Id: <173100757321.1638101.3585799940980030605.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 11:26:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 06 Nov 2024 20:12:14 +0800, Haiyue Wang wrote:

> The commit 0fe881f10ceb ("perf jevents: Autogenerate empty-pmu-events.c")
> build will generate two files, add them to .gitignore:
> 
> 	tools/perf/pmu-events/empty-pmu-events.log
> 	tools/perf/pmu-events/test-empty-pmu-events.c
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


