Return-Path: <linux-kernel+bounces-258346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81B9386A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0603B207DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFEB13FEE;
	Sun, 21 Jul 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DnQTnJXs"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3585944E;
	Sun, 21 Jul 2024 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721603804; cv=none; b=rEPZ58sZTbLK87HI1KxEuFOO+VvuFjwpanPP8etaPQ6cu+Yj3BmXhSPDkcxSeQB2OhtwehlJpbYVxPTqyCieDF85YNeDkcE9zGKrE3AK5sGk1e5nFiWk2ELzl7FCYXYn6Zgk65X644jWs8O08oKy3xLB3haYvMQ93d2dZeHbPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721603804; c=relaxed/simple;
	bh=ZSxWRDewKCAJA+So2y3dwsQUT2XrzaphGCUkvI6yl8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fWvT7F+b84YFOWfxtOCLwJ1kDT867obn/nVBdKdDKh7SDZugDBJQh2/16C37Nsw/EGiU/AQkzWW1AU48ry9rBekzfqAhMeDN4oWcb8wuICruLBK1jKDA2vqzRd6MDu6iGGMmmU0hBaoo/vpEOodUfIHdXcqMuSPa8ScsHhRzbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DnQTnJXs; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 66A9641A2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1721603794; bh=o4HlVwTjHpCEvylGNow+fqaaYnMegiBN6/gKCzs0O8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DnQTnJXs5Xo6MNHIPQ7WIaieUla9MRlXUdVAwrnvgEctbhZT6S5WL2JEQDY+hw3HL
	 /bh4p50yCFzdRWU/C6DMM3ohFVAX4qge27DAPHh2t8/4XAAI+QELgK/9J/vAsaXWHc
	 D9fB82L1D1sy+5BNfCZ3CldmtinScoRPV8T7QuAbq1xc51eITD68GvicdQMTKZpVew
	 gQkhszWAUsK6i2OvAYBzG1QbgCtL9mPmohEj/xa3G+oeSZiI6jHADKANvf9xF3Dt7I
	 DRPx3YSyY2KWFMZV2ulOr66wPEq1PomfOChTP9yvrzxVnXOH8jld8Qasl7AeN18jtV
	 F9Z92OlIZVMAw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 66A9641A2D;
	Sun, 21 Jul 2024 23:16:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lasse Collin <lasse.collin@tukaani.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>, Sam James <sam@gentoo.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 08/16] docs: Add XZ_EXTERN to c_id_attributes
In-Reply-To: <20240721133633.47721-9-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
 <20240721133633.47721-9-lasse.collin@tukaani.org>
Date: Sun, 21 Jul 2024 17:16:33 -0600
Message-ID: <87r0bms5da.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lasse Collin <lasse.collin@tukaani.org> writes:

> include/linux/xz.h uses XZ_EXTERN in function prototypes. It's needed in
> the preboot code. Adding XZ_EXTERN c_id_attributes silences warnings and
> makes the intradocument links to the xz_dec functions work.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Sam James <sam@gentoo.org>
> Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
> ---
>  Documentation/conf.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 0c2205d536b3..2fc1fea858e1 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -123,6 +123,9 @@ if major >= 3:
>  
>              # include/linux/btf.h
>              "__bpf_kfunc",
> +
> +            # include/linux/xz.h
> +            "XZ_EXTERN",
>          ]

I spent a little while trying to figure out why we need XZ_EXTERN at all
but lost in the #includes... Oh well.  For the purposes of the docs
build:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon

