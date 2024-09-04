Return-Path: <linux-kernel+bounces-312754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53912969AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A03B28254A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BBE1D86FA;
	Tue,  3 Sep 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/cE0gvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1F21C193;
	Tue,  3 Sep 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360632; cv=none; b=S5H3WJB35CDujbfPHNLRcmEfIlqdE4HtIC8byp0a83veK3M94W9ckQTmTdfrZAjjWAGR7osMpBcpdo0x1WR+EOwu30pO8mEnvM09FiMnoq5tSaH5jEGV2Gcaw+alKpdq19Q2ZNI/TRUDcYbnKutNzl0L7zDdzJkx7GiyJ4B4jOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360632; c=relaxed/simple;
	bh=slEqdjod24jK5mcHpLb+UcyIr7qbTr1QgD6V2HP3D2Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJm79XACz7In8QqwT/187aGea4dAvXaIqTea78rTDDl3myZztyc+KvDMsek/NO/+CzeuieqQBakRIwbYUfmddqzIixRDsf7UP8tje+Y53OPby7YywsowEYo/rrHvSPXhE3KZ+0Ge2e3N/vRlJkz+44BovbcEAcAnNvPzGWQxusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/cE0gvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1172C4CEC4;
	Tue,  3 Sep 2024 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360632;
	bh=slEqdjod24jK5mcHpLb+UcyIr7qbTr1QgD6V2HP3D2Y=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=l/cE0gvC92dIMUMWf6pXFmzD4iml2/D1NIYK56DoPQ+b91ipxMZH7bTpWpTN/etL3
	 FtnQRt7YvDdwrwOIHYfOD5S9ROByeOpAcIMrLKmF1CdwPyPnU0Nt2WCYj3HIqnnsew
	 XtpofXuxtxF9aJKfGqzGp2J4VWZzfpqWTGNPqHi4=
Date: Tue, 3 Sep 2024 12:50:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: class: warn if a compatibility class is
 registered
Message-ID: <2024090307-islamic-charity-33d0@gregkh>
References: <4660a46b-9128-4407-8baa-f257245784a3@gmail.com>
 <7bc5fa50-59f6-4455-8f77-1c89f1e17d0b@gmail.com>
 <2024090242-smother-preview-a1d2@gregkh>
 <ZtbRLOUO48PzOKmC@shikoro>
 <ZtbRpMbX6g6vLUzO@shikoro>
 <2024090338-landfall-geek-58df@gregkh>
 <ZtboaI4b_aTfRWNk@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtboaI4b_aTfRWNk@shikoro>

On Tue, Sep 03, 2024 at 12:43:52PM +0200, Wolfram Sang wrote:
> 
> > Delete the code and see if anyone notices?  :)
> 
> "Never ever break userspace, at least until Greg says so" :D

"Never break userspace in a way that anyone notices" is the real rule we
have :)

> Seriously, Heiner initially sent a patch simply removing the code in
> question [1]. May I interpret your above statement as "Acked-by"?
> 
> [1] https://lore.kernel.org/r/80c4a898-5867-4162-ac85-bdf7c7c68746@gmail.com

Ack now sent there, thanks!

greg k-h

