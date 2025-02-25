Return-Path: <linux-kernel+bounces-531227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF627A43DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB8C19C627D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68368267B0B;
	Tue, 25 Feb 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syEoWgxy"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515D267AFA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483575; cv=none; b=fIYUwgA9sKq6cuOdnzmXaZWuz3fi31pf/yk/yeReCaCXbaGBUf6d0/hqwF737im4NWBc3SWQ1LwQhUUzy5P+w5mROKxhoBX8OuAUrnTl/jiXqoUOq9gvgjwgHFtDZbzz2m77CnEgvUJnVHHcPfbCjIHL40aqvaDQ45gpqbwoj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483575; c=relaxed/simple;
	bh=t3CqzkdHnut+AcOWMLBrzxQFVM0JQ4DtqoSr9BGiXcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC2eOov0yd1TbxgkFE2f5ijWeJaG70rYP5lHB85lUkFwIoxFqUYCiP11HpT9Cpxx233yoW5iTvUCpOaxF85EotcquVpM9ZI5Pc/LeQYS2IoW8WSKSdlLcOc+rXSh5Y7jPBjr8b+fwl02k0KfGo/X8Q9qSSTid4GFWrkAcnEEwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syEoWgxy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso4058824f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740483572; x=1741088372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3CqzkdHnut+AcOWMLBrzxQFVM0JQ4DtqoSr9BGiXcY=;
        b=syEoWgxyrUEQbf2zftArtuw1lmWIpEgCLvmgMNQEl2J1wRLaJYWOUki7LeIf4JO8Ta
         CrxMkyc9e3l2mqplx5mWeAJ3ealLwC+VU27zX8Z44fNdKuwzxQSOnQZTQTR4rUpO+FeW
         54J+dOJV6P2zYJi6SYj3/VwjmdF2bKm1I4EhK382f4WF2wwT4cLz43XpsYAtHrWLvVMs
         zU56VfjoU7IWbQj68UFszLIXCNQv4Y8kv2qxYS8vqoMVKQf/Bc+jgxLNnRECugnTNEqc
         xBw5yrcDV1tPxofpKeThlvRI340Gs+N+Yv/dduesOJ0/deb4uorQHM6sTEjnxT85GBJ8
         KKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483572; x=1741088372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3CqzkdHnut+AcOWMLBrzxQFVM0JQ4DtqoSr9BGiXcY=;
        b=ORUXkr8lDXHRy/v2DS6ACTWLUAXUL3Mhmt6m4ElxxVKhRHwyAZGSTcv2clLT1O830+
         JlXIciLCKQypBO+G9HF5fqephYPwuBzkIvzwJaEnnn3zuTFjOThmcpz28jDbjBK1Uro9
         FbRgrjiRKCDfhKTBG8aCO8dyzr+/ey6UvEBrQhCJHAeZPn2xHK+HIpGm6F3fHSSZ4Z7F
         kfq1lDkSlSQorhwI6xtERpfheML1G8gr7Kgkkn8by7ktdHtjm0dJ+SkiYdlR076j6xt/
         DTPa3hV6+FBO1ppYm/ShClUNU/cEOq26ZyvRJkl8agMInMw6vOtE8SbhfL1SJ5pQmQmu
         NeSA==
X-Forwarded-Encrypted: i=1; AJvYcCVuWK5m4IpFybH3S8IXlT5qENU147TD+uVOHx05tKJOHLr+cBqE+0me9olEPj3nYrwlM9MU5d/WKPn+pxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76Z8TEVcdHEcK326RPJfbxtpJJbr/rErXz5mUbGhSXDGWpZCn
	wun2vTLmQOlZjcEzOV28GYBN7VGGsUnKGOGAQFtAV14vKYzDs/km3zw1eFfnM73napEdwOl0sow
	AfmsPKOZwBlOuvHJmn53VQnrWnHRtYGATvSaP
X-Gm-Gg: ASbGnct/u4jB1qaVGyoh/bfbAg6Tw7zYYPj9m69AqABd3+B8dPI0zHWNRKhXyFWpN9v
	zNHDHYg2DEZ+AMw+ajynYlLsJXSTRaTy4EyoBqcl3NneYmuc0bdInrOBYc05Zq9UXAHZAH4G/um
	Blvd9RJZ3JfxlnuQo5QxvOe4RxxmCNp4LWOe/paA==
X-Google-Smtp-Source: AGHT+IE6Jf5uEQbdDoyduPeETuIxbOiU+I7jiNghAe4VRJFYQVTUjCbcEPTzMOlIpJV+X6jvntuOk2+/yAD6xYYIwCM=
X-Received: by 2002:a5d:6d01:0:b0:38d:b12f:60d1 with SMTP id
 ffacd0b85a97d-38f6f51da39mr14004109f8f.26.1740483572550; Tue, 25 Feb 2025
 03:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740475625.git.viresh.kumar@linaro.org> <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
 <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>
 <20250225105425.ooqvefiae5bmr723@vireshk-i7> <CAH5fLgjbW0yGm0TQcQEG9cc+i3WxbF8JKaqBUFD7=pJ-JkJ9zg@mail.gmail.com>
 <20250225113642.5fek3cy3jvmusunz@vireshk-i7>
In-Reply-To: <20250225113642.5fek3cy3jvmusunz@vireshk-i7>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 12:39:19 +0100
X-Gm-Features: AQ5f1JpyhRXUj6SpImh60VBaSqHXJn1lxTjc-AZw088K9Q8iddxPYbe9odSJppI
Message-ID: <CAH5fLggYMHxuoc1m385UL7sNB1ojAg=pwZ-_xfgHiFSV1-xpfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:36=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 25-02-25, 12:34, Alice Ryhl wrote:
> > Hmm, ok. I would have expected it to format on one line:
> > unsafe { drop(KBox::from_raw(self.ptr)) };
>
> I did try this earlier and rustfmt suggested to format it the way I
> have done it currently :)
>
> > That is what normally happens when the semi-colon is outside the
> > block. Not sure why it did not happen in this case.

Very weird. I'd guess that the #[cfg] is at fault.

Alice

