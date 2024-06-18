Return-Path: <linux-kernel+bounces-219148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32990CA85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86C9282F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51781153575;
	Tue, 18 Jun 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UI8qinO7"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657A13AA22
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710680; cv=none; b=Dq/SFO99UjHVrtWXlmzybOmkScrpQXgzp5bYWyG29WdiKyCV1th27fbK1RPGSVyXuTEtBITzwT7x7Eh2fUzFGTKgJmRPM/AEIi7adHUTw8M4pt6YJeDYGb7DZB/WukAoaFnUJawfpbBNdj7OF8IjjU+Bf9bSvRkrwKADo7pqoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710680; c=relaxed/simple;
	bh=vDBnggGHduCLfhJYXpM1LddAUFFv7KUjf1LNrU4eBgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNRllJTvwDDY3molxZ5d60TWKb93byvgrQuxwBqOYlk8WWSd+OfQkmjl1suC63GrGIjdtWbv8510YJJB0hmJfw5Ze0BM9t/VCTNIWWTI5fWxGHxr09n3M4X3JuEP22avRVFUFTnzTk54DUx5ir1FI3f2okJoVdgP7hwQ/Y6IC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UI8qinO7; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so55627861fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718710677; x=1719315477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1nUX/w35W7jhWMOL3MjUXKKFpQa+k5Ifppyru0Gp1E=;
        b=UI8qinO7iZOsWo/sz6sSfgITneXR0gPir7d+PK0RCSOj1lKR+3soXntM7dVUEnVBMp
         hxErAtcVSU6ZdqSsJWo3iKC55ZWCmBbsu/9pcXYyn4f1jiFCrROZ6IXuYBFKizUxTUD9
         YfxZBRN1Sy7Yim6hRoQTNXN8hRWD9Ry14uTK3iM7RoIFellyMiHhBZzsShIjaBvLEw30
         qs8a/UG5IKYVg65ZbXtjxIhSTz19P63N658IcZMOHT5Qc0qnI0HWMciBCG73oDJuOuZa
         NZSzRRLxF0Kk8rTpeYkGIsFoI6Bv+kLxMMg2U+P+/Kfku2NmbYyB9/j12YaIAo0Aykwe
         Ne5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718710677; x=1719315477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1nUX/w35W7jhWMOL3MjUXKKFpQa+k5Ifppyru0Gp1E=;
        b=H35s6Q9xxWjS8sxvnLaYiag8HIUmbFSHxzO/2TLdBX06UjVpiiEjwb6BGYmdjzu6ur
         b13ibQ7JUOF3C3QBX84nfm7bOWbfNyKfsdLVIPUua2RRmW7c2fnIDz1x8QP0xcUpX9rc
         oLAnbGnzkDH8VN1l/jZhzgAHs2NaKXOxxugpvHa3ONJYDaYp1KU45pM9/LiYJ0ldEfJg
         fA7oWoTVFphHokagwKMMzS7RvUEvW9OWfyPWta40RsfEgBr2uCjKllxQzrQyxMhg0GhA
         cwJwUWONl0TPb1PH0SNWM6ZVQCGGkzQBdyUeAEIAP4tUF+0UtJEokY05zMGp+lZbHZ3N
         9keA==
X-Forwarded-Encrypted: i=1; AJvYcCVEvbyegxoCWTWUGXy4PWqEDaib/zUsYxXdlKTZ01eVecqOt4LzbXaXOzl3DVTKN8B+fWGzsKoN42XNPmiQXSAgEP+T6lQnFmqllVNw
X-Gm-Message-State: AOJu0Yxb+7jiL4ZUJLR7ZoOTpTgQ64MOutFgpW4t7fWX5Ddl9f7vc5Di
	dS6to28XY1t86FYFvVAQfVPRePqzmu2g5VvWCkK9/uvFQIIR7no0asKBcYk4wT4=
X-Google-Smtp-Source: AGHT+IHKBDNDrr5MqcJfCJ1fNOiBxzenrX3DYKCxbyPB94Mjsb6jjGhbiJQBUQAJuB6ysUQVSV7D1A==
X-Received: by 2002:a2e:3619:0:b0:2ec:1dfc:45bf with SMTP id 38308e7fff4ca-2ec1dfc46e6mr58898761fa.42.1718710676831;
        Tue, 18 Jun 2024 04:37:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e96f9sm225384615e9.26.2024.06.18.04.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:37:56 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:37:54 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] kdb: Remove "mdW" and "mdWcN" handling of "W" == 0
Message-ID: <20240618113754.GD11330@aspen.lan>
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.6.Ia1d546061f9430a90df0e7521097040e0e939c58@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617173426.6.Ia1d546061f9430a90df0e7521097040e0e939c58@changeid>

On Mon, Jun 17, 2024 at 05:34:40PM -0700, Douglas Anderson wrote:
> The "mdW" and "mdWcN" generally lets the user control more carefully
> what word size we display memory in and exactly how many words should
> be displayed. Specifically, "md4" says to display memory w/ 4
> bytes-per word and "md4c6" says to display 6 words of memory w/
> 4-bytes-per word.
>
> The kdb "md" implementation has a special rule for when "W" is 0. In
> this case:
> * If you run with "W" == 0 and you've never run a kdb "md" command
>   this reboot then it will pick 4 bytes-per-word, ignoring the normal
>   default from the environment.
> * If you run with "W" == 0 and you've run a kdb "md" command this
>   reboot then it will pick up the bytes per word of the last command.
>
> As an example:
>   [1]kdb> md2 0xffffff80c8e2b280 1
>   0xffffff80c8e2b280 0200 0000 0000 0000 e000 8235 0000 0000   ...
>   [1]kdb> md0 0xffffff80c8e2b280 1
>   0xffffff80c8e2b280 0200 0000 0000 0000 e000 8235 0000 0000   ...
>   [1]kdb> md 0xffffff80c8e2b280 1
>   0xffffff80c8e2b280 0000000000000200 000000008235e000   ...
>   [1]kdb> md0 0xffffff80c8e2b280 1
>   0xffffff80c8e2b280 0000000000000200 000000008235e000   ...
>
> This doesn't seem like particularly useful behavior and adds a bunch
> of complexity to the arg parsing. Remove it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  kernel/debug/kdb/kdb_main.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index c013b014a7d3..700b4e355545 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1611,11 +1611,6 @@ static int kdb_md(int argc, const char **argv)
>
>  	if (isdigit(argv[0][2])) {
>  		bytesperword = (int)(argv[0][2] - '0');
> -		if (bytesperword == 0) {
> -			bytesperword = last_bytesperword;
> -			if (bytesperword == 0)
> -				bytesperword = 4;
> -		}
>  		last_bytesperword = bytesperword;
>  		repeat = mdcount * 16 / bytesperword;

Isn't this now a divide-by-zero?


Daniel.

