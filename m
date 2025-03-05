Return-Path: <linux-kernel+bounces-547653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481FA50C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32283B040F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D882561BD;
	Wed,  5 Mar 2025 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd29LuLx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E492561B8;
	Wed,  5 Mar 2025 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204566; cv=none; b=snDU2iUx2or62K+L0z9Hpsa4Uim0vs8x5tHnr6xrVnbrOKcGkC3j6aN+kXVZrFR2mOjUHepqS0aBVBb9yRRquwvaOMm6/RcBRRHPF2Taw19ZXcgxx3Ter1+tMzT9RB/udIx3s6txDsUQciWViYavuso2Uz6BXX26uHRX0JjJnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204566; c=relaxed/simple;
	bh=UnaG/Y3D2RaEknxGey8mFGsnuniQGtB239GqK+8Ei7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXsoKLnsM8myU6zYJd1pA8mXAST3jDvcXj5XA+dV6cpxSCFL6O/4/85xWWKpZCoE41+PFyXqCvfmZaoSffPD566zsjmmGIpGzTNv40T0ILc/cpuBdTelTmHIixzfIGGuSBrTisF/mYNqrfzwdE4x6rIJyIpRkyRL6bSqUGBEC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kd29LuLx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390e3b3d432so4792195f8f.2;
        Wed, 05 Mar 2025 11:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204563; x=1741809363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obQQoluSZXQiJyFNJHehlGp6Bxo7iUgFTG6ZT/ix8QI=;
        b=Kd29LuLx2M7WX/iALMjoWRlshEhGaL5FlyXMAAtCOqBHXQjw/yFZ/ETm469sfK2WZs
         ezpKhWeIjB8r1cOxvMzD2WA6TjbYAfk3F9l6IQXWCHV8N6o4aslM0IwavlAMtD3FAGQ/
         viGgc3vQWDAq2nin/NbhQVVrcPsxoNrVlus3toUEWIQN1f6armwIJSf6YPExxre3VPMv
         BNYwUyg0hK9AHOd/YDt2KW2q/GwoiFraj0QlkhuIqNaBmuFBtrEVcE1SFMVELQEDVkCk
         hs1F7TIIlyH7Wd+1yuagFuEXc8lcN2wGF+yIJW2JYPBuLtzpjrHbw0bvu82m+1a2ZHbr
         G1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204563; x=1741809363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obQQoluSZXQiJyFNJHehlGp6Bxo7iUgFTG6ZT/ix8QI=;
        b=a5fDnYd/UPVc3Fl/MxLdV+udDY2VIt+jdn1z9fjENUGjXbevYYCjQhCBB/efiMScnv
         lppwcpxkztoNHyGHd/ZIAqaSiGW04h3w76iW6QcqVzMjEG0DHFkr5eALYN5akYa9GVAq
         P8Ai0KCNdPVe93XaDh+VhmyLdDVoT7GQL+iSS7AxataBs6dJ62KSsOFh6ymNEyMc00xA
         /Ske2fAAWy9E6Fdo6eGq7UmtZRFyNqAWVS+VH1YdDsAiXaXZoEk3iX2x6bkHYwi541Uo
         8K4v9+OLngzz7EXMkaTQGql5QEgihPev21sNrFQzfxArHgN4gxpT47Juncweb1pFMyUy
         b2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVT9LU8/8TTXN0vvf0i61++2Bj11/eNEvkJuUWHZPnfLy/n4GhiKpJDN8ktHGHGO1ztU+z26WjgLOvhDSs=@vger.kernel.org, AJvYcCXTkcLXUDS3bFYsIxroVTQZWoE0Wv1p08PMKqmpKKMRkvamsOPtpKvigzqXmuUcI0RPj36wNyoyE6c1@vger.kernel.org
X-Gm-Message-State: AOJu0YxYe7GkaJQ3pldzYk+Uy6fAtSh40AcMkPgxhsLjRE47WsdumVwM
	J9ZfsmydHSUSqXY8Lx9Ut1aj7WJvnwzV7KpA5G7j6K7YpHzil0n4HhA0YA==
X-Gm-Gg: ASbGncszmwIgPbHfJSrz0w1NyH6PQm/hR8duUI/nbnLrDYLo6fJZxvOazk8LdKMuWcJ
	GZTV0hikf5MC1n+FUJj3/fWnF3h25I0tyHNUhF/AXyTAg6DhmM43V6QrIj3uZzjZcoZkTdjvCYE
	/LDrkdcIknRhpQ9hA+SECM6ASzDDkkoLnRbgV7rtd6nj6L6+kYU+CVULfeNfPwJyYhSgl7LAS+L
	yE+pwilMi+DF60RdWVNyDf69FBYZDx8o/SH4xs12HEHxDWoCzJyII61xwUtINs0k9f/JxrmeCh3
	8ehp6tKTBPxf4V7arDA/VqBBtlF5QFT7WQnuHEGU2xEvidkDP47qFRj/wwgjsEu/5kRGCHeGXJA
	FwoT9VMU=
X-Google-Smtp-Source: AGHT+IHwhwN03Rano/W7g7TpcC3KAu4AHu8XRY4nSHbUDqGpseFs6elK+kPo9+eCu78mIs5dhyNNNA==
X-Received: by 2002:a05:6000:2cd:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3911f76f519mr4587194f8f.31.1741204562674;
        Wed, 05 Mar 2025 11:56:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c588dsm26580635e9.21.2025.03.05.11.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:56:02 -0800 (PST)
Date: Wed, 5 Mar 2025 19:56:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Boon Khai Ng <boon.khai.ng@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tien Sung Ang <tien.sung.ang@intel.com>, Tien
 Sung Ang <tien.sung.ang@altera.com>, Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <20250305195601.1dc6a1f6@pumpkin>
In-Reply-To: <Z8hetcRinFXXVAdy@hovoldconsulting.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
	<Z8hetcRinFXXVAdy@hovoldconsulting.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 15:24:53 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Mon, Feb 03, 2025 at 04:48:22PM +0800, Boon Khai Ng wrote:
> > The Altera on board USB Blaster 3 utilizes a FT2232 and FT4232
> > chip.  
> 
> I assume it's either an FT2243 or an FT4232 and not both?
> 
> > Add VID/PID for the on board USB Blaster 3 so it can be used
> > as a serial device via ftdi_sio.  
> 
> Can you say something more about these devices? I guess they are used
> for programming FPGAs? Are they embedded in other products? And can the
> same PID be used for more than one type of device that they are embedded
> in?

Also, is there any actual software that can use them through this driver?
The Altera 'quartus' software that is usually used to program (etc) the
fpga is pretty proprietary.
I think some bits have been reverse engineered, but only for a few simple
actions.

I'm not even sure the Altera code even loads a driver - just uses the userspace
USB library.
I'll have used it on a system with a custom kernel to program (etc) a CycloneV.
No hint of needing to recompile a driver.
(The sheer amount of software you need to command-line program a device is
stunning! - I had to parcel it all up so we could use a usb to jtag cable
to in-situ program one of the smaller PLD devices on a small board.)

So what is the real 'use case'?

	David

> 
> Or are the PIDs tied to different types of "USB Blaster 3"s? If so this,
> should also be reflected in the naming of the defines.

