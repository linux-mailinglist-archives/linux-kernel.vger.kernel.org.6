Return-Path: <linux-kernel+bounces-539814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636BA4A94C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A6E3B7054
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62A1C07F3;
	Sat,  1 Mar 2025 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6/qIa6r"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1E1ADC78
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740811074; cv=none; b=iFAompJilnxQYs94IJ3NugnOFKyMjWMxAUAAncId0SCMpEuQbf1LXThvPPnUSNhGHGFxtTmh7Ud+2hg8yzpOwuDr7Zd/qJBV2U/dw97s/mxDm6ojdZsAsraodECQ3sSGyUx3DuxjokntTSjq0yFKIsRSgEFE9xNPXt3Htc+1G/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740811074; c=relaxed/simple;
	bh=sP27WLF3Kyr8Bfxk0fH+w8RbmgSoEoVftNHnBn/VIfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFqUl4USSpAuy35a0pgAtFtZyytaoWbLJGUmE3ImFNZHw7RtFSve2Uoh5G2G3I/Lc0/DT+nRFoXEELVv4Sp+Vtte5bPRWeEhA0wumFNyJlpoDyTk8Lz5T0sR+9MoaKUpSJLl/AIufpQNfsbgkFqkTGbKgwwpcdRtH7P4b53d+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6/qIa6r; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so4452006a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740811072; x=1741415872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gbI6Lx1SwHUo016RUwsEL/Zpp8Wju2RW9C01nQ37/k=;
        b=L6/qIa6r7d2CEOMvk322trFFrBmsUL8D93Ims0x4ULaRPzH2i++VxTC14X6lMNoCmh
         MZFIKbkISu+oHZHxqqwiCgxjEg1c0koBQ9EgEBM67ctcc3HKiT5Os7pEzHNiuev9m+9R
         E+PuSP0ZFDq0OBzq8a/GZ/8suzb3GQxZuEBXilFn4yP072poh90zPTCj4qJcqJYWXiPS
         TU85d5f4LpmIMS9PXBjO17eFdWqx7qk7a8vsbyFE+o6R1EsYo2hofuQ7Rq03CPwN9KFd
         e5Nru9oSgWOslWNr7uRe4vhZ/iQ4WMSCA/b+DyhZQjliCsDP2/nO/yd7b8KLZ1o0D/LJ
         hZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740811072; x=1741415872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gbI6Lx1SwHUo016RUwsEL/Zpp8Wju2RW9C01nQ37/k=;
        b=NgHR59qlABx+pTL+AhpJgZCSAJb6F4U/41FQMi3VoMPiDOdqQ0ZNUNl1CRJSDHucHF
         HEYxUITHBl5G6pv/f9V/XaDhZB6ss08Vg/V7+Sr0aK0jwKc63MmT7OH3fV3wQ2jY7xiK
         1QEqBdcVPyBK1y+7C0JiPyn9y3nBJk09DPva5tyqqE8tUuq9Pqifsv+EiZ1krsCdNiXs
         7jvH+msnupSrJ8YoddVKptrfr60DsgfzaQCER3Vv09GW32UfeG0oBKH6OZNrovWWo3ZU
         d/duLRAktqMrkuMFNWt7Ekz9ed40inj+79VSC154xNRicv5p3yNwGBunSppdUf3i3FQ4
         7dzg==
X-Forwarded-Encrypted: i=1; AJvYcCW3DZXRFiy67VTkZwJdkg9Lq88UMFXQMKc37y+8E5U4PtxIM2H8Ba771Ud0EeHcgRCmE1j8cN8Eos0wQpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7zyQujBRWOFWE+xdqE1EhTnpGsCC5DuOmAp8wLFM6vkJ+VV6
	06blytH0PE7NQNSCrrdf7/o6TR3pKc59juy6JAXtCIBH85MxcPoHhkdgPffqJ1eIbIwFUhP8qbP
	9XiX4/h4VFU3k83hRiI+Qlsf2XBg=
X-Gm-Gg: ASbGncv4wnBQpiMZwGiL4ecuIiQ7/lYid+mi5w/d/jTg7x2U95P26J2p/MIjLPRQl7i
	vQupGtkn5f28NFTriB8I8WY8LFwCNHetayypaZM6VwBSxTHsMt+LbKHDfzDnaNf2F7fyqPJAy9m
	NiBpFKDxbAu6h68bUbj1u4lDhSvw==
