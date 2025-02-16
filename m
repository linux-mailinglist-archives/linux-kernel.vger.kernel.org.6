Return-Path: <linux-kernel+bounces-516841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595CA37812
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2309A1890564
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B011A23B5;
	Sun, 16 Feb 2025 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUqZuu2X"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861717B421
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739745440; cv=none; b=ATqarJT7vx4tzeRxo6YrxdZlSnGoQT1F4S/ufKRop7LqKMsStO4SwxpuB/Jk0IID78io6JO/+6GipAb1S0gJU4pKfIU6IAXP76TKZ21lEOiV4K0Gd9hUHqMk+TRUhNimZsZgszd42vz7BMFkzEMdFyOOrLtP8DXiLV5GM1/baP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739745440; c=relaxed/simple;
	bh=JXZajotjEbFhreWmuz7UOEqYE0FECe+GwjdOx9EH9Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNjA1BQKa+Juwe2J+730qrsdGhSaNvQ+/XrtO4iJbREN2rKKwBuoUVpHS14qv42/XYeQIiLrC2qb0IYAJxe15r9rafKvjbGeMh1z9wCmZDOEEqpTStUzQn7R4QZ4/e1AQxTD0+s14+qVh+A6LvI0Sc0yatZJ2Wy78BSBZa6jGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUqZuu2X; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f31f7731fso1000116f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739745437; x=1740350237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Kh9thG040LreVv4+ufcfEmUFVELFZsgHnqQYr/Tf9k=;
        b=FUqZuu2X4nmVbvFvO3VYKsYCtSf+YpLWV1XFk/Ie/SADXYDkjxDLKAf8cFpE/+veZ6
         xPLhbE87p1bEVYKPKcfUv3CkcIteGNG4ZprnJfvlwhCAsER5GrqpuXc2nGKoi+z9IOVu
         MMT0Jy49pVKVaGylzPB+BqFsDzpVc/+E+pNy7Rro6te/9SRpKbhROGuSyHDP7IeNZphf
         MgMi2s25V0hMxq+gI2Bg6L46fNbPz2VlOh2MM2h1uSfWfbxuWdXB4qLluXcXVRSCkS7P
         fduhRehc/Emc7KQ/wilDmYfRujwVsNA3AHv+HCJ/RWyopi68ZYLTCxIrBuacbRmM5v6d
         I3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739745437; x=1740350237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Kh9thG040LreVv4+ufcfEmUFVELFZsgHnqQYr/Tf9k=;
        b=V22Uvl/nDT7PW35AEkz8gLv+WEITz9j/VUEJm9x/zzB8Zy1TAVePW2LC57Spi1jLgg
         q7ffYnT3JSTVqI0VrXJSF5qRjnznkfIfva7tvV6xI0g/dawmwy7F5e26NGkkhLSJTUzZ
         ZYYoZ+lImity5iNYrL25PpYhPepymR9QfIi+avpCCZj3FDkERdLXnNxv+90J/lCYqwsW
         lrCI/8FSz06JsG7KEUZ6bPO8mdtxIJZolf/1gMYKQRnOROvyyUgtGNzHO7uk9ktF6HDq
         VLLYEYyfji4rQe4ioJ9NN/CKvF/p3vMX0iUe5Tj/uxXZNbSPfWMV38iIb1m+ouA8fymG
         JL5Q==
X-Gm-Message-State: AOJu0Yw4fpl1TGO3r0huaf6TX0h2vEXLU3zHfspFB/fSiOdjO7UAyOCu
	9X04mOXiQpi+PkXgjEg8mY4Mc2TJeemUVIpYtMj8JVfGoxn+Gn5I
X-Gm-Gg: ASbGncu+uPmHAoUhEvNeTqvk9zsp7y38uZXkDCYKORs64nnwJIbsVlPc8SiaVM3/iSb
	kzXi1/zMMWOH/VJTc9KfCy6oYThhQYQ411XIJhD7q2M9vrlWoE0jDmYX117QFOtLtlQczr6xnBE
	8LbW3cR7ABETcp5lo/Eil29t56SzYiwXOAfG1aFN/I6bxKwx3dWVdGqe3kz5AWNyoYpaib3J/Fj
	CCNZYYPlDQ5OZ/GQVu349XZYf6Edy+Q8thoEDooQtnqKeIWsHDDP22sDra6uuzBGwi2rsHyxxEI
	ujauW9hXUDlm/Kg4EuD8q+vui1d7aumqAd1P1YERd8SB72uQQ7f4bA==
X-Google-Smtp-Source: AGHT+IHu/w44S1IiwVXFHpue/MzZKpqJqU0FoKe+Ix44OCCD3HhyXUpekRCDpqP4hXBaXiyk9ioPmQ==
X-Received: by 2002:a05:6000:2c6:b0:38f:277a:4eb6 with SMTP id ffacd0b85a97d-38f33e7f75dmr8027714f8f.0.1739745436669;
        Sun, 16 Feb 2025 14:37:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm10725578f8f.99.2025.02.16.14.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 14:37:16 -0800 (PST)
Date: Sun, 16 Feb 2025 22:37:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH next 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <20250216223715.734fedc8@pumpkin>
In-Reply-To: <Z7JO9eutvu3KBEbc@smile.fi.intel.com>
References: <20250216201901.161781-1-david.laight.linux@gmail.com>
	<Z7JO9eutvu3KBEbc@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 22:47:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 16, 2025 at 08:19:01PM +0000, David Laight wrote:
> > Fastpath the normal case of single byte output that fits in the buffer.
> > Output byte groups (byteswapped on little-endian) without calling snprintf().
> > Remove the restriction that rowsize must be 16 or 32.
> > Remove the restriction that groupsize must be 8 or less.
> > If groupsize isn't a power of 2 or doesn't divide into both len and
> >   rowsize it is set to 1 (otherwise byteswapping is hard).
> > Change the types of the rowsize and groupsize parameters to be unsigned types.  
> 
> > Tested in a userspace harness, code size (x86-64) halved to 723 bytes.  
> 
> Does it imply running the respective test cases we have?
> Do you need to add more test cases? I believe so.
> Without test cases added it's a no go.
> 
> > +extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,
> > +			      size_t groupsize, char *linebuf,
> > +			      size_t linebuflen, bool ascii);  
> 
> Looking at another thread where upper layer function wants to have unsigned
> long flags instead of bool ascii, I would also do the new API, that takes flags
> and leave the old one as a simple wrapper with all restrictions being applied.

I can't imagine any code relying on the rowsize being converted to 16.
And (elsewhere) I've definitely needed to do hexdumps with strange numbers
of bytes/line.

> 
> And again, provide it together with a bunch of test cases.
> 
> ...
> 
> > +			dst[0] = hex_asc_hi(ch);
> > +			dst[1] = hex_asc_lo(ch);  
> 
> We have hex_pack_byte() or so

At least some versions of gcc have generated better code if you don't
use *ptr++ but do the increment afterwards.
It is also what the old version used.
Not to mention being another wrapper you need to look up to work out
what the code is doing.

..
> ...
> 
> > -		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
> > +		*dst++ = ch >= ' ' && ch < 0x7f ? ch : '.';  
> 
> Please also add a test case for this to make sure it has no changes.

Well isascii() usually checks for the 0x80 bit being clear and isprint()
rejects control characters and 'del' (0x7f).
I'm not sure what isascii() does for EBCDIC type charsets - but I don't
expect Linux runs on any of those so who cares.
Oh, and isprint() seems to be based on a memory lookup in an _ctype[] array.
Very 1970s.

	David

> 


