Return-Path: <linux-kernel+bounces-256362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD0934CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8A51C22398
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AA13B593;
	Thu, 18 Jul 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="aZbVzB8P"
Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BD12C473
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304763; cv=none; b=hjpoNudJY3OvBoz+vme13MwsP9Lm8ECa3JpZySb+WheNHiUg5bM8mq4HyLIn6cAAmWixaugH3+OF/fIIJZOz/u0q0IlVSs2CdKPvUE3RP7MSUQ7VhF1ZHxltMY/26v5xhdBNowmKXPxZtjwd60tkxWjEJjx6nquoToUZZaux2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304763; c=relaxed/simple;
	bh=UepMa331D+cyY94JmLhcAFRPs/Td7L3bh/kXcYJTGY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEz1SmrLhntLEZA4N3DoceTKIjC/AKlFWsj7Jd6xzFWxdqkhszj/M/MCs7IHUXZMk+gLCB7X3jA4RhRerP/U62AP3K0QonC/UH2cdN+WuulYIq2gt04ByXeK80YCAOn88OPTNGKregbCem6+jZJfu57AJUymtjzY4kr3+Vc1sVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=aZbVzB8P; arc=none smtp.client-ip=74.6.131.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1721304754; bh=IEA/ym12MuqvUDny7bhJK84e5eeW75NUM/WX29B50T4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aZbVzB8PU4b1VYSH0TCiDEm5f9uphgYalHQrdeCpqFXVAFf367yKJMed4uKL52HgxAglWXrBWJGBQo58AI+P0Gdr2HPD9ODHgjyRureVFArHsEVcUduBI/onsaUbeBq7NYorZPkjdR3K75MLUSqofaMLlmiF0lSaZ+f5Co7WhetPlxnJi+0urXKwsxebqe8DLYniVl8mL9sACDMAAhxdmZvgFTFiv5RpthXfWWTNB94fiN4VKSbwCoOlq5W+4+E7SO+jmTKF0h43iCeuUPXAwcETFAKtsaUlfCvl+jX8WuijJDWlVMJ/iISeSeVE4p0zTCjXNY8AVzCUDWQpNB0Xtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721304754; bh=7gLwxSktrZbBOcacbXWLM+oCt5FkPbsTG6tNRq81e1p=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LCrrkNI2W7ogTDRNEnn+BR3QQrKWVAtpMJ68yQlHiVyXbKgzNC6NxUslVp3WwfIxXVNJWqQ2q4KlOTChecKzcxuZunrMtYVxcO3X6PUghB6hTZfMlGHa9vFII3/JzzjthvcddAL8VauHJuWckVDq4+pR5Mre+uFtdtOCTLyR/TFK6S/JRv/ctmL+VECiHTP2vZyohBv3xkZPDLJtiM4ODj53dveY2YT90NDFxVWMlENzcFvCi+sTEGNYoOXNewfPc7lHQl6fuON+/pd9aNc4dGdD5v52cOggkNyKT0u6+PSVR1Gq2RzqkkHzmHnJxfxGF/ZouyRTMoU4/7fjtGFnKA==
