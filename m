Return-Path: <linux-kernel+bounces-577416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CEA71CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76461895791
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159EA1F892D;
	Wed, 26 Mar 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ulq3LNU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307621F540C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009189; cv=none; b=N1xCZycWJNUWAufJXxLppDVk+DNHw+rEAtOTF7rOceWl/TJQH6AeYHZFoEjB0bvJ8ypMo5P/WJK2TyeHB/lD/xTozJ8/FfT0bbbDybA33JwHQ7Pjxa1PBe4UhJRL7SDP+KwrrenElAwIOJXtOJ3mA3O3SwEQ62IbKrO3BuYw6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009189; c=relaxed/simple;
	bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQFdl28AP95XzISZqksgOb1hFRCczYPvjAsW8vEA81srb0urm1SrCCdkm3p4ZtqW/xEJ+u7kb/K2CgXx6WLmURxRQd1uMMjFnkGESDqLhg9qZJI8iR2rMPa+vNyauoSngqDrAdYMq+4a8HJaJh4qrv7qOL72ZFEI9hdNen3hPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ulq3LNU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264c9d0295so12325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743009187; x=1743613987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
        b=2ulq3LNUbq8QlmlGGFHsJyljuyR3endfuqLV47tEye+OYOrJwCV85qm4mkFkiAZi0U
         0c4XJv7YGjfFcA7rB0v3qD4P1fhGIvN0X4AtFZmGJ4VIsi93w3bjFz6xu8DJTjql3JJk
         +QKDyBwF2yuvM3X9Qzh5dBImn1IHAX+stvGP8t62JN+ag3D6HfluNYbG1G10obJA7kln
         HnPEWvyiAZ6aZMlWfQMaPzq0ceoh7FJTK+iJfqU7tv4VnPDW4JYcU8BK6lL8m7EYLgNQ
         nvqMPmo0IrDpxmnNV8iNmvojvksxKbqP1i2IpUB8QfzKgbcfYY2ag7hXW4oSK3lutrYB
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009187; x=1743613987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
        b=Wfy9MBJsnF6a8b6iLmZjNCWOf/LdpGlPetGSwZUmoXDByZRjR1Be7AUoiV7MvOVey4
         /dwwR65GJhLD9uR6gh9BInem7JS8FmSTmXSuyo2j1LoMtI6wv2r8v16SULEbHObHLpJg
         O+di8js7MvJNlooyOk1AnNptbu3flBh0BHDLYoXqbCH1g58ZEvbSHA3jKOm/ys7fwuOf
         5jPduUHs/E91hyndWcvD2nxZkoSVN6B8lofnF5jK3bpzICDNWTjIRVVVvR4+AFtKUu5q
         yiVyTHUmMVrRwbnX3VcnSs08ysn6yXS7tNvoUuJe/oBBLVt6aXyCbL19lNnxNEr9sdn4
         QI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8LGd1n0LDQZAZkvXhKyNGYfc4x3A8/tAAek2U01NcCDEeW9W5CbxAK/w8H7hGyw71XaxVfeOzDaHZ9k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jV1RZG2vBYgbaPzEBAERApCiR9yKZ8gR/rdsePu8MOpNazzU
	8DpNxSgISr7zulrpG6W3kBoJYvb9IPPPzADCPHPG5e3LFRmYpVNH9EvsojFGAv/5FLFAjDC6as9
	YZ4zgH1ZLcEM1hn2hf6jGD3lZ9lIjJkxsuzuD
X-Gm-Gg: ASbGncsnecpHtRXBkCQ16TpveTAIBZCd64bR5s+XdUCZXyW08RJlo4kB3nU32Awg6v4
	PJZBawY1Is8CnLkKf7mfdIdaCVckDusYnOgRYg4ue+WZZkM5+8uZuCFYCD/Wdnmm36FlW8Vz0BV
	vYhlVxrE7hnu+I+DqpvokkLo1GLZPrerbNGPhwwbwSc12a9HxPJHE98yqB
X-Google-Smtp-Source: AGHT+IFvk39LnkeMkX25OX1JcG8F54jZn2W19dDnfX7iWusa4FMz7ouKzjv48eaBIVtkQbCfKLgP4xKq2VNnjn++uzA=
X-Received: by 2002:a17:903:13d0:b0:223:37ec:63be with SMTP id
 d9443c01a7336-227f365b723mr3316495ad.4.1743009186911; Wed, 26 Mar 2025
 10:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325015617.23455-1-pcc@google.com> <202503251242.FFDB6940@keescook>
In-Reply-To: <202503251242.FFDB6940@keescook>
From: Peter Collingbourne <pcc@google.com>
Date: Wed, 26 Mar 2025 10:12:54 -0700
X-Gm-Features: AQ5f1JrGljJm4PeWBnKXpI12td-rU59plY-cd4apU9o-HArGlIBfJwqu8UHG7l4
Message-ID: <CAMn1gO5Ero80wm=P3_-BQAFPuefUr_VUBV-msTN-FD6oL_1Gig@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
To: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 24, 2025 at 06:56:13PM -0700, Peter Collingbourne wrote:
> > This series fixes an issue where strscpy() would sometimes trigger
> > a false positive KASAN report with MTE.
>
> Thanks! Should this go via string API (me) or KASAN?

Let's take this via string API.

Peter

