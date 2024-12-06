Return-Path: <linux-kernel+bounces-434628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A49E6923
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A81884B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088FB1DF274;
	Fri,  6 Dec 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUpjGa34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F31DACA8;
	Fri,  6 Dec 2024 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474368; cv=none; b=l+3b5te9ReC14ZEF7lj1KEUMhh3kc9bBp+P1fRV6NT7lwp2nQc4z5QGH50fN5FulTjQ72YLo8cO6BERa3DlKlaz34MVVzxBbt2miWM/BXl830Ct6BSXYuL/qa7BTD7Db6xYnebwkSf1nrh9dmUQg/7Rpq+jVSkRf3IU+qf7UHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474368; c=relaxed/simple;
	bh=IG0P5Es82HkdWekjNgM95k8o0xWoTGSEHqiHERM+RmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NX6Og/8AgtTSwN6VRBuDIs2HpEFhS7JzFtVbl99ASO+un1hsFYzp9c3l+vWCk5Cj66EW9agH1VK/Gz7dCMUqRRusEfAW24NP5FKtzwQ31t9I+cWU4Z/NgfTqTyusy6tiLU0acza9RilnvhAx+LFKE3zs5UED3d2igWfFqzUUVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUpjGa34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADA5C4CED1;
	Fri,  6 Dec 2024 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733474366;
	bh=IG0P5Es82HkdWekjNgM95k8o0xWoTGSEHqiHERM+RmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EUpjGa34wpQRVGU4ztNhbAfwSEaPX+pHiUAW1W2tKjoZldksIl4hEwxF1iz13QShs
	 NBW7Gt99m0rHp8mOI1cqhhsUzck9pOinr/cqv7PWrQY438tXj7WiQXrPrBObp8ZD2K
	 X4jO20ME+DbXqk8IMJTqnVDXV/UquCL7vRU4DxPr3DOh0ap5QwW2IxXDmSzinXQnB2
	 NhL6HWASxtPZOG73WrzYRLsOW9oAklZ0WCHp7G7bDUcA+7bLMBRotIhdIqCheeKQsS
	 oD4pWSlOk3h4spx/mLEdtgy9v0j9GTRmxelvQ17hhW1otA7w22EuLp9PfWcf0uoe6i
	 ELtCvmbnMiTmg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Evgenii Shatokhin <e.shatokhin@yadro.com>, Andy Chiu <andybnac@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor
 <nathan@kernel.org>, Justin Stitt <justinstitt@google.com>, Bill Wendling
 <morbo@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, bjorn@rivosinc.com, puranjay12@gmail.com,
 alexghiti@rivosinc.com, yongxuan.wang@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
 eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
 samuel.holland@sifive.com
Subject: Re: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt
 improvements
In-Reply-To: <990b942d-fe91-4bda-a38e-1eb47f2f6086@yadro.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <87ldwxot7i.fsf@all.your.base.are.belong.to.us>
 <990b942d-fe91-4bda-a38e-1eb47f2f6086@yadro.com>
Date: Fri, 06 Dec 2024 09:39:23 +0100
Message-ID: <87a5d9gq84.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Evgenii Shatokhin <e.shatokhin@yadro.com> writes:

> On 03.12.2024 15:18, Bj=C3=B6rn T=C3=B6pel wrote:
>> Andy!
>>=20
>> "atomic" spelling in the Subject line.
>>=20
>> Andy Chiu <andybnac@gmail.com> writes:
>>=20
>>> Changes in v3:
>>> - Add a fix tag for patch 1
>>> - Add a data fence before sending out remote fence.i (6)
>>> - Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace=
-v4-v2-0-1e5f4cb1f049@sifive.com/
>>=20
>> Hmm, the fixes tag was not included.
>>=20
>> Also, there was a lot of comments from v2 that was not addressed:
>>=20
>>   * Minor spelling nits
>>   * Breaking DIRECT_CALL, and include Puranjay's CALL_OPS work in the
>>     same series for DIRECT_CALL, to avoid breakage.
>
> Yes, FTRACE_WITH_DIRECT_CALLS is currently broken. If I try to insmod=20
> samples/ftrace/ftrace-direct.ko, it reports a failure:
>
>
> [  179.531472] ------------[ ftrace bug ]------------
> [  179.531761] ftrace failed to modify
> [  179.531786] [<ffffffff8005f9ac>] wake_up_process+0x0/0x24
> [  179.532577]  actual:   97:e2:fa:ff:13:00:00:00
> [  179.533211] Setting ftrace call site to call ftrace function
> [  179.534409] ftrace record flags: 99980001
> [  179.534692]  (1)     tramp: ftrace_caller+0x0/0x34=20
> (call_direct_funcs+0x0/0x14)
> [  179.534692]  expected tramp: ffffffff01b0d000
> ...

And just a regular Ubuntu 24.10 will fail with all subsystems using BPF
trampoline, e.g.
 ------------[ ftrace bug ]------------
 ftrace failed to modify
 [<ffffffff80250d98>] bpf_lsm_file_open+0x0/0x1c

CALL_OPS with definitely a must for this series.


Bj=C3=B6rn