X-YMail-OSG: D5mKTscVM1l5dWYKdlCkscYU0D9qCYTW2jDnNFDx47sqLVq4baNM3zYEoxMRzds
 WpR0W.8jciySolrzqcxE1WNXnv8_zchLp4tKN3BNW53vp7_FqeJZ6qa_XDLodnlCIIbBhj9iUJwg
 fEislkpmYsEYQrdbNCY_UspSF4FXjTCI44ADZvqwpmkipf064EHpBW2nfGM_f060e3QAWIJgs4a8
 11EDvyqe9bUhWS7DnfmzAYKw9c27AwSLI8gFuFoGVtjXZAVkCvL25q.7Y8v6bYuT.lLFzmYA.lL0
 3OgK2Zmqi.5pwf3WEY4iFLIJJ5gfcZcAibnUHt1vsgh7D0tuBV4gKkAn9KONFlOJycxzIt7iIFAH
 xX4Ji29ISpt5NyqrTchX2yPj95CTuY7_LFmZzghgZeGhWmr7mVdRqubllC0gzq1VkvBSEgORGkSa
 RpE0QFHGn9pnyrJdZy.jU8vymaqlwenIUPESTfxCN_6JFFTlQV_S_Pn2l8QnuY2c1YTciFU5NHe9
 6ovFu3GigpvpyueMDe5r5I7ZTEIfBKxPseAg7HGHcv5zwFCTfFaj1Dm1oEUFXhKD00GIZf_0zdLD
 pn_vFXwVFutb_ePAOFKD9a6Mv4A1w0406hb7VHbooH92asGTNGtyfhAy5H1InS_sZvD96ioz4qvp
 DmeRVZ7FviqfPJfzx0V.qIrKYQn5AZiVoDbFp9Ogp3jDGEDr4Ahqygo7aCNcaxxmyvIXtrqQ9uxC
 5UvyEOyHS7Rt7WUXKqUY5bdncyWjm6bVtzKl3IoR0_GnScKhtQ38xBBs12VRh5_Av5AWkJzfcjKC
 3OpMdRhu9ShBYsVjNIX9QtycwEQYHdNMMsfeaKBxvDIKBcD.mprgaTl6tqej5f_GOcEHkulzwSTw
 VN__6LKZBjQbi3ObBFUKmkbZx_0DweIDwt.fY5Rv24yIglzLbMxloVT61Bu.IKNjZ0uVQhwHdXC0
 SffN9dmDIF21KkgjERDUb6A7nGFZri1aUfLjGSTps6GucEV0UnwnHrMJJkdyYgDxZ8glPCn13kzC
 C8Qq2WzxVx2MEYg4YS2hgrjsv9kTIrKkqpJfmwnvJVdPBtwspcODa8sX66Bmz2wh33qeOK2.x2Y6
 HtQ_tj_anG3eB_btE4VWtQOubVhpJbSrszJoNWqjmAxVQnMxcmD1iiEDivRxevWK0K3F_VAvmBLW
 jnhC7PTfzB5KeOeUjww4ZUkPrCGdp578USyuaJ.3YNwjuTdaKbNO9EK_gE.mq.sD7cRCoza8vWC_
 g96Kmnk4z2bDEUljA1PpZtEMHFMRfbdmGfwxPtLMz4SE9WnNZjTOGXNQ8wi8uRAlRp1tVtgewbzQ
 1dt.gI.IaY4BkgmCVmASf4bvd952_oS4mabquwu..ZGr5rsHRBWyUt_OiO3nO1dAFe.KBWoKicvJ
 IlBufNz6g2tD0wbbwzblExqP5UUwXI._86_IC0XUHPRf4ij7Cqqca96RAbBzJ1v1gAzjyl7bU1MA
 NCKdStvkH0uxaDEZ6e3CskZoRr56TXa9C5ADBMtY3gxKcZmZI5dVtJlrYmWiYTwOTe1cmpnMk9e7
 GV23_.eKSrqBZi.9N8OjycHxYO7k3889TwBADYT8bsQ5v_BmlqIHS9d_AOuaLyGk537EzYsqXX50
 dtjf8mtqCMk0hzQIi4yz30E.p1X1dzhJSbDLnn07B9a_r2kbeXyMI_sDx3yZW.jMjCCoomkWfY0a
 M.rwNqdryDWS4FJYF5MBkfIxpGlyY8tctvRVJy2yDXPNUXMam4FlVG9qTSn.4snUO40QKGJasgZ4
 FOUsJiRTs91oULO4R.I1y9wzq4xsPZwzjPug6zTAeNVE1k2K4tccFoGLUJ6blv4090hFFKr03FEc
 GV2X0zzXY4CzbTKCBkvmVuaCAQITh1R5dZrZvwK_wt5yKuw.dvAB3dMMlg7CUUacUfFx7MrQq8SN
 gHDLFr2cRc6Th_1_bJCkfmjdyDg1UvMKpK.NbQ1HrNEb1jX0197mjeeUBxhCIpLHCXrSEu1jrfAZ
 8RqmrIyNFfOvqKohWJR0AM0FxHC9.cbZgosSpOiPY5I5QaS8__.TXPt9w1ve9mcC1RoCrfA6GzKy
 yQJ9FfZJK29HVWYeStq88WHsYy9nJVa2xwLNGV._voZFJB4JWGEOHV9TYysB2oShmHvA5yNfpGo9
 pj49.rGmI0_XPa_fLk14ID5JV5zP9BP1gpozWBhDTEhUiEg4OuT3nGHDT_B9jnKsa9gRkAzkRCd5
 U_isfzqfHgmg6gD3Y4rpssG9Rnb0WRhjZgszr9UFOtUCmXvkLxO4-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: b64c7635-28d3-4c89-8ff1-ac7caa0f8c14
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 18 Jul 2024 12:12:34 +0000
Received: by hermes--production-bf1-7bd4f49c5c-qb2hx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 78b91f3de68e800f759283adfbdfe161;
          Thu, 18 Jul 2024 11:52:16 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: When /dev/console is a disconnected /dev/ttyS0,
 TCGETS on /dev/console results in EIO (Even if TIOCCONS is called on a PTY)
