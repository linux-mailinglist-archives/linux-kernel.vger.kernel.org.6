Return-Path: <linux-kernel+bounces-286745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2EE951E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCAD1C21B34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2A1B3F2C;
	Wed, 14 Aug 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pjsghska"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906813D3B8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649173; cv=none; b=nJ5cc7xSiEkWv85tZ9Yeve1fevR7O+GG9N6ongWsf1XNB8DT8kdREsNKSbfgjFaR8+4/3oTRG1G0Ov77howcTsgKoGkQCeXucvhpus54WPgMYrU21HFV4vmFoxWB+CaZBBa+V5Yioej/Zmb/wNvGh85PIc04wMDB5WSHCmm0uvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649173; c=relaxed/simple;
	bh=mgNqTMRuBWcGYsZOsbCHOnFgkqB590Cc7VbG59We20E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVlsh0McMb0G7oKMEac/ESA8rIVJ7Cls9IzY8lo8H1otqd9uXpu0JXwrkvzuI/Icuty6LruY7RSPClSQgpn4AummcvIt/WK1kHh90vYlQjjBwC52RZdst3BK6GCdDNPv7Xhe7m4n2WrjpOEIT0W+7b0GkrrfrG4E/A6BDjd/kM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pjsghska; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD8AC116B1;
	Wed, 14 Aug 2024 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723649173;
	bh=mgNqTMRuBWcGYsZOsbCHOnFgkqB590Cc7VbG59We20E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjsghska+lidHQXgloGe9sANTnyoBh2No42+Ngny3OcPBqyeABrEkZsyIRvcuVinH
	 /p/0AW1EVGpnhShQuR82iAJ9H6lt13Rb98TVhJNVZU3Lx3APdP0TnWSIpETRHDoZb0
	 zjPQGOpcL1VWY2KuqZFLLUSaupcbPaIX06eBFtno=
Date: Wed, 14 Aug 2024 17:26:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
Message-ID: <2024081445-grimacing-unfair-d31e@gregkh>
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>
 <2024081303-bakery-rewash-4c1a@gregkh>
 <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>
 <2024081417-husked-unfair-172c@gregkh>
 <48c5e8bb-2f65-41ee-b9ce-f31b2997b751@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48c5e8bb-2f65-41ee-b9ce-f31b2997b751@redhat.com>

On Wed, Aug 14, 2024 at 10:20:09AM -0500, Eric Sandeen wrote:
> On 8/13/24 11:50 PM, Greg Kroah-Hartman wrote:
> > On Tue, Aug 13, 2024 at 02:18:07PM -0500, Eric Sandeen wrote:
> >> On 8/13/24 4:54 AM, Greg Kroah-Hartman wrote:
> >>> On Sat, Aug 10, 2024 at 01:25:27PM -0600, Marc Aurèle La France wrote:
> >>>> After its conversion to the new mount API, debugfs displays "none" in
> >>>> /proc/mounts instead of the actual source.  Fix this by recognising its
> >>>> "source" mount option.
> >>>>
> >>>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> >>>> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> >>>> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
> >>>> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers
> >>>
> >>> As this came from a fs tree, I'll let the vfs maintainer take it if they
> >>> think it is ok as I know nothing about the fs_parse stuff at the moment,
> >>> sorry.
> >>
> >> Hm, I guess this is OK, though it seems a little unexpected for debugfs
> >> to have to parse the trivial internal "source" option.
> >>
> >> This actually worked OK until
> >>
> >> 0c07c273a5fe debugfs: continue to ignore unknown mount options
> >>
> >> but after that commit, debugfs claims to parse "source" successfully even
> >> though it has not. So really, it Fixes: that commit, not the original
> >> conversion.
> >>
> >> I'm not sure of a better approach offhand, but maybe a comment about why
> >> Opt_source exists in debugfs would help future readers?
> > 
> > Why is debugfs unique here?  Why does it need to do something that
> > nothing else needs to do (like sysfs or tracefs or anything else...)
> 
> It's kind of a long sad story.
> 
> Originally, debugfs took no mount options. And because it had no mount option
> handling, it had nowhere to reject anything, and so any/all random options
> were silently accepted and ignored.
> 
> Then mode/uid/gid mount options were added to it in 2012 with:
> 
> d6e486868cde debugfs: add mode, uid and gid options
> 
> and it continued to ignore unknown options:
> 
> +               /*
> +                * We might like to report bad mount options here;
> +                * but traditionally debugfs has ignored all mount options
> +                */
> 
> A decade+ later, I forward-ported dhowells' mount API conversion with
> 
> a20971c18752 vfs: Convert debugfs to use the new mount API
> 
> after some discussion and agreement that we really should be rejecting
> unknown options, and all seemed well until ...
> 
> https://lore.kernel.org/linux-kernel/20240527100618.np2wqiw5mz7as3vk@ninjato/T/
> 
> it was reported that busybox was (incorrectly) passing in "auto" and "noauto"
> from fstab during mount, and thus failing. So, 
> 
> 0c07c273a5fe debugfs: continue to ignore unknown mount options
> 
> got merged to re-allow/re-ignore all unknown options in the spirit of "don't
> break userspace". All unknown options were re-ignored including, as it turns
> out, "source" which then led to the current reported problem.
> 
> As for why it's different from tracefs, that's a good question. Tracefs was
> cut-n-pasted from debugfs, and had the "ignore unknown options" behavior from
> day one, which in retrospect was probably a mistake. And now its behavior
> does differ from debugfs, but nobody has reported the busybox problem against
> it, I guess. This is an inconsistency.
> 
> sysfs has no ->parse_param at all, so vfs_parse_fs_param() falls into the:
> 
>         /* If the filesystem doesn't take any arguments, give it the
>          * default handling of source.
>          */
>         ret = vfs_parse_fs_param_source(fc, param);
> 
> case which handles the internal "source" argument just fine.
> 

Thanks for the history work here, makes sense in a sad way :(

No objection from me for this change now.

greg k-h

