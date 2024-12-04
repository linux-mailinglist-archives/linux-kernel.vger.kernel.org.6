Return-Path: <linux-kernel+bounces-432094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC769E4503
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2A283917
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F11F03E0;
	Wed,  4 Dec 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="pAAJrZ1N"
Received: from sonic316-11.consmr.mail.bf2.yahoo.com (sonic316-11.consmr.mail.bf2.yahoo.com [74.6.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D341A8F82
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341691; cv=none; b=qazCp7EZztQra4aODJkbWQci9J9zM8E0w7z02qKFgnJSto5ssG1GJZKa2jkBzkP+akLF7PGV5I4GkidYcGWf79KN5SGwPQTv+yuHnmHa8LT5WykzFl+1DGj14HpebdK/Za4oz07/PgsEjVifdolTCnvyVcsLUC7Q96qTDPjKTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341691; c=relaxed/simple;
	bh=K0wcnXLcZ/RtqU+ivOA6ood/1YWbzuCuZIIkq/uqnlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+ybng0umTVH3llJ9VCjhdXt5X72qfpOIkYaurG6uztKnMtVGMzWhA1LqSou7cYWrXgkBlL1nT3Yr/5DBee06q4iaxPmpz74doSbp3ZC5aogXdV+E8iXQOEYWAShxxdm1t8fRxvdHWmiHyrfF94+r1uR4lfjJKP0hThfJmrFKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=pAAJrZ1N; arc=none smtp.client-ip=74.6.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1733341686; bh=mYbA5vc0s8RXvK4HptomEuPbET34RtMCpXkIm36hcVA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pAAJrZ1ND1pNRiAXMERonizcRRE15cSim2jOeErf9hm0GTsbchckuqROL2HPnSVOykPi+IvxVxHWlDLToHS2hIePlumnS0DegbcF77YUFUvUoCjIdlDtawvp87nvud42WVBraG50EJLBlDahV5FDTxXie7da3tahnLl6toimjs+wo11JqtgmSsxx493ypmsf1xOLqkhiC1lFrhDtl2nJiPpWURIXNiy+wpfLvQZDSjsbIwQF9UNTyD8YkIWHSt5kjDD2YZ7Arc44hPb37btKtZ/FDPgUwTFDb7b6ccryl9kNduxXbWgpC+LOEj4UmZw55TagxbAM9Bsq0rCj1SIRnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733341686; bh=WAxwGgAcWUWU9usn30GpiMfMxhhpNn2RFeXlwQvAkwB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oyloTeA1b+RUOHAwxTwPOvtGS08a7MFvp7MVEJtg7oQjSA3y0nF4gyllrPnOjOKm+b3FM1xsSfiDkDsPnANaSkthYfzeU/zmE7LVZuXohImCS6z37lu9dKAVW5AxULEbuJ7i0UKpCqMjhfV6YmdDDBIHxS3dJ/1xG7tDoueAo3PuHJjlZ1PYq0LQ+qXmQDc843Jl3/uIYYb/jEWO1JGtCod6U7k77dF3eWzC6WK51YiQvNiJ4sCXngm4+GyT8137JIeNLDZyU5RQbDw7a060b2jEZAG34IP8gefhl0fQmGbHiDoToBxt+ipuDsdUWeQxtmUonqU+LqN60jXwhHEePA==
X-YMail-OSG: fvlMYtAVM1lIxQN4lY5k_6afP1vDxCLoa6W4oReg2WvVjjiGK7SXqF.B1JeI7c5
 VSH49IfJG0SY5xThI4BZ_AEoz8BXraouHLe7VhWN2zl66nC3LlnnY6QG9yBtvzVUT5kyHGka9_FB
 wdXjvjunlopf1JeYiGWShXTssCZGgHD2czVbx8pvPz_M3j7Vf34HZf4eX2z7Vt7isSoJc_HKMEui
 DhcoIFYT938b_ftkoFryMgqdygAzhijIm4Xk3WoaytzXhRFEADJjP5s8v.T0ko_KjVXDLbhYV3K_
 t42tDqEorpDIF20hLind0y7lelJAAyyAdzhygplj2DHiuuGWc9Q2BfWmh4QKIgg0KQ06OGCnBzm9
 aC9Ld4qtTXOpb3IpZZgA7Vkgph4VdlriXN8r3ikCrs0L5NcclWaRiyzS6EuXjW3F_i_NAqgYD8b7
 tYM25eN60kz_hHVMkjUMcB5KCZzot7OAl4ijjcNv0iybzrU8s0J5urqAoSBZ30yF738oMQRPpGl1
 M96s5QlChYAxJDlEGjEHZ3EKhk1OHEIWhcM7xtB0EEVvdqEHCwRTw.R62oOtS8Qj7f_7msOHPD33
 dVI6t0IcUINH_W7FU0vgN1pJbz1XNBsWyzo0WuFEg92i4iy3wyXGIZEAyuSDISYQIl8VlUoGyOFO
 Ks1QeuWr1st3MDzDC0msHNLwlxMVIddW4GtecmpGzajFpTUT_YV6y0aCN6zPnY1Q5SFPaScFKKiQ
 zGn1mbGRIZXjyCQwQJwVG0E9BPU6muumM9yZIPr3yZS_oPBf4k.9RcOZ5Av_k0A67RBqCJZjeRGJ
 IfwFIAAYVKhVrTK37ugASZ4.Khpu7aXd7iduYxz5FqBRKYqP6..w.g1jROqXF5VXjwiwlajv05B4
 hTMNhkG2_MBDt3NBWmV.Esidf_knJ4t27zL_1crFmE1O.o.VJgBdhXa9smap7uVHDlFi.sz7oz..
 MRfvMsi824dWI4kR6oyfUB6QMiaGMi2gdeQOm8KWdHrRJ.IZ5_rU1PH5C4BJm4f.F.Plb.172OBt
 zGCyMkQ0uCtpdKP5rOZ8Aw2bmbTUT0GfAUkOwP.PY59bHSKAPjW5dnBfwkhdvEva.rEl2PTAqcXL
 p6rlwFWO1r2Rz8bdzNXL2KYnGkSqWYf_nr40tZ.pb0OTUBl9xnEjw9JddMj5NR26j7A8t9tHZvdo
 FCCP2zMuL.0IzINHB1M9_P7O9anxo0m1ZcChwlzeQET.toIxVL5iIDJQ5PrD6zZmQNu0p2aoUYEP
 lxaQx9MaRT0lqaalAFjWkARU2CSWt1VkUYi0uWX64SUquiiPjOC6kqF3yzWf7pqPWYJlCFiphBRJ
 BgJxhdKxtKwEmW_HPTiM9gG1aHwW2YIVe1ZsmqJfGaTZhbFa5qiP9PDSo7H8nhrGZrAQ2_NO5aCW
 5i0ULLIGebZoJPMlIDhRrLwlDn_wObePAOR.flEkIFNwwL00FmoroZnUCXZPAKspcAJcWhNuU_GS
 TodrV7vXS0NxpxtQxoFQboMniOzHiRBFR78mC66ZIAFV6q48E4pXfp8.B8v772nsyRssGZRuuJUM
 4AyoY9Jvm1oZJ8LZeKb12uB1Asz64a1d88piKLJgoCqneOQClOMRvOlw24n7s8Fpwk5X7q6tvfNz
 _3w9n_Dk1ooo0cQuAR_L0BRU485lyDhqCmLG14U9w7BZw_onUipKmQVU.qY66LkfX29Kj8YkbcJB
 DU0F4HQLnxxhE95nHvpUJQJK3MiaTR_g6EDbqBpwE2WyDesF.DtG10XgeXcdPfkwLaPmJTkaTL6B
 aDQxsmnzbdsW8x7Z1PTOl800bjM35mimGNtc3.VSguakCFcr6AQUXUMyvVQnGA8qkp1NZZyKwUyj
 l6Gc7w0RmrqjetzErm3FleWc4Bo6me_3JAMWIZpYQBzOrRTwrj6hmpDdkGs1.tRQqqSMaX3Mg0uo
 QbHnmBDyPc3pzld_8chi9e744prFrrSXVWngWrrXpYepxwUXrovF.0A9I9F2M8BILWO0V_NiOq4x
 qQ.BX7PjUmJOZG624JSJDa0I_BAgnGtZ9YteJM933bWITw9mWfmtNvtYeqTJxyhZU9ds2CEbl1mA
 BXfZg6ujjAfPEW6fa5wiIdS3bFKTLys6ytqChdc6XtqQ447ejNVKvcLl7sAWfZK7N1emHFJaEWSG
 6m7Ch01_aWjEUIzOyPFbDGx9RK30yTbWdVLK013g4BfIHr4fEPrC9py2q3.7S_jW3w.t0B8yaF0I
 poGTGrWHyZcHO2PGjt0sJBu5aSvW5rI23OCGMs_MViV4EZop2OXGNmLFRkFRfMqY-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: b98b651c-f1cd-48ec-860b-add473fb1d46
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 4 Dec 2024 19:48:06 +0000
Received: by hermes--production-bf1-66bb576cbb-q5j52 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5adf508ed2686e3ad514bc3ba5d7462d;
          Wed, 04 Dec 2024 19:37:56 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Wed, 04 Dec 2024 14:37:55 -0500
Message-ID: <6622246.K2JlShyGXD@nerdopolis2>
In-Reply-To: <2024120408-moneyless-stood-cda2@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <1791540.X513TT2pbd@nerdopolis2> <2024120408-moneyless-stood-cda2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > initialized by console_initcall() and selected as a possible console
> > > > device.
> > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > 
> > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > real name here, sorry.  I can't do anything with these (including
> > > reviewing them), until that happens.
> > > 
> > Oh, I thought that I didn't need a real name
> > 
> > I found a recent thread that seems like it suggests that I thought
> > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > Or do I need to wait for that change to the guideline be merged?
> 
> That change has been merged a long time ago, but as far as I can tell,
> this signed-off-by you used here does not meet this category.
> 
Oh, what would it take to meet that category? I've been using this nick to
contribute to other projects, and it matches my GitHub name, and FreeDesktop
GitLab name

Thanks
> thanks,
> 
> greg k-h
> 





