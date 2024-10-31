Return-Path: <linux-kernel+bounces-390574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35719B7B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46631C209F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5D19E810;
	Thu, 31 Oct 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjivpw9v"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CB1BD9FC;
	Thu, 31 Oct 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381092; cv=none; b=NldnknxdS18TfMQ0TaEv+bdgUdAgfXY9eH+DQQH8DD/HZKVmopxzVlfkeY/sWH1bP98Ap1hS/rPMhmxSvnvk8ec1fqKjwujWJTORa/cjnvWN1YN+84hWvT5hNSP3mex4BmgtETLLxyBeo6f9ZZoA1iuF+WB+1EMHH48dxQgBFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381092; c=relaxed/simple;
	bh=s3Lar00z/TMKMxtUmNXahKam1H1r9Hk5LJMLQbExYfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRCNFZWAdx0HojLXaIv8vwzR6834awss/1ukMPDbP117eTEILHNo+79so8qAZc8R59gfNC9WLx7jQYwD4K6gwiY2nqNJIAePVjX7GvW2kwD3IL3Cm3FA5CxqAKuKYmurydbvwuTUGTeOzPj6IyidTTMN6Ltm/+s8SlIljGs/iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjivpw9v; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5111747cso9519671fa.2;
        Thu, 31 Oct 2024 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730381089; x=1730985889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Lar00z/TMKMxtUmNXahKam1H1r9Hk5LJMLQbExYfs=;
        b=Gjivpw9vEZPwADv2itWnDgDJ6Qe4d79xybHjm4osGFCYM9wtQzE+R6V+N9DgPWlXJQ
         6W38fxXqmir65v2mlxZ5mjsx40sOCG0hpdeucaU3hcG6IY3veAa5qIfuuiNsXTC9vtHZ
         FiXjlDK2NWIYzJsqvuV0KvO0adKFZXi9yNHKU9TS455P0IAR5vuNfexB7udZ5qzv8Y4n
         ttlUiiR7NYvkaCbRxg4hGtnkeeV8QcJHwnE2UU3k3Ebs1V7f4eJRq8edeocfAU1vde2/
         lmqyXcgQyunTgqIOC/zjmTmdfOhUgQQJvh3v4YLxmzKJMAm3bmWWkBoqAmAW6Ks9vURX
         Z+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730381089; x=1730985889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Lar00z/TMKMxtUmNXahKam1H1r9Hk5LJMLQbExYfs=;
        b=GNJPujBcClegWzsepDIxuu6VYPYwTTJOYKa2J7u1E3Z7peIQPkDfKlnD/WV/FGu9vz
         NRufpb6ORp22lvjR2MNuuHDaBCwhtaG2xJUklb/ntdvSIYxnRxREZVkkTIlBCgwlD7ha
         tl8cWq5chTlhB4WINQHvKUGZxZbup24ZEsEjRiWE5k79HE9cttHhg0svgp1jUyw6Gqoo
         2xUo6JN49y1c8+GtLSrV7J4635RhSx3JTS6PxNEjrYfZhbO2Qv7vxvu2RjaEt0ZiMOps
         STRkmcJRnV24fr3BjNnXDki6vTA3m16J6C9ed8bT6qbVFSYcdxMYiEextNbIbn8AiHU6
         hpww==
X-Forwarded-Encrypted: i=1; AJvYcCWYQvb0v++xSXtiiUHtNQ1hRbDOoXQp+CCqBYTh+kiWYbkpMWeV3yA3uqJa9EFmcdruC3h2V/+Fb4uDz/o=@vger.kernel.org, AJvYcCXHtl0x6HdSKtdFq2jIHqn6Cw1hxd/vJo7BUDlJUuTpKguR8Ss70qGgUbbADSEif0+mekp4K+ZUamzoruBuQII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFeBorp3btQ3cVAOn9LbHROmM9ooZir/NCgw1iHXahJfLxHZyZ
	YgKFa0l36dgtzvQ2iS8dmUNRK8fgWjOoUHLm/gIdRZr6jlkxSu2ne5VQsoiqpgtzUVC6R+c/+o8
	jFIR7p8OX2FpOhF1GAMB6Z2KdUi4=
X-Google-Smtp-Source: AGHT+IEnvKtIbxnAcrxbDgeETdHzFq0MmO3NjN0pPGuiojMp5x9J7i6g+2xdFn7RmNxhEcKgktDEB1pkrsf37HR9OwA=
X-Received: by 2002:a2e:d12:0:b0:2fa:cd7e:3b40 with SMTP id
 38308e7fff4ca-2fdec5f5801mr15627671fa.11.1730381088401; Thu, 31 Oct 2024
 06:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com> <CAH5fLghmVYwNKPGrtHzUQXhEyxiD=ZyF6LNHoWUREWH+dpK=DA@mail.gmail.com>
In-Reply-To: <CAH5fLghmVYwNKPGrtHzUQXhEyxiD=ZyF6LNHoWUREWH+dpK=DA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 31 Oct 2024 09:24:11 -0400
Message-ID: <CAJ-ks9mf-5cGZCGFGPLnCV-7r5PMfpJhXWYFrqq2owTeAHtcqg@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: types: avoid `as` casts, narrow unsafe scope
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 4:47=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Oct 30, 2024 at 9:46=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
> >
> > Reduce the scope of unsafe blocks and add missing safety comments where
> > an unsafe block has been split into several unsafe blocks.
>
> Reducing the scope of unsafe is good, but moving calls to "cast"
> outside of the scope is excessive IMO.

My intention here was to avoid applying subjective judgement by moving
out of unsafe everything that could be. I'll omit this from v2 since
it isn't clear where to draw the line.

