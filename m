Return-Path: <linux-kernel+bounces-385690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F009B3A64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F011F22847
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2F18FC84;
	Mon, 28 Oct 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="DvWnB/PI"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C218F2DA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143587; cv=none; b=p9+9WqtIX9X9pLr1UYO1IWsj6b4dSFokOncZv4khTt8icXWiq20eCC7uWchfVhTNt3zyjZQQZb6A+lJFiSeBbZjg6UpjyQ9kCGfyQIOvllvP5lEBJa6LMdo34TCAVbQn8PbsevBWs/THTg6Cfuu7Ld2aDHsmK01Z5KA8+vU6hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143587; c=relaxed/simple;
	bh=24JPi+4dTbNwfNzqZKqh0kl7+T+6nwf8JVQHwTKseng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghFLaVPLGSGROdVXrPotaTSUcoq14bNqXjtnoW9KFFcYmqcBUTBe7Kq2grZJm9mY08IKjuVmdmWUavIYcW5Yqqqkv8zUjg8iqealeY+150g7BLgFfspORdHbJbSYPS8G257b3EnXuIWM5x9gu8KTVb6SAbkDM9kdwOmxruWcHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=DvWnB/PI; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 8C302177105; Mon, 28 Oct 2024 19:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730143584; bh=24JPi+4dTbNwfNzqZKqh0kl7+T+6nwf8JVQHwTKseng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvWnB/PIas4yu4E6Dx3g5N3pragWYLqIO8sEBnTNyYcnsTF7aCYeVbccKZw8PtDuW
	 K8s8kpQyWNX/haONG1rpw5vEtzb1lrRAuWfxfLkCtfoecO8NZPBKZra9jSeIpOUVgC
	 buWpy3sb40pnjkHakzycrKjRDt5ksZ7MfONbiqDK/7ocXTnaiFfZLJHy+Xx42+7N0j
	 I636kqeGMzjrp0n5n22ZSTXM9bjYz2fUvcrUzwrHDgWrESIpimIHSJGDRQOSSa7SJC
	 cz5zPN86bFIe3C6fc9+Ds5SZW/y14CF4X1EkTAFhKo/lNDXid0bPtt9V419GICU+UZ
	 4051AA/VicOCw==
Date: Mon, 28 Oct 2024 19:26:24 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix breakpoint enable to be silent if already
 enabled
Message-ID: <20241028192624.GA918552@lichtman.org>
References: <20241027204729.GA907155@lichtman.org>
 <CAD=FV=XP3WueSj9reLqsDm3-i3K0LMX7SJcf_Z=8E=3rD7E81g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XP3WueSj9reLqsDm3-i3K0LMX7SJcf_Z=8E=3rD7E81g@mail.gmail.com>

On Mon, Oct 28, 2024 at 11:38:00AM -0700, Doug Anderson wrote:
> 
> On Sun, Oct 27, 2024 at 1:47 PM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > Fix the breakpoint enable command (be) to a logic that is inline with the
> > breakpoint disable command (bd) in which if the breakpoint is already in
> > an enabled state, do not print the message of enabled again to the user.
> >
> 
> I don't ever use these commands (if I'm setting breakpoints them I'm
> using kgdb, not kdb), but this seems OK to me in general. I'm a little
> curious why you don't also make the "breakpoint clear" command
> consistent.

That's a good point I haven't looked at the bc logic,
will fix that as well and send a v2.

Thanks for the review,
Nir

> 
> -Doug

