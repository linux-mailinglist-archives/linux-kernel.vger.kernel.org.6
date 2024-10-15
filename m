Return-Path: <linux-kernel+bounces-365932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C0199EE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DA31C23300
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E6189F30;
	Tue, 15 Oct 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="dhl+cQiT"
Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84548763F8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000016; cv=none; b=LFHtw73I8xgT1hjpRkCd1B4Nmtx2EDhU28Qo1bwy5FinDNaMhLha1BbykUCKdQtWO7km3pwCLr8x43ux8LwDUGhw+HE1OSqg+o5qCZaI7leCrAQJC2bbWQLGy69Yvx1MQNKokBmlOD/Ey/JvS7RxaGyfGIeBOO+B+DGaNOBhWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000016; c=relaxed/simple;
	bh=GK8e/lRCfocwcQok6NFX1CAdyOJhE6h73VuT9uQnFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=px9pMuEPam6WLVd9CvBFNfnKAI0SgAa/P7LrVAM3PiDkRQXiv47VibJWeqzcFapjpM54ifAWMNI98wzWfToNVy6Up4dIMaOPXG4VzyryZOx16pL05F2NCPEuEMRyKDAc8JD2cJW8byOr+VNG2x0zedmG1XIvNFP0YsBiKV8tYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=dhl+cQiT; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1729000013; bh=rYOONTOsLkDw0QBDf30SL94SNl6BK4s2pc/GMlQPEZ0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dhl+cQiTv+5LLj2Jvc3+0q4d9qddhqwYbqTcHcFFqWTwj6/IsFNRt3H+NK6S0obbsQwxmN7B8Su5bKxoZ5uhve9TSVPbUW3bN306amXi4iwoCoMlUoezzL1XKHnolsozFYB3sTs1zGMXDPFVVqv8+pytJ3uJkU545wkh5GXBfN4e8CzM+hKxyUPqQTMA70MtgP+0tQaiML3D1iCmyfhHgYgRwMxgtZ826CcjTALCNgDP8nOyqZ9gOvkPTUYCHiT0NxwWhVSd6okcej2rwiCAJpB/RiPVoQzPXoDNThSY6mH74UM6+Y9Nsx4ykuIUIuVU16Hz4sPeH6Fnn4Y33noN2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729000013; bh=6KNBpm7bXwKi2xx5Aui/qhurJNDGM8lJk5g4m4sZoF4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sqzLXqfrTPgGhVc81zGc+KZ7f+NKRoiAnmBbJZd+peLOb7jZe1HzYxS3Wjzm/w+Jk/BzegVj0YQVrhKhSaTjTS8LE5tkFtuMn0WeyPDoV4s/jeXhXdt8TP4lkja+TIqJ/6qqpfR5QLczNlUlp9S2/9RII8R77Di0Z4q09evHuUSUS+PpR//eLd5qeqL9qweP3QafBuQBMITgkupmLWtBXWEKrtWwO8vFopZ1msff3ZyBN9upHJ7fEfkrzt3jjQWWO2zbOv2culM11O03qpYLv/Nz1SvfroOSpjFH9EUAPWEhFgt9KkCYf5yb/Fd/yroot9w6OgDrWuK0fI/URZYLpg==
