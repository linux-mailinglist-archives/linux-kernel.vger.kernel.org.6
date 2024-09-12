Return-Path: <linux-kernel+bounces-327089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EA9770E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC87B225CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA4195962;
	Thu, 12 Sep 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="pULqx5m3"
Received: from sonic311-14.consmr.mail.bf2.yahoo.com (sonic311-14.consmr.mail.bf2.yahoo.com [74.6.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAC1878
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166775; cv=none; b=CfQb1iV//zXUWGbzLBhHjN4Rn6QnI+pxtMVzXcaLfDtFTweIj54kEfAq4GJ/LLUS2Dhq2nZfSQuDxVfzzYoQUWGMQ6Sz1QuspGfvdDtVZV2EhyklpXakemc7neDkoQMqeI+gTRW+xRi0r1JjqY2EzlCIensUWpcVefsVB3e4SFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166775; c=relaxed/simple;
	bh=dTCJ4xlScbRc7AXIl22WHW8PwZM91nAuIUHyxrIBS4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJyaxIqEUMrVamm5KwlnDhbpObJ6dswfTdqL08UzWa5wr4B/X3RAExd6Jr3PV8YcwhBHHU0v/jBnuEIhMryLaapb/i7yaWecS5V8LDMzJf068BiZxpjtFYLktFosU1mHAg5Lyr50YMX76f0WkZ9zx3JmljZN//kxS/pLS2UtS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=pULqx5m3; arc=none smtp.client-ip=74.6.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1726166767; bh=kiwV08t7EFMVfVLa/e3/BVH9jAkEMb4cppHqrin6UZw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pULqx5m3MJHilqCrEgsw/KBpide+X+H2wh8fCVbd30Z5F10x/qvL12bK//gYqsR87JP/92pboD4JpeA1gRzjxMZRw+vFNq+0SOveVdNrR9G6EWBK1f1v2rh+WhwzWhmUkr+zl+xnCLsQxHjtDjHjpq3DQnyFwxE+WWOK2vUvdKjwvnWX9HCXeaH08QZBIZ1h9OC5ANrHHqYNRxm21DxKyc/7xgIENAIsQVqV6wCOvJIaccap2Ek7GzZCNPwjmIutsKvBXkl8bZwxtiRo1tWsHRO1t1Uo8gCU69aqTMCLRggHAWri3K4T/6WIhk+HDqgIEdn4fEPIfAS75I8pl3oHZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726166767; bh=Y1gP/Jq6amGrhRHzp6yNsdBxpJCpp/0ZKRK89BEvpv4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LiGj6JY8LbN6R41e4Z+eEqe8SqyCQU6sty19N7s0M1gprL8WDRCtI22Ejh0SDaKl4ZPyQr8H7JSJRHsUTUU/KsgPx9o11JEpQe9Bgi7L/EuAcHq/tzFCMNaCV71llXPxFxRS7fEUUlH05TYJ3BQcPpymdi4D+zUGuodpRDUkLPVEw6sGsTcgqWHERn7nBPLwpfy6Qjy4gnMVsUUiFDRk7ybVQEMAoBSg96fRe1fiKTj+c0/RncDrUDmNRmIe2pq1H17JNy6B7IUIcuF7iD8ojRPA8okGpQgAi+ZFvKP3TdPu9yi/iO5Y51w6gbEZquSv+gup/AVmIPaPUfy/Lr//yQ==
X-YMail-OSG: 2YW_3hwVM1m_YOnnQn3TvXepl5vuhDQFwWrmw6oPfXMpaM6I5rgPgSIXlyN5US0
 pzBjxd5puN_nXQnMf_WtBh4FG3gEQYEFIfkMna.NFyap15gBLph.HWzelslElwiWQ7lH2m7hVt5L
 1gTFGXWxfe9c1YDzmNIrldxP_Ooq5w.Q7rVyb5YssmNYQKQRjr4zIAmqTiGiPGXI2V.i_CxBX2VO
 M5IDJcyXHy4oFSVZ.uHivnyPMNTIdDq0ksw478YwhLMZUJgL3v0KCbkelg2WhG2SYtjdIhBhxCTB
 4r2rTIqbvve24faCKssWikR.e8CcPdrcC_0zaAwuqlQ6vOgnbiWFEeLq6YttEF8mnOcMy_J8SPC2
 oNx0TsyShQciJPX5za9HH78.duxjYtOC07H4oBcWLmHH.lC74OocEukzA7O8MJlS86FCAdbOUkv6
 LItAo_fHq4PVXOSBIokM3l5bi6MNv0RNu0UVv9gkRKYNeN...7Ykys08Ux__MZ7.usV2yqtLqC27
 9QTvfN_zElJeBnhKRh2KAWdO7VQh8iomZE1XgE5G9hw..TfuX7xwK3Bi41h2PUDXe_P1VfRuaWCV
 0XlFMLW8bKEn0jWKJBpB5PIplIoJmBrSJyaall7v8SSphilZ9mYYfmMR9CmcDuvuX9yAjIebLOSR
 yWo4quEFmHqrPayx9eUMis26hhYhxJs9EldVQHyF36SVWzhS1eI00xupzLbtk2tLZChXzGooE4N2
 WHvQfjkjdDg4A1Cy.v9tF4RNuztOanrbF3MM6M6n8JvYBzJHftr3Q7vYkpf9Apc6ykJ8X5fq6MQt
 q96DbUcrXQlk8NNOvoMP_Xl6052EYRb8XxR79JwZYjQ7UAAHQ8O92LZyF_5ceHnCW31t37BD9lL9
 Qy_KTPDRwv_mvy73ae59Lbv_KUR2.tDbVbJZbBbiQkxE.XkLmQGyEnZzt8vfuyA.3KtVDhEi99Dg
 hqCoZgFKc2jCnup3s8DqDZ25.nedKqAUtKKaK4P1j5KcRQ_fDnPTD0VewiHiJ.I92N2Cgu7IS_he
 Q_caqJ9JDeEb1ZCAGXWHW2uwf32899FNmuyZVLFIOxg1e6GbNf2rM3HD1CMD7JLdUX3FZnzBHmKQ
 xECinZ1YPGBEHxxl.NwTPYuOdUEXQTVwat3JpLmfnGuKbZPJLyVBQBcvEFaW1Wty_ewMa3SoydRk
 xRkPNcSrXGiu21blQeCKh6gYQDq5dIzuiCv_z.LjWTQoZ0tgmtVfIJf3DoJtjgVH0C7Hs00QZv5N
 DOgpELBaxOMfGaAtFhxcFx9Kzg.gwbxd2ox1uVlRh38OtQgGJaXPfItYq3lLY9wiyYKhT0TDrdfA
 2EBQj_uGC6Vi1M.A3dNjTh4jFkUZMoeCnXu7YGNT3f5hjAvQSTiKzSi3XCUuHl6aguN2QV5oOpdm
 QeFNDr6Mbsecf5XjFoyRftmMAbruTyEaZLenvW5TCFCD_OR5_oMmRmZDsR_75ZlPCFoxbqfem5oL
 siri0p_2JTcWqqYIBjbCkzDu0wlUS0DGjCYtQNey3F1WBUO.OZkczaG16rd._sG0MT8gUm93JuRw
 45M59IN108JrYQ8JiXdUOYUvBRJPEaeStpHqByrvZyMTb1J_wxxE9c_RPr4NmVitBjw8j1IRpiou
 HINbAqgS8l9OmIOVdI2jhcx8VgKEVeP5ZrVBADhfzX_Ew3MXjp8gNqXHV0cXu1dEWjynk.VUvTeA
 c7ARMbg7AWtqbkPC0L_7tQaQ6Qhr3A_uhLs5CTmdmgjOyAyhtMCBK.k5H_ZO5BQHbcqLq8Prwbau
 et4Cu1cx9pXBn9VSoJ_..2MV_1EIqpRndz9S6EJAgjueuy0VJ_qovqCHM2P7SYsVeDjEN9uG_AHH
 snOmT5vPlJXukIJu2Y82sZfEzJewd5DnydtV_6s.qKIJBZrEK2ZzB2xZm.TaMPOoMCBtGRoPG4Cv
 twAerPFiFQ54nxCUmngCa5W.U25gPQsl55LIg643zGiV_R13i_K4NkzBSzqg_S_nTbhFbG5GOMOH
 aU3Se99h69VMbFoWZEWK9YRr8wO5gC5aYSvCW8FPRG9.hEqg2Amr5UExYIVaCRiFYX10NNC5ZY9f
 wnZBCbwMA_jnfXUhqlzGvTmazKeK_QgzTEqObOXyabxZILXgPBTRNORFpVGvhy72Bh_jaD3lSdSt
 n5WRf..QJmgCwC2UQodYGb31lJOEVp_o0tIluupo5ru0PPZ4Aa5Pfz2hRg23QY7Y3y0X_T.olTTY
 LA5EBArb.JYFVQR7Aavswb3u3xpKOdUUKWtbfSgekKekThXbWCiOGU5s.W2m6rsjLEdoxsfqPe09
 0
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 22f37603-1f07-491a-9c75-9f7173fedd02
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 12 Sep 2024 18:46:07 +0000
Received: by hermes--production-bf1-774ddfff8-dcw6h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a449f06eaab838140659539c2a40f2f4;
          Thu, 12 Sep 2024 18:46:04 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>,
 john.ogness@linutronix.de, senozhatsky@chromium.org, tglx@linutronix.de,
 tony@atomide.com
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Thu, 12 Sep 2024 14:46:04 -0400
Message-ID: <13599488.uLZWGnKmhe@nerdopolis2>
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
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

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
I think you bypassed the issue by specifying a baudrate (which must be forcing
it on?) instead of letting it select an automatic one. try with just
console=ttyS0 ? 
> So I'm unsure what would cause TCGETS to fail in your case.
> 
> Willy
> 





