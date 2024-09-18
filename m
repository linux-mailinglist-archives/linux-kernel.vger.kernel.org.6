Return-Path: <linux-kernel+bounces-332738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E997BE14
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4011F21E64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07AF1BAEFD;
	Wed, 18 Sep 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HaS7msaS"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10021BAEEF
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670453; cv=none; b=ZgylzQFtlEzdZzMWZcBMougFY46PjHPSv2Yeq82DMK1eBkQRYo2eMnGlK/OIGN1sxJPaecclr30K77G0Eue9fyJQwhY5GG/2zXo0qaxGKyGeTQW5CRYLc24kbNMh9QCqQS50Uv8XqYlLM8T1esqD3EdPVikWqer9Pu1qDkbmUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670453; c=relaxed/simple;
	bh=mT3ohME7te8T2As9CrdpUmPIESVaDC3Cl9Dhcw5IwvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+kxb0G+r6N2NIqVWu9jxH46wS/hZj/Jnw0ABVMKFQLNZxfnBtOWEuFvL6ZCFahXXhRV1y5Pgt8eMqHqwlvvsmVrs+vO8y09odmZQQZRjEmUCzIkPBpveXdBD7CNmQExtw+XZb5OnDldXIy3gLrqrJWbhLMyH9XuOJJBhZIjcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HaS7msaS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso1812216a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726670449; x=1727275249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2t1ItWJ3ig5qNarueJWrYx/kj01x5BbGfjJ8rjmQF4o=;
        b=HaS7msaSAFOth8TNAcHj7HDYoKXWe6YbCL/ndo9IJlfwqeL2aPx+obqlwD7kTtujcm
         nj/A/tPAfortjsylr1Uf2Ioe17jjZhqFcCNkKJft9XyJYuZ5/RFIZiFCeYXRPB5x1W3S
         4vit6z00DkxmEpr8FttvpvcK7tsY9RTfNiiOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726670449; x=1727275249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2t1ItWJ3ig5qNarueJWrYx/kj01x5BbGfjJ8rjmQF4o=;
        b=TwG6m2GURncqSRnw4M74PpNvR0sHWM8xdo8rtV2Gav1Ds2cQEyp+dtIm1i2WxihQTa
         uTpCdmddalDzgi9Ezq52dDiK/z1PcgPBj/Htm8Fa9scNwh/kFwp+UdKOL07b3M1LAAoX
         C45BMQX8+FsGIrIs62ev8V4rwjmblV8xCe0dWrZvddHjakst5zlvr8gmBBuwaEFeLfWY
         0gaR/gSF6NS98ZvSOiSuIKrF/skEtCuFzhEGtBEZk5vdbSG6JW07zokfiTvVmdV1CIMv
         vQ0d2HfR7ePnYdYUpaf1VTw2R2qgzUUv217PTvd9f5RNihYUFsDMona/NdrWdv8zERgU
         H2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8KhziDSBKhNi6h15yQghYM0gz+lAebzL6YLYlemxTWcYDiQAAUkM4ODWR1yTl1WTtBOK8l16QBqdtXQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VN8V5XIJwZtZwSnqzkj7uggGZkSgEdBwLxiHD4O8xFJznpjK
	LiDUQtc8yarYJ3g9gjvpapiGoCsMOEeQYcBuLl24uAC4e+0prwwTc715I9+sBKyR2WAVK8CEEXP
	upP2p0A==
X-Google-Smtp-Source: AGHT+IG3pVGVs+iMEBkJpLMRpYllUDsDr6B7c6Tw/Pp4xzSmM+E9tx+tSxE2g1abWpYKrJx+Ab+yLg==
X-Received: by 2002:a05:6402:3591:b0:5c4:a0d:78eb with SMTP id 4fb4d7f45d1cf-5c40a0d9d19mr28981450a12.3.1726670448842;
        Wed, 18 Sep 2024 07:40:48 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb8a218sm5005534a12.62.2024.09.18.07.40.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 07:40:23 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso1810979a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:40:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmEhJB2eKlt3U3bvs3cbDo8+qjaJUSIY5skJUNinuwOVhsHAkUEQiouQrupiYgBUFHMre2xYhd2Q1leok=@vger.kernel.org
X-Received: by 2002:a05:6402:2189:b0:5c4:178a:7162 with SMTP id
 4fb4d7f45d1cf-5c4178a7270mr24593373a12.19.1726670413894; Wed, 18 Sep 2024
 07:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
 <Zurfz7CNeyxGrfRr@casper.infradead.org>
In-Reply-To: <Zurfz7CNeyxGrfRr@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 16:39:56 +0200
X-Gmail-Original-Message-ID: <CAHk-=whNqXvQywo305oixS-xkofRicUD-D+Nh-mLZ6cc-N3P5w@mail.gmail.com>
Message-ID: <CAHk-=whNqXvQywo305oixS-xkofRicUD-D+Nh-mLZ6cc-N3P5w@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 16:12, Matthew Wilcox <willy@infradead.org> wrote:
>
>
> That's actually OK.  The first time around the loop, we haven't walked the
> tree, so we start from the top as you'd expect.  The only other reason to
> go around the loop again is that memory allocation failed for a node, and
> in that case we call xas_nomem() and that (effectively) calls xas_reset().

Well, that's quite subtle and undocumented. But yes, I see the
(open-coded) xas_reset() in xas_nomem().

So yes, in practice it seems to be only the xas_split_alloc() path in
there that can have this problem, but maybe this should at the very
least be very documented.

The fact that this bug was fixed basically entirely by mistake does
say "this is much too subtle".

Of course, the fact that an xas_reset() not only resets the walk, but
also clears any pending errors (because it's all the same "xa_node"
thing), doesn't make things more obvious. Because right now you
*could* treat errors as "cumulative", but if a xas_split_alloc() does
an xas_reset() on success, that means that it's actually a big
conceptual change and you can't do the "cumulative" thing any more.

End result: it would probably make sense to change "cas_split_alloc()"
to explicitly *not* have that "check xas_error() afterwards as if it
could be cumulative", and instead make it very clearly have no history
and change the semantics to

 (a) return the error - instead of having people have to check for
errors separately afterwards

 (b) do the xas_reset() in the success path

so that it explicitly does *not* work for accumulating previous errors
(which presumably was never really the intent of the interface, but
people certainly _could_ use it that way).

             Linus

