Return-Path: <linux-kernel+bounces-220043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10890DBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3421BB21AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5E15ECDF;
	Tue, 18 Jun 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="RIeH8pia"
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6047773
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736769; cv=none; b=kqog1ZiZG2yzpYJYXP2mX0B5DwoYvYuKqEwKzzVOAKkQwE+pFRaC4lwqXaGa781NUyBTY4Ohw0gdYx9UDoggBQrhbsztX4kQQVy6iEtrDc/OWQUZkcZxGydXPDVFkRaIknR/vjza6iPsmsDclNadbHl7SS7UWz+0x/DvYPh5PUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736769; c=relaxed/simple;
	bh=WzcRlgSLD4jtKwMx/SoUegItGoTx6IczvRxW6XmbGQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il7fAlNWroAaTTOFe+qhgr1FjCdryb3N20amCF6YEf3/r2ZcBa0ZsziSUeXXUOe5MBdfp4viY2jIJknGF5Hrnx1iKuDoDpVp5KSymOEyOdxI2l5kTdNXyQtJAzIsLFmTqlve3BDJ8bNqa8+a0ysFw6ENMGIOzxMhCNrzyWtmefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=RIeH8pia; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-3737dc4a669so23348435ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718736767; x=1719341567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+VIB/wrRtyRLESy7hxRzVO/Bqhf5JtVy9rWt3ZoFVI=;
        b=RIeH8piaVLBPcdckOsDdqCD5rUTxK2iTpBFy61IjcP902QJCp7xWTvc6HY4KrbZCIP
         nFFkzpWMXpgY4QXdOCs1T53UshUS+Qx9Wq0J3/HSMTEHmY0v5rsRogS/bC2Lgx6wWIcT
         9mYQ0M6yosagSkcPubfjR4GMovsBJ0N88MiDBljPMS7COjwR/qtEE5v8bRXyuIU86xPT
         9/baosBTbhA71xpccUhNACSsJBpaoo6Uj1OsGY7i4eEafZ1tD1nHXx7nhjd7tqPk3WqJ
         Er3vNLy3SSV1qozOETgFmub3le+DT0TidcpMd3FPpMoc9Ngxwc2n2iGLidL6TJ6CIwml
         pxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736767; x=1719341567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+VIB/wrRtyRLESy7hxRzVO/Bqhf5JtVy9rWt3ZoFVI=;
        b=VRMvv5q7mJjwRqZjdsDzEkNhOwuuu2m3ykZCVuO02olkL8NJd4fIw0tmVEMrs57AnA
         Wyc1uIi7yuEcoS1h/Z2pk6qKFrwAaCDgEb2rcW1YieB8RcDsEl+S+y7M6jb3r757GtHt
         Kc/KcQRBUWyrEIWdTlr0o19zs/76OkmGk2oY+fUNJFQVxZedIxnWGATnbKdQGFR2xNeq
         UXWZcZs53TQhxp96VjPSOHz0+tP4EvpKlUK1W8mnGAW4Ms+CcaIE58Zw+srnMVWbcU8r
         oKZP0r9C+hQcESTLAZCksmtCX/YhfzizZ05k5TWDIQljlAVCI8MlH3tqTpegunkwMJai
         nAjw==
X-Forwarded-Encrypted: i=1; AJvYcCXHQq+zkiAwR9RIIflp5oKRxGSxownJkI4DiSozk0FXvvqOdxaosF3tejw7s+jhzBLN5QQ/g3R8EOI1SSqL8xvTvpTnBzQz+C1zevUy
X-Gm-Message-State: AOJu0YxdNXW2LkEOGT8P6VGswKuLSKyDirW6c0mJ8DK2cFyZr1N+vrBf
	DLlVmVGolymiJTDR802PLfVfFf6+mD5xsP4hv3kDsc4uwAe4ZJmLCynXcr78TsY=
X-Google-Smtp-Source: AGHT+IFeTq+KIGVEjDyxRXOyQtQqAiFX555xdsv+CQHaKXl4oB6K9xFej6wgoxRbjaDCvBuuYoej1A==
X-Received: by 2002:a05:6e02:1e02:b0:373:8b80:eb41 with SMTP id e9e14a558f8ab-3761d6564c7mr5198455ab.1.1718736767445;
        Tue, 18 Jun 2024 11:52:47 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3761d0f8579sm908725ab.17.2024.06.18.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:52:47 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:52:44 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnHXfLEwk2uRbg58@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>

On Tue, Jun 18, 2024 at 01:35:57PM -0500, Mario Limonciello wrote:
> On 6/18/2024 13:30, Aaron Rainbolt wrote:
> > On Tue, Jun 18, 2024 at 12:09:19PM -0500, Mario Limonciello wrote:
> > > On 6/17/2024 21:54, Aaron Rainbolt wrote:
> > > > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > > > 
> > > > The _OSC is supposed to contain a bit indicating whether the hardware
> > > > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > > > be considered absent. This results in severe single-core performance
> > > > issues with the EEVDF scheduler.
> > > > 
> > > > To work around this, provide a new kernel parameter,
> > > > "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
> > > > CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
> > > > properly detected even if not "enabled" by _OSC, allowing users with
> > > > problematic hardware to obtain decent single-core performance.
> > > > 
> > > > Tested-by: Michael Mikowski <mmikowski@kfocus.org>
> > > > Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
> > > 
> > > This sounds like a platform bug and if we do accept a patch like this I
> > > think we need a lot more documentation about the situation.
> > 
> > It is a platform bug, yes. See my previous email,
> > https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org/T/#u
> > (I meant to send this email as a reply to that one, but failed to do so.)
> > 
> > > Can you please share more information about your hardware:
> > > 1) Manufacturer?
> > 
> > Carbon Systems, models Iridium 14 and Iridium 16.
> > 
> > > 2) CPU?
> > 
> > Intel Core i5-13500H.
> > 
> > > 3) Manufacturer firmware version?
> > 
> > The systems use an AMI BIOS with version N.1.10CAR01 according to
> > dmidecode. This is the latest BIOS available from the manufacturer.
> > 
> > > 4) If it's AMD what's the AGESA version?
> > 
> > Both affected systems are Intel-based and use heterogenous cores, not AMD.
> > 
> > > And most importantly do you have the latest system firmware version from
> > > your manufacturer?  If not; please upgrade that first.
> > 
> > We are using the latest firmware. (We're trying to work with the ODM to
> > potentially get a firmware update, but since this affects more than just
> > us and a firmware update may not be possible for everyone, this would
> > likely be worth providing a kernel-level workaround for.)
> > 
> > I can easily provide more detailed information - would the full output of
> > 'dmidecode' and 'acpidump' be useful?
> 
> Does your BIOS offer any options for these?
> 
> Intel(R) SpeedStep(TM)
> Intel Speed Shift Technology(TM)
> 
> I believe you need those enabled for this to work properly.

Neither option is available in the BIOS settings UI, however our ODM
confirmed that both Intel Speed Shift Technology and Intel Turbo Boost Max
Technology 3.0 are enabled by default. They did not mention SpeedStep,
but I assume SpeedStep is working since frequency scaling in general
works and the kernel patch fixes the issue.

In case it's helpful to know, when booting without the kernel patch or
without 'processor.ignore_osc_cppc_bit=1' set, neither of
'/proc/sys/kernel/sched_itmt_enabled' or
'/sys/devices/system/cpu/cpu*/acpi_cppc/' exist. When booting with the
patched kernel and with the kernel parameter set, the 'sched_itmt_enabled'
file appears and the 'acpi_cppc" directory for each CPU appears.

