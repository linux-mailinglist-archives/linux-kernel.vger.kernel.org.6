Return-Path: <linux-kernel+bounces-343685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FF989E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BB51F219D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09E188730;
	Mon, 30 Sep 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQujpbd5"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84CB17C7C4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688552; cv=none; b=axl82OqUb2iSWgHx8NEqB2XGqF6lMX+mUV3+3tyXQcZCtrJWsAg/nQUlNaQW4mTCtpuOU23le8TwoCuZ49+ggRnGdaW6aRWvacEvoXsZl7XLo4rg8GvZsKWtwtzAwhM3qRJKz9Ayav+UUeV2QDxXU70PQDzeFb6FLXml7mc4LOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688552; c=relaxed/simple;
	bh=A1fGxWYRT+rLnLYY4XjZD7c/cviI8I+09C5LGo1sj24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMm+Jr04U4KMfsdkQffSPqqIexvGowtGJZn4tCXFY4soF3n8EGUs+Nb+O7YfpWd60YEMKOk8tJYBY3DNRzN3L15bQJWO5lL+1u99bK30zgeieG6AmUqd6+PV16zw4TD0/h/s0lB8TQkZa7nBod+Rp1XViZ7+nXOTQTFxoFVjaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQujpbd5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso680361666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727688549; x=1728293349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrSgKLXv963s8mVz9r3Q+1HNhsVnqhk2fQcNtk3Cxfo=;
        b=RQujpbd5eSjUtXpqSpyLjLt2blDEiQyxReHwm++fai1pW9OkUhlrWPKjsFiLaL+ujK
         w5+eqHsl6Kyciq3tqrNTk/s49nB6I4NrRY0K5KIWRLwtUGO1qz5UKKIAatynhsEyM7ks
         PlPBMXscJ5CeopXMcJfGtKngcdIDXOWRQB2/6OJKMgW+VV6FoRSHwTv7Ulliv5hhUoGT
         fIWU8txGGSxJ8NEhCJwTw+Kf51OUUZc8lyM4HflLmqMqVKEmpskp+BSInhYTFxi5z+3i
         vEg+xxa40wRg2WWjWLHD0+AY8XlTWw1wqXqE+MA15+InP/EixOKT5X0dhi+fWdCqSFli
         PGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688549; x=1728293349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrSgKLXv963s8mVz9r3Q+1HNhsVnqhk2fQcNtk3Cxfo=;
        b=pmKsnn/wHhK0pxZjk/yJ4zfbsy2wEUFEc73Az9+sPQqtoLogS3H4wJvPejASPZdeH7
         DHJbk52wz3qEgJH7HwxCwtP1xnbxeyqY9IMADv4GPdVBjnnjLgMbb9/yIMfox4ZrcOf/
         zHyMFDETDTVPF7+frVpVeZqhF/iY1yXf3Wt44l37zvJ1zZf9Sj7cqOJc6tFMuAYlrT4c
         7YF4we0cQRh3jpsJNsMRtiKoRojviODMkhJzT5E8+LPpOjoD0Yvjtk8V3GvyABYlLuqJ
         Q0qkB6nA8PsKLYer9zDojYrjXZbPQkLDmkVa9FoRFHNDTGTOs5E7a0llr8GsLTcJcQq8
         MdNg==
X-Forwarded-Encrypted: i=1; AJvYcCWQnmOUbLfBP2kBokmjcdriAewZy4DfiqJmgPIuQkvjaw7DzmbgaTcQM8KWikVsajuE+dq+RC/tE3jbv0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/dAunYk5kHh1nCShprCDKRNmUb6+R+L1Xw+LMD9QqwNbpymD
	nyllREjIrVSMIFee/QRG1FOmev+PAPkOgihHULHuJrEokIPlqCTOlJU3q6x5r2Q=
X-Google-Smtp-Source: AGHT+IEkKrPJsUlHoyTMQaqjzeMWolJl4XDm5NPQqsWGGZyTSTe4MBnX5SWsdMBYeKWeft0bEIk64Q==
X-Received: by 2002:a17:906:f59e:b0:a86:79a2:ab12 with SMTP id a640c23a62f3a-a93c492a75amr1205266666b.38.1727688549160;
        Mon, 30 Sep 2024 02:29:09 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997d41sm501776866b.194.2024.09.30.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:29:08 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:29:07 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: kgdb: Correct parameter error
Message-ID: <20240930092907.GD5584@aspen.lan>
References: <20240925100742.1730576-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925100742.1730576-1-changhuang.liang@starfivetech.com>

On Wed, Sep 25, 2024 at 03:07:42AM -0700, Changhuang Liang wrote:
> Module kgdb had been converted to debug_core since commit c433820971ff
> ("Move kernel/kgdb.c to kernel/debug/debug_core.c") be added, so let's
> correct the module parameter path.
>
> Fixes: c433820971ff ("Move kernel/kgdb.c to kernel/debug/debug_core.c")
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

@Jon: Do you want me to hoover this up or will you take it? If you are
happy to grab it then feel free to treat my Rb: as an Acked-by: too!


Daniel.


> ---
>
> Hi,
>
> v3: I wrote a error change log in v2. Now fix it.
>
>  Documentation/dev-tools/kgdb.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
> index f83ba2601e55..a87a58e6509a 100644
> --- a/Documentation/dev-tools/kgdb.rst
> +++ b/Documentation/dev-tools/kgdb.rst
> @@ -329,7 +329,7 @@ ways to activate this feature.
>
>  2. Use sysfs before configuring an I/O driver::
>
> -	echo 1 > /sys/module/kgdb/parameters/kgdb_use_con
> +	echo 1 > /sys/module/debug_core/parameters/kgdb_use_con
>
>  .. note::
>
> --
> 2.25.1

