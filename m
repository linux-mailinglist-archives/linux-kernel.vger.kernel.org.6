Return-Path: <linux-kernel+bounces-178959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B808C59CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597801C2127A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31465339A0;
	Tue, 14 May 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/YTXGVP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F45365;
	Tue, 14 May 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704531; cv=none; b=kU0kGqsjKC/x7QRtkN+sMhCCXSGlTAY0ITV+bcAUumy3V/MCAZrTOyBtgi8Ne6ElTSGjY7C1cD3J2AQtaN+MXtf7HmuoH7hXorMheB9OIvPEonU5bGYq1wTIoUQREWl/a4i709rI1Jz6Twg5+zFBOj6ZmTreyX0SZAf/ryg4xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704531; c=relaxed/simple;
	bh=us5zpSDDttAqxfqYn77fWVvof2NUi1rtw7ubbf6Thog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pOQhCuA+jqQ9CUOcfRFjnHmyC5i4VzPilBewLNmEhqRMYkqZSBN9TTDy/+iI76KFnP+nSCAoUJXGQWubg8fPWTGEuY36n7cUpLHTj3UXglI0jnQyAdKqSasr+054AvxC6UmVzW240oAsmFj5dVMwVlKiNQG3xNfpH8Z/4fyJcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/YTXGVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF94C2BD10;
	Tue, 14 May 2024 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715704531;
	bh=us5zpSDDttAqxfqYn77fWVvof2NUi1rtw7ubbf6Thog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B/YTXGVPHZ1vLFHKQw+vkoJUiOGMjCNRCfln88lY7HEX6xwIMAPazPBVv+YlJ6Tsa
	 GbNHPWL+mRdCHJjZUA6/IHQPQwtp0T2TqFtkjGHFiwOmHrwjfgvSWhwDFP1eo8fp8v
	 vgCNqi90Zlq6BhJ06M7ghf0MTY5epDXuRsZMCWbq9+OR0g+4+6A67jDnqO24U2kAle
	 dcLtQ5hILwtkKZbgZtoM9BSdL0eTUWFGDyrqIklDYhxJBSbmF4CcA7YUE30lkp1P7m
	 j+7LUW/yGYHmd/6uufWg2DzEa6Qx5FFBU+lZN51Ay1KVnheTgVzRSj0qoJVfATUXtL
	 PiIrGyn3W3/yA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet
 <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH] riscv: Extend sv39 linear mapping max size to 128G
In-Reply-To: <20240514133614.87813-1-alexghiti@rivosinc.com>
References: <20240514133614.87813-1-alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 18:35:27 +0200
Message-ID: <87msostkq8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> This harmonizes all virtual addressing modes which can now all map
> (PGDIR_SIZE * PTRS_PER_PGD) / 4 of physical memory.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Nice!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

