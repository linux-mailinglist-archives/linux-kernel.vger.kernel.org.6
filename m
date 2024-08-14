Return-Path: <linux-kernel+bounces-285868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FAD951397
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249E21C2361F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AFF524B4;
	Wed, 14 Aug 2024 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFBlUccX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DD365
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611055; cv=none; b=IPDOd+o9YDNHF6fGbQpww8vUVxpGfKNKe9KZ4+MTQGRLZzUN81OipEcZUwdpgi3Qk2uYtfXBhsZrlmXH5BJxz+AnP3ZP68e9eXZkLiLtR5X6uwsD7ofyimvzqcuhyTYuEIbEZU5eny2qFReKEVk796Dpfkmu+MsddcDp/vBFkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611055; c=relaxed/simple;
	bh=Cj1DRO9nTN6B3ML5hCX37DLUkAPX8gTV/xUzM6iMn94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQderC66OXxRa+cXIrDgXnbdYWKDP1JZxJpYJtEcHHfNS4AfZ/AbKdQHm/kvA9Eut/qo3D35eW5b+bsXyFY42JksDNwetADKuTkPnI9gLso8udSi7ZYIZTZcGQcpnHEeHSOWfUgIwAJ4DDnDSUsWJI5qVGi9jB+4xBuZwFg0Gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFBlUccX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36B8C32786;
	Wed, 14 Aug 2024 04:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723611054;
	bh=Cj1DRO9nTN6B3ML5hCX37DLUkAPX8gTV/xUzM6iMn94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFBlUccXlUoPoXP54PU+YMHpC4mXGxy24IsduGjJ+L3BoOXDTgdMWpmIxFlODLm9w
	 cvzyGXuQVgymEgyel0zPjsLh+ExWNehkqGTSouKedg6wx+HMLcxrqnlRDUtHSE8acu
	 NAnpS4/N9UFNnYwo5WrpOqGsIG2LgBIXm+lHi7O4=
Date: Wed, 14 Aug 2024 06:50:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
Message-ID: <2024081417-husked-unfair-172c@gregkh>
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>
 <2024081303-bakery-rewash-4c1a@gregkh>
 <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>

On Tue, Aug 13, 2024 at 02:18:07PM -0500, Eric Sandeen wrote:
> On 8/13/24 4:54 AM, Greg Kroah-Hartman wrote:
> > On Sat, Aug 10, 2024 at 01:25:27PM -0600, Marc Aurèle La France wrote:
> >> After its conversion to the new mount API, debugfs displays "none" in
> >> /proc/mounts instead of the actual source.  Fix this by recognising its
> >> "source" mount option.
> >>
> >> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> >> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> >> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
> >> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers
> > 
> > As this came from a fs tree, I'll let the vfs maintainer take it if they
> > think it is ok as I know nothing about the fs_parse stuff at the moment,
> > sorry.
> 
> Hm, I guess this is OK, though it seems a little unexpected for debugfs
> to have to parse the trivial internal "source" option.
> 
> This actually worked OK until
> 
> 0c07c273a5fe debugfs: continue to ignore unknown mount options
> 
> but after that commit, debugfs claims to parse "source" successfully even
> though it has not. So really, it Fixes: that commit, not the original
> conversion.
> 
> I'm not sure of a better approach offhand, but maybe a comment about why
> Opt_source exists in debugfs would help future readers?

Why is debugfs unique here?  Why does it need to do something that
nothing else needs to do (like sysfs or tracefs or anything else...)

thanks,

greg k-h

