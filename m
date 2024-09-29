Return-Path: <linux-kernel+bounces-342784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4259892FD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375572858A0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F425762;
	Sun, 29 Sep 2024 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="jeqXBgO4"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F51E49F
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727583670; cv=none; b=jZ6NucawI9InIofIORs4lFWZpq2xuK+gHKuuvCpsdRiuTjWqGlD1FSxgQlVsM2+Uoi4QZ5KgG/vWq3isyjnV4cmoDMSrDE4F/4FfjH/9G8DghCUSmUsR3WwJSHcHWUxyY1Vqw7O3OWigxOBLyfp4tV7R/OK36oAEl8EH6ukTk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727583670; c=relaxed/simple;
	bh=pHVoxB91LNUpLKS+bFIZR71Nc4XMjyS1YH9Of4Peg3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tunVKJY81p1xoSd3HQAKQyEpSxzJnUDnCrs4ogirhalFj3GtKBhj+/IxavzMUCCg+kWIkQB5iofVaiBdGGQ8fCajnL2NF8wKKNYTWkhfvsYMQvNTwr4+8QCPjPC33mCFEBzdJtVp7R5OibfURZGzpvaPlQCxrjD7tVRIxyibrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=jeqXBgO4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6c3f1939d12so27743087b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727583668; x=1728188468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHVoxB91LNUpLKS+bFIZR71Nc4XMjyS1YH9Of4Peg3o=;
        b=jeqXBgO49Acd1azmP/9084qlmm94m8LoYp2aXtRe5zAHND89xro8zU8+1x84nsYEjs
         yPspw177xw7U9bDhARmLFFf6jn06447cYtifSc7ClC0sEBm7oIQ2V0Lo5qKgTYCMO9qO
         qIli2yMxNBQUgsfu8fWjFSrCeuTPWf75CmGGMtVRv6eJFzpN37NGD6ITAhRJLYZHNodi
         I07CahPhahUC5ii9K98Anlei2mZCEuyQ63yVbWHfvzezMiQwT4/Lj4m4D7vVXysJHKdA
         k9sJs3JNfy43FJF5hHbEW/3uoTxVwMg7ml3JKSgGrqN4Wjx627+NWOEZKxdyWUSurwg5
         8WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727583668; x=1728188468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHVoxB91LNUpLKS+bFIZR71Nc4XMjyS1YH9Of4Peg3o=;
        b=jw9s0CK1UleU5h/f//5CZyg32BkYrLjMO0oCb5R+GYRk3btK7wXGwE1qzvg6ggB7pX
         vNJXQ1OTFXeTa9P20EcNDBMBy5wQ5/paiu1yxHWvd9+AN8pjbAJkjxNv6kp/cEeikD8z
         7T3hxx6ofy/MrKkFpDCyr1/ZctTXFOeexQAqZ1gVTRNyUtmwFJ+tr69rXzSMinQvomNZ
         FqukXYggKyDOc8Re8bi2Z/9aj97mVtcX8j6v/BOEbZNFgABiaYiubDZsqj3znmSZKis8
         BxR6ywOPn9UOeSqyT8exT7qqn1QDocaZzVni8hXUeGSwxSccPmyxKQeHndPQoAbmvoKP
         FMlA==
X-Forwarded-Encrypted: i=1; AJvYcCUCX11Owdh/miW2c0GT7LYcniSmEHkB/uSkv+cissfCcFke0nRjJWcXao4BOhSz5z7LG4VDvSwD6XnVsj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDFUICaKWEqYR5ves8QPVRkAS7Aq3WUm+nRmGX/xIazGrBQ9o
	hLEXT2eDhj8Oxrj4QE3pxVtm3rIj1tVPzjqxFlkt/fJr/mHXw84NvAR/RkcQM6vgDolZInWw5Na
	ukvrC6z1SRZiz8big62JI+QGp/1fTMPNqi9Ughg==
X-Google-Smtp-Source: AGHT+IFcGTqHY7ozyyABT+lA6IrUxrrq8O1OudXtxS0Ccg/+2lxmPPRsG2ROBTXVmUmB9im75BbjPDh1s/kAip3anI0=
X-Received: by 2002:a05:690c:dc6:b0:6b7:a7b3:8d94 with SMTP id
 00721157ae682-6e2474f4703mr63064527b3.6.1727583667787; Sat, 28 Sep 2024
 21:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-4-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-4-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:20:57 -0400
Message-ID: <CALNs47sFE+mgkVL6_mXwuW_LRCT+UMO85ZDWdSYRkgqVk-QfPw@mail.gmail.com>
Subject: Re: [PATCH 03/19] rust: types: avoid repetition in `{As,From}Bytes` impls
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In order to provide `// SAFETY` comments for every `unsafe impl`, we woul=
d
> need to repeat them, which is not very useful and would be harder to read=
.
>
> We could perhaps allow the lint (ideally within a small module), but we
> can take the chance to avoid the repetition of the `impl`s themselves
> too by using a small local macro, like in other places where we have
> had to do this sort of thing.
>
> Thus add the straightforward `impl_{from,as}bytes!` macros and use them
> to implement `FromBytes`.
>
> This, in turn, will allow us in the next patch to place a `// SAFETY`
> comment that defers to the actual invocation of the macro.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

