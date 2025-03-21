Return-Path: <linux-kernel+bounces-570935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C6A6B663
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007F819C6D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445731F03F8;
	Fri, 21 Mar 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDMx7gzo"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BC1EFFBB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547217; cv=none; b=Sox77UcKUnS+bpk0dmGXT/vmwlvgOc2D8Qsn8sr0nstJNd9QU1DyBSqrP5puUFbRHfGSTNEJkGIvW/NfbD2c6Hcy18UfB5TS/2t68zpNkW3lT2fC+N/iYQCxBm6szm73k+oJvoUDpkiJirNJ3c50+hJvzfIkoytZ60lwaQeCruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547217; c=relaxed/simple;
	bh=vIw+xo/RVlg0K7NewC2ds9CYeI22kvETCWi6z+XQAyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGb28KuoxH1sTM4XrypGEuLPYak96W0w0BCoLoOWIIxZeypReVBGJpaSGMUlspqTkVe8hBLNsatDO+fmUKgl4u+qRlW52EjBk9ld2FpMulllJ2/IjBAzuEux1x6Qg9PA5xzoohZzX3yuCZFqAadFfF5xJVtB4hse2L32SdCVG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDMx7gzo; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e609cff9927so1242730276.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742547215; x=1743152015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rgcCLbhKsmIYAOgp/Js66iyzZCDf/tFpLepP96oubhU=;
        b=NDMx7gzoF2arimACgLXmWu/4aMLGWSlQ6LK8NNwmbWSyPeWAvl6qFUFAsh6Zg3WzOB
         By2XV12XUyegTE/TwGoKP7kYEyKuKdZPkDC5+1zTKL4JwbTR+WDSPxSS4TSR6079kEGE
         ZF7vaIknVYipfeheJUZj7rDp804VRPz2HWVg3Clt/H5ZJVpZR+Zvv5HLxd5CFxYVVvyD
         4+SYg4UpJVJF6JdqTUuEEroH1cEY3SasXx35s1Nlrhz13neY5wLV1qhNA4CJnJt3cuNd
         EjAX8BGGzrhC23eyHZXEkEr2by5RbF6NA8owH8B+KcuM+WTOv3Ay+3ZqNfYZcZKxG/db
         9eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742547215; x=1743152015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgcCLbhKsmIYAOgp/Js66iyzZCDf/tFpLepP96oubhU=;
        b=LDS5DFGGjMUpWfmpUwRlP0ahqYHc0yFNugK9cuoWgr3NzoE90WK0aTh6dLsRvAuxI8
         kC/ks0MMKdPCjq44xEhzHObgAv0DCsZOGJYbk38o5bt+A2b0bDnCuC49UhuPj9KeGcXm
         6L1pfGIWrzGvS/vp7VzLwG2Is8WYSSPIyNwulAplDBKguUuf1hj8uAmPJcrMligGwJEA
         WYACEyqPEc6DE9TAOideZtL+JkVZdXfmb5ukWhRFiEmcnUv+IqYg2Af1wU1DfKWuYYWm
         4hChD6Y4HcuV+YwMxazbhoC78obk3acBXavVWAuPV2s1L3Wx3vdDAXV6IB9Czmm5BKuR
         65zA==
X-Forwarded-Encrypted: i=1; AJvYcCUSuFPeLqn0xdlQqlC0mB4wb0X5dVGqiQruO/ZcbHbX8vB2aHriWDf8SDVWdXpVZjwxnq/rZhi/6hqjKdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2mW+cMf4pDsnh/w3GEYVgrs71c60BdCbGf1buLQR6ddq7dIk
	eG7rtWMvBhaAnUMKY+10n093bP5r8wGskAyo/SwUv1OhtPprk1Dm6F+E9vGNwfzHbVZ19p5r2l8
	QTmxjSIC46tXbcch2PExwM4/Pgp9u2yb4eMHlzeMFB3woFHMEhVg=
X-Gm-Gg: ASbGnculvLJZkxSSLPZwdqncgHV/26kwr76jFyk0jFXI3hWRNq6we50d+FYQDZz63od
	JmcwqB78gAl7bMmNCk79l//4A/dnG4BuKZFU32BUPBosSNiADNnDKlIaHOiQuyVN9DfRObvismF
	UG+fA+J+zEYYu8VRYC441Lu66IqIZ+qUSAzEhh9xeO0IbsUo/sEcf1xjOO0gw=
X-Google-Smtp-Source: AGHT+IGIA5O54XjDs3NqQwJeGdMi36x/C9LukWoKZoxYY9+RYJ4sWd1HYzkWqNeyhwHHu+idCoD8F4Fq7IsvO+NBSkE=
X-Received: by 2002:a05:690c:67c6:b0:6fb:9c08:4980 with SMTP id
 00721157ae682-700bacd6ac1mr34010717b3.27.1742547214831; Fri, 21 Mar 2025
 01:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321080918.1f8b90c4@canb.auug.org.au> <PH7PR16MB6196A1D9A7043FE4E69D8AFAE5DB2@PH7PR16MB6196.namprd16.prod.outlook.com>
 <PH7PR16MB6196B4BE63D7ED4D91E66BD3E5DB2@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB6196B4BE63D7ED4D91E66BD3E5DB2@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 21 Mar 2025 09:52:57 +0100
X-Gm-Features: AQ5f1Joyy04hP5ZqLNHiPsqFX5pzDqdwo1UJMfxtCqFw2cJyFhvslvysOB8BsFc
Message-ID: <CAPDyKFoMZbr+CDf0LeyQ_WxpTW=b_gGp5q8y-PPo+0MBNnyJJQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the mmc tree
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Mar 2025 at 08:33, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
> > > Hi all,
> > >
> > > In commit
> > >
> > >   79055e47336e ("mmc: core: Remove redundant null check")
> > >
> > > Fixes tag
> > >
> > >   Fixes: 737d220bb2be ("mmc: core: Add open-ended Ext memory
> > > addressing")
> > >
> > > has these problem(s):
> > >
> > >   - Target SHA1 does not exist
> > I was using Ulf's for/next branch, as I always do, and their the sha1 is
> > 737d220bb2be.
> > Should I be using different tree/branch ?
> I apologize.  Looks like 403a0293f1c2 does exist and presumably point to the same commit (impossible):
>
> commit 737d220bb2bef9efd43267c757faff003533b631
> Author: Avri Altman <avri.altman@wdc.com>
> Date:   Sun Oct 6 08:11:42 2024 +0300
>
>     mmc: core: Add open-ended Ext memory addressing
>
> commit 403a0293f1c230524e0185b31f69c02a6aed12c7
> Author: Avri Altman <avri.altman@wdc.com>
> Date:   Sun Oct 6 08:11:42 2024 +0300
>
>     mmc: core: Add open-ended Ext memory addressing
>
> I guess something in the metadata is different.

Sometimes I am re-basing my tree, so I am guessing the sha is from an
old tree/branch.

Anway I have moved to use 403a0293f1c2 as that should be the correct one.

[...]

Kind regards
Uffe

