Return-Path: <linux-kernel+bounces-326975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A265976F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C01C1C23A61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E41BD002;
	Thu, 12 Sep 2024 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="XlP81OBU"
Received: from sonic316-11.consmr.mail.bf2.yahoo.com (sonic316-11.consmr.mail.bf2.yahoo.com [74.6.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CB14EC51
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160899; cv=none; b=AQmsEJ/EUUGH6+MJoRnZ+G/WbeyKz48d6suh826xQxU5wwQPc5XHMhqV9cxnfnoq4wca7j4T5F+e63toMRCGOW7BVY0RJOeQX1mSON9ssA8Mn8qcT7A1yWW4SZIl6GC56o2MxRvfl/houXfzMt4Qhxi9PlkjjY7cZVYxFxVjRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160899; c=relaxed/simple;
	bh=PGE+jSfBrzcH3izmpfrUVJfnCJn92ZLbqm9O/GWGozM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7hQZFim29cYsR97stl+5pQqUUAbvFpwdhKCXyzqlkX65E6/8EBpWiijnIL0cOGUYBwheKN3oNCP1TKPy+30iqY6Wp1Ec1DwNGpeozJ7Pz27xmneTowMoiDYGXJTFMoigRDty9BnPwSWGxSas4qZ88GhvMrov0tOaUMOgzsi+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=XlP81OBU; arc=none smtp.client-ip=74.6.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1726160896; bh=4OMSjianHkBn4YhHlbce6scNsBNGbcqmHHrstBsQccQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XlP81OBUwFzxR6Ufn4+ghKtfw8Bd86YSfwO/8eY4bCBw9WV704cwrh1Yvm912Mt/TaQ4WMnYG7Om8jZ54oHlsACEuNLkyIAZN/OiYF83XTASHySC2vKxGs/f0NDxMuc7RKac/ZZKqFzhXN4xMmVsu4UHeJykBJizy4RnjslqcloY4sL6/bIrVu7g3ZVb2q0weBotmPqICgYBN1X11ZyIaTYatfhO7a51EJvdriJ4yxe80y25mwet1kJg99WSSfvd3zr9wkL5HvYZbZBfmb2G2gw+O+lQ6P4k1aoUPcF/4DD3jOezMATtYqwtsBTQsVnMUQxGC+JVMO6V7OxuL5dsSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726160896; bh=dGl6TqukpJWvBsqNXxKUiGkRWmn0e58pTmBkuu+fA2D=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Jq663ZCJnbRxiYz5kqXbHQKxoooJ8QotpQdkXFFoWMEads/Ogb+Lw+msH29fCjEwZHCVU2ucnY1KNC0ovefLsL8kveLjVtXA9/P+2xZ9FUxIoXGSXWDplSg2Bs9Eglth4Min6hlSvJ1bvOlubjiUApi8KWTKaOBGLEfBygZzjKgg9hWFtwWQU53m0AGFjyHJdNphoR8/WPi8g+lX5XtU9/7D7VC9g2jVPs0kWW5LkMqRGRghcvA99D9Um3delmHPt0Vbw2/0Z9v0gA9gYS6D54aNjKcDBzcFHGR6ZcaM/fN5dJsTJdw0dytkRs7htNQgL7+L0cStkdtv1LBP8D1zFA==
X-YMail-OSG: TyY_1F8VM1nQ3H7SjIvyYbMzykJTtLBsVIFX.wukQpGRwRYdC0Tv9scYv5eNFuT
 JFMl7qQikmuTU9vQMH_6ILXbsLX_h0113z5xy3BkWd9svk8OW4AL1_Jqwoxfs2v0gkMp6P48Q6Nc
 fTEC1ZlAkgkUfg44QNo7FOQplJNwryXEBeMQpiNO71QSJNI0oXrSN2E0SalVOXABCvdbnLExpOZk
 Bn1.aJVk__1P5X.vhKP0gMeVHKryJhr69xEnN77u66L5JOuxT5SyJYFRI.Z8fW4XBSNjVoVm2qIr
 ePGu0ScJC98BKFtYR2WdQy6PoM1_ocEFOf9BMHMk8XgJPX0GY1LJ7CXycMccOglvAzaHauHlq7Nq
 zRM072lpuTxbK8aud3h5r7nyzqUG1Ov7TL6Z7ncyRb5Zij7snM13V8YeAFVmh3cRv_w9jo1TA5qO
 jMK9akICjp.FDDNmGq81iFXba_WuXM79R9KpqkiigALrvst4MUyMF8GTMpPFbo2oYfpd__HpnTau
 BtaGZ..1kIMmBqM2dUQcqM9PEUeVgyi9bp6meJo3iUuDMobuX4s7nsI8mMRhGs7nd_dTJnuM8xd6
 Z4Mk07iYuYWTEDgP1VcsCPwQF1QCIAzA9uMpgXW4dK4NlrifsdyFg3P_2EZHjUy4E1ZWOuKWe305
 Y1v1aGRxzO1MOfAppCvA6dSKeXThztd.8UL0_HDnW3dJqqSJ513pO.xi_qhk4T7WLQhX1AN9q3bP
 GesR52RUasK.SHDfZvddRT01grIIggUfbEAvebsF5iBnthyv5ZOxP7DSqCl3J2ThJoDwDiVBcBhc
 9TrX5frsYG9Y2xv5xvGj1eB0i4X5qXOnPiW7Mn0CWJAyh9oAq9bLCBaKQX9qpbolHPbKxLla4hnW
 R.pf.pu2uWs0c03VGnO4L3nVvpcsBSipJ.Hv_Vt1nzwsGTbeHTqo9VN6HyJPXc0hlO_cYGzNy_6P
 HE1D_L0.5H4_bsvnB0HBGdBsV2vPM5Wti.mH7hOOaZLmrMcNqZQnIx4HpJjbpp5XgcaJUJeJKdKu
 .A_uH7vDTuQG.X6c2hGmDyWsn.TTOvvuo4yS6SBQiCVWXWL_hf5rhgIARpo_kA4_doaT2yO9P7DO
 IEU14c9CHOQw5S2kI4SPaUcw3eZw9iK_wqzabbiKOYszkITVEDUuctYYhe3jMoAvJUS5WPAUhZim
 q16V0dJ2MeNcjMvfol62nKT3wyqKD.YUjJ2NSvloIWw0_tbImd0sj0cdSoPDm_9uv7162jcOgwbO
 xoG4lB3KTxH5cTY.oC7vAhQocg1fVndsqeIeXqgFFOv_dUQgoyIO_3zVYlwjXOJXQ2cjEVDxvPX.
 3Xy.XPzqDbclrJ.j2D2SLvmhOqC5tATaST6_0Lta4Z07ifk6ONw5Nm.bU9z7GCG6oHbZc7ZOAyUu
 s4bKwogcodSCCWvhj37I1vlgeLqFzJc2Iqud1.TXC6SGl6XTIWulprDDQhTavYdkLPxwa10VT5NQ
 meddBXhVMDGrGKUWslXwKhjx98S03Tn0WLWyRuShmDXkqmuzeb4Hb2c6zXCfacpYjdSivwBR8oUd
 XJBL7aTsz9iKfPnEq__dK6KsSAbCtn3lXPuMzrJhThT7mQFWhzSvrybnYanfxECENQzW0n4Mmij4
 pgdKThKuwLOJRhSSyYXvuUFGY5cPSMFAlqy6.oy79XsRv3b39XfeBYrxUSBfrAvT4.ZcOykds4dN
 5yERwc2hONMbj_KbjJcOUYiVFY2DMg6DMkemSbwWQJcYH7LNmcTtAMoAPLy4Tpbq1fmASxURVkML
 nMIbTuSSbUtTv4riYo1XlqtiCQwOl9bRbPBtYqwqhfkgfhvWYwG4IuWxzPoLEZ7.RFtaXoradIHj
 UC0q0AI7PktUhEvzwHFjYiKYD.7_cNRd2PAWah3qLMTJqUMWflolUkLmMWpPP3Y0YXDQpkW641Qa
 GuHkcvDyGonTmcHE46YcwOpcGJgtVMJ9wU9btaFctMSTL8SHHBbQJ1lO6FAkhfhRW3q52elNLJ2j
 j254Rh5ttuOvjF_ZndfMY7De8fBjjgDEaxKPsqBWvZl6Is44gOkTFIlma.1RWpXZ45oMXOjPTwyi
 4ZbAMUDW00emkdqJ314ijo8XPNs.eF2_E.lRGrPYOD9EU5_Sxd6WaUB1fBlEJ1DfsbIpAufFz3cJ
 YVDWP7xSyh4SezHPaYbpEjFHKCTYFPH0VYf2FJ2yoI1tPqZZ0X878v2QAvb9HDRDq.NW5HcWKls3
 iJY61krpaR8Io1me3g0s58pb2UhivWwEU5MaAURTl9ERgfNEoOyLSo2VfoFrBepZA0CvcrqDpLg-
 -
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: e01c4eb9-b5e6-4c1c-b058-09de6582d644
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 12 Sep 2024 17:08:16 +0000
Received: by hermes--production-bf1-774ddfff8-xzxrw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a4a0220c4e42731ceba3c8af1d8e4d1;
          Thu, 12 Sep 2024 16:48:01 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Thu, 12 Sep 2024 12:48:01 -0400
Message-ID: <4925457.GXAFRqVoOG@nerdopolis2>
In-Reply-To: <Zs3YyYG0RwNcG2vL@1wt.eu>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <1877609.QCnGb9OGeP@nerdopolis2>
 <Zs3YyYG0RwNcG2vL@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Tuesday, August 27, 2024 9:46:49 AM EDT Willy Tarreau wrote:
> On Tue, Aug 27, 2024 at 08:53:49AM -0400, nerdopolis wrote:
> > > > If I get it correctly, you suggest to do not register serial port
> > > > when it is not physically connected. It makes some sense.
> > > > 
> > > Hmm, now that might work, and is a good idea...
> > Although now that I think about it, could this cause unintended behavior on
> > some hardware? Or folks that might plug in the serial cable after booting for
> > whatever reason?
> 
> The *vast* majority of serial ports spend their time non-connected, and
> are only used to connect to the equipment at runtime, to recover a lost
> access, or to connect locally to it during operations. What is proposed
> above scares me a little bit:
>   - PC-like serial ports (DB-9) support hardware flow control using the
>     RTS/CTS lines and are expected to be instantly usable when connecting
>     something to them. The presence of a cable is detectable, though many
>     will just have a local loop (CTS-RTS, DCD-DTR-DSR) and will in fact
>     only detect that the connector is plugged in. Some don't even connect
>     them, and turn off HW flow control.
> 
>   - many boards don't even have hardware flow control and only provide
>     the usual 3-4 pins (GND, TX, RX and optional VCC). These ones will
>     never be detected as "connected" and will be permanently broken.
> 
> > I still kind of lean to CONFIG_NULL_TTY_CONSOLE, that way if enabled, and in
> > theory, only distributions that had CONFIG_VT_CONSOLE turned on would turn on
> > this option. That could allow /dev/console will still work the same way for
> > user space logging, while disabling vgacon and fbcon.
> > 
> > And it could still be overridden by console=ttyS0, which I think is needed
> > anyway if you have CONFIG_VT_CONSOLE enabled
> 
> That sounds safer. And even then, I still don't understand why the application
> logging to /dev/console needs to block on it instead of just dropping whatever
> doesn't fit there since that's the primary intent of an optional logging
> console, i.e. emit events but without preventing regular operations. Maybe
> *this* is the thing that would require a setting: wait or drop.
> 
Sorry about the late reply, the application that is logging and dropping is
kind of unintentional I think. From how I understand it, systemd wants to
verify that /dev/console is actually /dev/console, so it calls isatty() on it.

isatty() in turn calls the TCGETS ioctl on /dev/console, which when the console
device is actually /dev/ttyS0, and /dev/ttyS0 is unplugged, it the ioctl fails,
and isatty() returns false, and systemd assumes that it is not a serial device,
and in turn it doesn't log because of that.

Thanks
> Just my two cents,
> Willy
> 





