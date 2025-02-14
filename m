Return-Path: <linux-kernel+bounces-514604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC0A35938
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B233ADCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA68227BA1;
	Fri, 14 Feb 2025 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA0VQYQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE7227B8C;
	Fri, 14 Feb 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522658; cv=none; b=Nl1VYLTXeoaZH/TKMWQNi2a5TRI8v4YhbtOIn+zcClPn1wMQcvC4grAtEUgOgiXVyEHpm0RbZLmi8adz6hQt7tnSFeG0fF/ESlY/3Zy6cmYd1PU5TM+80mVQDkJLmWE67b/RggYVAMvEY/y7VQs700UFI8uVunSWALhGjFeANSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522658; c=relaxed/simple;
	bh=h0l9qNYhLpyFcQYKUrxPtG9pbn4eT0oRT7VAINBKXaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLfgIY2C38Pmnxc78D13VGlf2aR6xJexH4fKMgJa5Dz6XocjCT6xRfrfDDWHM3mrNKMGTznRPN3t2EgaKIpP3KJHl5l+OuoBntBxxw3k3rXqiVSEV3JR43s+yOGA3PlQ6taUeLfyVIVPWLLG8Sod5JCbLXPx2dkBmtqGExK21CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA0VQYQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B25AC4CED1;
	Fri, 14 Feb 2025 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739522657;
	bh=h0l9qNYhLpyFcQYKUrxPtG9pbn4eT0oRT7VAINBKXaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QA0VQYQkj3qvQvSDwfvAE2ksS4/w3nsFqd6TQJy9Vo2Bt3NmCtY3XYHbILwlXQFGd
	 Az/5YaGuRo1BWAZI/6svd3HC5W511UirbgjNUdrbJ+zMeUxjCtio7s83S3f6WjRDdv
	 gAseW/sYYKI+0Jbn9eiI1ccL5tZME81JFQg0/gt1gpP3XKVkIzpx+qcPGNp1GQ2F01
	 k6JOmamz0hP/1HxR9+mfDKVC2QLKs8lpb4hlXnZV1G9qSn/qAdty5M3bVaZmJPdY0Q
	 8idfC8Hy4I+bAOkbtUa9V/4AbdAij4NKk94DCcRHRCYo1nALooPXJNysK6jRpwqNzU
	 9vTKPn+B3qYiQ==
Date: Fri, 14 Feb 2025 00:44:15 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
Message-ID: <20250214084415.yrffvbop2f6z3du3@jpoimboe>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
 <20250212175023.rsxsw7pno57gsxps@jpoimboe>
 <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>
 <20250213023936.lzbpgou4eallaij3@jpoimboe>
 <045d7e22-672c-b9da-38d6-8897e854f262@loongson.cn>
 <20250213185408.m5aogf2trvhvi2td@jpoimboe>
 <439175dc-caf0-3d38-89ba-ade5a364c9bb@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <439175dc-caf0-3d38-89ba-ade5a364c9bb@loongson.cn>

On Fri, Feb 14, 2025 at 10:23:08AM +0800, Tiezhu Yang wrote:
> I have a draft diff, I will do more test and send it
> as a formal patch once the other patches are landed
> because this patch depends on them.

Actually since this is a bug fix, I'm thinking it should be merged in
the tip/objtool/urgent branch so it can go in an -rc.  Then it should be
trivial for me to rebase your patches on top.

> The code looks something like this:

Looks good to me.  nit: loongarch can use the C_JUMP_TABLE_SECTION
define.

-- 
Josh

