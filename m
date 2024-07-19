Return-Path: <linux-kernel+bounces-257597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C75937C71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0D41F21BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9752D1474BC;
	Fri, 19 Jul 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O0AuVtMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B5B657
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413664; cv=none; b=YKiajADmAtMX1JE+Njj81sN/AhIESQqHTZwymgAabSGgb7g4FCAVjuJ2dljTl36vfP4c96Bp9niCafheTcQDF0J16sy9GNkmp7pZa06Yuyf+KwLdMWoEy0SZFLn4ymp/paTLZjiJtCDT0ozTB4uhZuZj6bm9BP6lIAN3gMuyb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413664; c=relaxed/simple;
	bh=zGAtpP91Nkw7gmHk4JGFM7zxM1qdGbbR4mnMfCgPoeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRUe3p9Nhrba0sMyL+xnLHrf/fqg+tg3yQyuRKtzHrxiSIu/PdfU1tjykUPBVOqPFBYPJXSmXK2Q+B4VI7BmcuoQxIDh3nFFDIuTTB/E0tHTbXcIZCRe1FdkIUCRKfS3X3LgqbDvSzWcv4h4xgdStoC41L0IMkk/BHAEPerqtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=O0AuVtMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0390FC32782;
	Fri, 19 Jul 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O0AuVtMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1721413662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGAtpP91Nkw7gmHk4JGFM7zxM1qdGbbR4mnMfCgPoeo=;
	b=O0AuVtMcKoTzEQzzqe1qw+rtpKdAwFaaJ1+UOpsBDq/2ypLk0KqIEr9vXPs1OnYDszdM7k
	zugR40hyOvQQv4XGmRyamHpJb9QgCnLXBaN596vIhoIlJoGwbIrXz7HNAHJv3w0SSyghkB
	jBKEKMyyFxJlwAAotyEal1i2m7xjais=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8144b6fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jul 2024 18:27:41 +0000 (UTC)
Date: Fri, 19 Jul 2024 20:27:32 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] random number generator updates for 6.11-rc1
Message-ID: <ZpqwFK5hgU2gOA7y@zx2c4.com>
References: <20240714200050.902013-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240714200050.902013-1-Jason@zx2c4.com>

Hi Linus,

On Sun, Jul 14, 2024 at 10:00:50PM +0200, Jason A. Donenfeld wrote:
> The following changes since commit

Some fixes accumulated since I initially sent this. I assume you're
waiting for akpm's series before merging this, which would make sense.
But rather than send two pulls, I figured I'd just retract this one,
move the tag, and send you another (which I'll do immediately as a reply
to this email). I actually debated for a solid day on whether that was
best or if sending you another pull next week was best, and figured this
would result in the least churn, but if you prefer things to be done
differently in the future, it doesn't make a difference to me. (And
because of the "fetch changes up to ..." line, I can't just silently
move the tag, not that this would be a good thing anyway.)

Jason

