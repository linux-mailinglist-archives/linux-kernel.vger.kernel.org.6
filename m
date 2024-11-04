Return-Path: <linux-kernel+bounces-395447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59609BBDF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E9D1C21FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4D1C4A0A;
	Mon,  4 Nov 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rPCgB/ql"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CE1E89C;
	Mon,  4 Nov 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748558; cv=none; b=b50Na2BrVQtjHd0qz4wHkrSff+BKg4Bt3p8kgdj4ymfKkEFo7Yzsz5KTwEZzC23YWG5ooazEeXmRP7zI6BTIl0CAltlU8wjmArWEZKIeBDDfqC0w715Akk5XaZJTlNZ6ldJjYF5F87yUyLhyrbp/AdL/s+MP3qsY7sAojfkljU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748558; c=relaxed/simple;
	bh=/10lBdbCWP9c3Me7/mu9OI01ETDGMCC5hQMI8xKD5pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCO5pQcpLfJMUZeDsCM4lf7OP94bP30zrj8xwiBfZR8hE+rhmFDrOBLYp6MK0cBvXtVBoIlc+k/hsyRsSJWGzneYYYWptOsd8Uy2aTAihS5B71nBqGE7pbuDSnDqgatUeWbD80f+CDkaRLj+EK4ZoFzt/vgZhDr9DmRTbHcqLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rPCgB/ql; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B99CA42C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730748553; bh=/10lBdbCWP9c3Me7/mu9OI01ETDGMCC5hQMI8xKD5pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rPCgB/qlsGJ8NYn2P3Xu3eYnNHSDIz71O2zjl+/TLaJYiB8cb1gv6fLhBCYFvZL2T
	 k16tSJCFfOxT0OaBukHDepE0Z//EVth1mIXdZY/KpYfPVPQ8TUIHtEVyMXv1MTCGUz
	 Anv5+DJa751ezbTghlnHwmM4Umhp3zmiBayhls5ih4jGm4Wy5fY/U94e4QJofLDHY4
	 CoqsILds69cZAvUR/2Os1vbf6wdq30E9LBAbrFMTIYHCCEStNH43ovd6IzXyGmHFHo
	 8Rb9TiHvVE31b1deKd6yY3tGNAJHmp6nKaOoaI/KqkVWxcqmIuRFjkpG2Gx47B6phq
	 r0tShdfrs251A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B99CA42C30;
	Mon,  4 Nov 2024 19:29:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
 linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
 stephen.s.brennan@oracle.com, horms@kernel.org, kernel@gpiccoli.net,
 kernel-dev@igalia.com, mhklinux@outlook.com, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>
Subject: Re: [PATCH V4] Documentation: Improve crash_kexec_post_notifiers
 description
In-Reply-To: <20241027204159.985163-1-gpiccoli@igalia.com>
References: <20241027204159.985163-1-gpiccoli@igalia.com>
Date: Mon, 04 Nov 2024 12:29:12 -0700
Message-ID: <87ed3q94s7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:

> The crash_kexec_post_notifiers description could be improved a bit,
> by clarifying its upsides (yes, there are some!) and be more descriptive
> about the downsides, specially mentioning code that enables the option
> unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more recently,
> AMD SEV-SNP[2].
>
> [0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before running crash kernel").
> [1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic").
> [2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump").
>
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---

Applied, thanks.

jon

