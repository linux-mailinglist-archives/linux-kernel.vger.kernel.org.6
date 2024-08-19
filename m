Return-Path: <linux-kernel+bounces-291957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A316B95695A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34221C211F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC42166F0C;
	Mon, 19 Aug 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNJqjHOj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B314A4C1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067234; cv=none; b=D5drgCAIo8nltWHDolAZyo81ERyqW0xtv+nkuqk4PhyjVJgprYFybh8IY2Zbkmv7YyNhfi5w51+y+fCM85SJd0u/CDsoiD8qofG3TvjylJvzEedePIupQ+gDFPA7t8ST6aigDFd1PoCK1fgh1OVbjF1MJ+GGqoCZHjHvPWSCiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067234; c=relaxed/simple;
	bh=YMZiQ7nTMyzqbUWNC70HrYRlaqT6ID15mYXgXsSQOZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RueJ1i7ukoJSaWS7sbKp7J/7DweGxhUAzJQnxkUDi7eHV86WRF6GKJxRBbJUEWiA0oUb7drGTG39cN8cB8deu7c6uvue1Iz76Z/i80YEjKmGRpLpkxLQ/9XMopkNmkeYFJgc7qSlvV3UaT/5MnWrf6OA6pyTQidjA0C2BltoiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNJqjHOj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso35376095e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724067232; x=1724672032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMZiQ7nTMyzqbUWNC70HrYRlaqT6ID15mYXgXsSQOZ0=;
        b=JNJqjHOjHy9U0tbLgcWLfl1zGJtJRdSfCE6geaxaxNB1R9wTpJDyJ8gsnzXOHEA86M
         KOGBvIVVO+AkpNYgxeQirO0I6ZakRxWjfKppXMKxs0g+/mk1Zsut5r4JQNMzvL862rYv
         CxdBJHkDB1zvGbmg9YSAelm5o1pALMvwOZlJhtfm0L1CHzYDX6vdX9PZy/aIDZH1vVFv
         PlnOhfsVArAvdk3+7ajMS+qannnCfM9E2OX0mtRay/vdKMalRB1JakvLBE766L7/MKKk
         TOYRcuOYWC015d7U1gRmSlJFJoNP9jYECRuRjYy3bc3A6UAifrTU4rAAJUmFG26STWE1
         DTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067232; x=1724672032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMZiQ7nTMyzqbUWNC70HrYRlaqT6ID15mYXgXsSQOZ0=;
        b=DE0IAJ6ztNDZyYYFveZHhPwuqU24bzM/LKpOez38mjOZ/J26HLSgDaojttIuD8VZZr
         2dugVUFQZHfdSHpZCSCuxsr36ndXSnYzo48jYr1sS1LZo09VwqXthtqngXGPTq3qTLZD
         0b4Poai9DbOLzT2j/gHfFuZJjXileDyuxCe94DqoaIk40JB8PRcJDZsXv1VCKYEx6gn0
         VvSGbq7XB0XKTsadYPI1xXx/rmCP11igflv3r8ITmq6B2+atOKE+XFIqmR0nLoFRlfip
         1swf1MvwnKEMauqW01BwW7awl5vG15TVw7qN62uWO/wSXCJjYCamRYUFKxyW79kh9LIh
         zm7A==
X-Forwarded-Encrypted: i=1; AJvYcCWng/+vkZhZAa2P8jlc5C5U2v59ZMbZp/Otmfpoprj6SoaMXu5iLONou7/KpfRh139w7fzmeux9xGJPcqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4nF0nbH62iBXUfXZve88jcF2oFeXiIs86XlHjpolSxPicc2+
	3WMiSWjtVnKTnj5AsrlwjO4UeH8BQtBtfWbEIYVlJ+7kqXMiBriuZ0LxVX9yHxydXULYJZ/NVSx
	EdoNYJ4UQsgM14JmMKY7+h7aLLbetFkcBw/LJ
X-Google-Smtp-Source: AGHT+IF1Qt48Zst3Qaf5ggizXmigrv+nYn2roTN54In0bMoPLMwmjRuAxV+t0LPMLUaYC+7pXJSxUTRhraixgxUvkzk=
X-Received: by 2002:a05:600c:1f84:b0:426:58cb:8ca3 with SMTP id
 5b1f17b1804b1-42aa8249aa3mr52914405e9.21.1724067231397; Mon, 19 Aug 2024
 04:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819112415.99810-1-benno.lossin@proton.me>
In-Reply-To: <20240819112415.99810-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 19 Aug 2024 13:33:39 +0200
Message-ID: <CAH5fLgg04kKJVzM0vnp8j-rYfYdCb-RZ47U_MEX9unXsDDYXqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: kernel: add `drop_contents` to `BoxExt`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 1:24=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e=
134390ce@google.com/ [1]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

