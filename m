Return-Path: <linux-kernel+bounces-553445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D535A589CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D945F3ABBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445B3595A;
	Mon, 10 Mar 2025 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDEQdxiU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525AA79C4;
	Mon, 10 Mar 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567563; cv=none; b=aRta1cnJsGJVpQ2Q/cfOLfWGqzCsgb51/jk11Sc+biRybt9dFpLvIn1NDge3K9jw1GNzOi7ErRENVZZAhqRIydmOF08u+Vnpt/Uk140IDfbGcbtlmBspKFZLm06O09DrrzyLqhrnEl/0qUOyyV7Ok6hEycO1qO5Bgje4xG9dxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567563; c=relaxed/simple;
	bh=/ZqWwR0mD+Aoi+i6jL9FUFUDsWHnPV8tJUKAkV+No6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0jJIWiDdfIb68cLlNMFDENj3tCix/ywMr+QKjUEIpilf2CJH6eEBcaXspFjja3Emvd8zLJ+8T/iGYqeit1H3gw1gPXtsJ0mt2zTAAGIuZcnBior51CQ/IoEt3vpTgzoHU9qEq9TB660DQvN12ZH5ihuq40l81iFidmfDK1wO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDEQdxiU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224172f32b3so5537795ad.2;
        Sun, 09 Mar 2025 17:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741567561; x=1742172361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LUQuJrBkakSWYtGoMqfYv6I+MDuULLx7Sh74kdrvzE=;
        b=FDEQdxiUN9ONz/QFj167f9qLM6dgCaGrGx8INDwzbqjWatzIa3E+unsKs2g046ujcN
         0WQrtVjcmTnK1fvWpuO3RTyPYaacs8JYAb5joE9Wn32Nl6gr37JqotIxsQTNPTCcXlFK
         Niz+P1cTaPIcU2XLigR0g3hXAUJgLWbwekJ49iZFm57y9zUQtpZASiY3fyrCbzmAndV6
         m05B/2VQep3ZUZNfOqbZAJ6hZ4bDs8YHzohXIz7mcC0q3ymgkBVMF6rFVXQzv29wyipB
         omBZdVWQfncq2wdcSgOjsarR3mmkDjl0Fv9rDA8mKa3CR+w50lS+XrRt+fRJpRcG+ukN
         9Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741567561; x=1742172361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LUQuJrBkakSWYtGoMqfYv6I+MDuULLx7Sh74kdrvzE=;
        b=p1Er4/6pModot8oCsOpg+F+iUHN8l9DNrnxoY7+WX7WatcG0QBq84rSr65XpilLIqK
         wTFuzNOl6JdL8gQ6q70248dMEYzstAeiD+RUmnSr2vURfgr9O2RwFRELy8iaAyT3mwRe
         cxIWtX8b6ytHnhAjs30eU7tDDft9t20Q4igrXtpiEm60G/uuiozYUv1YKcY2NAbqixrN
         0W0yQpx4CWu/y14EQmZJEofltKTOBvq/+6RKbpU4jLj2zFdr3OOWDIJRLwbdJ0tMOMpG
         ptFBzVv/DDO5iieX0x+W5eUuvhjWK1T8Y/nJBA3TIEChMH+SlLkFSeUvMVeyJMw8nt3K
         Jkpg==
X-Forwarded-Encrypted: i=1; AJvYcCUoGVEWu032aQ8UEgeqrIgMeLAf7j/fOWx05nO2/oUEwRy8bR8T837+SpCPNP68TeUY3ffGCT+ybY4ioSd4vgA=@vger.kernel.org, AJvYcCVPOS+h1X2yKLwI2kZfluk22KLbyhDNbNh0vazphwOwoQhtNXpaCyl000bpOCt8Ay2Ko0GLtToIDQcLwAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqlXGNnbNC7zRtNaFjAMEjwZa9mUOvehRvPYdz2TSdJedGUw/a
	k6iCpAL2UPbXMtY4b4V8nrThnfkL4qvEoHSno39tnWBiVd1C2hAtBXZA7BhDpOKP8bXIRbCo3KQ
	IwS1v6GgnMlUK3LtyifnJLN7K10bwf89zakA=
X-Gm-Gg: ASbGncuUOdc2LPELXDCAPKsDx051vnEOrIKqX6RFlGU0001PKnI6b6FImeWW6Psq97E
	EK5CE9epKI/ZUhKnX9HMmQOGkBCoxX0Sm4TyqYcHJ8WIFGiSXBr7S/RmIWojXBJCJ0H3HQCdHJK
	rzyFSYZq7OFFl4TPEndu4qjiKAxg==
X-Google-Smtp-Source: AGHT+IEH9/dx8gO+h2G8Ae4Wg2j5B0YCP301EwW5CaZPMqTorzcwfRqLnUXBbJkmgta+4Sz6O9MsdgtBo+DxJf8iU8Y=
X-Received: by 2002:a17:903:8cd:b0:216:30f9:93c5 with SMTP id
 d9443c01a7336-22541ed8023mr46283405ad.6.1741567561422; Sun, 09 Mar 2025
 17:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309175712.845622-1-trintaeoitogc@gmail.com> <20250309175712.845622-2-trintaeoitogc@gmail.com>
In-Reply-To: <20250309175712.845622-2-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 01:45:49 +0100
X-Gm-Features: AQ5f1JpJMlBgE5pNhPLjrUJbILEviR6O7yqsqAisOA-ctOGwlRtLOE3JrHwLQDg
Message-ID: <CANiq72kHuQxP5J--Y5vtT9d2mJ=0k-xVW+irJzhibAG2BDgSzw@mail.gmail.com>
Subject: Re: [PATCH V9 1/2] rust: module: change author to an array
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, lukas.bulwahn@gmail.com, 
	ojeda@kernel.org, pbonzini@redhat.com, tmgross@umich.edu, 
	walmeida@microsoft.com, charmitro@posteo.net, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 6:57=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> In the module! macro, the author field is currently of type String.
> Since modules can have multiple authors, this limitation prevents
> specifying more than one.
> Change the author field to Option<Vec<String>> to allow creating modules
> with multiple authors. Additionally, rename the field from author to
> authors to make it explicit that it can refer to multiple authors.  In
> modules that use the author field, update its value to an array of
> strings, and also rename it from author to authors.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/244
> Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ The `modinfo` key needs to still be `author`; otherwise, tooling
      may not work properly, e.g.:

          $ modinfo -k . -a samples/rust/rust_print.ko
          Rust for Linux Contributors

      I have also kept the original `author` field (undocumented), so
      that we can drop it more easily in a kernel cycle or two.

        - Miguel ]

    [ Fixed `modinfo` key. Kept `author` field. Reworded message
      accordingly. Updated my email. - Miguel ]

I didn't drop the Reviewed-by's -- the fix I did is a single letter
change, but conceptually keeping the `author` field is a bigger change
-- if someone disagrees, please just let me know and I will drop your
tag.

Thanks!

Cheers,
Miguel

