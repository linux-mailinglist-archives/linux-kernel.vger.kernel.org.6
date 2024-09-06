Return-Path: <linux-kernel+bounces-318821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A67896F3BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F201C24508
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C81CC897;
	Fri,  6 Sep 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MnZBcpCk"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFB17C9B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623733; cv=none; b=oSU0FsNKGN/V/rTID8mrj2UinCwY2a+lDH4PKrrsLIf6G3pnVaUkZhPN2cRvJ+L4amFnOqKTG4Rn7Lp47iJXEvWEEguWQot+M9cXuBMpKf15X1bxS6EaLkhhi5KrFgAtdQNYHTb3lo15aru53uMdzWvJ5UpiwoV5QstQq9XJI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623733; c=relaxed/simple;
	bh=7zJd8pqsGbtorV2RA9SGRcvUEjR+eD3Dxzhd3Hx/9aE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aez2lPdcdQky/0KHHCpeD2OzNtFzW3gMPkD/xqQdIL2qSjmT7VvB6iYxryzUFSe+Y98iEKHoETlbOPH8xG75SyYp5ZkJ8nigRKvGU88G3PQB7H7urjOnoqT7+KO9jGvpsF4vVWq/pUK+u2SX/40W/kzguMgeOhZRBszn/wPUfyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MnZBcpCk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725623730;
	bh=D4Tr3xq01QTABI4MGDDJgIWKSI4WtSOuzrdByLrAR/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MnZBcpCko69YZN85FnTOGIbw5GEuf6Qco7BMs7ynvKVa2dOPSQuCl+uCN4rO5XwcP
	 rlV37HMCXYfMYMIrB0fQa+25ienTlCphVdiyiFymWa3x40EPqK2ElAgVFpOYhXaH80
	 /JB6jtLO3TgzrupFrSxQhwGBRUsnTwwLqBHdSv1CWLL6huCR0IRBisTA8KWidfOFoS
	 BnQ9xsytS2Vb/ihFAhkIsmkVv9X+pM93ayOH+n8P+KR1xe+rG9HxZ93t0hxkTVN58P
	 nV+ZYfUVVlIkHVpGir8Lz84/osUjNKAX5JfPLH5uJbXj/UA5lKFd/x9Gj+B/aoXWO5
	 LDa2sptqW/hEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0ZRk3C0Jz4wy9;
	Fri,  6 Sep 2024 21:55:30 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <0fa863f2f69b2ca4094ae066fcf1430fb31110c9.1724313540.git.christophe.leroy@csgroup.eu>
References: <0fa863f2f69b2ca4094ae066fcf1430fb31110c9.1724313540.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/vdso: Inconditionally use CFUNC macro
Message-Id: <172562357203.467568.1789157792030341503.b4-ty@ellerman.id.au>
Date: Fri, 06 Sep 2024 21:52:52 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 10:00:29 +0200, Christophe Leroy wrote:
> During merge of commit 4e991e3c16a3 ("powerpc: add CFUNC assembly
> label annotation") a fallback version of CFUNC macro was added at
> the last minute, so it can be used inconditionally.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/vdso: Inconditionally use CFUNC macro
      https://git.kernel.org/powerpc/c/65948b0e716a47382731889ee6bbb18642b8b003

cheers

