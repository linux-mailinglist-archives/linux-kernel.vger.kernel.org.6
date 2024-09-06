Return-Path: <linux-kernel+bounces-318955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1853D96F5A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8541C220D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F51CEAB5;
	Fri,  6 Sep 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOTP8D+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F412F5A5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630149; cv=none; b=EN6qe+M65AVzm4EobYHRdEJWw3veaaQdNO2BYAadz44yMPKemqYlpUCbzDjOI8nE37fI5IrgTydP/oZO3tP22Qq8BPxYXkYGqbLyakSpRJH2QIBFP7xmNUihuXwSxRI4tb+w18wHZA+ndkh7DYfzGKhaMGgCAWmcJSWNiA9UKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630149; c=relaxed/simple;
	bh=TpYZ1d2TFd024dscFkqlBYrCtWf92nDHMAa+rQjV2eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt4RUeHyBZwNnDzHmuo+3ms3VlXwaHc/3X5D2YDrJjjJk8UE5qjgTZhIaqyqvbGaPIrL4GCqEIAGvhju6ypv31RPdsYXdXWnNgOOguEdj5fceYHbfsRX0TOnFp7b+/UqFDAd3omMgISRsyqALLWhY5CcwsvtjoeJUKoZDG6hLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOTP8D+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72AEC4CEC4;
	Fri,  6 Sep 2024 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725630149;
	bh=TpYZ1d2TFd024dscFkqlBYrCtWf92nDHMAa+rQjV2eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOTP8D+GnuRiOHrydnEifnWH85HCC4gFaZgYHmnFHzFqsPg29egawxr6BTw+cVrHr
	 zVaTLLVLzHCnMWiEJzHaQy0UbImQpFvDRoJFoqdT1fEekPzFWQGngEtR7CNnQuWr6n
	 po4W92Ez8FMsfB+uB2jKeiIkKhMxWTVWy2nLVTsMdla8OlZJkLJx/uq7uq4yJxNdFO
	 MZlOBnJ2qDi4OUGbMdmXjRmk9s/AvjITHODN8iuDC9PcUHJih41Tj4oOkeM1M4NXWz
	 n7Q3zcdDL7wNwpNH9DWjMDKfoZSvi8bH9DtkrWuMCJzmiizYwc2ow2d98RH9UVsbgw
	 lJ3WShTthQgYA==
Date: Fri, 6 Sep 2024 15:42:26 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/15] timers: Move *sleep*() and timeout functions into
 a separate file
Message-ID: <ZtsGwgatGpFRQerw@pavilion.home>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-4-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-4-e98760256370@linutronix.de>

Le Wed, Sep 04, 2024 at 03:04:54PM +0200, Anna-Maria Behnsen a écrit :
> All schedule_timeout() and *sleep*() related functions are interfaces on
> top of timer list timers and hrtimers to add a sleep to the code. As they
> are built on top of the timer list timers and hrtimers, the [hr]timer
> interfaces are already used except when queuing the timer in
> schedule_timeout(). But there exists the appropriate interface add_timer()
> which does the same job with an extra check for an already pending timer.
> 
> Split all those functions as they are into a separate file and use
> add_timer() instead of __mod_timer() in schedule_timeout().
> 
> While at it fix minor formatting issues and a multi line printk function
> call in schedule_timeout(). While at it also add not listed
> include/linux/delay.h to the MAINTAINTERS file.

I don't mind sometimes having several logical changes within a same
patch if that makes sense but the delay is MAINTAINERS is pretty off-topic
and should move to its own patch.

> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

For the rest:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

