Return-Path: <linux-kernel+bounces-340464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6509873C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653051F242C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102584A32;
	Thu, 26 Sep 2024 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXoxhOIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137C2914
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354669; cv=none; b=IQDQVp/+A73A4VjvoBukjQ946FWdL7wwpbhqJJRHPjNGgJpycjMY86TZgGZbCZaBnPfYh1ATVuhyLSUjHpXTYUrVqbZcNDhowpiOlGzXrJzfDnm/wQwSG5NmO55dWE1LpWb03tsGKrNv5/CIX3U1cLSVl18IBOWVHFBNSafhTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354669; c=relaxed/simple;
	bh=XUOYQfxT4FVGRoSDdSkDVIMf04nqENcBT7vtZcYIf4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8X9erBMlHl1CyGidS07/DPU5qNWwhUrCRngMF5JYhoVHeif0j6xMN/uBNMd1l1NoXjzI1J1uarrwLkMFjLGQhe2xKG4CZ4A6kTalmequYiGajD+D660FfYJedKzMyT0rtHjw2Xwv5L6kIOSCFC+S75t/lKhGrMs2BnEaGAm2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXoxhOIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA12C4CEC5;
	Thu, 26 Sep 2024 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727354668;
	bh=XUOYQfxT4FVGRoSDdSkDVIMf04nqENcBT7vtZcYIf4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXoxhOIlDNmd5ds7zNQ0W51CkGF6zHEI8gdbTm8DhczBemzojTGbp8Bf0+qr8OUsS
	 9nF0aKZ4b7q95cSE8mb0uYJSMaj5f3TK3v8yCp0dGxYLM6IUjX/Am7UYUm47aoc8aO
	 6ZLdBJTzZH3hUBu5Tau14XtSP6Lt+mQmVVXfSxt4=
Date: Thu, 26 Sep 2024 14:44:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Armin Wolf <W_Armin@gmx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: Error "ee1004 3-0050: probe with driver ee1004 failed with error
 -5" since 6.11
Message-ID: <2024092616-showing-fragrance-f70a@gregkh>
References: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>

On Thu, Sep 26, 2024 at 02:35:05PM +0200, Diederik de Haas wrote:
> Hi,
> 
> I updated an amd64 machine to (Debian's) 6.11 kernel and got this error:
> ``ee1004 3-0050: probe with driver ee1004 failed with error -5``
> 
> which I didn't get with 6.10.9.
> If needed I could do a git bisect, but maybe you can already directly
> tell with commit would've caused this?
> 
> If you need more info, please tell me where to get it as this is a
> (relatively) new system and I actually don't know where the eeprom is.

bisect would be great, thanks!

greg k-h

