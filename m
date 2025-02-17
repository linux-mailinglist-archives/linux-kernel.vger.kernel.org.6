Return-Path: <linux-kernel+bounces-515072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EBBA35F73
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDD016960E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1E263F3D;
	Fri, 14 Feb 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxN4ic2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A915199D;
	Fri, 14 Feb 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541017; cv=none; b=qfhNTiC6SXldDXWeWN4mCd6wLwyswCyC49VoWnA6f3qWqZdQb44tDdjV6612yclC5/QTpQVr8fruXVP9tcPXVsjehJixcb/jPCqjnr2G7+5T/DDsusxlO3NQ7lpw5ZbRyjd4LwSoxkrrzW4UibTFvG3mYvsf5Fy0m7QjyHKKPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541017; c=relaxed/simple;
	bh=8k4FeVtMaF5OT8RAx5OhEYivQf7d9xES9DqEuOZaieM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkTA6cYss+BeWHRqUjaFG4Kg1DUUT2jfxn5dhXKI21r7KB+NUQZ9lbqatVfebU0HuOO4+Ikd2CiYqVs9PpqxK7ap+AAxHXJxkhOMnT9jAaX01fm3eezWg/LZ7jTyqADYbn9CMUNY3arRUX6TjyVzeKRj+fXykJXMaksJ0SIAF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxN4ic2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D336C4CED1;
	Fri, 14 Feb 2025 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739541016;
	bh=8k4FeVtMaF5OT8RAx5OhEYivQf7d9xES9DqEuOZaieM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=qxN4ic2KLb50Z6qjcqEP7Q02QpdZ4767PRy5XUevoMWEaNVfwPJz81S+kM82MGRTe
	 QehzvGLtIrqhS0tBXUK0oy8Dg+fILd03PcgCDQ6jb+bfGXS5KpP2bfb3E2vsF0uiyK
	 n+mupszqFcGsua3HeT9JeKfa+lhG2ZjV4Le5wavyVuQom+dHo0/WUhFV0lIRbw5FVj
	 14gxnbrmMVcmk87mT09pPS+eJEnJtatBBPCsaTwAT+kLZIyH4tvtAQ3Y4DicDeH39K
	 HYg3YKFEyDeIuFINWV892l0tqgYYzO80/lrStoqMNNuKdqMMpI9BAAnbH5JXHhqbfT
	 4iCyK8FLUFOyg==
Date: Fri, 14 Feb 2025 14:50:12 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>, Markus Elfring <Markus.Elfring@web.de>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/2] i2c: octeon: Add block-mode r/w
Message-ID: <xkko6oasll27ai5zjcwrvpuwpnq7ezhjyhbwblfbcnfqtzonap@nlslkpmdyddp>
References: <20250120023327.2347863-1-aryan.srivastava@alliedtelesis.co.nz>
 <seom4yspcjnmdxxwn6wuyiqdy2ywpna6nw4rn36tsqinlncbca@jdehzfnznlsg>
 <Z68Ig1ckLoULA08E@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z68Ig1ckLoULA08E@shikoro>

On Fri, Feb 14, 2025 at 10:10:27AM +0100, Wolfram Sang wrote:
> On Thu, Feb 13, 2025 at 11:19:19PM +0100, Andi Shyti wrote:
> > Hi Aryan,
> > 
> > > Aryan Srivastava (2):
> > >   i2c: octeon: refactor common i2c operations
> > >   i2c: octeon: Add block-mode i2c operations
> > 
> > merged to i2c/i2c-host.
> 
> Andy had comments to v10.

Actually I had this patch applied locally in my branch from
before my disappearance and pushed it last night.

I will check those comments and revert if necessary.

Andi

