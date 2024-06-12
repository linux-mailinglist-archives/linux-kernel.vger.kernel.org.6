Return-Path: <linux-kernel+bounces-212267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83D905D81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35651F22672
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9385934;
	Wed, 12 Jun 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R8yuJ4Fd"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C784E00;
	Wed, 12 Jun 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226787; cv=none; b=qVaCH4JsNsHKSCiF0vEkeEPJO7rL1dsviwnE6S/Vvupg90Mons2XOdpc4/4xpnXXmq610Zl8KMqL2pOH3lkC6qjDhTmLKXgekNlro4oTKfPtA0e+G1KW5HRCc3hm13/7PwGoxsEBl3GF+fcfSO44wdzSjTMeYA+Z4icgwjUbx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226787; c=relaxed/simple;
	bh=m7dkmymv3ocsLwM5RBIeCOX1op7kT/HL3bNHHw/zP+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1+9LoiqtQN538WJM/CR4eiEMYSuDUVh+tBCZsPFKXu0XtH1kKJV5MxliFQgglOJT7PxutQMOaZyaLxciNZ8gCelUrcGfu92UTk66GcoAEt6PmMEIzeFziL6aeXamWIfxBTP+38heP05vpwRvD+0LdIqJLGHvbZLrnNyuTVm+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R8yuJ4Fd; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0343A45E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718226778; bh=KXI+K1lfq8TL5SFEVkycAbAE6O+6El1LAKAkRnQ6TJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R8yuJ4FdrWGdF4DiUgESJzPTg7JiXTNbxi5vhmEXE8KfnCoRArD48ovkyN0YHxUIY
	 ZyZ79SELD5xest3TPmOCmtr2fAY3pPoWb8yCqwO5R7af97XsWqkfLnZdPwLi6uvCsa
	 J+gklePmqmGJp2xv+LHoXFeVwIrKn1Hu7KW5APlEV5baVsdahixegcVsZB1UJFj5F9
	 7XjMvm1gIpLAMFQDbASN21CZ9vqs81qLfJVCFDCu8tkDiaUEKGsxcQX5gV5Bg/c1SA
	 QMOZevbLEl05XCK4DXC+iTkvoo3g8+lmgIAyHSRrTeAozbnYpmTQqxG3kDwPuW1oKa
	 fFeXV+0dkcTVA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0343A45E09;
	Wed, 12 Jun 2024 21:12:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Haoyang Liu <tttturtleruss@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Update dev-tools/index.rst
In-Reply-To: <20240612161835.18931-1-dzm91@hust.edu.cn>
References: <20240612161835.18931-1-dzm91@hust.edu.cn>
Date: Wed, 12 Jun 2024 15:12:57 -0600
Message-ID: <871q51q2zq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Update to commit 8c88bc5b489e ("docs: dev-tools: Add UAPI checker
> documentation")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/translations/zh_CN/dev-tools/index.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
> index fa900f5beb68..c540e4a7d5db 100644
> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -20,18 +20,22 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>  
>     testing-overview
>     sparse
> +   kcov
>     gcov
>     kasan
> -   kcov
>     ubsan
>     kmemleak
>     gdb-kernel-debugging
>  
>  Todolist:
>  
> + - checkpatch
>   - coccinelle
> + - kmsan
>   - kcsan
>   - kfence
>   - kgdb
>   - kselftest
>   - kunit/index
> + - ktap
> + - checkuapi

So I have to say that the changelog here is not particularly helpful.
You have *not* updated the translation to that commit, so it doesn't
seem like you should say that you did.  "Add several newish documents to
the todo list" is appropriate for something like this.

I've applied the patch, but with the changed commit message.

Thanks,

jon

