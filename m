Return-Path: <linux-kernel+bounces-328390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A99782C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE469283F94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB3286A8;
	Fri, 13 Sep 2024 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gYjEEnam"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7626AC3;
	Fri, 13 Sep 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238320; cv=none; b=aTY0uNN6y30VQeXYDio2xbmO6DRIB3mvGTo8OvwR7JYygSMWLg3pugrG5m1fPKWcXKD1oh0jLUh/GA5GD3FmaPu4c3guA+9fM7eLJrxVKRNIfNn0/9yQBXKp7vnLobUytUIUPArveiBSXhB9zrYhVMp3jKpUZr/lm9THZJTRzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238320; c=relaxed/simple;
	bh=ODPC/mmlX6/mJkJ4sqrmh2Ywzw9wnagKUef8mp3AdE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkOJWBfU0D2xkNPDcHDBvQDlCP2Jraf+ahbXuOd6rLV5zpGAliiu1wb9bDrrtPx27Df/FIqx11jLsmsjQ8NxbpRlzD1nKYNjjz36pSCPjBWBmcD57leZxeQn9VPBG8hOON0VuTEHsEJ7HrBNmjBacF2FA4N0YrVh+fXI+6CTXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gYjEEnam; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1498F4188F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726238307; bh=sP9tNsxkkTxV13nxMXjrTbHIM0VIEbH9geFGNnQijsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gYjEEnamJFddfn3iBfRfuvayzFovUIpGK2dTEUQHcDMgUtVB9MpOQiKc8aOozNSi2
	 Zk1pzFiV1EvLR+bgD08C/0uSpcf+aAZGZ8nXkxW0kcJ/C7GymxMaDRSp96HHnfEQj9
	 0pEKyR5jNjCYRv5rlfzWIzH+dU2ub4XREP3o07XO3vl8enWjXQsD4ViYbJE/GpDF/D
	 lqY+tNg5hqSp/PIpoDL4IQnYp6T3/rJPdmis43MG/f150K1X/Blxve8tTp4urWaFR6
	 fKLEdmHcqUErxjRvIZUtgpjO4KEqKqAHtghxj4PRzAdhYgUf9jcp00nuzvt5rhc/a+
	 xWz0y5ue1Q/Zw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1498F4188F;
	Fri, 13 Sep 2024 14:38:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Cheng Ziqiu <chengziqiu@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hust-os-kernel-patches@googlegroups.com,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>
Subject: Re: [PATCH] scripts: use ':Original:' tag to locate the origin file
In-Reply-To: <20240913081626.4174631-1-chengziqiu@hust.edu.cn>
References: <20240913081626.4174631-1-chengziqiu@hust.edu.cn>
Date: Fri, 13 Sep 2024 08:38:24 -0600
Message-ID: <875xqz39gf.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cheng Ziqiu <chengziqiu@hust.edu.cn> writes:

> Simply substitute path may cause file finding failed
> if we have a different dir map for translation. The
> ':Original:' tag could be used to locate the origin
> file if both the tag and file exist.
>
> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> ---
>  scripts/checktransupdate.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Perhaps we need this, but I would really rather move any files that
don't conform to the English-language directory structure.  Having them
be anything but the same can only lead to this sort of confusion.

Thanks,

jon

