Return-Path: <linux-kernel+bounces-349612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FBB98F910
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2045D282472
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BB1C0DD5;
	Thu,  3 Oct 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hql0qvLi"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CB1AC429;
	Thu,  3 Oct 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991676; cv=none; b=Od8YLPPSA2wUljyeuI+ISekltoCs/Bh4hByM5S+Kx6PmRwUia03mhQlkfchAfy5Y6dXUOt0kOAvvPWvzcziq+m/SbBiVXXIfJhlXt6HQpHumwun5jXZOdPneeUUJKJWdSS+u0CXtK3x4ta12WKGOrntSI6JuP6k6AGe6JnA9aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991676; c=relaxed/simple;
	bh=3TkiZggLetztTg/Sv86VQcGBrsWgKOT5PfIJHzxF9QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHtnjxHSjxO7zz4+iz1tMCvVRhngtShv3CJWXQMUausDyseQZ3szkRyqvY3tZpsnt7GUe1yf3cLDWfezJ/vRZB5Spb4LiLbm7mUMieD+/bJvh0Oa0kk2r/Uc123SNJROLtyXxPCWcpozoL4nJbPw95Np892DvQHsWqTs46PtxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hql0qvLi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd85502a34so178282a12.2;
        Thu, 03 Oct 2024 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727991674; x=1728596474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TkiZggLetztTg/Sv86VQcGBrsWgKOT5PfIJHzxF9QE=;
        b=hql0qvLiTWwAjEEhfJEln0EH9wUCKTOnTrPzvmC0RIW7pM1Ak2I/sFPE5aKyHg3h2S
         ZUqi2RPhJOyNcUgjZ+nplXI/6m6A87XV6IcKpzh+YbKgoqXuir7rbKvMK/ef9J3JA9NS
         kQFYPQIEqMN+UGyrWuxw6sqdXz0bOo24xRiSxC9OPfBBBc3doTHe+2/uN+nN88x5AKwb
         7LdOwKO0F+Ui1pO1jBqAqrD9vQSe0HlorKI77EcL0byaxbIFAXN1r6hZeax7G9dZTBuf
         4G2/aGCcUV1KCfSUKX3y3ETTsEieW8GyeDzrcpantTeFfHqfaDvbqmZJeDIM3Eq5OYYk
         OB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727991674; x=1728596474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TkiZggLetztTg/Sv86VQcGBrsWgKOT5PfIJHzxF9QE=;
        b=o4DrZ5wzrPM3n+rJ3i+ntR1EzeaK4DOKG+91fouCyHKgKMSR3eUnVSxNDIZTn/2k2L
         +/7XqxYerQV4Wl9xUPqVD2UCaOfNuB3GhToJ+hUuupV3kRHouggsqvoh0vjHV5R3+kjG
         KMWfQH8PafExSf0bWlq49BfWcRxIO0Rp8unHo9nRr44inyb/SfxWoyaksFZjD10cLsrH
         kcRoEgJ2YHKIw1VTUCfD9QrjTQ4hp2+m7nnFWuIm8q98JGQ/7qVd4A4FlKwz3NH8PHwG
         qa2WW20umezN7BkW1p0A+njVJPW6RzC4/coAagUaMqmPZ2RAV/uaAY9C0DDC1oPPLGO4
         FIRg==
X-Forwarded-Encrypted: i=1; AJvYcCUOFLcXgwWKKd5kD7lT70/fkJPXVppPLNWOCA8+neaNCl6/7uKQKMpQRsPnqzYN70JNhkhOh76NGR2slC/69IY=@vger.kernel.org, AJvYcCXvcWTIBVv5qilpesypogIG7TQFgHvW6bt2RShd1i3QP2RexGPA7qa26TVA2eGm+pb3XLG9S5ljyz0Ugj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaJnaU45cNUE0mrWAiAxQ08utf6C/3BT9mbXHSauLqlhe4bx3
	w/RRq2VZ5kGVV2G1Unmr04M5JNwvBxM2kpyJWRC4m4TUZzs/PmORVCxV1oKe1LZ3UkUHOEMzUs3
	e4b4WvXm1OotaHlG5S7gLp3fmgCE=
X-Google-Smtp-Source: AGHT+IGFKU1oA5ucZ4//Ibb/FDO+Pj97ji98aX9vA2KvRhvNOyPGcIjw19gjUwZ2+LLM0jZo6AIXOeufaGPvngC1AFk=
X-Received: by 2002:a05:6a00:464e:b0:70e:acd0:d8b6 with SMTP id
 d2e1a72fcca58-71de22e6819mr352098b3a.0.1727991674036; Thu, 03 Oct 2024
 14:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-26-dakr@kernel.org>
 <20240928204357.3a28dada.gary@garyguo.net>
In-Reply-To: <20240928204357.3a28dada.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 23:41:01 +0200
Message-ID: <CANiq72nuZ41eDXkybGBbGRMgJzUOe1rRZioS-amJfH7UV-9cMQ@mail.gmail.com>
Subject: Re: [PATCH v7 25/26] kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:11=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Would it make sense to throw in a soon-to-be-stable (or
> already-stable-but-beyond-min-rust-version) feature here to not have to
> remove the build system support for unstable feature directly?

Yeah, agreed -- we are going to have `lint_reasons` and
`arbitrary_self_types` before this series, so it should be fine.

Cheers,
Miguel

