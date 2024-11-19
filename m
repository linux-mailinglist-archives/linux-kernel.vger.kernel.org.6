Return-Path: <linux-kernel+bounces-414751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9CF9D2CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFB228336F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9CA1D150D;
	Tue, 19 Nov 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ8iynQA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F01D12E5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038113; cv=none; b=DJqHV5FYx9+vY1nZlBDZGBrrCott7uA0nn8G+O5+ZfdZM8YRDxebAcFzOAdMtNLII/kGruk15cE/dI1F9ncNpY6feeaPby54yv4ZyWRg0PpXCr15jMiIXxPSJdUupNJ6ARgY8yUph7m2OTWgC1bWLq0Syixy2oPBf5mNdhytoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038113; c=relaxed/simple;
	bh=M9+AtSHNRnbjVAZQlkaGqAJdeKVY26XckfhM9AJn6co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXjGHUW11K/tvOOAo+PlgOBsJNl9JamlTWufSglOS+gMxQvMpB6uP6pZvQREW2VFOLKDyxZmLlvs68ttta/NgYRgsxIDFcapxneECzapeJEsmZ81EcXYH7Z3PXK+aFKJ6uFG1+W7pTt6tfaSOLoKaJZjdI/1bEI2dNYNyJKUaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ8iynQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF96C4CECF;
	Tue, 19 Nov 2024 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038113;
	bh=M9+AtSHNRnbjVAZQlkaGqAJdeKVY26XckfhM9AJn6co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJ8iynQAyqU+Q/0oYveULfxJRGs15OAT3MB+C0Sj52jC8zuLmn3W3bEkQppjrBv9T
	 rYUBfp07Spp7p5776jmw5XeTeRg8DnKz8V70R3H4L6TtkXYjkW1MzODiNWoT9xGbKx
	 S0Yc2R0yBNW5q4QATdcfbzo1l5VF/8d3u71h1TxYQJ3bIfMgj/rpluT/A0s4nPGTcv
	 K1twv0W3P495oMIk7AsuLJXblpTPYahmGhq3GZ2loECMp9SeK41CIzHNi1oxz7onoC
	 i2RskGTJQAbyuFKWGmc9nvlRWbQJ1bYzalDTmDtTzzNuhxH4Yet3R8mN1B5TIwGoJ9
	 tZGRDFStqjtWg==
Date: Tue, 19 Nov 2024 09:41:50 -0800
From: Kees Cook <kees@kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinbum Park <jinb.park7@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix mm/rodata_test
Message-ID: <202411190941.43503D3@keescook>
References: <cover.1732016064.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732016064.git.ptesarik@suse.com>

On Tue, Nov 19, 2024 at 12:37:37PM +0100, Petr Tesarik wrote:
> Make sure that the test actually reads the read-only memory location.
> Verify that the variable contains the expected value rather than any
> non-zero value.
> 
> Petr Tesarik (2):
>   mm/rodata_test: use READ_ONCE() to read const variable
>   mm/rodata_test: verify test data is unchanged, rather than non-zero
> 
>  mm/rodata_test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Nice fixes! Thanks for catching these.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

