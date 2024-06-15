Return-Path: <linux-kernel+bounces-215993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3FD9099B6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6EA1F223B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9727442;
	Sat, 15 Jun 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GcrpN0N0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6279F0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718480558; cv=none; b=QMg+HYDsJjJBYJJAH6Ned4p6SxytimHPcLoVZF/UM5ZyU7qEhZzEPfUNzXRVNacx4bxxj5KHHm5ucyio/Pj1v6KrRGc/4tpt9jylSXJDOfsoJkRUBXdV/4mUtxgBd/wn7pdIgRNE28+h88rtT4ccika9CAiR9a/JA9osunt9iuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718480558; c=relaxed/simple;
	bh=+UdLH0WPQNR18Vi3J43f0+mQIQUVOhhjt7EdWXjh7RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCCGhp4UviYJrVC2Oz5hMcVnqe4jFfvaapTAZ1ol2wO9S7KqIFp3xMrhl1ShjdEcsSeGXUbEWYtppw4E0/2K8tWw0RpKKlwYp7KlNKG+OW64yUf0kNscbWUgYZI4WrWtbIXi9T1t4ZEEYX0yc2iVqimNJuPAAIYbc1WzhEcGsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GcrpN0N0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C807445E1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718480548; bh=qu/dBFFpqkkgxB6kh0uYEAdu/GrOhLxnW6Dyqt7w/7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GcrpN0N0tznfmqFxn2CHm34o4mNcps2f+0Hvh5w+U/SJgrifUDN/po1A8zypL7JW9
	 r08mwl13v8jS/zjQ7CP8S18bparEPlZqkvjrdqyLbUBIscjrJiebN/bd3BbPGpmHPN
	 QkgwpPlU2lpRKF1eoFBBx384KBO+6CfVnaF95I+BY1kbicNvvdQTOsvfelo6JPOvZv
	 WU/53Dw1DpfaotF3jGWBPW4IFpXsGIxr4T7skI7EzZCtjXoeuUAoMCNq38+vT+GTd0
	 aUQUVxpXtWs0l4Lp68PkjpYcpO4vhK+maa2CqmuwAsdGpZ+KVzbr6v79DYc8Y4z/8C
	 HGAgujrSU3y/g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C807445E1A;
	Sat, 15 Jun 2024 19:42:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>, Yanteng Si <siyanteng@loongson.cn>,
 Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scripts: fix most issues reported by pylint
In-Reply-To: <20240615035323.909650-1-dzm91@hust.edu.cn>
References: <20240615035323.909650-1-dzm91@hust.edu.cn>
Date: Sat, 15 Jun 2024 13:42:26 -0600
Message-ID: <87ikyakn6l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Pylint reports many coding style issues of scripts/checktransupdate.py
>
> This patch fixes most issues with the following contents:
> - add or revise comments for all functions
> - use format string suggested by python
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  scripts/checktransupdate.py | 55 ++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 31 deletions(-)

How does this differ from v1?  Please always give that information so
reviewers know what's going on.

Thanks,

jon

