Return-Path: <linux-kernel+bounces-411829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA219D000F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544341F22A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266518D64B;
	Sat, 16 Nov 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="p3r4liZ+"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56768172A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731777790; cv=none; b=up0+0Pva7dVE7ahIemBnexGjv0zhjdqO8g2s7ASpEN3FxyzC6DzZaDqjcnStWYI20+5/0tppMiJBIOJo6flc+dmzMDxI07h6lK7TvkP8wh4eNBfWFzbzjbRnVsgHxpnHFmTcLgQjE9+BZuugezYtHvxO0vaTQcoBoDBMTCHszAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731777790; c=relaxed/simple;
	bh=sGxMLa58o9SfaZeXvP0XRxq+2G0GwanpEc5lnpm19Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ/DVephWEGgzRGM+S14c6Cb0T2hAURK1rqyflwJWLIkXnfXg91RfftlK/4ymJIzyCsBefvW1XMLkS/YTzdCQgjoZsaBXkYyAjDymiBgrrce9nmL+8ew9cyy1G5njpMdvDa3308h2JcvAaR/3xsY4agkjS0rs7FcRubfn5aDi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=p3r4liZ+; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id C64B3177104; Sat, 16 Nov 2024 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731777781; bh=sGxMLa58o9SfaZeXvP0XRxq+2G0GwanpEc5lnpm19Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3r4liZ+iqHoyJrBjJLd86c2PFIe7tUIrKeAPY6agywX2+wzLtr+zMwBRab2Ug28/
	 rlh/a3R8Ry79GQJVph1BcHi57X+PH8xNw2CWxzBjbv84/Vvovm4t0qTW7fPt1DmsIG
	 RXOKxDkpwi+eDj0fcFUmJhXf3rus6T6G5WQTvj+iWi0A1BU4lFAr24SfJtFF4gwBuq
	 tCfvxTo1C7YdNXRWczF2H7DT6x4cBcUlMX4CtOojU08WbQPMxgacSWSxLq2eZRRKIb
	 eF1qKELR+H96FIfT5JQWePsOHvBgXImNDF7ph7jvgOkiu6WQ+zRoy8LpRobqEeUo7K
	 Vjn4Au7ZfjrVQ==
Date: Sat, 16 Nov 2024 17:23:01 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
	kees@kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: make printable macro more concise
Message-ID: <20241116172301.GA222714@lichtman.org>
References: <20241116061258.GA216473@lichtman.org>
 <20241116072804.GA3387508@ZenIV>
 <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>

On Sat, Nov 16, 2024 at 08:49:39AM -0800, Linus Torvalds wrote:
> On Fri, 15 Nov 2024 at 23:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Now, whether that logics makes sense is a separate story;
> > that's before my time (1.3.60), so...
> 
[...]
> 
> Anyway, the fs/exec.c "printable()" code most definitely shouldn't use
> the ctype stuff. I'm not sure it should exist at all, and if it should
> exist it probably should be renamed. Because it has *nothing* to do
> with "isprint()".
> 
[...]
> 
> Anyway, a.out support is dead, so I think this code is pure historical
> leftovers and should be removed.
> 
>            Linus

Thanks for answering Al and Linus.
Al, continuing forward, to work on a new version of the patch removing the
support for dynamically loading binfmt kernel modules or you'll take it
from here?

Thanks,
Nir

