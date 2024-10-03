Return-Path: <linux-kernel+bounces-349521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E36098F772
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE3D1C22044
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7E1A7AE5;
	Thu,  3 Oct 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4kT8f22"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AD4C8F;
	Thu,  3 Oct 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985648; cv=none; b=lzaDMjukwyBHHQHzHCQslOX7UKBzkKs1pwMEk/AdqbN0tY0mEMKITpPPm8STPkYuUFHgNuE6RI2Z4tWi9zGiaZVx8hN+KYwVfKa/H9SmFJywAtONcB4c3xpQlj7WdipIJFBxSf6M4CkhPRkvnsL979WuWt6pgUeG7VqmOece1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985648; c=relaxed/simple;
	bh=UoqoaM05vPymb1NNs21LPer58Axo7gfGhV1eH+OdShk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbJ6VOVSbvWNnUMSK3IJK1YI8JeTjHXW51WxbvhcmrwMQYBm5nGYMm09GD1Qi5yRpIcAGVaI5j3EFsR55w1wUkCfwhTyKLrCfsIQfWOa+eYjvPWf0Z0uqnbu00BrpE58ilHbSiWcGq+mImV46uMfIphWgZy/j8IzblKEmOGKaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4kT8f22; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9b2d75d92so191455a12.0;
        Thu, 03 Oct 2024 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727985646; x=1728590446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoqoaM05vPymb1NNs21LPer58Axo7gfGhV1eH+OdShk=;
        b=g4kT8f22+Z94hXO/OfY3pUPlfF4pi4xpry6etA5IXarKgx3rvllRZUvrHyn7NA0QCp
         BqIz+9C4gBxv6YHlFDZM3nl2imrSNwIjC4AlSforYQBJeJgSoa2Cfq+q0J3dX7/zTOGp
         C5obR4btCX3aWXM2ehE2iE3Psu3nwlUPuziwLkQizMJ8pU6YkqCzQJUhoi+CdHX54E9b
         XP3eyDFsrrqcRW4MyGXVMHSE4dzRhA3HpPI4CShdhVkVyEbCAzogmItrqy/8XpSmFaXj
         B6VwuNc28uAUfLVRK/fbAMXfIK9MwqoaCPhS6MOBTCZ1U//7xHbKxmo+FDoT5YaFJFyV
         V4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727985646; x=1728590446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoqoaM05vPymb1NNs21LPer58Axo7gfGhV1eH+OdShk=;
        b=t7UtVeFFj0k84YH8zh/U/DZfM1MqcdLAxxbXDcA344ba9878NY7nTfGfYFo6/n5RyM
         Hhph8+SRaZbxRgIkxmlcwNGB4uCfybFeZfYi2wmwgPsblZS70i+jcN3sjLx+NYCk7LLl
         ImZAIPY+kTGAynTuI/bVa0wp/95WXOLrAbNk9amrUWdnJnvzD3z+e4vY95huaIWKRJ3S
         sAOvtZhxJP4aAQSgsYNqA6xOqCk3YDj6/jJz5v9Cxn1f3UlkptCJqAKhM36K/DDnmI1L
         KXJSOwHxTRqZfth0+53hLfLwGcE3RT+CGX4oq80m0txlTuvrY1xgaiEqai9lBiQXihgV
         A3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAMTk52I8bHVTlZYLwA0Im2ipX9kp6JDT4DiLxFVyl3t2UjEVi9bnWcnyUvgNwVj7emVvawt4wf8YLMqc=@vger.kernel.org, AJvYcCUDm2I10Z76/hzkABpB5A+PxmuTFl1qHNLJplF3Y1WQZV4oJWG+lrdmC+D3yjzX5/UBlXvm3z7v8IgVgcQtnsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tebtoswtUkrk4MB4+B+1tHjSByyqDYMT5T4NKLhuVemEyYOr
	8q8vWN7+c9TjO4M0Stes+vxU00Lld54dvN9GPbcztGGoWn73AaegQr73JHDPz2X3cC1+m5gL/Zh
	yxcp6VrOERQ/auSW1g1v/69QGqWM=
X-Google-Smtp-Source: AGHT+IEtGHvRvHryQjF+XZtgO8rnb0QvpIG7ocNvoG1PV4Ddkccy+WuG+Izs2kC+TqBFpa725+tx18EmNaJMcPLXZwM=
X-Received: by 2002:a05:6a20:12c1:b0:1cf:4edd:e6f7 with SMTP id
 adf61e73a8af0-1d6df7307c8mr286029637.0.1727985646416; Thu, 03 Oct 2024
 13:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-17-ojeda@kernel.org>
 <CAH5fLgg20kDCJfD_6+fTSogOnpqK0x3a6eKaTahgSvdgfFzSEw@mail.gmail.com> <CANiq72ktnMSfMfGEhN1kO0F+C5O_KsUY1y_eb7ZL+qzzSkg9bw@mail.gmail.com>
In-Reply-To: <CANiq72ktnMSfMfGEhN1kO0F+C5O_KsUY1y_eb7ZL+qzzSkg9bw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 22:00:32 +0200
Message-ID: <CANiq72knpbKByDZt5F-fNEqrOHUJvqcHdWwLVRO=v7b8eSAgrg@mail.gmail.com>
Subject: Re: [PATCH 16/19] Documentation: rust: add coding guidelines on lints
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:45=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> example in that sense -- I will think of a better one (it was nice to
> use the same as in the other examples I wrote for `expect` later on,
> which is why I used it).

I added a footnote in the version I am applying to be able to keep
using the same example (lint) everywhere.

Cheers,
Miguel

