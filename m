Return-Path: <linux-kernel+bounces-261726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A3193BB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4FC1C236D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C505417C8B;
	Thu, 25 Jul 2024 03:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="iMZCESSP"
Received: from sonic308-3.consmr.mail.bf2.yahoo.com (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCF33CA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721879908; cv=none; b=CHYsqv+4V0w6Kst7lvDqjAJ/SSGGcZgipXIV/KzhlZLQO5Tum5dYBiINwfNxiRXD5ORgQXICbNpwm4upjUUQsHbYKzvCFo5HQn3cf5UcCWZ+KuXno05w+IylNU6t4yK7kEB6gpc7K/Cmx57/JKAlxRt8tr7q3p1sDZ/j4ux/TXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721879908; c=relaxed/simple;
	bh=BO9hA3Vvr+j7n3Ikzwb9C2yLTBiSxeXjhjBnmXu2IqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3X9nz83AfYotny+8ZBp9LHoxpwL+5CFr1CamcOVbcjf8htuhyML8OGFpPAFrtsF2XLWutwvOe9UIdOZAW0LO/VwYXYgJEcRkUp3HAEl2mhULILIo4pDEPfFydIFG60nKd9+tXF4ZwFJ9VJR9VGL9CeLRd79V02/OhQbOk55SJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=iMZCESSP; arc=none smtp.client-ip=74.6.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1721879905; bh=I54NC2gr8RpipeZkyS3u7uONu6d0PXZfWYNdL083Ou4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iMZCESSPa3OSznVy/54mWMg9Y7559E+oAl1WdgwcFqQla1U3FCFZrZ6GKIuuuCowN/U8WVGSHQZzV+zF60Kgi3LRyK1r0CKTx1vH4QPj0OVBBP4HfEts7SJcRMShVXarkCV5tv2JXrctaoNco5zABkUwP0QDAks/+rbdok3Sjj8d5M4AFOb4uM7uqefzVbzeZSbn8DVjN6idectXexrmVBkUHkyKq6JupjT5JKXABwivQTg0zQRyI7UtbwDxFboMzHJUPntYU6dJ1xnT8D/Bh6SMIrlnhjjbgSLig/TthX17pLGkETi+CaljV9htBNTgt1uPpWMvk07TbzDaKjsuLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721879905; bh=EqMmiXwEJnnr88CUJv8RBELMWR132scSXiQq48Ti/eA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=O1YhDxHamp3NwSKmPcRaYK5YxoNsazQGvolZJphWdBIYfH1QFqCBZezKXNb5kfToPBgHf9qls4mJeqDS3x5t24O5AyN4OobAKluegtZDtEsBuGo9sHkqFQzGl5O3Khp3RHUca85FkIDzyDhbJoydUxRRgP9oslp+s5yzZ5TuwQoyTZ3NlsmryZGU7mt0wFmhJBiRlmhzvnFZHZxpMQ8I5F8vXEN/Zo2FdqaF92uWHUfEHxGfOCbzUOyq7c9zPEXqCKlkB1i7x1Y4EGYxhiigXShliXuRSklKGoGFl9cFqDcmFjRop7qzOsPAxDiiOypbyiajz5C0wpI+eMvTTCxwtA==
X-YMail-OSG: FKfcq20VM1mF00NnD.7La5obRXhSGC5W9Kzg5yplI87uQfZJ.zJ30VSJ3dgG_5i
 MMp3ieOtO0VFJdah_XhnTmB6nQcmeJBYi6J3AUbi6omh3BN33LoZOH7vy.GzAd8fPGpgWAfswT10
 V3GyqAb_jCyNh_ecTqesEHnfmQq7MsSyhtMxG5QVBhgH1D_3hu0DLOuZ2ENghE8Q_38MULKhCHs.
 KZ_cISgL5Vv7x3qqQWwMaa0.1eT7z_RNK1OTM4BaR5sQ2PBzvj.bOWRABKrU.B9cg4gVVPUPNEDr
 x8ATk2OUzKXf.wc_hlTQIvrYRnEpB_1a8Imnzd0O2mOc_zk8ywW1lLFXk_lJL5NDh5lDKJv_fqCD
 XLFytaYq_6DpwKWuvPdQ3qLKdjIB6KKNKeoVZWVY7XHeUWL5HOkRHdeS.T.D6ATtGnf12maP2VIp
 fqllcA.0PXo9_fEh5.zItOtSHsBNk8gCuVMyBd3l6tq9aKrYW3Qm.Wo1rKIbB1z5S.DybgiP.R8N
 EjTSDzCXhJfiCR5YQHUyeDHsK3p03Mf4bxbSWiUSdme9TqNJDi76L4x.P2CAT1l78MaKdwnsXv.m
 HX8FhR6ehdKLQj9_O5.n4VVHqAP4poef8cuxXBs5W1RQs87uQxbEhFDCoF_J6rgLQ11e6228Tasr
 P1hcZOrb7unvo5lW.Wcy5puknJL8ND8fPTR5NOfovFe0zM2dlheYkY59hvCjTMWSfdZAcqQSpW89
 1xBF9GOeviWt_cXhJZukBtCn2i34FpgEWKZ_cgJqIe6Q9bG6_GvLXAKl1w_l4G_32igNz80qRSrN
 i9lqTf_P3oooY_tCtda6zGEUG4XRK3DOoTKCg3oOOBc2McFLQ08AOHzemYFxX_ILfVeLCxk3kqV4
 6vGJKTqlpEUnrHFW272xLl42UfWFPj1Q2T_FYcmtstfUET8j.qo24Y6mdGz5XsSGvZPMaZ8mjxdm
 232AJMKLDC1pJn_CON6Oxu_7Gvw27uUhzwNHUC4N7RREmP4r.leQ_BE5ykY0x1dum9DgLSMi9uhi
 9Ow8V2htuiDWmnTL3d0NlacTWVqvc5jCp4o0j7bHzfjpOSlIjR3MXV7d5.E8DQfBeAhdN.cS9Fd3
 xHuMixgqG.Mo6udorvsWy8njyDczpG6B8HqDgy6SanItuY5jF_M6enoMyWS5UUJpnNbG_4c.y8HG
 DlFhwcB9AF5vg92eSpDMa0HO3VSR8smv6ET1LrEp0JpuY3R7tpss.vbt7WPIG8vwunLe6I9kC.QU
 n3odvauTvQAh9IoXk..Ok2LnZbPCVpVooZDISnRQ4PoEggaFQSbdlQLzjk25ek3JdTu09bwGfPBV
 YhjOnLwMmOZcOOm32Su54m9DM6tPLvMQtJihXV6fTUqSJ74GfktjwFS86ilyEeBYj5H8D8zbpkMz
 U_VbpKbCcnTragKnaCYYsa6pfqXWMO4Yk4GciLt8klq25ay6_Dpyb1WwXGH9HnHFk9lewopf4yqq
 bs8U1QJjAtcxdZj9nGzomY5q7UgfyZBxb3KoXbBYImh0fjFS7M6UO7f55qCkpX1hCyzVQL1fot.z
 0Ugmrx_U4EGBzOAAuiUELaPqsm62RQPO7WQmhrokQoAhSHzcH6WSJocYUKCdBY06s3QehaXs9yin
 EfHbDqYP6ezZdYpGfzl_IbxupU39dJDvLuMmVTr4v7.MfTpjaI4p.6jFAdpLutEhsjmwf8rszDul
 OJFWt1ndcM0nqmlTbTPx5v8VoHIqwaWxDKFxRyW9V.GHrSsfJ_5t.I33wknV5J39Cd83uF.J3wHF
 rGgsx.MCVv3wWO12sAH3YhGlFPm8qtGrRhwfX18piGwYLc6emLs9OHerGIlw0G5bt6pwmgod8xjf
 Sxi9M6OYhFqDWnvnE3d0OzM3oxE2WjEqYfjZuyHeGxz5n.i9giCfFEe3nrFCA6gsTcyJKsHFaqxo
 03udfrElf8hRTv7C0j.d9lWi0MQCZ6OelFAJRrChytfZbIoKYVOjmUwH6W.aeGOTJr7lkg2CBFml
 a_rN_G9GbXZT98yNGNDJUakTfcdejr4wmzjpXWCi52NeNT0hRjs0po19.zovSYv5y3jKiLx8yd_f
 NE4dd9rjVACwZg6eK50l5ERmDqxS33qJ6UNU6IYHeF2sUevrMN5VkHHDcAHZ8lPjSjgQsCagZNOc
 xIAumicUtl3adPxW4Zb25UvRrKfogIedDBDqCIE6VNJmK3a05l2NEazjbfwbRRlqxJMYqVa.M7xy
 sOQ74BBmWkDuGSMNXorWBKmH5VzvLRmtCwasALzdd3YWe2u3ebwU-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 92158dd9-cdcd-41ab-b457-8317e7a582cd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Thu, 25 Jul 2024 03:58:25 +0000
Received: by hermes--production-bf1-7bd4f49c5c-2s5sw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c895541a1e779a22732294df416cdb86;
          Thu, 25 Jul 2024 03:17:55 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: When /dev/console is a disconnected /dev/ttyS0,
 TCGETS on /dev/console results in EIO (Even if TIOCCONS is called on a PTY)
Date: Wed, 24 Jul 2024 23:17:54 -0400
Message-ID: <2169369.OBFZWjSADL@nerdopolis2>
In-Reply-To: <114770592.nniJfEyVGO@nerdopolis2>
References: <8411114.T7Z3S40VBb.ref@nerdopolis2>
 <2024071238-underarm-impulsive-dc1b@gregkh>
 <114770592.nniJfEyVGO@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thursday, July 18, 2024 7:52:15 AM EDT nerdopolis wrote:
> On Friday, July 12, 2024 8:59:58 AM EDT Greg KH wrote:
> > On Fri, Jul 12, 2024 at 08:52:15AM -0400, nerdopolis wrote:
> > > Hi
> > > 
> > > Background:--------------------------------------------------------------------
> > > This issue becomes evident on VT-less kernels. As when there is no /dev/tty0
> > > device, the console defaults to being /dev/ttyS0 instead. Although this can
> > > also be replicated if booting a standard kernel with 'console=ttyS0' and ensure
> > > nothing is plugged into /dev/ttyS0.
> > > 
> > > This issue prevents systemd from logging to the console.
> > > systemd when logging to /dev/console, long story short it calls isatty() on
> > > /dev/console, and when /dev/console is actually /dev/ttyS0, and nothing is
> > > connected to /dev/ttyS0, isatty() fails on /dev/console due to an input/output
> > > error, causing systemd to not log the console output, because it rejects
> > > /dev/console as not being a terminal.
> > > 
> > > 
> > > This is noticed on a VT-less system with Plymouth. Plymouth calls the TIOCCONS
> > > ioctl on a pty device it requests, to redirect console output, and in newer
> > > versions, it displays the console logs on its own without the assistance of a
> > > VT.
> > > 
> > > This part of it works, Plymouth is able to 'see' what gets written to
> > > /dev/console, log output from processes that write to /dev/console directly
> > > (for example 'echo hi > /dev/console") do appear in plymouth's
> > > /var/log/boot.log, it is just that systemd is not writing to /dev/console
> > > because isatty() fails to report /dev/console as a tty device.
> > > 
> > > The alternate fix in for systemds https://github.com/systemd/systemd/pull/33690[1]
> > > is believed to be that when TIOCCONS is called on a PTY, or another terminal
> > > device, that trying to call TCGETS on /dev/console should no longer result
> > > in an error.
> > > 
> > > 
> > > Replicating the issue:---------------------------------------------------------
> > > 
> > > This program replicates it:
> > > -------------------------------------------------------------------------------
> > > #include <stdio.h>
> > > #include <fcntl.h>
> > > #include <unistd.h>
> > > #include <errno.h>
> > > #include <string.h>
> > > 
> > > int main(void)
> > > {
> > >         int fd;
> > > 
> > >         if (getuid() != 0) {
> > >                 printf("Must be root\n");
> > >                 return 1;
> > >         }
> > > 
> > >         fd = open ("/dev/console", O_RDONLY);
> > >         if (!isatty(fd)) {
> > >                 printf("err on /dev/console: %s\n", strerror(errno));
> > >         }
> > >         return 0;
> > > }
> > > -------------------------------------------------------------------------------
> > > 
> > > When the kernel console is /dev/ttyS0 and /dev/ttySO has no device connected,
> > > it prints "err on /dev/console: Input/output error"
> > > 
> > > When I strace it, the relevant line is:
> > > ioctl(3</dev/console<char 5:1>>, TCGETS, 0x7f...) = -1 EIO (Input/output error)
> > 
> > Do you have a proposed kernel change for this that solves this for your
> > tests here?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Hi
> 
> Sorry if this is a duplicate, I accidentally had rich text sending turned on,
> and did not realize until too late. Anyway, to answer the question, unfortunately
> I have been unable to come up with a fix on my own 
> 
Would the fix be to make /sys/class/tty/console/active report the terminal
that TIOCCONS was called against? I am probably wrong there.
> Thanks
> 





