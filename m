Return-Path: <linux-kernel+bounces-229787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031D91742A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C066DB229A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139717E911;
	Tue, 25 Jun 2024 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBnWoCkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A3149DF8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353977; cv=none; b=sRn8V5GXQXoJRkAEM4ln1IIbiBFd6z81Z1f+zjO1kJkkHlyi33udXv1TRg0T7FvzRdjjxBd6Ma7Y+6CTsMJANjyVc4DqXznECT2P+7tAnjSf5eoJq1jGJzKP1QuIXFgzE43HvXi5Ys0faRJqVLfF3DXZwaJneoxWPCxIIEO+eak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353977; c=relaxed/simple;
	bh=5BOOIQMYkjT0XpMDsYxYEv7GYC5Xe22N4qyGoD7Oj5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/ltaV5Fts51jFkR/jc2szEsM5nrEHwzoEXqsNeChTBT699w49XNesV2X5E91iC+rb+yCYHOiAdkuO8sZYk4HGN3xdwhnyNRaOYjO/LoIW8qzSq6iUIpPZZVPbtujUN6O6n07sus1SyQAgXADFldeITeZhVGIDTseJrSOxda/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBnWoCkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607D7C32781;
	Tue, 25 Jun 2024 22:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719353977;
	bh=5BOOIQMYkjT0XpMDsYxYEv7GYC5Xe22N4qyGoD7Oj5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBnWoCknFlkqFv+7PmDzoA1bZF0e6DPMCJLncsu6sU/nmvYzugIhCIJqQVptIKr6d
	 Xd7PUGdK6hiflBx+hittAcwdLr9Rrxr6fmx90/xiPukcdZX6WfWMlmdycVrRicT+QH
	 xk0SS7Pp2QcHulFMVQLVUjnJht+N+pgWQEpza6KDLWGMF4WHhq6riWL+sJU8h7j2cb
	 m0ZTo1VY5lh8LSwqAO1G8wHsJzOcymuWnKlQ5GunufhwhbxVyDM3MIAH2e/z/W7THc
	 1Gg5F2IKcNC28sxKqTM6lK1LA+jhkZry9G08J9hew2BWlyCoJzCME/72lsux3pHs16
	 LmlhenHy2qibA==
Date: Wed, 26 Jun 2024 00:19:33 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 20/51] posix-timers: Consolidate timer setup
Message-ID: <ZntCdRoIktPJ9bGE@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.745025149@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.745025149@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:30PM +0200, Thomas Gleixner a écrit :
> hrtimer based and CPU timers have their own way to install the new interval
> and to reset overrun and signal handling related data.
> 
> Create a helper function and do the same operation for all variants.
> 
> This also makes the handling of the interval consistent. It's only stored
> when the timer is actually armed, i.e. timer->it_value != 0. Before that it
> was stored unconditionally for posix CPU timers and conditionally for the
> other posix timers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

