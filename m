Return-Path: <linux-kernel+bounces-342485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A0988F89
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182C0281BC2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5031187FFA;
	Sat, 28 Sep 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HtPFC/Ra"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80C125DE
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531714; cv=none; b=DhYaLZXb2cCNi0BfcuOUyVHCkqCl8tTYH+TZFdNl7dI750+1GqMnGqcHBMcFDZwMztTYQyETr4JOi+0uYnjtLWqCNz+tmVhY+RSJDQunTAbXauMI8yX4LY657zixxsx0EG6mOMJAWUzG48TlwOAF+JFABl5LNTjSUwLHh520Dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531714; c=relaxed/simple;
	bh=CHuyMdPc0Pq0Y00+l0fwVclS4+g9jnElbq/qOBCWgdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7LQTAU8ZSsh60quUVo6fmwfcaFeESPTQmwTdB0rKZQtvzTQtfOdDriKDt7CKG/71lYMMpCCo0Kq32kJnZBYvf0V0gDMDlAZLgggzdnHug8hvOfBqamSV9C4GwbeQJ52c4impNBcDIUVxi3Njbbe06U7bFJybv9u1h1QSYEFRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HtPFC/Ra; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D5D341898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727531704; bh=wcthUFttYFJfcIQ1UHU0FBtfXP+od6x0ysgOTd9jkeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HtPFC/RalC7H1oQjzWPDbVXLgjNJSt52jV4/P4xvLreFdH0Ge/iXnXl7PIcGNqkMe
	 XQ8S1fWkDJWLHsjxzz2/RdJ86Jwxvs2BgY00KGdUIPQgltYxjG78szMMTtnyqLhVEL
	 Sg0q0zv41NgwrD+/Xw6tr42Db9fOypcaX4Fn93MtS8WgG5Nyk8EnPM2TTQx9glHZYH
	 6XWIeKqPYCZCikPfOvWr5/AsXOOddQ8pgvd2Q3vm+4TrRdKNLakU2ye6FJcauZxSGP
	 FkxMuwDs//7JRKDtfiMgGWqhheDWZwaSq+leqt75g9+iq7OEzCCIikaE3/SH3j6f/l
	 CdDa9o3qCkXyA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4D5D341898;
	Sat, 28 Sep 2024 13:55:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
In-Reply-To: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
Date: Sat, 28 Sep 2024 07:54:57 -0600
Message-ID: <877cavdgsu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> The following changes since commit ada1986d07976d60bed5017aa38b7f7cf27883f7:
>
>   tomoyo: fallback to realpath if symlink's pathname does not exist (2024-09-25 22:30:59 +0900)
>
> are available in the Git repository at:
>
>   git://git.code.sf.net/p/tomoyo/tomoyo.git tags/tomoyo-pr-20240927
>
> for you to fetch changes up to ada1986d07976d60bed5017aa38b7f7cf27883f7:
>
>   tomoyo: fallback to realpath if symlink's pathname does not exist (2024-09-25 22:30:59 +0900)
> ----------------------------------------------------------------
> One bugfix patch, one preparation patch, and one conversion patch.

[...]

> I was delivering pure LKM version of TOMOYO (named AKARI) to users who
> cannot afford rebuilding their distro kernels with TOMOYO enabled. But
> since the LSM framework was converted to static calls, it became more
> difficult to deliver AKARI to such users. Therefore, I decided to update
> TOMOYO so that people can use mostly LKM version of TOMOYO with minimal
> burden for both distributors and users.

I must confess that this change confuses me a bit.  Loadable LSM modules
have been out of the picture for a long time, has that changed now?

Even stranger, to me at least, is the backdoor symbol-export mechanism.
That seems like ... not the way we do things.  Was the need for this so
urgent that you couldn't try to get those symbols exported properly?

Thanks,

jon

