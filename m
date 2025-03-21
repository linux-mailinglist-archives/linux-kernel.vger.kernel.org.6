Return-Path: <linux-kernel+bounces-571520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC3A6BE4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95AD188AF66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0E1DED72;
	Fri, 21 Mar 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCIcH9EC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647229405;
	Fri, 21 Mar 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570711; cv=none; b=s/9Y0kMFRgbl2tLU02cZORxGDsSsiK5L3SsY4jSqfG4z5hIQuaUKvRSFmcv9zmRyQdHDcnFoGvJcBkWcudAMVp36VaQrkXjcKAQ6eK92e8e/bkhqYThLNAWX7/wiHlSWzLJNdqNn3NwsxTwdqMgDO9eOgP7hVhky3selz4utyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570711; c=relaxed/simple;
	bh=gonmBaD35T6vhYWzr4nVLaUUNngSAuVoY9nj188RzKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAgsnFeEtwTaTrlM2khwsscfmB15aKaPwvaNFn4QD7b/F4xo+QiYLyECu/m2MJzLFASs48LEx2F85zDEXRj7Z+tp4VER5tay2CFacK3jt2VD5s8TBHr/TDGmUN/UnyvgfiiQ21UNm0H63KCFV4OsaEg2v9Qj4biKPzjrzDArWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCIcH9EC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf1d48843so20329861fa.2;
        Fri, 21 Mar 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742570708; x=1743175508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FeMkEswfDRDBCyza92nNhHVhv8r9MHi5/ng87liaRo=;
        b=UCIcH9ECfC0huBZyIcrC4rKhmxKUheAn/sOY17bEe4VN7oldlJqR+08r68zwtsshr5
         P02WJwqlkYiD8Mb94PHXLv3YD4Yzd08AucHU1pGBBcPiinq0X8EEqFdq1gM9cx6DZIIF
         YnmKoZPN0LEGU4qP1vqcpI7lKikhLr2eYP4ftcoiK/Zr12aIDogXoHyKoF1z7MVWCjvy
         uCnhXqy+n7OclFPtCMnD91UFUkWWKQ1iPFLxxcjRqUZkMFqCJ8D7Z7zaMt4KG6xDh9/q
         6tpRh+62TIb7DP12i6fj+ZatBAs6JOfKLK2uH2Gd54ZS8M+AOGKuggOL1+tS6fMBSoJk
         2p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570708; x=1743175508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FeMkEswfDRDBCyza92nNhHVhv8r9MHi5/ng87liaRo=;
        b=n93vae7AHQq1OqHVtS3iReMc19PLXyUTOIPODMMyD50jO/zTZ+/Q3r2CfLTrPFTycA
         ne7iwtvTcuR+5J2qvZHHSvEBy9L9jaGgC6LQQKTs3owo/feJhha2D+0HdJVkv6IYcHeJ
         ifYe2figPOqo5QTIN/jv6nslPKEGZHZuQmwvSK23ZjtbzZ9GfVpSnScN0oYkWQfL7Zhs
         1hViFkxC/4/k5idau9fWplNNh7gTG47dJiXikIKH2QWF9QwANMNXVck5zEQhVerIB1n9
         8L9AMSdTY0mt17AmFplSZ15YfZsNKVqtmv8svPRiyK77BBsbE4k1muoX7nUTXRXCwIxe
         uorg==
X-Forwarded-Encrypted: i=1; AJvYcCVWF/JAqfrLvbHxxKDieO+MEmvgp336jGAg8LoBR7dcc2bvk5SB2hlW1AMrlvJzTYg0OCtFAF5n2wJzEDY=@vger.kernel.org, AJvYcCXi/7YJ/z+kl6UT5QSDHz/yzTWwwJhxW8lKnJPbe3WkEkNqHkuhoXfRqXNxQkJ1xpgIGT38nUZzIIAjmxCY8Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XSlKjKr2x/f5OS0DF2BQ/J5YXutjzj43pFAc1YpT1YK1FZ2D
	RHctQ+EvJBYffPIhCZNHLwbj/ZrtotbFhVYz9LyHR8OPKF9FyG0voMeb5LxmIkkVJh51mBuUCaa
	HdD8g30PngkgBjToEHf2KPKUuSTKOn3vwEbbdTQ==
X-Gm-Gg: ASbGncse9H0WMqSperGsrTNo+l/oOZA+VGrsIYMrqhcR+lnWY83qmNUG4Pw38YxmoPN
	pZrICnCE8H4Tmft6JdppF4J/SvH+x7l3kx53CWeSP5CeMGCSaC6IO+Rzx6Jq8BVSIprQHQontmt
	IoT+ffKWgToBMZrLFUFvTNIdrHi2Gf3qvOnH1K64dtZLPB6HWgUK1y
X-Google-Smtp-Source: AGHT+IFV1kwk7Dc1/DJ8opPqj/YijponY1HB8C2Apxe4rbjqW+R/8bqgWst9NM8QjnR++Gs/zUMZYMaJ9OZq75kwj08=
X-Received: by 2002:a05:651c:1189:b0:30c:160b:c766 with SMTP id
 38308e7fff4ca-30d7e22790emr12839181fa.14.1742570707834; Fri, 21 Mar 2025
 08:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com> <20250320-vec-methods-v1-5-7dff5cf25fe8@google.com>
In-Reply-To: <20250320-vec-methods-v1-5-7dff5cf25fe8@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 11:24:30 -0400
X-Gm-Features: AQ5f1JpXBlGnQ3JazYbDH3PPIovQYCgLxV02N5l_V4O0jjX8zkwXC8nGFpuSlPI
Message-ID: <CAJ-ks9k=SxS_zAATadm8SZkfcY2OciYNaty3=WEs2iv5nFJRyA@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: alloc: add Vec::retain
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:57=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This adds a common Vec method called `retain` that removes all elements
> that don't match a certain condition. Rust Binder uses it to find all
> processes that match a given pid.
>
> The stdlib retain method takes &T rather than &mut T and has a separate
> retain_mut for the &mut T case. However, this is considered an API
> mistake that can't be fixed now due to backwards compatibility. There's
> no reason for us to repeat that mistake.
>
> To verify the correctness of this implementation, you may run the
> following program in userspace:
>
>     fn retain<T>(vec: &mut Vec<T>, f: impl Fn(&T) -> bool) {
>         let mut num_kept =3D 0;
>         let mut next_to_check =3D 0;
>         while let Some(to_check) =3D vec.get_mut(next_to_check) {
>             if f(to_check) {
>                 vec.swap(num_kept, next_to_check);
>                 num_kept +=3D 1;
>             }
>             next_to_check +=3D 1;
>         }
>         vec.truncate(num_kept);
>     }
>
>     fn verify(c: &[bool]) {
>         let mut vec1: Vec<usize> =3D (0..c.len()).collect();
>         let mut vec2: Vec<usize> =3D (0..c.len()).collect();
>
>         vec1.retain(|i| c[*i]);
>         retain(&mut vec2, |i| c[*i]);
>
>         assert_eq!(vec1, vec2);
>     }
>
>     // Used to loop through all 2^n bit vectors.
>     fn add(value: &mut [bool]) -> bool {
>         let mut carry =3D true;
>         for v in value {
>             let new_v =3D carry !=3D *v;
>             carry =3D carry && *v;
>             *v =3D new_v;
>         }
>         carry
>     }
>
>     fn main() {
>         for len in 0..10 {
>             let mut retain =3D vec![false; len];
>             while !add(&mut retain) {
>                 verify(&retain);
>             }
>         }
>         println!("ok!");
>     }

Now that we have kunit in rust-next, should we make this into a test?

