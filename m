Return-Path: <linux-kernel+bounces-204920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE98FF4FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350BC28C7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361961FD9;
	Thu,  6 Jun 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcxDMi/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BF61FCE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699946; cv=none; b=PBdyfVe8EDJx4i8Qj65DOQQAjWq/ovfByq9g1DU4DXr9Pc7F0QrTJ0HXFtBv1dZp0MGoUCVExDlmpuYjVXPdDE5hG16eY0CFzTDVJBRYUjCYc9VfrHFZ7rUeQeRw26hVMAnOh3NDhG0lqfOkd7QptKbe29EO1c/5O7xm/J4yC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699946; c=relaxed/simple;
	bh=cjxXDxzOXY9wo/DdhYXtPhf/ZYUdZrTm3zV+OIKl1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvThVNZCDGFE4YRFWQzfGmcuvnn7j1GQpxewv/K+B2MzL0dHjgLRGqrTPtkijo2D8Gc3IlgXakp44iQV/JyAvSH74+x2yk1jS8lLYnpeGn2SQCI9SPKcpD0oo3iofBcnnBClffpTuhqLQSdv4JQsw6GLTezko4otYyY++9NzrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcxDMi/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E573C2BD10;
	Thu,  6 Jun 2024 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717699946;
	bh=cjxXDxzOXY9wo/DdhYXtPhf/ZYUdZrTm3zV+OIKl1o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcxDMi/mm4rrxhsLm+uiiiyTw1Bdgo2qUMftXKNN+T4kMEkOa28Lf0c2WuEAAWjan
	 alcsj5oKfniV2gfHekNWhq9lYL2tLaVNiK43VAW1uYHg9gbJ+ZUY9Tx3AYJeg3uM8b
	 HoA/NKz9WbvZGi3PeopKO/vCh+JMk7FYJU/L3NVS8A9tRA/CXUJXTqRLuYD5WRqS/D
	 AUAhDXtDEA0zHTVgCQtADQyMbFE/MuMJoKMgvJlo06fD0MQFNQgLKxY/FH2om83GHu
	 yDBrC9YdNiQxH0MLUZvXIcrfGpWMrCqvB4JHvXCv4uOeYwR04qRg9bCzd2KtOCjgjt
	 vSqNrIANfKfnw==
Date: Thu, 6 Jun 2024 11:52:25 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Current state of the sysctl constification effort
Message-ID: <202406061143.27C12F44A3@keescook>
References: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
 <CGME20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4@eucas1p2.samsung.com>
 <202405310930.5E2728A@keescook>
 <20240605082625.6hwdc3haim66rr7v@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605082625.6hwdc3haim66rr7v@joelS2.panther.com>

On Wed, Jun 05, 2024 at 10:26:25AM +0200, Joel Granados wrote:
> On Fri, May 31, 2024 at 09:31:24AM -0700, Kees Cook wrote:
> > On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Wei?schuh wrote:
> > > Hi Joel, Hi Luis,
> > > 
> > > most of the sysctl handler preparation patches have been picked up by
> > > the subsystem maintainers and are available in -next.
> > > 
> > > Only two are missing:
> > > 
> > > * utsname: constify ctl_table arguments of utility function [0]
> > > * sysctl: constify ctl_table arguments of utility function [1]
> > > 
> > > Both of them are going through the sysctl tree anyways.
> > 
> > This is great! Is the target v6.11 or v6.10 for these?
> > 
> > -Kees
> > 
> > > With this done it should be possible to also queue up 
> > > sysctl: treewide: constify the ctl_table argument of handlers [2]
> > > for the bots to chew on in -next.
> @kees: Since you have probably done these before, I'll ask you the
> questions:
> 
> 1. The idea is to send Linus the treewide-constify patch on its own at
>    the end of the merge window for 6.11. Right?

Right. The best time is likely around Wed on the second week of the merge
window, assuming all dependencies have landed. And it could be sent
earlier if all the dependencies land sooner than that.

> 2. Is there a special way to send these treewide patches? Or is it just
>    a regular PR with an explanation on why it is being done?

I would do a regular PR with all the details for Linus to do the change
himself, but many times people send these as an explicit patch. For
example, include the full Coccinelle script, or the "sed" command
line, etc, and then detail any "by hand" changes that were needed on
top of that.

> 3. Can you please send (if there are any) me any examples where this has
>    been done in the past. Maybe some lore.kernel.org links?

I found this one that is a good example, though it's a PATCH not a GIT PULL:

https://lore.kernel.org/lkml/20221220134519.3dd1318b@gandalf.local.home/
became
https://git.kernel.org/linus/292a089d78d3e2f7944e60bb897c977785a321e3

-Kees

-- 
Kees Cook

