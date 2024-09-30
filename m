Return-Path: <linux-kernel+bounces-344538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC0798AB06
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E55284BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9D196450;
	Mon, 30 Sep 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cUoErctk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6C286A1;
	Mon, 30 Sep 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716916; cv=none; b=EZwk4I+/GUqrXUEGyoQtcbohIMJYrAlUcUqyXcErXgqwal01iqAswzl4jXxmR3JTHy+50rmTjQVGUkODxEx/KlWH0Awy9VqLlp9K304hQftOVJ++TxGfj4bII2Ll0PkYuRLzRVwMh/Krnft9CgmPzVmdo/RWec7a2pY8jENX4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716916; c=relaxed/simple;
	bh=sQnJ2vYgT498XXCmOFGCfblCNnKtLSSWz9NtsiNU6CQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShwqzVVGxYmjNnyg5rOZosGZWBsZ9AlEzx3LAxg71ZUREYq3A1/m6QuH5yXossWlQHznopeyjsQpmhJvXErOxO3O8QrviwdLhf+R/JhCSoPt+vjRxCQ0PwlmxvV5syjzepx541VpkiK4egDJQyxdsJ5ne2ae4Nk68tnCcKe5fUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cUoErctk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2A60F42BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727716914; bh=sQnJ2vYgT498XXCmOFGCfblCNnKtLSSWz9NtsiNU6CQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cUoErctkcwoPXi21RUc/Oxl+yiqOZwiR2zeEcf5C70lMQkMhOARq8DBtQAPd2ydHq
	 ZR8mhhKH7f6e7KgYTNztDh851DXhPOZepfHTU51PgQ8QI030k8tMPcb34XtggkS2Bb
	 hgBU2hArwX9tcRjLIH5s0XCll5ptxDr9usajzxLTcJugoOc7MyOXP0wzTq7uD1dGOd
	 AFX3D9Dqd5s6s6r4OQmPDbdgo8TvJiNPWSMeGt2RHpPBFkYrKpQVFaLhF2ROYFz8nl
	 MX486gF0FQN3y6WJC2B9/X8x7Bw6L9IIKLIgS2+zxBSc7y8uRnm1K5DIptkUYIkt/4
	 pjeBgYfle1LtQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2A60F42BFE;
	Mon, 30 Sep 2024 17:21:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Daniel Thompson <daniel.thompson@linaro.org>, Changhuang Liang
 <changhuang.liang@starfivetech.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson
 <dianders@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 kgdb-bugreport@lists.sourceforge.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: kgdb: Correct parameter error
In-Reply-To: <20240930092907.GD5584@aspen.lan>
References: <20240925100742.1730576-1-changhuang.liang@starfivetech.com>
 <20240930092907.GD5584@aspen.lan>
Date: Mon, 30 Sep 2024 11:21:49 -0600
Message-ID: <87ed519hw2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Thompson <daniel.thompson@linaro.org> writes:

> On Wed, Sep 25, 2024 at 03:07:42AM -0700, Changhuang Liang wrote:
>> Module kgdb had been converted to debug_core since commit c433820971ff
>> ("Move kernel/kgdb.c to kernel/debug/debug_core.c") be added, so let's
>> correct the module parameter path.
>>
>> Fixes: c433820971ff ("Move kernel/kgdb.c to kernel/debug/debug_core.c")
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> @Jon: Do you want me to hoover this up or will you take it? If you are
> happy to grab it then feel free to treat my Rb: as an Acked-by: too!

Sure, I can grab it in a bit.

Thanks,

jon

