Return-Path: <linux-kernel+bounces-348010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B898E17C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1803F1F23BDB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEB1D12F1;
	Wed,  2 Oct 2024 17:07:31 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138716419
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888851; cv=none; b=dnlgvKAdepCD7sLQdKHybhCcg8xDRrSR1e6j5hMoXTI5KrWpLKeH00QyQN1gbkMy1DrYswP85qXrs4rHtkhHZCX/5vH4vI72MTfzw7x9jVKWGMGn1lS6dNme6syuyET/yk+Sq9d1ou3L4Dc4ABd+6eApr0GXnXCIu4t3ogcioZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888851; c=relaxed/simple;
	bh=ddE5IcagNAb6wUQZaqIwzTNo9asm9xRSfGvRPXTqD6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4ThR0W0o2dOwk7EsFDRCsVqarMGAO4ffaqFOQzCdmN9VN/1AkFZ3pEDAXKqU7brNigxPPmqp9ZwamVMywCEw5HnxRVQhnm1cb/CC2RiSJzTj/QnZQsyye/+HBxnfEj5Lbb0dsVkmwtfqBCxnnijiqJBK22Dc6/WJ8BNWUv0Z4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XJgz571DCz1qsPD;
	Wed,  2 Oct 2024 19:00:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XJgz55FvSz1qqlS;
	Wed,  2 Oct 2024 19:00:01 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id o1fEc9dja-6n; Wed,  2 Oct 2024 19:00:01 +0200 (CEST)
X-Auth-Info: qyftVG0Q0C/TMVzmcECBxdHF5lFnb2uI8+gWg6iruV5cHKkLtHap3F1puUM5exuv
Received: from igel.home (aftr-62-216-205-210.dynamic.mnet-online.de [62.216.205.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed,  2 Oct 2024 19:00:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 9DA822C1A09; Wed,  2 Oct 2024 19:00:00 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tony Ambardar <tony.ambardar@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Arnd
 Bergmann <arnd@arndb.de>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Wed, 2 Oct 2024 09:24:50 +0200")
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
X-Yow: Here I am at the flea market but nobody is buying
 my urine sample bottles..
Date: Wed, 02 Oct 2024 19:00:00 +0200
Message-ID: <87zfnmbfu7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Okt 02 2024, Geert Uytterhoeven wrote:

> + * Optional: only supported since gcc >= 11 (partial), clang >= 13

This is misleading.  gcc fully supports it since 11 as long as binutils
supports SHF_GNU_RETAIN.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

