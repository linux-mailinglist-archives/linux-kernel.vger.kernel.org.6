Return-Path: <linux-kernel+bounces-241718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A5927E75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3CB284D01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A113C69C;
	Thu,  4 Jul 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gATVg5se"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298873454
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720127283; cv=none; b=cfFeMAJCrd1PvCnBX3n9OXyhY9pnfUyivAhI9UfZnHxPEwL0HdREAtmbBxud9v1XTPcIEvejMuiR4IUbHrPFPEhscOhy7DNisRHFiMIBii/Y6t2YzkbM2jECbTOt5Ld2HvgpD5qjNTvYoua40lqEtk3R9bKdjO/oXAXs3KyOg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720127283; c=relaxed/simple;
	bh=tsSeSJw/wskqqIQ95nhOCClgJITWSQXmHVQgcE3x0fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWmgaPvfjCnftb6THO9Vtz7x1+8xaUkayK9lS4NOuANJJIRxWWbWr2wr4L3v4CfPrtQx48yWz/YGKei7lLDBnrMEzOqpMp7VGACYoqdm0aJHdLDzktcLny2bdM37YPs2U1m9yo8vrUfBNIbUlO5Uz7qqAEf591ughm5/nsJo7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gATVg5se; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so14019471fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720127280; x=1720732080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PAwkodzaV7fvFpdWbJ56Wv8CLAuFVUCXlI2rcaicgMo=;
        b=gATVg5seAL5NonkTgcKp8WW+ToYjd+ZHSQDRcEZXs/OzASnl8kdRtmvxaIjPolB59Q
         fEtyltYML8psu+EEbx/296UMzi0JM1zQ4/t1KTY717TH1AA0n+EY6TrchoX+VFT18R84
         GrCroJjJWj2Y9gTRp+r8HT3DzTk3EIajp8WJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720127280; x=1720732080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAwkodzaV7fvFpdWbJ56Wv8CLAuFVUCXlI2rcaicgMo=;
        b=CemsXY/V5V9zg/QbU1eTd0if+vuOSSamibXy56JP+hOup0eBGIOkECN8rnFDVAR9cp
         b95pkZ+1eGTHq20YRCwCJrt4qUpVCKIESWiNH+e4TBlvucDXko5KQKGOk2S8Kvuwl1sU
         XGkFPpSnuNQVTcPmI5+2WgZ20Ua1whpeFerbHD8djIyF6wAx8zM6Dy/aQoJOuSiptH58
         xFpLBk3mpGpYmHtwHjw4qoHLCpqn0CBUFk8peyYEtDyZhMyojTWJL3iPrZklXrCte5hr
         QUc6FoS6lRFeAPzjjt8qdAJWZ1g12XSoq7Cutz3H3CDayVGxCJLlNmmSGHtchwT25JHv
         qECQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRIndhESzfyLY4T7p7ZpBbWEEH4YLUY6Ch0GGESCpXipgQXNcGb6rlXaeaoaB+YvqXLo96lXiqXtQsVEiioaNVaJGGKRD2d9v/VV9u
X-Gm-Message-State: AOJu0YyOeNBwmcFUXF34PrQlxhUJ1aixdpQu8K4lrnAYtZ+xExE+n2t9
	SXnVcRRMJZ96QU7970p6N6Ggp/qIVe+xEVz968ouU54z2OI7/ydkVOb+3mxCjtNHzjJB30fsUaK
	T6IDwzQ==
X-Google-Smtp-Source: AGHT+IF6tDppXEmkKibCH0LmKeFiR9Z6lDJz8RYoJImrxmBZTCTuyHsCWl7hmopYcKkKCYi+EYlTaw==
X-Received: by 2002:a2e:7e07:0:b0:2ee:4cd8:94b6 with SMTP id 38308e7fff4ca-2ee8ed90e17mr21796061fa.15.1720127279851;
        Thu, 04 Jul 2024 14:07:59 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee8d815d47sm3858361fa.83.2024.07.04.14.07.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 14:07:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so63099e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 14:07:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6kEaZmFlAmlVAWnQC6nwMMT8AjrwXw0nzchGECpztI5L92CrUUwQYCAKUYyeiyblmwLhGcPHKKNYQnYfQRnaUXAqcRRbKJ7GPL6RW
X-Received: by 2002:a05:6512:15e:b0:52c:76ac:329b with SMTP id
 2adb3069b0e04-52ea0632400mr2207288e87.35.1720127278580; Thu, 04 Jul 2024
 14:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com> <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 14:07:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
Message-ID: <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 12:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Bah. I guess I'll have to walk through the patch series once again.

Ok, I went through it once. First comments:

The system call additions look really random. You don't add them to
all architectures, but the ones you *do* add them to seem positively
pointless:

 - I don't think you should introduce the system all on 32-bit
architectures, and that includes as a compat call on 64-bit.

    The VM_DROPPABLE infrastructure doesn't even exist on 32-bit, and
while that might not be technically a requirement, it does seem to
argue against doing this on 32-bit architectures. Plus nobody sane
cares.

    You didn't even enable it on 32-bit x86 in the vdso, so why did
you enable it as a syscall?

 - even 64-bit architectures don't necessarily have anything like a
vdso, eg alpha.

It looks like you randomly just picked the architectures that have a
syscall.tbl file, rather than architectures where this made sense. I
thin kyou should drop all of them except possibly arm64, s390 and
powerpc.

I'm very ambivalent about the VM_DROPPABLE code.

On one hand, it's something we've discussed many times, and I don't
hate it. On the other hand, the discussions have always been about
actually exposing it to user space as a MAP_DROPPABLE so that user
space can do caching.

In fact, I'm almost certain that *because* you didn't expose it to
mmap(), people will now then instead mis-use vgetrandom_alloc()
instead to allocate random MAP_DROPPABLE pages. That is going to be a
nightmare.

And that nightmare has to be avoided. Which in turn means that I think
vgetrandom_alloc() has to go, and you just need to expose
MAP_DROPPABLE instead that obly works for private anonymous mappings,
and make sure glibc uses that.

Because as your patch series stands now, the semantics are unacceptable.

This is a non-starter. When I see a new system call where my reaction
is not just "this should have been just a mmap()", but then
immediately followed by "Oh, and people will mis-use this as a cool
mmap", I'm not merging that system call.

So I don't hate VM_DROPPABLE per se, but the interface is simply not
ok. vgetrandom_alloc() absolutely *has* to go, and needs to just be a
user-space wrapper around regular mmap.

                 Linus

