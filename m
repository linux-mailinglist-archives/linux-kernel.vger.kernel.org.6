Return-Path: <linux-kernel+bounces-269546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD56F943418
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587231F2272C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767601BBBC8;
	Wed, 31 Jul 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LIrqMPvs"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B61799F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443089; cv=none; b=gPLGNcSBtZ0wrrI59lOax3X4COYockfELKdZIoErG6UjLzkla7+J9U9iMfvSfODGqRx9p42s93dbRWX58CRb2Xiaf8gdq3lI8ZXKk/E8yDH/SMWscuTHNXIlv+Zv/Vd2sAOQGaw5s1rWaRweNYeHnmOlrjXvwDbJBlTCYydkxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443089; c=relaxed/simple;
	bh=rUd0cGf1on+FxpG5Hc3Eyj6ypoiuk37DKP2lEMkiEd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqIQwRCt7v8LPijOv4VciyUWkvZWFL9J6vJbPaqcq5euJWBj5bYvTgv2YUXGTUBN2ZgL03WIPElO7dttGRhvzSqg4o2HOClZ1VIAT3PXV73p5QvUO1LbmJWuVk+ArfsOpNKPB7V2a/1d1Q9Od3MaHOZ/USFG6u+hVK/3ex8pQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LIrqMPvs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso2393357e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722443086; x=1723047886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrUX2Uh96Y1NL/ryusQ3vQnFbbcC4JTSkp0ngC+rWQk=;
        b=LIrqMPvsRlqogeZge90TTpPhne37kfQaBwgsWJyqm5MVTOGn9/nQgCVbu3wMiFFNPr
         y90iHWDz5b+5/7MjbZTCZJodDWYNK7nqQOhvGV7W+HuU5Kq3IYtgJ1AXO8qALFjwkI26
         K+GwApoLxznC9D6752VA0XKfwbfuMwP7sezf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443086; x=1723047886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrUX2Uh96Y1NL/ryusQ3vQnFbbcC4JTSkp0ngC+rWQk=;
        b=lyy3jl8U8uRkaBCk+JLK6KQ/LpXiTMiRODN0o1o+lgDPyn785FIl6C412krJN9f14q
         z8NCSNeoWisP0Wq3kkmp2k3i4U6Drf343MTBou6inn4lofHp5RhCEC64acLkPuN2NlRL
         0v/KzFtwBTd1UWvzY+d0lmmwwCodWmTVx25ozdhsTMGRt0R24rA8DQ4143Q6o31d/QFD
         xFgTXbK3gquwkR9F0SriTkbC8ceQbJ9qveygp7J6p+vYLXdyTBhcQbtYlnhNC0YMnO9y
         By7knvGST/6ezOEzVxEIddmGvSA+CetAN0354BLAv2MTDJax+6PdQQaXOVTHA5zoeGzR
         Ukkw==
X-Forwarded-Encrypted: i=1; AJvYcCWck+DyivmLvl3+L3nsKccIsfiJvpHnCA831gKMQNOma698StP5QaeRXtgXluJGwKMRBIBgV1yI7vaok4v67pFF898X50NGx9YsI5Jm
X-Gm-Message-State: AOJu0Yw+y3RguToNRfne74jB0z9Byf+R1Hb3F6ntPn06yektO/Xucmdi
	URznia7cj2HSICZLXJJNbv5HYBet5kaxVNzenzWE1uC6qG2xb7ppOjjBfPA4zIgQHTmxAURZ38E
	3P2+c8w==
X-Google-Smtp-Source: AGHT+IHGh6oiCH0t5u7H5tKjzXJQe2c9cU8zHcK/nbxtegC/b4HHIpuoUb87OsL8VsAsFdIthqLAew==
X-Received: by 2002:a05:6512:2c0d:b0:529:b718:8d00 with SMTP id 2adb3069b0e04-5309b2694e5mr12496710e87.8.1722443085465;
        Wed, 31 Jul 2024 09:24:45 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad411d2sm787311166b.126.2024.07.31.09.24.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:24:44 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7d638a1f27so282878166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:24:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBJNasHLNBUfl3L+/66dIf5MV5ZlJF2OiUiQdmRrUAw7gRGWRDhrG2ZQMyWt7FQbtOD9YIvY8f/0KMTiavw3Vw5Pc7wxRf6wHKZ8RV
X-Received: by 2002:a50:cd13:0:b0:5a2:80f:a6dd with SMTP id
 4fb4d7f45d1cf-5b02184b896mr12768983a12.14.1722443084374; Wed, 31 Jul 2024
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731073031.4045579-1-davidgow@google.com>
In-Reply-To: <20240731073031.4045579-1-davidgow@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 09:24:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjx1qBON_8+N2Mte8=EtpVRHNa+JCxbBnJXGs3=wF0c0g@mail.gmail.com>
Message-ID: <CAHk-=wjx1qBON_8+N2Mte8=EtpVRHNa+JCxbBnJXGs3=wF0c0g@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Zero the 8-byte get_range case on failure
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 00:31, David Gow <davidgow@google.com> wrote:
>
> Fixes: 8a2462df1547 ("x86/uaccess: Improve the 8-byte getuser() case")
> Signed-off-by: David Gow <davidgow@google.com>

Ack.

I'd have liked to minimize the #ifdef's in code, but yeah, this fix is
obviously needed.

My bad. My mental model these days is the 64-bit case, where the whole
'check_range' thing is about address masking tricks, not the actual
conditional. So I didn't think of the "access_ok fails" case at all.

               Linus

