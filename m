Return-Path: <linux-kernel+bounces-416167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5651F9D412F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B850281FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1619C542;
	Wed, 20 Nov 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwksfhdM"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D113487BE;
	Wed, 20 Nov 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123972; cv=none; b=gIB4JYtaIchGW4+BKdCbgIrlKtuE8c2yyN+I3pof/bgnZs8CxQ9pFvr75TeFZhn7bNR9sYQIxwkFdyquV/zuSoZxyN4+My+h1LovDNL6KeDa4yyC0C7NbZ8z5rtZ7A/y85i4N7lqsgOo1Y+rhgIQpf7yH9VTeltFJLDPtbgzeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123972; c=relaxed/simple;
	bh=Ydm7LuOScxlb4wHp+uTbMha1SN4b3rRxDoJYfVZYrLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9JEUhqIBYdMDD+pNmG8Dr8xUzDDoeabQfSH2utjmCenNJCx11MrC8trQH4LK9ukBV4W3JQgYQ29dJ2zKxOUcNpoaPg4Lw3ulBUNboqdDSEN4//53uWS/RQhGOJI21DMUq56a9vHpr8SNovk2ib5C8CiUo3I7VeYmK1lDxaVE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwksfhdM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso44104a91.0;
        Wed, 20 Nov 2024 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732123971; x=1732728771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/2Lytn1vm/IYW/jhQDWAPmSMmgq3z2ocN64hCXLvjs=;
        b=RwksfhdM98kf5mm83DW4JWdg+ol+pnFgrbQBE6EXT4RPSlmIA+lvnCnM5zyo9nKzrN
         QLhHusoJbesFQmnBAeYXEzb0LXaAQb1+1101m0xWLThh0cOe2iZrLdFwPNB9d8Gagjun
         hpVmQJ1re9aOeQQvy1pM/f7OtCS8IvEKgQx4foPFm83fOJXUaaX3aen4LY8ESIcWOLz5
         s0bV+qzjcpA0tznvfiNfXZDL6HhKdB4qMC8y1dD+8mrBCHg7eYnUOTK48xE/LWXbB8Pv
         BqQdyxgy13VmV+zQ6fuucYXNu1dL2/M4RLt1aIZh5ri0bMQw32YuZrUeBfWJXYN9YyZm
         2zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123971; x=1732728771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/2Lytn1vm/IYW/jhQDWAPmSMmgq3z2ocN64hCXLvjs=;
        b=IAnqPyiVHU2u7QQBNgGXQgftygoLjB7sVe6YxwOkfJZF/fV9mK7yAwnab8t2bR4zxl
         4U60jljgDNELxmAEvwX2+Kgrmdzf/+YaQjV26Rk+5t4XH/VBz7b+HuJl+rQJp6rkf71J
         c3rxPCq+2u0WbzwtYg4sn+KTGDFQVuygC17xwneoaXwNVHidi2Q4iPhkjepu8Jemw6Ns
         Jm1krMT4STPM34ooJbB2Vm6bnxdOu3S4T4314Gt+P36X+Ug2K6dA634OnQyEf4U4zk7l
         3eXezCgNXCA9ZoqqusUxVYjpYwPBoVqMzBMwDL7cgVNWyk3505h5pZ2iox00/nV2KzPu
         FwJw==
X-Forwarded-Encrypted: i=1; AJvYcCVOQyIVWFuWSFojKc3o6XblqVaOQifxsxFsJ5UCNp71qKssSjGV0+mIHMqS4m2MWIU430p6WmbZU59qjTqk@vger.kernel.org, AJvYcCVhoGdTsmBAg/u8hJUhZMR9780wRveqD7yySFk+huXbpZiHinxbMD2uULufpmzvHDmL4MERdmGYYvhNcJ8=@vger.kernel.org, AJvYcCXp0VjBa9r3l0SFeaHrtIlq3ywLjpp76r3ZHS/agSnuhLuef+BMnPM2brvif/XUCs+xIb5HswM5ess=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NHai9rzCqj2qE0b+O+bVo3Qg1ZsNenUbGqqK8CFXsZ1SYPrJ
	aLxo/AAKhqqo9psNPMPR5cO8jWRwEa/QKgQvZuL72k1cV/dplZWSwqSiu9r0SjyceftCOw264Tx
	owWhclgO77SBiQt+FRyHcPsCwJDU=
X-Google-Smtp-Source: AGHT+IHerz1Iuc8dyH4PpuZqIVt7KpLCTN71uXCQnZYztGGh+ZSbOJc6m8Z9MNLoR0+cjQLmDOeC84yAM1gSlvybWL0=
X-Received: by 2002:a17:90b:4d88:b0:2ea:6f19:1804 with SMTP id
 98e67ed59e1d1-2eaca7d0bedmr3911138a91.25.1732123970570; Wed, 20 Nov 2024
 09:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
 <20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com> <87iksmq8ho.wl-tiwai@suse.de>
 <CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com> <87ed387ioq.wl-tiwai@suse.de>
In-Reply-To: <87ed387ioq.wl-tiwai@suse.de>
From: Hridesh MG <hridesh699@gmail.com>
Date: Wed, 20 Nov 2024 23:02:13 +0530
Message-ID: <CALiyAo=awTsGQnGH5UPB7dF5QsZ2AFkKv5LcJkJRXV9sv51iqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Stefan Binding <sbinding@opensource.cirrus.com>, Kailang Yang <kailang@realtek.com>, 
	Simon Trimmer <simont@opensource.cirrus.com>, Joshua Grisham <josh@joshuagrisham.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

> Is alc_fixup_headset_mode() called by the quirk chain?
> When this is set up via quirks, alc_update_headset_mode() gets called
> at initialization and this should detect the headset type.  At that
> point, alc_headset_mode_ctia() would be called if the proper type gets
> detected.

Thanks for pointing me in the right direction, I believe I've managed
to find the root problem. I've set it up via quirks to call
alc_update_headset_mode(), when I plug in any earphone,
alc_determine_headset_type() incorrectly determines that the type is
OMTP despite it being CTIA (I've confirmed this on a friend's laptop).
Adding my codec to a case in alc_determine_headset_type() for my codec
seems to fix this issue.
After the headset is detected as CTIA, I also had to add my codec to a
case in alc_headset_mode_ctia() to set the process coefficient to
0xD689 (as written in my original patch) to finally pick up the mic
input.

I hope this is a satisfactory approach, if it is not, please let me
know. I'll make an attempt to understand the cases and process
coefficients before sending v2.