X-YMail-OSG: qvIGeqAVM1lsXPUAkICszS3BRxxlm6OVrq9M6eIqDxv9cSn.nW2phNOpNdMEyQr
 PVLvW0tFDrFllzUb8gz5V2w64sqVMBHY6_JyNfKc3rFjqZNFmpz3_I8edo2RAPgAlNDmAXbs.leK
 Zy4I8.Oz6aBSUH6SIuLKKSkBM0fcTkMIuUicRCttB8IiLvng0IIsesf0cHDXBKTM51XiKPeXuJii
 Xxj65nvnMUJIWUDbWfnwRamfd8_uJDXLeTic_ahR4qcjledfyvSmDdyJxmm_TUZES3tvBYjLKsQL
 rNTj3WL3zblxpNQ8PRjR_ZYXxKpujVrnqAmFJSjGOQpnWTjP_ZPWaiQSQXoDJU8YqXGnAltH79IK
 QelBhHehxZPBt6ximE6WA6dD6OT8InDu_iAvKhmBDCsCJ_V.OqUGlGESySEAljxFztOVUZmeLKwF
 MjIpAwYW3VkLAUgZvUbCj6h88EgzQamaj0pc5p91fely0tdvNsET6KKD2ye7RVHYH1hzeIw.P48l
 rKa2aWjTUcXzYTOW4UvZSm2fkILkrBqKg9ycuwpEhY.hJY3Do99k8zUrpgEVUD6mfXpYa2D7p3p5
 nlVVjDmi_EBjvTiI_R64OxM4GExzazx5OkwyBpo4c2TgntE_ursziK4bRRcy.kxEXdTbDQqODHFU
 .zOMPe_DAYluUkWjvFDaWerUu7s6zSnXpnZY1ZtQP3ypBwJ1xi16_spFA0x1rgCeAV52rUcLppIY
 BQbjpjd48svUDrtHZ2fDWt7XiDPWoniGIfDI4mjeVPZDXuWIigESIt_upFqVzI2mpW5lI8mFeExS
 Jk6Z12VN.7GUjEeDloU0CfYIox5nCLebhbfgtOAVHzoo.rupCjVHToZyTnu98U7GutbWJexNc24_
 jpcgd8LrfUe_lq2jfgTmTx_uhDrSE7iRJ6dWC4Xz2AjG.9v6O2laLuHHeRNlQyxiGYTRTKwgJLPF
 UQ3UESlwuMxm91h7zsWEnrzlNsEE_L5DC1ZOUaY1ybr5OIhkJuLlAJhHkNiAgj0vTQccqU6M9gKY
 .YO_kYQx6dL_DizWNqF4UpIPxDVvsbGNVKLsathae2Fk2tlNIxtVI9QWknrQ23KS84QY1qMpb587
 BotF5gCqBWjY3cDuUpg58vyVIK3J1yk4.zr2CtIm_g0tOUp9VSa251b0cErA1VFVdMxdgO7bhVtL
 59KSwaAiiwL3.PeJOVwTmNJbCRNiA5gVe1_zq84O16k8E_J0Qer2QM66pjbtEiz2SZcESmGBen2n
 7wxhFUKGlz45SAf0AhTK593IpuPM1kVRX5whvKCW_MnIL2fqfTZpwt41qQfC02an0G5Ql5W41wib
 vK8hINRynT14TSbFRLVqjYMYDwZkYd_AWlBuku8wI2G3OePyUtA.PIUVE.3tOuDqtkt2jC_SdP.y
 bj81YOLSkLKbRnHnvd1Ww0PO3Snzc9Q.B8WCRDHzgdsi3P4hvp5MePazGQz029a81Jtzc21.LC5.
 jN0E4c7cqYlXL8EU3Nav0cB6e.xPpvy6Jxo1r3kUZsvmlbKvavV0MyHdlc8QU248JPZG9rjXdsGu
 M6hoIl7XMrsHPsrhXVQW9olPVVrjcbjS6wf6vmXrJ.EWzwOfbxbpkd1qhKCJmgSXNLDas_kSOyCy
 C.LhT3a2Y2uVuJitGggvTDwAxYXJjDXfJgS_o6CdjsQU3V7Ab86OkoRAjmSS6XI1TkPkCj_0jp0Q
 oYpIyDcQFJw_ukIhgZIR6MXToRAXdGffQ_YyX5.OibmpKBoUp54uAQCo9pSVwyhft6D0oOoUepG_
 etKr7ZbEEPsvUE8lyzvBHpOAMcxgvkgCfuf_0eHDlK0EcJFOUhPYm2DpxDwfxcKXB2KtAlCoDS9Y
 HnFfIkv3.LGYaEwN8gMMsTD.HX4p3orfHF5rT3DUoK6rNW2GujT.fNXiJTmhr.JDMDb0BHsBhwJV
 9LMYx0jXiqhtWh098L6MWXlErWF2uWgVlGfs51or6x7rPG.FQp.crjfLPQ.yd2guZUdlG_8GvZxE
 z3sr1Fv4K0MA_.RKyiy_9TD_WdcyuMzvxGaxwE7DLcbrxDITmxrxh10SF39tQCzmunlODT68XZKm
 ixCy5L6Ek2vRWoMyoqWPjbskNFEZxxrDMRAS5l..ywt1AclpPb7gZoml1GrbtadMg_8krwtC7a4p
 .BpQ186AFl7gsfWKBkVmEqCqafEoEX2HMqPGQScANqA6VYCHNC0pJJeQzuvRvybw8_M6tI0txtbp
 fJVFctoypLc.84Ah7.AWz6A13S6Qe0YQBcnIG9v.2ldohlaJWefnvO5VnxJ8LrUbXoIvgyA--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: d9d3487e-782f-4678-acf3-21183243ada2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 15 Oct 2024 13:46:53 +0000
