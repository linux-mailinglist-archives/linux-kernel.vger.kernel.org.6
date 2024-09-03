Return-Path: <linux-kernel+bounces-312634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B911996991C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6521F2483B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931F71A0BEC;
	Tue,  3 Sep 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKL6B4eH"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125A1A0BCB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355984; cv=none; b=FvQlPNVDdeGBEIUtCPzGMz+XbNkVUeBdg6ArobKhfMhqQktLQi+vO02E1FgQKF0FzHPOnZNi5mCsYFPoVgx3xyTHVvPJQVSbLfCwuUmamFzbnOKhNVbqhIn2RR61hLW8WmP4yQqxbDvbKxHMa7LdlBKaMg2rufr4QW/brQqJyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355984; c=relaxed/simple;
	bh=c0vpnkUFsXef0W5Py4ezUBWDFZhRIoqpCv7NYgYYQwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA1xcNZ0u73fkY+cmdYIP83n0oZg5VGOAnDX+Q3XnaVWtW4KS7IEUBWayVP+TS3yWo1TYqWFI4pinD9DPHe02qf7Ja2M4uKqGaIMENwhEvUGANOHK3OaNuwDoF7fJlC9l+CjKosBy+AEn4aKQRr9z3ACXMT7xgpA+BMtE4E3FX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKL6B4eH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso42107105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725355981; x=1725960781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0vpnkUFsXef0W5Py4ezUBWDFZhRIoqpCv7NYgYYQwk=;
        b=XKL6B4eHIeffVTWkuAyMfZXP5GDZds1nyv+PdLojqYSO4xi1/THPFdVcTvfqHPqrlY
         HjwN/cZ9THbAh0B5SvAykNEoogzm6/KETPMkh3vZgOewrFaCWfCR20v9m3JpjyEViWDj
         wO0syYhjiRu6w/Gd15ijewV9oTTpvX+7Go2BdOzaOafwe+nwCZE7bGpViQBrV39x8b+R
         0oqLqvwpKVrDJa/kgFJImNrDTidZvfc2CAcQa34XinF5h7AMLvHB63MRh7zaTYRm5DwV
         R6lij9D8ARXbnU4VlV3JLEA5Y0bmVl4h56UI5WTNHVl4osIfgMooRvqg1Qbp5s7yHTlf
         gaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355981; x=1725960781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0vpnkUFsXef0W5Py4ezUBWDFZhRIoqpCv7NYgYYQwk=;
        b=F/ym9cKytgaqYjZ7z7ZYPgL7qrRGLqLbZd2h8mVy3IfYhPKXqfyBzSlOBWCeGAuWiw
         464sF6dsVQYtIvk87yqM0ENUKPWB1EHDwkIfNKAaOxvL9rV7lzcx/9OYL93FdUJKjfq3
         +5svHBey0ooVyJPSls5FcpydaLDum5NSX/rHyovYexpX83khASBzNJ4+TxO2Ve6fPBf9
         7av0a0mLVsvzkP4yPntI7SX4WgcYJfgnTN86TPzow9NZnE3yi5AYgJQ/k7ESbYJexP9v
         7sIsGNPMq4u1e9oX3rCNmwiXjsxVMpOEfwj0PggfD6/kzurkIo+i0C5A4TXNcBLeZSsM
         /zMg==
X-Forwarded-Encrypted: i=1; AJvYcCXd9Sn4qPZZtwVPhSiIBv6KlS3bPURM2vIGgoAmxIIDApa44sXJya7PfrAUbb4P211/gX8ji+KcHeO7Q5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzK9JY+sjneNewyyshZC2/DIdcwqq+YFl5x5p/7isBDdFcw+U
	C1OGFY0XiXfz58kd3GidPzBajS+LjZ7f7L/ojZN8sIBmtk0K+ADhgaUJ3I14ThfrOYqPU08c1b9
	LX9rDre+As5nsHnWrC/2NX4jASKJ6rNgJgomw
X-Google-Smtp-Source: AGHT+IFQ0z3kIL0B8GtLMicNXuU28GUFcpTGLSuRcXdc7yD7zpkP/Wid9apTohJEbl7Gvgav4b700RAJ9aY8EZQNvYQ=
X-Received: by 2002:a05:6000:d8b:b0:374:c3a3:1f4f with SMTP id
 ffacd0b85a97d-374c945c72bmr3961888f8f.24.1725355980208; Tue, 03 Sep 2024
 02:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903091700.172734-1-benno.lossin@proton.me> <20240903091700.172734-2-benno.lossin@proton.me>
In-Reply-To: <20240903091700.172734-2-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Sep 2024 11:32:48 +0200
Message-ID: <CAH5fLgjicT5O77UviXUPxc0-O7nQO4J+M3Nfo+6Mm-DVGQBhMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: require `Sync` for `Backend::GuardState`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:17=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> `Guard<T, B>` implements `Sync` when `T` is `Sync`. Since this does not
> depend on `B`, creating a `Guard` that is `Sync`, but with `!Sync` state
> is possible. This is a soundness issue, thus add the bounds to the
> respective impls.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Right now, a `&Guard<T, B>` has exactly the same powers as &T, as the
only thing you can do on the guard with only a shared reference is
deref to a &T. So the bounds are correct as they are, unless new APIs
are added (which seems unlikely?). But the safety comment could
certainly be improved.

Alice

