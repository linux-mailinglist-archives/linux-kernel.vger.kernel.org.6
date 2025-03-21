Return-Path: <linux-kernel+bounces-571936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46498A6C472
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDF1B61011
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056FD1EDA20;
	Fri, 21 Mar 2025 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc61kHvd"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87664A00
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590049; cv=none; b=IovSuWHqkezDcrNO7D2HiY5h7PwtDsSDfJhkbDfVgbpJguVSs41VFhLPD7WGi4sfxG2kqswlFiRuSA2FDheNCsCYP3BdrcIjoz+B8jLWQitA0bfJEvShchokJGUthseNGZQhFpdbXngo51MrKbha4NYAzE5MPs6YX7YnrN/vv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590049; c=relaxed/simple;
	bh=ehLx4BfcXIkstbQwTrBvBWDcNjLbE3ihDPBz7Pqh1xU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr5537DoUbYh5LsBYu5nyFaP3hRGnlxoH1zLd7xE5APvr73m7SjUjJ9uIcnEPw/pFEZmFbZlVjb3y196iIgW9VjoGM9YLJiXOGbDKV42E/FwoSvYkKcnC368zRIAotB5URhIe3KzaL7Us+/zrtV04y681in9+/qQ/f/91fK3SZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc61kHvd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948021a45so19048285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742590046; x=1743194846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND0e3RNSWvx5KkHJbkQWkYjoDHtfIfYJu6MphGZCA40=;
        b=Xc61kHvdBTjIWvgV5KoOT2/Yahx2vzs3L3LjjZ6BHufRl4kBU+PdpXP18yUMH8b1O6
         RPoSXtNB3IzCiwkvMz8K0BzdB58N/QyyJH4s/Xp+apjJxN/GsGn55h0Pew+hodrllC95
         my3FXUQ5ERRS+SDg8GICGD7veDCH7ZmV9qRVuk31VzvVd1gGlb1a7K76qBCBGnrkOEfA
         AIHzWPcsWRJ/avo+d287NlYotfbRAJ3LJBIYkjH030Dy9zG4oklxudwVF3AXhpB0HUHk
         mjoIbJguN9A2QhoKx4YJeNkU4oMGUEitLSQ9+pKDpr55ltwcTyAYTQOSUB3UnzeWFEur
         DJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590046; x=1743194846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND0e3RNSWvx5KkHJbkQWkYjoDHtfIfYJu6MphGZCA40=;
        b=b4yM25dR2QRcNrYUh9qRDGOJDQSz0Oc3v+S5TVVSfgkEmLglBaF7Rr9qzuvZzZA+Md
         ZaXRUer0zI5DLs/LIODVPfL2fEP8egV2VGKUw04oZdbirQ2oS7whtzuWt3bLjNjpCjEl
         DvyO9EN0UwnOg9npqxK2R/UOIcvQeSvzU+3uKSqdSbBY1DTuasIiJN+R8k3VmZyGtyPH
         I8vlGMT/6c05z0qJ2N0iI5BHpHiJpMY5VbmdavbHCVryesJPzYr5I1pzR85dMMilzGGw
         PHp+WLpRURrEBFOAplj0jUGh1cXDlMJzav5q0C1KSICuPph7INqva49GXcDriCuSSFaf
         7AvA==
X-Forwarded-Encrypted: i=1; AJvYcCVgJuHpQ8kbU32hM1f/AlssvBJ+gteBgUUQdToYEx/7FaKZFyq/WaW6AkJExwkT5M6J6Km9C0Y4E1UtINA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFFnhjdbgYzvL7RnDbD2L8xaYuvPxv7pDh+IjShId9v55yFcM
	y7Fxr7bM5/blyCH3YPI16GZmc4UvWfmV5EuAeT9FzLB2WhOi3HbY
X-Gm-Gg: ASbGncvzVFc44h50px+PsAs2MIPOd6zicd0rRbOY1HQqjKK0qLmt+PBqHHS4bFGGWpQ
	5jd7z3apO84CzBNQzDJyCZilOpYbNIGrluisw50wNJ+r0IcH648jxRg57x5ltI3EpEt2k4Bt4Li
	1hpxeKIegvf26bFXsyVAdFGw6VEVQUU2k/9w4vC2WEKODw+leNkUc+d9kgdZtAYKLYr1z0E2BPN
	/C/mKZgF7UvPhRGJTB5TUP0bxG/MyAvxyxnTDy4g+AtRvOzivDbkIS8H4PYZ/MIzhu9IWWFVSi4
	jZZheRFIYP8/R62mrV0Qhww/GmDElM9NSwycGSvGziyzxTNjHv/nkn1YT/a3NJfyngpQqAm1Tra
	pNV8Szyg=
X-Google-Smtp-Source: AGHT+IEUY/YMDen58rtgjf2rDWUeHAUIuClJoBQZe1dZO5pGRH2VLewUMSXaKg2yQXYxdDhSMza5yA==
X-Received: by 2002:a05:600c:1d15:b0:43c:f1cd:3d78 with SMTP id 5b1f17b1804b1-43d509ea2fcmr35004905e9.12.1742590045586;
        Fri, 21 Mar 2025 13:47:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d42b8fcd4sm54024495e9.1.2025.03.21.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:47:24 -0700 (PDT)
Date: Fri, 21 Mar 2025 20:47:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, x86@kernel.org, hkrzesin@redhat.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com,
 atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
Message-ID: <20250321204723.1e21cb23@pumpkin>
In-Reply-To: <CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com>
References: <20250320190514.1961144-1-mjguzik@gmail.com>
	<CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
	<CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
	<CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com>
	<CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 16:53:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 20 Mar 2025 at 14:17, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 20 Mar 2025 at 12:33, Mateusz Guzik <mjguzik@gmail.com> wrote:  
> > >
> > > I have a recollection that handling the tail after rep movsq with an
> > > overlapping store was suffering a penalty big enough to warrant a
> > > "normal" copy instead, avoiding the just written to area.  
> >
> > Ahh. Good point. The rep movsq might indeed end up having odd effects
> > with subsequent aliasing memory operations.
> >
> > Consider myself convinced.  
> 
> Actually, I think there's a solution for this.
> 
> Do not do the last 0-7 bytes as a word that overlaps with the tail of
> the 'rep movs'
> 
> Do the last 8-15 bytes *non-overlapping* (well, they overlap each
> other, but not the 'rep movs')
> 
> Something UNTESTED like the appended, in other words. The large case
> then ends up without any conditionals, looking something like this:
> 
>         mov    %rcx,%rax
>         shr    $0x3,%rcx
>         dec    %rcx
>         and    $0x7,%eax
>         rep movsq %ds:(%rsi),%es:(%rdi)
>         mov    (%rsi),%rcx
>         mov    %rcx,(%rdi)
>         mov    (%rsi,%rax,1),%rcx
>         mov    %rcx,(%rdi,%rax,1)
>         xor    %ecx,%ecx
>         ret

I think you can save the 'tail end' copying the same 8 bytes twice by doing:
	sub	$9,%rcx
	mov	%rcx,%rax
	shr	$3,%rcx
	and	$7,%rax
	inc	%rax
before the 'rep movsq'.

	David
	
> 
> with some added complexity - but not a lot - in the exception fixup cases.
> 
> This is once again intentionally whitespace-damaged, because I don't
> want people applying this mindlessly. Somebody needs to double-check
> my logic, and verify that this also avoids the cost from the aliasing
> with the rep movs.
> 
>                    Linus
...

