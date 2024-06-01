Return-Path: <linux-kernel+bounces-197648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81A8D6D7B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0D8286353
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88754AD27;
	Sat,  1 Jun 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDLTJsB5"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51C6FA8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717208422; cv=none; b=DEpq2mwMjbeykOWo/9/2vinYDyZWppCxWtGiXFUXmoyMXPGggtJen7ddhq3ZPfhbC5LxQnb9wtViSsnvOthr/8J0yXFMXsZNFXIB4Ndc/jkcebq4YS8lPioRA2iAM2D7eoh4fjktegfzAawl2KPhriv5kLoVZmpy0F0u3a7b4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717208422; c=relaxed/simple;
	bh=d9Lw8NUoUCIYQ+yLxVSF49sOJheG/9m65dkQ42MAi74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPJgm5UfeG8KWjZaGv6ntm4dcmh1jgmuP6itj/cPbHC43CJyGVWbYNrdH9AJ86jaiMf+mH9++/sOtkXpWsuuHsr2EY8GfL1x1iqiNG/beIaB7frJ8yGgSElQUdpQf1scquuq2BJZIwvnbHmS00l4UxzcIroUSBXFYrQCM32rbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDLTJsB5; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfa59545e0fso2564799276.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717208420; x=1717813220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=29hoWkRwJJopRTaD5yxwEHHavNk9SWern4C/CoRhJEA=;
        b=NDLTJsB5DwCFDe7c+v1B8VhRsJTlF4PTxZ99j3+X605Y7q4/lKZEpUI+xkQc+nlB2N
         caGDPhkBTfHQ3TOSWaBSqQ/EX0jdKJ7YX7WE3m5fANwz+iRc8hj6OR6Tt/jsuBA8jwAn
         YjtQ/mYBCwmGIfZmD8TW9RXda/H2NiOvHUaWT1P95kRluZ7LLTp2hjP1DNCkJbKRh/Wa
         WiarBpjelqXMAWShE9aipe5g6OgBsa2vJMLZwad3u8Wx4oot8xrv5TGZrkJbYsxc/vR5
         Tfj2PDKqwSgttJdh2Yqjgsh/teke+tS+X48dpYL+zfFrQ5lqWNC/xUcSawXazLKvLrUb
         Ildw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717208420; x=1717813220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29hoWkRwJJopRTaD5yxwEHHavNk9SWern4C/CoRhJEA=;
        b=WsEyaOM2+6hz+vyt9a7UIckjXyksYld7uQNxopSOyVKP4eaSrqxggnc5wxenv32089
         6dwGVELw3V5rcTZlyMPXFuMo4RxdByOXJqR4Ym8gxF0eMN8uBxTUMuNsdhz/OoRHBDY1
         eJSsAv1dj9pgyWZsNo4o8d3yYnzcP9qAdnJDUpwu5e+GfcmyrfvXp7hyDUx5uWRGPOel
         kfbMi8MmgHt75VYr37ab1HK4hJpeknsaHDqoJa0vr/FgOy44V1nNShuwAxHkd246dRaT
         flvvfjLlsmVWxZe2BLh+m/GiOucr98KoqNcLVjoMNdOnsP8uL1bNSYNSPWTDnbfJkN4T
         sJug==
X-Forwarded-Encrypted: i=1; AJvYcCWjjLh8OT97zTdAPGI7N+lxxRuiyMP3S4v1D1HqlCe/hUYkKELZ1Z9M0Ue12qxFCF47lyRpKG6KcSYyTzowUthHjCBFZcSkubkr5POn
X-Gm-Message-State: AOJu0YyyQvCTOI8Poox/dwpeJDggGkg+hpXusAxKMAp7HQHvrgHoBDFg
	Kj+8/kShXuVSXDFUu+YDv3PqGo9OVBMiNgQ3SMMXtfeM7IDx0FO5UC9FcjrypsIxHW4kRT2rxV4
	RDJxOmc1wkCztNVNR6xi3nJBrn4o=
X-Google-Smtp-Source: AGHT+IGy6bCFfl1yWZRJ07bao/Kf4yf50om6Rq/dNHAF0qvBIOgq20a3ir4uuahipLj9SFZjwUDi1umBu4WFLZDCRlQ=
X-Received: by 2002:a25:2fd7:0:b0:dfa:7513:59d7 with SMTP id
 3f1490d57ef6-dfa75135b5bmr3509883276.65.1717208420279; Fri, 31 May 2024
 19:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531092001.30428-1-byungchul@sk.com> <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com> <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
In-Reply-To: <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
From: Byungchul Park <lkml.byungchul.park@gmail.com>
Date: Sat, 1 Jun 2024 11:20:08 +0900
Message-ID: <CAHyrMpzU_f0TbEA6HpuqTFOBY7nHOQGXR3VpOeHzu62zQxvyDw@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
To: Dave Hansen <dave.hansen@intel.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, akpm@linux-foundation.org, ying.huang@intel.com, 
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com, 
	willy@infradead.org, david@redhat.com, peterz@infradead.org, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/31/24 11:04, Byungchul Park wrote:
> ...
> > I don't believe you do not agree with the concept itself.  Thing is
> > the current version is not good enough.  I will do my best by doing
> > what I can do.
>
> More performance is good.  I agree with that.
>
> But it has to be weighed against the risk and the complexity.  The more
> I look at this approach, the more I think this is not a good trade off.
> There's a lot of risk and a lot of complexity and we haven't seen the

All the complexity comes from the fact that I can't use a new space in
struct page - that can make the design even lockless.

I agree that keeping things simple is the best but I don't think all the
existing fields in struct page are the result of trying to make things
simple that you love.  Some of them are more complicated.

I'd like to find a better way together instead of yelling "it's unworthy
cuz it's too complicated and there's too little space in mm world to
accommodate new things".

However, for the issues already discussed, I will think about it more
before the next spin.

        Byungchul

> full complexity picture.  The gaps are being fixed by adding complexity
> in new subsystems (the VFS in this case).
>
> There are going to be winners and losers, and this version for example
> makes file writes lose performance.
>
> Just to be crystal clear: I disagree with the concept of leaving stale
> TLB entries in place in an attempt to gain performance.
>

