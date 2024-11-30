Return-Path: <linux-kernel+bounces-426386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838F9DF26E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937B3B20FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CB1A38D7;
	Sat, 30 Nov 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MDn4Mcu0"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888519C54D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989780; cv=none; b=Iuy8rG6pYmheTiesZPSMFD00f70iL8Bmr5quRuWosYM4fXXrKHY+51yjhJ7sUUJpkkXqw03p+gVAYJr6Tn0ycgL8AShRE1zs57lwvkT81UKxML9T8h0R3r1iaQC+KQoJjJuNI6ZmsP8e0Y4qW7wzg858u2pGl52/xgEmUX21eTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989780; c=relaxed/simple;
	bh=5COwjKHdAiMaJwK/Hx+9BfwsgIdb3l+pVKvrV5yLzNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqMKAnp1egFZMEvDtKYo45oIdWbES9cygQIeKEYkdVXs62LrknAyGCKM7s68gAaE7VcDfEEtEKQheVpT5Qql05/W92ElzSzjaq3qLbtYFxD+qe6xIrig6/XQxs1/Yo/iXVYBZ7TmwG6JxnTv1e98sO72T7s/neIzaPOeACudKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MDn4Mcu0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa578d10d50so462635466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732989776; x=1733594576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbB2vuXpy4jWACIjXNfh0gThH+CYe3wsKjjW9mdP8c8=;
        b=MDn4Mcu0gDjNRbSoHPSu8hDwTO5QWjIwD77e9hX0KddQlF1wy0LoFOC7QNj92YOZWI
         9tSOpPgnQ7163HgXuo6WeYjozAKDIU5c8VvGCsBXiujNlwPA6w94CU8xm2cujHLnVFh3
         xT2+d+8pbqNnpyC+o0qQ/7x1uDSTGcG2SajBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732989776; x=1733594576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbB2vuXpy4jWACIjXNfh0gThH+CYe3wsKjjW9mdP8c8=;
        b=LbipmLx0zKkx+gDEzr/SaSqjHIxMwzZU2o4nIAShjj6AUP+0k4ZweVLBaSxd3z07x0
         ueFF+fJxHmWy+/atybEYR/GZM0NqdR4O+gsM/s6tmzV+EFfKBnKY9ihjn2SMvXyM3z3A
         lJgxW6vAZBlcFOBY1Rpa5mDyDQ3P6YDsQ6NZZiBuPE6i3ivGE5L4w0/gaKtjCDuAi/MQ
         vvpESamMrqLFblP/rrlg5eg+jNy4A8BRkTizbo6z/QRjjfbkQlnTwQqm3+d9k31/A7Vv
         WR9ORtVZxqc9AM3YW9MWRPA+MbiCmBdCBu0FyEr0z3e1i+ulpcIqTswTDkT/WzDfYfV5
         hA3w==
X-Forwarded-Encrypted: i=1; AJvYcCUNLm/E7EVIxMICoQ/Qo6GxHxapPgMSRBLhx3CjCSK4IrEY6urLeVCD0vs2vAhcMmlhMEH8OoGcX8M8Eyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLETLYiGZYTwJ3sgiIfndgiQA71Z1Tbo/yd89d1PnTmRLHLV/O
	IprBlc3AWk3z7OCj8aBtrFUpYfdmzBbTMS7VSaX8Q0quE/Ev6bufAPp2DzpYHdGf/+CTU9+GEiv
	f4r9CeQ==
X-Gm-Gg: ASbGncuHJRRo2vHdmzqlpEepSwgQX9bhH7ca7VfWaclO6znYyDdkdEuWolktN+47NTY
	V1Zakfg+i8/dM65WP/COQdLs4rP67snHP01JT2xsuhD6c8/driFfnl048bJTIJrHLrKrIJt4Y7p
	OfZgj6q0FlxcHY1GZzOog3OmKIWlhbUpCV/zb1shaFoKUljfnXZdUb+acbAv1YCz9NRiIMsrhrm
	LACypEna/od3pg3cMobT2NFSWZzBop6XoZPkBHo1r6j6hdw4ADrj48Dg4wPf2ijjRQgfi/C60j6
	F9mL0O2hfALmQFtgLOOXd825
X-Google-Smtp-Source: AGHT+IFAc1aMkI/Ngcii5Bevcwcu4u4pxYraz7+jHqc/TIY5Kdy/x0TF6n83DeXKm38rOZesy4N4Gw==
X-Received: by 2002:a17:906:2181:b0:aa5:1df4:f57d with SMTP id a640c23a62f3a-aa580ee0131mr1558667166b.2.1732989776474;
        Sat, 30 Nov 2024 10:02:56 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59995562csm302379866b.189.2024.11.30.10.02.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 10:02:54 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so521757466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:02:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV45nDBDcqrjjx+KYrWe+Sy638TQX5rLwh3zeoCg7y6E+X56rPZ4puEOxHSWre+hhRS0KSFZdl5uopg9Es=@vger.kernel.org
X-Received: by 2002:a17:906:1ba9:b0:aa5:cec:2785 with SMTP id
 a640c23a62f3a-aa580f50e22mr1700257566b.25.1732989774448; Sat, 30 Nov 2024
 10:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
In-Reply-To: <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 10:02:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
Message-ID: <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 04:30, Christian Brauner <brauner@kernel.org> wrote:
>
> What does the smp_load_acquire() pair with?

I'm not sure we have them everywhere, but at least this one at dentry
creation time.

__d_alloc():
        /* Make sure we always see the terminating NUL character */
        smp_store_release(&dentry->d_name.name, dname); /* ^^^ */

so even at rename time, when we swap the d_name.name pointers
(*without* using a store-release at that time), both of the dentry
names had memory orderings before.

That said, looking at swap_name() at the non-"swap just the pointers"
case, there we do just "memcpy()" the name, and it would probably be
good to update the target d_name.name with a smp_store_release.

In practice, none of this ever matters. Anybody who uses the dentry
name without locking either doesn't care enough (like comm[]) or will
use the sequence number thing to serialize at a much higher level. So
the smp_load_acquire() could probably be a READ_ONCE(), and nobody
would ever see the difference.

            Linus

