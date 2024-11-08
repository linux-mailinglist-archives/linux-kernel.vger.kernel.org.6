Return-Path: <linux-kernel+bounces-402015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5E9C2242
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4071286115
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A6194AF3;
	Fri,  8 Nov 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDxM5613"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4F19259B;
	Fri,  8 Nov 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084034; cv=none; b=oJNwZje4DOlz0RlXA8sQmVZs9ctrlhvt8AItSC3UEdvaP3p7+D0fjcGICoLZNR0BMusVM+0ybvjP043w7i+rURucvriKJF8LWCAAR9oCtAhPKMos4O1JMvDFG0SYZEIo3lxinuCKKUIWtnAmNbPuCWQKgJX4CBuPxDmH/qNZ96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084034; c=relaxed/simple;
	bh=KAo8pu9w4Czd5CgMz5jJ4Hx0msYaO23Mn2vfozf49t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBlBgc4gQIBeUkio0e+Bzf7kzxeHBSxPBxkYvgwY8fYZw7msUz8odTMbKAnus5umMaujHDSt01zlMl7R7VY8hKW9w2TCRgM4Rn4qAiFNYa+q3z5WF+5PBmi0jl0Lu+hQq5T3GsWnXktuznsU7yn+YKBBoPq07oVIVhJjljewB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDxM5613; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so2897788e87.1;
        Fri, 08 Nov 2024 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731084031; x=1731688831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gxVJPWQwvi0DCSX04vTHmYfhoauBYYB6/pc9DaiuwQ=;
        b=DDxM5613OhtqRlJO3xmBQl13Z7xSzqTu7Oy2vGJTpvaoeQOB4t46Vbyq5fzQeWYyiw
         KkJM5zyxVn7mWuqVlhpPz8FIZLs7m0RmuJy49Ii4NPFOS0Wi50WCLGtD/3fah5dXeo+g
         9eCCcVW0IGmbR9BbH1fua2dOLKD39V6+uEyjGcEwk51DubfwqIjL3htWZR6vwajbP3W6
         0wRMvR4/xkt20Tbgfrb0f7apha4oDpKm+r3BrHpllKAHO3yDVl8lvV/XapYZNHMeqQYn
         8zC9xtfRof/zYA0NTbHqSDF7/vBnf3qbg1nghD9gfMXfCdHYU8coxsZbuzbqcgxfWQy8
         d22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731084031; x=1731688831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gxVJPWQwvi0DCSX04vTHmYfhoauBYYB6/pc9DaiuwQ=;
        b=hpWZr1o4QNlNsrSJnM6/9U4/zOXra9dB5eBPZ1Ch2GgL6GFahE8O2i/ZbUQ5eCwN69
         m5vO3iIp9sE93arhF3fgt6dlcG7ikqyB/ecuSuqkbBwL9nAMdxYbKaAakh1eD8izAp+V
         kaJ6EXPMmUe7WQ+ZDIV8husoyoDCjUTSjKvmYzqEUpoKaLMi4vrsNFeT8MKG6eLGqgBp
         oWU3Rqv1LZoJKSDvfIxDnLSUmE8MTzKDL3EovsS82OH0Nm1b36XWp3lVEw50fc5zdi6e
         iRQpaN4w1tX26z148BCjc0a+bk2+D1VwM+trJ/Q46IcPq/q0gBKGzHpdSHeI/G3xvj49
         VPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6jERu6svgRUHHBt8I2wSPE/Qbe4phfEMzRuTkptgPHomr+v97Wo6F+7ksdIWYms2TCLdCMbCZkJuuSfJMOUw=@vger.kernel.org, AJvYcCXDTCKB+WXAEqNS1MlKwjz1AZ/bsdPcx3AxlQpYzsBd0TvWhWKT+VO4b2ve9ZqMx4qTayRXVtgJokcwYNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyplmzgXisODWRm4Hxg8SKbCCcMoUVecGgtBxQO0t4QP0T2UCVe
	e/geRy9tLuqqKyzas5j6odd99FIvRhpkXyGrnYhKo72ilW8dR8UecqMsv+hYGAgjesMwC31fwaI
	SY2Hi7Q0t7ZPkqaxq4c/4w/EvqCY=
X-Google-Smtp-Source: AGHT+IF8us+cJ7PxviL9PMAIa189BAYZRJ3E7m6WWtKr5N+PrznE0j+9LpssOLHinDhpkIRYPX4omESaJ4iTi+2hXBQ=
X-Received: by 2002:a2e:bc87:0:b0:2fb:6169:c42d with SMTP id
 38308e7fff4ca-2ff202aae04mr16432061fa.41.1731084031036; Fri, 08 Nov 2024
 08:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
 <20241108-borrow-mut-v3-2-b7144945714e@gmail.com> <CAH5fLghF-B3eGnN3yQ_eZRWWMQa-CLDZea6hgFM3uS=n-GNyzg@mail.gmail.com>
In-Reply-To: <CAH5fLghF-B3eGnN3yQ_eZRWWMQa-CLDZea6hgFM3uS=n-GNyzg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 11:39:55 -0500
Message-ID: <CAJ-ks9khaR9juEXN-PGiF_vBztf+JRXGnAJv8oe3SY+YC6k-Xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] rust: types: avoid `as` casts
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> > @@ -333,13 +334,13 @@ impl<T: 'static> ForeignOwnable for Arc<T> {
> >      type Borrowed<'a> =3D ArcBorrow<'a, T>;
> >
> >      fn into_foreign(self) -> *const core::ffi::c_void {
> > -        ManuallyDrop::new(self).ptr.as_ptr() as _
> > +        ManuallyDrop::new(self).ptr.as_ptr().cast_const().cast()
>
> What's up with this cast_const?

Doh, just missed it. Gone in v4.

