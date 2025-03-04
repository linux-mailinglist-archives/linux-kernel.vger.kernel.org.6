Return-Path: <linux-kernel+bounces-543292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2FA4D3EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA741733B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AD1EF390;
	Tue,  4 Mar 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z/LoVmCK"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3B35944
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069993; cv=none; b=t4lb4loi78uegmg555ujbLPvVM03yx6WVAR6PAuCJqW9V0MBrbJwVNReuLRoEYFcPJ9TIMspZazVCgX0utmYK4E4Lqv40Xz5Qn9TbyBd/4Duo4jxcJNQ6nTzWmM2eRBFaysqglhTfziFHVXgdhIoJpJC/dmxvvmqFEce4DGaxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069993; c=relaxed/simple;
	bh=VcSDZCPSlilk/nQT3SJdh7P3PWn2QylOjDn5IxXXQak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUwAloKZJjusfRzTQ1QRhEjG5dLo1V/wepn6eIJGfPbdRVhKlPkcTGL5q5LeqekKR2sZd6RU82eNveaaPixPWvn5cQvC5u2ddeRPZqtXCET5icsdPQvJzqL61ug+2+OX+IlDpdWRxlfQjH4PDiSifID5UAIdUUGMUsN4nLu9v4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z/LoVmCK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec111762bso962239966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741069989; x=1741674789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPfpycxRLeXPq3Vn47UB9XJqE73Xmj0YUhuOs6CYk+I=;
        b=Z/LoVmCKLnhJb81lughFALWjqBrpilunt9GEY8b2Oc2L6dwmrPqKfb/Aia9aYOeJ5K
         5shhzI9BRnk+YSlzKjTnYUT6xR0FMw3TWnZ2YZ3ZU/nDamenC9EZQMaQRWKtMnTYdprF
         MUleghMGXoRFsskH6UtSDGHX0qhVzhIgamXGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069989; x=1741674789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPfpycxRLeXPq3Vn47UB9XJqE73Xmj0YUhuOs6CYk+I=;
        b=EWiH0cbpQD9bvAVbikoJmKbnXIlYlzPn6GWhCKReVmpRoHXXSNwdAKflNE+F3mxZTQ
         mNeYO+Aubh+uk4VY6NJ42p1m2xCKFkppK4M0rwKCh4e7/KCO4inqOPlvZElFyy+MKz4i
         zzEkDLvGa2CNN2RGjzdXKzELX83NhYqMk6crwe0FUbIN6e7qCJOYxXk1Y1aYgwNVHNWJ
         bqaPtJGIdLnqLSWDDU2bvQfvMp6BDHPWTj0S+UV4F/ZT1tVL6sPela2u9txUZBkt+9AB
         hDn/Sl8/Pd7jhmCfuoZyUVGPp0vMLGOP0Xfx6D/RsnRk5omjPK5ycOhD9z6dNmzq6wys
         KS6A==
X-Forwarded-Encrypted: i=1; AJvYcCVfyHlEFNlOGIoA3daB7U51RHZKRiCq+ItN4I7QwuHhlrGf4dyOl84lIXIr7WukOI1kMSVceyu934jGkZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7DEetYQTuR7QXPIQaGV3655Qc+hq0W/yqt+qfoWZa/nJkd7c
	KU0ojqmm9e+Nq17nPW2kn0OcjvLquzUmW8OJ/IMcnbDbum/D76Fg4QGuDcHsHWgVwhOUbeWHa+U
	8Tes=
X-Gm-Gg: ASbGncuNVZi+MND7TJ74JkmYcpvkgnWv8+U1HcufWbka0oM/kIZvhg5A9M4PVZ5Tsr7
	e1ICqHFVyK2yJTve3A5F5x35QiFNiz89ARfsh4IPL1MrGnFu8InAqJ6XQZ/GARpx2DVaBDTW7Nx
	9FlxkbrKCaxPb9jNnLGCDf7VXmjzy45yVXzIXJEI/1P83cedAQOroVoH4GJJm0Z25L+x6ZdF3Mf
	959r4t6RGG1rT/G3X5YIgi2+8EKgYyI6qxur33tQcRtxQlSovXQeO/ThrvBrUfIPwqYynGRvzpI
	iTK+KYY0NMRkHBgY2xGWS8G8smUNmRJfREcIv6uJzP1F6zlk1W6mUAMV3npDgPPieBTY0kQR25C
	4fP4PQIbhnQvLnOEEH8s=
X-Google-Smtp-Source: AGHT+IFWEYv/9Wi2/AF7c5SJW+fJRwPtQs7r+7iY2XdE8hjqE6FbPU5Qaoh6k0qmiadVxzbLJdUHJg==
X-Received: by 2002:a17:907:7d8c:b0:ac1:ef3c:61d4 with SMTP id a640c23a62f3a-ac1ef3c6a00mr162981366b.21.1741069989202;
        Mon, 03 Mar 2025 22:33:09 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f8d78e80sm39168766b.56.2025.03.03.22.33.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:33:07 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf4802b242so552804166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:33:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8OOrkDreSnU4p2ryqRKC75Nv9ivtq8i5+3ceusz3iiLT/ZNKJIrmJn7jgYXPtfHVPxmKxHC7zd0EwROA=@vger.kernel.org
X-Received: by 2002:a17:907:d90:b0:ac1:e2be:bab8 with SMTP id
 a640c23a62f3a-ac1e2bec4cfmr418813066b.26.1741069986218; Mon, 03 Mar 2025
 22:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <1a969884-8245-4bea-b4cc-d1727348bf50@amd.com>
In-Reply-To: <1a969884-8245-4bea-b4cc-d1727348bf50@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 20:32:49 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh804HX8H86VRUSKoJGVG0eBe8sPz8=E3d8LHftOCSqwQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqCPbp5F6rtPDaoEtKo2cLB4OW__15FO9jOkbpgZdLjhluznTu2FTcwa9g
Message-ID: <CAHk-=wh804HX8H86VRUSKoJGVG0eBe8sPz8=E3d8LHftOCSqwQ@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 19:31, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
]> > ENTIRELY UNTESTED, but it seems to generate ok code. It might even
> > generate better code than what we have now.
>
> With the patch on top of commit aaec5a95d596 ("pipe_read: don't wake up
> the writer if the pipe is still full"), we've not seen any hangs yet
> with a few thousand iterations of short loops, and a few hundred
> iterations of larger loop sizes with hackbench.
>
> If you can provide you S-o-b, we can send out an official patch with a
> commit log. We'll wait for Oleg's response in case he has any concerns.

Ack. With that testing background, please write a message and add my

  Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

and we'll get this all fixed up.

I assume this all goes back to commit 8cefc107ca54 ("pipe: Use head
and tail pointers for the ring, not cursor and length") back in 2019.

Or possibly 85190d15f4ea ("pipe: don't use 'pipe_wait() for basic pipe IO")?

But it was all hidden by the fact that we used to just wake things up
very aggressively and you'd never notice the race as a result, so then
it got exposed by the more minimal wakeup changes.

            Linus

