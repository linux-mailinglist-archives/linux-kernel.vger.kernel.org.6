Return-Path: <linux-kernel+bounces-426731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A19DF715
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25F1281685
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202F1D8DF6;
	Sun,  1 Dec 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDpNEHwV"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90F70803;
	Sun,  1 Dec 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733086096; cv=none; b=qjZ7sfV7bKStCryNOPWz1YPoQRNeA3kxwoVQE7IGN8OpPYBE8mMDULtM4T15Pz3tD0eAGjn3tIO38SWI8exFuTgfSu97GgSZg5M3V6d2RkaW2xst3w6J4+qGMqeBAekmCQycM9cDh1BIW4oJ84ml4Y7fwD1ccOC2psqvHQ4sRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733086096; c=relaxed/simple;
	bh=oEUek/oLoEOUG2Zsp9jaU7h3xjAClbKuAkjW6nkgCQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj+BZ3a8x4+24+QPlaG9La2aScOWxcpC/cuTuWjMgIZeLax/Wu3XwNRKXwGd3aD0QcQ1JsElg3y4X59Abmx4R4SgESOyr/K+5gx04pyCdFNe24BhoLuDtmG1DARDanI6OKdKPn/Amrk7knE2VW2alkhwj1XsLbFQ4eGkleve5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDpNEHwV; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a7d94b545aso10569035ab.3;
        Sun, 01 Dec 2024 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733086094; x=1733690894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPHxfSACZ+2h2VPEaq6+rYqVaulrzLUGki8m/llPT3c=;
        b=jDpNEHwVu8xAU/b6krZjMfOrLRJPuSZyaIbXhoa+pdnGn55IFwEVZA0Owo2e9U/3i4
         B4ZcRyAUxkXIGdPFZnVaqAsY3Z12dUZCzwmkTtqAeS0hJGIukZT7/2WJcAMvoix+EnN5
         uPfbUhJuELuq/0y1PU72HZMYjh1u21F0Nxl60N9q+sXFeQHgS2Yai9nM+ozlhJdVBTPF
         A/yruA9PWI67cs3HMf8ZPwy99i0GZqDWzYTTljVPe0UtDcKN+RgnJxTdiwPCDpoT7l/O
         qYVefj8awHLCWAcQUjXiLLaiW77CL7lDPACZ2XzOV4eYKq8n1A11L6C0VLZqP9fzfiV8
         79Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733086094; x=1733690894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPHxfSACZ+2h2VPEaq6+rYqVaulrzLUGki8m/llPT3c=;
        b=Av62Hs+AF033C7h1AoT7welkAjsLwczKLVSzDwTOmae9gvDeBuaLcQwuakuRNJjOnB
         PO7eJUWFOA7EeImZMHKqzlg9Mhi/UbCHwZuYn1+4XIqz5Ldo4zVUHil5zlhz5+azVF8N
         Xf4bPMb7Ouejl9SnMBvMPbTRAO2Ki1zFVWn8Hm9fP7LilcJ/u76V+bOGp97fPtqUYkxO
         mEAhvPNLRqow1rgZXsp2mubEBthfDfk/Tee45f/b1hRfDshUt6Dd9Ru3cwDf48jQMxZz
         tr60rlTZSJbYfl2CerU2bI5IJVJpF4ku7oHMgQBtaZqIWgVLW/mtHSSA8ypr+RFwN2p8
         SZcA==
X-Forwarded-Encrypted: i=1; AJvYcCUwoEhUToP5vMLYuLOf2sL11FX8Cc/L77dGtSZT09AyToMlhCcGKKgjS8F792PoLPuxgsthPLz6IR4NhILC@vger.kernel.org, AJvYcCVTNxrmneBg09OHCKsqLfOKSIV77tb9RoygcVVou/mawNyCFrj2cJ8IsG0vl6ByOLShz/KkZvG8ATOqjRs=@vger.kernel.org, AJvYcCWzV30JxY0vVIAqUo+f5+EvZZlw2zA6G/Arr9BSOoBG9ZeV2IZ+qTSyDbMLKtYFMFJlkPx+5/TQArc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BSOxPxNC/RrOp0u+ZN4/tj9jhWpG6/pVQw11/Nh4+5rj4iME
	S5lLrtjhIfSfcQ9lvnKULL8ptZu8G34koMrbfkb46WQWXCameXbNav7oAsx1pVcP9Fzl1dazlSr
	vO7T8ve3DhHG0j8a9B/QtbMzbAbc=
X-Gm-Gg: ASbGnctG06ri94AbAGHjdWqIzO/+JXJRVKy31BsNcailScn4r8fLK7P7kbv6QtQlKpS
	NWbtgtn+xF2Y9pYlDSVbYzrZiTiaYaT6wTNSEk3hr5ERuOsD3TKlQQQVHGqQ6/E4=
X-Google-Smtp-Source: AGHT+IHw0PoW86iu90bgBJH5l9I3IFB97my7HbCGQAgg8zibDjFR3wOY92iHdJmWWUjUCCEJP9pzqDq/0AokWh1FtHE=
X-Received: by 2002:a05:6e02:4518:20b0:3a7:c5b1:a55e with SMTP id
 e9e14a558f8ab-3a7c5b1a735mr113260755ab.0.1733086094131; Sun, 01 Dec 2024
 12:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
 <20241130144733.51627-1-yanhuoguifan@gmail.com> <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>
 <Z0u5QWzWSXGUTUO0@gmail.com> <64783a84-5f21-4c33-b74b-5e6d79107c33@roeck-us.net>
In-Reply-To: <64783a84-5f21-4c33-b74b-5e6d79107c33@roeck-us.net>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Sun, 1 Dec 2024 21:48:03 +0100
Message-ID: <CAB95QATT51L7FtVKdhTpTMo6sCwkihqyb5GtQBbLRR0jyRmMUg@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Guenter Roeck <linux@roeck-us.net>
Cc: Li XingYang <yanhuoguifan@gmail.com>, corbet@lwn.net, jdelvare@suse.com, 
	linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

> >> This is an unrelated change. It affects other boards of the same family.
> >> It needs to be a separate patch, it needs to be explained, and it needs to
> >> get some confirmation that it works on the other boards of the same series.

> > I found that in the LibreHardwareMonitor project,
> > the registers used by Amd600 to operate FanCPUOpt are described:
> > https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/blob/master/LibreHardwareMonitorLib/Hardware/Motherboard/Lpc/EC/EmbeddedController.cs
> > BoardFamily.Amd600, new Dictionary<ECSensor, EmbeddedControllerSource>
> > {
> > { ECSensor.FanCPUOpt,  new EmbeddedControllerSource("CPU Optional Fan", SensorType.Fan, 0x00b0, 2) },
> > }
> >
> > I think this is suitable for the AMD 600 motherboard, and it does work on my motherboard as well.
>
> That makes sense, but it is still unrelated to this patch and, worse,
> not even mentioned in the patch description. See "Separate your changes"
> in Documentation/process/submitting-patches.rst.

Can confirm CPU_Opt is still at 0xb0 for ProArt X870E Creator Wifi, so
it is the same in AMD families 500 to 800. The introduction of the
sensor to the 600th family should not affect other boards, because
they do not use it yet,

Kind regards,
Eugene

