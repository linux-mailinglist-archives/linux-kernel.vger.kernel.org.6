Return-Path: <linux-kernel+bounces-300418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1395E369
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24015281A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979F11514F6;
	Sun, 25 Aug 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzpVp6LJ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834F13DDB6;
	Sun, 25 Aug 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724590246; cv=none; b=elHpkuZseISsL+Ik/JptnegySNzR6oJ83BveMON0Wxz8ETBd/miyYWJsqJAv3+TEcmxNYO5yc2bLFjCpxk6F3OniZOmPYGhZzBTLZjeFuBjxyC7bgb5mdG1tazGvVNWV9sZkq54Yj7YTh2XkpV2bcELofruCicacicBK+UFaQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724590246; c=relaxed/simple;
	bh=r9WeuWABwMmRkPqLpGJAMX1LfE7ljeaPQU3aY0g/cHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMNB8o7l44c41Q6Yu3afTOS83982zgESt4LoXK0mYV+vLHjEJhjER4PLzJqRt4zZJoxNqSJMuAeD1m13klh4PACWKucG4sDybAz4VBX/TAs8BskaqnT6ok+hSJaYDIjL7P5hGQ2AeBFQXMg+1WyOhnIPJA8tXYo6P8FocHY2NUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzpVp6LJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3ed48c748so618138a91.3;
        Sun, 25 Aug 2024 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724590245; x=1725195045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NectQEqGBNO86BpxEJPRR5vvssTGqVJHmsHRMzJiCk=;
        b=VzpVp6LJ4ZMh4+IUqep4pgWcHAsnh2GsedOOwDpFqxcimlOI3dTOIxMXo9FxodUqSc
         WHOiEXt9/AwsAaZlJ9cj8rqtj53f4iLzhE+4ICS2Smo8+13Hs50Xi0m13yXuWT9AqcSA
         P1jFHhp1HSHr09F+SjHhghnP4LkZEnTvO4rLFk6BnshPngQ/w9eDAKVWtX5FyxXIbL+u
         +p6T1H3GacBWIqy5X6ks8LD4AKYvs4DosvxCMxcxRjP7UJYV8ZsNQ6Dsr2uG2P8zwP48
         F0ZjrJrZyLwdb2vHNe4gsqn+NZMjlyVaqNd0yulBixwm3wdqb+7Few0DIJNXhm7HLJaZ
         olQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724590245; x=1725195045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NectQEqGBNO86BpxEJPRR5vvssTGqVJHmsHRMzJiCk=;
        b=kJOEt8no6IQ4B8r5VmXWgrvZN7CCp6dB3rDLphi+dGmce+MUhW2qe1BK80pS9Ulvin
         uj/oAgvy0dbNUtx0YhKIScJ52twP36bUOEZQIpMmxOxiSQGHfJnZ4iACCVcnJ5ERKADB
         H1Pnk5PcPW3ElHmeBkR23Qx3lW2CnZjTHk3EkROrKqHO0fY/5crSvFbFYtggQHaCG1fz
         7mfG67JLaNjOvmPjdKzoxPxEmz4M2cL70AuK5jcw8m4LO60vC3dx1+/jF6Yg1KqfS2k0
         0N62ZB5Q+1OzYGOmqI22IH1aYXZ8HY/E7VxhXHU8yonMTlLFxKFSVimXk8H7x/BpkVj1
         Fuiw==
X-Forwarded-Encrypted: i=1; AJvYcCUc0TcUS/9GU1OrEwxrno0xNHwClcmx1h9QcxGcaho5eOICgiDQu52TftLoRc2ajME3E4m3IVfPS3NohnaLQ8s=@vger.kernel.org, AJvYcCXPWiolvDCZM/xX3TDouUmbXuSYrn6sUO0mG90MfxMCXUsVpTVHTKyRMepUzGYoPesnO0qfN6DktObiz2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVp22UYqn5yk5SE8m3M2esbMeu3u1e32OyBCX6gGrIcb6HLCmR
	5nDCGGO01W5WppJNWKKqVZ1GiZvP0P2o3PWy9nO+qD7Vd5vbFfq6iVxX+1Etygr1tjEFMQnsMil
	DWCTVJR5hWMAHhYxjRQloPfzWEoY=
X-Google-Smtp-Source: AGHT+IFhLRblrp5yfgJOeY2kAtUzgPNt47PKkc86rSetVTd5vH/BaqrFrIKFcbLJPhBSdAsNsGH0XUv5AngSlA3qoSU=
X-Received: by 2002:a17:90b:30d6:b0:2cd:1e0d:a4c8 with SMTP id
 98e67ed59e1d1-2d646d44922mr4654116a91.3.1724590244796; Sun, 25 Aug 2024
 05:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-aref-into-raw-v2-1-9215bbca5720@google.com>
In-Reply-To: <20240821-aref-into-raw-v2-1-9215bbca5720@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Aug 2024 14:50:31 +0200
Message-ID: <CANiq72mB3dOqTedkRN2zMea_2Y88XBiDWwBHgyEAm3mWyZnjCA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add `ARef::into_raw`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kartik Prajapati <kartikprajapati987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:59=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> From: Kartik Prajapati <kartikprajapati987@gmail.com>
>
> Add a method for `ARef` that is analogous to `Arc::into_raw`. It is the
> inverse operation of `ARef::from_raw`, and allows you to convert the
> `ARef` back into a raw pointer while retaining ownership of the
> refcount.
>
> This new function will be used by [1] for converting the type in an
> `ARef` using `ARef::from_raw(ARef::into_raw(me).cast())`. The author has
> also needed the same function for other use-cases in the past, but [1]
> is the first to go upstream.
>
> This was implemented independently by Kartik and Alice. The two versions
> were merged by Alice, so all mistakes are Alice's.
>
> Link: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com=
 [1]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1044
> Signed-off-by: Kartik Prajapati <kartikprajapati987@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

    [ Reworded to correct the author reference and changed tag to Link
      since it is not a bug. - Miguel ]

Cheers,
Miguel

