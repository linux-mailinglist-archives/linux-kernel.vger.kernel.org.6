Return-Path: <linux-kernel+bounces-418912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9759D671B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28756161666
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646422EAE4;
	Sat, 23 Nov 2024 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq/VINW+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37DDA59
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732326850; cv=none; b=IprRC+HBKJK5niRP3YwVJgvrx83Pv6Sa5Ozq6cqOHKVKxsI51Ah8Nt6K9/rg4UZpSaX1I5jzp+5h1AnVUu91ZbHetAO5tZhqDBvwwKBLbcQSkxF86dFfPnUSebVDWuVjkcKq10u2mYBiqHQENbOWbN4k7vOb0q3yB6x8msttLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732326850; c=relaxed/simple;
	bh=o9GLyyaK3K0B0dB0GBtuXiKIPCM7+NovMES8eXTS69k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmnZxXSYqvxh/k+4ACImK7JwaXVPjGNY7HidHDx/fZgF9ufDmdAAoAlW950GDl8HS6CzCjPC/vmyze+Xp1PTmP29/3w2uWajRg3RLeHxaP6OpJk9AuPBXY/jgNDuu3bBVxMM5/3ye1erAA9Acw+n4TjXJ6ZL24xHxMloG8WyXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq/VINW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DA4C4CECE;
	Sat, 23 Nov 2024 01:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732326849;
	bh=o9GLyyaK3K0B0dB0GBtuXiKIPCM7+NovMES8eXTS69k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cq/VINW+Jv9vj5jKmptgXnXhs7Nz4UTF5AuujHbe7U3aKQ/b1XazHRh8oMju7w9sp
	 Iub+6XHy4ZqB/ikDM6nNrPnCXp7/UxQ5lKfS5K5Y02xR6pEIOUZsr+V+HwqnjI+cNS
	 Y4lA0Ge1g/LmqmBylkMj9kweyocxQsacDRtCqebhYFbq7iZnYrPhr9cWfcsQxMTNYd
	 Plg2FVnuvvjORz8yj8FCTmQZpB8ZOgpa+06ZNF2S3bNdd8P8zWt8a2Wn+nH/r4xgX2
	 J2XVCEHK6kH07/mUJIRawRjkeBDX13dRs8+RSH52AQKKPln8vO2K64I8gtVDq3VWp8
	 +eLkSAZvPyPVw==
Date: Fri, 22 Nov 2024 17:54:07 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] jump_label: Add annotations for validating noinstr
 usage
Message-ID: <20241123015407.vvdgcr4pd7hyx7c2@jpoimboe>
References: <cover.1732326588.git.jpoimboe@kernel.org>
 <f9d71d6c6f87b6ea88b904f328595b7663e6a6d2.1732326588.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9d71d6c6f87b6ea88b904f328595b7663e6a6d2.1732326588.git.jpoimboe@kernel.org>

On Fri, Nov 22, 2024 at 05:52:20PM -0800, Josh Poimboeuf wrote:
> Deferring a code patching IPI is unsafe if the patched code is in a
> noinstr region.  In that case the text poke code must trigger an
> immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
> CPU running in userspace.
> 
> Some noinstr static branches may really need to be patched at runtime,
> despite the resulting disruption.  Add DEFINE_STATIC_KEY_*_NOINSTR()
> variants for those.  They don't do anything special yet; that will come
> later.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Oops, $SUBJECT should probably be changed to something like:

jump_label: Add DEFINE_STATIC_KEY_*_NOINSTR()

-- 
Josh

