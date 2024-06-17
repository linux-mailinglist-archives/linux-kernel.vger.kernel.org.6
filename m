Return-Path: <linux-kernel+bounces-216939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA890A8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A331C22BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB4A19048B;
	Mon, 17 Jun 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl3UmTex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62668EEC3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614488; cv=none; b=F0dXnkC1fIjJKRYkMbhNE79gX6zS7KOmuz/yMMgoQAGJzB0fjSz+XqjMRQzAxGzwaapmEP6GOs+OHFed5eTAkO8HP5w8m4ZXbQIp92LGQHVUVe5hUFxGfnPYcRdFRWkeR+3DMcpB6cVZKde2y/JUtRDOS6QbwkMrpstMvBEqPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614488; c=relaxed/simple;
	bh=G59EEspYnVA8GSD85elpa1Q/ascFxlAJaZm6pbVgcok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQlgIwAdgr/HN2MnMyp/PYFZzFczlzDjPWe3SuKMo9UBuj2VGhJ+2dd16uasGmzf1gm72eJHosp3IBQy9t40tSEPYtVabwvIxzCK3IzhFI81hkSSiI2Dl1MdAB8feko6qZeIe1siukLuz9AVx7nKQDW9zMJZsapOA4KeWQQwlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl3UmTex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62B6C2BD10;
	Mon, 17 Jun 2024 08:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718614487;
	bh=G59EEspYnVA8GSD85elpa1Q/ascFxlAJaZm6pbVgcok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kl3UmTexqPV0v1+J6y8BRNcSiJHVoWhOOnwgWGMP6BQ2prg4cGELRRbkl7VKwQp6/
	 TfBmZgtLCy3RUzc1AR2DalSARLvel/WwirewNxr+J/KswwZbnKL8+ozdlmG3/atSBp
	 dIBbihNk/5lS2UTvdZAorPtP2uKfpY9r0z5TWSd9YrdFtFdH6rWfFUeXMdNM3yVCCn
	 BUDSQKNSasci0pQ+Mc1sjj6+EstulFA6F2cx0+YP42tthU8KpNUSr3RqufcK2I80po
	 N1WjYNCoEMcsqD6OdK091BD1rqRT4Y1IiVYCmgDLOPdRTjNexlZEWZrb4QQpCDatKg
	 INxpFAw29cwew==
Date: Mon, 17 Jun 2024 09:54:44 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: Re: [PATCH 4/4] mfd: tqmx86: add I2C IRQ support
Message-ID: <20240617085444.GO3029315@google.com>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
 <18d0348f2f7b70329e44f7759bad7e6fe231dba0.1717499766.git.matthias.schiffer@ew.tq-group.com>
 <20240613154234.GJ2561462@google.com>
 <ZmwQkHvCdB3rPGEw@herburgerg-w2>
 <20240614094939.GG3029315@google.com>
 <4843378eed12ec48996c431db0659a0e8a99bb32.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4843378eed12ec48996c431db0659a0e8a99bb32.camel@ew.tq-group.com>

On Mon, 17 Jun 2024, Matthias Schiffer wrote:

> On Fri, 2024-06-14 at 10:49 +0100, Lee Jones wrote:
> > 
> > 
> > Note: Careful not to cut away too much context when replying.
> > 
> > On Fri, 14 Jun 2024, Gregor Herburger wrote:
> > 
> > > On Thu, Jun 13, 2024 at 04:42:34PM +0100, Lee Jones wrote:
> > > > Just one question; what is (7, 9, 12)?
> > > > 
> > > > And why is it the same as the GPIO one?  Copy/paste error?
> > > > 
> > > Those are the IRQ numbers of the PLD. Both blocks, GPIO and I2C, can be
> > > configured to use IRQ12, IRQ9 or IRQ7.
> > 
> > Might I suggest we make that super clear in the help?
> > 
> > (IRQ7, IRQ9 {and,or} IRQ12)
> 
> Well, 7, 9 and 12 are the values you would pass as the module parameter (and we don't want to change
> this, as it would be a breaking change). Maybe the following?
> 
> "GPIO IRQ number (possible values: 7, 9, 12)"

"possible parameters" makes this clear.

-- 
Lee Jones [李琼斯]

