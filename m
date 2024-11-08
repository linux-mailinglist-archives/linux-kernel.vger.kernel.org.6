Return-Path: <linux-kernel+bounces-401669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E069C1DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FADA1F214A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821601EABA3;
	Fri,  8 Nov 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h86O0dLr"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1CF1EABC0;
	Fri,  8 Nov 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071716; cv=none; b=UzsA8NYVBz2nUBCCvKuFIwpmK2jdDu4NlGe34G/NZzCxySQvzzaHrm5sRPCqw5cNHUxWPt2SngHJJQE5qSCXJbVLeJu7vI7izpb/8u3YLN70YRnyCgIoMrfAgPQJNAJGBKqqvLUNHFu6yaQ8G4W6qCNQDRD338UlclmRzoJSpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071716; c=relaxed/simple;
	bh=S5DbOLQWNUmcsMMoxMl1o6JyGrdoPIXkCZq17fpq8kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZr5GKZzH7JTWC7Tzl/OAyHun651cBOtbzrZhYvmUvHGTn6mhK06Q/sOaPcA/+dH10yVRbcNvxI7Z+5822XsH8kG1C290wV8OzOk1V4sXlCwultH+U/aKrqvPiaKbEoREr2VimORVQUtsQFhREH5K5Zvoavpxd20mJ1KLh/KgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h86O0dLr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3462866e87.1;
        Fri, 08 Nov 2024 05:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731071713; x=1731676513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIM6C8Fw+FrvhJvPNyJ/DckdhYzcG9wI4TRAhH+aZuk=;
        b=h86O0dLrRyw8uieiNB8bwP/51oMgvIHSrNSFDwl1oZ/S8p5nZuCV8X/jqrTF+xT1qf
         5JNStGVR7At55ZMfLgPh1OG6XqgTHH0msqXZJLqAEQJAb0GY4ahUysswUznAraXeLpV6
         BZISwv9+YE+UivyAliJNE66CxFGGxpqGF072kKhKm3EMvVVvL6UGw6rECyaMJvpn7Qpd
         alNEtiSJh7hKiE2Cta5yUVoMhTVTTmxSEK2ISlSg+tfzkYTlku1FkTrWeuHM/92g1tCP
         AFU2Hc1FYWDTsWj5B207gaF7DRi88gq+yL7p3SfV98orZknrKyuqqMTF800otLQ/IdBj
         bs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731071713; x=1731676513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIM6C8Fw+FrvhJvPNyJ/DckdhYzcG9wI4TRAhH+aZuk=;
        b=ndJHy7RtKCirt9ebUBr/dCzjsE0r+gtC903uKZKQ6IesLcYJtEl2k4F2kmApbYYNXb
         IY567wt+nFlshEDCPPs93tJab2077rIFhEgH80cHIGHNDg0i+IRH9SS5aTiMUT9UAOaN
         iGUrMk6D3Sv3AGIeyuNpvn4waLy5DDfpIubMN+j41s+MYwx7JeEsQ/bKxwuh/wraBd21
         Hn0j0AKf6iMXfRH1ZcdqQn9FtOlPGkffWeuwGAp3jZyArFeDfuXB0OiAAC7+qdk71oTz
         gI/j0/V0aOd3K0Mn0R23Ctiu3Ud7YFWOBxoFn6v+i5esVloYbaGhCkMcMveagsmw8moq
         NVAA==
X-Forwarded-Encrypted: i=1; AJvYcCULcPlJOCbaqV0RCff3oxxhpr9zu8SI4mrQIGy6fpIZKrR4uVDljudG401l//HRLQAlHBLkgqs090WauZqfrfU=@vger.kernel.org, AJvYcCVjBplsZKopdgRpFCgIEG8gSdwnbdv+oJqywBbC6eSqLq/12g6Whz9HKqCtMkg+JdyQE/zmlURHpaOEpT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9bruwSMoRBqMId+qo6YUco1v3vRJtAMhLshxHmEs2ik2BM/e5
	1hzUnd72oGm3oeRP3sbv7TgMGVvj/ohHO9TBwfcuO/D5GoaQ56NuPQmg56nmJgB86pU81Jo8TjC
	O+F/+FFfLVbb9MO3o4aWN68ZqAZc=
X-Google-Smtp-Source: AGHT+IHAa7nTR6A8DLl48P9dU8CgvsvQIFUQhLZojDfDgTj70pc8sW9wIDWIF/zCgk+dMAiDpzJ5fI3tYMDv7lIfYI4=
X-Received: by 2002:a05:651c:158f:b0:2fb:54d7:71b5 with SMTP id
 38308e7fff4ca-2ff20280ab0mr13198551fa.22.1731071713269; Fri, 08 Nov 2024
 05:15:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-2-de650678648d@gmail.com> <CANiq72mT4FfDXDX-tdWo3owLdrsg3KBDrQC_1whA7-ZhVH4H+g@mail.gmail.com>
In-Reply-To: <CANiq72mT4FfDXDX-tdWo3owLdrsg3KBDrQC_1whA7-ZhVH4H+g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 08:14:37 -0500
Message-ID: <CAJ-ks9=S_mP9Z=3Byidn12uj15s4ACgbgVGD_JkqZ5j-X6ipyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rust: types: avoid `as` casts
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:13=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Nov 4, 2024 at 10:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > -    /// let ptr =3D NonNull::<Empty>::new(&mut data as *mut _).unwrap(=
);
> > +    /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
>
> Nit: this one does not change it to `cast_*()`.

Ack, will mention this in the commit message.

