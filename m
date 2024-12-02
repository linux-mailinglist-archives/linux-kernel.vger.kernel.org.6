Return-Path: <linux-kernel+bounces-428072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A019C9E09D9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F849282AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D51DA112;
	Mon,  2 Dec 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hsGo05y3"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAD1662E7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160484; cv=none; b=WYYjGS+u+Na3bBCqRUf4eaO4yQp9svdEFgecPs2nuihDDCTmrWtmKy3+Onjr+bhBOPcezMJJSYxctjBYvuzFkUIQeWPX9uv9Boe5EUa37A7tfvjDZkCDK5dY06kka/FMloclltETkmbGE2lUDVB8ylAxiRC9We+YuaUx/AkwCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160484; c=relaxed/simple;
	bh=r/3/WvrUYpNr+tcjXSjzxvxpguA79BHRy4L5fPvtBqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skFwNY/YL+JRg7oxQ9Y5quyBDQKhd1foW9dcXHAEWrQOE7cQgS4XZb3alB1IPG3XQWSYHlPaugq0cPp/GjrIok4U58LThL4p7rN8VWYiwLK31RYon+GzQ+5I4Ya3d9E9zwmXxl53Amp3OtMpkIHMJFWaWcyxx+QLvHkWcgMbNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hsGo05y3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so4477861a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733160482; x=1733765282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zV7VHVGHL7Rl9Gp4X03jHFgxr0pgqWsD/7qzPnBvxDs=;
        b=hsGo05y30KMtq7vsXmOKIxshtEYFOzclZQwXkq3yF4q6XuT+Bc45EdtX2sQRPVAhS2
         nK2hNzbAcPLOKjYj0TSwEIO1ksNviCCqDfx6cfsQFF+NrRrEsHebcirt0NbZS4OSj8F6
         675WkxqfZCn1tHFrPwvW6y5zvFz1MAWUBD9kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160482; x=1733765282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zV7VHVGHL7Rl9Gp4X03jHFgxr0pgqWsD/7qzPnBvxDs=;
        b=E7osVQ8YUgjDZHR8za5WaRNmvzx70KwBS7kc+vGlRWnaGF2LkIxyED/Nq5nuLeqsa3
         UbIIzgwrcKys//CKxXJFKLnFGzRK8H72XHwDTaFf045XM2BKcfs5kVa5KM2af701T0G3
         glVJP4T0B2tcOPVYUbppQmC6syaeOzZQeLU/k8pXrgT9e9MJpvoZjSJWn1XhO++2i4eQ
         dhDutKasTBEZf7qG5abg3Q8s5u1XSWBldN8a4MKlCTcd5Y6bUGFzbTGf5tK2fvavUDcp
         a/y8lnVwhhoPgEnBgc8QJHTWmHjpnIWV5yqSWvXF0da8ckFsGSktCf9+umoM+meEA6X2
         lf+A==
X-Forwarded-Encrypted: i=1; AJvYcCX+LicReTWSDgScX4RvzTnCUExasw77om9F5A4ffT+Wo6tmEQBQbWnwgGeRnO7ySj9X0p+8q8TghJuH2GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRKHVEAih7nKbY/dATV43sGYaK9IGr3KW5mvjDupHdxtESGhI
	bYIGZWB33SKO35PTfhsTnrhRPBJuTspAkwiMmdPSj+N88DsrGrphrPqtP+euzbLrE2tXoNUwUUg
	=
X-Gm-Gg: ASbGncs8HlYVwy9dXSVog/mBRHyxPlzP57AJ+PNRDrYZafLA/9x6zjfEmYSQOOwygXh
	KADyxnECxJuADJj1HBwkqsGD3ykcY9Pcxky8nvHy6ybgQU04Dm80eimINt0T8D9rL4BEhq3M5XP
	C+E+3b3UOQ6TkYBzPUF3FbdoxMXjhQlYzBG2DyPWOhg+Bm2tqMZiBhUBdQnon2wt3juml1ddias
	3dR4zf1mHnKd77cEZCPldBwOPH3PsoFAbGjD0Nvd5pKSyH8s6DavCIbJbwHyuUdjqnUQoXhNk6b
	1jVl+qQVK/6iXjXk
