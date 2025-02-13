Return-Path: <linux-kernel+bounces-513503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3DA34B03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754E73BCC23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68E20127A;
	Thu, 13 Feb 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="d32GejBx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481124A079;
	Thu, 13 Feb 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465206; cv=none; b=fb+dUFF0ioyY7lj+5fyVj1W9NwUPgwMIy9B7lb5rlbPzfBphrSypMt2Yi1RsxBu/e4oTrEC61pVUJgLM/uNz6jhVO2XfswZRPjaXL6A8rlplxLieRrgxgITyUMsJwizfv9se3kH8q24XdK25+q925GEh4uZtS7hACsTYhK9O61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465206; c=relaxed/simple;
	bh=DBrzRiKfHQhUieCoS1jd2keEcouyy2TAdA8Hy9eT5CU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ph/snXJcvS9iU/BQN3h/qmgoDefHWgcmzJObM4qCWxaRuHCM79RQ4Y1mnr6LTe4LxgPrC2e2Ds0/bV8G9yCHUfep2+5OsipeByUQbnVg58TJSWRaPQKLcM7ezHRT1zeEOETlJfc6eDYeffVdY9K9bsDfYmbkXrqpO60gEFukkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=d32GejBx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B8FA748EBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739465203; bh=KEZqGb45tLQV/Ib54LAY03Ohsm5zJrAVnCYgVwcKUjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d32GejBx45dnSb/JQzlubScBvTOOS0S7DlEwWWfk/pxYJNoqzMlWA4gFE95h3srLh
	 tO2ErhayEOPoWLvpoH5g2WQc3N8Ktu2Gq92AQ/QtXbz3NXTAUFBoyNmpz6jsXu1TkX
	 4JajJBAmyUaFlUp+A7xx6eCG0w3UtP/ge9n2g2XJONiD+nwGEu3qLMF6JuvRyBdBXG
	 IyrxS2TfGmdCOD+dzXkVnHypsNTw9MKyz/0MzRFyb9QavYHDVl5q4aMZ5jIEegrPdV
	 K5LT3mJccGWY3QbNydb9fbw4u9NpsBry2Fkng1aP1V7XsKAVXb9q8za1Kv3OpSWfbV
	 2sKA+T43jTD5w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B8FA748EBD;
	Thu, 13 Feb 2025 16:46:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: trace: decode_msr.py: make it compatible with
 python 3
In-Reply-To: <88bb0d47100feaa3cda215e68bf6500dc67da7b3.1739257245.git.mchehab+huawei@kernel.org>
References: <88bb0d47100feaa3cda215e68bf6500dc67da7b3.1739257245.git.mchehab+huawei@kernel.org>
Date: Thu, 13 Feb 2025 09:46:42 -0700
Message-ID: <87frkh6bd9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This script uses print <foo> instead of print(foo), which is
> incompatible with Python 3.
>
> Fix it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/trace/postprocess/decode_msr.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/postprocess/decode_msr.py b/Documentation/trace/postprocess/decode_msr.py
> index aa9cc7abd5c2..f5609b16f589 100644
> --- a/Documentation/trace/postprocess/decode_msr.py
> +++ b/Documentation/trace/postprocess/decode_msr.py
> @@ -32,6 +32,6 @@ for j in sys.stdin:
>  					break
>  		if r:
>  			j = j.replace(" " + m.group(2), " " + r + "(" + m.group(2) + ")")
> -	print j,
> +	print(j)

This does make me wonder when this script was last used ... it hasn't
seen a real change since it was added in 2015.  Oh well, it should at
least work with current Python ... applied, thanks.

jon

