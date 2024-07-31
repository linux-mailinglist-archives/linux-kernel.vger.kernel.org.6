Return-Path: <linux-kernel+bounces-268798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64894295D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA561F21009
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5C1A8BF9;
	Wed, 31 Jul 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHe60/I+"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D318B480
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415305; cv=none; b=I9b4xWwKAH3Bs08b5HMYaPKLxOJ52LE2GxM5SoizHU1gxjQ9Dd99J1rEKg/qADgcmC7dUF/UHL5KcamQpVMIwsVvFjAxkMEinb0K8SZfQA/MTRGXS5XvRU+lDWKGILZgQfSeZo1iEFsC8Pq3kukjQH4GoxekgG88oTc1fJpPmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415305; c=relaxed/simple;
	bh=B2Sw/vizsMUyqk/vLPQLkHjIXQQw//mEZa4w4bBnzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDW79m5MI9hcKjVO1kcu2LuEkWuXNH0WF53Qzm+bYs5QrjIyKRXRHdx3o/D2gJEaHmhZ/xY81o/A9PY2UV7IfCADa8OJZePYdxIDKzCyHv04PLy86j08+Y1ShP4Ciwaq+ONjYPRcxLCf+/OQLoKLeadlWnlIY4UejW8fhdBYYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHe60/I+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-368440b073bso445989f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722415303; x=1723020103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Sw/vizsMUyqk/vLPQLkHjIXQQw//mEZa4w4bBnzLE=;
        b=cHe60/I+vSo+7t/v+obI/ikcFL3opg0XUhXQWuEzGiEFIBfenRusd7TvCU1j2U0sKp
         Fn7jOXmSxtyaN5Z6WzXnVxPGODXO0B0/TLU4gypVi6Q9yN87vfND0+LYuL7jfVBJVzxt
         62kocJlLHJLZfwOkwXzZiLj1L8KLXzdkQCbJITWUH+HeqeeMIzW5F3mKVoZAtpIDmFOc
         yRoDFDahpzbE8ECxEDNZc4LO0x8iYrfLm2noAkXNckbaufrPhN+CeDvSlQbmp+f5gUn/
         RIRMj3rNIpE86XGotJBnYAuYR6C1CJcoNgpD7n0Ckpx5cthFASWs4gJ9oaxU3RRszjlg
         s/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722415303; x=1723020103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Sw/vizsMUyqk/vLPQLkHjIXQQw//mEZa4w4bBnzLE=;
        b=PCv3k7qOjMFB4zUMhdixs1J0rosXJfgeVd8NszbtYDudUX7DQmGPMRKJx4998+marp
         XMjUmRMR25WAmJq6Phd686HlWPLHbxH6xY/58MpbOVBkB2rSe/u55gZrmZbnQ1Vsn1QG
         5/qZQKy8kCep/WemAIAOvWb1fMUr60yV5WaDOtMBYglcTm7ErS3qMvCtx6OcjBoxUvWw
         001BOM0LbUmCBYg7Gh8PfXGbBYUjuRaOv6i/1EqBUVfOxNG/5jrHZgwycUz8yF8nRVdO
         dk+Bg66jaz0o8Dm+4t/dXWG5Vvn4rdonmZfKu8U9Byy+BIkeCyXkcSUJ9s1iKHdIVDkt
         7BHA==
X-Forwarded-Encrypted: i=1; AJvYcCWAZEGYF06wvcrJ7bLWSi0X2D4dJBxdIV/2ofXTDcbMeeUzwOrXLcKLCg6LzgxrsSvO9L8Yq0sEBZS7oB7khLxYJvnNdL07a8SELfWH
X-Gm-Message-State: AOJu0YwJmd7XuML/hYpJFd2MCVuy2h5fX8w5HGsZw6vCi3a0OjAfY5GV
	kOhhxC7W3Tu5qh370RETw+nMBS4XmBA8VFWTinUjJIQIJf5acsq/AIZ+als4g2aq0dS2l28cgv1
	tLPDBvWdpMT3sivdqXv1eizWiODRcHV55olXG
X-Google-Smtp-Source: AGHT+IH4/VkrKwNdMel37onE/R34nyaTDLUF63X2rjy7FQGTHwsI7LeMqmpN0KLfwKDEj5QdRZBUtCMOu4zauPC3ess=
X-Received: by 2002:adf:e541:0:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36b8c8ed754mr2828583f8f.30.1722415302303; Wed, 31 Jul 2024
 01:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730182251.1466684-1-benno.lossin@proton.me>
In-Reply-To: <20240730182251.1466684-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 31 Jul 2024 10:41:29 +0200
Message-ID: <CAH5fLghV5mRFZ4ORRouy6oKMuUBu4LnvsvmyH3XoTLcV4PvdAg@mail.gmail.com>
Subject: Re: [PATCH] rust: types: improve `ForeignOwnable` documentation
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:23=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> There are no guarantees for the pointer returned by `into_foreign`.
> This is simply because there is no safety documentation stating any
> guarantees. Therefore dereferencing and all other operations for that
> pointer are not allowed in a general context (i.e. when the concrete
> type implementing the trait is not known).
> This might be confusing, therefore add normal documentation to state
> that there are no guarantees given for the pointer.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

