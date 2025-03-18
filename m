Return-Path: <linux-kernel+bounces-566435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7413A677F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3983A9552
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BF20E71C;
	Tue, 18 Mar 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNV7p9xU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEB28FD;
	Tue, 18 Mar 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311982; cv=none; b=JA1mofgDt0Baz0N/SXyISuRIQJhahse0t6mfKA92LzOmzZGYTk3O4t6gwlF2W3yOI0e5aaxxT56dznrlMxFWsL0PvH/5tULuMOeMu8HyW95ngKOtM/qpEaPcXpcJRPb7xF85fbB2Bpaf+Xk2NPhAg5o4Zme/OAtZSXgpQt/e9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311982; c=relaxed/simple;
	bh=68y8GkdAQLX6Usa7pa9vQcmtnJMUrq8yth4Y3tc6GKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaDhXSdPvrb/ySBYDLqY2sEfBxT8nibSnUt9o/FZutYZodFVvBHLkvUpkplCPQNpHfMlUDK7pvXP2GYBaCbWsHwzX6q6VNg/fAPyUQ9ABLutBIE42w8qrmLwFHgoJ4G/1QFedSeQ5CbySx5llUhHIoCGWmWy5dzHP+efddtcyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNV7p9xU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so35011925e9.1;
        Tue, 18 Mar 2025 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311979; x=1742916779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68y8GkdAQLX6Usa7pa9vQcmtnJMUrq8yth4Y3tc6GKw=;
        b=jNV7p9xU1IVpUrXrawZuRg8n0h0KgiKl3qswWdQ1nxkV/OwAqEA+AdTTzzLP6QayjN
         IhQ/NyTiPerp/eITygANEhe3ftT6hPr8eYzeg/sWUcGBA0xVKzq1mREAHi8WF/25EnJ4
         wZj8NqJk3nV3YWPxuqde2tA/aFsdmG35xWqesQRjQyfEQYe2Q7qj58gqa3Kp7se9UW65
         a5N5hM0bcaB3x2Y7Sdyq/thzWwOMrqT5FvdjML0AEewtjzbn0liS6jZ+t9E7ESLEI+2Z
         /8V8LNo7WucHobogIR5WLed2D8rKZnycdGbpJVYs/PbMR9QD/IbdKUB5D58SGTxCXbME
         1NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311979; x=1742916779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68y8GkdAQLX6Usa7pa9vQcmtnJMUrq8yth4Y3tc6GKw=;
        b=waSE6fIfSye41W/d3NCLzKP3bmx/XKWZ1wt7RQxXD5h01RJLV4cBBnccBXqZBHjVdc
         HvOgK98BCgC5P7+Ua9xdN87cd7Nf1g07qCQFkQDScoLoAbxiAh0Myv5hNzMVpKfRaPR5
         ROUBoeaU/gHKiP70Z2WxR8Vfs+D5HN1G2fVIyzvi6oNaEv2eLS5lP2dTbJjqX5IIw4zo
         DuiAbioDVXWkpMy1/dAqlDPXgO5URLxS5xv2VG9niyb0Pyh8abgP2ovqplFTPkRxDKp5
         7S5b+/LoN96yGOi11xh9ZP7G7TZvK3GlNXWuBcNSSkh0DeiVYIWOQPTCDwZ63z1/2z6C
         Oahw==
X-Forwarded-Encrypted: i=1; AJvYcCUgBu0m9klR0YoP3U+EFNASR5VK0YL1I8RNISKEaabage2GHOatM/fdXwKNyfQ3Dlw3EADV5zVMaOk=@vger.kernel.org, AJvYcCXvrjFtAFYHGum5FHJASTrqb/C8te+ql+AnnFB9ldblN8YXwnylqgcwMrvXVR1D+IDJQeA1t+a4EuYxXVF0@vger.kernel.org
X-Gm-Message-State: AOJu0YxcDFCxySDze4b38AVcJKQGhhoj60NaYrg3MmMLHeAPa84lH3/f
	/a181ejhzPFEVqxEMlHplDl8auGXHYXJ5pGeWwdnLhgqXsUoTbwhflS8rAU9ND2VbJXabHnv/Ov
	Vp9vHh8jbXbYC5vPxTNc3GhGFS90=
