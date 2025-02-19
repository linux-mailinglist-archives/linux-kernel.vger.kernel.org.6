Return-Path: <linux-kernel+bounces-521444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB6A3BD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B719E3BA4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FFF1DFDA3;
	Wed, 19 Feb 2025 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m562y06k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C21DF730
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965659; cv=none; b=CSBv+uBnMoxwc6tVQajEyVM3YwNKqo5SRVNLfikk7Eua8bUZFE7E52fkH7GdP3duxNKZ9+pni1UxutSwK+MSVNN2e0hpNAbLiL+b41n+svmLm8WeTwE7ncwDifWW1q5MsmqLa33e4Fd5yhQPbBpcFVsK5cRE3zE+te1uD7nQyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965659; c=relaxed/simple;
	bh=zWx5hk1WAf8TrISGvDDN/GnDdSXaBsNABFLb3KrPPws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzyCFP4+jGPiiOFkJyl6BY/2tHfrtVe8lfQMaCjfQRZAqz+MAuB0XJxiAvoMmhKuDoKhOKvv/vLylj5c6MQnbDYL6WIS2o3bMC95qrB8RFfCBnTWdaJKrMQGTrWTNSnTUhF9NB7PXVf4DJvW8MDhwU5NA0oFFYbBZTPxeSij8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m562y06k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1394C4CED1;
	Wed, 19 Feb 2025 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965658;
	bh=zWx5hk1WAf8TrISGvDDN/GnDdSXaBsNABFLb3KrPPws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m562y06kMDqn1m5JG+R6kbWEqk0i8L/7+1X31mPKOtSkuguAkOdBIXQVRL0T105P6
	 2zrkOzLkG5usKum2Mmlti6jdIgdoAPUweEN4rig11ZkE2JKVNWj+n5VHbWXZibVG66
	 TrEQqEBaXMo1DADbCpXwN02VoFl/GDYQMptN61K2VWXlJHROioUj5YWoapYYIF4EYT
	 73xdeMgIT23WFLpU19fbd6Lj+5G5TeqHTGq08tNTwTowc4ZA18DTTZ7QzB+Sb8E4ah
	 pW+d7yLMc2BJnzQiGwWUgHVvoQYYmgGMWTuwKe5sH4VE12wNJi2SgYxItin0ucNwWX
	 GLmFESONMAq8g==
Date: Wed, 19 Feb 2025 12:47:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
Message-ID: <Z7XE0P6ZFHxtlYXw@gmail.com>
References: <20250123190747.745588-1-brgerst@gmail.com>
 <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > Thank you for doing this series - it all looks pretty good from my 
> > side and I've applied it experimentally to tip:x86/asm. I fixed up 
> > the trivial details other reviewers and me noticed.
> >
> > Note that the merge is tentative, it might still need a rebase if 
> > some fundamental problem comes up - but let's see how testing goes 
> > in -next.
> 
> I wonder if there would be any benefit if stack canary is put into 
> struct pcpu_hot?

It should definitely be one of the hottest data structures on x86, so 
moving it there makes sense even if it cannot be measured explicitly.

Thanks,

	Ingo

