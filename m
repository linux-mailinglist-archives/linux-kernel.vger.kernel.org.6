Return-Path: <linux-kernel+bounces-566434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E6A677FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F81889119
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4CB20FAB0;
	Tue, 18 Mar 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9cIODXz"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC7212B0C;
	Tue, 18 Mar 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311916; cv=none; b=bnWsEmAsX6Idq6HGE6aQf7bzgMUokggAqs6qiXmgTTR4XCemWhoCaGY9yxerr4vkLOEAAOnjZnSvqO5WfBe2CslVlBZMvHmOgk1VV5x+v9PoHFusrppgCm0Qpo63Z4oGh7kXlDJ36hQQBVzQizt4JgfeageaHCNU0waG7e3EZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311916; c=relaxed/simple;
	bh=3K43m0CJ5P2Hs/+vHT2aH+lWnI3DWXrYwrbq8SoJBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtxsB0l6QC3e0iDtF9OaeIdGXW05tXpXqb11mrhBFQinAhLrvLmhrb+cW9t7BQQci/SDPpNHZNtCEQ3WQ2jHNpVHWlbjeomLD2LGja4f7WOhx9gv/JuvXMQumw2Mkj58CCe/gfBT28zFs5Rc+eXr1Sw1F5lCDvl5iElePu/fQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9cIODXz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3887015f8f.2;
        Tue, 18 Mar 2025 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311912; x=1742916712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CinvE4PqkImlncYqzwGrvxTtdjlYEnx4qMRt+q3DIa0=;
        b=e9cIODXzXfGoyRacDM06y4pImIgwtZmb9z95FhyKDC5WJrbdWJnbAO9yTie9TEqx7h
         K8ezIye/HJnmhi977Ozgz4PTscgGIPzg/SZWYlM2rfEjzON1M3lDnoS2PRov82Bgm/Vm
         sQM/yaPOjTZy4aVaW5/6o26oBLgr1uq1E7iW+uwfd5+534DzBwUZwvwI71pbGMNmwGhE
         yr08GiXHN5NPfSZ+1mQFiiTzq4ez4dxUE3M4PG4d6AVfyY4rbq6XeHYaWT7sdLtwnRl6
         vVu01vHR0QZwLlUmEj52r+nrgyymPvZ5AE7ncgzqS/EDl8xZsxl0oM8bBP6LBdJFsq9b
         QYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311912; x=1742916712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CinvE4PqkImlncYqzwGrvxTtdjlYEnx4qMRt+q3DIa0=;
        b=KqaMly0nSdzHDPxHayHQzjjhuK0ucOnW8LWpfeJ484SPOYJ1h1oBPBvsl+eVy8v756
         sucEKor+TqJCBjIgIxjvEnHwy/pKi/AK2TF2pFFev9sd++1g22L0aq5hGsWLNeDzU/OH
         pUZCSs5FUCjGB7HdM3Z7nDbzF0gQ6vKikOsbeGHa6t26RPasPHHHR+t6lQx+Bdkc0Lge
         xBDEEM1YoPt0TzENE8Qls4PrpymaHliZcgOzWBDts/gyinx1ufmTxwBSpNsD9dNmBO1U
         DHrYWuuTvrkux6VUy89DpwelmuEsiYyRFEJdoAbNdnfd+CkzOKJoDW2A7H7jMrKU0BJf
         9DEg==
X-Forwarded-Encrypted: i=1; AJvYcCUtbUhIgzHj5ELr3XngVfBNpSSRbWBzGkEBOXVaCQe+k9+GvRUPxp07yaVu07f8rdJleVgEbpGCkyk=@vger.kernel.org, AJvYcCVd1iMvcguBJmF7S5LRyxkTEWaLleXdVW12Lvq7aZNN1zcg/RqVDCDXq6ZDdlnppMKjoiptvQSxldoc7dbD@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiv312sycvoL9zw7fx0W27vuOo1JDczO2hFXjjzTS8KJ+3Ud/
	ms3rlhrOcCtp9k2mZZdtX/lXGMWxoeXtCTjKv6aukdBlOYYL5tZtZWelaLNnSe5E8sc3E4/t8+0
	NaEXw8GpB7CwK8lFvg2S5aHCN5C0=
