Return-Path: <linux-kernel+bounces-327521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9AC977717
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2FDB22FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642481B12D8;
	Fri, 13 Sep 2024 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="caNUKo9b"
Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A072C95
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195977; cv=none; b=Vm9fMsPVTEYLIYc3ivvJgKkVmfpouh5NT94et20KaWutKhizXNMAZg2KrTzHN1bRbCXew3KJKxfk3HTD5Rmn4XqwD0Q74pQkm2saR99aALh4gEQT/l9dYitH1CCwM5FgIdkkTgNdNBqmWYyjURMLI52tmA9YGk6ryX7LlM/UeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195977; c=relaxed/simple;
	bh=TD/memrEiTtTKKoCzHw/Qw67X9+bcYrS6SD3tqTva5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQMCXNhX0zz9pcCFHeLJP4tIRqMSePvBgke+9QhN/8D15DP2G6DHuWKfh9pqw7mrDGrVX+Teo6o83z+l92ew9qvP/OdWIP/Ig2cB6Haoat69y0RvQA2ddaPuHKiO2njKc6LXIxvFtN8rCq3AZ0hSy6lc9j3js1/iT+EBWhaiHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=caNUKo9b; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1726195974; bh=sa7hfhf5YFzjbyLYFOVJKaJfyye8iVDZNrw6Abh/+sU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=caNUKo9b5U3cJqqbtV7Ym1RTezPcf6dG7hkOb3jf/CYIyrqYlgkwxGry9mWQ8SI0cYGUImGE7nIV5grpOAazk46PVpeFvHzEIWdSsOxzbfmM13UViboPFavSX3FNZMNxenTqX4wET0SwYzarCJFUpIlPafe1IS2c091RpOYTAue+ptUlkSYWsDT8hay4YX6o41vxZArQlvwWqbz3DV6gVoiP94I6g8ArRxhzJEy1su43/i+KGgmdSMOT0RhBhcMin7jQP/yE8jlARWOeauM95+NnBX2f+g7r8ui4efUEOKcQnj0OpB8PVOV867Aq1Z0VRQrHQHQCuKyCmGMY525bjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726195974; bh=D684bRv/+M/c+Q8kTQKKa3jopDQrWPNzkpcjhWIFfnK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EhFzN7dlsQH3E3VtoRm/ygkdRDcOjjXcZ9QkBcNR3rssuOmFH8pq9TMryBX2F2uxcDTb7lLgI7jjVeXjIb6CCWFon5DLRslEm6ftPtobm0zdas1lGjvOggJJiiIIap039uPsFe5UAOw30PO4eY5eXJB4E6Qz0gH/zfFaZd21kKT5dAz4sF7ZnaQ45yH9ORhYbKDkACe5yqffPPY7SYbEEDfEcNXTTQIVc//CRYRit8FrYU4aNv4pk49fWFbUTIJnE6p2cN8aeOhiBxsuSpCAK7QCp6zka97aO2Qg60dLbWPKm+ikkTgArVJYDY0Zk/qSgYzFn0U07vjF6IaJSE1wgQ==
