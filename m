Return-Path: <linux-kernel+bounces-364527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D235499D5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A12B1F24517
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6881C68AA;
	Mon, 14 Oct 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC0o2btr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D01C3300;
	Mon, 14 Oct 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927799; cv=none; b=Q17IU28cJgZ0Hkcxr58DWvk6uZnStehpQDxg2xl9EVfwEv0/H6iMHfvL3P3akMUDg8zmWq2z8ryxdWnkp4e8pVm8CwtMHAsHQKT6M7pSmCKqsKfD5krpoysuJQtAgbnMNJf+w+JRTst4aiJ1p1AH7qq7Yxx6r1emSdIozF+WAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927799; c=relaxed/simple;
	bh=ol1AsYHgFG1jE/sTqLYzDIYO7XeC3+QanguChEXwTkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KQ/i2qYgaMlKHmw3xmFD67h4oNiVNGaTyn7UNYv6Xk7W69CQxXSvjTVJRbjTJvF2V4sW9LOzSHwroIhXwrrVvGG3OB6NqNjupjAmL1z8f0SDdF7PEV3inAiCVsNODpQc67ZyvqvyfCi7zx7FueGy+CTdNaGAyKZK9DOXbbziIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC0o2btr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19C9C4CECE;
	Mon, 14 Oct 2024 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728927798;
	bh=ol1AsYHgFG1jE/sTqLYzDIYO7XeC3+QanguChEXwTkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lC0o2btr2isEaZefXsP9igqUaN3TzEcPl0b2REKMUgSHMPMiQilrzUnAsocwc41p/
	 tOydDFoAWb0gxq3lqtgnwNhKA7n9ntd0E7jph/WEzNTn5+9Tjcc7fG1VFR2hOe1R6N
	 Nk/83QHpRmlhglLB+23pU6/lc87KFm0uYm6CKlU5iLnbCffK0JL5jMENp1bonMRFFp
	 8qmRdDOz4Xh+NDeFYqPEJAuKtyrel8IVsJC+DKjpbBCHgfJVFVViMSewSFI2rDnRLF
	 5raylHPKmjybwMvXV/TVbxyO8580ESEC7PgISFZqLI4sNTXaVvkPnm99S45CfqAAtd
	 CYC0SOa27evxw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
In-Reply-To: <20241013170732.71339-1-atrajeev@linux.vnet.ibm.com>
References: <20241013170732.71339-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/perf/tests: Remove duplicate evlist__delete in
 tests/tool_pmu.c
Message-Id: <172892779762.897882.10648635927487710641.b4-ty@kernel.org>
Date: Mon, 14 Oct 2024 10:43:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 13 Oct 2024 22:37:32 +0530, Athira Rajeev wrote:

> The testcase for tool_pmu failed in powerpc as below:
> 
>  ./perf test -v "Parsing without PMU name"
>   8: Tool PMU                                                        :
>   8.1: Parsing without PMU name                                      : FAILED!
> 
> This happens when parse_events results in either skip or fail
> of an event. Because the code invokes evlist__delete(evlist)
> and "goto out".
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