X-Gm-Gg: ASbGnct5jFWX4GJvo9J4A6OpGkbiVKCC97SufdF4bqBAzaRVdKPOVPdKtsDEqwbwQYj
	jTKM3sQQScM/XL1ta0Covq07H/jLbJHGVF0Bg3EAEbZCeCNyKF/tNXeo4pnl4xr7gLdzVopNYjz
	NzsY/ser0YbCNlD6Dhmp17N7nMkDk=
X-Google-Smtp-Source: AGHT+IHWPKWTHbtn0upDeL/n8bU40gn0yInHJsN/Rx11n80rZjNU/L/rCSH6qMBV6U/AqlSRsE+U9L0kwT/++6fzLW8=
X-Received: by 2002:a5d:47cf:0:b0:390:f832:383f with SMTP id
 ffacd0b85a97d-3971d1348b7mr18713568f8f.2.1742311911851; Tue, 18 Mar 2025
 08:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt>
 <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
 <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com>
 <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
 <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
 <agqtypvkcpju3gdsq7pnpabikm4mnnpy4kp5efqs2pvsz6ubsl@togxtecvtb74>
 <mjyjkyiyhbbxyksiycywgh72laozztzwxxwi3gi252uk4b6f7j@3zwpv7l7aisk>
 <CA+fCnZcDyS8FJwE6x66THExYU_t_n9cTA=9Qy3wL-RSssEb55g@mail.gmail.com>
 <xzxlu4k76wllfreg3oztflyubnmaiktbnvdmszelxxcb4vlhiv@xgo2545uyggy>
 <CA+fCnZdE+rVcoR-sMLdk8e-1Jo_tybOc7PtSp9K6HrP5BEv95g@mail.gmail.com> <qacbgkfbfqylupmoc7umy4n5pdvpdp7hrok7hqefhamhrsnhhm@4e2qucovduw2>
In-Reply-To: <qacbgkfbfqylupmoc7umy4n5pdvpdp7hrok7hqefhamhrsnhhm@4e2qucovduw2>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 18 Mar 2025 16:31:40 +0100
X-Gm-Features: AQ5f1JqGFWmofpIZGo_iwNyrZk8kRGYUZ2Wq3IlRJd5hdIOL8VoWslIcfmDgzvQ
Message-ID: <CA+fCnZfwcV40i_78qY1WTdJc5PgRfvu-_7LERfJyPt6Xf8Ln9Q@mail.gmail.com>
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

On Thu, Mar 13, 2025 at 3:58=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >So this was my brain converting things to assembly. Feel free to
> >reword/clarify the comments.
>
> Right, I focused too much on the signed aspect. Treating everything as
> overflowing sounds better, more unified.

Alright!

> >It could be that your checks are equivalent to mine. What I did was to
> >check that the address lies outside of both contiguous regions, which
> >makes the checks symmetrical and IMO easier to follow.
>
> I drew this out and yeah, it looks like it's the same, just grouping the =
logical
> expressions differently. What do you think about incorporating something =
like
> the following into your comment about the x86 part? :
>
>         Given the KASAN_SHADOW_OFFSET equal 0xffeffc0000000000
>         the following ranges are valid mem-to-shadow mappings:
>
>         0xFFFFFFFFFFFFFFFF
>                 INVALID
>         0xFFEFFBFFFFFFFFFF - kasan_mem_to_shadow(~0UL)
>                 VALID   - kasan shadow mem
>                 VALID   - non-canonical kernel virtual address
>         0xFFCFFC0000000000 - kasan_mem_to_shadow(0xFEUL << 56)
>                 INVALID
>         0x07EFFBFFFFFFFFFF - kasan_mem_to_shadow(~0UL >> 1)
>                 VALID   - non-canonical user virtual addresses
>                 VALID   - user addresses
>         0x07CFFC0000000000 - kasan_mem_to_shadow(0x7EUL << 56)
>                 INVALID
>         0x0000000000000000

Sounds good - I like this visual representation a lot! Thanks!

