Return-Path: <linux-kernel+bounces-550223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF5A55CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CD11888A08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3F1422AB;
	Fri,  7 Mar 2025 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKyaZ2wT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91F3D984;
	Fri,  7 Mar 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309854; cv=none; b=gzvGvzXdpqlk+uYfwfZiDled8mBQVP6oMxhFV4/8OvUvwIot6IDn8z/+YtgbQbKZfF6JO07pJ10wCMW3f+LRaD0if6RYPeeizp2wTe5uP2SrJo0eFIOfD9uPm0r4NLZX1LKgodA3+4GQQyNSOaVil6kc5Xv3VYzaDBI3ST3yHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309854; c=relaxed/simple;
	bh=U8W4lBndXbHt9de0ee6upN787KMW52umATu2vsi2G1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtK7jReBIWcmmgi6AU5d6aiYNancLqIK5Cojm9MuRGxTaTiqLr40uhoRsfAYeUB11hzZbwDoU4hnexpNnfKkUua6ys3nF/F5PugCdQUDeYr31SPlBa7wwT6G3BtBNd2Dop/v0wC8slkeyJEMcf8jpww5ALr4AVVxOW+px0QXJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKyaZ2wT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso7567505e9.0;
        Thu, 06 Mar 2025 17:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309850; x=1741914650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8W4lBndXbHt9de0ee6upN787KMW52umATu2vsi2G1s=;
        b=DKyaZ2wTtIXPpSKWBMuBeIM0rRrFRsr+B4443f6+dd+yXzy4RT1hCBlXU+I7JbIfk5
         CYNZTnDICc3VYPt5GwUUTCBVST+SGJsu/y1zOi5uVyjWPY4nfUVjoX+wB3Tp1Kc8WCLv
         ahKyruvz05QKBCf5XkNicrviJ8KIq70g00/Px2vffHZBDhNeLPnMh+nEnyj76FLCw1Fg
         fM5g0a9latnpRQBtKqxoogrPqDYBM3SNYkrVI7D74dFIFJGTyO9YPNrI3jNtXrjKZXJ2
         wNHXpE+VF8mSY6ygnkwm/oo/mcfVJussDtLKcf2ECr4b3Z1K8Mio0Qmcm1XIhUZiHiLo
         gy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309850; x=1741914650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8W4lBndXbHt9de0ee6upN787KMW52umATu2vsi2G1s=;
        b=hYnxmWwyfXSOmVsfbQZ57bisGaw3UZzkwcKl+6hfsL9iwHvvc01VM/CJ5EnKC8O49q
         6dQ2NQjUft/2DeKPFV29doAj+zzQo4B/slrHsY9Iqc7Cei7yd5E++reNU6RgchApxjDm
         l6cJFpK4Wzi/wJpNjvD7pX+1zU6VIokZijdQ3Elz0jKedQ1MQz8ZKN5QI+Nqzap/ZjMs
         6TLzU8Fxlt/sY639eWal4ldVncE8oeK7oC7AygAnhDflW8mUcKGeUNAKZ1ha6Ea9Z13x
         UT2p/uJ6qvrGnojrMIxeVlxMdUFwTuzNe+vgSgSPXCl0HncPuPdDcMwDb+ZimZ2777wG
         iOKA==
X-Forwarded-Encrypted: i=1; AJvYcCVNFHApF7cQjOkpW1ggrUZnoMYfTEddoimNCCO345bb9tXRw37d0b82CQleF8DbqQ1xGbtyayjoV5+PrkN3@vger.kernel.org, AJvYcCVwtW55Oc6MRVMypHcoSwFzd7C7/nbcJrbwkX0fuWda/zazZ2uYkGqwstxUprJO+MwhOqfHSmcb+MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOp8l76F1LD8PYUzIxeA1svNBVeWMBcaLhkfXNTthrPoT9j1M
	+Gl8P8DD7jO/5i+AJJGmsMnwFwLwOVX4GkhT+FvpoiMGrEhQGt1e9RXL+cKTpV8e1EoNvON3Sx3
	Dzh2zU2gxr5lv7vsKi/16bkO3rvY=
