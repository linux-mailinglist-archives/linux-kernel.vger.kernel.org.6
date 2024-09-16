Return-Path: <linux-kernel+bounces-330554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D454497A014
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DB41C2184E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF4014B94C;
	Mon, 16 Sep 2024 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="bAkDwGPx"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F254D8C1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485186; cv=none; b=mUdWA2s6WvCRIBVGnbVzfYYiRw78mzkQGbhe4K/x2sT34Aa7Km0w0be3hhmg+A1bicuiu2pswu8fRKTshcBi7KjV4CzYY+pdAoqCd011wIvnDNR/mWrQtqOsv7OV6AbbSCeGVHA/yvhX+C8/pjKuvkmb/YsACS/zYRco3DxfmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485186; c=relaxed/simple;
	bh=bYd0WkktXWILmdHEr7/n4AePAmpjHleyf7hXLz7ISLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRVR3dhvFNKFgUoRBkiMZZuMLnRJ2KJeTqpcMxl3m2EeQRE1rJ2p0b3WllHxaM2fqnO4fEM02vMNTdheKI67de1GRPi6FhdmTkGu1Nh1MEQ+8HdKj1iIdgjhpgugvGTOMLZBZ/m3sKnJx3x68UKFq6S2i2tQSGJWvkoYZYpIJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=bAkDwGPx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=jIjlG3JWvYxItnNfDKKGYD5uMeq6hDLaQ9Ki3wJz/5k=; b=bAkDwGPx2to7Ctep
	EOe2egZhCojhvmQjUCLAivjavi2Mm+KwbniUiB17E3N8BgOII2gay8h0kHxzPj13WjRpoZ74xnyvv
	JW64fclcUBrm+X2LSP0aEAqATYjJHOuhTv1RyqoKbqC1l57/Hg9s2RxXI5aseggAQ5nI6yOYmNyYT
	2L7iGXe7hJrjlT9H1KJjX6TlHkMdkH3oaH+9QiWCH1Av8HZMAiSdacz6yG2a+O7spseNqyw7ixceB
	IEfXrCuwo7XwYmXwJAVxWL9dXjAX/aSXEEfORwiTrnT1Q1ey8q/ivo2G5u7z3dYM/f/qZG61tEYbL
	0PZ78tbBE5UST4WIgw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sq9f5-005wLj-01;
	Mon, 16 Sep 2024 11:12:55 +0000
Date: Mon, 16 Sep 2024 11:12:54 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bob Gill <gillb5@telus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 6.11.0 crash on X startup
Message-ID: <ZugStvRPjdmQmMUx@gallifrey>
References: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
 <b955ec60-081d-4194-8688-b49ff206ea1d@telus.net>
 <aae5a0a4-4d65-43a0-a793-b95096e9ed98@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aae5a0a4-4d65-43a0-a793-b95096e9ed98@telus.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:12:06 up 130 days, 22:26,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bob Gill (gillb5@telus.net) wrote:
> Addendum: I have a portion of /var/log/syslog of the 6.11-rc7 kernel, which
> contains a coredump, and
> 
> another line: Sep  8 20:13:06 freedom kernel: [  566.359456] ACPI:
> \_SB_.PCI0.SBRG.ASOC: Device cannot be configured due to a frequency
> mismatch
> 
> any takers?

Not my field specifically; but I think a dmesg from the working one
and the failing one to compare would help people.

Dave

> 
> On 2024-09-15 14:59, Bob Gill wrote:
> > So 6.10.0 runs ok.  6.11.0-rc1 was the first kernel that started
> > crashing.  Every rc after, including 6.11.0 all crash.
> > 
> > By that I mean it seems the startup is ok, but when it comes to the X
> > server, when it tries to start, it crashes (and takes everything else
> > along with it).
> > 
> > I ran recovery kernel, enabled networking, dropped into terminal.
> > 
> > service --status-all | grep lightdm gave:
> > 
> > [ - ]  lightdm
> > 
> > Portions of Xorg.0.log:
> > 
> > cat Xorg.0.log | grep EE
> > 
> > [    61.679] Current Operating System: Linux freedom 6.11.0 #1 SMP
> > PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024 x86_64
> >     (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
> > [    61.809] (EE) systemd-logind: failed to get session: PID 2028 does
> > not belong to any known session
> > [    61.913] (EE) open /dev/dri/card0: No such file or directory
> > [    61.913] (EE) open /dev/dri/card0: No such file or directory
> > [    61.914] (EE) Unable to find a valid framebuffer device
> > [    61.914] (EE) open /dev/fb0: No such file or directory
> > [    61.914] (EE) Screen 0 deleted because of no matching config section.
> > [    61.914] (EE) Screen 0 deleted because of no matching config section.
> > 
> > 
> > From the terminal, I can't run 'service lightdm start' and get back to
> > any state.  pressing ctrl-alt-(f1-f9) does nothing. Pressing the
> > caps-lock button on/off on the keyboard stops responding immediately. 
> > Even the power/reset buttons on the case do nothing.  I have to hit the
> > power switch.  The kernel crashes hard.
> > 
> > My graphics hardware (taken from 6.10.0):
> > 
> > inxi -G
> > 
> > Graphics:
> >   Device-1: AMD driver: amdgpu v: kernel
> >   Device-2: Conexant Systems CX23887/8 PCIe Broadcast Audio and Video
> >     Decoder with 3D Comb
> >     driver: cx23885 v: 0.0.4
> >   Device-3: Razer USA Kiyo Pro type: USB driver: snd-usb-audio,uvcvideo
> >   Device-4: Realtek RTL2838 DVB-T type: USB driver: N/A
> >   Display: x11 server: X.Org v: 1.21.1.4 driver: X: loaded: amdgpu,ati
> >     unloaded: fbdev,modesetting,radeon,vesa gpu: amdgpu resolution:
> >     1: 1920x1080~60Hz 2: 1920x1080~60Hz
> >   OpenGL:
> >     renderer: AMD Radeon RX 6500 XT (navi24 LLVM 15.0.7 DRM 3.57
> > 6.10.0-rc7+)
> >     v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.2
> > 
> > 
> > There is a weird line from /var/log/Xorg.0.log.old:
> > 
> > [   299.900] (++) using VT number 7
> > 
> > [   299.900] (II) systemd-logind: logind integration requires -keeptty
> > and -keeptty was not provided, disabling logind integration
> > [   299.908] (--) PCI:*(4@0:0:0) 1002:743f:148c:2415 rev 193, Mem @
> > 0xd0000000/268435456, 0xcfe00000/2097152, 0xfb700000/1048576, I/O @
> > 0x0000a000/256, B
> > IOS @ 0x????????/131072
> > [   299.908] (--) PCI: (9@0:0:0) 14f1:8880:0070:7801 rev 15, Mem @
> > 0xfbc00000/2097152
> > [   299.908] (II) LoadModule: "glx"
> > 
> > I don't know why the BIOS line looks like: BIOS @ 0x????????/131072
> > 
> > Is that normal or did it not find it?
> > 
> > 
> > Sure, its a corner case.  I might be the only one on the planet with
> > this problem.  Or maybe not.
> > 
> > I have been using a standard .config for building kernels for a while
> > now.  Please reply to me directly as I'm not on the list.
> > 
> > Bob
> > 
> > 
> > 
> > 
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

