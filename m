Return-Path: <linux-kernel+bounces-219213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFC90CB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CAC289423
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5463C13792B;
	Tue, 18 Jun 2024 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBcsmtJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CC2139A2;
	Tue, 18 Jun 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712709; cv=none; b=U4YOgj5NdQjikdU1+dfMVsjL7C0DqEN0bLtxCQ/3QWJrzLZjpDi0dWiRlZxI/VAlWKLjPhlczVf6EvtviD5zSFMNPNoOd26ATegZBWFQKY5XiJ8bgOXVu50ZAE7LsWalfTKwlUM/uWc5EuWp7jvVJbdNtYsHHqFgy7stMKryii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712709; c=relaxed/simple;
	bh=VoZ4zhtJJmaHjupDiKoJdFBRS8zOfKvXjt5MM4X0JmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxvxy78Mn031sGLNuIFxhqhlWwcxp0A5G4LXwvdkWOVXuPuodgOb9s2wGPs5JFchpqZJTtJ/s9NdUgNoMl/eLAAQq23HcaDqAq+l+3IY2FruNqZhXVEyD5uDvCW6MAUS/H9u428scDDqGj0xMMetB89u3rl4lhhyFwwtKfZJOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBcsmtJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8991CC32786;
	Tue, 18 Jun 2024 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718712709;
	bh=VoZ4zhtJJmaHjupDiKoJdFBRS8zOfKvXjt5MM4X0JmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBcsmtJsZer/gER0g2gI3eZ3i6X+NX8nSmwWQko+AxtcmGWL/tUaCZMNQ83dXDTxm
	 El1xc+IIBTGw7fcVJsWaDsJFgbNknq8TRzqI7y94Y+2A3KTeAqeOlu77oBdRw3S7TA
	 j6Efbqi+vUsc+qGlP13SNU0jhrZK7onuaJiCUCfUAO4z1xA/vDqadpPU1EPrsI3J5U
	 RiqefzGbAGPpGCqHVc9twt3wRcwwtNRAQAUeRYCzlqS7nI1LD9Q8lLi1MD6Xee44dE
	 3Z6WNLHIMszKeEi7Z2ulT0rlw5f9YTXqMEV5WtHyRlXBG2xJ/cynTnVIUZnIr6gQ7t
	 hXbl/A4rXrdgg==
Date: Tue, 18 Jun 2024 14:11:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
Message-ID: <20240618-spotten-scheren-0c87d248419f@brauner>
References: <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner>
 <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
 <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
 <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com>
 <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
 <CAHk-=whtoqTSCcAvV-X-KPqoDWxS4vxmWpuKLB+Vv8=FtUd5vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whtoqTSCcAvV-X-KPqoDWxS4vxmWpuKLB+Vv8=FtUd5vA@mail.gmail.com>

On Thu, Jun 13, 2024 at 12:33:59PM GMT, Linus Torvalds wrote:
> On Thu, 13 Jun 2024 at 11:56, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I didn't *think* anything in the dentry struct should care about
> > debugging, but clearly that sequence number thing did.
> 
> Looking at the 32-bit build, it looks like out current 'struct dentry'
> is 136 bytes in size, not 128.
> 
> Looks like DNAME_INLINE_LEN should be reduced to 36 on 32-bit.
> 
> And moving d_lockref to after d_fsdata works there too.
> 
> Not that anybody really cares, but let's make sure it's actually
> properly done when this is changed. Christian?

So I verified that indeed on i386 with CONFIG_SMP we need 36 to get to
128 bytes and yes, moving d_lockref after d_fsdata works. So I've put
that patch on top. (Sorry, took a bit. I'm back tomorrow.)

