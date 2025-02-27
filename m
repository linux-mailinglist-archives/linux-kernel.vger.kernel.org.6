Return-Path: <linux-kernel+bounces-536625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79287A481E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7364C3B45BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818DB23C8C0;
	Thu, 27 Feb 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvOzRGlv"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254723AE96;
	Thu, 27 Feb 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667423; cv=none; b=ahar9veLwygMoZU3OQg+83kdFNiCEj28zDUyZxTTuY+xeKv334r0YWzle7Y3chrOF8waJUUi7KJsb9dM0M5DsyQMj6bLlpMitZscgx4ViIT4qPyR7+PjUsOci6HoG0kWqdVmL356PM6mBZTF6734d1P6keJnF/h+FIOG0YrxXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667423; c=relaxed/simple;
	bh=aHu4HjOiSkCHENsBL2+QjxQh/gEG6TIfQWWRKvIwFs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stvnQQSOjr3cQRamj+M9N9Qpz9nUlJ43xxLQKQBix9bohlE9SP/f/flVF7MV8t4SngxB17waGrQi5aKBvVs0xbom8wV8YpGCuwpp9ao5/sK/1ht1bE5tUUahRSNXFbKUXN19DJb1eBNNa+IHk8WGnX/4YMAJbm45nCt0X+ozpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvOzRGlv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-546267ed92fso1021309e87.2;
        Thu, 27 Feb 2025 06:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740667420; x=1741272220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrQwoCf+jFDDz9zpktNsyPQTVzoYZj2045oO4CtLIj8=;
        b=YvOzRGlvCU/EPLmn6rp3tJineLUiupOGf1qZqq5AJX9OSJUh+dJcYaUdL3f8/Mf3zR
         Fzi0wRWjLuK/efkMhokHeXFlCm//5KG2gE44Ytcf8l1oQ5OU3O+xrQbM8EwCSXWH9lWp
         CAeGbkbvR5fZbcevuZqkDH87cZEFjookAapxF1sHUodQ9duXBgynDDYss8KdTj4DCFU8
         wB6yD+cLbYzgAm5CUuNk0QqVeSx04Q9BeY5S2GQyqJ6vPQylmyDrd77EuROYa2N7TwK8
         /Z8PP8XiIc10BxnOATfivqVMmRSoZ9F+zgJypu0vNnkndIuuIA3gsTc7z9cN8Mna3Qt2
         x+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667420; x=1741272220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrQwoCf+jFDDz9zpktNsyPQTVzoYZj2045oO4CtLIj8=;
        b=NA02foStNVC5DDeDUQV3/JWFhsAYzxWxy9mXyAXRGnQPrvuV3tRhigPDwfVsRHFoKE
         ohI/OabaCwD3k9uTd/bJKckRZhEOgiWfId8sviNBlwvtwVskV+JtAeoLLnQeFlCq4a2L
         JLhKztMFQY9c61AcencBEdBTuScbPJgm7MFv6pM4XB7Z4aQYNVyWP86F0efQzXSLeQNQ
         iuCgcGDGggRlOiibcMXqBpg/Ztkh6U3WSxanj1MFuyKmhIxc+aWCbjffKna3pxUNb12C
         RN6Vr3ftEMVHfjIfLowidl2miDmjgoGB1k4KmyIumMDOnFNs7IWvxQJw9uz9jyA8Qim+
         8kaA==
X-Forwarded-Encrypted: i=1; AJvYcCUfyJdiPWY1ep3f1RtZzVaOlo24XfpSHn2u+z7uvhRwL1VywgLhZek7hCIYRnePXeqFr0A8aKlLs1cZiDJ7Zp0=@vger.kernel.org, AJvYcCXFDEfsmnKjJKhkeTCM+JA7el8VwSYLyeUaSCkILVUI08RedkGYCSFzo/qSLUaRCWdM+F/u5U7ckwC4QKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhd84sHXKHUc9EkuDMMaKVF5nKVaU1J2IAj7lYtOg0y6xMArX4
	wJDF7a/85P90RcQryN+xm6+0l5lMfPPjCYagZMcJGohTmRc81Ttc+dcKCrbng/06F7R0uc1x51o
	lRy4D7eMORg+qrTquNe/XM/W+tJ8=
X-Gm-Gg: ASbGncvSqjYSzlcNX2P1BQUFryAFfHYNGEUOlq+o//C+VdSqQCw9uHoAYb+DbHeiNyV
	wyBmSlyh2s86ssFoiN0g+kUMttFnaWc8KLVhWLMwkVxcJjnjzWHnk8JivovIxkmK7y1keZg7Qos
	EpkeAgYgLw
X-Google-Smtp-Source: AGHT+IF2Ebq3Rent6Q8OTUwnDBzprobGcIoozGi87gZLcCKHId58DPsiZpKYoPLqcZfKxFk37rWwDUs2Lz+w9QpOQNE=
X-Received: by 2002:a05:6512:128b:b0:545:ea9:1a24 with SMTP id
 2adb3069b0e04-548510cf634mr6927671e87.14.1740667419952; Thu, 27 Feb 2025
 06:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
 <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
 <4l6xl5vnpulcvssfestsgrzoazoveopzupb32z5bv6mk23gazo@qn63k7rgsckv>
 <CAHk-=wgMnSOnaddFzfAFwjT-dGO9yeSkv6Lt21LgWmCKYCM7cg@mail.gmail.com>
 <hofm7mo46jzkevpr6fkqe2jnl3zrp5uxdux457hli3ywkneaij@yhhibsnuqfny> <20250226115744.024184b5.gary@garyguo.net>
In-Reply-To: <20250226115744.024184b5.gary@garyguo.net>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 27 Feb 2025 07:43:24 -0700
X-Gm-Features: AQ5f1Jqo_qhQ28y7ZKcJDKeDW7koaI5WfLn4CpiSw-oP4Tmva7WXiWcKvkc-wDM
Message-ID: <CAFJgqgTD-N=Gd7TRBD7N-5vuojq8nWffn-J91egoUP1stTFkhQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Gary Guo <gary@garyguo.net>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alice Ryhl <aliceryhl@google.com>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:33=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
>
> If you translate some random C code to all-unsafe Rust I think there's
> a good chance that it's (pedantically) undefined C code but well
> defined Rust code!

I do not believe that this holds all that often. If you look at the bug
reports for one C to Rust transpiler,

    https://github.com/immunant/c2rust/issues

some of them have basic C code. A major issue is that C, especially
when "strict aliasing" is turned off through a compiler option,
often in code have aliasing, while unsafe Rust does not protect
against all aliasing and have stricter requirements in some
ways. So it can often be the case that the original C code has
no UB, but the transpiled unsafe Rust version has UB.

The blog posts.

    https://lucumr.pocoo.org/2022/1/30/unsafe-rust/
    https://chadaustin.me/2024/10/intrusive-linked-list-in-rust/

also touch on this.

Best, VJ.

