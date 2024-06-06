Return-Path: <linux-kernel+bounces-204904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46CE8FF4D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87601C25453
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C347F6C;
	Thu,  6 Jun 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G85+JGz1"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F745038
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699382; cv=none; b=nY3jrkmocKr4Xv3NTaS3mLPtsYnZ0b/GLoIYZxDykPG7syk86lCT6C5NJuf9bDK91a/VFmPHChVwk0+s/o/JE1eLR1nc/0ixmyfr6/8omMK8yCtWxgzabGwwOCMktgty0HNgjWpYaSp84alXlF0i1AIteS72VFUvMlo36f+ea60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699382; c=relaxed/simple;
	bh=5F0RImuQkfhSdYDAeSpSq5Ih0l+qbvKjSst0BwKVBTQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mwNtbQvj45Y/VfiGfQFP6NiKulu3fyYkl6wnM5waSTsQmckalsroQMEDktbtXTdWA0TVCzwd4LuZYFWWeWPqjGKbw1akKw/fjvHZ1sCh2oUA7U2W1LRJ17+cg3shf0NBnmqX/8pvaGt8GypqUPjECDiqU/3+utdTwSS+gVSpoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G85+JGz1; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80b68ed46a6so186778241.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717699379; x=1718304179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1f6G3z/Rx2xjhKhnDISCoNudUz/WZtT1MDwLpyhSZCE=;
        b=G85+JGz1pTqe4M6u7XRqDXJdmIZDh5gkHEhlUwx5mpMioC9v2rCBGwlmdqsvkdW7Fo
         9sPjZT4/HxOvBaLK+1oR2Qqz4MtDio8vxuRHwG+R6jrTKmi/hX/zsSNiGt6Ss/wJ5Q8f
         pGwNI6vbEOUZm6Y6VPda3RPjmxBVrzerApvRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699379; x=1718304179;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1f6G3z/Rx2xjhKhnDISCoNudUz/WZtT1MDwLpyhSZCE=;
        b=XDd6WTs99TuYMNHvH719snja8EN2GaxwHGHJgHXpF/xhQvEbu+l/uzWFY4Ux27uCyh
         cNwZVgUR4nipRVdVjkRMyMFRboy1xGO9apSbSg/5PyHqEC/njgeSdSut60hWHQ1OYPxv
         tFDchYpAf+MkLPYxhb4EO+SBRoS9usVyHlMpOfcf1GaopFORriaTUdCReJEtv5SMP3Ol
         cXNC4jujth28NNLBxLqge2y/CdoUzv5RDzsWxC+giiMPBc++Ti1MSAHeKHJNRTFaRbw7
         tAxPtEsit0FP0g5eqVnqxU7e3E+qekW0iHog2ydC5IyL7VcWkgdjtgn45/y4qZFbp7k0
         SOoA==
X-Gm-Message-State: AOJu0YwPLUpwEn6zNY/YLnoXRumjg9f3wX0jRlYaAdpeCITGSku7a7bI
	n5M5O4EwCKBJVbhIxenp9i0UICZMl0XDn82FNXD0NzDXUVlXjEODnyTeDfEjRlMfZRAPDIIMOaT
	4
X-Google-Smtp-Source: AGHT+IHvgAaUR+7cIWpnK3p6r8gUgutdr9pIFJQgM/rAM8Hui1Imszk4J0xoxRed816/kTWonmipKw==
X-Received: by 2002:a67:e889:0:b0:48b:a3d1:58cf with SMTP id ada2fe7eead31-48c27659c2cmr138049137.11.1717699378950;
        Thu, 06 Jun 2024 11:42:58 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48c19f09735sm357616137.12.2024.06.06.11.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 11:42:58 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48bbcaf093bso326844137.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:42:58 -0700 (PDT)
X-Received: by 2002:a05:6102:b15:b0:47b:f1ae:9c77 with SMTP id
 ada2fe7eead31-48c277979afmr161569137.23.1717699378278; Thu, 06 Jun 2024
 11:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Jun 2024 11:42:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
Message-ID: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
Subject: objtool query: section start/end symbols?
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So this is related to my currently very ugly hack at

   https://lore.kernel.org/all/CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com/

where I'm trying to do "runtime constants". That patch actually works,
but it's flawed in many ways, and one of the ways it is flawed is that
I really want to put the "this is the use for symbol X" in a section
of its own for each X.

Now, creating the sections is trivial, that's not the problem. I'd
just make the asm do

        ".pushsection .static_const." #sym ",\"a\"\n\t" \
        ...
        ".popsection"

and the linker script will just do

        KEEP(*(.static_const.*))

and I'm done. Nice individual sections for each of the runtime constant symbols.

However, for the fixup part, I then really want the section start and
end addresses, so that I can iterate over those uses for a particular
named symbol.

And I am not finding any way to do that with a linker script. Sure, I
can trivially just do

        . = ALIGN(8);
        __static_const_start = . ;
        KEEP(*(.static_const.*))
        __static_const_end = . ;

and now I have the over-all start and end for those sections, but I
want it per section.

This is actually not even remotely a new thing: We do this manually
for a lot of sections, and we have macros to help do it, eg our
'BOUNDED_SECTION_BY()' macro in <asm/vmlinux.lds.h> does exactly this
for any named section.

But they very much do this on individually named sections, not on the
kind of "do it for this section pattern" that I want. Yes, you can do
it for patterns, and we do:

        BOUNDED_SECTION_BY(.note.*, _notes)

but that creates exactly that same "bound the whole set of sections by
symbols", not "bound each individual section" thing.

I tried to find some way to do this at the linker script level, and
decided it's not possible. I may be wrong.

So then I said "we can just make objtool do it".

And I think objtool effectively almost has that already, but I'm not
really familiar enough with the code to start messing around with it
at that level.

It's kind of like elf_create_prefix_symbol(), except at a section
level, and needs to be both prefix and postfix.

Or kind of elf_create_section_symbol(), but making it a real symbol
with a real value..

Hmm? Am I barking up entirely the wrong tree? Or does this seem doable
and reasonable?

            Linus

