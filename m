Return-Path: <linux-kernel+bounces-170259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91F8BD437
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0B1C21AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A171586D3;
	Mon,  6 May 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE81h80X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E2158200;
	Mon,  6 May 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018207; cv=none; b=Mon7HHnVmYMWSoL5kj2v1UzzgPaHskNnhV8pmq+awwVqOBjGDYYsfVA4pG+wZIuYTgpGxD84TmuVMScFP+bP+IIApqRlr6YNZ+Ud9PxlX/URcv+atw3uQluKEM+5dmFNGwtoL8wTgrxP0PlM1JBUcWiXUjO0zpMPQ2g7vdj7ZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018207; c=relaxed/simple;
	bh=9mKo27o9TugRDuPDvKi8KCJG46tdt7CPVGlhj/hGQuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD3hvmB+MCGGMaIX34S/+RfvjjekycI9q4PYVr7WvRFZYrFXxI9iHSYMk6v1yRQXa+ka9yrB3r8d55j03aGdBlu9zqIu5OlTm2vDx901Zsuo7JDj/r6CqgVEPrnB7hzl/24uNicZbAwA3i1Sg1pTfukGcCW8wEB0PwhyS54XnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE81h80X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0081C116B1;
	Mon,  6 May 2024 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715018207;
	bh=9mKo27o9TugRDuPDvKi8KCJG46tdt7CPVGlhj/hGQuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RE81h80XEWfTzMbvbgl91Sng1WZHP83i9T4dTDNtFKECcRQVAByctgVnf9dlyDG9G
	 iB6QJbJCxXHbQFB3wREOI+EkoF42q6ku2IdHNNECmw8UcSQcqbSqma2HZn2MQ5dE3B
	 umxOeDnKbxxcJI99YJlswFwS3TdUqC4vvwH9zaJvfWa9SnTuApr6eNR8s/NXX/Bps7
	 k33yCSJDzU1LztFp7bCmMc2kf0tSOu9i5tNAAfdGWaxM+etlJ6GMiLJWgYSMBmcl3C
	 wrxIIwHw/udpDUPW1NvsVplpbEytKkxpTedLdS6a6dife67/slm+TdbFfmWKORBAH7
	 xhsY8XMbiYf1Q==
Date: Mon, 6 May 2024 10:56:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <20240506175645.GB1425562@thelio-3990X>
References: <20240502092443.6845-2-visitorckw@gmail.com>
 <202405030808.UsoMKFNP-lkp@intel.com>
 <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name>
 <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name>
 <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X>
 <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
 <CANiq72mYPV_rNFirr1q=hjjz2yDzw98qrwqY5c14G3odt+shcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mYPV_rNFirr1q=hjjz2yDzw98qrwqY5c14G3odt+shcA@mail.gmail.com>

On Sun, May 05, 2024 at 12:42:53PM +0200, Miguel Ojeda wrote:
> On Fri, May 3, 2024 at 11:56 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > + * The __used attribute guarantees that the attributed variable will be
> 
> We should probably mention functions as Nathan said (unless it does
> not work for some reason).

Yeah, it should work for functions. I think clarifying it will not work
for local variables would probably be good as well, since __used__ does
not work on those like I replied in my other email, but it is not that
big of a deal.

> > + * is actually used. It's a compiler implementation details either emit
> > + * the warning in that case or not.
> 
> Is it an implementation detail or rather that they took different
> alternatives/options on purpose (even if not documented)? If we think
> it is just a consequence of their implementation, perhaps we should
> mention that and what GCC/Clang do today in their latest version, in
> case it changes (so that we know whether we need to remove the macro,
> for instance).

Yeah it is entirely possible that this is not intentional but when
-Wunused-but-set-variable was introduced in Clang, I know there was a
lot of discussion around making the warning match GCC in certain ways as
well as breaking from GCC in others. I have not tried to dig up those
discussions to confirm though.

Cheers,
Nathan

