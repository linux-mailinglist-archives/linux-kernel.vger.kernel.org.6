Return-Path: <linux-kernel+bounces-417067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1F9D4E84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E3B2843D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A11D89FE;
	Thu, 21 Nov 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVKaI7LL"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A017BD3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198638; cv=none; b=PxfVM3XuOuH/TtodFD2VBR3LqyR8Zbfl91EGQgvXdWXBAh4gbILa8MRzEiUtYua2tqV0ZWtYNDpPJDUVBHbdhgPRP8QFZFQ01YIb60twBHFaysT84XfH7Wb/o9xQqWs5ES9+ZSLXE/R+s9w0h70ZjdXzWmXXVcYlhi+iVmsL4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198638; c=relaxed/simple;
	bh=gY4slTsrzigmIW7W5TPf/5NTUCDpLiT/MxahrSWIQEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERXMn3oHYvb6vd/P5TbkVSbI4t/mprke0hKWi5YocSX47tXm2nVpa9sSmE/GjqLfY6Uiuy3ygLwIl1ie7x+cgCvGXXxWD6uAD34Tq/WSBapZ/3L+15JauqNBZH3PGE4HxFPLuBSpOYoBT6Ux6IaVK9lhb+swSBdwlcAqO8u7UXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kVKaI7LL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so1218815a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732198635; x=1732803435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjYV0f9LV8DKVMMDSPPIZsuPEs8fFiR62vH6BjDoHdA=;
        b=kVKaI7LLN0hNHYNAh64WYFHhT/w/Y54BnpEheuqDNoxlr+b4zAOl37j1X0kbylKOPC
         UM2ldTPj0GT73LAHQTsMOIhz5CS4HREoCHOA4UsMGGTzsatHyUzh4bobxh+1yIJ1enH6
         SIKkgLilkIona/oq9V31Q0VyrPAsTVEmY5JE2ZJbPkXVN5L/u0vItWLw3aKWswwY1fnx
         3QYDFFx+DCiL3x63LNtHyugGB5XOE1bOxqQL1IH0yPdujTeIQethBcRiVyZB3Zym2zvx
         WUzecFQ40n9VhsFcAV/94LdBPx+B3RZgHNP4z7TgWrhqrPiyEYPcGnDEGFFd3Vtf4mUk
         Y5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732198635; x=1732803435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjYV0f9LV8DKVMMDSPPIZsuPEs8fFiR62vH6BjDoHdA=;
        b=BytDsEDPUCKKBIHHN3oIBoeQUbHiZ48OzMKIs5UysAXz5dKQacz7bT98TKCoNOCcyd
         axkk83c7QTWYGoV/7QXDReRwjdDrNR3PXz/DZAFQswZW0hc1gSw3T8Ui7u8CwJnqmeqq
         UTQ1tz9NWVETsbMV26Bem7GcDKuIlraqLSWENMl0ZkSBJMwHYNgliWqowUwAgg+1/ntf
         xVFBafyRVEoDobOsypB9klSxqJq1DG1zqTNh+Nfgvsurtil9GPybbs4kfMsqaTx/r8jz
         2SEd9r4LYyY35YVnWCdRXL2AD3fiP7rDoq72MG7KP8yi2RM+f9Jr/2q7oFrgmkPHqNfV
         nFtg==
X-Forwarded-Encrypted: i=1; AJvYcCVKx6iXGDHY3jVoyy+32RVHJeyoGRdCptqSvTujt38S79CSQHADkGUXfiphsnhEdT9rBj+mxyPJcoAxQrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Kt3/BegLQdHrZC+tjf5JFFDuw8ITs7R3qjW2b/HWgSZFvLVg
	vAu1997ksNlCyCgQ1EtPbA6QDp/4xr8bASHn/GaKJ8bBdbOSOSSwMBSn5Z2hptE=
X-Gm-Gg: ASbGncsYw45s2lSGtOh8m4JD3QXWrINljsz26Pk8zKLTju/Wiwnsf8vacxxev585sc2
	aHowlCTV1HZ2z688RX9syAVhCKWjE+B2ecmvaeKtLkcQ3DWYkHOSiVvmb++1Fy2SZZ7Pg2FB/n2
	G7fKhSdn2P77e5pmXm/RTZWvEIXSQrOCzmhDN/xP1bANW1mgEgAyw5VbBSJFL6FyicROHE4O8Ks
	vNLvvthjoIMVIKUTPc7oUTIhTWv+ZsRs/PAiLKNJpryWvHkRzaajQ4=
