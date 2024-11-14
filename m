Return-Path: <linux-kernel+bounces-409676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2999C8FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E50281A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AB181334;
	Thu, 14 Nov 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="GVLjHCf/"
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60A15DBB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602492; cv=none; b=JmQlxIXmsWkn1JqLadbV4VnG67HvRDF4rqPPXFATEYpIv7wHuFC7DWsgoavYlKlVchh+gf6b1VW9C48j3cyHhA4IkmIulCCqGwuUZEi28oabaQmC22CO7/vXRDfKkFFu8ZAZtnMC546DHK09eSKAavGt/UzEmXAJEfeeMiJyF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602492; c=relaxed/simple;
	bh=qFIEaL5IReucQlViHo26Nnec3Y60USrR6Ex1wLhrzx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTg3DaGlW6Qv6dQmtcpuxuSDWYZsAqE7VcdicI7bH0nvQonTpwX+ce9+sZ7HrP5HN2/hv+7SPL5UsR5Mp6zN1xrGgGrmg0w0WG2MzUrfeacoA5gS6iFsR9ymTLbR8AerqmAk2G8DyBDO4gRKchdF7ZAvOLry9GrU8NeX0x6fwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=GVLjHCf/; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e30cef4ac5dso925208276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1731602489; x=1732207289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SL08LjacC7rUX7MCRD0qhYmVjxHSE5H188E8poMRgtM=;
        b=GVLjHCf/LmVVqAI3f8zOudSGioRnSNj1qABak04qk8H64GOReuaqInZuXOFhlOQ49P
         +6/6DopY68lfmNDedF993JqAzXByWEWQmSouZf8gMV3ajOad7VDFRQx9N9ckFmT8WqRa
         hcwV7mY5WyOh9mE6Y2FESbLWYlNOIgKZfUZxibRJQv1TaVPEF3fcykKHzus3CxFiLQMc
         4fKhBIfUaHeOKB8BiE+hiVWbkOAn+daSHHAgAoWHNgDrOkPYHmgeC4YLEGDQO5DGF6AZ
         a2jbfRNDZRQ0YqauYNYbUHRQtWgaD7CAK6bZTMJrj0mZ3WxbTpwPu0l5wU4gIRq3URtz
         1Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602489; x=1732207289;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SL08LjacC7rUX7MCRD0qhYmVjxHSE5H188E8poMRgtM=;
        b=mjDRjxCJPneSlO6u1QFaSbwyhvi2rmdUyzdzZ0ZwFv45s2j9uLdusiQVqxHKA30k0l
         gYowgg+ueasfigs7QZoGLvVNbhTf5rj0lajJb29OapTmDvojmEt4XtZpuX2nmWzpUGtv
         ID78xTEPzwUzRJOteydhMElWsVyYd1Z7fLc0jeIh2NLs8Mz36x08VPhkd3ehOPmjbX1+
         DLDhvLJ0jIZkquOuLCq/u6kP5wpBs0HN1trBZehOD8hNr+P/cqez0tuutTgKJrUMdFQI
         Oxhp3Vl0h1jZzdWC9NArRpT2TXeHXhYeT4rvJ/mv0MCmoP0jH65NVNlETRYYMSldWikN
         NsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK61CrGkikb2okp7quupowuoNYeWOAxjmDH70CmB7Y3OhHdOTxkIPB2/S0hbJlOIqu3bM7suE1VZdCD/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcgYH3IrZHD+Zk9FwqY5/97e5jQ8rb7pewWYBb7AIPkgNbVjt
	lZZEIS0GjKMU/W5Wes/ZalfN0+2Lbj9GcXy1l7PNGr86CpC5zn3WBou8a2eGgFE=
X-Google-Smtp-Source: AGHT+IEaP6fMi31v7hWmEvcvQvJvm61ChjgveUhIvu1IZuBu1iKqTOGRYw+1t45B97aO2vUW83NDGw==
X-Received: by 2002:a05:6902:b1d:b0:e29:48ad:b845 with SMTP id 3f1490d57ef6-e35dc547994mr9707581276.22.1731602488742;
        Thu, 14 Nov 2024 08:41:28 -0800 (PST)
Received: from kf-ir16 ([2607:fb91:759:8d6:15e3:d4fb:c375:8d87])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152caccdsm399688276.14.2024.11.14.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:41:28 -0800 (PST)
Date: Thu, 14 Nov 2024 10:41:25 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org, Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241114104125.00a02eb1@kf-ir16>
In-Reply-To: <20241114115136.GB3187799@black.fi.intel.com>
References: <20241031095542.587e8aa6@kf-ir16>
	<20241101072155.GW275077@black.fi.intel.com>
	<20241101181334.25724aff@kf-ir16>
	<20241104060159.GY275077@black.fi.intel.com>
	<20241105141627.5e5199b3@kf-ir16>
	<20241106060635.GJ275077@black.fi.intel.com>
	<20241106110134.1871a7f6@kf-ir16>
	<20241107094543.GL275077@black.fi.intel.com>
	<20241111082223.GP275077@black.fi.intel.com>
	<20241112164447.4d81dc3a@kfocus.org>
	<20241114115136.GB3187799@black.fi.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 13:51:36 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi Aaron,
