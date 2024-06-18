Return-Path: <linux-kernel+bounces-219417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789690D142
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE75B2A072
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A791741C7;
	Tue, 18 Jun 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="st3H4mMr"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D516F277
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715435; cv=none; b=MH4sSORRmg+1htxcOWN9IYk845AYRb0b//23U4V3OWPUOmekC9TnG9exMs9l/OA7V0nI96IcXN31dGkNu8f8ht2IJTZeLRXR9WO1Nv0l/4WYG2mzAPfBPw9ZrsFDmtH2Rbaf5dp3EyO51tnYWcONR35EabrB+jhM21OovnITfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715435; c=relaxed/simple;
	bh=nV3bKtUkMBGMCnkXnDMhV0hIf+nLnmMuohPIUEx65Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuzBGyMsPpS/u6NLeANouXLQ4GYf6Uag59/IuWTbKX6ihYluAwkFRfhfR6aCCCEgcg5QS6jRpN9mujbmMk0osXRavRuKpfl508BgQH/KgRmUbDE+XW9gOlqlwYjaALgg3vztJOTJOiDFHlFwflPEJd+J2PkfHozxrWIHEsgrBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=st3H4mMr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217d451f69so44130485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718715432; x=1719320232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbjTbEXM1rhyPvCrzJoEnRCjMhlrNa3uzeM59k9vu6c=;
        b=st3H4mMrn2ldDvHw0Vm1fOTudrQeBGYBTsUk3pizeKeYW7Lc8lp6l+wGIBd9rrMeOq
         SBDRDQLkAeSyV7CIE/wbWRdaWFA5rP+uVtJ+rOsrSPUllRYItfQ6bcwgXe5+NVKaPGNJ
         cB+jPehofWk21vawC+YwebIkD8i8SlX1Pct2UHNRFPFWtIYKRFL9qmhO7I1/6rCzatFm
         +ddAedSRFN2XJU5EVOCn2tfrbVcI1M65EziFxCf/jIi3y67EcW4LRMTearfWYB/Bk+a9
         dK5KKhJ50uIw3e9mZlGxKqKTZTm6nAFRt0DEi9T3r0nEiPJbh9o5kBt3PLMSfMQyroZ6
         o2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718715432; x=1719320232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbjTbEXM1rhyPvCrzJoEnRCjMhlrNa3uzeM59k9vu6c=;
        b=ZZChAD/Qniybr5fzhaU/RzHTraeJEMfuz7ML5BIkk7p26FF7zDNJLGg+5JlYiE8TDU
         kqsnEMzzhDgryv8TOsg9MVQpdVUG+6SpUxD6JJFVXFf0bWARulygbzbCUU0aE4KY//Ca
         tawVygRPgI9TO0CXx6emGqUlI3GxO8ZR6j80u00IafaL/4N+iWVGkN94M3jwBPF3xukp
         jmfclz9ScOTwmw0Wdb+RkGI+CJ3Fe1sNOWwoudmjzcpmys5/wj2Ot7Kl4OBEJA9q3/ZW
         Ez6/q39jVeFTh+RXNRHJH6VBu/b4V3hLEsd544XA+1iP81uvyg24LconTCGYFt87R7h9
         vdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrtX3N0+xLfWNgsJiZ6H9lyq1A586iLruY2tOuE5yNsO2B4/mjU68e5MXI9gN51X7Ep60fK6dMe8dIP87qSOY7j4sVVzTE4QxN2SM0
X-Gm-Message-State: AOJu0YzVO7RliXyhP/zqftsxq9p0V8sexPzQjINlqmpC2DPYeVhrMO9j
	CNBPCOm7ys9E4g2UwE+qx7T74kMa7NW6TMnxS8F4Gv55AXbcQ9UyfRK9CKa79x8=
X-Google-Smtp-Source: AGHT+IEj25bGB+7W9l+ETh3T8M6eWkgzBT9LugX6g1oKQJQ4kvRTbQG+s7sBjsfNicqR/X3eXtThYw==
X-Received: by 2002:a5d:4c4f:0:b0:360:7809:ff0b with SMTP id ffacd0b85a97d-3607a77af36mr7982159f8f.51.1718715432145;
        Tue, 18 Jun 2024 05:57:12 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f224esm13949181f8f.66.2024.06.18.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 05:57:11 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:57:10 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] kdb: Tweak "repeat" handling code for "mdW" and
 "mdWcN"
Message-ID: <20240618125710.GE11330@aspen.lan>
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.7.Ie8aa2af2df12c2e9dc510f003a301401a1ac97fb@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617173426.7.Ie8aa2af2df12c2e9dc510f003a301401a1ac97fb@changeid>

On Mon, Jun 17, 2024 at 05:34:41PM -0700, Douglas Anderson wrote:
> In general, "md"-style commands are meant to be "repeated". This is a
> feature of kdb and "md"-style commands get it enabled because they
> have the flag KDB_REPEAT_NO_ARGS. What this means is that if you type
> "md4c2 0xffffff808ef05400" and then keep hitting return on the "kdb>"
> prompt that you'll read more and more memory. For instance:
>   [5]kdb> md4c2 0xffffff808ef05400
>   0xffffff808ef05400 00000204 00000000                     ........
>   [5]kdb>
>   0xffffff808ef05408 8235e000 00000000                     ..5.....
>   [5]kdb>
>   0xffffff808ef05410 00000003 00000001                     ........
>
> As a side effect of the way kdb works is implemented, you can get the
> same behavior as the above by typing the command again with no
> arguments. Though it seems unlikely anyone would do this it shouldn't
> really hurt:
>   [5]kdb> md4c2 0xffffff808ef05400
>   0xffffff808ef05400 00000204 00000000                     ........
>   [5]kdb> md4c2
>   0xffffff808ef05408 8235e000 00000000                     ..5.....
>   [5]kdb> md4c2
>   0xffffff808ef05410 00000003 00000001                     ........
>
> In general supporting "repeat" should be easy. If argc is 0 then we
> just copy the results of the arg parsing from the last time, making
> sure that the address has been updated. This is all handled nicely in
> the "if (argc == 0)" clause in kdb_md().
>
> Oddly, the "mdW" and "mdWcN" code seems to update "last_bytesperword"
> and "last_repeat", which doesn't seem like it should be necessary. It
> appears that this code is needed to make this use case work, though
> it's a bit unclear if this is truly an important feature to support:
>   [1]kdb> md2c3 0xffffff80c8e2b280
>   0xffffff80c8e2b280 0200 0000 0000                            ...
>   [1]kdb> md2c4
>   0xffffff80c8e2b286 0000 e000 8235 0000                       ...
>
> In order to abstract the code better, remove the code updating
> "last_bytesperword" and "last_repeat" from the "mdW" and "mdWcN"
> handling. This breaks the above case where the user tweaked "argv[0]"
> and then tried to somehow leverage the "repeat" code to do something
> smart, but that feels like it was a misfeature anyway.

I'm not too keen on "successfully" doing the wrong thing.

In that light I'd view this as a feature that is arguably simpler to
implement than it is to error check *not* implementing it. In other
words by the time you add error checking to the argc == 0 path to
spot mismatches then you are better off honouring the user request
rather then telling them they got it wrong.


Daniel.


PS I have never done so but I also wondered if it is reasonable to use
   this feature to manually decompose structures. For example:

     md1c1 structure_pointer; md1c7; md8c1; md8c1; md2c2

