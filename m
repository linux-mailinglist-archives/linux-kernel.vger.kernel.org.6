Return-Path: <linux-kernel+bounces-207273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FA19014E2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54E128175E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457431C68F;
	Sun,  9 Jun 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlFAMsSt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A8D26A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717920454; cv=none; b=EgRK1IRot8mfCQ22ly2ad0AyTQyKW2qjnjNtW/ZcIYqbB28R/MG8C/N62cTaymIIl1dJPYQKC0YliTY9ZOZgp9EWwljK55nolsPEddecrJmfR4xIWa/zB7Qbh3IAchhncNPtMmlPuJ4qoBwvk8Bia6/VEgI6dO7Pem3b3+CsTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717920454; c=relaxed/simple;
	bh=lOSN//yUQFmhLpm5Bd1YqSKVJsxaLRxaQ+D/NYYOnxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWc7kxznnsqlF3o+ZAx9j+TvWjePMKazyLjmct0j4tvdpG0Y0CZnwckZQDK54pW4WNZcmag0TGh2iPZzbJ3aI/JGbIa+at4v2Pb8ElI+Of34rTJGkw4m2vpgA17M7auRgzebqQ/424/2Dq8tO9F+13cpYKt7ZDVZQlazkGu1ecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlFAMsSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BF4C2BD10;
	Sun,  9 Jun 2024 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717920454;
	bh=lOSN//yUQFmhLpm5Bd1YqSKVJsxaLRxaQ+D/NYYOnxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlFAMsStExGoQBYvuSIo0iDEJHa4iKG/EfmfB9bdHbNXmA4tarjE3A1ad6uuHN8R1
	 LpsVMw9kUTmTq1i7v2Gw6FgQwOPuFCdwpQk2PHtISl+EAG3nPN0+ABKK2kZ5RQfK6u
	 XIZZdrPv4JeliIHs3ZBUFeV+eKvnpnmZGoAK4XvuWXcthpqEBE/cpWnJu6eycqeSov
	 XfFa+xkYLO/oPjT3NlL2A7fRPWVexwHB6Rb7Ao+47yYMZRfK3Vzg9i3ia0B69hiSab
	 y428LSwwqvuLxOxWlE1e+bVU4IFYj7RV2FvvqqjoHFpDrc9tk6vyfmXe2ezgXMr3W0
	 1ipplsLYj6eIw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sGDaP-000000006fV-05O9;
	Sun, 09 Jun 2024 10:07:33 +0200
Date: Sun, 9 Jun 2024 10:07:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.10-rc2 - massive performance regression
Message-ID: <ZmVixS7tG9-sf9l2@hovoldconsulting.com>
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
 <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
 <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
 <adbbd899aabf4e6898bbbb04f90b3ede@AcuMS.aculab.com>
 <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>

On Sat, Jun 08, 2024 at 03:00:43PM -0700, Linus Torvalds wrote:
> On Sat, 8 Jun 2024 at 14:36, David Laight <David.Laight@aculab.com> wrote:

> > I've done some tests.
> > I'm seeing a three-fold slow down on:
> > $ i=0; while [ $i -lt 1000000 ]; do i=$((i + 1)); done
> > which goes from 1 second to 3.
> >
> > I can run that with ftrace monitoring scheduler events (and a few
> > other things) and can't spot anywhere the process isn't running
> > for a significant time.
> 
> Sounds like cpu frequency. Almost certainly hw-specific. I went
> through that on my Threadripper in the 6.9 timeframe, but I'm not
> seeing any issues in this current release.
> 
> If you bisect it, we have somebody to blame and point fingers at...

This may possibly be related to the cpufreq/thermal regression I just
reported here:

	https://lore.kernel.org/lkml/ZmVfcEOxmjUHZTSX@hovoldconsulting.com/

which causes the big cores on the Lenovo ThinkPad X13s to be stuck at a
low frequency once they've been throttled.

Johan

