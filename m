Return-Path: <linux-kernel+bounces-564071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD7A64D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7915818951D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4A237160;
	Mon, 17 Mar 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THk11wR7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF41EED6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212076; cv=none; b=rXpWvmVb+6ze1O3mT8bf7SCMdVQa5jfhMoBya/kEEnmWnJeNjXNRQyX5bgSIolrPyNEtI/hsXofAk9Ipgv/v5e+CbMXqcN7etdGcCC9P3q9YFPVJPjc471Ow1Drf1dbvD6/OhJnTr/b+KAXHcbrms2NA8IQ3VEwHfI+4mHRVRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212076; c=relaxed/simple;
	bh=xsA9SQb+/OFmiyqy8KvlFYfWN5nGuahSBL5qwTlZBL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DX9s/EqZYON23sCB7t5QLIARxyZ9C8DRyj7x4VXEmGpkJzUQzZP++aZslVXjVzzw39bWySsYwloo+81se/OT+LM9EE/5fZUkw4GE8JWDcliUDSsbhuCSQd0/y32vNWW3pPyemXeRSlGa0E1gMMevae51tZ3vrjmvDden0QR8L30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THk11wR7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so15366135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742212073; x=1742816873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsA9SQb+/OFmiyqy8KvlFYfWN5nGuahSBL5qwTlZBL0=;
        b=THk11wR7xRfp07yhtztNxfV6Bw7RIzzhrjmZHV1j5bnD6yXFA925FRS7h9/FrKrX67
         zmEAAInEWLHL7gFQwNCURNvVvxrsx9mgR8k0bXIiQL9TCIF6vaS5Gn0LCY8ShfocpV+u
         VC3Gkc9j12ZuOpBL2rEUQhBTvE32a6Wz7uCImUlO2HB1+3Nmd2OsxL2XTbnvMj1v7+N0
         F2e0Yaefji1CZcBiKbrPe0ubP9dJksR0vMoRfoKbfv3xShLas23ngxsowCDvahGXXtah
         fwLTl9DpdJFVsw3PEkkMOH+8GlnsmExRbuI9bNdjyOtPoHqlXHhZn3fRsMqDDMWH10rG
         ZKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742212073; x=1742816873;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xsA9SQb+/OFmiyqy8KvlFYfWN5nGuahSBL5qwTlZBL0=;
        b=SOPidl3k4xPZiB1rT4nH+RUzyLKirOib2Jt8pTsnTTdhP55Btq0L7IbBQEeMhnUbJk
         j3nxfInK/qcqImQL9cGyDYwAcU5CFkbC/x3VMnu38qOQnytR9XEpcCHAKNCjrJ9LiKwj
         tvD5uTK9ZFgX8mn2Vo2Plm6R3K+VrERKdubcLaNOJyu9JY8PhuKqNZM+p6gDwzPRxz+n
         7f8HT+9i2BxuPr8mQtqgl2WjA2RSSxwued+QXHWJpUttFubayirlo2DJgflLQ3LR2oZz
         BIS7OqI7gXcf5/JQxl/1UewqdBw7hn+8Fd063dS5jwKrdNNMrrFJlSnhhXFra0wnO7LW
         Ay1A==
X-Forwarded-Encrypted: i=1; AJvYcCUWZatGXzwJJ/+W/gdgT9jfZlbOcyWCbwS8yUVAAGMMWYfmmDEO8X9aWF5dMrfVkr9XoWoVlVbnsU8epFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vWJMWe228RUEgz7Vq/5KE5uumwOsN7nYbnw0Hot1FMGejTA/
	hNf9cstos8TQKh2LR8KlMxEqs8faS3prAG2hx+UuuUHEtt+ExJ6/rRPhmqlf289wH8xjEx/c5kr
	NcB+gmeT6R1CXyw==
X-Google-Smtp-Source: AGHT+IHvrRiZPwEAiCbABxkr6B9z355kEoDig4uUNC4rURZqb4W0qxAb2JrapZHIksVqIadtK5iI1woPxAlRK6Q=
X-Received: from wmbgx14.prod.google.com ([2002:a05:600c:858e:b0:43c:eaf6:525e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19cd:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43d1ecd932fmr127507565e9.31.1742212072870;
 Mon, 17 Mar 2025 04:47:52 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:47:50 +0000
In-Reply-To: <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
Message-ID: <Z9gL5hQWvCNy5XNH@google.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > Add `Vec::dec_len` that reduces the length of the receiver. This meth=
od
> > > is intended to be used from methods that remove elements from `Vec` s=
uch
> > > as `truncate`, `pop`, `remove`, and others. This method is intentiona=
lly
> > > not `pub`.
> >
> > I think it should be `pub`. Otherwise we're loosing functionality
> > compared to now. If one decides to give the raw pointer to some C API
> > that takes ownership of the pointer, then I want them to be able to cal=
l
> > `dec_len` manually.
>=20
> This is premature. It is trivial to make this function pub when the need =
arises.

Normally I'd agree with Benno, but in this case I think having it
private is preferable. The function is safe, so it's too easy for
end-users to confuse it with truncate.

Alice

