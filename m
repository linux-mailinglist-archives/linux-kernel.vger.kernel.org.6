Return-Path: <linux-kernel+bounces-242216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8492851A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F85286BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8F146A8A;
	Fri,  5 Jul 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S45y54gZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F5146A77
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171707; cv=none; b=HJuKdoOmuWrZJAmXP5KcT+1c+h62Xtx+YL+bXoD6xDq5iaJvALT3ehqx3OelkkixQPuztYOxMVltc8Cx2FbH5YmTv0MoqqxbJm6aq7mNiIxb/JO09gtW7z8NyYnaKQBL4r1380xRzCKoagq9Bv0ROK1FkPwkKC+YJAf5eatOppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171707; c=relaxed/simple;
	bh=drKwy/2b2bnL5niZuw//owSp8zxwp5yVQ55aM6+15TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paeexNm5Dmu9n6z2o6I2dofYHneTILovp5x+1tjcFfq/5oCUb/MOQy3T+EWjB5cL9K00yHai521AF5/amcw0au3DyvLGQuurXSVG2sdDgaMcHO3Z6lJxvUzHOo8Pk5EG4VtWbWj1YoJhHc7tRC9C5C0jz5eKoSfz323MvRB5SIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S45y54gZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=drKwy/2b2bnL5niZuw//owSp8zxwp5yVQ55aM6+15TE=; b=S45y54gZ6rZXGyiEt/fMsVRBHE
	TgXaiNUUQNim+Xbbwu9uKoqJNwXejYyU2VlJ5MoeYHOCbXbPfFP9bVFoXmVaZNTbnIE9jmku0p4Nh
	ucGhbVbGMvvugCEH/OmwGcuail0bmxIjkuixuA7pTfe0Hzx+EHVkT2iuUNcR409Vc8ofR0ca/4Upy
	qzMavzpqjhgoWnHjyYDJiaUbEgGmW8WCmVXLkK75+hzwzI798gMw/Nn+kOumdYAPtctqC/5Hu1JlS
	Bk8TTnhKDPqwiCsObYJFEF0npV1bKOHdf5qVx/5DsRC8tOa53OszP+3rNHZhvzD2mEk6lJz+ERYWg
	9z4fg7KQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPfEf-0000000AJPk-3083;
	Fri, 05 Jul 2024 09:28:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA8713005AF; Fri,  5 Jul 2024 11:28:05 +0200 (CEST)
Date: Fri, 5 Jul 2024 11:28:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, dave.hansen@intel.com, xin@zytor.com,
	linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	nik.borisov@suse.com, houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
Message-ID: <20240705092805.GC11386@noisy.programming.kicks-ass.net>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>

On Wed, Jul 03, 2024 at 05:00:53PM +0100, Andrew Cooper wrote:

> /* Non-serialising WRMSR, when available.  Falls back to a serialising WRMSR. */
> static inline void wrmsrns(uint32_t msr, uint32_t lo, uint32_t hi)
> {
>     /*
>      * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant CS
>      * prefix to avoid a trailing NOP.
>      */
>     alternative_input(".byte 0x2e; wrmsr",
>                       ".byte 0x0f,0x01,0xc6", X86_FEATURE_WRMSRNS,
>                       "c" (msr), "a" (lo), "d" (hi));
> }

FWIW, I favour this variant.

