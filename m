Return-Path: <linux-kernel+bounces-558648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E08BA5E90C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A78189B3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE7F9C1;
	Thu, 13 Mar 2025 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+aBCsNf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763B15E90
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741826553; cv=none; b=TMFlBImdLG1h7rrggHTY8XDGXlx1ovjEh18v41S5uSzb0C7fsuXmUhFKWQxvBdtk5XTKmE7ZGWYjEq/PBffKGf+tKt5fmFljtv53gYzKlGiaI1cCfXx6MHnXkPLE2h+pe+KVz6qFNE8FHxasHmiRRhnKdp7QS+CAbdViWur+mOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741826553; c=relaxed/simple;
	bh=ig288ShW6uf9Gfh2KEd67PQ2IpnjkJQ1Avi5bcKW4BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op3AMUhk4z8Ll6j8JLOrIuEsz/aDxOgLUUUmekZMMu1KPye7f2j9NRL4U1x/nIHRjh8AK1eHwXlwO1GNEr1tpMIDkv7pu44wlxbUkXqVpXlVbHIlNRsOCNQgr70hrywk2mDScsh2Gs/fFJwhnkVbu6h5zOJ5F/sr7ByFUYhxgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N+aBCsNf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5497590ffbbso422917e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741826549; x=1742431349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aokOw4JpMhMtQebNFKUI7JxGsy/Gt1nWUW1Lw1QEB/8=;
        b=N+aBCsNfN4LWs1naizfU8UhjiXtlGUuuA0hGCRAh8qxuyU6jVHVvNiN8blAVOxGH0e
         SXJm67nKoZ5X2uYIRuKdILqP/AdcepYmZ5a2wpGx+V3zWIWJgciEhOVDIDy7wjkGdkK8
         54YcovTjZ8bn3QObZ5MeRGMF+anVcXUUquhvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741826549; x=1742431349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aokOw4JpMhMtQebNFKUI7JxGsy/Gt1nWUW1Lw1QEB/8=;
        b=w0m9igthztJoMxQbh12CC0plSQJ78pc8wLy4myVhYcVHb9MGpmt4UxxXlAwSsW/ZB0
         Xgo5FB/C/35XUUNuTUrsK3+JyXLBnnDdaIhSa1BsMuyndWojkIPBC+YW2t010EYiKUDZ
         BaOBrRjNJmlCqeS0iAVNjjZmfGToPkopVMwsCET4YO47QPVQbLjLXXRPfLsEasG2VUn6
         TPTFiC8dr09iBx/xjKuJRKjb0QpkGjLDPPpDh7TYPDRZv/5xGFyEid27kEALvw/CGyU+
         YyATjgEZeaxC5AJ7OTWb8ol9prmncgNrBchxBidRD2kIzqN6fub5n3Ax++CejiaNwv4J
         4OFw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJZKHtGqZDjCNLWARInXmpPccwteN8GeyMz449nrKgdf4V4t9pGR22QQlAg1sH7AVbbOfYMMvC0d2/+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ql8vqekByew4fO0HhqU+yR7DSB1qHSm7sYy6O/pMTsoylvvY
	8qn6n8iElnYGLdO7uF/QV3oeBiHEgmKol3JbBAJReTyPxBudTVvwkQQ/XjgpwUg8NnBVE6ig7y7
	XVJY0
X-Gm-Gg: ASbGncugKaqA6LvFTX4+UPHK3Bc4tnHtklimYrGfcAPwUjfY7quOYutPYlG3xjntEfM
	1I6i7GFSCrdnhVyJYW6JsPK+fBB1MiEhrXgLPl2YQTWhOSHiF5bY2HCXNsf6o1G8h5sdpc6Ebxy
	eENouOwnVvTKP2UJ3SyuDZwTM/+xnL0e+6mTaeN1guTrB7BvXrTi05J93WeqG4RgT+IwSXJQr8j
	KY/KJUJxxXe8G+QKU7U3HCu+52WzMDT7wjIt9h/fyOLg0xHnBMIVvMUPFCpYaJ+YQS4+NhPiq+8
	4O7eGEEPdiOGwy8vS8aYYu3fzHuK/zo9AncFu3+vlRImggLRJz7sJb2V/D+5k++uXD+Nyxb+iIq
	I4KUnzJox
X-Google-Smtp-Source: AGHT+IGE5jkgjjaEV2W+SShFDFsLN5yxLStCLquVFrmG2Lfw/VnmKm1mEzr+VI1UeG0RXqyoYcbg1A==
X-Received: by 2002:a05:6512:33d5:b0:549:8f06:8229 with SMTP id 2adb3069b0e04-549910e8abdmr9925020e87.49.1741826548654;
        Wed, 12 Mar 2025 17:42:28 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864fd5sm34280e87.115.2025.03.12.17.42.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 17:42:26 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54298ec925bso653166e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNOtywf3nRVv649eNGFAsDt2fnBH0nwAvFiIb7y8IOzh+zNo8nWyI20UHGwwFs/45SVAM61uZQYP/joyY=@vger.kernel.org
X-Received: by 2002:a05:6512:1255:b0:545:f0a:bf50 with SMTP id
 2adb3069b0e04-549910b5d89mr8085069e87.35.1741826546215; Wed, 12 Mar 2025
 17:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311091803.31026-1-ceggers@arri.de>
In-Reply-To: <20250311091803.31026-1-ceggers@arri.de>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 17:42:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBUN+DERvSdZn67FUvyT+U_CNJs0HUdHooSZSK2F6Nsw@mail.gmail.com>
X-Gm-Features: AQ5f1JqK--WuCFQMRsSDI8hPU1ACy47TUHjlGUN2x6HSPjgBp2xFsOB9wkyF5O8
Message-ID: <CAD=FV=UBUN+DERvSdZn67FUvyT+U_CNJs0HUdHooSZSK2F6Nsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: dummy: force synchronous probing
To: Christian Eggers <ceggers@arri.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 11, 2025 at 2:18=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Sometimes I get a NULL pointer dereference at boot time in kobject_get()
> with the following call stack:
>
> anatop_regulator_probe()
>  devm_regulator_register()
>   regulator_register()
>    regulator_resolve_supply()
>     kobject_get()
>
> By placing some extra BUG_ON() statements I could verify that this is
> raised because probing of the 'dummy' regulator driver is not completed
> ('dummy_regulator_rdev' is still NULL).
>
> In the JTAG debugger I can see that dummy_regulator_probe() and
> anatop_regulator_probe() can be run by different kernel threads
> (kworker/u4:*).  I haven't further investigated whether this can be
> changed or if there are other possibilities to force synchronization
> between these two probe routines.  On the other hand I don't expect much
> boot time penalty by probing the 'dummy' regulator synchronously.
>
> Cc: stable@vger.kernel.org
> Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for driver=
s that existed in 4.14")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> v2:
> - no changes
>
>  drivers/regulator/dummy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Not that it should really hurt, but do we need both commit
cfaf53cb472e ("regulator: check that dummy regulator has been probed
before using it") and this one? It seems like commit cfaf53cb472e
("regulator: check that dummy regulator has been probed before using
it") would be sufficient and we don't really need to force the
regulator to synchronous probing.

...not that I expect the dummy probing synchronously to be a big deal,
I just want to make sure I understand.

-Doug

