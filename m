Return-Path: <linux-kernel+bounces-316590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC8496D198
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01741F29D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE221991CE;
	Thu,  5 Sep 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzrxKmaY"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F5194C91
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523857; cv=none; b=bz+lyb6olRJt3qnA5KL7vhY0kH++/IlalCsxrvJDn6M1Xmisj0JWOEkxDRRmhbboNB9KT8WFM2puuexrlnA2IhQFFjmqH0X0gOBfZAEevxPhouqg4cF7rZ9gh1p7VK8vbzMDJFmbg97J89QSsrd5snnvaR8BD2vZcLT0k3qdV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523857; c=relaxed/simple;
	bh=qvUtuea05V6qpDBt2oe0KDZfHbwdwIfCyNjizCTTsKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPoxVgcPCbfNjkVYsPSlQ0mkZmPWLDmT2UxkXRp2nZlCDX4/tK95mB8K0pjM3ZKU4u1bYTOZ+5PGSAt7uSk1S26f2k5tmg3Y65Nn+D+pbzsl4ANrpPUg5imXhIQAuzNABILfpaYUIwv2YqwHjJCIORFxAWuWKailx4RQkeQSdEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzrxKmaY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374d29ad870so252479f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523854; x=1726128654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvUtuea05V6qpDBt2oe0KDZfHbwdwIfCyNjizCTTsKY=;
        b=FzrxKmaYMiAHn+Rw53wgwnU7lcKWLB4oX9uvZkxITWgXlj+AOgMdjo0FeLDC2X2ikq
         hDRHOJP6h1wD4U9xJZjr29hY7ueebULxmCMuXSIF9pnDzn+jJAgjOB4qONzDYQSzpkPK
         F0vjnqIc3kdjn+7bh5ef/stEvuMtecQCrblYZr9l9JS5rY6fjR3H0WeoWV8kfFvSZAHB
         aigIuYfYedAEByGlN8xgLsfxKCEcUnXPdppNMXOFLYSf402hu9rK2i0esn9wAAo9s0US
         W0WQWYIEegiUKRyGkBPtwH9tuo4XzLX2GuKjrQvLym6uH0QANvHHUYtHj6yDeV7HL7ZB
         fWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523854; x=1726128654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvUtuea05V6qpDBt2oe0KDZfHbwdwIfCyNjizCTTsKY=;
        b=NGs8qgMC2i6q8fPiVZWPYcTXZtXVRPHUuUahCKmDH6MMV2PaKD05SxL4YVv7e++9ib
         ABdt7zjJjqzdHVM7EDKJgPL6VzjXrISEL27hhaJ1dsnkDPD3aVb3nEVcNKcBzFjPoOP5
         w/iPyB4kwtMDsmPyrAS46zIC54hlBXAtSGqC9Pj2i70jmPZAzCGQNTxXV4Q8rXg0s+wH
         kKF/hT9CM46UOb1e4LIb+60G8tj4LxNtElN8k34qYUElI/3iTV+lRU05R6k350+5gTCc
         9I8BCB/C/ZezvCzU8DsxAo2XlPSYZcv3D6wPKwv93s7zhToX40pOzapf4fyclWjfIUC8
         po1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0kdEdfXHkxK//6SDTIZw2ac7PNKzNYMRXFd2dQOTxN5SkrjlWtO3tKsJ/D0+T75gqqxa2TzSuw6TVJuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm64o2k3bUw4BPGW2Gm669OtjYu+pfngLvZQvPh396NRBDoPpe
	npcXyWmm+i2QqpNmlOJBfzwkk1eTTy8irrQmFSTzBaHOcFTcGK25hnKdI6k5PmRoPvgMIcsGvb+
	/wmyZcAjnstxLu1cn5RB1hJ6e/cdyRRBLmFXs
X-Google-Smtp-Source: AGHT+IGfQnv/7eMNeNLrFaPjeyN14SUVsxlIgWd7D4uZKrPENQ9PlDRsjJlnUzvNYsFrUT1h9gvgun7V/HGRHxTT+m8=
X-Received: by 2002:a05:6000:178d:b0:374:af19:7992 with SMTP id
 ffacd0b85a97d-374bef397c9mr14232382f8f.7.1725523853771; Thu, 05 Sep 2024
 01:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-11-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-11-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:10:40 +0200
Message-ID: <CAH5fLgjwzGhrQ3xCV+VkdUmOG0ffpRhss-Lici0YoHk2ax=zXw@mail.gmail.com>
Subject: Re: [PATCH 10/19] rust: sync: remove unneeded `#[allow(clippy::non_send_fields_in_send_ty)]`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.58.0 (before Rust was merged into the kernel) made Clippy's
> `non_send_fields_in_send_ty` lint part of the `suspicious` lint group for
> a brief window of time [1] until the minor version 1.58.1 got released
> a week after, where the lint was moved back to `nursery`.
>
> By that time, we had already upgraded to that Rust version, and thus we
> had `allow`ed the lint here for `CondVar`.
>
> Nowadays, Clippy's `non_send_fields_in_send_ty` would still trigger here
> if it were enabled.
>
> Moreover, if enabled, `Lock<T, B>` and `Task` would also require an
> `allow`. Therefore, it does not seem like someone is actually enabling it
> (in, e.g., a custom flags build).
>
> Finally, the lint does not appear to have had major improvements since
> then [2].
>
> Thus remove the `allow` since it is unneeded.
>
> Link: https://github.com/rust-lang/rust/blob/master/RELEASES.md#version-1=
581-2022-01-20 [1]
> Link: https://github.com/rust-lang/rust-clippy/issues/8045 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

