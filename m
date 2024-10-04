Return-Path: <linux-kernel+bounces-350564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DAD9906D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B07B24AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134A12178E3;
	Fri,  4 Oct 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPw70e0r"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774E1CACE9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053426; cv=none; b=l507rAghYl1KfQsmm1O8znbsaMMVy3EVLNiqlC2OhtkpenL2hcgVZy/4Fi/bW9GbFoWmePn6b1UFH5D8B/nCmYcWEXS05zjyIr2Pr5C+13aGvk+vQgkgHx5Z/4Wz12ryi4NTtXhyHhnKdwwPvZ2alsRBssnIeYHCVr8Sz6Rjsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053426; c=relaxed/simple;
	bh=LdW3UEgWBNutR+58RAbUeVOQb38u3IT4Cej/3Sl76dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/wkCV1dWIwJLurtWcEXn3Iya0Ly6DQXOQCgIeL9V7EZ3dKJcoJvhxGPD+8f3LeNI16zwhHWkF6KQh/rEoiNKCYTS38nlo4Cb09ZB4R8PRrzlVia2NJ06hTtLOZsP08bRR5nSPXPlakMUgX5BR2OYlN9gThAlTRmv+i3SSilB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPw70e0r; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e137183587so1891009a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728053424; x=1728658224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0iYyQjY9l/Hm6uV697ftkwU4KvJRwNy+C34ebXXW2p4=;
        b=DPw70e0r+pqc3C8ydu3d9NL67xQhL3hAJbIhDNME4AfXebpgW/3uAoL7bW3PmHAHcL
         TaIn43AKx4AmpEoW0yH3ErhdVuWbOFyeGaF3UcqoK7WRDeSKjwqHxuJYtXtbT+BYrZxG
         9ydtUqvvAqjYkqJ5APVJP/M42pbdhzzsSjzovi/XB22BtSap1/W7WfFPyz58TEvi27dJ
         jJZ4D8IgA5p75lCSkT+tU7htE+d8He243vkBPQPfsQyCpM9bdF08p5Ol9axQhFNn7d1+
         OE1ZO6DI9Za80r9ptXNl90lMT7mGkRCsgdQqu3ZbTWB86jXhxio3c5LW1s+viSimKcii
         MHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728053424; x=1728658224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iYyQjY9l/Hm6uV697ftkwU4KvJRwNy+C34ebXXW2p4=;
        b=IGAf+pBPCe/UPBhMnUFxjpyZIEXq5XSSMnI8u/npsa/Hj0K1FgpAR43ypug0FcZ/DF
         iKyXVwi65/NkxskFPGDuwKRff3KmjErJ65KEVLgceebcm3k4WUPRPeGjyk7XcHyEZaZx
         SGazUjX9wmzRXxToKJIUfodt2o6JvDcEesCOfxmG39BR0uMA8O3f1dazwhMnG+D6+BiZ
         /mY+tXkP8TrBLfXiBaH6epWiweQBbPxYA0ARh0yNSSlNdS82j1V+ISCeV6nVvBBP+miU
         dhahYYsbQgVrdTvY7bo0iP2fupa1Q0ncXBPHxa/ydx2CRIULSDNsQ5QlI/uD9/jGnlKl
         Phsg==
X-Forwarded-Encrypted: i=1; AJvYcCUiml/iRzvCenybuMadOgoYw/7ECaShTKCEkYFXhhLBK1XqFAwKGf4n2bepT0vhMLNUguH+7jhYNZbAIyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicOAqidYFpujtgpe1r+O+Y4+ysGY2rJjgWMaNM0qJRN7vaKhs
	YbUyV8qexH1w6Oxtyh77A7PWARQCnmm1BWCCj6aZHsvKKzA6V31rM7cNmm8WUHj5BbeQLWaoc7+
	sx7s22ok7Pkkv3u+vIHZ1Z2QMeL4=
X-Google-Smtp-Source: AGHT+IF5IC1gwxI+aw756xi7KHV4VtxMtcLesqQhTDuECFzNrcNninDtelTrg/3KomYxxGW2E7G6xWl1j1ybLe0RxZY=
X-Received: by 2002:a17:90a:7084:b0:2e0:74c9:ecea with SMTP id
 98e67ed59e1d1-2e1e622759bmr4067501a91.10.1728053424350; Fri, 04 Oct 2024
 07:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004142504.4379-1-aha310510@gmail.com> <Zv_87TBZnh2lIwyH@casper.infradead.org>
In-Reply-To: <Zv_87TBZnh2lIwyH@casper.infradead.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Fri, 4 Oct 2024 23:50:12 +0900
Message-ID: <CAO9qdTEZW74N_XDM0N1UkRy9BfrKE1SL-S4h2bvtEJ9QROTETA@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 04, 2024 at 11:25:04PM +0900, Jeongjun Park wrote:
> > A report [1] was uploaded from syzbot.
> >
> > In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to skip
> > slot cache"), the __try_to_reclaim_swap() function reads offset and nr_pages
> > from folio without folio_lock protection.
>
> Umm.  You don't need folio_lock to read nr_pages.  Holding a refcount
> is sufficient to stabilise nr_pages.  I cannot speak to folio->swap
> though (and the KCSAN report does appear to be pointing to folio->swap).
>

That's right. It looks like KCSAN log occurs when reading folio->swap.
In fact, since most of the code reads folio->swap under the protection
of folio_lock, it is possible to modify only the part that reads folio->swap
and the code that reads offset to operate under the protection of
folio_lock.

However, even if reading nr_pages does not require folio_lock, I don't
think it is very desirable to modify only this code to not be protected
by folio_lock.

Regards,
Jeongjun Park

