Return-Path: <linux-kernel+bounces-415640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27399D3935
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4CD1F26DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91C19DF4F;
	Wed, 20 Nov 2024 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQWm92VY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CE17F7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101122; cv=none; b=UDFaQwYXm4zoJev2BOnxSjFXlMjFXMh4TMIOkowK8RWDn9sflz67fXMgRlTAOMpICSPbJnINymO/2G4kYgJfGqKq2SipKp+LWd6Pm+noj46IFkGV6vgkLXAykULnSutjzQAYpcYqOCiwSPabJvQ6FWTM7ZY+nSTxXmA18ScMp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101122; c=relaxed/simple;
	bh=h69bwaT1JWyhvxNrWac0bTEoYmUwTuVlZVpjh3UyqKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEBnKQ6XE7Yt1o76lmXxXVo/xZHkydW4VBzqm50s6x9vmJQZCc36QTApeACTQ2ffSPOYG09xlW9ezTJiEtGHMOnSq7I7y+1QohUAwhRzZDQt3qe6F8R5CodEhxoax+vBFc0hL1tnBVgIXGg9WXvKrvdsgnLPktYbAI7LBnKFubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQWm92VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9E8C4CECD;
	Wed, 20 Nov 2024 11:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732101121;
	bh=h69bwaT1JWyhvxNrWac0bTEoYmUwTuVlZVpjh3UyqKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQWm92VY1kCxxdVu/QrA/94hnV1/i2JAy2YBgx88A5D8nv4az5YmcVUMcuOq27TZG
	 7dCFV+7uLijGYEWBk0UsKYKGk0XuuR0B5kaawVUWRHx88uVnBAbeFZdJ6l51K/Msjp
	 bHugEffU+LKaM8SOU8G7I6wLtqnw1eHfqLHL9rySWMOfDpLj+kmM4UylPMylyY6ZbN
	 J2hRP0N/dZzsRVnUM15QUzLap13WaItrEtJJ0BAeclHUBgODJTp3XhahYWkv6YxM0M
	 spUIS14V2n3h5UmWKdFCU3uzrhU0k+NHMkK5FttlxzWoqlCmKEJGcrGuTIFSrFSWtz
	 jBNsk+jqGdU5g==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org
Subject: Re: [PATCH] seqlock: annotate spinning as unlikely() in __read_seqcount_begin
Date: Wed, 20 Nov 2024 12:11:45 +0100
Message-ID: <20241120-gastgewerbe-oblag-e8e208731117@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20230727180355.813995-1-mjguzik@gmail.com>
References: <20230727180355.813995-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=brauner@kernel.org; h=from:subject:message-id; bh=h69bwaT1JWyhvxNrWac0bTEoYmUwTuVlZVpjh3UyqKM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbHv696aJYzx7uzJcCEmfzvHzYdPTydhXu+HpwaT7rh vZ77JESHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5cpuRYUG6qvVS5iQ+H0fl 2RovX5WHWuVf6QjJmbpe2l2qyD5Pj+F/ZXrdU7+5CxP26x0quL239WTptJQ9BpJV4latyuu+lJx kBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Jul 2023 20:03:55 +0200, Mateusz Guzik wrote:
> Annotation already used to be there, but got lost in 52ac39e5db5148f7
> ("seqlock: seqcount_t: Implement all read APIs as statement expressions").
> Does not look like it was intentional.
> 
> Without it gcc 12 decides to compile the following in path_init:
>         nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
>         nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] seqlock: annotate spinning as unlikely() in __read_seqcount_begin
      https://git.kernel.org/vfs/vfs/c/c795e8ac8471

