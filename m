Return-Path: <linux-kernel+bounces-401565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E869C1C52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438C51C22E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A471E47C4;
	Fri,  8 Nov 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUo86sKI"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1757B3E1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066149; cv=none; b=hCTtmRxAvK+OTjzxmAuOgBS4t0vSYZCYWQIv0Zh3rC52mhS6fZWZ57ngDHKPG1kZbLH6dKOZob2dSJLm80Dl2KWOQ8TieQu1FjHDXKIwnQcDD91ikcr9WbAVzmREriZGg0qInOy/4GDDrHX+rsICb0v/g8g2Ow/99/cm4rCp+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066149; c=relaxed/simple;
	bh=QSYeNCRrMACG703/tZ42was+9GV5MlAmzjGVyTIcV80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oo+6m5UpGnigdhV5+lac+ngCfC8VFcIE9TxwEKlML+0kcv9TGgan4cEoAyskYmAK84FficecdCq2ltabZoxwHWKzvWORg/F4YiU754xbjwwLLXDU5bOHsPeTYzJ0bVdX9/v3QKCohIz6U+G3FAyiSdXHMknap5jiSzBQvB9mJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUo86sKI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so1282182f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731066145; x=1731670945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSYeNCRrMACG703/tZ42was+9GV5MlAmzjGVyTIcV80=;
        b=hUo86sKIaFf65neG4PL5agGkFsQsByTWyg4c0dPfhCnKKEBHcZwgovFfJByOxTp0xV
         M8ZXd1n7fUQY4ifBYWbROYEZxU5F9Gb/RUFH1UstXtf7UTTTEJSY5uiFaaKRa+DDRlEO
         53+UneoaY98r0ssxyXjGycwIuFX49EQl18FeWV+Uum3Z+esZrv6ciH+WVOLJLH4y4hrE
         70Eb8W7jN6vmdWwN+floRN2bvZm8LwKIja22jvaN5QNjcLhLLb4gEaxnG15FxJrJlZtj
         hFxEDCwwff0gca6gQviiTqLKFkjn2FAQQ9TM2GYXlJe42SDMTXZaRM+5tqFLN85wJOvN
         LmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066145; x=1731670945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSYeNCRrMACG703/tZ42was+9GV5MlAmzjGVyTIcV80=;
        b=Thwq/z93/8BpLXpYHkd+AyWu706eTgAJA3XSrSJFb0z1LAKyoWn//sOGe5VXz9ES1a
         aHCSkeLyngy5+p7xZyAa98oHv/C5vU5lu5Og0JVEyl5XRU/fVdDrKgUU0wbJfYXOdHqW
         Herm8uS4g+cdKTR973UZNFA1fQMDl5gmQx8a/gsuF5e4o+wKbAWDqlwlgowPzCiBrNqK
         Z8N8wQ/eaXGwidKqgGi1Y6AKdmKVWUZvZOkLZGPugvMSbUgHNSQKM0D36GUtA50OnJI7
         cQLfWife2JIisvGBfD7f8URgDxbPGnG0ZvUy61xJa8XWnBJ6KvezXr3qV0WHF9sq201A
         n4mA==
X-Forwarded-Encrypted: i=1; AJvYcCURN+TpA2w5swlN/PlMCLTPTLpLqxnnaBz3a0zkW16RgQJqGFrK27EXZ6vDloFt/29D0+yVbnctlAscnD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1aRDF2jBi2kCU2ckGf122LrgV8BDO4+weX32VxLYfCCDA6JC
	bGJ7Xr1oXPG6ri7sE36kmunQPB+/JnzjVjCDZPBwJXS0Qos57l6y9MYvKbxvKMaJprM6zoVCLYt
	o5/rvVKUltUxv0dEfeDPUBXdKL++3fFUf+7uJ
X-Google-Smtp-Source: AGHT+IHwq++S1UFkctL0ms+SbLu6Jboh5uhqAxESNgvmcj+xrJ6NQ6q3WEQenfMQG5a8FwXU+DeMKJZxGjzaBtTZ3zE=
X-Received: by 2002:a05:6000:1868:b0:374:c3e4:d6de with SMTP id
 ffacd0b85a97d-381f1885dd9mr2122596f8f.41.1731066145385; Fri, 08 Nov 2024
 03:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com> <20241104-borrow-mut-v2-5-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-5-de650678648d@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 8 Nov 2024 12:42:13 +0100
Message-ID: <CAH5fLgji1CX=OGygvzoBPggYDss7PvgvHC+NhW4tR031H6Tbfw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] rust: reorder `ForeignOwnable` items
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> `{into,from}_foreign` before `borrow` is slightly more logical.
>
> This removes an inconsistency with `kbox.rs` which already uses this
> ordering.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I don't think this is super important, but shrug.

