Return-Path: <linux-kernel+bounces-556826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BCA5CF29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C424118984DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3088263F4E;
	Tue, 11 Mar 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2OIfwp4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1A263F3B;
	Tue, 11 Mar 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720819; cv=none; b=QvlowFgbEKneVMdYD3I7+8ifYwxD5lLhK0uGdGNDihN49zKM6jFL0O6qA0+o41Q6OM+Y6roh0kKqGiNpIZVvLhYjpLCOUYyJu2zk8fqnugwBY2kr4uualvBlqrByfVJ96tCcs/i9S4uxMfgkHBoBxmzdff9P8E9vKZqvXtg+vnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720819; c=relaxed/simple;
	bh=RCdZS8dk2ZS37SbH0ZeGYxVd6QvMyepLaIm0iG2+ZIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt/0rlEA9IVZeNexAEYMdDmv7OoY4Nygg+V2VE1aeI/Qvd7EBwxPM5EQd618vAS9dZPzw+fUod5AkHugg2YmKgfyYNacBrwPbry2QolMopAUsj28ezCDOtwiFUPUwkWYzNWlNkbsA/MBfgW3kZsvxVvt/I6BrLMzoGKs3NfQGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2OIfwp4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22409402574so12568975ad.1;
        Tue, 11 Mar 2025 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741720816; x=1742325616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PljsenAcEFDHEJkpAalMEEK4jdo+wNjGX1LHExZIY/w=;
        b=k2OIfwp4rRDw4eS1ZdMh146ILhDVy0M8SXzQ1NxkMX1QaHnYH36DFuLd+D5d+6MGog
         BsLB0Ob2Gl2qrkXTp1m/nAQwbv1KjQH5FjZDzcwg5WNlbgMHj7VkMV2LfU+bqDyTnzMY
         jXFklKL/2XW2gVmZ/BT9E1O7vZIU0GBh3LRSdNp5GUcmyw0fqNkte2eCCQVjOvLkzdgG
         ij0aZ5kDV1ezCmpEwkx7g20UvbuLKfLPk+lVOQXuzDZDN/iAZ1HU9ZIWtgdbuA2q5KSm
         Xoy5zvath4uLZnq2hXVcnPLuGOBO7VwJ7Df9ZaCl4HXGPFKwXlADRZ/dIrQfyrPpDDuz
         n+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741720816; x=1742325616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PljsenAcEFDHEJkpAalMEEK4jdo+wNjGX1LHExZIY/w=;
        b=Xo8lfBuDjH9tDF563skZ0Liy+C9WhI2zmi8M1s2Png5N/IA05ND8+jhXxshKRzy3qG
         pqJHniyuetswSb+yus39V4j5HF2E9+H7oUo2dawRCduKxTmpsF6u3W0xwELT5Pc5lemP
         cUdRZcc7U5VLtRSMjIwaiV9FYkoJBiRg881A9QXBc+cTrDl4p9RV3QpLukprprZiK0vb
         lIWr4WD29gekLGrUEpoQz49wqjD82e2jwzZlUK/m0AxEzNCmgk4MghHSb0OIfd7HP4Nq
         B0gCt1fmfghxjB00LH2N3NxFFBLFdpPH+IIR3d9cDxGLPK7UDCaKtpR5eZjxqJNWWa2t
         lUIg==
X-Forwarded-Encrypted: i=1; AJvYcCUG30F2GDtK3Uk8IdHcIK3rY0q965zyvKOpNuS1b/uH68Nwy2MFo9puHaCRyYpBdcIBg776+PPv9toShUXhHjA=@vger.kernel.org, AJvYcCWgfGVp7bzjWZHGvh5sjFysyNaNzFKDe96rzpaoj+9FIy1/2kM4rPBYO62EBpO6WkQujKKONtJtfAkSQQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSgalzBGVaxK4tuSZkWwO1pMYP3Ri+8SwtX+MMcNcuW229i07
	1uUhkPoKT4d7QAELl3h4Z7F6OClgB4FE9wOTO8Cx1tpwJWTQY/n63bPVfzemclVpSFH0S7TewtG
	Bm1B8lDK1OTrTFRbFPyX561AiZjo=
X-Gm-Gg: ASbGnctibp3NZ0zO7/S9WxC5kdzdURxW0NwZxhC/AiSzy32BiwT7L59fTnfj9H6uot5
	YVhooll2mSTEwywn8LBceoPx3R4Zb2D8iHmJ2K+rcDkl/3f+vPp4DQ7ayv85oNiBl94PHtCzHqS
	V99Q8qfbeS6vk6ABPbhN055G1hRA==
X-Google-Smtp-Source: AGHT+IGQS8UGOWNAAVvfaUP3e/l9yfURS1SXg5tRn5KGnCD9O/0FuG5wPHsaGtvF2X1f6DI6BcB0MJxXvQVsX5R2gXU=
X-Received: by 2002:a17:903:1663:b0:224:88c:9255 with SMTP id
 d9443c01a7336-22541eaa011mr84413755ad.3.1741720816110; Tue, 11 Mar 2025
 12:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
In-Reply-To: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 20:20:03 +0100
X-Gm-Features: AQ5f1JpWmNGeYdDCCXf5f08zEALR7P-JnpHC48aAm0TSpWoYRKskvESvqMmcoME
Message-ID: <CANiq72=q9z1O-OfSy9BHhzB+nAngQ+j79ps7OAEq+0Yzz4sHcw@mail.gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
To: Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 12:35=E2=80=AFAM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> The kernel cannot currently self-parse BTF containing Rust debug
> information. pahole uses the language of the CU to determine whether to
> filter out debug information when generating the BTF. When LTO is
> enabled, Rust code can cross CU boundaries, resulting in Rust debug
> information in CUs labeled as C. This results in a system which cannot
> parse its own BTF.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Applied to `rust-fixes` -- thanks everyone!

    Cc: stable@vger.kernel.org
    Fixes: c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")

If someone disagrees with those tags, please let me know.

Cheers,
Miguel

