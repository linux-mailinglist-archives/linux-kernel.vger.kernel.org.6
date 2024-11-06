Return-Path: <linux-kernel+bounces-398626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D09FC9BF3D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA10B20C12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A62064EC;
	Wed,  6 Nov 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="ztpL3YL6"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C7205129
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912502; cv=none; b=quYizVQjPZuu+vhNPbAJi5MJkJh9tvBu2j1MUL8OLWrPS2E2a2MV9GhsW+m7fgRm/x6WZoWssoZH6WV1c0xK7VhM4+hUbXlqe9mcSSdNBq9a8s9nZPTfcGoZ0i5ovRObyH6+YUbqEjZlnCX+CxNGN6QWXJa65LM2Lj2cpvL+63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912502; c=relaxed/simple;
	bh=dCqUWVAxFXnv42ES2FDGsclhdATI2oq7tHXpixuSIFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImM0cCWFpPd6qsdfK5bUKx2aeIsxf+1vLfGpCQ5MBVSEnww+3sjFkKORSViWtksE3r4rtLCzlMjHYXuTxpbtjHwsvj2QyIadMb2UNQ3rWG+9d2+enNFe1Hc8l1K7wf5n5WdY3pIGH6byn1Dix8OtCeIo9IK9LeWKw/OghEkuVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=ztpL3YL6; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3aeb19ea2so289325ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1730912500; x=1731517300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=op0VqxjjyKbJWNclEndGjJgNBVKWAngrK0jv+MxYK+M=;
        b=ztpL3YL61PWre2O/W8AI0XYkV6LWfEmInFJpog7qO5XuaSvE6ZS/qKXg81dDLjGvMd
         mKJSfTIwt1P2T69EH3g8izca0BIk2WG/Moq5ip6/AabOE4BaLxmKJHHBYR9moni706Zp
         A2O0KbKkq/g+jsf4tKFTCGubkQ2I9QSuxWlh5MnudPeHlE8mlY0+Zw8e+3gGsX4bVDbY
         NzL6091qQrMpDdgRZ4G7jeVnm0zLxWO7O+hsUSk3NfTCx69JH/kXF3AX79o1MuMKulC0
         DNgIZzsARwFpURiCEWJgco7Bjc65j74cGbiXpDE6KLgQfUusj/EtmkZtTRtsnwinErPz
         pkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912500; x=1731517300;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=op0VqxjjyKbJWNclEndGjJgNBVKWAngrK0jv+MxYK+M=;
        b=JncKPSDTWfMIelVspOCq9RkRtcV+otghmQt8DTPC/joo3dSb60WRJqQdWLPviLFrkb
         ue68uKgUhHjtGz9p0C7y+w5IUeVdxuhqJBhePuBo9b4L2Vu+8hq9vex1weKKOQzDG7MI
         6N+YNz6MNXPsG6yYHsbZdyzOG/DlM05HCsNbup8UZP0xFOYyVhvpApKhvhAwnQjlI4ZV
         fTKRO7CTP6AhO6Nj/o6mbBS+atGy/0gua2xXTLNqmlh7vb8ma1I5M2hxmftSDm6vNkwu
         S0VpLmsMlFbBiUzcg11XBqXAOSsM9dW7O092c4pMPjeTyeHOcJQXqEVXfL6HrcVp09vt
         caVA==
X-Forwarded-Encrypted: i=1; AJvYcCX0XbxVZP8nl+CoTumC0nJqg+nCmLI0LuL+0ZLbrVcizHN3d7GWhPYJKwb3ADcNJ7iRxiQ7lxD7gOE2Q68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zu5HompnA4s6UcYEgA+uV+4YDZ9v6zPLYQJcztZAYGkrK5dy
	38XAfzKYYJpy00lXP4P227UcbfNvSb2oZdgnozYsFJkQn5gJpB9OkGtEMzTUwIA=
X-Google-Smtp-Source: AGHT+IHrgEte4B9b/UBa+XLmWhe+r+AV3JVWbrzbFsSpvtGtulthtgr4BgHksHJ2AMoNKT1NC7SN4A==
X-Received: by 2002:a05:6e02:742:b0:3a6:c023:7e30 with SMTP id e9e14a558f8ab-3a6c0237f72mr163574695ab.7.1730912498556;
        Wed, 06 Nov 2024 09:01:38 -0800 (PST)
