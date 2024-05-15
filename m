Return-Path: <linux-kernel+bounces-180340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367238C6D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B661C221F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E515B0E3;
	Wed, 15 May 2024 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DLbEWNFj"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A21591E8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804540; cv=none; b=mxGqJf8B0HNxkHhrrigV6xWsN1FiSDlHnyyoVlGAoHj7sP3ljH6ZPaC5IOU47ll4xYgt0pd1Enr/UKwLD6NObgZ/EYcTNLMtEWRF5PMPp+wh1zxtl/nfHUkrBqhTfqEoKae8hUn9siYiuUaM474tPg0Y9iwgSqMBqtG2Op7tMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804540; c=relaxed/simple;
	bh=ipqP/BB7kFw3L7SYXlCoEWELU8i09uvc2ZITsN0s6dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPjUxAWOzeD1oQ71dpnxO2S6yRSieWgyY4HZ6pk+zgN7wi/W/WtYNU2bvPvnFNeXEk9Zj7V5rScMzoi7z6joCRF7an27VLl2siR7Eo07GR4ec/5dnX7/fhnnajTOaQmBOVZXgAqrbault4Yyto0R1264cLhjUqxDQVPkvzdC4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DLbEWNFj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59e4136010so231393666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715804536; x=1716409336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlA7HkqGGky3+qx2udfV2DjY9LzoSxvenoXojxQkMi8=;
        b=DLbEWNFjmUP34E3N6lCSsDOYOTLrOb8LBrryXfWt2Ey4MW2a/zO/17G49dIfFJBE7s
         JGcLUyW3/wBwqVyQlSgIrbaRr5R25TtbqXI4MdnUCQKTQwjuNOosGSoiP2UQkMIKwMcS
         uwXQuUREtl91uqwP6GvZL4ET8ZnS/FMiD7nPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804536; x=1716409336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlA7HkqGGky3+qx2udfV2DjY9LzoSxvenoXojxQkMi8=;
        b=YTbzVk/DTdZ9A4EURER9+UvVhpPD+qwDnYhS8NGOQ3GXxKfXH/ryQ6vIWFFlwyAytx
         pR17Cr96ANi84q2wlociAT143zj6AouoRBuc3N60EJ0ic1PEBUq/0CN9Ab5Kk6AB1YLn
         nG+VntmkVqIUt7o1I4EJiHG5g3NktWiCL5bAnxqLxb2W2v5GQaV50lHm7KcDNMeg/3bS
         WaIcfiF7JT1JmoC5rG9teOzMFXsw/HPomI80xwSU2S9uC9SP//6lQvkv2yzx6+t6MzgG
         FIJjkkPgqSaYjMaUQtQn1g5/1fB9HRCk1lZxE6RZIpKuoCz5XTY0DBaI1KiVaLbdFREH
         QZqg==
X-Forwarded-Encrypted: i=1; AJvYcCWPhAEF9IXWxSAS2lKTjeC+eeoqTZzCnMUBHMrcgT+72pSYHF5pvFvVAkyzFguKkAKxCpqtt9j0SzIvSkXxGPwTikETq1Dci8VqI766
X-Gm-Message-State: AOJu0YwlLYz2wNllWUNl8zRTGODEFfZlIFLCK8VeBowJUbn1L4lJxdML
	qxBtX08WKfU7m+SreZjAKOcE2o7j6adDRJ/UmhCq4oezbL6BgYweXaMkHg+nB4/aqml5Rd9jaz1
	fVMr4ww==
X-Google-Smtp-Source: AGHT+IGJjQsD/D+T3zxhT/tWyklYzbY0lMQ3Nc7V350rZDOhe0dOWNeO6pnIsrhZyLssdFAxBZSAnw==
X-Received: by 2002:a17:906:289b:b0:a5a:8bc4:f503 with SMTP id a640c23a62f3a-a5a8bc4f988mr279195466b.25.1715804536331;
        Wed, 15 May 2024 13:22:16 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17f2csm893134966b.197.2024.05.15.13.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 13:22:15 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a0168c75so248493966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:22:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxnJWGE9PUlIggjqsCxcYTPiHvbXsd0DRSdRUKGW40bIip8OUUblhicQ755GdpX6Wsxry4uO0IX/npaNxoZQy7abk4gnaUkkubLrhp
X-Received: by 2002:a17:906:eb18:b0:a59:c844:beea with SMTP id
 a640c23a62f3a-a5a2d676a37mr1093027066b.73.1715804534952; Wed, 15 May 2024
 13:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
In-Reply-To: <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 13:21:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
Message-ID: <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 13:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. There's something seriously wrong with amdgpu.
>
> I'm getting a ton of__force_merge warnings:
>
>   WARNING: CPU: 0 PID: 1069 at drivers/gpu/drm/drm_buddy.c:199
> __force_merge+0x14f/0x180 [drm_buddy]

Adding likely culprits to the participants, since it looks like this
is all new with commit 96950929eb23 ("drm/buddy: Implement tracking
clear page feature").

Sadly I can't juist revert that commit to check, because there are
many subsequent commits that then depend on it.

I guess I'll try to revert the later commit that enables it for amdgpu
(commit a68c7eaa7a8f) and see if it at least makes the horrendous
messages go away.

Anyway, this is some old Radeon graphics card in my Threadripper:

49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)
(prog-if 00 [VGA controller])
        Subsystem: Sapphire Technology Limited Radeon RX 570 Pulse 4GB
        Flags: bus master, fast devsel, latency 0, IRQ 130, IOMMU group 32
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at d0000000 (64-bit, prefetchable) [size=2M]
        I/O ports at 8000 [size=256]
        Memory at d1c00000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at 000c0000 [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu

I think it's a "Sapphire Radeon Pulse RX 580" or something like that.

                Linus

