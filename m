Return-Path: <linux-kernel+bounces-549346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68070A55182
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77927A9976
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB9221573;
	Thu,  6 Mar 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZEwTeG1"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC08221561;
	Thu,  6 Mar 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278979; cv=none; b=Gr40j/4iRB6m5CSYoeaWesAyRgUHQ2lWubGCIfp7G+qJgx76yke9bIJje4Ip2Gdtjf7Y8L67yNxvnTdeOwV5o1woZjkQQrFEGhy4nPSECo3B8fCN6EG4aJfMrqHIc7H3Mpo3dO0sx3vwimAQxBz/E+Xpw0a++EMn40lpwpFLJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278979; c=relaxed/simple;
	bh=Rre3tsQ7P67NIH1eBWiW6QiBSh4za0d+d/ZYpmd2TsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFUrQZly+Zu4ORM5qmS0/Os1HSOhaZhLg2nWIP3ikqlSjIfOteVdJUhpEr83zkpbZOMZd4vv9qQOw3ouUsv9ea7LYv9NNPXP5Qv2hBkuZZfe2Uru26o9KxJBCgt14g9Drfq9qd+L3HKMkwjU/B8QFvSdjv6V8yKS1pt5PGj9kX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZEwTeG1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so154389a91.2;
        Thu, 06 Mar 2025 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278977; x=1741883777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rre3tsQ7P67NIH1eBWiW6QiBSh4za0d+d/ZYpmd2TsI=;
        b=TZEwTeG1B9f+OHZBmOATuwhwxDBSUdAsxV5mnICQV4ilSM39WbuYPlUr4fDBDDqKZ/
         lF1G/Jr3tFlitLPbJWRaX6RFVcGEZRLrsgdQPl/04JoyZnEpDgoP7Bt3teXmDW8B1HE8
         jTqmB3Pgb9Thm8Enjen5t2IPT2QV9KGE3At8vTXXnPd68KAIleKO1VQW9mqdBxGS1imB
         7+7Pn+kkfkLySr52PozyKIwnB/AAnKDAFsMQrWJHhshcl1GWeyegkcuenxId7GQyPcbt
         9e8qnnbtCQwB23PY7WUSly8HocSgABO9opciZiSEMt8wxrjT2bQiJFdyVkoe9quWkad2
         /iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278977; x=1741883777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rre3tsQ7P67NIH1eBWiW6QiBSh4za0d+d/ZYpmd2TsI=;
        b=BggQr5pyBLO5DkW0YOARyDNpdqYO7t+QuCQf8WamAZpmiVZdy+NA1gHb0Yuyw96Xnv
         SIAYhytma6FW0ZponU2+hix62qddVLf4fpIKFmFQ3pslX172MxE7/c+NH6mDH431/97u
         SPZILG+ilV76yc6+Rq2qxKpJg/INICtb7inULijrw8usl46mgAitctzrkeEfiSFQTAby
         F8aiURady1XvcqfY7hqVYkifM4KQQg8M9lU3pzs6wXsEnql3S5q/ZUKqiryrtw8rYCY2
         xMJaXtDqQdEQnfx2zKn0iE0xDKfYC6p9U257bG4gzGxEOc1vgod27cOD2KV0IfmTj0ri
         buOA==
X-Forwarded-Encrypted: i=1; AJvYcCUh63Mvwpx89NQw42drX4JRv0jvsyQA7L/B++sOt5rwObSxlASGZS5c9sTXQagqrQPPt/jgf38l+1wSZv8=@vger.kernel.org, AJvYcCVqrN7ah0petqFTTPUJL7FX4MIxM8LVSZ5ldw4163zxTyWfKKpV+YmxzBqVxizbNUPkQEcQA5mQW0+RxhhEoNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9kbU3JWFdjBfbO6IVwpet6C1HMi/9trLXRCW5WdrXcyFly2i
	Wx/J6ZbrvZLt7+bEeJLIm14qPg96S2/sTpkTALVR3yqbUET7btbX6FGNIp0F0jE0K9RTbW6GS+u
	MjDcAGyU9Jzfp34BounX5vxJHctI=
X-Gm-Gg: ASbGncsg/VeRI77pSE/E5c/Ytw9TSP5E7vJvWHe6bNixifLi0gs6cy9AVRgq9sdcA6t
	GbugxfK2w9Mj/dBmlAuMo9oklvkBC0xCVDKcN+Mtl+qcoAo2pnC2T11sj/llH9vPD3WBe6BwE9f
	FhZiUgbnd7j4ghiqZkZrPQRr/bmg==
X-Google-Smtp-Source: AGHT+IHohoEXH/Px6pI4TKEWpzlyZTq0CWYULx0ZUFd4G/eQPh82YnhefvCcDjTbmvIW+sgNbb8eocKWnxh8dmxzsMc=
X-Received: by 2002:a17:90b:3504:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2ff49634f33mr5130208a91.0.1741278977492; Thu, 06 Mar 2025
 08:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72n=gFWrv9yFmzntaeR+RH5=qeD_uOs6NiW4dHkdaopKKw@mail.gmail.com>
 <20250306160844.269308-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250306160844.269308-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 17:36:05 +0100
X-Gm-Features: AQ5f1JpfqmxFwyJn6hhiA6K_0j7V5ITxtazc-jBTJPEMb_lr1T8GOjC3CLOVtvQ
Message-ID: <CANiq72nXzY_j38ytE7KwHpH3Cy4sDw85WU2MyUe5u74oB2UP+Q@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 5:08=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> In current config, the formatting seems don't have a effect for arrays.
> i.e. this array: authors: [ "author_1", "author_2", "author_3", "author_4=
","author_5","author_6","author_7" ]
> don't is fixed by rustfmt for no format.

So if I understand correctly, `rustfmt` will simply not do anything,
i.e. it will always keep the array as it was -- that sounds good
enough to me! Most people will write it correctly, and for those that
don't, `checkpatch.pl` will likely catch the mistake -- that is all we
need.

Cheers,
Miguel

