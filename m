Return-Path: <linux-kernel+bounces-343162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA04989766
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1701F1F2155F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A0770ED;
	Sun, 29 Sep 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="a+OO7bKu"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4529CFB
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643026; cv=none; b=LtpWcc+xZ9GbEpxkb18XRQBB3vVs3OdBW/a0UGEZlJXKoYULUZOkAXCQDBQ/1786CrxUPJKTg0dcl6xxf1/V1X2Tbz5fn8/Plm6q6ayLoqGfJIh2pAdu/eg0Znm5mRzzWB2HtO0P8Pq7sP2MfpFL17YWxoIAD/w+lDuXSLsT3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643026; c=relaxed/simple;
	bh=mAda5Hpo9svnQtIQRKeoFjozfaSfNFcwhiL8p8Bw1yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFeC7lqu7bVplWiRpIB+YM3XjL6sXccZ0vISJrt9hrwwkR0WybRytCeVavxqscns3eDSPWFThsT5Kz5+qACl0HmTNxnV9/69EeCnhvNIOGOKECCBKSBgjotKQfkygNX7yhEGm9BZ8M9Vo9Lv69gOCxDfz5Jooi3OgCMetrxthRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=a+OO7bKu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e22cb0b19aso30917517b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727643023; x=1728247823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAda5Hpo9svnQtIQRKeoFjozfaSfNFcwhiL8p8Bw1yE=;
        b=a+OO7bKuvZ3aufW3KJ8EpZ8igXds5B/PHWcN8hVflUgePWpG91ZPPvSTJv1cpB1Pry
         A5OnjOe78M51ePMkI7L/sqOy+f3Y9eZTDcBObS0NQEV7ZjX/bTUISLtNi3Io6qByDxAk
         vll9bNfnNu+JbJg+ONY6/QX5fohGD7ZyO4pIQXA62nyPCMLG6pbd2kl+Iiit8Qpj5SIY
         auPjozYsANf0L2gLmD5XcPjp/9Gop4qWtdiD0lppkB7x1SGjN/hhGgtezo+o8nNtP2wX
         4xUMCl537OmtCTC2OupEDZyyOPgQcBXgdxvNoGuzxPIKWckcF6h00NVKrVGidbuyHk2T
         wbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727643023; x=1728247823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAda5Hpo9svnQtIQRKeoFjozfaSfNFcwhiL8p8Bw1yE=;
        b=TKl/3AlQUfjBWpKj8aJ6FelNScIfhffUc7Gc2W96+28LgQM+lsnD8lVM9Ojnt3yiO7
         kl94iGjpbBDWH+HFmcmt5SKo/ZzTqxI+xfI+eaEbYclQ+Ooo2J5A+vbHjad3ljI8Tu32
         H3sKLxdioJLwq6hAAZbCrSGTj+pnnY+9NfzcJj9i88kNdzX0BU0XmS1TVHaSmyFU20l/
         DH1IsOHZwGSfPQzmUiiHRhcZzMr7jA6Wz5bbp9imU6xixUHPrv11XmJ0EfMrvhxALbt1
         c2VO1/VUnICV/VJpn1fd8TO/TWAxq31qIdSM2ZwBM5HZMlBr91nzOtgKdYMULgKi3qgb
         tgvA==
X-Forwarded-Encrypted: i=1; AJvYcCVoj1bZhbSMJfXDJ6sPAwonT9uLaTdOKaoeWFG3/nN9r30ueI2JlBB8D9mjSo8cn/lQs4Dd2gjgQ3Tbq+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HaqrMJ0jmJH/7/5CmAFa9wdaddduYVt3XPDpmRGI/+t5GLVS
	8FdPpljI5p+fq0X8/J97Y7tW3F5xE2v1bAVVpmYr7Y4wwKxKGL8Knb3C4KI8IwhORfwpkNfLrwk
	HrnGXB007i42fqBimw+FjUsRvYkked9wR8cIgoA==
X-Google-Smtp-Source: AGHT+IEaFN8drxJ/Lmsxoyp2reuZr4TaggGmqzYkniIgWdXGamTtr8C/cXk+EHngDU7re7cBpw2mSIfVlnQG9nusT9c=
X-Received: by 2002:a05:690c:12:b0:6d3:f283:8550 with SMTP id
 00721157ae682-6e247600468mr69615207b3.28.1727643023592; Sun, 29 Sep 2024
 13:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916213025.477225-1-lyude@redhat.com> <20240916213025.477225-4-lyude@redhat.com>
In-Reply-To: <20240916213025.477225-4-lyude@redhat.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 16:50:12 -0400
Message-ID: <CALNs47s-7z5QsEzThm6gU-8bmX6bpPeewRuKfc--o8LAbNGZmQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Benno Lossin <benno.lossin@proton.me>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:31=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> A variant of SpinLock that is expected to be used in noirq contexts, and
> thus requires that the user provide an kernel::irq::IrqDisabled to prove
> they are in such a context upon lock acquisition. This is the rust
> equivalent of spin_lock_irqsave()/spin_lock_irqrestore().
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

> +/// Creates a [`SpinLockIrq`] initialiser with the given name and a newl=
y-created lock class.
> +///
> +/// It uses the name if one is given, otherwise it generates one based o=
n the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_spinlock_irq {

It would be good to mention something like "See [`SpinLockIrq`] for
example usage." since there isn't an example here. Not a blocker of
course.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

