Return-Path: <linux-kernel+bounces-331715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C04397B069
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B4A1C20FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39F1714AA;
	Tue, 17 Sep 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="L9uB5Zc4"
Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEF166F31
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577703; cv=none; b=hUwBP4J11+23bjJTWw6ZGVlfIIfkzwHG4WkHbXkPEpPTu35XONWvYM/9OYPrZK3/Edps9Fens7cp+eR/6WdGMyqgRRDiDgYyclMGR0bsd9DVwru8FAyRyhei/rkz36g59gEyvkLamS3lAqCr7OiCah4yBhho0cDMbvzNzN9LznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577703; c=relaxed/simple;
	bh=LesjakjxLUjSk4hed4SZFQ4auefxOjGtaWxE1wiE31s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SM6PhQF6z80rSSfMs31E8Nsx0iBKRNQWZDD+q/pYUQy65VR4FaWI1KYaSqpq4dPOgE+CC7xCBU7Fh//cf8GdIxDx9+0EKxPphQuxOTOo5hYwuoj2jjsERRb15rtxHEF+vdsYd/2H6Cv9GW5xLp0ew35rWrmrRACHJrHW6abds5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=L9uB5Zc4; arc=none smtp.client-ip=74.6.131.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1726577694; bh=llqIGbJr4ZEZshUe5JDEKiTGdmOcUapDFXUObEL+oa4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=L9uB5Zc4wLAyCapmJYT4vzTIlzubP5MyKQAa+zCKZtCtFTdbKFC307p9T7SewTcGMcFx07RoNG10Yce0HcuZtDvw0l9uRzBMYQ9ZCy2Cxt2sSu3hjcq5DZbz7QoGDOzCZP83c+FEGfDudGAgDcCYsMa/++98EOBuays4gbHDya0bxUhrxJrQJ4BCcDxjK9WV43MaoIAWROqbmkFqquSoo7lrigZUM6QzoK3+/iDOHNs8JMZBODMYN6ONxRLVXI92aVsgnUjz+wrFeekNCWVd+sTUP+CweueO2XtDXpNUk0rp60cBbMVHJ+zEXKgcO6O5aOa4TNShFbNvcfl0COUjEA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726577694; bh=EExPOxnJYyA1VImvajqpvShvodHOAphediASU8unwHk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LyOxTdXeUeRfno0HLV30y5kPZ86uaFF2gXZSS2ySvPte/mFhi9D71G8XW82zGZg5C/y4GIneezyMc/IdkWV4K6zCr6W7rH1m5b5bdtDz64qz1QKJLIFwCZxhNEzMn7Pvppu5g4sUqfUdmk9o74B9n+pz2xgTgDqiuiujkVs6WoTRtws9uw70amUJq8pDvAyNOIz9JHTLNr/okNR+8fiqqF+//waGFmfurk4BVr4ePMGfwSjWyocK4u8CAi0OGYGrB7OqsP+5UQv6/Ok2JxC+eqSSmhsGk0egKtmYYyBiRx5EYr5p9+lxGCcAAK3S5YmXhovwlVBMIqi2ogX+8pvDzQ==
