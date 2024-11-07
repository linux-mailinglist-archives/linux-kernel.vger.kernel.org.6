Return-Path: <linux-kernel+bounces-400048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D79C083D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17912855F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA38212632;
	Thu,  7 Nov 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SawnAXcy"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B720F5D5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987821; cv=none; b=daWdyCzFfBFSx1NEUq/x4vB5jY3UUBBIqmh3H3ZeiR1cqEweA/F93UbiBTIOsx5QgETTFWEA2QuwcvTMxgRJXYDpBFyqnKVDdZO1sO9tXJZtyHZI4vBEGHSk0fCbAF4S7Hk0+Z2boSi9rQIxsdj/sbJLIA9/7Mn7QLjNRg7Ru4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987821; c=relaxed/simple;
	bh=qnMMY1EBIMFNCCj4m0hlU1mf5a1ROCT94LHu26I+oyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8QuMVhsg3ZBUkIWaZEAVC4twD+CoFXt1fixkUlku3KKd1NcaYeGGVN6T0gxT9CAcJVi/KFm9/ieDcIdafspyxD/Wr8WM1yfzYF47/iVt6DorYSZh1GZvSgHTY9vhCXSx88PAgxpKJ7vclrkHTCk2kb9rDZxmdx+fgU7eVg0Y/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SawnAXcy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ceca7df7f0so1130009a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987817; x=1731592617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4NpyOY6rUFjw/BWN7djSiT97ykyDTjSO50iSeMBEZ0=;
        b=SawnAXcytegrbHUxWE//kKaAXr7G9KednCrMy4cAOm/eul7g++34ldE7et0RmMs6bb
         Ar1d/Or9YQYGNF/DyR9iwP4E93glbPo/Yt+5dqF+/kyQhlbjII19t+7AyMv4PLLi16MN
         lmsyFc7IJbfUZ9Mc81tmy786aHNRz7cJ4qq26utce6MTcUIVwmGLwg3R8ej2yvfGIcFj
         vh0u1HIx16J9a79upEUKlbZr9g8ESqc+gHjn7mIO7oIOdL2cvFwTJqh5+M4D0IAzcn5P
         /EOtyT5RzNY1T+BtiduqBf4EQPzPX8TUBlbiq0WapWylewUEVLYt5PiMD8OmN/+g4eP+
         vZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987817; x=1731592617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4NpyOY6rUFjw/BWN7djSiT97ykyDTjSO50iSeMBEZ0=;
        b=ADNXtsxSjGE/nEnzx9DY/4iTn3DmofeOX6IyFNRI/LEHjUn8VRQO3n/brS9KeuE40S
         +FUtfPCy6yIbHd798FZ/w7eU8phNkag0LTJbAvWcPz0m1R/SQp3e5VN4qBwjUlVbeC3O
         2uqSnUlz3+SZXHSnRlbFMb1/qZ2/InS5VXPWh6tz3jfFvFfa/zw7fP9B5iELZSBUB4n4
         sLFHWGwVcu1flMjTbf5nuSnO3erkH1qglHsUuzgAd3vHnzbiyyhK1U6oGw+NFpYj6fOv
         BVec1UBHj//VARMNTtAsPzA6gIX5qftHvEfblgx7sotYdbGN85JIyRkRQoEjilOsPHTi
         /bgg==
X-Forwarded-Encrypted: i=1; AJvYcCWjZSxiQcoa956JSX1Ul3tzLBHg2r0UHgcUBM5a/qboJlxE92nuOydnxeqNiImTkHbc2y7iRTbdjWtg+n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93F+1S6cKnOwzHeiHj4PDPTOh4crQqxf/aGxrLdLEP5hidHvg
	ziH4bF/057FPfviOhnFzutEvYd+f35cP/o0VdhedNKzYqW1w8Nh5pBbP8h4fb/s=
X-Google-Smtp-Source: AGHT+IGH/e4k1MIhd1tMRWeuprRyYe0nFe/9dywi2+snJ2+871SY5AWuiZ+eYzeGjIiiWkZbc4wxiQ==
X-Received: by 2002:a05:6402:d0e:b0:5c9:76f3:7d46 with SMTP id 4fb4d7f45d1cf-5ceb928c9damr15946992a12.21.1730987817587;
        Thu, 07 Nov 2024 05:56:57 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ed9fsm814147a12.62.2024.11.07.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:56:56 -0800 (PST)
Date: Thu, 7 Nov 2024 16:56:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] fs/9p: replace functions
 v9fs_cache_{register|unregister} with direct calls
Message-ID: <d410dce3-36ce-4663-94ca-25bad2f91ad4@suswa.mountain>
References: <20241107095756.10261-1-colin.i.king@gmail.com>
 <Zyyt0XUv0Ypl56qI@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyyt0XUv0Ypl56qI@codewreck.org>

On Thu, Nov 07, 2024 at 09:08:49PM +0900, Dominique Martinet wrote:
> Colin Ian King wrote on Thu, Nov 07, 2024 at 09:57:56AM +0000:
> > The helper functions v9fs_cache_register and v9fs_cache_unregister are
> > trivial helper functions that don't offer any extra functionality and
> > are unncessary. Replace them with direct calls to v9fs_init_inode_cache
> > and v9fs_destroy_inode_cache respectively to simplify the code.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Thanks!
> 
> Acked-by: Dominique Martinet <asmadeus@codewreck.org>
> 
> 
> @Dan, I don't have anything queued up 9p-wise so if you want to take it
> through the janitor tree it'll probably get in faster; otherwise (if
> you'd rather I take it or no reply in a while) I'll pick it up when
> other patches come in.

There isn't a janitor tree or any rush on this.  ;)

regards,
dan carpenter


