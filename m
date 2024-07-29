Return-Path: <linux-kernel+bounces-266488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7274940091
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC79282F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA318E741;
	Mon, 29 Jul 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YX9E4t9D"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCB140E37;
	Mon, 29 Jul 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289460; cv=none; b=OZFSJGR2coO79YLCyJ10gIV4tkECVk5ugVvsWXtMiPOopOxYbz2+YiDGVZafN7lH6LHucjuXRuajmwt9PbLnECH+lwPFbbjWrKoE5ZnK0FSBCIkFsRMLrzSjMLWBpvqZiOwIRj8BwDdc+XuYEI7WNbujwxqTumPCDD9CZJECzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289460; c=relaxed/simple;
	bh=egT7lolkZwDkbg8iFKpldCm3XZvqR2cN1rtaJLy8o3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R8xPCR7l68XQ3CO6hHoImlRhOau9yMb/mE9ts0RgPRLJZFeR+o1yhuMrXEZXIbageDufzClvkClcurUisGn0AJsqAbz7+w1OUTQVmlOzILkhTwovR3CJ6JoyYI52kX8zbya7HgZN9M6udV/c6j2UqBFQJOcfEqtgooEVNiKxHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YX9E4t9D; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7F885418A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1722289457; bh=dXAR2n3r6HOfTrTdoBaobElAEl2izBVV7XrBjM7IZoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YX9E4t9Dsor3ibXfwP3iQhcOCNPB8I5IbAz8/Bz+g+7vQMdAvjWiqXgjHYwNibo9O
	 Duan7/eJlbhKfSPYxGjMCHMb1mouckuWZlHfC7FTlIh2fzScuQqFp0Uop5XpXG2MA/
	 aBcJPPEk0kHsHPUtEEJ+yLuZsOqe5HrahXWi1cpxWzYQdAoPVwROjlXP4DEztbyWK0
	 u/qs4CUBTJeJRnaEZKs/BeNQhuJ9ac3gNuGcwKbkeZYg9vbZrHteZkGSKF6zGbUDZN
	 SpK6X6UJx1qybwZ8+ci+7aNP3VXKriYyHNX+Gvyo5yOrvkiXRkWW6/IX/57VDaViM3
	 R84JTXGm0lYZg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7F885418A0;
	Mon, 29 Jul 2024 21:44:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, chengziqiu@hust.edu.cn, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] doc-guide: add help documentation
 checktransupdate.rst
In-Reply-To: <20240719041400.3909775-3-dzm91@hust.edu.cn>
References: <20240719041400.3909775-1-dzm91@hust.edu.cn>
 <20240719041400.3909775-3-dzm91@hust.edu.cn>
Date: Mon, 29 Jul 2024 15:44:16 -0600
Message-ID: <87o76f98lr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For future reference, a sequence like this:

> +Then the output is something like:
> +
> +::
> +
> +    Documentation/dev-tools/kfence.rst

Can be more concisely and legibly expressed as:

> Then the output is something like::
>
>    (literal text here)

More importantly, though, this file:

> diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation=
/doc-guide/checktransupdate.rst
> new file mode 100644
> index 000000000000..dabbf9ecd187
> --- /dev/null
> +++ b/Documentation/doc-guide/checktransupdate.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Check translation update
> +
> +This script helps track the translation status of the documentation in
> +different locales, i.e.,=C2=A0whether the documentation is up-to-date wi=
th
> +the English counterpart.

...lacks a title, so it renders strangely and inserts inscrutable stuff
into the doc-guide index.  I have fixed this, but I am not entirely
happy about that; this is a problem you should have seen immediately by
looking at the rendered version of your new document.  *Please* be a bit
more careful in the future.

Both patches applied, anyway.

jon

