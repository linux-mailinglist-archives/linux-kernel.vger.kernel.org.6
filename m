Return-Path: <linux-kernel+bounces-390200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E99B76CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A081C2127B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60A18858A;
	Thu, 31 Oct 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bvGmxlU"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0AF1448E4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364804; cv=none; b=PXSGoY4nFAnKasf8qK7kC1n1+zoXk2sRCLWfL9/XV0whNAF2qnnY0GqwJQe/6h0QnIZH+QIgUkG3ALJtRBf1YvEr1B543iPyAnF8BKjRG2Y25EM+SRKbBSQUoOVnsRb9FHw82OZ/p0IJvrzb3baZkyqNmUYd7r+/ZVMAHptmbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364804; c=relaxed/simple;
	bh=tBUmsUF++uEh+cHIYR2MKPEGPTwBPkYXk4KTkeZxiB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcMtmoB/912muCK5QB6VODtps7vb4JOw/Ya0qnIAv+KrA9jq0OfFuGJySzUNKvBuY6WY/gWwFA3MaQgbRNLWRsWFkg9MCEljYV2p0H2IR4JvEhWddLqP1QddeOOyrtTfq9C5L7rmNLi8Ezbron8CFq0xcJ6gjxsuZQUAQj/PuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bvGmxlU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d447de11dso602110f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730364801; x=1730969601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBUmsUF++uEh+cHIYR2MKPEGPTwBPkYXk4KTkeZxiB4=;
        b=2bvGmxlUm7BQIBu9SUfR9OOgKbK74jr3TMB0Ac6CeH84GU0C5HTsg/W/U8M+N0IVAR
         Cu8/WwTqRgyz06ftdEZtXw/naAAo00zWQ8K9b4yEgWuCouNoh+i27ab9A1LEkcTDhzYd
         ExYE6MvUEbtc4U0cIiYbuU1CxU93pRf/032Z31R3uFrNJGdgGqXc72j2bxc8MObT+Yha
         DesBb2UfoDnmACr3bmlLsbfT7aZGE4VHBI15Xo9LiS95QmVnMphwkKYuyDymVyu9K2Ws
         VCbQAciSmD/3ZAR0rn9K+c9zbg0RWN4JArbnhNvoyFRGBirVr7h2ub5V2JjtsC+JXd97
         vXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364801; x=1730969601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBUmsUF++uEh+cHIYR2MKPEGPTwBPkYXk4KTkeZxiB4=;
        b=TQ5nbVBGZ+NbQ3M2wMTn8RnOt5MGRV0xKTbCIiyGkzc0IaO43UBEX2MSab0y2g82nc
         j6xloNqcHj3Y0PAlos+wI1j4XVfJwiOMqT8lutYCcHRK4XwwtbbirKeQoBmplZfeTkTV
         nCF0iTZhbgZDyvLObKHo/H3EzMcYAyoRG8X58G7cv/8iQwkL4s1vZlVA4J+k0WrSdNSa
         5BrjgVr7ZeEvKypefydDlcIRL8WGgkxHkAzMiuB+aOSMUoswnAzl5YA2TmYKsZCkWw1s
         va6tHTFRFTETrCuSeilDDSv+rp1xDIfAj6YCA6mpMA5XmrisLRjz55ySkBxUW35Cg6yk
         qqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF9wfLsQG6s4foN0V5R3QNSK5DFzMNhv5wNXAqP3iU1ntiTqDKdBfb8oXPHpeNx4gavUJ5iiUVzVIUP+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqdcDEElWc7dlccEDekyrRHyuNCpW98VfOhn5Nf7R55QTfPzA8
	0NxEMt5oGvFxccCEBDouwnEEzlIK+uqzSxqOvdw8q8TwQhW+bJ/4h5CTXi8GC+Mq7NUlcDU/Vs6
	6H5jPbMNeBnqvTkgAuCfINvoprSMhvrIHeb+b
X-Google-Smtp-Source: AGHT+IH696Y+akY9jhmXHHXy6ARR89oMr3Db9V6MBSAHoQHCOePCwvyfUFOxTIoP8FBAhjcmix68B6pRgLXdikGqypU=
X-Received: by 2002:a05:6000:144e:b0:37d:3742:a5a7 with SMTP id
 ffacd0b85a97d-381be7d9095mr2206298f8f.33.1730364801168; Thu, 31 Oct 2024
 01:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com> <20241030-borrow-mut-v1-3-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-3-8f0ceaf78eaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 31 Oct 2024 09:53:08 +0100
Message-ID: <CAH5fLggYhh5QFQ0YT3t60BqmbSTvVX88gHMdZsaZu+zi+dRbBw@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: change `ForeignOwnable` pointer to mut
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:46=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> It is slightly more convenient to operate on mut pointers, and this also
> properly conveys the desired ownership semantics of the trait.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