X-YMail-OSG: bBQ8JiUVM1nRJktE_yvHVNI5G4Ephhhg3CFdDWjXDUFeP1H0lYcPsL91Nz1Zksb
 phvMpIZm8i8ED3JUzqC32kY.RvuhLT7bdPjNCRTsLHmzZS_uH7Q6zdtdrORtX_DOKp0Q.kgDdxNo
 ZgCJPIO9by5G8bddEVKOI9QlFF6mzZwJJrByCHzqNYhG6g3ZUagGZZt3IedB8o7CPNCm5EdZU_ze
 vmOdgw3efEJn5sxD1eSN.e0nSqj1W9b45gIdsxLCjXrlDWWUYNijK3liJkDWaaktr81b0aVWOeRP
 JOL7YJHqj7kYT1LzFhdvd0CBxfGZradya5PWexHfapVWNrCdPOVl.of01epnEPaS2E3pQOghPaP6
 5vtQZiBBzhMONrk1ZIsTnwYJW5QKG0C_2ef7QRVFoTh.ZqaOCJYMMKgKoZLG3C.gvXp5yPw9KNy2
 eAczoJDijJc_doekCM3dXJyIRRdCxOIOwMS3WabF9Mos_P87xtksJj6VDcmymynY.LBcFa1DTmmO
 GbFK.7bACGe6gJIbfwDy2KWJ9CaBm7td7WjU..k3PtI6Ou_YWU.WV4UdKg9paYPTT0tNey4yhrNt
 ujF9jF19s.r6OoE8ve4NngWdI9mSR3gymcvCpHCUf2UeVvfTvPHPhKG57t5T.VxN6EorJi9pBQpc
 Ki6LvkGd5FCQNkRnFUcMudXhcib.nZirGtH.UCTfgUhGKqwYt07Sv3YVRTh45lr5Q7YRGyHLqARQ
 wHzAwkgo236IBNWZVdoJCiHgXWVazqNM8MRsiIzAkfGjIlBWObGVzUdBTM2lsP01uSuF3mmzSFQ.
 vPb5maR3iUn_77nMW4RZbvomwHcj3aWgXGTAD0ytnyMZxwBTo4N.RZtmJigXcGUT5rDzKQrU0hcI
 TIHtD06YkMnVhV3Qy33n1IAd4mQHTElgxioNaQa3HxJRkp.pl1j0WxcPHa7oWGyig.Sq.eL504gV
 MzulFK8diOmrPsL6ILnuYTuCZPFHoxyhk5nOIRj74OhPkx1dUGjm9M0SL2WP2QsG6mwz7SZMiKts
 NWXHsKr4bngP0XsSxRgsIPTSVTX5tZBqLBJNdWP.YQ0MZIrqib8PKIwM2.N60izduRJyrnYtPZ0E
 8RaC0JWvM1roVqnvuifL2IccsLBTwIFoLBeC9g3ouiX4r0HZiBlhS9umrWbum3rns0PYMCbLiE1C
 QjfaCDLANhyRZrwh8Yogs2mgceRlQ3HS9ZeUk0eDH3LyZeu0d4Io5g4GYzrYxhonlbGZ.BFnMZtV
 ZteOL2kpv6fHxzcfnxNSCwI6710_figNRgyZLizkmZ3AwVycaVXiR0aLYUGmDdgXA83QUvdcDj0E
 kR6.D3MkPgdDJn0a9RtugELfxY8Vbz5gVh_y8wCxDtx1oNm9ZvemYQL7EMQIL4SgoZVpkiJmRg0k
 gBFOTyVYE3JPTdGhvL2TpAatk72DNGWyoSN8xE3CusMkihnjJEePxSGFbpIQs7I4AcKQS69N_lx3
 bIzIWbT1hsf90FpV1uwi4uA7GWrZCQz.2AWFQS0jSSSQKd.2XgJ4HbkJUZ_Yk8UWBn1w7239F7pU
 1HrEpky.FCmkh6j1LflRVWURQSunuOcd769Fl9mK5A_rsB_.PA87R3Mp4Dj_XXMLezsrARn5EGaZ
 V1sPN1QXxvltDSHEiJX3sS3v6ZInHMTGwsdkNZKnZKZz3N.xk7O6GSDU3BoXRedjwq.bZftSHrTM
 5Rsgp8g.OQxSyYaH7rC5.Gv42WL_ksmRQYhkRbKqklZOj6glT7eweZxOAgYiamPu85ha9Dugh9kV
 h0OuaUPysqo0E8V7ds.EqHtNJu_ghoViaZb5Zi_CW1iuFEpmVLvBG8WtK1yIGYke0lBDN6ctOjy_
 83igNZV264OubiYDFM0uzPgE0GgMx8cs_i9xEj1AM3mArV6SZdwNQBMVUsRiE146C7jLGpn9I0UX
 nSn_VFf7Pu525IfMNGh7d3.beDCxA33HTab_FhDmBSUfWTem7ML7ZtPMTCYXK5_aiGRK0Ajpnr0S
 my3kSm7AP_7Ng_NIR6.a3arf6uMfM3vMbik4VGgXd_6vH3bBDpF5YrIqBv_NWO9tig02hqpaUCCU
 QS9n13EJVES07Wch4QipxgClWnhOfMtH4Eiz2cMBCt.dCHVisxir90G0WkWaFTc1t58zoDJsPcC5
 hWjHiSGkseI7oM.10hnaH5MYT_.fMb3mYvh9mpJahPMalumj.Y4kSK295vtzB.QftpA3Q7tiM4uu
 1P1qmTIIvcY2yKlKDAlYVb49b.6Il6AcU49k6D2r_hxO.R6X3THx7n.aJlRTRCVLQUkDzIg--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 03d6af60-10cb-4cdb-b28f-66fcccd150c3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Sep 2024 12:54:54 +0000
Received: by hermes--production-bf1-774ddfff8-jvfvg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ad92291a463c21c8c05bab53151addbb;
          Tue, 17 Sep 2024 12:54:49 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>,
 john.ogness@linutronix.de, senozhatsky@chromium.org, tglx@linutronix.de,
 tony@atomide.com
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Tue, 17 Sep 2024 08:54:48 -0400
Message-ID: <7715560.EvYhyI6sBW@nerdopolis2>
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
> > Willy
> > 
Were you able to replicate it on a qemu machine with '-serial none' by chance?
> 
> 





