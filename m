Return-Path: <linux-kernel+bounces-183554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01B8C9A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B26B282159
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF5122F17;
	Mon, 20 May 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ9xzG0X"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3121345
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198082; cv=none; b=hGoHVQSBlP/+9FWshy9i4dF1umuXUMO4yWNklrBGlB2m86crEeKhwfmrgdYpxOarCPTncXfD9h54NnQHEUbCgyOZCxi3KaHGTqrp3R+Xu0DKTVJVpJtXzZaLKkuUHK2MiqxniIY0xJZytemXeeKSEeC6DpKIYAFDBBiofxmda18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198082; c=relaxed/simple;
	bh=7uuugY85m3skoiVn07kJvXcB4zJBbm3CV5cNkHDjjBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+mb3DZ+t26UMfB0eJ/ckh38jwnoZB4FmrBvdgo1wvu8jmi42KE+aCI3M3zW5E/CGKn+gQqPZkZEv6r7YirwjyMYAcJDW6tjhIS6uDS1W72zTlyshOTqJ2ejzw3UwTcYM2QcbCdwybxFzfyJj6AcrX1RM9X93ItEFhsxRrshDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZ9xzG0X; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4df3ad5520aso1184660e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716198080; x=1716802880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uuugY85m3skoiVn07kJvXcB4zJBbm3CV5cNkHDjjBE=;
        b=aZ9xzG0XRwlnWv4nP42FIH+tiSnaFlqpvRqqYwx3DSorkig6BcVA3qFnSFrId0ELK7
         Gv/o1Mx2ihBDvkhu/Scg1hZnT+f9612AJM1FqubzNMNcoxI2JbLK4/aMnWHw6mIEBoJN
         aY7/rm09UQsRSwh412d1d0Kl9fxuczUH7JyAuedJRdMlBbPtnX6YJ48P4C/WCvd4o2BW
         MH2piopsMHJxymHNPRZ5Sv/EPB/kGQxN7YpQCQxg6+V554VEoigCledMjif+zlYwNW9W
         I7cLu3O0hQIFlTS5Uqx/0PQ9bUF394LAMiaLAT4hPkyw3A/eOmtPjUJ8v4sxaTHvfw6c
         veDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716198080; x=1716802880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uuugY85m3skoiVn07kJvXcB4zJBbm3CV5cNkHDjjBE=;
        b=XyVSj+ZwCv9xidecwFc2hWWZ3VwdcXGavVgR6p5F/We5QuU7hOY2z2rjZeyPR5xAeF
         TMD/Y3ZzW99atR8EoJ/PducKc2yg0+uV8Ynbd5xQnlryVyPkJiI4/bP89vuP3IwS4lbJ
         6Yvmm4ttBemDduhq74gAe8F/oru2lWfeiTJaEcgjW7riXxR+46eAW7L+2t1AyJo2QEGe
         +b2aLsjb6lOmPcEMBfnSuEKfDsdA7MJ03qm8OdsjxtMwCtAM/ytTKuMADWPvqDTBnscj
         TZT/FFHwD+m3EgcRboPnbqBWkbgGVzbCHfvWB/2E3sDgRX9uPn0NLk343KY8Io3Sor3w
         MFFw==
X-Forwarded-Encrypted: i=1; AJvYcCW6lQaLkg7maVhzIaQGOblx54WfAsPbqwQ51tDNblShD1irDun9rS8yOhbR1CGKbd0xBBQwEUdAe1cS1GsdAbejVrbLs/+zWwXNIPcL
X-Gm-Message-State: AOJu0YxSpk7gwwNjvX3M6XcLRXLrbITqOXB6NFX3qqaYO8K8Saia9WcQ
	3GemGnK87gkkwI9wVZ0X0Q2j8FpwWymJmna4SL/cDRkVAV1uPEPyJrJD4iUbJZRqHVFBhkrMCbS
	kAOF2/QhHU2m10L8TU66d7rc8nWYtCqNCcD3C
X-Google-Smtp-Source: AGHT+IHIRXk83gqTUdQImOJqZPIX0uv6AUm05mTPSzxJ+VjagPZfmFf9nOGa5CXpYjIsVt4/l7jOnVOm53CKwZsfOTU=
X-Received: by 2002:a05:6122:200d:b0:4d4:e92:1a71 with SMTP id
 71dfb90a1353d-4df8835c8d1mr26014914e0c.11.1716198079941; Mon, 20 May 2024
 02:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519211235.589325-1-ojeda@kernel.org>
In-Reply-To: <20240519211235.589325-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 20 May 2024 11:41:07 +0200
Message-ID: <CAH5fLgjiKzmmwTrfiAx05tzFYVHDQUsiFmroMcWd3t=P+f6spQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: rust: move `-Dwarnings` handling to `Makefile.extrawarn`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:12=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Following commit e88ca24319e4 ("kbuild: consolidate warning flags
> in scripts/Makefile.extrawarn"), move `-Dwarnings` handling into
> `Makefile.extrawarn` like C's `-Werror`.
>
> No functional change intended.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

