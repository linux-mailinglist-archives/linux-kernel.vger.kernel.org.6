Return-Path: <linux-kernel+bounces-312806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293D969BD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5091F23C33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1331A42C1;
	Tue,  3 Sep 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fwd+fPxT"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056119C567
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363102; cv=none; b=mNUUU4tPC2J31IHfFL84fgihWOPqxpFQXZ1kUVuMW2jfwERiu/4kZ0Fryp8x4WqlUpmfic3v8aTzkzjrdtVgVBfMfNmQZ7PdDO0Y3plibNtGtOhtXU+uPMxOD+2VGqkvWHySAiVoenk66bZ5TKbn3NA33N+jo2y0ReguaWdwqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363102; c=relaxed/simple;
	bh=qsjcn1tKB6e1zBjRyJwbtyxU18n6uv/HHYFBuu9TaDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDfutmbi6FCwVpDomAnPXM1jLC838dG+T0bMI6lFiticVODeG65v9pKJ7MKzWO9KjB5n/HNjHOBLUrTbBTflJTzEoSMoeOfRW/oy3+PzbKcxPKsQ7ek62rQAetnCPk/sBFfL8InohmDWOKMgZnYpdHJH5KCOOi9eJqEjm4xrp1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fwd+fPxT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c0a8c7a9so1922766f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725363099; x=1725967899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsjcn1tKB6e1zBjRyJwbtyxU18n6uv/HHYFBuu9TaDc=;
        b=Fwd+fPxTDOgjapAXPppRoZVCJp2LaADsl+Rwz7xWAWW21LKGg1Z6G8rjKnmmayJff5
         ZSQDt9pFTw7iEGp8tWmF8gK/H10h4kthfmmhtIBD8u0mSr3MuqAxRMZKqzqV2g+EKjHC
         WB6agbCemd3Dr7X3Togx85FfXcItSkrmt+VerKsmoytgnJX6Xm+jeZDTYu+TgTqzNfsD
         BbkafCmk22eFYfnZTGByuI67sTzatjVugYBEtdK2WisK1mhmKXC7KMX+xeMIe+7xFXhz
         QM6l461FyLMEL8HaA2aItNEEtPL0ybWOyvEtj7rwifgG6m4dQ6ZbdbizLW/4xthz6SaA
         sKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363099; x=1725967899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsjcn1tKB6e1zBjRyJwbtyxU18n6uv/HHYFBuu9TaDc=;
        b=EaCKzInKCAskeFbExUvyODWNzdFAaCzZt60/3uPYy0/YbtvtlHkZuwfnyLU8Y4E4m8
         sBbnQw6WO+pndy+RnN4tYeA0GgoTdIp1gWRqKmcP9SI/6yJDInXmj6yEHUeSASA1Pdmb
         ysnZQNVc6QCCMqN83rYBUoTKLomH30bh+u5F+BV43+XXiYQt8vsylp16HiDGK3QVnJUE
         Rbm033HeQ4ff46PTXQN5Zuk4Ss4QeEwq1jLMdqZ1KErfpYjMb3GdQTUcXeFO9EeY2xff
         uBooclzavmBXRJnLmWqWC8oYwO4MiXOxVhxe0pIDeuXiYkWFLvi9G6+9Yv5QNU9lidQM
         dzqA==
X-Forwarded-Encrypted: i=1; AJvYcCXa5BDKuoEh1cw13ew0ScpfENLznzCrbRRUVKD/fvoBuELX/2IoSKzlLxo+sP21iY8ZHWXDxXb7TqEDWWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+1XStfJTxc/NDEx+fDQxnaPONnB53XecpqvQnVWeYS/GgL5o
	S1uxqPZni8PHzJ4kqGVLZ1cyX1Fh2d7JGt2U18dlX+toOZcobdClxPrUSDrmBOW/56ZpKVhScDz
	BSLBw74QtSvoQdhcYKbqY1984xh4k8RwRhuCM
X-Google-Smtp-Source: AGHT+IEaThavlAXYAaELQyLlGLHSJ3E+td/aLmWG7YfQepbn/Gc1yG+xLqcfKkRIWc6/8gSi80xDwbDOFOafNdN5Mbg=
X-Received: by 2002:a5d:5e11:0:b0:376:75fc:3a50 with SMTP id
 ffacd0b85a97d-37675fc3ce3mr869340f8f.55.1725363098364; Tue, 03 Sep 2024
 04:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903091700.172734-1-benno.lossin@proton.me>
 <CAH5fLgihM6OeuVrAhSXAqb9RDKBa8p7+EOsFuuqkGu-OzoapZw@mail.gmail.com> <c86fdb23-497c-4f5e-9dc3-1683fb494dc5@proton.me>
In-Reply-To: <c86fdb23-497c-4f5e-9dc3-1683fb494dc5@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Sep 2024 13:31:25 +0200
Message-ID: <CAH5fLgh7Jpi3XfZMZ15MxCiRX-+QbrJZst+SpjeSx2aK0dwm0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: require `Send` and `Sync` for `Backend::State`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:58=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 03.09.24 11:30, Alice Ryhl wrote:
> > On Tue, Sep 3, 2024 at 11:17=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> `Lock<T, B>` implements `Send` and `Sync` when `T` is `Send` or `Sync`
> >> respectively. Since this does not depend on `B`, creating a `Lock` tha=
t
> >> is `Send` and `Sync`, but with a `!Sync` or `!Send` state is possible.
> >> This is a soundness issue, thus add the bounds to the respective impls=
.
> >>
> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> >
> > Currently, B::State is set directly to `bindings::spinlock_t` or
> > `bindings::mutex` and these types are pretty unlikely to be Send/Sync
> > on all kernel configurations. If you're going to make this change, you
> > will need to change these types.
>
> Oh yeah you are correct. I did try to compile it, but maybe I missed
> some config options, since it didn't complain?

My guess is that it only happens with lockdep enabled.

Alice