Received: from kf-ir16 ([2607:fb91:759:8d6:e1a2:ca5b:827b:eda7])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6a97b009csm35012775ab.4.2024.11.06.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:01:38 -0800 (PST)
Date: Wed, 6 Nov 2024 11:01:34 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org, Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241106110134.1871a7f6@kf-ir16>
In-Reply-To: <20241106060635.GJ275077@black.fi.intel.com>
References: <20241011183751.7d27c59c@kf-ir16>
	<20241023062737.GG275077@black.fi.intel.com>
	<20241023073931.GH275077@black.fi.intel.com>
	<20241023174413.451710ea@kf-ir16>
	<20241024154341.GK275077@black.fi.intel.com>
	<20241031095542.587e8aa6@kf-ir16>
	<20241101072155.GW275077@black.fi.intel.com>
	<20241101181334.25724aff@kf-ir16>
	<20241104060159.GY275077@black.fi.intel.com>
	<20241105141627.5e5199b3@kf-ir16>
	<20241106060635.GJ275077@black.fi.intel.com>
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

On Wed, 6 Nov 2024 08:06:35 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi Aaron,
> 
> On Tue, Nov 05, 2024 at 02:16:36PM -0600, Aaron Rainbolt wrote:
> > On Mon, 4 Nov 2024 08:01:59 +0200
> > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > 
> > ...snip...
> >   
> > > Okay, thanks again for testing!
> > > 
> > > It means disabling adapter 16 in DROM is actually intentional as
> > > that is not connected to the dGPU and so makes sense.
> > >   
> > > > * Boot the system up, nothing connected.
> > > > * Wait for Barlow Ridge to enter runtime suspend. This takes ~15
> > > >   seconds so waiting for > 15 seconds should be enough.
> > > > * Plug in USB-C monitor to the USB-C port of the Barlow Ridge.
> > > >   Screen shows in log, screen wakes, but then no signal is
> > > > received, and no image ever appears. Screen then sleeps after
> > > > its timeout.
> > > > * Run lspci -k to wake up the monitors. Once this is run, the
> > > > display shows correctly and is stable. Adding another USB-C
> > > > display after this also works correctly: It is recognized and
> > > > lights up in seconds to show the desktop background, and
> > > > remains stable.
> > > > 
> > > > Notice that pre-6.5 kernels work fine with Barlow Ridge, which
> > > > implies that new code is causing this. It may be new support
> > > > code for tbt capability (and therefore pretty much required).
> > > > But regardless, it's still new code. With the current patch, we
> > > > can run a udev rule that enables hot plugging that likely
> > > > always work, or (worst case) at least empowers the customer to
> > > > refresh monitors by clicking a button.    
> > > 
> > > We definitely want to fix this properly so there is no need for
> > > anyone to run 'lspci' or similar hacks but because I'm unable to
> > > reproduce this with my reference Barlow Ridge setup, I need some
> > > help from you.
> > > 
> > > You say with v6.5 it works? That's interesting because we only
> > > added this redrive mode workaround for v6.9 and without that the
> > > domain surely will not be kept powered but maybe I'm missing
> > > something.  
> > 
> > 6.5 is *broken*. 6.1 works correctly, but that's probably because it
> > doesn't have Thunderbolt support for Barlow Ridge chips at all. I
> > suspect this is because the chip is just acting as a USB-C
> > controller, and that works just fine without the Thunderbolt
> > driver.  
> 
> Exactly so while it "works" for this particular case all other cases
> will not pass.
> 
> > > I wonder if your test team could provide log from v6.5 as well
> > > following the same steps, no need to run 'lspci' just do:
> > > 
> > >   1. Boot the system up, nothing connected.
> > >   2. Wait for ~15 seconds for the domain to enter runtime suspend.
> > >   3. Plug in USB-C monitor to the USB-C port of Barlow Ridge.
> > >   4. Verify that it wakes up and, there is picture on the screen.
> > >   5. Wait for ~15 seconds.
> > > 
> > > Expectation: After step 5 the monitor still displays picture.
> > > 
> > > If this works as above then I'm really surprised but if that's the
> > > case then we can maybe think of another approach of dealing with
> > > the redrive mode.  
> > 
> > We'd be happy to run this testing on the 6.1 kernel if it would be
> > helpful. Will that work, or is 6.1 too old?  
> 
> Unfortunately that does not help here. I need to figure something else
> how to detect the redrive case with this firmware but first, does this
> work in Windows? I mean if you install Windows to this same system
> does it work as expected?

It does work as expected under Windows 11, with one major caveat. We
used a Windows 11 ISO with a setup.exe created on April 05 2023 for
installing the test system, and after initial installation it behaved
exactly the same way as Linux behaves now (displays going blank soon
after being plugged in). However, after installing all available
Windows updates, the issue resolved, and the displays worked exactly as
intended (the screens are recognized when attached and do not end up
disconnecting after a timeout).

Would it be helpful to test on Windows 11, and provide a report and
system logs?

