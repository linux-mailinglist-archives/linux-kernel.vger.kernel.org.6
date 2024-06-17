Return-Path: <linux-kernel+bounces-217222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DF690ACFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743F61C20C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02317194AD3;
	Mon, 17 Jun 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jo5QZVns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362FF192B6A;
	Mon, 17 Jun 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623877; cv=none; b=aVlIxUrWLogBwoSvsMZUyDUhdyTPKVQ02Eb0nFAauXTns2B6CtBd3rPkQ0700y5gooWIqTMLKTTM8DyLUNSNoYXV+zbgu/AlubigmmFhISTpkvLpek3ShuLAEvZmNgJKz9aXtDz79PoX9NBUeRGm7RU2ULI23OmAPWVOly29wiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623877; c=relaxed/simple;
	bh=BtqOhsPuK8Eoit8hom/sv0aX31Dh5yO626hm3M1ww14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyYNScQ8Bu5trKquibRDNE3P0qgtE6CdcFdmGkf5KUq7p9oSJ3GAvc0wz5ShEEikRBKTQYahCqDnGDFyOawxOXoGV9AfE7MB5wj9nK/kXAsSCNEOrX8aIZjClgyFEJ/b55fgTxu7Rk/TQoMjCqmF01visdCMUuNviulZB3iMcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jo5QZVns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C253C2BD10;
	Mon, 17 Jun 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718623876;
	bh=BtqOhsPuK8Eoit8hom/sv0aX31Dh5yO626hm3M1ww14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jo5QZVns6NEFN3XD0fJvjtSCkks2pWhTskDgv1EpyGnRXxREaRS490loCV2IvpXRO
	 DjlPHHh9/zIEO74s18j4NMrbEYrcyA7NrIHbFJ/VK/+JuFiEaOCOhVaIl4TpMYpTVR
	 F96uj7tDHK6XevholJmjFvNeh9cue17/DPqfOQ/8=
Date: Mon, 17 Jun 2024 13:31:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <2024061743-aversion-uncured-d770@gregkh>
References: <2024051756-CVE-2024-35840-99fa@gregkh>
 <ZmFtaijTs6mOpB5B@tiehlicka>
 <ZnAdxYLsEwDrF31j@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnAdxYLsEwDrF31j@tiehlicka>

On Mon, Jun 17, 2024 at 01:28:05PM +0200, Michal Hocko wrote:
> On Thu 06-06-24 10:03:59, Michal Hocko wrote:
> > Hi,
> > what is the actual security threat here? As far as I can see, the
> > problem that the commit requested here addresses seems to be rather
> > functional, rather than responding to an unexpected packet options with
> > a reset, we actually establish a connection with some garbage parameters
> > (likely unpredictable). Which is unfortunate but I do not see any
> > security implications.
> 
> Does the silence mean that there are no actual security implications
> here?

Sorry, no, I was traveling and am still trying to catch up with the
pending queue.  Should get to it later today or tomorrow, sorry for the
delay.

greg k-h

