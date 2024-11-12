Return-Path: <linux-kernel+bounces-405764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14D9C57FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6356B2F64E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D123099B;
	Tue, 12 Nov 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+jFAjy5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5436230989
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411415; cv=none; b=s0X3NidoP7nenrtL9gC/j9zZxkklFia8kAbE4W47ktkDZNMJ4XDv7WTeTW85ERgJoswOQGLPuNq8IQ0587TWu0fLR8WpaB8fU/tORN8sidcQFjfpHMy4Q1PjdK8Fm0fepTdU2WBOaSyC3ph6paf7cAtJ/iuJ7LuavlpKWWamTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411415; c=relaxed/simple;
	bh=+50FJGKdMdt7/QBZZo9VkQ5mGbZlOo68kDdHC+pjOa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bWNc/SRShNRW6s5V7y2w9r9XpZDgfXIf1h1/zPFxyyHIkTjwjFPfjedTIwhN3MzwNqj1Dg2yHUqkXuCSc+PkJOHltYck44x4EZEijl2d1MHDoaDaDJRflJKFVitE63lOZZl1voRV+U4mS351RhQ5LjwfkUObXM8yUEF6u5SWg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+jFAjy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0539BC4CECD;
	Tue, 12 Nov 2024 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731411415;
	bh=+50FJGKdMdt7/QBZZo9VkQ5mGbZlOo68kDdHC+pjOa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T+jFAjy52Z8t8R5fvwoK+XP6rKli9GFcPqJA38QvFmbllvWaJNkLV+ryiioUi8csq
	 LDr5ctH6/dxkIehO0px6gixHtAdIduiNObraFQPQ8bbOREjhhR0YZRp99dxNDUz7Mc
	 vLtS6pJnK2oKgMagVZwPXWo9s0pRPAmp1+dexz+aY/9rgky/hbq1jj1mKzGte+QyJS
	 +2vmrffmodqalD+QMGHRlz0iW1C0zu1/3MCUmLd2AAIvYYX1Sl2I5rbAioHJHMkbwj
	 oM3PQjwLSdjEsw9e2u6feWrAR8ci6xd7aYSmRtkm7g2p/sRRF5dGEWcJSnpuNIu8ze
	 Zp6cHHT0VMCcg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andreas Schwab <schwab@suse.de>, Alexandre Ghiti <alex@ghiti.fr>, Palmer
 Dabbelt <palmer@dabbelt.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-riscv@lists.infradead.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: add forwarding header for
 arch/riscv/include/asm/fence.h
In-Reply-To: <mvmbjymxdsc.fsf@suse.de>
References: <mvm5xq44bqh.fsf@suse.de>
 <d380fd10-ebc4-4d66-becb-13995372d41a@ghiti.fr> <mvmfrnyxg2n.fsf@suse.de>
 <26452229-7461-48aa-987a-28444ace4f28@ghiti.fr> <mvmbjymxdsc.fsf@suse.de>
Date: Tue, 12 Nov 2024 12:36:51 +0100
Message-ID: <87h68cu1ik.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Schwab <schwab@suse.de> writes:

> On Nov 11 2024, Alexandre Ghiti wrote:
>
>> Indeed, Bjorn's patches did not make it into rc7...
>
> That needs to be fixed ASAP!

Ok, if we want to unbreak the tools builds, two series are required for
6.12.

[1] which addresses the asm/fence.h path issue
[2] which addresses the same issue, but for non-cross builds

[2] can be pulled to RISC-V fixes, but [1] reside in the bpf-next tree
(target 6.13). Details here: [3].

To reiterate what I asked Andrii, but for RISC-V fixes: Would it be
possible to pull these patches [2] into the RISC-V tree, having a
duplicate set in bpf-next? Or are we stuck with stable backporting, as
Andrii suggests?


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/20240927131355.350918-1-bjorn@kerne=
l.org/
[2] https://lore.kernel.org/linux-riscv/20241106193208.290067-1-bjorn@kerne=
l.org/
[3] https://lore.kernel.org/linux-riscv/CAEf4BzZbq9OwSGi4pdb5_q8YkErfFiQFKY=
Xg3g1rjpdejafx+Q@mail.gmail.com/