X-Google-Smtp-Source: AGHT+IFe0JmXdmCI+lvsXXlYr7ZEtGT1XLaPZczWDqoXge/PaGceZFxsFgT1DV1FgHz/TlL2p/n7Cz1UWpNfyIleyjQ=
X-Received: by 2002:a17:90b:3d4e:b0:2fe:b9a2:fd3b with SMTP id
 98e67ed59e1d1-2febabf8336mr10223520a91.30.1740811072227; Fri, 28 Feb 2025
 22:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224062111.66528-1-kpark3469@gmail.com> <CA+KhAHYujgeC2kAd-vs0N0zwprpeqtD8G-8DpJ0w2RSxzZ5SQw@mail.gmail.com>
 <CAMj1kXH-QmuXGi-5MSEzz7zSpPYWvM2eBPN-NbWF+R=49P2_2g@mail.gmail.com>
 <CA+KhAHYDui3VkebjxZLnN_ijMUzJf2BRMqtPqqos+rCbf8J7Ww@mail.gmail.com>
 <CAMj1kXHyZ5_+ZrcRtdx4X8LA+mzCNcXUZM_3QcEudYGbuGBq0w@mail.gmail.com> <20250301043948.GA27296@willie-the-truck>
In-Reply-To: <20250301043948.GA27296@willie-the-truck>
From: Keun-O Park <kpark3469@gmail.com>
Date: Sat, 1 Mar 2025 10:37:40 +0400
X-Gm-Features: AQ5f1JpXv5NUIffsINAwSjLUyU7sJARB6pcCqCs1GLV50mEcwA1SDJXzdVAxsr8
Message-ID: <CA+KhAHaXHUYs0aXcD9uJQWfwDMFngEE03wapeVwS35OgZO82JA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: consider parange is bigger than linear_region_size
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com, 
	Keuno Park <keun-o.park@katim.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 8:39=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Feb 28, 2025 at 02:11:41PM +0100, Ard Biesheuvel wrote:
> > On Fri, 28 Feb 2025 at 06:55, Keun-O Park <kpark3469@gmail.com> wrote:
> > >
> > > How about adding a warning message in case of linear region
> > > randomization failure?
> > > And, there might be two options in my mind by now to consider hotplug=
 memory.
> > > Either giving an option for users to override "parange" as kernel
> > > param or providing the legacy way((memblock_end_of_DRAM() -
> > > memblock_start_of_DRAM()) when CONFIG_MEMORY_HOTPLUG is off.
> > > Users believe KASLR will work fine by enabling CONFIG_RANDOMIZE_BASE.
> > > In case of linear region randomization failure, I think at least user=
s
> > > need to know about this failure.
> > > Can you share your thoughts on this please?
> > >
> >
> > Randomization of the linear map has always been a best effort thing,
> > so I don't think this is a big deal.
> >
> > I wouldn't object to the new behavior being conditional on
> > CONFIG_MEMORY_HOTPLUG, and fallback to the old behavior otherwise. But
> > ultimately, it will be up to the maintainers.
>
> Personally, given the confusion that linear map randomization seems to
> cause, I'd rather reduce the number of variables on which it depends.
>
> I also wonder whether it's actually useful at all...
>
> Will

I have thought of reducing parange until it fits into linear_region_size th=
ough.
+               if (range < 0) {
+                       pr_warn("parange(%d) does not fit into linear
region size\n", \
+                               id_aa64mmfr0_parange_to_phys_shift(parange)=
);
+                       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+                               while (range < 0 && parange > 0) {
+                                       range =3D linear_region_size -
+
BIT(id_aa64mmfr0_parange_to_phys_shift(--parange));
+                               }
+                               pr_warn("smaller parange(%d) is chosen
for linear region randomization\n",
+
id_aa64mmfr0_parange_to_phys_shift(parange));
+                       } else {
+                               pr_warn("falling back to the range
considering on-boot DRAM size\n");
+                               range =3D linear_region_size -
+                                       (memblock_end_of_DRAM() -
+                                        memblock_start_of_DRAM());
+                       }
+               }

But, in a certain case, hotplug memory may get an address out of the
linear region at some point, as still SoC's parange can cover more
memory(ex. in this case, 1TiB).
So I think leaving a warning message for users might be the best
option. Then users feel it's time to move to a bigger address space to
resolve the issue.

               if (range < 0) {
+                       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+                               WARN(true, "linear region is not
randomized due to bigger parange\n");
+                       } else {
+                               range =3D linear_region_size -
+                                       (memblock_end_of_DRAM() -
+                                        memblock_start_of_DRAM());
+                       }
+               }