X-YMail-OSG: FMHQd.cVM1m2Y8wiGcg1yCl38dB.eFJ9rQ9TIxv0ON1qZ0J5xhSktD_cQ9OpvJd
 p9CCdV2yG6QKAbn68g_WzM5QkRWFkll.8ureMUsMoOwzIfyoBKITyj8IWdsb1C.JNEkvs1d7sCGl
 mOXW7Eq8ysTE4ra8728GWIZq.xG8VMubIbXpQBVGuztCtuY0Td1NizBuodK1HINm2nxjyIEBX5hg
 lW05_s0vXKQILKwElK.zbAkkdEG4tRJ4WP3K58M4FwuSykkS5NDmOrU.R9AhWJeHdfmy8yIGX8GH
 h_smIHXQvnl2oNTAx0fzlT6vguoKfKOKQpFcFG6JlkB0mtHKRVah0HGmCXHJpchNaNBhhT197HoM
 DLJm1nqhOyPPFiFy.4kVw9921dhL2fat3OtmoA0CxXhSohynEq3TFnfdzCh3cE7QWWgYAMGxHt11
 TTsJiJonTe.AshQoesEgcOp0q3Sl5_R_NFvFPysfgG6SP2uN2BOqsWPJtGT1eg7NxUqrPKtJ3GdF
 z13QkxXMqo1ozOjW32pTXGkVxdUH_as.cO9idBfEePpaAw.uKycR.Y1WS85lXqi9vOt18j0mwbop
 hWxZ3bAJ0bw.Gt2GwP0ONDgOIaNPNmcVugNaCM4KCj7wJsdR4orRvtCgmC_w_6hZE61FqMtMW9d1
 gtnxc6JgLawDTvr_qVDwoq4UVFyiWdxK5m1CIY4QnqKJHYedVEOCYS51qkE3GzIT0WndZesAilaA
 OA88QKLg3Z.OWhIDGuh5N8KsOGYqR9kC6urchyQVgeO9aQ6XhaOKx1JnEeZA7c730cPFq2VCbwOR
 F.VivMGyTo6WJ9RIGoiYZoj4GjU9JSI0nt6b1hPaEuxujFmM5NCM_0G2OSLt_yXA7CNCaYNhMKuq
 Mbl1C5JVHcsjf.2pJ7F9agwlwq7M7GxyvMqeUOiPBhSTZFcOlch_456v5uQU8MBBAg.l8o8th8tx
 m6LIuS9_iEcrQQvr63tjZS4rOwha9Se99R72NPVw1htn3pTuz5Vce7gVwR0EsiXdAEI7a6.bvLR9
 6i_dMZRNXPhH6cWPHXU_hugyBf.rzrFG6Mc_ET7lY.jlE1qulcBLDCs0CR5T3A0cCNhS.h3AM3K_
 gFyJW4la6E8q2zX2SsjqZyQzwEaeGin6oyVQ95TBKQpnlflYCAxIGzCuYfL.U49VuNGHretNoum8
 3gnJ4aD.s7svBTeZWFBLfDMuN4LEbFDQyM8hzc_Y85vyV_wYwXfx4JE.jB0p_Fxg7o_Ykr16aqG4
 nNrPVc5cvQFIMuEGDBBAOkG6i2fM5SeQwKHmMc16fLbmoxTPjJuQ81AlCSC7izv5qbKRqe6vgrYl
 _dy3PNXtm_cr9JosfA29fPDfcMrumruE5wRP4dcC.bhryUj2BJRuFlLlsHlZGe2bqw7Ux_5WbMUz
 dwQBnaNQJtfUZ6MuqATbVusU4bfu1zMof21T5qL3SkcPkv6GJl54kLUM0J2NcWaRbkthHpSrfXYV
 dKE_bq6Jd9cwApeKTPNREN6E.SV_c2di5K9K0xKkQ1JnXmaA4bgAI6p_3TeYvkF73VKS7wHPMpMm
 RDcXYMe1j7n2JY_Syw1D23ZIiVWtLeKfsZ5xn6tPvS4cxiss.aUbQ4dFHzVWIs7QHFcgdT0b0C9K
 d0jdqg304SSrR2fRfDslQtDSXfsZXeH4W6bwC_6uiVYVxbfC2ZBHG.wPppLiMDSkgPEXrZTuCt7F
 A9DkfrEHdLrQXg887sv1R37Hecah_RrW9PqJQTMtSiS.1XZV2M0bsS1IrZ68QR_U9ufwaIBur3wt
 pZPa5efhhpWKnh7aAQVuVmX5PhQmBiBK2.o_okm5fUjryaPdR6MU2hqtfrMfmigOuTIsCssoMgJt
 Bxn.QIPfAFyYcoHg..6LsRzVlHdeAEd7WCtKqY4x8YwiOkrsxYMHGCLj5NuBQbjfw1c8u1052bKp
 cDB0BaA2uCktfM9zfMbAHPkmdqYoVtrEU_4yTUJYc6lRSQWFrWWQEWmTHLIyv.p4mh_10B04uhTG
 KwfeIlUB5KMWWfX4tzciIJ0sUfdUT0ReuodllX_Pe30LUgm3FlkRE8xmfvvoDAwOTwwSqo0U7miM
 1yy5rCjlYLlInL.EK1Um0._28kSIs0Kr0capdEcf3zegZA4B1Ip2qHrINMPwgpA84fK1Up_Xwfew
 ZvbccrdgMKvfoFdyP_RVHS4HJRIoql4WBjLbG9LN2hSzqKsEIJuQX3NzVAOydphfPBFm49y_Y17R
 h_g5zvlVeHeYYLbnimkE37HuuTEuzOSWGBVzC5a6QJpR4zgFpADUMgGPaQfcZT_OXcl41_zgLyZN
 W
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: e96aee34-b106-4508-8305-d8c103e0b613
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 13 Sep 2024 02:52:54 +0000
Received: by hermes--production-bf1-774ddfff8-dhfgz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5f77a5c8a842129266ca2efd3f931c5c;
          Fri, 13 Sep 2024 02:22:30 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>,
 john.ogness@linutronix.de, senozhatsky@chromium.org, tglx@linutronix.de,
 tony@atomide.com
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Thu, 12 Sep 2024 22:22:29 -0400
Message-ID: <2284924.iZASKD2KPV@nerdopolis2>
In-Reply-To: <13599488.uLZWGnKmhe@nerdopolis2>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <ZuMkAiJz1YgdGpmJ@1wt.eu>
 <13599488.uLZWGnKmhe@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thursday, September 12, 2024 2:46:04 PM EDT nerdopolis wrote:
