Return-Path: <linux-kernel+bounces-523233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82390A3D3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2701617BA25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27061EBA0B;
	Thu, 20 Feb 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0iFfj7f"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DA1B3927
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041735; cv=none; b=MNitJrdAceSnloZbDpu6TsoUmBL9BRZayETK7guenjdzJpP7O+7ZNQ2RWYEx16FpytfLC+j/kuPwZuDBtkNtTg1K670aznqIfjxDBdD8Rtarxh4zurPEpe8awI/oFzcDHAgBgcpPf96WQs4DGMav3iq6A+F1R37YuKTekmTkXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041735; c=relaxed/simple;
	bh=SdNR4ClrBx/eeZAz7z2iazWjvr1avPuKNfaN72mYIGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH/7XVkhokCaLICWJqLX0AQdSd+g+TAUMc6KEsMD+DZaSG9y3+eUBgTBzh6jtxqbIJnU5A78f/l+WDn7Zc20SgwNNQxrqyBz6/ELzUaqgKstPaw5/80laP51QVaicDJ03aa3Oagjmw2wwIPTGXxDovH5aztzA14OqZrRJ08ON50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0iFfj7f; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso1097687f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740041732; x=1740646532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJy3bOqSsh0t+h28vp9n62Av8VDeBRdvNoL1U3ajQ+A=;
        b=e0iFfj7fvjnif3Xed9oONXHd5vUxnI4oqBi/HggDTRkG0AzjBLZOD5zlaCGo7NtnRA
         JpCklRh6o8O9KCczsE0xot8gUnBO6r/PPA5izLRd2hywwfJyhw/5LTSDyiE86P5muTLD
         p80KPtB9+G4mzwFMd39VpmKTLv//Ssyu3/WNI3eS59AdocyfLAn6bSpgPSrgAzKOqqNf
         /wl9c7wx7PISM66nB/bgf0UEVRKXK5UsDr0xXAMFsQgpYkHfRO2pYeS5oyxVBEZYQC1l
         wI6JQZqJ70oHrsHX4bwBgcxgcPoajzw/NfY918BQ+PHf0yOELbiuvzyTh/lkMYer3Qgt
         3FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041732; x=1740646532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJy3bOqSsh0t+h28vp9n62Av8VDeBRdvNoL1U3ajQ+A=;
        b=lAw64yv1AR4m/ullUg3PYsWcZqX2S6mLGVzDkGqeGaV7RlZIMnukaLoJFJDHJaNUp4
         gDqh64qSCJl71qH68D7KnF1kiHpxOLxQfREGQ2NwTsFJvAjLkTbjv/8hTRXtiF9UoJNT
         alATgyxLOP3+vIJj8or+/Q5LMJyahr4yWRd0kp5gj1DdXVTux22IosIS1evFo9Vg7WI1
         ix3yw4gPTQ+Z4E75o1YEY9fJeJLhfXhSLu0hZnVS5fQKfh6LtnZfwbT0r9BP6DwBJQH0
         V1G50A+qw3Cb5Ejc/s1ZsVYdhstbui/Q5KdJQllMK9ntAsG/Erhc8EBMlE4mTX6YiQka
         XEZA==
X-Forwarded-Encrypted: i=1; AJvYcCXvH1jfIgxr6ptpr2wgwJYL9bwW8SjaL7wxwZ5CX9wk+dJna3IqUs8S28dj0GsTJdriQu9qV39JtbKVgsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0q8NwQ7tMNlQmbbtgJlYZ8uKJ0v8Q3VwVdQCnV2h8kVMoojk
	zNmWoCBoxkbjgCkKoa5aWy0KzRJsu2x6kjcYJcEgkhp3kCISOQzO
X-Gm-Gg: ASbGnctQWdc05EEXWd5/6HnqcSVM9rjn9UwyBC4J4WVtD0dMvysNNYlWCK2VOL23p4S
	vdKR2+zM96rjJ9hod35rxfeSHimF/ocMD9wbjZ3sJ/x5JHonhOlvO9E5cXxTkmoNS1N3avHzazk
	GHaDiVkwOP81Xpu9BoXQufWtTzwbKZhVxjiZZmV2fRB8vouUwo59Jr028mJuYjeZ078bT/TMh8j
	5S/eTFAWrkADGUQ5gsV9MhJG3bJhSExJ+f8HDJ6WXn+LTR30rNWjL+75Ho6fazVanYhO/e04w9/
	LxqN6hGv5fQsb2nLr+6PHVy3P3K7qqM=
X-Google-Smtp-Source: AGHT+IFfnW0cyW8E119bHHz9+mtO1ESWRT3Yf6hjXrVMUeUMEiuamjADqrwKcqa55mog5vcRyrjChA==
X-Received: by 2002:a5d:5847:0:b0:38f:3e0a:ca6a with SMTP id ffacd0b85a97d-38f614991c2mr1920875f8f.2.1740041731399;
        Thu, 20 Feb 2025 00:55:31 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm20239545f8f.67.2025.02.20.00.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:55:30 -0800 (PST)
Date: Thu, 20 Feb 2025 09:55:28 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] staging: gpib: Console messaging cleanup
Message-ID: <Z7buAACkugsEOa13@egonzo>
References: <20250214114708.28947-1-dpenkler@gmail.com>
 <2025021923-leverage-endpoint-c06e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021923-leverage-endpoint-c06e@gregkh>

On Wed, Feb 19, 2025 at 04:48:39PM +0100, Greg KH wrote:
> On Fri, Feb 14, 2025 at 12:46:51PM +0100, Dave Penkler wrote:
> > The GPIB drivers printed a lot of spurious console messages. This
> > was linked to the level of code maturity, often using console
> > messages for debug.
> > 
> > This patch set cleans up the console messaging in the spirit of Greg's
> > recommendation: "When drivers are successful, they should be quiet"
> > 
> > All pr_info's have been removed except for one which is in the module
> > init of the common core driver indicating that the GPIB subsystem is
> > initialized.
> > 
> > All dev_info's have been removed or changed to dev_dbg except for the
> > attach and probe messages in the agilent and ni usb drivers. This is
> > to facilitate the creation of config and udev scripts to ensure that a
> > particular usb device is systematically attached to the same gpib
> > device file.
> > 
> > All custom debug and tty logging has been removed or replaced with
> > dev_dbg.
> > 
> > Error messages where the user can figure out what went wrong with
> > errno have also been removed, particularly timeouts and interrupts
> > during reads and writes which can occur quite frequently uneccessarily
> > cluttering up the console log.
> > 
> > The patches are 1 per driver.
> 
> All but 4 of these applied, can you rebase and resend the remaining
> ones?
> 
> thanks,
> 
> greg k-h
Sure, thanks.
(Could only find 3 that were not applied, will send those)
-dave

