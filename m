Return-Path: <linux-kernel+bounces-521589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5788A3BF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435D2167E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1081E1A18;
	Wed, 19 Feb 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn9E79p6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040526AF5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970834; cv=none; b=Q9Hd0DIitcti2L7RuNltXovLWpOzsecU0OJMv0bPczaSD6jjljW5x7qaO6fb1uQCcy6XdPeX4ROOFClP2jRpM5dLB0+hdburTcqgIWfhojD0/P6Y7xfonE/BYnW1Y3KCWZ4BjnFLDOYmJtAHbxTF0L69BWMVSC/CExDsdz3ijn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970834; c=relaxed/simple;
	bh=Zw412UODYLiFMBdQiaAu14s+ite+vaJWYgatU/BcSMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KC9AvVp8BZHdRLM11dmC929M+it3kFaa7GoDDazGpVQVTHhIcKzHJPyJTC+khXYHqHjnqrjresCCYjmy7EA/4P68/ZwJkEo4do5mZWa9cblga+5uaPmTtbZLZk1lhkswdnTafIONUd+z5/e6tT1U9OppwGrjUKW72zJFp4WpO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn9E79p6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so25240535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739970831; x=1740575631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkTN5VUGFuE0NUH9FTNQXh4pyXoWjdkFRRMWX3EH+CA=;
        b=Gn9E79p6gAgTxfw3xU9rj7i0cp7bCROl1KbwFJ4ZMncJg6JhdYNlfH4ca9Ji1/H47p
         iRfPDKNGVISUEbYpi0QA7OrmhbNSx1k2E5BeT2RtTGgSQgXAFh8N/LLuR2tdzkoPeFU1
         t1FvJAIysVmG/zWLm77Dtg7r5CLXEtIUTkPQQTErUtzi+ygzaDehfMN6EYs4EC+x0KV6
         28GO9TER5L+R3dyY4y58I9DvhNtNtXukT2i4saDkzPApS4rLhdelWJ4nwrNW8YgAGSXW
         qs6JlgK3l/o3UipckCPTYZcC6XMd+lRv+rB43Kz1U57ieUFGJQo2VR1E3hUA3X1CerYi
         ykKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739970831; x=1740575631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkTN5VUGFuE0NUH9FTNQXh4pyXoWjdkFRRMWX3EH+CA=;
        b=tjVMFUAcMJxvbMR6d0Pbm1RlrFZMjL7lW+7Ume8N+/b9vZjkTivSUbaAki6DiheE0I
         V9+3Zx4lJ1y6apwKyc8YXElx4Bg+fk4+jtQGENT+SBj8LqGCPstZJeIB5Apuga87uK5w
         FX8AqrZ0mza/9BYjJAIXnOIPdZXkG/skXYcuziU2rHhy+gbhwzZPpVyVvwU+bCdcrpV5
         Xt1MdfxbMViq5SgcPWx7gtPAfqBeokwoDFsJvWl6/UC+c/QSpULTmezomjKJf/QmT5d1
         oWn9K/GK02/EeMSW6dnYHZ6pweEk/rmSWBc6kw1C42wzaThRDTLVEovlM+08AirxZG4w
         KZ+g==
X-Gm-Message-State: AOJu0YyW1MxEQussEw8YzTK540xMQom7zjspbgW8GsWCCjtdnyr/Oaq9
	z9aJA7GNl838T44QgAVGwrTTPP4R+F0MW76dLDFZJLuC+LkbAbkwclch0g==
X-Gm-Gg: ASbGncufQkeCrG+DDh6UaQJK5NgsBgB9SqrIx3s+odEa31vO/dgJcZdKJJA9L7NUJuX
	at2FGPqiSaqrfZB9nyWqQq979gN24iVQmEAZ4VBLXnoCv9Pt25OOYPj7Z6GCteHv2Gh6D+0cfsz
	dYlnqvIqGnNrltTSlflgQdMsHH+YOlzc3NmXpWBWuDIxGNyZXkRQl5qvPPSKnVK9foTp57pM6B8
	gKJ/JGGYUfUvMnRJu4Ia6tDwGc0xusbDfceGEgv8z1QnTgbsMiSStXiFuj0FVCzHFdWUC7uZvnE
	gLgopQ3qILesWATnD2ZsHSpzIfSov5Fz35TjyUZCHpNZmG8+d3Q/tg==
