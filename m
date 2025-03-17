Return-Path: <linux-kernel+bounces-565143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93730A661B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCEF1782A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D091CEAB2;
	Mon, 17 Mar 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO/H8t9w"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BCEAC6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250770; cv=none; b=rmDkVpc1h7IoAk8HUUDC0s/c+Sd8BE1IXyHNCNuJhjonYrjLWx8FCJlQGbF9zKL8LEjF8JatU5INE7vtYxTjlGz//s5qLyMVGSHZA1sTx672lVM1Qsdt+JUvvAdx0LxVEbOF25g8gGGXB6Iz2qHENqrZ3lPAmdlHABUQjIIyB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250770; c=relaxed/simple;
	bh=ngnlZvS4sJob1te9yEvLtLZlJEHgqktSliLxK7gnoXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQfmSXi+STmdqvP9BBVGunJr+vPaciEtcIB1fv91SMn6ICC2Eix9raQcGSdvl6UYVSAGcETv+ZmS7RzesrC6ehDaemFlaGsW9BYZwdN35K/n2TBlNC/r8hdgzB7T7TcDL9HT6ddHvCH0d02cOGBv0pGN7ytjugDzoaN4+NWawlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO/H8t9w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4138478f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742250767; x=1742855567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ot6DRM3x2WPjuCvUILdaemNftCV5YB0UEVXL5uJh8mw=;
        b=YO/H8t9wRX6PURkLw3d9LcBTH8u05tRaTBxHjcDoRpvxhEVrcqi5fyh8i2SU+Z5h7+
         EKjH6lL+ulH+o4aYwr2tzn6e6V0tH45DhPl/qqDv0XVUD2zN+w+FpnlDb7WhHWr+Uf+I
         XSWIpBrvJ9kYRdbiZNDHGr7XrV/BYUFR9kzYbrRcTmr2j3qyb3YB0WOsj51jFJx7tZnx
         WK3oLQTkPwgbPXi6VDaaTrVoASXwDp9b51+HSu4lwR42kuNuSZx/FR2A6tkfINKxxlSb
         wQe7WNyYG1sx3xoioiXKsDyKfrW5/WM1UF+y0RHXw1apLWnp44pYYWNeXPANisiNmn+w
         4VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250767; x=1742855567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot6DRM3x2WPjuCvUILdaemNftCV5YB0UEVXL5uJh8mw=;
        b=NTHxdBuBiSxIDeM3rhqRa66AaE7Yc+BCdPmVWtdhK7orTrGO6Sh3pJ/zV73dWmfDQE
         Mc01ZnceVdPe0g5xFZ3W7W7yzqavS4Ai3f6vOhTFSMfONW43OFvbLvqlj3s6YAYAIgm+
         I3DDXRabmYhGDysetWeFArJvxQQCbIKJlbZcF3ZRqY9z2ep8k7VKd0pUKbMiVWJIe1k4
         5hR0OciuyiB/wRBfCQ2EB7sNvuJwdSj0MR8xJiSsOhXKz/LHkA6cMW35LvuNfrqfNqkX
         j1s9ehSfLHlNecBpYlgROcQfDCBGFYZ6i3JhyO9iP0Ec9QBF5UsueuJU6hnfkWmAWC/0
         OiNw==
X-Forwarded-Encrypted: i=1; AJvYcCWVn+ZrJA5/RE3Vg7YPz8gZWudwoyAppgeNG+MUL/YyOpbVKV6u/jswLOBCyRVS9KsPecDUdALpGOxL7vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHQNO7JoRVBECSD0DRfJqwPrRH8zL/bH6xNdcSW2UYXG/FnbL
	wsEezKD35fI7gf5rbOShzqVO6rgMs/Nu9BrKOcZCvL5Id9OEUvFp
