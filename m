Return-Path: <linux-kernel+bounces-429429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF079E1BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A372821A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9231E47DE;
	Tue,  3 Dec 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkKRXHfp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4FA4F218;
	Tue,  3 Dec 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228325; cv=none; b=QuZ5YovObABJg3/kKOcjgAodvynPEpo/4Tp/NU6ODE7VGFYR3uUOaEL+wwodgauXKG5GNjb0+NjK2V/kGt9drq3eIQgX/cw3E7T25MaPAm6hR/pSWVLCe+poCyqXDTjpc5JPXxRI5+g1uBj83ZkmS4p4KDCF8NzH5wnce+AW3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228325; c=relaxed/simple;
	bh=IEtpKOaFTNjK4bo/3qCtbbXfWyGOChEHYH6Pc2ZfG2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5jWnMDqdb/PQsBZm0bWbOZOd6YtTVUABSqQ/caHIIn+byHGqHU7iSsz1bJbmd8jMei6MITPeeOWeTr8aqPC/SKmMCAsPQjk9iLkEEjeBfnoE2Nl9/nQL3XxKwGncWpC3NwJpQ2w4yXeY2l4K7QKbXbqqC3w5bvNo35rYWpXmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkKRXHfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AFBC4CECF;
	Tue,  3 Dec 2024 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733228325;
	bh=IEtpKOaFTNjK4bo/3qCtbbXfWyGOChEHYH6Pc2ZfG2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VkKRXHfpGU9lQpEUTyPA4wwKD+7pb6cX+nCRssjT7tViAi+XrfMbWeVHP3/qIn4nu
	 uATX5WESQIyruzZZ40JVQWrokQU8Bq2g/SKKPEqR4wm9YdXhgMpx34d9WxzTQpDtA4
	 3oEEc58NlRjDKTBsV+oDoLCHpqytjw4JjCWdN9rvm4bbQwIDlooCULFl1ZSbemfJfE
	 6oOjOoHXieUrgo6AVAsWFVoxqFkgEoNZyktOxMCamPq5l7Aw5KP3o5O2GQkQhyXcCv
	 ptW59TlXfcy882dXBtvoJADOOhsYgKmTQCqpWsFE0xwG4QBFipU7xpgubPIWRfc85s
	 gdWZh6VoU5wNg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, bjorn@rivosinc.com, puranjay12@gmail.com,
 alexghiti@rivosinc.com, yongxuan.wang@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
 eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
 samuel.holland@sifive.com
Subject: Re: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt
 improvements
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Date: Tue, 03 Dec 2024 13:18:41 +0100
Message-ID: <87ldwxot7i.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy!

"atomic" spelling in the Subject line.

Andy Chiu <andybnac@gmail.com> writes:

> Changes in v3:
> - Add a fix tag for patch 1
> - Add a data fence before sending out remote fence.i (6)
> - Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace-v=
4-v2-0-1e5f4cb1f049@sifive.com/

Hmm, the fixes tag was not included.

Also, there was a lot of comments from v2 that was not addressed:

 * Minor spelling nits
 * Breaking DIRECT_CALL, and include Puranjay's CALL_OPS work in the
   same series for DIRECT_CALL, to avoid breakage.

I'll have a look at the barriers (which came up at plumbers)!


Cheers,
Bj=C3=B6rn