X-Google-Smtp-Source: AGHT+IGViNBCEyyUt7v+OAl/YSOnFAuMghgmjRa5ioikuqs52+XZPS8lGZB9wMKa1odm1v/JmWhyhA==
X-Received: by 2002:a05:600c:3ba6:b0:439:91dd:cfaf with SMTP id 5b1f17b1804b1-43999da55damr34452815e9.18.1739970830088;
        Wed, 19 Feb 2025 05:13:50 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm17827649f8f.76.2025.02.19.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:13:49 -0800 (PST)
Date: Wed, 19 Feb 2025 13:13:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH next 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <20250219131347.3ec72325@pumpkin>
In-Reply-To: <Z7UPNhW_bXSOzACk@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250216201901.161781-1-david.laight.linux@gmail.com>
	<Z7UPNhW_bXSOzACk@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 16:52:38 -0600
Nick Child <nnac123@linux.ibm.com> wrote:

> On Sun, Feb 16, 2025 at 08:19:01PM +0000, David Laight wrote:
> > Fastpath the normal case of single byte output that fits in the buffer.
> > Output byte groups (byteswapped on little-endian) without calling snprintf().
> > Remove the restriction that rowsize must be 16 or 32.
> > Remove the restriction that groupsize must be 8 or less.
> > If groupsize isn't a power of 2 or doesn't divide into both len and
> >   rowsize it is set to 1 (otherwise byteswapping is hard).
> > Change the types of the rowsize and groupsize parameters to be unsigned types.
> >  
> 
> Thank you!
> 
> > Tested in a userspace harness, code size (x86-64) halved to 723 bytes.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  include/linux/printk.h |   6 +-
> >  lib/hexdump.c          | 165 ++++++++++++++++++++---------------------
> >  2 files changed, 85 insertions(+), 86 deletions(-)
> > 
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 4217a9f412b2..49e67f63277e 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -752,9 +752,9 @@ enum {
> >  	DUMP_PREFIX_ADDRESS,
> >  	DUMP_PREFIX_OFFSET
> >  };  
> ...
> > - * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
> > + * If @groupsize isn't a power of 2 that divides into both @len and @rowsize
> > + * the it is set to 1.  
> 
> s/the/then/
> 
> > + *
> > + * hex_dump_to_buffer() works on one "line" of output at a time, e.g.,
> >   * 16 or 32 bytes of input data converted to hex + ASCII output.  
> ...
> > -		linebuf[lx++] = ' ';
> > +	if (!ascii) {
> > +		*dst = 0;
> > +		return out_len;
> >  	}
> > + 
> > +	pad_len += 2;  
> 
> So at a minimum there is 2 spaces before the ascii translation?

That is the way it always was.
Does make sense that way.

> when people allocate linebuf, what should they use to calculate the len?

Enough :-)
Unchanged from before, 'rowsize * 4 + 2' is just enough.

> 
> Also side nit, this existed before this patch, the endian switch may
> occur on the hex dump but it doesn't on the ascii conversion:
> [   20.172006][  T150] 706f6e6d6c6b6a696867666564636261  abcdefghijklmnop

Correct, that is what you want.
Consider { u32 x; char y[4]; } - you don't want the ascii byte reversed.

Indeed, if the data might not be aligned it is easier to process the
hex bytes in address order than a little-endian value that is split
between two 'words'. 

> 
> 
> > +	out_len += pad_len + len;
> > +	if (dst + pad_len >= dst_end)
> > +		pad_len = dst_end - dst - 1;  
> 
> Why not jump to hex_truncate here? This feels like an error case and
> if I am understanding correctly, this will pad the rest of the buffer
> leaving no room for ascii.

I missed that, can't remember what the old code did.

> 
> > +	while (pad_len--)
> > +		*dst++ = ' ';
> > +
> > +	if (dst + len >= dst_end)  
> ...
> > -- 
> > 2.39.5  
> 
> I will like to also support a wrapper to a bitmap argument as Andy
> mentioned. Mostly for selfish reasons though: I would like an argument
> to be added to skip endian conversion, and just observe the bytes as they
> appear in memory (without having to use groupsize 1).

More useful would be an option to keep address order with a space
between the bytes, but add an extra space every 'n' bytes.
So you get: "00 11 22 33  44 55 66 77  88..."

But that is an enhancement rather than a rewrite.
Although it is all easier to do with my new 'slow path' loop.

> I had fun tracking some of these bitwise operations on power of 2
> integers, I think I must've missed that day in school. Cool stuff :)

It came the day after the rule for inverting boolean expressions.

	David