X-Gm-Gg: ASbGncuoSfFO1vnjz17psnxiwYLp2iF8otlXz7dmU/139bto9ACDwvp4Bgvm2ngZPLg
	yj+92ZK1dGNC3TIHTHFLDXQVMc25G/LwD0Z58EIUbu+1f2z29XXZv/XLE06uKBRjpIOeUN17hgW
	d2V/rxlTVOHw1dgl9ljgHQzm5MtdWB5VRn/B1dXeVZ9AjsoN2rQ+cwLhonV7VAROjhiZop/EgO5
	vo0E5F8WZ+W7Z99oOyI5EnBSl7vRygl1VPe+icAb4rs96bVpnuPNokBtKQZO9zTaG1CXaXtYpWE
	Q5UMmMpQF6GwVfK+jOAcOCWz/sqr6B0LyT7kh2aBhvoqszrPGeKZ4Yun0aCwSjcgALRcBaekvrK
	KPu6CdHuR5oQO7IXKdg==
X-Google-Smtp-Source: AGHT+IEPDVm8LlWTKxQP9QtLSYH5YE68iQcLxrRuG8Ug7L+GemtV/cs/Trjmmu5oyc/wqt0e6ZkvKQ==
X-Received: by 2002:a5d:588f:0:b0:391:487f:27e7 with SMTP id ffacd0b85a97d-39720e3cb45mr15710263f8f.55.1742250766789;
        Mon, 17 Mar 2025 15:32:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975d65sm16506618f8f.56.2025.03.17.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:32:46 -0700 (PDT)
Date: Mon, 17 Mar 2025 22:32:43 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Herton R. Krzesinski" <herton@redhat.com>, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 olichtne@redhat.com, atomasov@redhat.com, aokuliar@redhat.com
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8
 bytes in copy_user_generic()
Message-ID: <20250317223243.460e3bff@pumpkin>
In-Reply-To: <CAHk-=wg6aT1ytSaBouOSpu71ZFMY8ct1a6=HOQC0CZuHxQqK2w@mail.gmail.com>
References: <20250314175309.2263997-1-herton@redhat.com>
	<20250314175309.2263997-2-herton@redhat.com>
	<CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
	<20250317131623.2cc15ada@pumpkin>
	<CAHk-=wg6aT1ytSaBouOSpu71ZFMY8ct1a6=HOQC0CZuHxQqK2w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 14:29:05 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 17 Mar 2025 at 06:16, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > You can also something similar for any trailing bytes.
> > If you are feeling 'brave' copy the last 8 bytes first.  
> 
> I think that would be a mistake.
> 
> Not only does it cause bad patterns on page faults - we should recover
> ok from it (the exception will go back and do the copy in the right
> order one byte at a time in the "copy_user_tail" code) - but even in
> the absence of page faults it quite possibly messes with CPU
> prefetching and write buffer coalescing etc if you hop around like
> that.

I thought you might say that :-)

> It *might* be worth trying doing last unaligned part the same way my
> patch does the first one - by just doing a full-word write at the end,
> offset backwards. That avoids the byte-at-a-time tail case.
> 
> I'm not convinced it's worth it, but if somebody spends the effort on
> a patch and on benchmarking...

After a 'rep movsl' you'll have %rsi and %rdi pointing to the first byte
left to copy and the remaining bytes in (say) %rax.
So something like:
	mov %rsi,-8(%rsi, %rax)
	mov -8(%rdi, %rax), %rsi
will copy the last 8 bytes.
Ought to be faster than anything with a branch in it.

Whether it is worth leaving yourself with [1..8] bytes to copy
rather than [0..7] (and copying the last 8 bytes twice) might
be debatable.

For Intel FRSM copying 32 bytes and then aligning the destination
will be worth while for longer copies.
But I've not tried to measure the cutoff for 'rep movsb' against
a copy loop - given you'll get at least on mispredicted branch
for the copy loop and a 50% one to select between the algorithms.
Add in a function call and the ~30 clocks [1] for a short 'rep movsb'
starts looking very good.

[1] I can't remember actual number, but it isn't very many even on
Ivy bridge - and you get 1-16 bytes copies for the same cost.

	David

> 
>             Linus


