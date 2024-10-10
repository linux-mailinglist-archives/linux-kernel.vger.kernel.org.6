Return-Path: <linux-kernel+bounces-358267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE1997C56
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3767D1C2195B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45519E830;
	Thu, 10 Oct 2024 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCojelHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB212AEEC;
	Thu, 10 Oct 2024 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728537661; cv=none; b=fe59smaavhG/DYaQBJSCoZE79Iw3xdfP6qXIMfxCbVDdNqghOFWsZqr9gNmApjTb1x9qIeLZlxj1P8WRhLofNRCGPwwJyuyYqJt9JNuF+vZR4sesfuUjqG5tOwdXdrwJ3G16oD4vEaB9A8ZfjQsXnz4PG3egyNtbpQUtglzoy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728537661; c=relaxed/simple;
	bh=vrO7HYSb3YsMGnZenmFVLQp/g/ZcQHhH6gaPlC4lsJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzM+DdCuzu0vbKSuFRWQpoik7tb6/dck7tg5ZlUbaG1fThwU7hQ1ab3FciLsj5N9sgFHqyP2YxO1Lew2KTmjgX813qa8/z4ox6XFOy1RXxlcEQH6Jypf+9fzx9SBr2+JKPgiw6SwI3wjzlN2PG8usuZdbOj1aky54+SFQPqxAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCojelHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B73C4CEC6;
	Thu, 10 Oct 2024 05:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728537660;
	bh=vrO7HYSb3YsMGnZenmFVLQp/g/ZcQHhH6gaPlC4lsJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCojelHida8+/NnLYtfDLs+OsX/FUqWdl/qTMIE54CcTz037SqSPO+K6DFbRNGjOI
	 x4XgZXJlmn/+F08z8EwLxZ5g3IZILwanI6GN4G7FhGwH6+DGBv3WPXjpytLASEF6I8
	 hukGMdkcAt7ZUewZOxGDrsDyIxzq1cK3x8s8L4iVSqRIPgxdRDUZZUIMbSphBAkt0E
	 JG47sBR+r2abOm2XwK797FrXnGdIYGPXAWHQ7pdo9qDKf4c4wpB/IxgkNFl9vck4mJ
	 CYSKgsioO/NG1ddDl1FP7MtJJ7hIQHfzmErBkrGcRupxLj6+CAsWROJerflPgNdhMp
	 AMq1T6xunNfcg==
Date: Wed, 9 Oct 2024 22:20:58 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-hardening@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH] objtool: Deal with relative jump tables correctly
Message-ID: <20241010052058.7ftl2huxuzb2fwk7@treble.attlocal.net>
References: <20241007224747.3973322-2-ardb+git@google.com>
 <20241008174201.b23zrrvqv26ihq4t@treble>
 <CAMj1kXHBccOwtLWuT9P1ozpVm7bTcfPfjfXTVzJnCzsCYm1RfQ@mail.gmail.com>
 <20241010051649.wtarneasz7x7anaj@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010051649.wtarneasz7x7anaj@treble.attlocal.net>

On Wed, Oct 09, 2024 at 10:16:52PM -0700, Josh Poimboeuf wrote:
> > And has there been any movement on compiler annotations?
> > If this is worth while, it is something I could look into: Kees and I
> > work very closely with both the GCC and the Clang folks, and have
> > contributed other features that are specific to the kernel.
> 
> I spoke with several people about this at GNU Cauldron last month and
> there is definitely interest in helping out.  If you and Kees also want
> to help out, that would be awesome.
> 
> Jan proposed an idea to apply a R_*_NONE relocation at the indirect
> branch instruction which references the jump table address.  And then
> emit a sized ELF symbol for each jump table entry.  That would be all we
> need.

While we're on the subject of objtool pain points, there's also the need
to have some kind of annotation for noreturn functions.  One suggestion
has been a GCC plugin (which could in theory also work for jump tables).

-- 
Josh

