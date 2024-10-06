Return-Path: <linux-kernel+bounces-352257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B598991C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 06:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12282823A3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575C156991;
	Sun,  6 Oct 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="V9qgUZ75"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BC1684A8
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728189028; cv=none; b=tvOTFT8582ZbC1/+drY88huTUVPJsnJqX0STzciGYcQrnkBXr1K+X+olkhGLiyvJNJau1+LPuRVKS+Ee8C3nWHaRfowo4v5ve5CAp9kK2dKbO8x1OOBmLOMKCXYoOr02v4e01pD5QuUM8gMxgHpdoDEFwwuaFSQvtZR/k2a+PRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728189028; c=relaxed/simple;
	bh=w+cjvCJScRPrJQ9LLWH8LncRUtVYNKQnNlQ/uVxrZX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8Z02NJCw7auUgNGtS+njlAPUc14CPXpJlJsy6m0WmczTs64Cuv4bDR2ckcWZjaqM6iC/MRwYYHUX4N1Ls4We3Dr2P32aa//wkiOB9JaN3RUakyl/CoJVY8FaiCjdgXFv0wS7B2/O3Bsosdgsg7prBsx4RaBs09+FnBA2uGP5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=V9qgUZ75; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4964U2FR007571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 6 Oct 2024 00:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728189005; bh=EimQsZNtpFVCD0KKn4pfVYxBiDS4U+LyAmBVt67Ek6I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=V9qgUZ7531MWe3DxJKlnSfj4fjtKJiCJJI4cYSY3yV1VitijSiAZc4/UDcOTRHaHf
	 56FbZU38mp5cfUbwXN+En+5Dz3DKET6rI7VELrg734MqjZSji2x50t3y9xb0hchuGl
	 bAxMvJoeO2yz4XbEfOuC2eKNkly22C63yRhwe9DX7Kxd4UkQPqkJQaMfU1syhhuo2y
	 T1VZGzITBCpXp893h54yqsjk9Vs1FwMRYOk484bTR3zHnTfULHnpZFnXsb91LFEysa
	 c0e+9ZWlExOjhkZxG5LTM3DXgvpiGy1heTdNFngoUyo3UYcgO9EDLlNUnrxYvei1AO
	 y8slDkp/KMpwQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CB31915C6668; Sun, 06 Oct 2024 00:30:02 -0400 (EDT)
Date: Sun, 6 Oct 2024 00:30:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <20241006043002.GE158527@mit.edu>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>

On Sat, Oct 05, 2024 at 08:54:32PM -0400, Kent Overstreet wrote:
> But I also have to remind you that I'm one of the few people who's
> actually been pushing for more and better automated testing (I now have
> infrastructure for the communty that anyone can use, just ask me for an
> account) - and that's been another solo effort because so few people are
> even interested, so the fact that this even came up grates on me. This
> is a problem with a technical solution, and instead we're all just
> arguing.

Um, hello?  All of the file system developers have our own automated
testing, and my system, {kvm,gce,android}-xfstests[1][[2] and Luis's
kdevops[3] are both availble for others to use.  We've done quite a
lot in terms of doumentations and making it easier for others to use.
(And that's not incluing the personal test runners used by folks like
Josef, Cristoph, Dave, and Darrick.)

[1] https://thunk.org/gce-xfstest
[2] https://github.com/tytso/xfstests-bld
[3] https://github.com/linux-kdevops/kdevops

That's why we're not particularly interested in yours --- my system
has been in active use since 2011, and it's been well-tuned for me and
others to use.  (For example, Leah has been using it for XFS stable
backports, and it's also used for testing Google's Data Center
kernels, and GCE's Cloud Optimized OS.)

You may believe that yours is better than anyone else's, but with
respect, I disagree, at least for my own workflow and use case.  And
if you look at the number of contributors in both Luis and my xfstests
runners[2][3], I suspect you'll find that we have far more
contributors in our git repo than your solo effort....

					- Ted

