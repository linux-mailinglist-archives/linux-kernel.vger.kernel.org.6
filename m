Return-Path: <linux-kernel+bounces-353939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69A9934CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D801F251E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16831DD548;
	Mon,  7 Oct 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdLN3V2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB91DB349
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321668; cv=none; b=Mk4k2JrafFXDU5ASFtUUSswKQne1gVK+Ak4bHCdOi+JWPqI9hKCqEootrPW8wXI0wNUm3ew7CeWZ4zN4ux3HdXFIf7x070+flVpLZ711BLQq0VZF60j/K0xfxk0Di8bjLkYJ0QJUIqZz3sIYx3rY3hHoDuNhc+N9DksgLOe+gHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321668; c=relaxed/simple;
	bh=pqd0Rydr/Wr3G6ezp6Bb3loqN4BCafbTZhgbdhXzfV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTJM70bTStXH2Ht4+vkBV+DdrBuaAQF+MQsRJcEPVg7AVUEkmrd9hhmFSErahBi0DxTiJeKWEODRJmXjJ2YxgUxDZu9j0/5Lia54KtjIYGXLp7nzw3R2WGxlRcWpgBZPurtm7xQUUNJEzP5XcH8PNv6zmuqXVpExxtLtGpVqlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdLN3V2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66713C4CEC6;
	Mon,  7 Oct 2024 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728321667;
	bh=pqd0Rydr/Wr3G6ezp6Bb3loqN4BCafbTZhgbdhXzfV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdLN3V2dUnlXS7bEVFFf6zPipKJAanMeSxS0ixr9PP9KVmzugd2JnLETkQIwAC8ze
	 m41rEXs1ImkZO56bfJO875EZx9B5oWT/HN8IaqglabDQQudVs9DlBEk4qtgrUAaBdd
	 vGuVzuKWD18aEwQalhvX10Ec5KELA4XxVxYn1PkmdhzK38e4pxVpjnMeF8yYc/+ihJ
	 yI1TA8mFuFQ4C9JyNwea/iGyQ9x6LFjD+3doUQ1swnyYZFXoW4vBtQJYocUJRtZ8ET
	 TDEXD4BE3LxA2odWJetOpyPmTEOn0ZctsifF4V+3xQCXm4zCOECU1GydzpXtxkBDMd
	 yHjp/qHQtZ1oQ==
Date: Mon, 7 Oct 2024 10:21:05 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: bp@alien8.de, david.kaplan@amd.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 1/2] x86: Provide assembly __bug_table helpers
Message-ID: <20241007172105.vj5e4yc3fsxz3b4u@treble>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.013379820@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007083844.013379820@infradead.org>

On Mon, Oct 07, 2024 at 10:32:11AM +0200, Peter Zijlstra wrote:
> +#define ASM_BUGTABLE_FLAGS(at, file, line, flags)			\
> +	.pushsection __bug_table, "aw" ;				\
> +	123:	ASM_BUG_REL(at) ;					\
> +	ASM_BUGTABLE_VERBOSE(file, line) ;				\
> +	.word	flags ;							\
> +	.org 123b + 6 + ASM_BUGTABLE_VERBOSE_SIZE ;			\
	    ^
should be a tab?

Nice cleanup!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