X-Gm-Gg: ASbGnctWM3lVKCUr/lusW9igleYpUGthJS+apqqHOmWDsI+3a7o7t+t6IB0c7sJZ/p3
	3OQseMX10ZIuNh/H+A7fyI3fOVbgOtGaOsPdcptS3ZGR9ZSXmU2OyMsEmGN3Xo1PU4MIxuObNx4
	GHw3GUSKD2a2wpOidkiNqXexn+jmY=
X-Google-Smtp-Source: AGHT+IFUQsaiMRIvtR5jHluzCMQLuQzpGcI8hgAnBbkdkQFmyrZjRH1+Z3aerVqSjjiLZTXQuXJjMTVOJy208Ija/YY=
X-Received: by 2002:a05:6000:1447:b0:391:3207:2e75 with SMTP id
 ffacd0b85a97d-3996b45f0d3mr4021787f8f.18.1742311978657; Tue, 18 Mar 2025
 08:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <CA+fCnZfb_cF1gbASZsi6Th_zDwXqu4KMtRUDxbsyfnyCfyUGfQ@mail.gmail.com>
 <paotjsjnoezcdjj57dsy3ufuneezmlxbc3zk3ebfzuiq722kz2@6vhollkdhul7>
 <CA+fCnZcCCXPmeEQw0cyQt7MLchMiMvzfZj=g-95UOURT4xK9KQ@mail.gmail.com>
 <aanh34t7p34xwjc757rzzwraewni54a6xx45q26tljs4crnzbb@s2shobk74gtj>
 <CA+fCnZdj3_+XPtuq15wbdgLxRqXX+ja6vnPCOx3nfR=Z6Q3ChA@mail.gmail.com> <b2bioloa3qsueqiyjadi5zsvi63v6zh3vwzji4ed4dmsxkaudb@hrxzs4vh7wjf>
In-Reply-To: <b2bioloa3qsueqiyjadi5zsvi63v6zh3vwzji4ed4dmsxkaudb@hrxzs4vh7wjf>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 18 Mar 2025 16:32:46 +0100
X-Gm-Features: AQ5f1JrJPlldmh-W4saMlKXW0Ok9D48DqwKxa7GZ64X93-bATE_KAdVxzbhhhSM
Message-ID: <CA+fCnZd2xPEwMGP7QRSyqHAJEbs_TY8Pg1ijG0iDFojMzphnfg@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, mark.rutland@arm.com, 
	broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, rppt@kernel.org, 
	kaleshsingh@google.com, richard.weiyang@gmail.com, luto@kernel.org, 
	glider@google.com, pankaj.gupta@amd.com, pawan.kumar.gupta@linux.intel.com, 
	kuan-ying.lee@canonical.com, tony.luck@intel.com, tj@kernel.org, 
	jgross@suse.com, dvyukov@google.com, baohua@kernel.org, 
	samuel.holland@sifive.com, dennis@kernel.org, akpm@linux-foundation.org, 
	thomas.weissschuh@linutronix.de, surenb@google.com, kbingham@kernel.org, 
	ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, xin@zytor.com, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, cl@linux.com, 
	jhubbard@nvidia.com, hpa@zytor.com, scott@os.amperecomputing.com, 
	david@redhat.com, jan.kiszka@siemens.com, vincenzo.frascino@arm.com, 
	corbet@lwn.net, maz@kernel.org, mingo@redhat.com, arnd@arndb.de, 
	ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 4:58=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >KASAN does nothing to deliberately prevent or detect races. Even if
> >the race leads to an OOB or UAF, KASAN might not be able to detect it.
> >But sometimes it does: if poisoned shadow memory values become visible
> >to the other thread/CPU before it makes a shadow memory value check.
>
> Thanks :)
>
> I've came up with a theoretical issue for the following dense series that=
 might
> happen if there is some racing but I'll have to experiment if it actually
> happens.

As long as it doesn't lead to false positive reports or crashes in the
KASAN runtime - I think it should fine.

