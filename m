Return-Path: <linux-kernel+bounces-429403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B542B9E1BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB1028262C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21C1E490B;
	Tue,  3 Dec 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLzgSAxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B791E47C2;
	Tue,  3 Dec 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227536; cv=none; b=o4+HJ6ORgjp0A8uIDH/qvqLyxBeSdqA4MckDKcVxZNRSquZ3H1HIEAX/wcNaDu5RY5Cxhw1J6NW4S8abBlDtbm6zdC23kLcTnDM350+E862uRYQOvH8I9MRRwBcT3mzS5heabyywNtXuVfCl7d4CKclpzpVCGpF+7Ohb3gxobzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227536; c=relaxed/simple;
	bh=XZL3EXcmYT1TBAIqC6Hq3AdX/PAarjlqzMpxn3DIAfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qaQZx1n+80qZ+/BBbPHvmYKvbNoYfFHqBYaBH+O2oIjZlKEZw3PgrzMGHA+LZ2PHyg0YJxJgUI6Q6G0YSgMSDP+V/6AdUr3N0EDZVS75K04I+70UATo7o5L71BQNqXWhH9k0J586Nw83Hby3R3QZwWvZxrTcdCFj65fIMsqFfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLzgSAxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC7C4CECF;
	Tue,  3 Dec 2024 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733227534;
	bh=XZL3EXcmYT1TBAIqC6Hq3AdX/PAarjlqzMpxn3DIAfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MLzgSAxoTaW3EsaOzZnGZ2LWvOEy3OwzJbnEqiOIgebxkSDHx+YaRme+b+h1s/2u3
	 EKVRL/eafvWSGKuS2DKduFZUgP+RrNqnAbAwucO89XIIdxMYW2pfQ3cYNO7+WUm+Ib
	 DeM/BO5i60VT7Osreuz5qV0ni9n7kT4W7k0mlm0HPI01LXIuIv7wADPdMqgBb5eoql
	 krFBvEOeRZHeU3Em2cg8WXhc3g3iQ/XFJT83Qb4wvATAwLhLn8yR83jnB+nViGu4pD
	 cxmwUy3kHMqBgbHEKyad9fJhR5qwYyCxFYPpxzONzdCS/Gbe7MTeNY+NCGa13U10pW
	 qM9Q56CkL6CLA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev, bjorn@rivosinc.com,
 puranjay12@gmail.com, alexghiti@rivosinc.com, yongxuan.wang@sifive.com,
 greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com,
 tommy.wu@sifive.com, eric.lin@sifive.com, viccent.chen@sifive.com,
 zong.li@sifive.com, samuel.holland@sifive.com
Subject: Re: [PATCH v3 1/7] riscv: ftrace: support fastcc in Clang for
 WITH_ARGS
In-Reply-To: <20241127172908.17149-2-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-2-andybnac@gmail.com>
Date: Tue, 03 Dec 2024 13:05:30 +0100
Message-ID: <87wmghotth.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andybnac@gmail.com> writes:

> From: Andy Chiu <andy.chiu@sifive.com>
>
> Some caller-saved registers which are not defined as function arguments
> in the ABI can still be passed as arguments when the kernel is compiled
> with Clang. As a result, we must save and restore those registers to
> prevent ftrace from clobbering them.
>
> - [1]: https://reviews.llvm.org/D68559
>
> Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a91=
99c45b1@yadro.com/
> Acked-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

Fixes tag?

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

