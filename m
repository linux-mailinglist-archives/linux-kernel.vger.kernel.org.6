Return-Path: <linux-kernel+bounces-412091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F37B9D03CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A07B24476
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1331B21BF;
	Sun, 17 Nov 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iCfv/red"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D11ADFE4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846338; cv=none; b=s6MwybD9OvWhHjL2dwLpYRrQPKGGJU3KBlUwlmgkTtXm/IxbB3ZQB6hO5UllF0YXycbr4QKO6nczeMpbZwBJHYeMpxHk9vaBQZm/5JvBSgvLUNUbqpRasj9Qh88WkxJt2jAJLCU9Ly/u93tYV0G3mkFEwK4ZcW7yCGh2Vd27Hyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846338; c=relaxed/simple;
	bh=efUlmZwHh/jMF++7uXv/f2sKDeKuXuiwWigLCToiMoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2dlKGhlpgdpat1NjUPtu9ehVPNRAxZxZR0wUGXwnFMLxCoYQ26AsWz9I9kpb+PYElUGTw8ycXBv2y6GUj4Tt49VTj4c6/hSB/PvVzpMDUjVXISBKphXbgzxrfLcrEI3n8fBsVnLnmLMYCGMLkeHsGjvzkSRg4vi7r+i5eDLK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=iCfv/red; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846334;
	bh=i6DhGeGkGvC4VAr1zXIDNglBtiqEoiBLTPJdD8L8FBg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iCfv/redZINruq1CGLGirFkbQWXrREfAsn4I8yoa0MxIXuvbtDivFD5beaBn4TZiT
	 I8K6U9jexYhifBLeh2vM4y6unv9s2wewHgrdb/jdqjEEQgJWJGnEmLg9PF1uqfdEiM
	 ddEXjTmaxipXSvgo+ke+aism7VQCMSHIXysAJ8JIoi3b4oERD9xGReOusUIbKScQsr
	 /Mk9bhB9e/tgC2t0tbn0IhCEFDlSqSERbErko/bj26fwGPhn1Gkb+U3hACRID6uyN7
	 1KhS8RQAUXtacacNynSQus0i5IHipD0XifhTBfkT5rs8TrngGeK6ukyJ/PdPDws2qQ
	 hMW/fzDgRr5og==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj96v2mz4xf9;
	Sun, 17 Nov 2024 23:25:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: geoff@infradead.org, mpe@ellerman.id.au, Shen Lichuan <shenlichuan@vivo.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
In-Reply-To: <20240930023234.7457-1-shenlichuan@vivo.com>
References: <20240930023234.7457-1-shenlichuan@vivo.com>
Subject: Re: [PATCH v1] ps3: Correct some typos in comments
Message-Id: <173184539768.890800.1864207122324653089.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 10:32:34 +0800, Shen Lichuan wrote:
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> -in the code comments:
> drivers/ps3/ps3-lpm.c:94: rigths ==> rights
> drivers/ps3/ps3-sys-manager.c:365: acnowledge ==> acknowledge
> drivers/ps3/ps3-vuart.c:470: remaning ==> remaining
> drivers/ps3/ps3-vuart.c:471: transmision ==> transmission
> drivers/ps3/sys-manager-core.c:15: Staticly ==> Statically
> 
> [...]

Applied to powerpc/next.

[1/1] ps3: Correct some typos in comments
      https://git.kernel.org/powerpc/c/e9d3270007b13acd34de4256970ffe457efc6c65

cheers