Date: Thu, 18 Jul 2024 07:52:15 -0400
Message-ID: <114770592.nniJfEyVGO@nerdopolis2>
In-Reply-To: <2024071238-underarm-impulsive-dc1b@gregkh>
References: <8411114.T7Z3S40VBb.ref@nerdopolis2> <8411114.T7Z3S40VBb@nerdopolis2>
 <2024071238-underarm-impulsive-dc1b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Friday, July 12, 2024 8:59:58 AM EDT Greg KH wrote:
> On Fri, Jul 12, 2024 at 08:52:15AM -0400, nerdopolis wrote:
> > Hi
> > 
> > Background:--------------------------------------------------------------------
> > This issue becomes evident on VT-less kernels. As when there is no /dev/tty0
> > device, the console defaults to being /dev/ttyS0 instead. Although this can
> > also be replicated if booting a standard kernel with 'console=ttyS0' and ensure
> > nothing is plugged into /dev/ttyS0.
> > 
> > This issue prevents systemd from logging to the console.
> > systemd when logging to /dev/console, long story short it calls isatty() on
> > /dev/console, and when /dev/console is actually /dev/ttyS0, and nothing is
> > connected to /dev/ttyS0, isatty() fails on /dev/console due to an input/output
> > error, causing systemd to not log the console output, because it rejects
> > /dev/console as not being a terminal.
> > 
> > 
> > This is noticed on a VT-less system with Plymouth. Plymouth calls the TIOCCONS
> > ioctl on a pty device it requests, to redirect console output, and in newer
> > versions, it displays the console logs on its own without the assistance of a
> > VT.
> > 
> > This part of it works, Plymouth is able to 'see' what gets written to
> > /dev/console, log output from processes that write to /dev/console directly
> > (for example 'echo hi > /dev/console") do appear in plymouth's
> > /var/log/boot.log, it is just that systemd is not writing to /dev/console
> > because isatty() fails to report /dev/console as a tty device.
> > 
> > The alternate fix in for systemds https://github.com/systemd/systemd/pull/33690[1]
> > is believed to be that when TIOCCONS is called on a PTY, or another terminal
> > device, that trying to call TCGETS on /dev/console should no longer result
> > in an error.
> > 
> > 
> > Replicating the issue:---------------------------------------------------------
> > 
> > This program replicates it:
> > -------------------------------------------------------------------------------
> > #include <stdio.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <errno.h>
> > #include <string.h>
> > 
> > int main(void)
> > {
> >         int fd;
> > 
> >         if (getuid() != 0) {
> >                 printf("Must be root\n");
> >                 return 1;
> >         }
> > 
> >         fd = open ("/dev/console", O_RDONLY);
> >         if (!isatty(fd)) {
> >                 printf("err on /dev/console: %s\n", strerror(errno));
> >         }
> >         return 0;
> > }
> > -------------------------------------------------------------------------------
> > 
> > When the kernel console is /dev/ttyS0 and /dev/ttySO has no device connected,
> > it prints "err on /dev/console: Input/output error"
> > 
> > When I strace it, the relevant line is:
> > ioctl(3</dev/console<char 5:1>>, TCGETS, 0x7f...) = -1 EIO (Input/output error)
> 
> Do you have a proposed kernel change for this that solves this for your
> tests here?
> 
> thanks,
> 
> greg k-h
> 
Hi

Sorry if this is a duplicate, I accidentally had rich text sending turned on,
and did not realize until too late. Anyway, to answer the question, unfortunately
I have been unable to come up with a fix on my own 

Thanks




