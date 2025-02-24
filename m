Return-Path: <linux-kernel+bounces-528848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF23A41D06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8339B3A9DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60D269CE1;
	Mon, 24 Feb 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VZ4GezC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BEF269896
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395982; cv=none; b=JeTk9k+gBYCMXCqI5RXsPztsZfm1xO7A6G7NsLnoq80RZZ6YnvaQHNPDlgiJ1zui3a0rhlminVu1+Rpg9i33Ryp0bNuO5QKS/wNGAFxvys+FaErvRpvTS5vCI5eht7HUZ7Yd+k4E6qUaEeSejZiP5osrmqDk1nZe+S2g/wq8KSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395982; c=relaxed/simple;
	bh=nbthR7RhGoVVTUAl39Aagc6UcJUc0m+dmOqj/KUfZkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pz2fi/Btr+pl16pCk13eIF7P7vq9PbKl8nRhyRprh7yt8jv3g5if6IbwhZIc0qPEKJ66zKRz5NtrhEoqwI3h7k0o5aQW34ZuLIQtEDxzt5K02gSRV3FAtM/HnuxJ2Edolj+0hr4iCegKe4IDf2FnXuweFX06T+a1CCAmytlnewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VZ4GezC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so40395435e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740395979; x=1741000779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKNwKhh4dEnTxVcOajigIGSRE5tzPUoKtH97+XkBOAY=;
        b=0VZ4GezCHOwKdwLfQ5VDyjZVSCXbOP0WjrkfEAJDlxXvGmbi4j89u6ULlqzWekFGQD
         /RpJSkB/zWldxW2cGeVLX6xjkT96koI3DmOo9BmTmsVlkFJ0EXxVr+LseevM519Ooz7d
         gH3eFRNhS4+E+0j01rFtHiGcyDxOG5k7LcsFA9Wty53FHACDYX5xku8QbM7lJTmdbG/N
         wJmsoTTXzu64C2KOLCp8JvWh0q75bK1YNz3AzGkqNKyI/SCuAGwo8n0d9uePwxhNm+zJ
         wmDWnqR1JHaI99ygIE1AlHk0hSFmdix2n+FhQvnXcGy88RVByyDcoO4sRVSzTJBV3kVS
         +vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740395979; x=1741000779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKNwKhh4dEnTxVcOajigIGSRE5tzPUoKtH97+XkBOAY=;
        b=QVE2qB0bEeEvONrAwXAbek6DcL6YXA6E+tlf+eNHMPxKIR01RlShMhYqQYga8pwDwa
         4dKhS7JvZZGLTZpLtNh6LCEwmY8AHuaE2oAXvKk8w3rvDz1GVxTSWqvFvuS7BM8/zkQa
         886s1G9Pum8S5SPEHNFKUQ3dAxoMkzV2OPhr63bsonVoMDNg5Dch70oSZllHHxRwYyKP
         thE05mTfkzhfRqSZsUVd5yveu/EMGoWFqKyP48C9Nb/WsqQ3wDrrTQYm9feube2SILA8
         mb6e26IlPrm7Wh025RdL0IW0qSKrQHVXe/i1sDVyc5DHG0Osf2wNXVXR14makXcAnl8K
         Rg1A==
X-Gm-Message-State: AOJu0YyrpCHC5oVn04wMazfya/e3KFbwlHNCnNlpAVnOZKZpBRzpoSbG
	JlbWAQWt7qF2dkTwPNKQrNU0Vg0h5fzbyUxmAyXBK8s4Qyl1uPR3A5IYrGIbHdkei1F8dtzaPQC
	EVMnlf+WNJPgaiLwA+Pu2r3EfFIq5KmhYKROh
X-Gm-Gg: ASbGncvtH7XIzYniVOIDdyrDw4y0cMrI4+HZjckJNcEz/Ogp5Uk4qcG1P1917H7SG0h
	YAQNRqj/p+cAQOAS1FsgU+lBYsUOJsBDc59lrvbtYUQaUC/K65vgPW+Np/WRaw4e89hm2NusDfS
	K+URs/RcctUPoIcb9tJzs1JEL39xTxnbCfcl6r
X-Google-Smtp-Source: AGHT+IHfngivAfolpBCcXGBcAYbBekzzGYNr0zyvzMbAGXe+oiu7MNfqwRvlRvu1E0aoJ70PuTQ8YmFBD7fGj1cJG6E=
X-Received: by 2002:a05:6000:154e:b0:38f:4d20:4a17 with SMTP id
 ffacd0b85a97d-38f70799935mr9568176f8f.13.1740395979256; Mon, 24 Feb 2025
 03:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223072114.3715-1-boqun.feng@gmail.com>
In-Reply-To: <20250223072114.3715-1-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 24 Feb 2025 12:19:27 +0100
X-Gm-Features: AWEUYZlG3dBja0S9lUuTrhyjnlqfO-rrsKw667VUMX7yjVkDuivZCQ1hf-oSPHg
Message-ID: <CAH5fLgi2iXKg+Mwze41KHk1rLa1=f7=ofhbq_wz6mxmC4GNe6w@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 8:21=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> To provide examples on usage of `Guard::lock_ref()` along with the unit
> test, an "assert a lock is held by a guard" example is added.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> This depends on Alice's patch:
>
>         https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899=
920a@google.com/
>
> I'm also OK to fold this in if Alice thinks it's fine.

I think we can just keep two patches :)

Alice

