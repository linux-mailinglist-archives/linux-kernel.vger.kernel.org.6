Return-Path: <linux-kernel+bounces-266472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755FC94005B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A802838B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0C18D4D4;
	Mon, 29 Jul 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GLx35QH5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208B186E29;
	Mon, 29 Jul 2024 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288348; cv=none; b=lMGRkYlOE7tddfBB3pLMlCHEGB2DouwgefFQKYUxovY5ln0NIlOyyt0rsdP/l+iSDB03S3OsfzmJQqWfcGi9j6X4sFCEYeSXOLvn6ZXgl6UHtfID2pSJtRteKB7aX1k8giQV3eSAzRaRhXfQcG9NfZ6d3Xqdmt5SFu5YIWnWBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288348; c=relaxed/simple;
	bh=xFW+GT3fApDE/4SuNYTpe6YBa8rRV+FOjajD3aWNtyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oojoV9Ei49Kv0/bdmdEHL+RDyU8YXsIq6WM/mlnh2ZY0q8kvy9Dx9pzUCnbL5PnOFEv5uHJnUHowj4yAtIhyIP9fLTPE8ZSAK1SBtpLZp3GV3GaynhNwoc7kVAoUVrW0VDqabrzNagDk5RQO7wHTOEZdoPtCndPvLbtHVP5pnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GLx35QH5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC2C4418A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1722288337; bh=lxmKN9izR+poY84u2AEIMD/weTQew3J511bflX6FAfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GLx35QH5ybmYs6Ru2gj7HvW6wyYSu69ZQ9KVhbcs6Jiste9h3s9AxYpbD52b5HU/V
	 ZuXi/m8TS14pMAk/ebudznYzkgp4mUQO4ogKZx9D0m8AvPQjH7Va/meZxJOyyLv05g
	 juHlDmHhRzFi86YPFvbwx+5EH7hDMUxuGi/3AFlqeyjZuKDXgTqLv3Tkf+Q0cR8kwg
	 dCKPjahZyevDhDxwwd6qnjEPmvmOJ2WVWHcLwkFTQihdl0FlUXbe5nOE+/d3tHubmy
	 cOqZFmR1Dct0NpcLF+3NZiq+kKLjRkU9xSIlgXi4eqpAgukMsrsb/9cVpLg6mRgVdB
	 kAj7WEondM1vA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CC2C4418A0;
	Mon, 29 Jul 2024 21:25:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alyssa Ross <hi@alyssa.is>
Cc: "David S. Miller" <davem@davemloft.net>, George Zhang
 <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov
 <dtor@vmware.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: ioctl: document 0x07 ioctl code
In-Reply-To: <20240725171120.12226-2-hi@alyssa.is>
References: <20240725171120.12226-2-hi@alyssa.is>
Date: Mon, 29 Jul 2024 15:25:36 -0600
Message-ID: <87y15j99gv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alyssa Ross <hi@alyssa.is> writes:

> It looks like this was supposed to be documented when VSOCK was
> added[1], but it got lost in later submissions.
>
> Link: https://lore.kernel.org/20130109000024.3719.71468.stgit@promb-2n-dhcp175.eng.vmware.com/#Z31Documentation:ioctl:ioctl-number.txt [1]
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

jon

