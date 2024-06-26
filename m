Return-Path: <linux-kernel+bounces-231613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E5919ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D1C1F2218A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77E194094;
	Wed, 26 Jun 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DyD8Z7Zu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74120181B80;
	Wed, 26 Jun 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442237; cv=none; b=lZspPKPN7yPzmBjouWZpVFSxNLZezrtiq+QwYdKbRyQNeJhP2dyu7UwG0ofAQBXV2ELOKU+zMi3H/vngliye+S2pSw1DNE2hFl1QYHQdiO5HkP35BUI7GwBq4jTNUG+EysPDxvXj/yUZs8T8100E0Px6vQNtaHCIrAVy0cQLj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442237; c=relaxed/simple;
	bh=lLWM+nqCDaVV7u4KKuLXESgb2ZWrrwr0cBeW2yd+fcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFcKLMnVk0GS8o0SDiGodlzLRFkzELrJfi5ZOY0zYRhpere4qMD2sP0TbzHrDrKR2sPtiRVl0BqjctNGd971RYJOam1qYDmLBjVIxwsdgapDn6bgO06y2JuhlI+pU2XYqgwR6fyZ252Mnz6SPwDermnwQKGnw2SSiSEEL8G5bD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DyD8Z7Zu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 50DEE45E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719442234; bh=2ZvlwGGbdDD9XRK+WhZh+8iY+TV6ABdXMrHDCASGyQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DyD8Z7Zuu0Gie2z3t425/sBGFg/gJNXiyvc+IHv4H/lDuoqgwPHZPq+mAKIQynIQy
	 Ly6zpJG0uhLeLiP01wTqnf06Zp9+7mesdaZqnrCxC+4U3+flHhkEYDkj2NkhsidyiP
	 YHX6/hYCvdMWhMkZgyrnWhYe2PQOFxu+8nHhB+REYQM3WrsvS+1n82fB6KBXRx0lsS
	 ilK7r/Gp3jDnH/3hof1HQc9nZtuaOytdGdHX0qlTj838oFxlKRkcIkXsNZlyOjLoi5
	 Z/A2Y6ELQedMglsdycbWe5LejMCTJdcgxCi+l3IKBzN9pEqJodIAe+HD4XhAnAftxx
	 53w7FHy7Kobzw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 50DEE45E2B;
	Wed, 26 Jun 2024 22:50:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SeongJae Park <sj@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Alex
 Shi <alexs@kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, Bill Wendling
 <morbo@google.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, Justin Stitt <justinstitt@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Yanteng Si
 <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 workflows@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] minor document fixups
In-Reply-To: <20240624185312.94537-1-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
Date: Wed, 26 Jun 2024 16:50:33 -0600
Message-ID: <87zfr7xqrq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SeongJae Park <sj@kernel.org> writes:

> This patch series is for minor document fixups.  First five patches
> clean up and remove 'Other material' section of process/index in favor
> of 'staging/' and better place for docs on the section.  A patch for
> adding DAMON maintainer-profile reference on maintainers' handbook
> follows.  And then the last patch adds 'hkml' as one of available email
> tools on email-clients document.
>
> SeongJae Park (7):
>   Docs/process/index: Remove unaligned-memory-access from 'Other
>     material'
>   Docs/process/index: Remove riscv/patch-acceptance from 'Other
>     material' section
>   Docs: Move magic-number from process to staging
>   Docs: Move clang-format from process/ to dev-tools/
>   Docs/process/index: Remove unsorted docs section
>   Docs/maintainer/maintainer-entry-profile: add DAMON maintainer profile
>   Docs/process/email-clients: Document HacKerMaiL
>
>  .clang-format                                         |  2 +-
>  Documentation/{process => dev-tools}/clang-format.rst |  0
>  Documentation/dev-tools/index.rst                     |  1 +
>  Documentation/maintainer/maintainer-entry-profile.rst |  1 +
>  Documentation/process/4.Coding.rst                    |  2 +-
>  Documentation/process/coding-style.rst                |  2 +-
>  Documentation/process/email-clients.rst               |  9 +++++++++
>  Documentation/process/index.rst                       | 11 -----------
>  Documentation/staging/index.rst                       |  1 +
>  Documentation/{process => staging}/magic-number.rst   |  0
>  .../translations/it_IT/process/clang-format.rst       |  2 +-
>  .../translations/it_IT/process/magic-number.rst       |  2 +-
>  .../translations/sp_SP/process/coding-style.rst       |  2 +-
>  .../translations/sp_SP/process/magic-number.rst       |  2 +-
>  Documentation/translations/zh_CN/process/4.Coding.rst |  2 +-
>  .../translations/zh_CN/process/coding-style.rst       |  2 +-
>  .../translations/zh_CN/process/magic-number.rst       |  2 +-
>  Documentation/translations/zh_TW/process/4.Coding.rst |  2 +-
>  .../translations/zh_TW/process/coding-style.rst       |  2 +-
>  .../translations/zh_TW/process/magic-number.rst       |  2 +-
>  20 files changed, 25 insertions(+), 24 deletions(-)
>  rename Documentation/{process => dev-tools}/clang-format.rst (100%)
>  rename Documentation/{process => staging}/magic-number.rst (100%)

Series applied, thanks.

jon

