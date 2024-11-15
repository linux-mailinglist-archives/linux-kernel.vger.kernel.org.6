Return-Path: <linux-kernel+bounces-410603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E019CDDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4139282A51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13331B6D1F;
	Fri, 15 Nov 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cZvkPU1F"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E41B85CC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671944; cv=none; b=bcg+NTQvfxd9e0wwuhqytn7CYxovirBgvg0NKjtwHyLE9ZD4Fe8n4IA522YNJli+38nLPfuCxQRmmmyLT6UCf5MaNSVuEuhQk7WwGrOcWoxwD56JDR7nNsPsu5IlMJ1/c7uIldf8gu3ONje9cAB/rttyWRY6XkURjjd1Ohma8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671944; c=relaxed/simple;
	bh=HTGuyqghFMpQLRstslb57s6VUDSp1VzcCf57gtfUdOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+VXOIXLgDOHX04UPo95YxKzrOZomzxnMP7wjwePumAeP0+ux3S6pZF9Yvw0ti+79ydb1Obsy2kMkstVGAZgdhEw94DqWPQEOMp6e19NvAPyqQz8PgkGmgFBX2sAsQP1N5asPzv9+c6SKdkqeTUzrqR9mb44s20C3AKsQ6veYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cZvkPU1F; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so17563331fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731671940; x=1732276740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXwHEadxWmCoxLkoyLtprE1vuyARVAjxnpelz5IPf9Y=;
        b=cZvkPU1FRN0JGdn1zTkNB5pY0cZE9x5uqvH+miAewaZ69n2gjpjzh4a8XifDO8ERIx
         ADrmXOWyieSFa7Nr/13hRw1Ur1dfBuix1nYWNNLK22z6EqpoJvmcGNV7sp0ClfKb/WgL
         AgYngDJvCD9nJWy9cLjS30W8+C0VpXDx6MOAjspW32zjmMa/RKwSs43UmV5ajGIK35jj
         Z2Belk8hFVaf/z8AmnJQ8fdhh9p9jVi9npgKiZROteaM/zRxLQP6iU+Sy31M5tDjWsRy
         Be0NNxdep34p8v96mn3dzZ6b/JLCDAucHRRF1wIO7eyNA3lWqoW/WzrELfyJbOE6Zgxa
         VgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671940; x=1732276740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXwHEadxWmCoxLkoyLtprE1vuyARVAjxnpelz5IPf9Y=;
        b=oAfk9g5eDlQmHo/cIuLl7bvDhcWNHv8cRLolGN57ENlldC9FZXd/AgEJwiYMELPUUh
         p6G3bbuSEh4eBf0FPUsQFWvjJY0MN0sSAYC4uS1rVsOzPbfDpkwaT+hskrLP8FoS4aO0
         3DdDkgDnlj8fZdRxuZ1jl3lFTbeNVYsbMyd3wdtuhcKs04980RfoxH/4mGEcT9kGdNLr
         KYYdnol9JSeBGkQhUHB9A9wiyAavnV6SLIwSuw4mpdMuC4mN+vbRyD+fen5v16bBSS+X
         6SRQpyQx5RWMuVH5DmHE2odZHw5Kqi+stXlcMDOnzu9hwE1beHh/FSVF81KahoKLJN+Y
         +w+w==
X-Forwarded-Encrypted: i=1; AJvYcCVyCRlQkIHfBmT/NoHB9lHMBJ2dvefYGWHqNHGJbWZLZTm0O70oHH9pMbL4Hf/+9xbzJEXto0mOZk/Vnjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9dFAG9iRyeKuK8dNPeiWEjCyISCaPwx3NFdwSznGD+fi2zt5
	tsL3CLi95/T6N+9fvtlWK6vxFmmii/AunwC+7HEEbkg2Y87/jPnaftv/EOlWLoI4RQhLxt+S/xt
	16Bja/3dXUep+9XfTBoje5yYIuenz2RMU8CCjoA==
X-Google-Smtp-Source: AGHT+IF0nsR2k8u6MoTlNgkeSprRNolHD2YJ9vJ829LyOHGCWai/LvnLaLM3UhO2dd/h8Cvtta4ugz2CwMMNB/wzaxA=
X-Received: by 2002:a05:651c:2212:b0:2ef:21b3:cdef with SMTP id
 38308e7fff4ca-2ff609a6c1cmr15902051fa.25.1731671940255; Fri, 15 Nov 2024
 03:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112201659.16785-1-surajsonawane0215@gmail.com>
 <ZzcWGJxqMJVYd4Tp@black.fi.intel.com> <f9daa71f-cba7-4086-a523-a2e6aa526ff3@stanley.mountain>
In-Reply-To: <f9daa71f-cba7-4086-a523-a2e6aa526ff3@stanley.mountain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 15 Nov 2024 12:58:48 +0100
Message-ID: <CAMRc=MfuC8rfag-8vxFqJ=qsXzsTpoBfvP+xWS9+rBdj0H0epQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-exar: replace division condition with direct comparison
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Suraj Sonawane <surajsonawane0215@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:55=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Uh, I had to think back...  I had forgotten that I actually published tha=
t
> check.  I can unpublish it.
>
> I wrote it based on a real issue, and then when I looked at the warnings =
quite
> a few places wrote code like "if (x / 4)" where they had intended to writ=
e if
> if ((x % 4) =3D=3D 0).  So it seemed like a good idea.
>
> But in the two years since I published the warning, it has mostly been fa=
lse
> positives.
>
> regards,
> dan carpenter
>

Ok, I dropped this patch from my queue. I typically trust smatch so I
picked it up without giving it much thought.

Bart

