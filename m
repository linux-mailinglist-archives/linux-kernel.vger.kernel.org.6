Return-Path: <linux-kernel+bounces-279986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085094C42C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF383286DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCE146D6E;
	Thu,  8 Aug 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K6+KVbq0"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771F13F435
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141217; cv=none; b=meOilNY6FuwJWndzpjH/EAXDLVliyYHCDf5ZyUVutjiCEfWqnF7U9o9oPcYAadXZeq64+MNwwiGnphIx16ufrU+fN6/doVaiZ1b8USXnxvq4d50RNffWFsxZuoxAGwihbC8/Vqpv0NoZCTQ2lGPf5/Ea28jBsip/zkEurXo885U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141217; c=relaxed/simple;
	bh=wpwjiHoc7VgLtkIkF9IrlpNoofn0hUJ7BBPVJfy6oSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVPvesBhRXvSvML6RX26e/MdBxIaS+sDQqhoJNNyLgp5+QryPxWCEmDFZfbqh0hcshyM6tMeZXSXYYGChpRpt6i99T/46Zi1D/ulxR/B04ZZoUdBKcHn+v9Pk67x1KlQzabFXqHAgVZwCYrQqTjNYRJNhvj8gr7RXWgTf64JshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K6+KVbq0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so1531103a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723141213; x=1723746013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vs6dpRbqJripr2KpHyDnR1cQAk+xLDTiAQY8cHPi6fA=;
        b=K6+KVbq0xGSWoiEpmXAxpx4VGY/6UbjMLK/2nRskVwzNrv4zDwHsE573Q0+taJ2e6m
         slt7i4G12Wtf0VxC2uAGHsoHjJkTw/UiEObjcnd/1OgTbm9L+FXCUxfO8qQCwWD7WG8w
         zlw+8UMJEuHl2Ngg+KuDYmZbTYEte0xTbyptI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141213; x=1723746013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vs6dpRbqJripr2KpHyDnR1cQAk+xLDTiAQY8cHPi6fA=;
        b=HskUpVE7rywXqJi1Qaiwq9YI0qpwXKKHtJNlNDMmrqH7zkiYV+hwGsGoj/8VgY7C96
         nhn/nylN68jVQMjLUBg6IrUrPG/L1i8OD+w8gAkMxkjFFWm/RT5aAWmvCSrNFOY8Yokr
         QcxaySoBWBlOqsIYPdzHSXhLjbv90mrP00rg14PNLifZ7hne/vF1fygwponzJExGLGTG
         4WwMtlcgPPHEGBYVqj8WlRxkK7CwVXhHJIz+47VwW9J/+Ab+tHWf2nphQzaB9O4zt9ne
         YcdWu2e8rNrg8bRdhBNZElpJFgcak7jtKQOTDjyn3MbtFfXdtLwH7FQ6C9FcyfxRLQAS
         +SHg==
X-Forwarded-Encrypted: i=1; AJvYcCWG//HqsoZRneSytY0Ptg2c2Ar13OUEscQdLSELvRrDhW1gyqq+BzsG4CurgKHYGTogCer2wxpAgCfen/ZSSDjmCF93pLfpNAymm8Ol
X-Gm-Message-State: AOJu0YzvFiiuCwuraJx5OMqgcQBt1xBWd1st5lwraNa1PmbjPCjzAxib
	XJ8zthMvEvIgtAdpNQzCbTuusOUelG/1mCTy/y+4OkmQRxgVY2o08PLDTCk9FTYexeU8Wum+EAa
	PuUG33g==
X-Google-Smtp-Source: AGHT+IEo3sxLEjLLnMVK4fM/7yKIky9NXqZxB7IsDV/yMjQwQcogCFvYtX6P6ABbgrssxdXXupsjQg==
X-Received: by 2002:a05:6402:5108:b0:5a3:3b44:ae00 with SMTP id 4fb4d7f45d1cf-5bbb21cde2dmr2011312a12.20.1723141213310;
        Thu, 08 Aug 2024 11:20:13 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1f6c4sm855007a12.29.2024.08.08.11.20.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:20:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so130830566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:20:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrDsgUj/fqM6BmOb3bKa/m7sEStcudsTF9KQGZ7RD/fRdBLpIhijeksSQ5mYHicgMH1JkXyXNJnEeCt0CMj5ObNVH8gOuogBtI1Iu0
X-Received: by 2002:a17:907:969e:b0:a7d:2c91:fb1b with SMTP id
 a640c23a62f3a-a8090f1a339mr207711166b.68.1723141212363; Thu, 08 Aug 2024
 11:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx> <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx>
In-Reply-To: <8734nezz0g.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Aug 2024 11:19:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
Message-ID: <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 10:48, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Here is the disassembly from my latest crashing debug kernel which
> shifts it up a couple of pages. Add 0x10 or sub 0x20 to make it work.

Looks like I was off by an instruction, it's the 28th divide-step (not
29) that does the page crosser:

>     4121dffc:   0b 21 04 41     ds r1,r25,r1
>     4121e000:   0b bd 07 1d     add,c ret1,ret1,ret1

but my parisc knowledge is not good enough to even guess at what could go wrong.

And I have no actual reason to believe this has *anything* to do with
an itlb miss, except for that whole "exact placement seems to matter,
and it crosses a page boundary" detail.

None of this makes sense. I think we'll have to wait for Helge. It's
not like parisc is a huge concern, and for all we know this is all a
qemu bug to begin with.

          Linus

