Return-Path: <linux-kernel+bounces-269400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2994326D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF0C1C21BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5CD1BBBD0;
	Wed, 31 Jul 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HxkqYB9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DA1B3F01;
	Wed, 31 Jul 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437365; cv=none; b=PtWCW//pzTGjLVaIyZ+JXQn3YJJQ0dIeRhMR7AaQrZfly5r9Fwz+bmdotUZ5mGZN0CWA7swzAyz3pxUS9R/TmsoKye4ErQok4q9pugSyNLRg793RKuGif1qqgQpP8JT8xGiwUrgtZf7g+TzfwbY7m20qg66aT5wM4ttjr4mYuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437365; c=relaxed/simple;
	bh=eSI8WWJTsp9W7RkpBq7+uNr3jRtaClfhOWnUqHj3t28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc2pkBYEaHNZJSoOqbJeFA/nahUD/ymVJLmmuBHfyEeeF31i7XW2Xm1RpUtZGmZi3DfU/k7vvPjtkyp/xVDSmvBg4wNkrK17Da2OrTFuOs61rxfYCaVudre+s1k3u5PJrjTPGOtfKtk4rwRFAz29Cxirf6/C8ExwVGCbsO9oyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HxkqYB9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD13C4AF09;
	Wed, 31 Jul 2024 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722437364;
	bh=eSI8WWJTsp9W7RkpBq7+uNr3jRtaClfhOWnUqHj3t28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HxkqYB9/9HqSzrsIb20lU9+HNs2xHJLc0qmpcU1YBcmG6l3JgSde2EzsUnrfwwasl
	 PlR1hmvC+KVQ2UmQovT9qjH+CX8ithRXcjgDLwHj2WxGZM5OwOwVQTY80n6EjeSthj
	 wuaFLI6pq8baMWqYLMMPOyBOSKgAN1GRQnQzSLrA=
Date: Wed, 31 Jul 2024 16:49:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-41067: btrfs: scrub: handle RST lookup error correctly
Message-ID: <2024073157-division-niece-46d5@gregkh>
References: <2024072907-CVE-2024-41067-bc18@gregkh>
 <20240729205503.GT17473@twin.jikos.cz>
 <2024073030-vagabond-imprudent-8ea2@gregkh>
 <20240731143441.GO17473@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143441.GO17473@suse.cz>

On Wed, Jul 31, 2024 at 04:34:42PM +0200, David Sterba wrote:
> On Tue, Jul 30, 2024 at 06:53:40AM +0200, Greg Kroah-Hartman wrote:
> > > > The Linux kernel CVE team has assigned CVE-2024-41067 to this issue.
> > > 
> > > Please drop the CVE. It's a fix for feature that's still in development
> > > and is not enabled on production kernels (requires CONFIG_BTRFS_DEBUG).
> > 
> > We do not know people's use case, and can not "gate" CVE ids based on
> > difference config options like this.
> 
> The use case are early adopters for a known unfinished feature where
> instabilty could happen and there are known problems like lockups.  It's
> behind the config option for that purpose so bugs are reported but don't
> have to be treated as security.

You can treat config options like this, yes, but we can't for listing of
vulnerabilities.

> > > There was even a recent on-disk format change (mkfs required), this is
> > > not really for environments where security matters. Thanks.
> > 
> > It's a fix for a vulnerability, so I think it should stay assigned.  If
> > your system does not enable that config option, then there is nothing to
> > worry about, right?
> 
> It's not a vulnerability unless you define that very extensively. My
> systems don't enable that, distro kernels don't enable that, so there's
> nothing to worry about. Conclusiion is not to assign a CVE, right.
> Otherwise it only increases paperwork.

We don't control random company's need/want for paperwork, sorry.  We
are tasked with reporting all fixed vulnerabilities, and as always, we
do not know your use case (nor do we want to.)  So, should be an easy
"this does not pertain to us" check box to tick somewhere if what you
say above is true for your systems.

thanks,

greg k-h

