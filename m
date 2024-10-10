Return-Path: <linux-kernel+bounces-358228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104AD997BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7BF1F245D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137219ABD8;
	Thu, 10 Oct 2024 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0EM1WTzy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBE6EB7D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533596; cv=none; b=Sz+opGfgPu5WUtDDhEkgx60pWh0HOqLGX8m76ijpNxGvRAQJM6rMEvCnJ5hngot/UaWvAQNTBXmrhoGDt76gf5JcNyfiJyI0i6GGDepkMx+B2Qhfoh/VjFTy74GEOKDnd/TNKnPbuzejTxAgLvWXSxTvSfytLLkPEKFQa0XErAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533596; c=relaxed/simple;
	bh=NeY05LlwBc0ajuq1r6Lvp+ySX0MuSaKuKFkUvi7MQXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmTG+O/pBGvynzLTKnic1CltrsEymy6MbXKFH5TmAK7SxiCpCDzzc1Faz6pkhVuA4b9ODodLg6P0FmpeSplcXnDwJKNVjZBdZDL7sgYO+/GFhFjT1r4uMgYoOrDahnfbxr/Bx5oq6OPjBieN8AsffhwCH82NlQkK1WzSrIuqCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0EM1WTzy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso521051a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728533592; x=1729138392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeY05LlwBc0ajuq1r6Lvp+ySX0MuSaKuKFkUvi7MQXQ=;
        b=0EM1WTzyfqEdVvrzi4s8pAh+ov2jymKnhbhUkSe4w8tgknr4M9A2n5tqynYtjFwuwF
         BRLAzPREE9IiyPEwWRvmZbu0FTHFMRRXeWDx8GH+rGDGQh+oaS/QMGNmGYERqQsvghAu
         XfV7I3FeNooMdZDIg6DznMY8sy2OZ8jmrCvNj+/nkIYFoflhZSfSzcQ6RLco4NFs4Snj
         gOI8ul0qpKx0hD715gOuaLwfiR3RqQ5J/dg45w8S4kptcMSFfNwf/SgjBzhSSSeXNIr5
         QqluuNBZUUEC4QEAuwyF4ywpKA0iebvVnxYiO1g45w1xH3XqzGJ/zy/FP9crbasKpQVB
         rl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728533592; x=1729138392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeY05LlwBc0ajuq1r6Lvp+ySX0MuSaKuKFkUvi7MQXQ=;
        b=er99HhNOe4XJ5ZwFkuwG/vZtuRHlM1wQ0bYhOxNgWjTqRXwaH3qKc17GPv3lhsC4ye
         mA5fLytj6PzewILHNLGrMVknISLWkFrg5tZxoOhytDnMENElhHbGAzwAwNuPi8+8ix1Q
         wRKNk8tqCfV4eouHgU1SNJVU63b2Srktc/aEW1CcitMjdcabJLMaANjiiSr7gCBdvAiv
         9ARqAgFsc6vgxojkh7Uhzu8fpZ20v7s0wbr4EvM1XGdh5nEy53qnOS2m/YyIrK3J+nYE
         YwgQWEKZlDeFeQxbLm4bt+bVncFXt1K2DfH2cCOKLybTqbMLhBxoZJCzGIbYnaWGEIQh
         7jAA==
X-Forwarded-Encrypted: i=1; AJvYcCXLZw/CaQTFOmmueGok3z209ALLu4hqySpOnlBV4ohLiCdXKvrZOMIavPSBT5TwvSlI1xm2ZtdGRGUoAWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy309U7SfaG91wUna1fduSQ3IGoTmg4ykdwQZEmZ1E5+/KMNu7D
	RJrnArrFJ43drh21MIy2h1mGb7Ppbw/n7SU2oGdWF1W2jy1PPJ79LBOemZn+k3BT/J5aNVMhyLK
	p8Hnc4kNbysqeA/jSlXSbMTzqUsJ22HNzP6o5
X-Google-Smtp-Source: AGHT+IG+FVwH/Qj12xcjY3CkGWjMkdfNSI/LctZhiS6nktk17XPL2NZH4mbMaPk+5ew/hx877PmjHC+OTnmlCYT8uX0=
X-Received: by 2002:a05:6402:2742:b0:5c9:3428:20a4 with SMTP id
 4fb4d7f45d1cf-5c934282139mr901645a12.12.1728533591505; Wed, 09 Oct 2024
 21:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-4-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-4-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:13:00 +0200
Message-ID: <CANn89iKD5eMrQY2wz1JKMygQRhGn71ATSjhV_qWO7LH_693-3g@mail.gmail.com>
Subject: Re: [net-next v5 3/9] net: napi: Make gro_flush_timeout per-NAPI
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Johannes Berg <johannes.berg@intel.com>, 
	Breno Leitao <leitao@debian.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Allow per-NAPI gro_flush_timeout setting.
>
> The existing sysfs parameter is respected; writes to sysfs will write to
> all NAPI structs for the device and the net_device gro_flush_timeout
> field. Reads from sysfs will read from the net_device field.
>
> The ability to set gro_flush_timeout on specific NAPI instances will be
> added in a later commit, via netdev-genl.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

