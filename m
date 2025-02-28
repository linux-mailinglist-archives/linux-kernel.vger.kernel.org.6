Return-Path: <linux-kernel+bounces-538574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED32FA49A60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E793B3F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A326B96C;
	Fri, 28 Feb 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFgB0VHS"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F841D554;
	Fri, 28 Feb 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748671; cv=none; b=mIn/1b08d0Z/iuVy1sDlFCS+FVeVLhKBTsmbFgYG7B24N1jYcjRWv7Ezf0PiYxCkjYs4OynP5M2Jo64fsOA96gEbk4ujGcxWd8jn3ZUzHUCxdBwjEj3qIx7+/Bf+/Qf2J4RJw+KSYleMFF42RYLmCoiMrlJe+WP4MwvUDb6BGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748671; c=relaxed/simple;
	bh=4kwXD5+uBWoYczTyDsTYBCu3iLFzX1inUSjlHr4ofaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFbVR9hl4X7W4HrMEgIN77rxjkXH6bwUMxCXpCWF98pZ/EUdDPMIzmj3WYL1w2VdWzYFL4RfOg/j5WsfudEXvQxUFaZweTm9kfp+I1uunE/Lb5D4+vQfBIpICbmNreXyWnTh+ptrwgmRMW6TV5WFQqpdulJkGHNj+uzCm6n3s5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFgB0VHS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so542787a91.1;
        Fri, 28 Feb 2025 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740748670; x=1741353470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4Syx3Qr0yw9AT8a1Fz/z+dGj8bCAVwm0A2wrOX6olA=;
        b=iFgB0VHSZwiHtykNlX7RSNdGwX3iy1oxIvoDa49EDk1LfX+tn5MUnBoqmPH6kJikHz
         9vSKyxO+a1nBlJHR4euIOQT9t0cufcEcuAjLwkq7u6G0Wt4JTp6PKhqLokMjj6icEWab
         fI6wbGufSIVAhRAYduW2O70VClKyUgFJoFue4TPYhKYl3GZ35GEaLq8DHR/swXNqTwDt
         n+hkk+1FJw1QeutTIdssbjI6wazLGwI2TsAnbFLMCqmxoWHxK6MMksVnk6I9uFusgklh
         w8pWoVgija9Kvac0VmyrEpS+Tv814c6rB3Hmk8JxGFTw5kT5844tuz28tiRpmkEYRC1u
         Le3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748670; x=1741353470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4Syx3Qr0yw9AT8a1Fz/z+dGj8bCAVwm0A2wrOX6olA=;
        b=UYqAO9DZbmNgfho52xuW/n1ioupA71JaLf5jOJ9Y5ndqRozzfvSghyI7/pFRJKejne
         Msqj4B+oOtH6Bz6Nftji5cztG0r7gxa8AgTRupsBuepuZtfbz1ysUWKkuDzLR8YlZxGf
         QJhRIf2LCjCsRwxyPYr1NklpZ6BQnyxMgwjjz65s1rkfoXkF+WC98SlME/CkUSjyvgMS
         M0Sl3gUtRuIgUfSDBA3imzxPGQ23IkTiI2X7IyLY0a36vYpy6+XUrXYZ2W11pUX+ar2J
         076e7vXoIPeQbdiC7Y6yFovZLB+ZO1NzWbXpYTvcwu72QUubTacjkg7+4aSWml+0XJPK
         UTNA==
X-Forwarded-Encrypted: i=1; AJvYcCWDJs9hYWD5E3lacqYbr+ma9IbXOqHizab1TTr8gIaRKTycd1FUH8s4iXqTfRT2ethhnTbkHLpwaAzweqs=@vger.kernel.org, AJvYcCXxFGhDXsWwN+BfD9tQEzaWNYpd8UtEOaI/XB59ZaQfKy1kLOuw172+HNPqIq3vyURz6iv9C7B8wcfoqaUZ68Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rwJX0bGHnKXl7xWYYpMkvsXCIEXC0sRFWe7kanHIqMzE0nYb
	HPWQK96U8yxk4v2VyIp6nCWuMlsCdcf9ozr0D9Q82aRvKNKLsJ4JLKSdDLYbmAX7+H+Z3NY/yLC
	4gcP4LJZgFsKa325ysCPlwFmWr04=
X-Gm-Gg: ASbGnctB4ESjaK2Noz1NF9cYhuewJ6r6UJ1Wh8hG9OHShBSqd4GJ7EPc9bbOfZ8I7xm
	vy/QqrgT6u1/s1LmhGGoqhQEIeqaoev1A0AyGsCI/ivrqJDRnGbuyAS86uc3nnLvL5EkdFGEdYO
	YCWNP/WYE=
X-Google-Smtp-Source: AGHT+IH0YOf2Q2lg2Q00q/HNLKalLp9gXnNZBBvJbvnROP+JP0IzFtqkPWAYdtkhSgl3ZdGnc+LOreNzDx8beQcDY60=
X-Received: by 2002:a17:90b:1d02:b0:2fc:25b3:6a7b with SMTP id
 98e67ed59e1d1-2febabf856bmr2100548a91.6.1740748669911; Fri, 28 Feb 2025
 05:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jeyp4dToznpiAQYWHAABrEBIHVfxaIf7ntexop3d2AXQgnlytw3J8YFkX8E8EFKc1-USf_fVZqKhEmuNGE3O0w==@protonmail.internalid>
 <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
 <87wmdamiik.fsf@kernel.org>
In-Reply-To: <87wmdamiik.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 14:17:37 +0100
X-Gm-Features: AQ5f1JoT8rpCYKZVofZp_80xJtO5Q9WZNNbYRkKhCZhrQ1IILrRAQTpNvVYn3jg
Message-ID: <CANiq72k_1tmXF+bTAeDfMYz=DOcEwsaS6v3d6NLjLPF-+7hwDA@mail.gmail.com>
Subject: Re: [PATCH] Rust: Implement a unique reference type URef
 supplementing ARef
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Oliver Mangold <oliver.mangold@pm.me>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:11=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> When the trait is unsafe, we need to specify the conditions under which
> it is safe to implement:
>
> # Safety
>
> - Requirement 1
> - Requirement 2
> - etc
>
> See `AlwaysRefCounted` for reference on formatting.

I think should be caught by Clippy -- Oliver, please try building with
`CLIPPY=3D1` (we would like Clippy-clean builds as much as reasonably
possible), you should be getting something like:

    error: docs for unsafe trait missing `# Safety` section
      --> rust/........rs:23:1
       |
    23 | pub unsafe trait A {}
       | ^^^^^^^^^^^^^^^^^^
       |
       =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#missing_safety_do=
c
       =3D note: `-D clippy::missing-safety-doc` implied by `-D warnings`
       =3D help: to override `-D warnings` add
`#[allow(clippy::missing_safety_doc)]`

Thanks!

Cheers,
Miguel

