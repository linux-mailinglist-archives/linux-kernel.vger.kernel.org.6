Return-Path: <linux-kernel+bounces-180504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433318C6F62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9001C21065
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C87E1;
	Thu, 16 May 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J6JKRPgZ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907737C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715817966; cv=none; b=gns5NobAN2VNmOyK7iltZcUQeMdjXZzOreMcV4Yul3FJTpmyKINqG2USu+wq4ghyEBsafWbY7XHhsf2W9tjRb+8F8ef668Vrr1alcaLeepmZoEVsU/JL8n3WKvvjubTKGWP+UF7hlEwsFXL2zlF6VUPENOaD+u3j238bni/gaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715817966; c=relaxed/simple;
	bh=s73D1lLnldVlOwSZAxVM3XApqcVdoaTgdGebWTRVkn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P81o9/Zz4NFuYAvMlVv55DlvkfE2PBjNZtaXk88Ig8Gtcr3Jt6TyX3Nb/e2XcB0FzKjSlCMzno2sOPaH7lc/vyH/y0FGOnCQDilvBx8/yKjp4rVlh1wWK1JevsIVM920eFTbNzgnGlCtdfuA51mtybBrov7dbzcBj9ppnLJNrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J6JKRPgZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e1fa824504so1905921fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715817962; x=1716422762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9uSO/C+TlKTnIQVTkiRs+aNrBDYs8IQvFyIDb79vDAQ=;
        b=J6JKRPgZZBGBowlBaiM5+9I48o4B//9lUekWpRNpYIFls6QBLBn/OZHLoLtepcZUKM
         2P/Ew5sbmYHDmBcy1atWlb97zpjOPjMnr6M3gIP+5VNWLwV0R86st3mEqqLUioKmb0D6
         Mjq2lXmSLT1UibJgQDwpxtnmAwYirRiyBRzzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715817962; x=1716422762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uSO/C+TlKTnIQVTkiRs+aNrBDYs8IQvFyIDb79vDAQ=;
        b=HqudGZtTxFWAUjLcniWn36b+R/gylxgXmswvFVsS8FRR5yQHAwmte/hxZsIZaetQXy
         CTsGDdCfsgVZEDfQryWpbgn1M011M4L6tjdaqeA+rYU0uDfsRSDqYtKq8/ePDTA9Aq3U
         V1baB9+vb1/tg1frCuvBIAMW/G5EZDOyFXpLemCLvzedBq2ochJ4na7xvy/Wx73pFOwP
         KV9K/X6Hmw3Ahy8CuCAR2QyauLAt4szIHWX+RowRcjp2kauIv67bdrdrWXR8MFke2hgA
         3NfS1zij7MI+T+W6MuHZ9F9ljeXQnMSEb1Z57HeWKUmjY/9PWEN3HQzwPC2apc4zMUXi
         Gbgg==
X-Forwarded-Encrypted: i=1; AJvYcCXGIhg7IL+jBXTY9PG+e8h+RUXTFpHAFxwHOGqgiaQEdiDTBhzrKHegCIC+bVFvOCF6Lv7zUOjLq4ARFGSKym7DulqMJEKEGVxQFRau
X-Gm-Message-State: AOJu0YxdbFegAGFP/vu0AdM8AMHc6Af1/R6Mw427lc80+bUIDTKtv5oq
	RdYdjFxOUp+aTxZGzFHkoaD8oKr6Ktfl3zI/NWaAEj/wIDA+1YiCMAe16OICZtCP8kDJDZ5jmO/
	w3lS1wA==
X-Google-Smtp-Source: AGHT+IGxZ7wDyPduqCnT3FNB/7uQ4rbJmCKdU+JfsnvPUwBAAhym7MHSJB4MZwsso5waI5ezgn+ZpQ==
X-Received: by 2002:a2e:9888:0:b0:2df:b6dd:dc24 with SMTP id 38308e7fff4ca-2e51fd4afc2mr118594881fa.8.1715817961391;
        Wed, 15 May 2024 17:06:01 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed000esm9827638a12.54.2024.05.15.17.06.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 17:06:00 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59cf8140d0so199911466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:06:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4ZmmTx9mf7PCTjIUW+QJSMoOwB2Exuz0lOC74IeKCTWPROfxGrOcCU9dlceayARvdOZ2Zme83aouvzQDF3yHcT2AwxGyYNMbW65ep
X-Received: by 2002:a17:906:31d7:b0:a59:c7d9:9d39 with SMTP id
 a640c23a62f3a-a5a2d54c0b5mr1162843166b.10.1715817960352; Wed, 15 May 2024
 17:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
 <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
 <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com>
 <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com> <CAPM=9ty=xoLrCJGx+TfcQe66pMCi5-9etPhhb7HgWUOHFM8dUw@mail.gmail.com>
In-Reply-To: <CAPM=9ty=xoLrCJGx+TfcQe66pMCi5-9etPhhb7HgWUOHFM8dUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 17:05:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizH1b8vv67xVSoSHqp5B=dNsqtpP+86RM7G5z14nuRHw@mail.gmail.com>
Message-ID: <CAHk-=wizH1b8vv67xVSoSHqp5B=dNsqtpP+86RM7G5z14nuRHw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 16:51, Dave Airlie <airlied@gmail.com> wrote:
>
> > Let's see if the machine ends up being stable now. It took several
> > hours for the "scary messages" state to turn into the "hung machine"
> > state, so they *could* have been independent issues, but it seems a
> > bit unlikely.
>
> This worries me actually, it's possible this warn could cause a
> problem, but I'm not convinced it should have machine ending
> properties without some sort of different error at the end, so I'd
> keep an eye open here.

Well, since I'm a big believer in dogfooding, I always run my own
kernel even during the merge window. I don't reboot between each pull,
but I try to basically reboot daily.

And it's entirely possible that the eventual "bad page flags" error -
which is what I think triggered the eventual hang - is something else
that came in during this merge window.

I haven't actually gotten the -mm changes from Andrew yet, but it did
happen in the btrfs kworker, and I have merged the btrfs changes for
6.10.  So maybe they are the cause.

I was blaming the DRM case mainly because it clearly *was* about some
kind of allocation management, and I got a *lot* of those warnings:

    $ journalctl -b -1 | grep 'WARNING: CPU' | wc -1
      16015

but let's see if it happens with my amdgpu reverts in place, and no
drm warnings.

It most definitely wouldn't be the first time we had multiple
independent bugs during the merge window ;/

              Linus