> 
> On Tue, Nov 12, 2024 at 04:44:47PM -0500, Aaron Rainbolt wrote:
> > On Mon, 11 Nov 2024 10:22:23 +0200
> > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >   
> > > Hi,
> > > 
> > > On Thu, Nov 07, 2024 at 11:45:44AM +0200, Mika Westerberg wrote:  
> > > > Hi,
> > > > 
> > > > On Wed, Nov 06, 2024 at 11:01:34AM -0600, Aaron Rainbolt wrote:
> > > >    
> > > > > > Unfortunately that does not help here. I need to figure
> > > > > > something else how to detect the redrive case with this
> > > > > > firmware but first, does this work in Windows? I mean if you
> > > > > > install Windows to this same system does it work as
> > > > > > expected?    
> > > > > 
> > > > > It does work as expected under Windows 11, with one major
> > > > > caveat. We used a Windows 11 ISO with a setup.exe created on
> > > > > April 05 2023 for installing the test system, and after
> > > > > initial installation it behaved exactly the same way as Linux
> > > > > behaves now (displays going blank soon after being plugged
> > > > > in). However, after installing all available Windows updates,
> > > > > the issue resolved, and the displays worked exactly as
> > > > > intended (the screens are recognized when attached and do not
> > > > > end up disconnecting after a timeout).
> > > > > 
> > > > > Would it be helpful to test on Windows 11, and provide a
> > > > > report and system logs?    
> > > > 
> > > > Unfortunately, I don't know anything about Windows ;-)
> > > > 
> > > > However, I asked our Thunderbolt hardware/firmware team about
> > > > this, if they have any idea how it was solved in Windows side.
> > > > Might take a couple of days though.    
> > > 
> > > While waiting for this, I wonder if you guys could do one more
> > > experiment? I would like to get the traces what is happening there
> > > (hoping something pops out there). Following steps:
> > > 
> > >   1. Download and install tbtools [1].
> > >   2. Build and install the kernel with my "redrive" patch.
> > >   3. Boot the system up, nothing connected.
> > >   4. Wait until the Barlow Ridge is in runtime suspend (so wait
> > > for ~30s or so)
> > >   5. Enable tracing:
> > > 
> > >     # tbtrace enable
> > > 
> > >   6. Plug in USB-C monitor to the USB-C port of the Barlow Ridge.
> > > Do not run 'lspci -k'. Expectation here is that there is no
> > > picture on the monitor (in other words the issue reproduces).
> > > 
> > >   7. Stop tracing and take full dump:
> > > 
> > >     # tbtrace disable
> > >     # tbtrace dump -vv > trace.out
> > > 
> > >   8. Send trace.out along with full dmesg to me.
> > > 
> > > Thanks!
> > > 
> > > [1] https://github.com/intel/tbtools  
> > 
> > Testing done as requested. Notes from tester:  
> 
> Thanks!
> 
> > * I verified lsmod |grep thunderbolt which showed module.
> > * When running sudo ./tbtrace enable, output was Thunderbolt/USB4
> >   tracing: Enabled.
> > * When plugging in monitor, it wakes the backlight, but there is no
> >   image. syslog shows it as LG monitor controls. The monitor reports
> >   "no signal" and eventually turns off the backlight to save power.
> > * When running sudo ./tbtrace disable, output was Thunderbolt/USB4
> >   tracing: Disabled.
> > * Output was save using tbtrace dump -vv > trace.out and sudo dmesg
> > > trace.dmesg. trace.out is an empty file.
> > 
> > ---
> > 
> > (Yes, that's correct, trace.out is empty. I attached it nonetheless,
> > but it's a 0-byte file. I'm guessing the Thunderbolt chip probably
> > didn't come out of suspend?)  
> 
> Yes, that's possible and this could explain the Linux behaviour but it
> does not explain why it works in Windows. Also the dmesg is full of
> stacktraces, not much else.
> 
> I got reply from our experts. They say that we are expected to get the
> DP IN unplugs every single time we enter redrive mode. There is
> nothing "special" added to the Windows side for this either so there
> is no real explanation why it works in Windows and why we see this in
> Linux. What they also wanted to check is that with the "production
> quality" Barlow Ridge firmwares this is not expected to happen and
> yours is in 14.x so is this some pre-production hardware that you are
> dealing with or this can be purchased from somewhere? Where did you
> get the firmware?

This is production hardware (specifically Clevo's X370SNW1-G and
X370SNV1-G laptops), available for purchase from Sager, XOTICPC,
Schenker, likely many other resellers, and our own website
at https://kfocus.org/spec/spec-m2.html (with a tool that allows users
to work around the bug). The firmware is baked into the hardware
provided to us by our ODM, and for the sake of stability we do not
modify any firmware on the machines with the exception of applying BIOS
updates provided to us directly by the ODM. They appear to get
their firmware directly from Clevo.

We have requested an updated BIOS from the ODM. If one is available, we
will upgrade and run the tests again.

Thanks again for your help!
Aaron

> Thanks!


