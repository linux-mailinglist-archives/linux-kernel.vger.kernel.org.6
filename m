Return-Path: <linux-kernel+bounces-254931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E993396B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5042835D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374A43155;
	Wed, 17 Jul 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF9hiSgl"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA53D3BF;
	Wed, 17 Jul 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206336; cv=none; b=e5uAl3LSKCtc4GmYXkpILN0HoLXQW+1MFwMa1cQi2cCymjFoS/F9ahuGYv6GfrVusRXLO7UeBVbqIM544EGbi1rMEHr559k6eSf6HebJNBfgT2So65LOHnAB0oWgPTJ5tzw2eiyhXXyadiYdZSmRmmqDEVovhgvKulCQM0EVQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206336; c=relaxed/simple;
	bh=DhT2MVW6V/NGu+EkOUuOHwSOeb8p+64GEUOYF7DLdf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJEiPVbIAGqwKqKaVfDw/fpYH6Ix0dssZLhD/n6vjabvnDC8ZpTB20xmox03wbjO15Rt05n+ThIGgicvyjvuRsYlMEKgKDpWLtYhF4gGdK76Ho7rUmJCwjNJruFjsds3whc/zfp8Gd8sk4IVZAR/AO1uIRmtHXwkdBBV/tyJhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF9hiSgl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-795d2aa4ba4so1267547a12.3;
        Wed, 17 Jul 2024 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721206334; x=1721811134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfExU3AoDWpSz6bhW/C38P2ws0pP6aVCMH89wjyqRZc=;
        b=bF9hiSglhNZ9SDWBpkXk+gvtz0Lq2L+CDcB5QKLTJl275oer1VWpmLAXrq0hkJII+S
         1BbOQxGNTj1SJbSho4C9lPFytx7EHCyavFiDXGOfwZz2nMm0AGStDcMUAIuA1nUk+Fdf
         1Jy94j2qob0Z79YFrpZyGHTSD+hj8voJ5EiWGqEe9wzlmVuEGkNm5wJZseL/4kIl5toJ
         O+dQDiEmWCdrQBs6f/MAM1+aCh424UZvOBu2fo6vXom5TugqwYfWpglK9NSWgFGoVzyD
         qsVgTvwWKduMMAyaUSyNwJ39l0z+d4SuwZRTSXgRiv7na132T/trix6XWZvu+NZrGYXs
         cJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721206334; x=1721811134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfExU3AoDWpSz6bhW/C38P2ws0pP6aVCMH89wjyqRZc=;
        b=F3O3v4Risr+Z1J7+/qVSf5fQm4HiteemRO9yvY7+HNcHTmIfmcRPDnooOoiWlqpJC0
         pCerhD67yn6hF+VL0nhbrYmHo7xnH0DDc+pcWSrGON5UMx3pOx6juLb/3Il9X3LMdon3
         /m130i96IQwa5a42bc6J6d5Ul715SBEU7g3P7NZPZPZg2ig8qew3tc0/QbLm+uH+E02W
         64UxlJ3MZuf2VBj0IIVtVnsfULIlgenahwEbyFDqaiPs8LpKLCqIHOJEZNkdkqP2Cj0S
         iIw+wYFhSkm5qvozmniCV3vIIrT9JTGWVnC5/3IZn9R/NqgTDNXONiZ7iCR4QRh6p9Yg
         8/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXu6q7byKpGTpyB6Na5LvyngE26l4HJ2MAgP9P5jyldlaCU/zHL1WhNJ+6bPHU6C2xW3FbpJzW02u16NhRk2Z/yefLjp8qSR6rZ4fRPkcN6w9hNnuIyhnO5mwsV4oHtz0r25Cf2m4Y6Bquz78Y=
X-Gm-Message-State: AOJu0Yy+aa5i7wctkNAnesdePDMMM1nGojj9WO24U9IQKZDptF5PynI5
	ortBZrpNwDrTEuS+cstbp8XSWQqlJaEWxwYlzB1bBOUWUJ5vKbqt5YlomHmtFd+0iDH4tex6dH0
	1ioS7Qb1vmCgXor1Jl5RjCP6jClyHZTwS
X-Google-Smtp-Source: AGHT+IFJycnzEM2+SeKpBRzOLBXMWZqQ4DXLGye2aBQccdmWkkaEhULFCP7ytIFJJWtNIiuEF0qy0nVMMoeoejupyJU=
X-Received: by 2002:a05:6300:4041:b0:1c2:9969:60e3 with SMTP id
 adf61e73a8af0-1c3fdd545c4mr918165637.55.1721206334147; Wed, 17 Jul 2024
 01:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717034801.262343-1-alexmantel93@mailbox.org>
In-Reply-To: <20240717034801.262343-1-alexmantel93@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 17 Jul 2024 10:52:02 +0200
Message-ID: <CANiq72mwTq4m-u0QO2tdF5Z8++xnepgtG_dALwq7ar5JOkwuVg@mail.gmail.com>
Subject: Re: My first patch: Implement InPlaceInit for Arc
To: alexmantel93@mailbox.org
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 5:48=E2=80=AFAM <alexmantel93@mailbox.org> wrote:
>
> This is my very first patch for Linux. I have lifted my arms up, placed m=
y hands on my head, and tensed my non-existent abs. Punch as hard as you ca=
n! =F0=9F=99=82 I am happy to receive any feedback or critique, especially =
regarding whether these are the correct mailing lists for the patch.
>
> Over the past few weeks, I have read a lot of the kernel documentation. H=
owever, if I missed any crucial parts, please just point me to the chapters=
 I need to read, particularly concerning the mailing list part.

They are the correct mailing lists :)

A few notes and nits:

  - I think this email you sent is intended to be the cover letter of
    the other patch. Typically, you would generate your cover letter with
    `git format-patch`, which follows some conventions, and then fill it.

    However, for a single patch, you can just put this text below the
    `---` line (i.e. before the diffstat), and that will not get committed
    into the repository.

  - Your email's From does not have your name, which is why Git decided
    to add From to the body.

  - Commits are prefixed with the subsystem/area/... You can take a
    look at other changes in the vicinity to get a feeling for what to
    write.

  - No need for an empty line between Link and Signed-off-by.

I hope that helps, thanks for the patch, and welcome!

Cheers,
Miguel

