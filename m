Return-Path: <linux-kernel+bounces-372015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04BF9A434F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92CA2875A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC88202F6B;
	Fri, 18 Oct 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F04ZqbFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFE133987
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267737; cv=none; b=KbunKYjZhz0ojQ1vC9KNS4a9Kna0rNyRCS0Lrla9ekCOqnTX/qbj+1C5M6cv0mJ+EBw1irxKd52cVxWxnAx7qcdL+eliwuawxkzo+fC4WLNzzik0w5x4vLXyrG973G/qoiXRY+0nwqzEHkFVZRMcQsdLkB2/b39k1uSz7xgBoms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267737; c=relaxed/simple;
	bh=gKvZwiinxwX6XlGGY/ed7b7TYRPyHmq5Pq1h/RGtNuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhQWEC/4Po+MySqgZeKmSDop9XoFzC0s5sn+subWF8jnQENeJR2M+rSxvehRyVLD0yRK5cusFGOBkzbGt10sMYJK6YQni/EAwC1fLEG2YLC2BFWKaRg5sbm/wdilzoZxB7H/xsNCu1YqJMyuGvU42h7K305S+SWdxSnqu82wfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F04ZqbFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5457C4CEC5;
	Fri, 18 Oct 2024 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267736;
	bh=gKvZwiinxwX6XlGGY/ed7b7TYRPyHmq5Pq1h/RGtNuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F04ZqbFgpYzuM41cnwRfPX3G+eaf2x0sbu7fi0BZN/l2Gg3NFheSzzkOL31cvTci4
	 crAc3ft7+bGyYFn0AgDDUt/alynxZtA281WYRO8woJvJsw50hsA6+65AxGLqc9AVTn
	 Z14q54q4puV/Z/0g3Oyj8j+rT4Nz3UILDTFX3RulfSKTMhslMPlBlCdGXj+a1Jd3/h
	 WsiJuwWxg4fl1MSSNsi1+G5amftothj2YVAKgXoVVAowbg4lOXhfHB0V5NT+pLkeWG
	 44H5vPmr95dQ/lPkbXhitKk++ekTiy2sBmfEw65LNquOJKLBuzy4Ws11DoQmCSqrJ1
	 ly5A9Yaa8NkGw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use str_on_off() helper function in report_meminit()
Date: Fri, 18 Oct 2024 19:08:42 +0300
Message-ID: <172926766252.1788036.5825981783630801187.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018103150.96824-2-thorsten.blum@linux.dev>
References: <20241018103150.96824-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Oct 2024 12:31:51 +0200, Thorsten Blum wrote:
> Remove hard-coded strings by using the helper function str_on_off().
> 
> 

Applied to for-next branch of memblock.git tree, thanks!

[1/1] mm: Use str_on_off() helper function in report_meminit()
      commit: 4bb21dbb6728fbe6cb7e2f7dc7e5388962c4125b

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.