> On Thursday, September 12, 2024 1:25:22 PM EDT Willy Tarreau wrote:
> > On Thu, Sep 12, 2024 at 12:48:01PM -0400, nerdopolis wrote:
> > > > > I still kind of lean to CONFIG_NULL_TTY_CONSOLE, that way if enabled, and in
> > > > > theory, only distributions that had CONFIG_VT_CONSOLE turned on would turn on
> > > > > this option. That could allow /dev/console will still work the same way for
> > > > > user space logging, while disabling vgacon and fbcon.
> > > > > 
> > > > > And it could still be overridden by console=ttyS0, which I think is needed
> > > > > anyway if you have CONFIG_VT_CONSOLE enabled
> > > > 
> > > > That sounds safer. And even then, I still don't understand why the application
> > > > logging to /dev/console needs to block on it instead of just dropping whatever
> > > > doesn't fit there since that's the primary intent of an optional logging
> > > > console, i.e. emit events but without preventing regular operations. Maybe
> > > > *this* is the thing that would require a setting: wait or drop.
> > > > 
> > > Sorry about the late reply, the application that is logging and dropping is
> > > kind of unintentional I think. From how I understand it, systemd wants to
> > > verify that /dev/console is actually /dev/console, so it calls isatty() on it.
> > 
> > OK.
> > 
> > > isatty() in turn calls the TCGETS ioctl on /dev/console, which when the console
> > > device is actually /dev/ttyS0, and /dev/ttyS0 is unplugged, it the ioctl fails,
> > > and isatty() returns false, and systemd assumes that it is not a serial device,
> > > and in turn it doesn't log because of that.
> > 
> > I'm no tty expert at all, but on this machine I'm having this:
> > 
> >   # dmesg|grep console
> >   [    0.000000] Kernel command line: boot_image=l0 console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait
> >   [    1.638242] printk: console [ttyS0] disabled
> >   [    2.848759] printk: console [ttyS0] enabled
> >   [   12.950334] systemd[1]: Starting Set the console keyboard layout...
> > 
> >   # cat /proc/consoles 
> >   ttyS0                -W- (EC p a)    4:64
> > 
> >   # strace -e trace=ioctl stty -a < /dev/console 
> >   ioctl(0, TCGETS, {B115200 opost -isig -icanon -echo ...}) = 0
> >   ioctl(1, TIOCGWINSZ, {ws_row=30, ws_col=152, ws_xpixel=1534, ws_ypixel=604}) = 0
> >   ioctl(0, TIOCGWINSZ, {ws_row=24, ws_col=80, ws_xpixel=0, ws_ypixel=0}) = 0
> >   speed 115200 baud; rows 24; columns 80; line = 0;
> >   intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R;
> >   werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;
> >   -parenb -parodd -cmspar cs8 hupcl -cstopb cread clocal -crtscts
> >   -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff -iuclc -ixany -imaxbel iutf8
> >   opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
> >   -isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop -echoprt -echoctl -echoke -flusho -extproc
> >   +++ exited with 0 +++
> > 
> > So TCGETS succeeded above, and the console is unplugged. Even if I enable
> > HW flow control (crtscts) the result is the same BTW (I preferred to check).
> > Same if I enable carrier detection (-clocal).
> > 
> I think you bypassed the issue by specifying a baudrate (which must be forcing
> it on?) instead of letting it select an automatic one. try with just
> console=ttyS0 ? 
> > So I'm unsure what would cause TCGETS to fail in your case.
> > 
Looks line I am wrong about the baud rate turning it on, I did more testing.
That is odd, I tested on my laptop and on qemu with "-serial none" and booting 
with console=ttyS0 and stty results in an input output error.
> > Willy
> > 
> 
> 





