Return-Path: <linux-kernel+bounces-566258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A4A6758F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319C83BC592
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5220C00C;
	Tue, 18 Mar 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYok27mC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031102628D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305774; cv=none; b=HK8Rs3+nX1cU/DK4uF1BT/zdi0WzU2pcRqIFvNs7anTHXlYl0Uhur5Eah4g7hQ0SrabhrPAlb983nsd37kn5wlfFgw+J31CoewrqNq7wAEf+JN6N/u1AOrfBAhDHeSARAAb6JGIYTW1qZw6Hro9pUXzTGx0OM4jpiRDKkweXHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305774; c=relaxed/simple;
	bh=1zucnD3tEe4wYl4tSlGXF5mjHYT1yVy/S6vsQstc4bQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RleAD3G/zuiQ0d6L/+0EmZ52n4w71kVqbcpMolYI/csQjxToQJOuErNP+zRRhVZ8ZTdNMJnmeA7JJT451GGEuj7fw+iQDue9P5Q5dediTvdHb/iCLLP9jdYgX6fd4Fb5J25VCxTBN45YH++LBmZqOAzpM7QghmSn54TFaJHRbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYok27mC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B49C4CEDD;
	Tue, 18 Mar 2025 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742305773;
	bh=1zucnD3tEe4wYl4tSlGXF5mjHYT1yVy/S6vsQstc4bQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eYok27mCmKGPT3OGy2YkfT9Qa8p73nscU5+GUAezalD2u4mo7NmmYtRrun5uB5R2D
	 WNzdXo1Nyx3xPFj8tTiH/FjOaqtNYjGn6bau2xz3FHDTCoe5SeuRQF7vZJ8LYEtPxE
	 mMx/7yh9nqUeb+nleXQgfXPkfL0PdI1/5Z/7BK9SRartn9O/2BrJ5Yt//DKqdF4Ct4
	 yatzSznfspSLVEHEkntaNn+Vb2WTm/v3XXKj5V1/4NTRteR83bIf44HBBuVGbpQ0OM
	 AMCIIDhwl7i7TFhGNMn8gULKGoDJ1qM5kjtXvtuaC+NE7FxMXbsyDwu8X1wNCdQT6J
	 2szfLEkxrAcCQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH v2 1/2] riscv: fgraph: Select HAVE_FUNCTION_GRAPH_TRACER
 depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
In-Reply-To: <20250317031214.4138436-1-pulehui@huaweicloud.com>
References: <20250317031214.4138436-1-pulehui@huaweicloud.com>
Date: Tue, 18 Mar 2025 14:49:30 +0100
Message-ID: <87tt7q5tzp.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Currently, fgraph on riscv relies on the infrastructure of
> DYNAMIC_FTRACE_WITH_ARGS. However, DYNAMIC_FTRACE_WITH_ARGS may be
> turned off on riscv, which will cause the enabled fgraph to be abnormal.
> Therefore, let's select HAVE_FUNCTION_GRAPH_TRACER depends on
> HAVE_DYNAMIC_FTRACE_WITH_ARGS.
>
> Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503160820.dvqMpH0g-lkp@i=
ntel.com/
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