X-Google-Smtp-Source: AGHT+IH93gMLvcI/DFYVTq/a6n4IhYzARjiJ1JNS+Gsh6qhc7rGpDMT9CehzMvDfjJs3TgJiP82//w==
X-Received: by 2002:a05:6a20:430f:b0:1e0:cadd:f655 with SMTP id adf61e73a8af0-1e0e0ade41emr34502820637.14.1733160482407;
        Mon, 02 Dec 2024 09:28:02 -0800 (PST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com. [209.85.210.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417614basm8786867b3a.11.2024.12.02.09.28.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:28:00 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so4518574b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:28:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfqs5mtp105bCjLDB55SA1pmldivfEAXO7W51SiMDfNFCVYEixsc85ct1S+bZjTIuajgua+PhHgu00GGU=@vger.kernel.org
X-Received: by 2002:a05:6a00:1390:b0:71e:5a1d:ecdc with SMTP id
 d2e1a72fcca58-7253012f56dmr32940878b3a.17.1733160480025; Mon, 02 Dec 2024
 09:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-fix-vmstat-v1-1-c995585b7df5@chromium.org> <20241202161811.GA2843691@thelio-3990X>
In-Reply-To: <20241202161811.GA2843691@thelio-3990X>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 18:27:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCt_RALHi4O313bzi=Grr=sCV+Y8WmHmOF8JpttHw6nFpA@mail.gmail.com>
Message-ID: <CANiDSCt_RALHi4O313bzi=Grr=sCV+Y8WmHmOF8JpttHw6nFpA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmstat.h: Annotate operations between enums
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 17:18, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Ricardo,
>
> On Mon, Dec 02, 2024 at 04:02:19PM +0000, Ricardo Ribalda wrote:
> > Compiler is confused when we do arithmetic operations between two
> > different enum types.
> > In this case NR_VM_STAT_ITEMS and NR_LRU_BASE are not actual
> > enumerators, they are used to find the first and the count of the
> > enumerator.
> >
> > Add a casting to int, to avoid the following llvm 9 warning:
> > ./include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
> >   504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> >       |                            ~~~~~~~~~~~~~~~~~~~~~ ^
> >   505 |                            item];
> >       |                            ~~~~
> > ./include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
> >   511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> >       |                            ~~~~~~~~~~~~~~~~~~~~~ ^
> >   512 |                            NR_VM_NUMA_EVENT_ITEMS +
> >       |                            ~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
> >   518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> >       |                               ~~~~~~~~~~~ ^ ~~~
> > ./include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
> >   524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> >       |                            ~~~~~~~~~~~~~~~~~~~~~ ^
> >   525 |                            NR_VM_NUMA_EVENT_ITEMS +
> >       |                            ~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I think it is just better to disable this specific warning for normal
> and W=1 builds so that it is not visible for people, as this objectively
> makes the code uglier:
>
> https://lore.kernel.org/20241008005136.GA241099@thelio-3990X/
>
> https://lore.kernel.org/20241017-disable-two-clang-enum-warnings-v2-1-163ac04346ae@kernel.org/

Thanks for the heads-up.

Either disabling the config or this patch will work for my usecase (media-ci).

FWIW, we only need 3 patches (plus this) to build media with W=1 and llvm19....

I do not think that this patch is very ugly :P

>
> I have just pinged that patch for acceptance.
>
> Cheers,
> Nathan
>
> > ---
> >  include/linux/vmstat.h | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index d2761bf8ff32..32c641d25bea 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -501,27 +501,26 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
> >  #ifdef CONFIG_NUMA
> >  static inline const char *numa_stat_name(enum numa_stat_item item)
> >  {
> > -     return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> > -                        item];
> > +     return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS + item];
> >  }
> >  #endif /* CONFIG_NUMA */
> >
> >  static inline const char *node_stat_name(enum node_stat_item item)
> >  {
> > -     return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> > +     return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS +
> >                          NR_VM_NUMA_EVENT_ITEMS +
> >                          item];
> >  }
> >
> >  static inline const char *lru_list_name(enum lru_list lru)
> >  {
> > -     return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> > +     return node_stat_name((int)NR_LRU_BASE + lru) + 3; // skip "nr_"
> >  }
> >
> >  #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
> >  static inline const char *vm_event_name(enum vm_event_item item)
> >  {
> > -     return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> > +     return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS +
> >                          NR_VM_NUMA_EVENT_ITEMS +
> >                          NR_VM_NODE_STAT_ITEMS +
> >                          NR_VM_STAT_ITEMS +
> >
> > ---
> > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > change-id: 20241202-fix-vmstat-88968bcaa955
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>
> >



-- 
Ricardo Ribalda

