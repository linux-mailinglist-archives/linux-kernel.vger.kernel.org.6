Return-Path: <linux-kernel+bounces-315229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445BA96BF9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF63C2868AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40101DA301;
	Wed,  4 Sep 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QSXeqYqW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B81CCEFC;
	Wed,  4 Sep 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458710; cv=none; b=mYDJJrTf4uB8OVG2TCjtFCeRX8fmNuNW+RnsLrvjY1RFR4QJxzSRaOh58/QCBOxzlXdAdvgCeejEMumo2P1vkXBbNyXc+kaHWOwB8tGPWkhQScoNFGe7Cvm7nKaSAe3h2EnxcVWOLxjHc2SYLtejbxHyvWVb6sBlbUTH+cm9hPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458710; c=relaxed/simple;
	bh=aeuvU0uTn4EHsdlBsgLqrVDqKnND00xcE/ZmfdY+tSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1Slp9Bd1MsoRFcOwIlIImNM4MhkfnfUlSGvDbI+FCGs/pBt0dSfcvq2RYJ2bv35AHf+3WT8bHRzbtwWLiIEmEDK53UHqY4M79ebxlj8ydkiQXLxhm88cxegHwUr5oYdaHfwn/6DMDRmowN9lAhLjcZH/xc0q/nT3dfPlWgn1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QSXeqYqW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 724B642B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725458700; bh=bPJsyN4OVHJPkKS+55oOZsTfbS95iFLn1DvzX0Lx3OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QSXeqYqW/dIbK+uYzWOEt9TVLyNtXYWgZr/drwtvj+5/a5RfAvVjo5Eq84IIRzn1y
	 WyOKH85f7YmP/BdMRINSAXrxkB0LgOJgoOm8SNg1W+gGQLLXkkNslk6wJ1DrSUY4N+
	 S2r6NkfTlTqXdwUt5905CMKDgIbt83+QEXfRK3kuCGLykx8FdE4vrtVpnST8el4EYG
	 dwlsmtrF6DGD5PN+G6D/LaSzHZ2SOrPvL0JJ2iMLNVFS3QF1E32EISiMeHokWI+5a9
	 6BpsCktNneCvf/qKGjDDUqzoosLG5SPpG7CgRv+YMaigQHTz9Gi0KbIAQXDMHTwqxF
	 nTAKkOzDyHPqg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 724B642B1D;
	Wed,  4 Sep 2024 14:05:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, Haoyang Liu
 <tttturtleruss@hust.edu.cn>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: update dev-tools/kcsan.rst url about KTSAN
In-Reply-To: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
References: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
Date: Wed, 04 Sep 2024 08:04:59 -0600
Message-ID: <87cyljms50.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> The KTSAN doc has moved to
> https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md.
> Update the url in kcsan.rst accordingly.
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> ---
>  Documentation/dev-tools/kcsan.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index 02143f060b22..d81c42d1063e 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -361,7 +361,8 @@ Alternatives Considered
>  -----------------------
>  
>  An alternative data race detection approach for the kernel can be found in the
> -`Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
> +`Kernel Thread Sanitizer (KTSAN)
> +<https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md>`_.
>  KTSAN is a happens-before data race detector, which explicitly establishes the

Applied, thanks.

jon

