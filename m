Return-Path: <linux-kernel+bounces-568098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E719A68E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8AC885E10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E12571A1;
	Wed, 19 Mar 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve2JD+4y"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB1256C7C;
	Wed, 19 Mar 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391794; cv=none; b=lvTLG1BqNxJUqafU4mJzkBkWzv3zDtIJC6qBS8/w/BUJ0vS5m6WVpS5/cT+RIPh/DbfGTQ1R6+o2mKH+Dyu+kRD9eC9qkvUOqnhYpRYDfqPVrgZKDgIT4T1Tc0nzOW0dKe8+WsRBtPut3/T4WLLSzwuQqbLbfT2FQ2RBuFSwFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391794; c=relaxed/simple;
	bh=EW2+CjP+11PZnip+nDDx8uqTPNkbK1009G41iNbWFqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjKSx7J2qF2dsqxZcUlQE6ISlfaLkypsv1RDmOqVkX2uzhF92doPn5gYN97fqw0A23qeJ8eMuQVN5dYYRcRODYoQCAkDd3E+lG0Vz/kL4Eaz3FSBBBzSMr9DHyzKROjdX5MA3mWaViO26VbqE9ZYVx7FteGh+YayIcaBOWHo9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve2JD+4y; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30c44a87b9cso61078641fa.3;
        Wed, 19 Mar 2025 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742391790; x=1742996590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2MSofc8cyvKVxUKPs8pE0XcoDtUlgqxF6FfrtYMUiE=;
        b=Ve2JD+4yg6zfxSkP88AZp25F1EQ1zjLCqA1INid+tjVwqEgfe0s2FNzcR5TdQQJ+vI
         tthcu5n5Z3jUC9PMHgYU1TCgd8DhLCUhI8uxzlxur37iis5v3faOuH8dbsbs69P6Wxfh
         9cHkl51kADFybqZTDS0DFUzgdPZxkDM6X92AkGKv4Hp+mpoqcB8sjzWoh6x+6T71/OHA
         nPh+gabi0xtDbzCuTuMEJVc5YcbqIHIQgA6yCpZ4TNBK6iwm5lt6e8sulasNuzfPQhYF
         b4uYuUgAxXoQV8zOVksPjyVkecJift1TrijtpAzICxF4RRYCecj42BYRoY/odOURe2OK
         NdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391790; x=1742996590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2MSofc8cyvKVxUKPs8pE0XcoDtUlgqxF6FfrtYMUiE=;
        b=gsJlbKUMx5PGrY8XcFvjh8dW12JBW48v8LusaDDxE3NiVcyenlliywOMAuNfyGN+S8
         37aDil59vOWoFsZoWznS5vKmDuCHRKUjnhaaCcnuqItNQ8pzx9/mVlLBOq6l2CkWFI23
         xB+1tJJaMjigIIUe15MbNWaa6HVC6uQsenHYZ+2Ic9nugcoTNPT3utlcsEYuzijCL0iU
         7L02d2MP2LCYsV5Psez7lmAF+I4lxjNSicd2jLKVQJJk7NJHmlzGVoKJxwHJP+uWQg78
         u4QOYwLAjIGWL3MAsy8ZHY9h1HGMMOkVciuDQPeW6Eq02DhOKGe+KDWlhi3P5IsiHSVm
         Y3Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV76ibGkQz6oJBx/DWp9+2UHc4GbZBxzVB8HmpnpR4tuYQMLLB1tNflmM27xJDLq/3e0R8ozwkwSNs=@vger.kernel.org, AJvYcCWSnKtM85iDQTazOcjunwM2w48TG6r1tFuAzmN2YVbpj9VW6Y4t6s+29bBeM+9tdVHzkdhBhAOGSd2bjumA@vger.kernel.org, AJvYcCXSAapBlOYtY1R7kM5n9efUUXu9WiHpCjvmidjslnqWcdddNE7g++fvgYC+y8OKFOoUF9KRCDqj63+fOXEQg+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdqcUN9u4PhlOnvpypiiHm/6P/2JiDZn0NEt2jJbLPKuFULr0
	DYRxMbSRgs4u2/L6mdcwhKs5KNnRPgIIcYXwdJoq5wKhHoUP8dDkoOqm1v+euDy1GX4+sHTM/Mu
	Xk5trTDVbZbPrAl8Yt+/z/hJoBjo=
X-Gm-Gg: ASbGncvbXaoqtuM2pzTI1CH+AarFtLpXzwFPqVrz/sKYmQPB/wZkbNj8YDYFzRRV4Ki
	biNKb4AYGy9pxw/wKVaKEzQtBEPIRXhtVQhVy0z4tJVKsIxpML0CRQaILMX7IpbbvgOzmoWKWta
	uPc9sGB0ByY+G1a9JXySGN2xpeyBLN6OcovyU//8dimg==
X-Google-Smtp-Source: AGHT+IF4UZnEdUSdxleThqoQmroEP7JDDLQW+0nYHiycAoFsWFqa8q5lYSIadDHk2oU9ljzuqsif8/Cf1eEeLepUQng=
X-Received: by 2002:a05:651c:1541:b0:30c:f60:6c6 with SMTP id
 38308e7fff4ca-30d6a39d6demr10181131fa.6.1742391790128; Wed, 19 Mar 2025
 06:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316111644.154602-1-andrewjballance@gmail.com>
 <20250316111644.154602-3-andrewjballance@gmail.com> <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
 <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me>
In-Reply-To: <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 09:42:33 -0400
X-Gm-Features: AQ5f1JrzlMF52hRTEnPnE3fmFFgkh9IFrPPTcapQYiPgOpAS7vBvzN1PK6u3ims
Message-ID: <CAJ-ks9k+A1+0CWXZmD2m0+jRqTRTNFn-=d9VXqytiOqvn4BR0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	acourbot@nvidia.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 8:50=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Tue Mar 18, 2025 at 9:12 PM CET, Tamir Duberstein wrote:
> > On Sun, Mar 16, 2025 at 7:17=E2=80=AFAM Andrew Ballance
> > <andrewjballance@gmail.com> wrote:
> >> +    pub fn resize(&mut self, new_len: usize, value: T, flags: Flags) =
-> Result<(), AllocError> {
> >> +        if new_len > self.len() {
> >> +            self.extend_with(new_len - self.len(), value, flags)
> >> +        } else {
> >> +            self.truncate(new_len);
> >> +            Ok(())
> >> +        }
> >> +    }
> >
> > You can avoid underflow checking in debug builds by using `checked_sub`=
:
>
> `checked_sub` doesn't only avoid underflow in debug builds, but rather
> in all builds. But the code below is a good suggestion.

Yes, I know :)

I included that language because the underflow check is likely
optimized away in release builds.

Tamir

