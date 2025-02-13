Return-Path: <linux-kernel+bounces-512824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C321A33E28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058993A52FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B22080DE;
	Thu, 13 Feb 2025 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHQSe2Si"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC4227E90;
	Thu, 13 Feb 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446361; cv=none; b=g5Z3OXhiMJkxbxI4eASrQcPouGaXRotiRFzSzs5B2m0Feggo9X1L5uNkQ5OgDxytnlYvvyK/y2gdNVJoZRO8PscGH7afAW3dm8kY5hap8tRSYLnVOaDgXT5sOpRFBpX37a8KVexeFzLxESetJtKbR893h9oK4aLFUa0jB4Cm+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446361; c=relaxed/simple;
	bh=WTmXv9zZjZOs41ldUhJ0J+1igSuXLtd7YCgMAUF3Knk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2Mvz1Rcmu97n6BIQBG+sN3n+/ygotNJp9pmASYAtbdIqrGFAbLFMOg/zZfvkUs1V6JjHpw3Cne3m99Hv5d4l6HxpftMUjPbXipWpajsPwPrs5crKjWTarFmsk4TegNmyOBxytehEZr+NC6JzOi2Y+aA326w7cmqmzvqNH9wv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHQSe2Si; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c3e25658so1724035ad.1;
        Thu, 13 Feb 2025 03:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739446359; x=1740051159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuO3/QAhJJwMEJuh+O56O8zlXNyp22vHvvMs3PFXypg=;
        b=QHQSe2Si3uJktBk/RD2lhA63IUuXKF4HG3u7c3OHtGqBoLLAxkAc2tsc8IArT/RBbz
         nbIGiCMT1sdgJ1lDKgeDGH4Eq6pLz2Y4VsgIGebmY7f6mHbdnoN3VzLgG4ufJmM8jvsn
         7we2QW8BDR3mL6E4Tf4QBoGdgOT3nEaKTr3u7Bs7bGA2aczu63KLd7PiTxMLDRuYmLZa
         KFx4ZR1JF1XhQHmYVF87e6cyKF5YV0p24N3lDyhLSxn12fOT4TP0U1liUzSiA1PFK/i+
         5wPVZLNtuijp3iDnEzADDOwBDHuqtM+ZUrgp83nXOmpwM21ELIhbw+1hWpwhbAG0q3eo
         BJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446359; x=1740051159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuO3/QAhJJwMEJuh+O56O8zlXNyp22vHvvMs3PFXypg=;
        b=qTtuVZF8Q7r9bsFsLkIwRSB8Fjx9OC5NcPfdrYS1eijD4314OcyhCCxW0PQ+l1atV8
         5KmBKlByzwhcdx2BwShGz6J6Not9ycm/ajWLy+RnkxCZ/EarB8qUVrDgyrEOXtYvrBhK
         sSPaVHsgxzEqpNr3VKNwrOxbK8v2gpg6wQqqaFbdhrbIK4s+Izy9/S9ytAD1NMd3LaGk
         ULRDHaF1K/KdevRdD7rY/nJnMH7CwJ89t48vG17l80BOWx/aiQ63MECYzVllKZWtNbCK
         6wA/I4h/eVp1cZOGbBKXM1TD4DtQ+2hPWfbVGxK6bFfsIRAEtNpb+6DsyvAeLk8kkmoA
         7wFg==
X-Forwarded-Encrypted: i=1; AJvYcCUFFEmiWDxtw5TmyFbuGqMCrLvMB7puLznlvkBxDpN+tvzROkv1PimtVpmCUDjdL7gA54b24i2nSIy9iur3RIk=@vger.kernel.org, AJvYcCXbPyoYCmvxhxG9Kygn1GMLzfJJr9GKaEVHBWvnod3uu+ybUIEupyL5HCRE9Z35ebZnXAF0FXDiDX+lsrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4V3GT3qGOnRrJwjDHY0KOCAVBmHDiNa7zPVEScaBCmAY+K19
	nkn5sXsDBu03tcHgJvxwzsCNU0tuFec1Ws3qrfK0EJu0byDfW0+u09rLNOqlRiPuP2XGN4F4o0f
	SI97i8uMIaVOQYsvXbyG6wMTnCV4=
X-Gm-Gg: ASbGncsHSwiZiTKbiLP67xgjKfBi0KfVdIxixnWV23hCSnfPU9EXZAflhyD4UO9o3B/
	KkDl9Fi75uWuWYmKXRfxHu/3TJ05VBhLYaIxQHXJLoCI6n1JVHV7QGxagBPsZwpDv6MAZoEiQ
X-Google-Smtp-Source: AGHT+IGOYf1FdHgYT8az/YHu4tftfIcEUzY4jIhLilmfqu99aEiZCelfm251QGNkqsLk5rWExoLtTMVLFsfrSObs++w=
X-Received: by 2002:a17:902:ea02:b0:215:3862:603a with SMTP id
 d9443c01a7336-220bbb465f2mr43671375ad.10.1739446359466; Thu, 13 Feb 2025
 03:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com> <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
In-Reply-To: <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Feb 2025 12:32:27 +0100
X-Gm-Features: AWEUYZnf8SnyxTsEdghJXriv60Cx1tTPSw_h6brdT0bNZU96WiP2p68xxKDAYP4
Message-ID: <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 12:14=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> the maintainers for the subsystem generally take series (though of course=
,
> it is entirely maintained and managed by rust people).

Just in case: I am not sure what "rust people" means here, but if you
meant the Rust subsystem, then it is not the case. Maintenance depends
on what the subsystem wants to do (including how to handle patches,
but also the actual maintenance), who steps up to maintain it, whether
the subsystem wants new co-maintainers or sub-maintainers, etc.

    https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in=
-a-subsystem
    https://rust-for-linux.com/rust-kernel-policy#who-maintains-rust-code-i=
n-the-kernel

That is why the cover letter asks about the `MAINTAINERS` file.

I hope that clarifies.

Cheers,
Miguel