X-Google-Smtp-Source: AGHT+IFyOr66P+E7C7fnM/4Z3SPEljF0WWGFDrqoTUQ0MA6Kwx1at3Yb3Tko4ioxPpp2Dhuf/ouQLQ==
X-Received: by 2002:a05:6402:4404:b0:5cf:d5ad:2809 with SMTP id 4fb4d7f45d1cf-5cff4cb51c3mr5195197a12.24.1732198634797;
        Thu, 21 Nov 2024 06:17:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44ef2d7sm1866994a12.19.2024.11.21.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:17:14 -0800 (PST)
Date: Thu, 21 Nov 2024 17:17:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Perego <pperego@suse.de>
Cc: Kees Bakker <kees@ijzerbout.nl>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] staging:gpib: Fix a dereference before null check issue
Message-ID: <47c36187-7315-4a32-802c-4909599e36f7@stanley.mountain>
References: <20241120144653.377795-1-pperego@suse.de>
 <a0807e04-b2c9-4261-9b3f-7660fe258f56@stanley.mountain>
 <6ca90e87-965a-4895-ba72-8144540f6e4c@ijzerbout.nl>
 <b843f8a9-1562-458c-8f6a-c59b1037b756@stanley.mountain>
 <wgcv5wesq3q3xank6elouewntisernnw4agfziqekkeirftx6i@ajucs5yqsvus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wgcv5wesq3q3xank6elouewntisernnw4agfziqekkeirftx6i@ajucs5yqsvus>

On Thu, Nov 21, 2024 at 03:10:02PM +0100, Paolo Perego wrote:
> On Thu, Nov 21, 2024 at 10:37:30AM GMT, Dan Carpenter wrote:
> > On Wed, Nov 20, 2024 at 08:54:16PM +0100, Kees Bakker wrote:
> > > Op 20-11-2024 om 18:04 schreef Dan Carpenter:
> > > > On Wed, Nov 20, 2024 at 03:46:53PM +0100, Paolo Perego wrote:
> > > > > This commit fixes a dereference before null check issue discovered by
> > > > > Coverity (CID 1601566).
> > > > > 
> > > > > The check ad line 1450 suggests that a_priv can be NULL, however it has
> > > > > been derefenced before, in the interface_to_usbdev() call.
> > > > > 
> > > > > Signed-off-by: Paolo Perego <pperego@suse.de>
> > > > > ---
> > > > You need a Fixes tag.  But I'm pretty sure the correct fix is to remove the NULL
> > > > check.
> > > In the whole agilent_82357a.c module there is no consistency whether
> > > board->private_data needs to be checked for a NULL or not.
> > > 
> > > If Dan is correct then it is better to drop the NULL check, not only here
> > > but in a few more places as well. There are at least 10 functions were
> > > there is no NULL check for private_data.
> > > 
> > > Run this command and you'll see what I mean
> > > git grep -3 -e '->private_data' -- drivers/staging/gpib/agilent_82357a
> > > 
> > 
> > I had looked at similar issue in a different driver:
> > https://lore.kernel.org/all/2d99b7a6-f427-4d54-bde7-fb3df5e19e53@stanley.mountain/
> > 
> > Here the NULL check we are discussing is the same thing.  The private data is
> > allocated in attach() and freed in detach().  The detach has no need to check
> > for NULL because we can't detach something which isn't attached.
> > 
> > The other NULL checks are in agilent_82357a_driver_disconnect(),
> > agilent_82357a_driver_suspend() and agilent_82357a_driver_resume().  And there
> > the NULL checks are required because it could happen when the driver isn't
> > attached.
> > 
> > I also did a quick glance through to see if any of the functions which didn't
> > check for NULL should get a NULL check but they all seemed okay because either
> > the board was attached or the caller had a NULL check.
> > 
> 
> Hi all and thanks for the fruitful discussion. 
> 
> > So I think we can just remove this one NULL check and everything else makes
> > sense.
> Please, apologise if I'm too newbie here to understand next step on my
> own. Am I asked to do something, to submit a V2 with the correct Tag or
> the patch is good as is?
> 
> ( No pressure to be accepted, it's just my willing to understand and go
> into the process :-) )
> 

Please send a v2 which deletes the NULL check.

regards,
dan carpenter


