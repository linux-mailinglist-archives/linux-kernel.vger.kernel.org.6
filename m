Return-Path: <linux-kernel+bounces-401605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1194D9C1CD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE30E1F246A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425A1E7679;
	Fri,  8 Nov 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzBlbeoT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8C1E47C4;
	Fri,  8 Nov 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068579; cv=none; b=rnn4TGsK+f2XBSGI9iRi3tcliWDVUA5uelWfqDxd9nANdrXyfb7YaQNplPr2HuXZ1R7e7lmmCCh6HanlfipME4/XYnxwl3Yy1Z9GHtohg80PJ9/AjlcL0aqq7iNAA+I+nVuzjkr5WUAtALCIX90gbyxFMwLrdU6K6ydZnWaWp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068579; c=relaxed/simple;
	bh=2b7dYs/mmpG9lxNkDG8ZJcmFoOXZ0jGWnduqvTW4bAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDt4FlaK7W9X1BSf/NLciLdP2rfiDuEu6kcuHHQ9Uj/nahidiE6GFPqisrPZ9b9ff/sn49jSO3GGm0y/nGnBEtwJDBAG73ykoblGC3pF6GRRIIQJvhNDfeIsBDUtsscXJqzvnkmKbwPxUNSSMCRKM64RCOJWK5C69fjmWwWtPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzBlbeoT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb518014b9so18873791fa.3;
        Fri, 08 Nov 2024 04:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731068575; x=1731673375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b7dYs/mmpG9lxNkDG8ZJcmFoOXZ0jGWnduqvTW4bAI=;
        b=CzBlbeoT6zZqY7ca2hG7MQ2Ln0bdlNwIXI58PNyHH34BBGMm4xmvkC4FbZRfXMZiPr
         HSx0dOcIRKugtvK4mWafPAwZpoTkZXUFD7ODIxeustzrMCyhwAp+UxD0CBvfPpSJUzBF
         Z3hpOhnTiSJlso805WkhoR4xhliN/cokv/9fT5pqqCT0A6jNmZjcInHxFINbBaZLZjX6
         RKyCrwye+OB9bAizn8LqPyjku1kVdzOesxSlu9mDFr90ubGSrUr7RB5sdlEycjxfebJM
         uqP1OrKf66xO20YkMVAlnrF6AiI9Bd43S49HwCtLEBmII36/EOF74BMMRz9VSzw4guCh
         EhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731068575; x=1731673375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b7dYs/mmpG9lxNkDG8ZJcmFoOXZ0jGWnduqvTW4bAI=;
        b=TTXsxEIqHIwNOqw3JMUunsWH2gx3AyuWKLOI6v3EfzQu4H7BaCSNy1aH0s75uc2m6s
         Lgd4LabLpsYp5Cx8G+uZ7W+a2TRU6XEZhXEkAfEHMXqH6dfrZnlEd8pbfQ6wy92BD8zI
         F+2B38AP939Wx44raMgdOvhrVbP9rJoKaHR4tJYVBUN2PCDJBi8fUFdBPFXUUSiRBRNT
         1Opui5WBEWXj1qevMGymHC8/2ZCvMyzrhPGJ7xFFwvnn3zKzfiEwy32ILkndcf/RzTny
         sAkEPlld5KC3Iiu2X/1o5JA+hYp7rRmsg6oTq1ctlclm6T9d0FAhdOt0ZV9Rs4NxM961
         JDvA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEIYEA439vFX2DF1tJwNq0/vSLf3wYKVAaBAUtLuETIN/hEsKW+gkyuJ6uXkrB+iMz6liViakJ6u0wk8KvlA=@vger.kernel.org, AJvYcCWgIONuxmTzvl775c+8i/xhBcWhhGtjwrcy1XTCeQeIv3egTp9dgP75waHfZJ7QD71+RkPcTVTQc6H2beQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eo5VvHChbsCvF8x2vYR0TqnWEoIoFYRLG0f0195edry3HyPQ
	Kfiku4TmxNatWLwPSfaN+YJ9ndDp/pQcc+4LTlHzcj+R7r9PAKzxu+UCkpYTjq5EiQ7SFneolr0
	TKDTpxll6mOJwdOT6xc7f7qM9A/EPIA==
X-Google-Smtp-Source: AGHT+IHFlkxl7RBeHD/BOcMkJ5+RF5KJw/QO+lXdYTzZvhY/jURdU+h0iQcjQKD9OG0T4N4btsac1NazYjQjoh56jCs=
X-Received: by 2002:a2e:b88e:0:b0:2fb:8774:4412 with SMTP id
 38308e7fff4ca-2ff201b7ec1mr11556621fa.24.1731068575157; Fri, 08 Nov 2024
 04:22:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-2-de650678648d@gmail.com> <CAH5fLghWusxAnU7avBueJmsdbvpoabb3=ckA7JvaZX6iha960A@mail.gmail.com>
In-Reply-To: <CAH5fLghWusxAnU7avBueJmsdbvpoabb3=ckA7JvaZX6iha960A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 07:22:19 -0500
Message-ID: <CAJ-ks9=KuD5gLGh2q1q_=L0fR18HXQo7esq_XK5aEUoUQHSFQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rust: types: avoid `as` casts
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:35=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Mon, Nov 4, 2024 at 10:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> The compiler auto-converts from *mut to *const, so only cast_mut() is
> necessary. I think this will still compile if you get rid of all of
> the cast_const() calls.

I thought that wouldn't work because of type inference but it does - I
guess the compiler derefs *mut T to *const T before the cast() to
*const U.

Will change in v3, thanks.

