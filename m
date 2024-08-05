Return-Path: <linux-kernel+bounces-275274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4163194829C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EBE2835DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE716B743;
	Mon,  5 Aug 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DNGd0h1H"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D590149009
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887474; cv=none; b=edytjmMyPo3oQNtWzWM6pXrkidFnHYCMX9DPpScJQdjNvy/zEOfjxKazjyQpjor0xF9wS7YyApyxDgCv2zygamzh4Re9mvujljQEO2TkTIXeixOM8J3a7iZqy28stbsn7tyaSM0+F9+uZz93dh/G+jewmzOzWCdomYB5V4A8rAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887474; c=relaxed/simple;
	bh=RnAVL1F8Zc5pFSyUaXWapLKKpniVvPkLdg4oxhP2wTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYGEG/jmkm/jD0qmvaaedaQYdZqi4xVjCg2ybR4B2Cm2K5Bo8PYxp3Cr8wJT0lS8Ue5WczVPCXdt2zaqug8RGiIX7iRhSWIg6Ze3CqEFcJFEU6EoO7h1JGtdLNPrd6UJ46HLfFn6ETmc+9rLEPeEYV++xXyZxbZKc8gXf3REQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DNGd0h1H; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso11760615e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722887470; x=1723492270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIYPIC0BflVMuV8NaYQS5YL8fh1QrNDyHT/xu/wxw5U=;
        b=DNGd0h1HGUURXrVkwefMyCWML2OHxWIFBq8CA/WJWcEEP4yXExGtBBLf0ZdWUe16oV
         pmgaX3glPBtckV3rYBHK++CK52+tba6ua+/4y+7HQU78Q3IlG3Vk+r7gxIa1VmiXg+3K
         Ys55BSjAeGD3KyjTpR4AdJnNPTHG87mnL5Dlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887470; x=1723492270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIYPIC0BflVMuV8NaYQS5YL8fh1QrNDyHT/xu/wxw5U=;
        b=t9D7F0AjSWLsYjqe+QAeRbsST3cXn9RC+PEImUWp/B2NqhmuI4u78ov8FstqQwgHfY
         eskyi6GTplAwtS4GEHT66AwUMwPalKCrbERz6nOVXrcm/M+bKyZauGG++szoP/a4KmO3
         PA7fCmQNUWNmRwYA9AFNFafqh9JNu1uzvr2HUqvWHtRDhoYRUYELWD+b7v+aLpDMc/6I
         Dqqu/NnWZvtAuNiC10VMkqki7RElj4UykDDN++hKaILHPbEe2FYnHQm0jwOs6+5u56GS
         OVODAhfcgx2sZB/4BjRroYE/EfgJyTQfR/I7OPaXurnOGmTaacO2xdrVU3n311WiF7PR
         9azg==
X-Forwarded-Encrypted: i=1; AJvYcCW8EGthr1o1K1AHbGWR1IPH/21r91h/bXm7ekdRNJY2p7F+M69beVAebblSTqbBUMXQgZUA5GWQVY2S81Vdt5dxAoxl+WdgJQbo6a6B
X-Gm-Message-State: AOJu0YwtBlXGt1RqGLqGLRjfzoPMe/HQqXmJuRGwihT9hkMpLcga8rLP
	ZkuBkSYp12NgZVCVV0onzi2v3lC/PcrXfyQEiSJNCyNI+B9kW10Tw83Rg6yp9DyZ+Z2BjxrjpQu
	V4Gp1Ow==
X-Google-Smtp-Source: AGHT+IECBvbKn/GiBWMvYYtpNGlrtFgPKhBs/5I2cKw0jnjaLlssJpu76q8+EgCuPw+MRImKwef0sA==
X-Received: by 2002:a05:6512:1323:b0:530:b871:eba9 with SMTP id 2adb3069b0e04-530bb3736f1mr12110153e87.1.1722887470023;
        Mon, 05 Aug 2024 12:51:10 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10de2sm1222326e87.71.2024.08.05.12.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:51:09 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso152657951fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZK2pe+dKTyNrmaaYGBaGVW8GEUwP8n8NCMsSGThu3J9d+adeAUZAADEgdvxvzd68EqsJnhLj4RhXQU8wlgL9s28uvtqtSHqqPwLKu
X-Received: by 2002:a2e:9845:0:b0:2ef:20ae:d117 with SMTP id
 38308e7fff4ca-2f15aa88cc7mr104885471fa.10.1722887468283; Mon, 05 Aug 2024
 12:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com> <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 12:50:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgP0hCD-05rfvWcVmizzx676WsR0+iEuVwQUMSFFnM8kw@mail.gmail.com>
Message-ID: <CAHk-=wgP0hCD-05rfvWcVmizzx676WsR0+iEuVwQUMSFFnM8kw@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Jeff Xu <jeffxu@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 12:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But x86 has the same context.vdso logic, and does *not* set the
> pointer before installing the vma, for example. Also does not zero it
> out on munmap(), although it does have the mremap logic.

Oh, and the empty stale arch_unmap() code on the x86 side has never
been about the vdso thing, it was about some horrid MPX notification
that no longer exists.

In case people wonder like I did.

           Linus