X-Gm-Gg: ASbGncvWY/OyMf0bcF+Z1t0BKtqsX649ehG8gLq6pUzsf15SYEXRQvCCzF/9emFyuGf
	fuEQH8SH2Xhj17FSf7rk/eq8sFO87rzuVvrysk36ii6Wdau2w+mVlaKZh+462wTygr9xL/W0+Dr
	EBidQDkfyGMuNhCKx02va6TGbtTEPU
X-Google-Smtp-Source: AGHT+IHcxwy2elEu5fwV9PGx1saik9Pw4IRZRUb5LxTYzJmaYAjPccFT/W64mJXJreBTFyx+w0ryjVybFCrO+CIEJ/Y=
X-Received: by 2002:a05:600c:6d8e:b0:43b:cc3c:60ca with SMTP id
 5b1f17b1804b1-43c5a631736mr8352965e9.21.1741309850252; Thu, 06 Mar 2025
 17:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt>
 <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
 <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com>
 <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
 <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
 <agqtypvkcpju3gdsq7pnpabikm4mnnpy4kp5efqs2pvsz6ubsl@togxtecvtb74>
 <mjyjkyiyhbbxyksiycywgh72laozztzwxxwi3gi252uk4b6f7j@3zwpv7l7aisk>
 <CA+fCnZcDyS8FJwE6x66THExYU_t_n9cTA=9Qy3wL-RSssEb55g@mail.gmail.com> <xzxlu4k76wllfreg3oztflyubnmaiktbnvdmszelxxcb4vlhiv@xgo2545uyggy>
In-Reply-To: <xzxlu4k76wllfreg3oztflyubnmaiktbnvdmszelxxcb4vlhiv@xgo2545uyggy>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 7 Mar 2025 02:10:39 +0100
X-Gm-Features: AQ5f1JovwqbYdeSGr0-fcudbS7_ChDFAODKKUUmrprBtHFAHDoFjM50Rrc6n6VI
Message-ID: <CA+fCnZdE+rVcoR-sMLdk8e-1Jo_tybOc7PtSp9K6HrP5BEv95g@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Vitaly Buka <vitalybuka@google.com>, kees@kernel.org, 
	julian.stecklina@cyberus-technology.de, kevinloughlin@google.com, 
	peterz@infradead.org, tglx@linutronix.de, justinstitt@google.com, 
	catalin.marinas@arm.com, wangkefeng.wang@huawei.com, bhe@redhat.com, 
	ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, will@kernel.org, 
	ardb@kernel.org, jason.andryuk@amd.com, dave.hansen@linux.intel.com, 
	pasha.tatashin@soleen.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:08=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> But looking at the patch you sent I'm wondering - are we treating the ari=
thmetic
> in kasan_mem_to_shadow() as unsigned?

The shift is signed (arithmetic). But for the addition, it doesn't
matter? Adding an integer to a void* pointer should result in the same
value, regardless of whether the integer is signed or unsigned.

> You wrote that all the ranges will
> overflow but I thought we're interpreting the arithmetic as signed - so o=
nly
> positive addresses will overflow and negative addresses (with bit 63 set)=
 will
> only be more negative thus not causing an overflow.

Ah, yes, I see what you mean. From the C point of view, calculating
the shadow address for a pointer with bit 63 set can be interpreted as
subtracting from KASAN_SHADOW_OFFSET, and there's no overflow. But on
the assembly level, the compiler should generate the add instruction,
and the addition will overflow in both cases.

The important thing is that both possible shadow memory ranges are
contiguous (either both start and end overflow or none of them).

So this was my brain converting things to assembly. Feel free to
reword/clarify the comments.

> That was my assumption when
> writing the previous checks - we need to check below the overflown range,=
 above
> the negative (not overflown) range, and between the two.

It could be that your checks are equivalent to mine. What I did was to
check that the address lies outside of both contiguous regions, which
makes the checks symmetrical and IMO easier to follow.

