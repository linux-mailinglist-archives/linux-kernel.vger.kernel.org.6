Return-Path: <linux-kernel+bounces-551921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E19A572E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A33B74A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981322571B8;
	Fri,  7 Mar 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do/9ebNc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E9254868
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379076; cv=none; b=MkCDQgXhmmbcZf29HTSN/hYpTiUAW0oY3d4A9rM9SAnIHQkj3/3cTCzDeRZT/Gpzk2jBX7s7RHakeSoSQNR+65gA2vD6IgGyIeQBbc3MQkyvaU1l13krdOmEwZtASiHgLYpMCODvp0MAlmpZwTttOBUNu3oOTh98iUPNLobWpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379076; c=relaxed/simple;
	bh=KjWnEu/K+zIr63GaIVtY3k/dYFtNoqLKDVJtEmyg/K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+AfWYOc2Mfsvr7VU9WUdZv1ljGLQO38S+2BoZaCaGJKsERGOZ+2ugqOBnKeFPSA9dkpoMm/GViMsocwxCVOyBWGHsTOAOoY7PdZx7Tg365Uuva3gfd960eBsZmCYBxa8mK67ko4hJwXyWgutwMNOStgM125D2IWElFZGc8CnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do/9ebNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E810C4CEE7;
	Fri,  7 Mar 2025 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741379075;
	bh=KjWnEu/K+zIr63GaIVtY3k/dYFtNoqLKDVJtEmyg/K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do/9ebNc+rpBe5CQ6DPq2GR6Fnmntp/gZhzzwMuVGgCSiDRUHeqfU+RBMP8jUA6T7
	 nU7/Q3ts7fWi29aZfyr0vRNe/BtrO2k8aaKExndfYPajbft8GJVfl+NFt7PR36rAAP
	 cxb+BUxhPTwFE3tLauXt5DUQbNS49KKbS+tN6FFM75K4J0cI1bz4tW8/XzzYnBQWu/
	 +KJITztuQ4W+u9u/P197DqS8zrGB3L2kE3kfFyHYjekoORDRr7LpL1om5csGbTEXHB
	 94EtWTxIah2ptDO/FJNWvDlrDqXtmXJPhaQD/cwQtzLZHdUIu3bsuQve4tkf3Yf6fa
	 RlI7+pof1gr4g==
From: Kees Cook <kees@kernel.org>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Jessica Yu <jeyu@redhat.com>,
	binutils@sourceware.org,
	Timur Tabi <ttabi@nvidia.com>
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] elf: add remaining SHF_ flag macros
Date: Fri,  7 Mar 2025 12:23:58 -0800
Message-Id: <174137903607.1472989.15422208420067527885.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307171417.267488-1-ttabi@nvidia.com>
References: <20250307171417.267488-1-ttabi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Mar 2025 11:14:17 -0600, Timur Tabi wrote:
> Add the remaining SHF_ flags, as listed in the "Executable and
> Linkable Format" Wikipedia page.  This allows drivers to load and
> parse ELF images that use some of those flags.
> 
> In particular, an upcoming change to the Nouveau GPU driver will
> use some of the flags.
> 
> [...]

I added a reference to:
https://refspecs.linuxfoundation.org/elf/gabi4+/ch4.sheader.html#sh_flags

Applied to for-next/topic/execve/core, thanks!

[1/1] elf: add remaining SHF_ flag macros
      https://git.kernel.org/kees/c/b0db1ed17645

Take care,

-- 
Kees Cook


