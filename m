Return-Path: <linux-kernel+bounces-349953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24898FDD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2EA281179
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B282137903;
	Fri,  4 Oct 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRSzS6R3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABF5336B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026929; cv=none; b=VedgkTAgVvC7K+vk6T6apXivAM15vJMeCLB5YbvEPlFGNmalA33yVU0B3lgNAiffOlG4SU0EU8LB3tPM2ERy0YOJwSd74XK8hppyymjVod8cDBtkZGqwYB/rwlgNtk6JKnpNl5uEN6hFDBCNpaIHH0A+TXPkzOlzR2Dgs3pbQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026929; c=relaxed/simple;
	bh=4OqY82lwHqjl1LDxwx4VLbyMtfyka+h8HMYR20e0srM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9eMrwYT4B9ia+4P5rawBv+0qHuh9uc4KlcrzR6PCmnOlgZ38eyarN2x24DZSYtFQlcrH/LYVOOz4am2b9dZk7pS9Wtb/EZiud67SbxKJRgxqd311jGUPiqPI+mYLiQBXqhOkoX9m6SnZj1ZtUEDdqVRgznBoJkdokmMUDgDbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRSzS6R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FCDC4CEC6;
	Fri,  4 Oct 2024 07:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728026929;
	bh=4OqY82lwHqjl1LDxwx4VLbyMtfyka+h8HMYR20e0srM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRSzS6R3QOt5NLFX9qNzhKlxbn1mlRIvslobZGBsUVgftT3KLhxd2OeLhukuvJzmO
	 BUWY+Bubo+hX3NDlbPue3h3IYSa0qBJH/Es5TA/9RB94vU+ERqyO90E7epcaUNYQfl
	 qk4DQ/ryoxLbjAVno4/d4EuGvVmsFXeazNzjYOX4l0wRBQ0drXrc4hE/s5MJ97/Nfl
	 aoO9nTroBm9XcqdlRfl3aa/FMYbHG5YllHKirZg+jadGb4P02w6CVQaENsbRcHHpfs
	 wsJ2qB9vi3ePJdPFpaqJEAd9q/5S3t6V9p8jGeSQA4x1u+jc4da4aABaLD1tPxvdTn
	 vxtKvwxmyYJnQ==
Date: Fri, 4 Oct 2024 00:28:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool: Detect non-relocated text references
Message-ID: <20241004072847.zihm6dw7y5m4e2lb@treble>
References: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>
 <CAMj1kXHt3GTVx-Ow0OZaP4WW7k=RVc+jgtC-4qOSZM3js4jo0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHt3GTVx-Ow0OZaP4WW7k=RVc+jgtC-4qOSZM3js4jo0g@mail.gmail.com>

On Fri, Oct 04, 2024 at 08:54:16AM +0200, Ard Biesheuvel wrote:
> On Fri, 4 Oct 2024 at 02:31, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > However there are some "lea xxx(%rip)" cases which don't use relocations
> > because they're referencing code in the same translation unit.
> 
> input section

"in the same translation unit and section" ?

> > However if we enable -fpie, the compiler would start generating them and
> > there would definitely be bugs in the IBT sealing.
> >
> 
> -fpie is guaranteed to break things, but even without it, Clang may
> issue RIP-relative LEA instructions (or LLD when it performs
> relaxations), so this is definitely worth addressing even if we don't
> enable -fpie.

I haven't seen this with Clang either.  Also, objtool runs before the
linker so LLD relaxations shouldn't matter.

-- 
Josh

