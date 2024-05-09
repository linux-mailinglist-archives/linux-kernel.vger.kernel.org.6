Return-Path: <linux-kernel+bounces-174992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593008C185C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63E11F21CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF3126F2F;
	Thu,  9 May 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="SvQCTsBu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653697FBBE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290021; cv=none; b=oft9zod0ts+vNqQTZasWDfbFoOeTgSEHXi5lsK4N627ke5U3fVOJeMKUM33U/BPv6HV9P8VzKWnz8dD6gtNgqYCPe/ry69MYHuIScTMDFUNDYeYKxC3Y3EliUNUM39HuZTnVv7oBJlJS8l0GsGdsWG2y2R0nvh2ySkKzTC58aDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290021; c=relaxed/simple;
	bh=sh2RVcH3kYXx3pxWSDGSev2r56o7qSVgAC52eozUMkE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qhzSzOaI7ne1XWA3i8xd/fOz3VO1ebXSXAssduKLGdMo0YX5yAUHaYSESalmUP7ikp2x2CIycQv57qis5NFQ6INZGuN7h1ZLy3tNwtmk7S1wvwFjKvhKe9SVUVPlfRIuUCKsUv2tfk4ZZs0wF0v99FMUlqhIE2X0G9o0uksCaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=SvQCTsBu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c448b44aso341804466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715290019; x=1715894819; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJpnYp9Gok3jjEaTByhEx/g2RIutD08xBpO53TQkyBA=;
        b=SvQCTsBuu9qYbfTyxs3r99RzaTnjBQyOb9AbGUAGwSU6PvO6IKULoplLnnYOcEi4lm
         7uve9FtRUWnD1D/OoxXL54vWkU6gxdW5fRILK+MpXDhrDyh+kXK49S4Goc+QhBoOP/vO
         ViFCamhIdClhN0tuwRO3TqThqoRY0wLj6CJ/otNCKPuCNCVvnBH644uxNGk1rBRvVc3u
         0uXFgip7VOU2jdyZqCNBdY9eVd4LcwkAx3y/s1mzCI61nb2gAjuXWvcejeeoOCvJ0d5y
         TUGh6b1cLBP7AC8mVdpEuXjadJtHMShTNzt5sFB+xqP+958DDHuNl/3JGFMDdYfLWyKJ
         LgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290019; x=1715894819;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJpnYp9Gok3jjEaTByhEx/g2RIutD08xBpO53TQkyBA=;
        b=OrPFtS8gOQVRYT4NZkZ1uzJjaQrB/2VEudAZX1k2UiZqxRTQQ2WAvwdhXkmdGvybx4
         t+PDHVMaZ98o3Jataz34qMfyyrYOQv5FD/wKPOcvW76t+RTIkAE0WGp1vHF4//28ZiaA
         gNve0nmUBoIyLzZrXTSkNWIZVF5MhIVDo33TKiXAV7oxea13B191tDjmiHV/jhiSGK1P
         gN+kIXnk5/ndDNytA/XNUaMl6wugoqEuMNXTOI+I+if1n6D8LFCZ0KFlO4h7lho9ACCN
         oGsjd1hLmwOkqnJGFzPC8MlU3CX7HtDT8qsMj6kCpWok9njnKBRxSHWyojua6oFhLsee
         2Vuw==
X-Forwarded-Encrypted: i=1; AJvYcCVHAD7e0uOrl/pvYWUqw2SJmGVtExGcdKdN92zp9CXWKj+0XB+G/oP8/NCdoWj9GD3ZFo377XBQ0H4uUnMr8SmBIRCw7WiJrMy7VCfW
X-Gm-Message-State: AOJu0YyAbZihtndhAWzgyeMVJgu680SDjNcYBBM7uX5uLMUpAF1VaKRU
	NZA4hGDhWNI6vujiRMe3a/V2frcB1FAxZm78oP2/EiRlukF4l8A6h88rsQCh+q8=
X-Google-Smtp-Source: AGHT+IFtYo+0Pn0orW7bPoagGtyFqlCu8vgHBbRxWWEscfR2+qoH0iwqBQyJ2OIx7eQMwYd7E6Jpcg==
X-Received: by 2002:a50:bac4:0:b0:572:9f40:514d with SMTP id 4fb4d7f45d1cf-5734d67aadbmr523850a12.29.1715290018651;
        Thu, 09 May 2024 14:26:58 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:9c2d:df77:ab3f:a592])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7dd9sm1065430a12.69.2024.05.09.14.26.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2024 14:26:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <98259c2f-b44a-467e-8854-48641984e468@lunn.ch>
Date: Thu, 9 May 2024 23:26:46 +0200
Cc: Nicolas Pitre <nico@fluxnic.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF387A27-547C-448A-AF52-8E170C05C094@toblux.com>
References: <20240509121713.190076-2-thorsten.blum@toblux.com>
 <98259c2f-b44a-467e-8854-48641984e468@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 9. May 2024, at 22:36, Andrew Lunn <andrew@lunn.ch> wrote:
> This seems like the wrong fix.
>=20
> commit d97cf70af09721ef416c61faa44543e3b84c9a55
> Author: Greg Ungerer <gerg@linux-m68k.org>
> Date:   Fri Mar 23 23:39:10 2018 +1000
>=20
>    m68k: use asm-generic/io.h for non-MMU io access functions
>=20
>    There is nothing really special about the non-MMU m68k IO access =
functions.
>    So we can easily switch to using the asm-generic/io.h functions.
>=20
> So it rather than put something back which there is an aim to remove,
> please find the generic replacement. This _swapw() swaps a 16 bit
> word. The generic for that is swab16().

Thanks. I will use ioread16be() and iowrite16be() as suggested by Arnd
instead and submit a v2 shortly.

Thorsten=

