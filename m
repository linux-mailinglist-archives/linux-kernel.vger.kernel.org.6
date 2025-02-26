Return-Path: <linux-kernel+bounces-535105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F4A46F02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B948D7A7E31
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F325BAC2;
	Wed, 26 Feb 2025 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5uE1p5r"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA51C6FF1;
	Wed, 26 Feb 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611302; cv=none; b=VknW8Pp0Ci1boYI/qSAqOciQpORY8ZWWYwwaLpskPiuAWzP/nEbFvGn5kLw+2xms7H1h6GZuBHBMPjm2o7ZaZiqhryX53Lljw1HkCNLxP2+an5qr4jP+Dp0zMAn/1JEVDYS4UWL5N9D+48bTo+qUOfn/U05MffOrXIl6rpj+i1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611302; c=relaxed/simple;
	bh=QwvGNkau5Bh+dIR6tn3UJPayr4vQX3G/2XwtNvuU3cA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmymTMuj5nPYh7L0hAm/jVTOF+npqmmruMH/u4aMtpBlcQhd3JwtVhlrcxiP1RjYRlbHeGrZntKsv4QUEF1weUZTVll0Gr7S5ixnVYd+hcI987Z9Y/qjGCTX8/gf0c4ZT7GN+khSYKsettAVJvFcwJe+5m7Fuz5CEKldZlRfgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5uE1p5r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f378498c9so306488f8f.1;
        Wed, 26 Feb 2025 15:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740611298; x=1741216098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kqHl6YqOGD3BSAVr59pspE1LiZ8g6APu3kUtEV0wPY=;
        b=E5uE1p5rK8WhEsOkeJ14meGb1oBrTScoNFeuLh+7hOdhNJI2+QfXxAe7oSsmcQexn/
         kBXFg2fQeqEr+8yB5Yo1tPVTc7T2cxTAiMEFnNGwk0wAXqi16IVJN7mJVA3zXWgUwnqv
         uNPBKAU+TIqpWTDwA57wrd2bjyq4ayt2Fw1Xhn4rzjQmdqVo72mICrYe5lhKdCVB+oiP
         k82gG3zHNKv0lluBzRiOFiEgQG0HzTdZjAuxNlDIkQX4nmv9SaFSQNV+NIsA1p2VFQFr
         h16ka5a+ceWGgAi6WYr7Gq3q4KjPo3y6xPse+Lgnu6vMbZOXnW86+BuJ3w+DLGRU/218
         xIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611298; x=1741216098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kqHl6YqOGD3BSAVr59pspE1LiZ8g6APu3kUtEV0wPY=;
        b=XypfSHED2Rozo88j7ptoJqPGjZ3glQauWSCD4479z3xdOWKzzQ3gS8BX3ZMSY4dT+i
         JLtLSRVXv36iUeA8zTekENgGIw7DUJHb7R3VLLHb1krhXfvXQESwzSxkm9SPg2zaM29X
         k8Xu7/lQar7dzvmQo66esDkzyQh5QHLkyZ/fm/schA1j9JFbLrpp0ARgyvF6aBmfVA/u
         Qon3bZbHTEZ6aLp/WMeJAXvjjUHftH6wevrG/pDDU8uJ3C9egz8Wg8dwOYTrrJV4XmHK
         OAUtcLgbE8obrfgkJNUfwA+vPUAKEUMBdDJOPRB6KO8bnACa9gSbV+I8f5ok09+astj5
         UpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlT6Q5RK3KYh1lBl18n1LTcsQWQKeaJt/Swv8LPKRBHNgRpPv4gYKIc0wZr6C9twwY4C5LQMBhIDsrpJhchAI=@vger.kernel.org, AJvYcCWjq6C6PvSmYUK9kXPGHjRz0Fiutk7SRH/gYpT2trBYLxrllrD4WOjEIzOimGmwI5mYJ1gz9ng1Cwr3SrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSwIJxRotEEkOVijvik6OjaHmlcqo5HCZKeWlRP9ksgKAVrWq
	Tx+iVvB73VMJXRyNW7AFzHZaFJpNgIWoD/lEz9KPNE8woju0y7lK
X-Gm-Gg: ASbGncuSooxUCA23cghanc+tbveuBf92032MQu0H6OMRGElvCguUEQI5ewCrz7uNHMm
	t313M07kK7hMP2lrJu6Tx18kI4k2wtmRqy1fL7BDQP5MhVCT7ZelqAnVdZ1O4T49EoH4KemUuT0
	tkjdV7ohZ6WXkxJKTg604gqJnsRMLNC8QeVXswk8iPeJLWoih+xD8ifXogu+H9VJjn9l2qEf3P4
	vF8hzZCxFACkm0SOr4QXhDWjj/b4eOlebgDur1DbYhjC86fd+ncwddcGNqkxjmNqWqS9AswNZmi
	tJcoBwZecq36S95poR8KJG2oNB7IuwnrPRaqM6ZSGdcrfBm6KgRl2hcvXIy0F6qB
X-Google-Smtp-Source: AGHT+IFb5vDf6eK/bH7+GTIOY122a6dwufeCuABNTioN79EKFgWyAgc0vc4m9UlnZFbwXhjvhwjBkQ==
X-Received: by 2002:a5d:47cd:0:b0:390:d7c5:590a with SMTP id ffacd0b85a97d-390d7c55ddbmr5289864f8f.10.1740611298093;
        Wed, 26 Feb 2025 15:08:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e03asm208817f8f.95.2025.02.26.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:08:17 -0800 (PST)
Date: Wed, 26 Feb 2025 23:08:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ralf Jung <post@ralfj.de>
Cc: Ventura Jack <venturajack85@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>,
 torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226230816.2c7bbc16@pumpkin>
In-Reply-To: <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<20250222141521.1fe24871@eugeo>
	<CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
	<lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
	<780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
	<CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
	<f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
	<CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
	<7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 23:28:20 +0100
Ralf Jung <post@ralfj.de> wrote:

...
> > Unions in C, C++ and Rust (not Rust "enum"/tagged union) are
> > generally sharp. In Rust, it requires unsafe Rust to read from
> > a union.  
> 
> Definitely sharp. At least in Rust we have a very clear specification though, 
> since we do allow arbitrary type punning -- you "just" reinterpret whatever 
> bytes are stored in the union, at whatever type you are reading things. There is 
> also no "active variant" or anything like that, you can use any variant at any 
> time, as long as the bytes are "valid" for the variant you are using. (So for 
> instance if you are trying to read a value 0x03 at type `bool`, that is UB.)

That is actually a big f***ing problem.
The language has to define the exact behaviour when 'bool' doesn't contain
0 or 1.
Much the same as the function call interface defines whether it is the caller
or called code is responsible for masking the high bits of a register that
contains a 'char' type.

Now the answer could be that 'and' is (or may be) a bit-wise operation.
But that isn't UB, just an undefined/unexpected result.

I've actually no idea if/when current gcc 'sanitises' bool values.
A very old version used to generate really crap code (and I mean REALLY)
because it repeatedly sanitised the values.
But IMHO bool just shouldn't exist, it isn't a hardware type and is actually
expensive to get right.
If you use 'int' with zero meaning false there is pretty much no ambiguity.

	David