Received: by hermes--production-ne1-bfc75c9cd-654qs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID edcbb5a3444e66c3a36f7a30a53f2793;
          Tue, 15 Oct 2024 13:26:34 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>,
 john.ogness@linutronix.de, senozhatsky@chromium.org, tglx@linutronix.de,
 tony@atomide.com
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Tue, 15 Oct 2024 09:26:32 -0400
Message-ID: <2006466.usQuhbGJ8B@nerdopolis2>
In-Reply-To: <ZuMkAiJz1YgdGpmJ@1wt.eu>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <4925457.GXAFRqVoOG@nerdopolis2>
 <ZuMkAiJz1YgdGpmJ@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thursday, September 12, 2024 1:25:22 PM EDT Willy Tarreau wrote:
> On Thu, Sep 12, 2024 at 12:48:01PM -0400, nerdopolis wrote:
> > > > I still kind of lean to CONFIG_NULL_TTY_CONSOLE, that way if enabled, and in
> > > > theory, only distributions that had CONFIG_VT_CONSOLE turned on would turn on
> > > > this option. That could allow /dev/console will still work the same way for
> > > > user space logging, while disabling vgacon and fbcon.
> > > > 
> > > > And it could still be overridden by console=ttyS0, which I think is needed
> > > > anyway if you have CONFIG_VT_CONSOLE enabled
> > > 
> > > That sounds safer. And even then, I still don't understand why the application
> > > logging to /dev/console needs to block on it instead of just dropping whatever
> > > doesn't fit there since that's the primary intent of an optional logging
> > > console, i.e. emit events but without preventing regular operations. Maybe
> > > *this* is the thing that would require a setting: wait or drop.
> > > 
> > Sorry about the late reply, the application that is logging and dropping is
> > kind of unintentional I think. From how I understand it, systemd wants to
> > verify that /dev/console is actually /dev/console, so it calls isatty() on it.
> 
> OK.
> 
> > isatty() in turn calls the TCGETS ioctl on /dev/console, which when the console
> > device is actually /dev/ttyS0, and /dev/ttyS0 is unplugged, it the ioctl fails,
> > and isatty() returns false, and systemd assumes that it is not a serial device,
> > and in turn it doesn't log because of that.
> 
> I'm no tty expert at all, but on this machine I'm having this:
> 
>   # dmesg|grep console
>   [    0.000000] Kernel command line: boot_image=l0 console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait
>   [    1.638242] printk: console [ttyS0] disabled
>   [    2.848759] printk: console [ttyS0] enabled
>   [   12.950334] systemd[1]: Starting Set the console keyboard layout...
> 
>   # cat /proc/consoles 
>   ttyS0                -W- (EC p a)    4:64
> 
>   # strace -e trace=ioctl stty -a < /dev/console 
>   ioctl(0, TCGETS, {B115200 opost -isig -icanon -echo ...}) = 0
>   ioctl(1, TIOCGWINSZ, {ws_row=30, ws_col=152, ws_xpixel=1534, ws_ypixel=604}) = 0
>   ioctl(0, TIOCGWINSZ, {ws_row=24, ws_col=80, ws_xpixel=0, ws_ypixel=0}) = 0
>   speed 115200 baud; rows 24; columns 80; line = 0;
>   intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R;
>   werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;
>   -parenb -parodd -cmspar cs8 hupcl -cstopb cread clocal -crtscts
>   -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff -iuclc -ixany -imaxbel iutf8
>   opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
>   -isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop -echoprt -echoctl -echoke -flusho -extproc
>   +++ exited with 0 +++
> 
> So TCGETS succeeded above, and the console is unplugged. Even if I enable
> HW flow control (crtscts) the result is the same BTW (I preferred to check).
> Same if I enable carrier detection (-clocal).
> 
> So I'm unsure what would cause TCGETS to fail in your case.
> 
I am still kind of curious why TCGETS is succeeding in your case.
What is your /sys/devices/virtual/tty/console/active
and have you tried in a QEMU VM with -serial none ?
> Willy
> 





