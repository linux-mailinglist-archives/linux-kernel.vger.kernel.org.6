Return-Path: <linux-kernel+bounces-411986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A319D0207
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297901F23925
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 04:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA7214A90;
	Sun, 17 Nov 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFvdrBbO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CB38C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731819383; cv=none; b=SDyPjsvAFtH0DT368bU4JxQVX0Sd0ovP68S5WFeHPgAT7ZfE4s5jjSH6v1sUd1AiJnSz3M0xKMpGoXhzrpUOarpx3EFuJNPPD60n+zrKre8mlfBtEJuebDEdWtBwq8O96xVNHoL5s083xxw+K6nLCkphCWh0iqzkOki0pYEbUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731819383; c=relaxed/simple;
	bh=IDXfBaWVW19QPFT4o4LM71AzWZ+c9os8xPhkQiaVFPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=er1EhHPIKVHIh8op1EzujKuC5+sejjtt4lnp589sWsz0ibu+nsWWXTk5k9+k0G/PqksfBus8MSBSs7upkyltK8Fq7+IH9sReipdw/pRkoc7Wf/jmf81faQhpXnkt0V+gNuYUwchkyVsVwV+JnAplGhDCjRL3fcNrfvEsTrrS4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFvdrBbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0649C4CECD;
	Sun, 17 Nov 2024 04:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731819383;
	bh=IDXfBaWVW19QPFT4o4LM71AzWZ+c9os8xPhkQiaVFPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFvdrBbOWvEcFGvEC7ZMoj0WR8sr4auv1wDTdH+WqkC3M93megu93mxCAaZf1j48+
	 M0Z6lvP3xSmaKsrlVXWIaT/03VfF8ILdwDHAZz4hiJzPAphAffxSrmRMcCQO+tofmx
	 Irnw12gFey+Dw6Uq1iJNv5j50+GDTRuVN/jbx5D8H6fGLmsY9bCSxvKJlOzmDNgos4
	 8Ge+PSJbDv5dKBWNsiThYDSfNcmks831Ybi6TMZ0LNrovDLF4ioq9tsirSLXG1GPiv
	 SzvQJW0USg8NKUiDtI7/LkPCG2DiRwL1R5sly07DCyk+HJAsdAmfFtAlFRNt2eWo1h
	 Cz1qGlrSsyHPQ==
From: Kees Cook <kees@kernel.org>
To: ebiederm@xmission.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	Nir Lichtman <nir@lichtman.org>
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] exec: remove legacy custom binfmt modules autoloading
Date: Sat, 16 Nov 2024 20:56:02 -0800
Message-Id: <173181935997.601589.16672643288623371390.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241116231323.GA225987@lichtman.org>
References: <20241116231323.GA225987@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 23:13:23 +0000, Nir Lichtman wrote:
> Problem: The search binary handler logic contains legacy code
> to handle automatically loading kernel modules of unsupported
> binary formats.
> This logic is a leftover from a.out-to-ELF transition.
> After removal of a.out support, this code has no use anymore.
> 
> Solution: Clean up this code from the search binary handler,
> also remove the line initialising retval to -ENOENT and instead
> just return -ENOEXEC if the flow has reached the end of the func.
> 
> [...]

And it removes a goto. :)

Applied to for-next/execve, thanks!

[1/1] exec: remove legacy custom binfmt modules autoloading
      https://git.kernel.org/kees/c/8c9870077aac

Take care,

-- 
Kees Cook


