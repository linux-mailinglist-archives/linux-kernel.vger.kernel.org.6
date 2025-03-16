Return-Path: <linux-kernel+bounces-562955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966ECA6351C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D637C7A5619
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C41A23BD;
	Sun, 16 Mar 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Feyu6Kxi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825101863E;
	Sun, 16 Mar 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122045; cv=none; b=japk8dOF+jQh/fbz9jRQiGZruBoGvpwSfUOLmac/d8bOPvqPruKpJRqJgtb+x3xN0vcjwDOyhiQOMFTFXmT3z5zdHwckus94jgpAD8Fsg/GRVvp8Iz3ub4MGtGPtFHIdH2vnS0oZB7TLE8U3Kwj5xwoUaPwuDh8tMvMXi7ys21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122045; c=relaxed/simple;
	bh=g40wBC/fXKGvRF2rw0eGFoa5DqIIeLqIPu1es6A+atI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hk/2PMSzvkHgiKkVgzbn8sSULwThFOSa6CaJ1x70fHHf6cBnuz1BtYJndhec1ZvHGsDH1JXG8R7DIpR98Nw03V2qHgYsQiy/JCXmwq/0GJEf+BC4W87LkqM9Gm59cfcy+okO/5VVtV2lg0YWnxCVm/5WrFUyLpL06BF+k/Jh3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Feyu6Kxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DCC4CEDD;
	Sun, 16 Mar 2025 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742122045;
	bh=g40wBC/fXKGvRF2rw0eGFoa5DqIIeLqIPu1es6A+atI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Feyu6Kxi3Kw/QCYXTp5ZXqIRXN1+vhtQthYJnnBBxZE6eMrJXk6eWRRtxdgmOS7iY
	 367Lw5FZX7TPwK+lkLsYXAnsrQNhnUPPLtbLqcMPDb947lUFxsRdd0wx/ZrAZywIDJ
	 qxNAbwyCjrNmymA8tRhasWBKCWHnt6sMKP27ur8fmSXJ2pPOJ8Mqwv5SWOMUuwZWOv
	 U/5VVyGYV0Xmxyz/r67BXzJzMXSMRu/4o1/naQvtV+mkMtZEeHfX46gp0o4FKA4HO2
	 PeI9VZqmEFw9a7ofVitgPhi36KN49GTCu0hVCoLxUI3GmC2snSATQoYQtjf6sPFfJm
	 IjXOmgc0cnKbg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499d2134e8so4052674e87.0;
        Sun, 16 Mar 2025 03:47:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFJN9he1ZiHKfYQEWstWC+G4LML3awiMTJoXPcrjsSjArOJKKVlxhv8PDItjZ9NSKKJMJqzCh8WbTC@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgI+wV8DAx6u803sfgLO5xqn6JcjNJgEdSkRP9w3qUoyNvKEy
	PVY03ejUpzz8birSVSPKw1KfPTimrYXcLqkPQOiVk9HjgUtRUE7p0TVtUgkoQP9L1JKWssNNDrt
	VBzazRs1G9ONvXPhgHFiZl8/oX2o=
X-Google-Smtp-Source: AGHT+IGpE1HVrrNt51l7Ch0DU/040+/i124fZpEgpME/sPck0xr8EQPFkz90zJ8JTmqNGB6wZb5au3VXOWdtsbBf2PY=
X-Received: by 2002:a05:6512:400c:b0:549:8fd0:b44c with SMTP id
 2adb3069b0e04-549c3986cb5mr3069815e87.49.1742122043675; Sun, 16 Mar 2025
 03:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222003057.2582425-1-masahiroy@kernel.org>
In-Reply-To: <20241222003057.2582425-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 16 Mar 2025 19:46:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbG6ay_O3Go=gze6AA1ZiUCLDuH86bLs=EejpxyDkVgw@mail.gmail.com>
X-Gm-Features: AQ5f1JrlC2IrFQmw24DxLo6ebUP8bME5ReQdE0msNewCnsczWHLUkxfPbDV-wWE
Message-ID: <CAK7LNARbG6ay_O3Go=gze6AA1ZiUCLDuH86bLs=EejpxyDkVgw@mail.gmail.com>
Subject: Re: [PATCH] nios2: migrate to the generic rule for built-in DTB
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 9:31=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
> DTBs") introduced generic support for built-in DTBs.
>
> Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.
>
> To keep consistency across architectures, this commit also renames
> CONFIG_NIOS2_DTB_SOURCE_BOOL to CONFIG_BUILTIN_DTB, and
> CONFIG_NIOS2_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Ping?


--=20
Best Regards
Masahiro Yamada

