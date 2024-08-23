Return-Path: <linux-kernel+bounces-298089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A8095C1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC21C22BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC60A21;
	Fri, 23 Aug 2024 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTVZz4YE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB117C;
	Fri, 23 Aug 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371527; cv=none; b=D2Uwh4Hw3FcbAHPR5syVCrx8/0XJHSf3vuTu3dow05xHpFHsmygp2bGHUBkOaAQgcObvKPa2FwoXy91azHiMCHSKgh/5kOY5JenmtlpjNrUlkZy/G5Cueo0NvTQdHzFFO4hERGiMb+v8ncqZDwT824QUWSoWS7+1TzQ6SSUNYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371527; c=relaxed/simple;
	bh=aVeJe/7KLuyfzsfAXhhlrtTjGT4oThY97aPYWYhQF0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQzrI+PEhoFjdHHbfvNQlsTiqMrjaeIDh2WZIST8Ry9DSCD0QUhyHhWd3+nKbnY6/HWuNWCxWGT6vgQIpRjyYBZAA6W42Hlt3zW3VVFhyvmSoSG+gx3NXp5HW+J+nIdBp4LUp+r77YD9BFgLICM1wxP5osw57rxEAxu2h7zAXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTVZz4YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CBFC32782;
	Fri, 23 Aug 2024 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371526;
	bh=aVeJe/7KLuyfzsfAXhhlrtTjGT4oThY97aPYWYhQF0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTVZz4YEPR8OkLTX3s51yozSUOWo5LbCs2D16ppX7+fj+iG2YuA+B87To7r58lA/k
	 9OIjL+7Ux/j4+/3EoQknaz11d+/CkSau4jgiimojc0cVPUCcXrxTCQVc6kYDk44Ivp
	 ZEauXX+xUq6LPl0VYYGRbw9Tkv2VYowwFtRp1pxfwP1lCPUWuFtKn/B+zAr2MSG+Hu
	 gGnbm+EGaK1Z4bfr1fYnmLadDrsTz4tAVCSv4R04rhdtkpSzV4Jkrr082CrxmEjp5f
	 0717RoIpRCOyxcCHFkNQdFYcEV6FYdgAoWol+bwdzMlvGuzPYbKH4eEahkxcqhhZbp
	 rK6ghTimYPnCQ==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-sparse@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] string: Check for "nonstring" attribute on strscpy() arguments
Date: Thu, 22 Aug 2024 17:05:22 -0700
Message-Id: <172437152070.4121900.7735546714762971895.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805214340.work.339-kees@kernel.org>
References: <20240805214340.work.339-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 05 Aug 2024 14:43:44 -0700, Kees Cook wrote:
> GCC already checks for arguments that are marked with the "nonstring"[1]
> attribute when used on standard C String API functions (e.g. strcpy). Gain
> this compile-time checking also for the kernel's primary string copying
> function, strscpy().
> 
> Note that Clang has neither "nonstring" nor __builtin_has_attribute().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] string: Check for "nonstring" attribute on strscpy() arguments
      https://git.kernel.org/kees/c/559048d156ff

Take care,

-- 
Kees Cook


