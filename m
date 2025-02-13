Return-Path: <linux-kernel+bounces-513437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2BA34AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB48F3ADA8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06607241691;
	Thu, 13 Feb 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mhzEZeyV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E99B2036FD;
	Thu, 13 Feb 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463907; cv=none; b=oBgpT17uY2az48NlMMB17lrk81OCe3uWkO03Frk/y5pUJjDRX9wweAf5VYIs/+27Qfvpf00xlZNTrbGGGNSjD2Q7Cye+xVP2S8GQBHfBR+wiTxgl6qJwl7Rio41d3y/Fwy/gyAPvGDjbsv1ME8W5l8/X4GIJZPs2d0cgOv4G/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463907; c=relaxed/simple;
	bh=LJYiLv2B2qtZYrVktvz7nPLYWm7u3fmQN3FyovuslSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exTxFVxgTzZWmx7atUO+EK0WhOhnu37yBCoKA0Ta9wT9kraBBIXCmZ/ARr/FgLP+SEq0zEjgzXv8I534x2Je8Y99F0uugWsHJl4ZV7yaw0BoYdRvPHsTQOP7OMCNjfzKYBY1/6S5/hH3EUxEvsAih9VFwWd7t+CU+6AYvuFWy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mhzEZeyV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BDC1E44097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739463894; bh=yPECwjUzd9d/TUb9Hi1x5Fu5nz7qf+2JBwxIbrQGCWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mhzEZeyVhK50h+4Fd2HM8ermneWJ6JGV/cbNSKoSRIRGSeusOmz1F8VxTMl8s5oiU
	 N5NvkubaqkxCN0EOtXGQ8uVa9lfHlqEs+0fKDwA5G1VwvBZ9b10GPuk/Bcvl1Aww7o
	 T0D9zwqZOvlVgYdoNuS0nij1O7WzUMFPsNRKqjqC+sPewls8/OdTNjZV4vYDwNL9KY
	 DVXEvJMoNwLOvpv+6mWsNJjhpdyZK3RWi3mlYcJkefNTJktNS5HZC5jPSH0q4k4UCh
	 H0XE8oEIgWGBqPooioqGv5svOMiRCjxSdNJeN6KeGq+6lqB+TO70mrd7k8LJs6Dfsi
	 bj1JKO3WWzLHQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BDC1E44097;
	Thu, 13 Feb 2025 16:24:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: drop two duplicate symbols
In-Reply-To: <c3dce809f577584cf9aedafc6c2a0d5a9ca909ac.1739394480.git.mchehab+huawei@kernel.org>
References: <c3dce809f577584cf9aedafc6c2a0d5a9ca909ac.1739394480.git.mchehab+huawei@kernel.org>
Date: Thu, 13 Feb 2025 09:24:53 -0700
Message-ID: <871pw17qy2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As warned by get_abi.py, there are two symbols that are
> defined twice:
>
> WARNING: /sys/devices/system/cpu/cpuX/topology/physical_package_id is defined 2 times: \
> 	/new_devel/v4l/docs/Documentation/ABI/stable/sysfs-devices-system-cpu:27; \
> 	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-devices-system-cpu:70
> WARNING: /sys/devices/system/cpu/cpuX/topology/ppin is defined 2 times: \
> 	/new_devel/v4l/docs/Documentation/ABI/stable/sysfs-devices-system-cpu:89; \
> 	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-devices-system-cpu:70
>
> As the documentation at testing/sysfs-devices-system-cpu, drop
> the duplicated one from stable.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/stable/sysfs-devices-system-cpu | 10 ----------
>  1 file changed, 10 deletions(-)

Applied, thanks.

jon

