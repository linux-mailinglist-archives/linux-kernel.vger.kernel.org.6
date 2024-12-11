Return-Path: <linux-kernel+bounces-441055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A349EC8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC72812AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F124233689;
	Wed, 11 Dec 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ap6NNcZV"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909882336A3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908715; cv=none; b=CikjtaSyP8Cy4kFt6RaMVFHw36NaCEqRgv75gQzCwGNL8hLAMcI/uJsYQ3rbRvp3QYkW2Zxv3GymB9Yegn77RUT//7dV4VZMGKC5tIbQ2gCYIm+rGPuJbCpd+XOyHr5/0lKBRdcRN1dPZ8EzoV+JxMuTemPAMLCXw7wSMyYkv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908715; c=relaxed/simple;
	bh=3vHYlP+vndcNXuZOI6XprGkQpKc6n1GhE/RqwAQGt1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poXEgD/ki4Jzh0vwbUhQaQu9m6o/XPbf+QaKkQzOS7v7+FTL+Cjp/baA5GBwEOy3wn+bEYSqfi8kB0GDbalO56TmN7bpT8iuwVYqRhqq/7pEvu7jGpDZ+dVeLyMoPZDxR+aghrGH40PBrFefZt+e8fdltc9wZy8MEVoNiIXUOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ap6NNcZV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2882375f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733908702; x=1734513502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vHYlP+vndcNXuZOI6XprGkQpKc6n1GhE/RqwAQGt1M=;
        b=ap6NNcZVR9tEdDFafFXVp8tZwW1IbPCjW6gAJOCL8T2Yeu/XM7u5+iMinmN9oD5r2L
         0JNFgDECbdlm/XEY5pAJoB9z4mqPISbUVMQKv/9DVRX7eDN1PSHbQv7ukZCGhwVrme5U
         qwDjtLamHKHP9xUVzThABInaLbgV+AEeDJ/4W5w32lD/9Sa6O/JFwBy1PvRWdoymYbhj
         mhF6yt2jvO7nY0lBqA62zvDTUS4EGXyMIcXpNwEMmkr7h6q2iIuHoUgq5xvdj2pTUJiX
         QkKEbmjFe8ilJ3apuPAu1lH7zLbnyi9ZTiIaSZD0D+F9Q6cxpmlfgGfe9rGdTyGgzR3H
         7UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908702; x=1734513502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vHYlP+vndcNXuZOI6XprGkQpKc6n1GhE/RqwAQGt1M=;
        b=ddlWFMKDoGkfi6yCZe2WXq9CKrSh6ykAyp1WFvnyFm7VEXpul1uE0/1c/xM8XjkPA1
         vhW+FWMjEwjwc2EO8YHAnVDVKZTpMvCOphxv0/7S/CP3jLgCTMFbfHff/mkSxxPevwB/
         SxSuBmpUVVS8ZRryf3Tu5A3b94FN+DdA+3pVmhNyN1xz+vX+BGXwohlQlNrU7JDNM/7X
         AJoc8VJbJcfFYbjz6PLF/HUyT3T/TGwoikeaPJz7YmwifWQzPGVD+znvVFyHcw306JFB
         C1v+6giHNCyL7SJQZR8EG+NqD70OVb4+8cvaBOaE1XcF1NoRTB2JiXMY6rspwEA+PAEJ
         IiDw==
X-Forwarded-Encrypted: i=1; AJvYcCXDjqH+NHroDT3ZvsE2a693tB1lVAGmIXZhbk6rCg9mDQC2igPQ7mtijAyOCqpJdzrPiUtiBBaNFb7kl5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQf9yaeDMOrge+2iOajEPqz4sRu8iwz+gWeJleAsTk2dr6jbU
	QUzWFlYY6A45cPNgK+wtMp8IIgY6B8rC0/1zan+l31qVX/d88WN4kn58c819zkZKEQEi1K94Djh
	8/F9buuNe2ePYLNi+bUYMkTNpyiDExddlUIXJ
X-Gm-Gg: ASbGncsiwVOeD5xZc3cSiqMYtOPEYh9yYE4F0OjjRcxq/p7velLWehFUsBQbgj/8Rcd
	ClbS1rDpByiZgIuxlCGRaPt//ZQzmwh/Tnr9Nb8FXweCHNLeNs1Yap3AxNVHtpZPBMQ==
X-Google-Smtp-Source: AGHT+IGXlwylyC3zJtiNHL0Jm3c9KPPDvqnLEc6f8/awzTY/st7wW/grsH5pHA1x0LnLhySjtkPO/7zB4NO4hs7+tfc=
X-Received: by 2002:a05:6000:18ae:b0:385:e961:6589 with SMTP id
 ffacd0b85a97d-3864ce96d45mr1556644f8f.20.1733908701835; Wed, 11 Dec 2024
 01:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210224947.23804-1-dakr@kernel.org> <20241210224947.23804-6-dakr@kernel.org>
In-Reply-To: <20241210224947.23804-6-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 10:18:08 +0100
Message-ID: <CAH5fLgjWGRCzy9WXVd=ggi5=R6e8Z12bq8yYwAQLxLMH-uObMQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/16] rust: types: add `Opaque::pin_init`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Analogous to `Opaque::new` add `Opaque::pin_init`, which instead of a
> value `T` takes a `PinInit<T>` and returns a `PinInit<Opaque<T>>`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

