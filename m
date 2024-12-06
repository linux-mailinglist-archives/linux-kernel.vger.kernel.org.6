Return-Path: <linux-kernel+bounces-434911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A555B9E6CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75587165D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C61B6D04;
	Fri,  6 Dec 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6pNu0Ae"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D01DA0ED
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482847; cv=none; b=ESkV9V4oQWmy60MELRQHbfxuH8PSSQOEj7giOQkuFXP9g54W8NPHlS34bFooLbqfsQslEStyMmiM5fJrkZB/y2M9awC7E6F9ntj5ffTHldXvTtkwzIZvqIUowIzHkWo2LeN0/3phjlql77oGyeHzgppQKH6+mKReLn7iWZm1Cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482847; c=relaxed/simple;
	bh=cQlFajvuHyFsfmxrk4m+vVxvc7Bo/fdPu8CtdTBVCWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgkamHoH0yIWht4pw9TIatcdEeInzFZVVwmdjCJJoc+T4QDiGP1cD4t9EJfvwwqSxydCMawkQ8ssIP7llXewBkfQ19SVbmRwrXFadQ8fqN/WS1HtvgPSOdLXLH01OW1U5hbfQasVy6pnGyzTaC8NKMk2GhZBoEiKQnxlbEl5J1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6pNu0Ae; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725b4f6332bso144928b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733482844; x=1734087644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQlFajvuHyFsfmxrk4m+vVxvc7Bo/fdPu8CtdTBVCWE=;
        b=a6pNu0Aev+7bhuK/O2PeqfvOiBPTUhIQl8jznEdGxM3J4F4swuDL1zi5/0i60NctkB
         c+2jOUQkFXYcdBkgVAbHn6X/09Yc+qyqbkrfga/QGvL7INhSMLmiBXNDwwUIzJECNQH0
         5xArQ7XuavxoCWG+tblx2RFOwr8ggNXT4FJJk7Y54bak8vXSWGEXceyYL8El7qmphuTq
         AIJ1q9ZUKmWRbU6ANy/cb5a0vmDG3myX7d1utpMB9IVkc14nam1DtxNXFDtk+L3nESxT
         eD4f5m3yP0U7057zgsPr2TXSvFqZrbQNlsE0WMWxAOaBeciOqGerYhGIf7/n7ms/4XOR
         UZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733482844; x=1734087644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQlFajvuHyFsfmxrk4m+vVxvc7Bo/fdPu8CtdTBVCWE=;
        b=GbpU5AlebnqCcNvUXS5ERbQa1E8uqWhkOKWPfzJDKTZW3iO2VAebXykzzP7/eLDLC3
         O8PV2pFKG+kP7Pqn0Ml4/BwvpVeDc2QNIg86x1imlvzB5IMQEBCfz/csV3/N8UlwQlUE
         0+M9/Qz2U5StZDIkYTy9iJTROitcUH96c3vDY4njPVE7F+bqP2zj3KcftxWubPRaBeEZ
         Pszp+SEq0JHwon1COsCzdJkfjaD0zlnTAm0wfy7wT75UOXPSoL4Twuiy3WUmn27PpxAp
         vlwULjKXASL/+ZlxRvcA8kgpE3wNldZt017+rH6LG/VkaJG1GSEiEf8cn5N2OdjcliKD
         ashg==
X-Forwarded-Encrypted: i=1; AJvYcCXMVx9lM4lOKlqct4fkeOgdjNZEu9P8W6A86vX72JA1XONhvO7+x3nHAU8c4E0djx7PkglDMIe4pz94rdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXA1U1alGMNXtuFvtub4FoMuerqeRdrg2EFU/OaDMnbkkqTeap
	p5KxmY/tViZlh7Ff//vKOsNhtrARmzqNnMRh1AS18VhLVEEqlB/QqArIAo+bLFcw7BLn2hT3y8h
	cxk93xEVPB3GpbYRwO+pTu2D9Wt8=
X-Gm-Gg: ASbGncvgBcqcQhWEgfMkiuk7dj8uUYpPFtpKGP6he6eSDBeMoH9my6eADloD/4ACN8x
	ernFLWjjo77cnARHbnviWO0KrqoyTe0c=
X-Google-Smtp-Source: AGHT+IFlTQf96GggNi+tTMsEv+Ohdjf+dgguO6qstJdTsai1UF/MPTMj7RQXJgLK15YYVqvphXUSwHYiM7UuBcTd5go=
X-Received: by 2002:a17:90b:4a49:b0:2ee:c059:7de6 with SMTP id
 98e67ed59e1d1-2ef693630a5mr1590944a91.2.1733482843973; Fri, 06 Dec 2024
 03:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204000652.GA1999416@thelio-3990X>
In-Reply-To: <20241204000652.GA1999416@thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Dec 2024 12:00:31 +0100
Message-ID: <CANiq72mZzevQY=wouBiTzPoC3jn9W3B-kKKsUnaZvTYDLYQ3sw@mail.gmail.com>
Subject: Re: Prebuilt LLVM 19.1.5 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, conor@kernel.org, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:06=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> I have built and uploaded LLVM 19.1.5 to
> https://mirrors.edge.kernel.org/pub/tools/llvm/.
>
> If there are any issues found, please let us know via email or
> https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
> opportunity to get them fixed in main and backported before the 19.x
> series is no longer supported.

Works for Rust -- thanks!

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

