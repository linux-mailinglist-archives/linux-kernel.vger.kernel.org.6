Return-Path: <linux-kernel+bounces-216091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC3909B40
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 04:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B618B20DF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 02:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B216C6A4;
	Sun, 16 Jun 2024 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="bSiQjyQ9"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDB2B9AE
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718505063; cv=none; b=RZ60o++o6SqanJ+U85w7NuwS3az+S5F+PT0eTVIx7pIrS6NgcVGYX/pPY1LfsNGXrXm3nWOcwML8KmRYheXCManhNGqJoCCaR8wp772C5AUn91Hwec9ZxfNHN6JvqYl189NElkgkiV6nhmj05Lsj30QdTLUotgvCNBd1QkDebEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718505063; c=relaxed/simple;
	bh=YrpUnOnBfpPvxcN7Kn3yd+4s9tXe5sHEYq9JyDsAGzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgJhubz5FpcOhylFXfyuyBe1A4tF+N3cwkozANP1BoqNABk45BKRmcCaKwKlO9+8G+Q+hunx571CBsUd+qwcSbZ39oCkK63g22evplmI70P+KaL20b+ZGVr7YjDJFBX2g/+rVGylTizlOLIxBQzfi80TKr1fILbPv2AIKOJe1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=bSiQjyQ9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso2795860a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718505060; x=1719109860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVSak/2X/IwDlKdGQQzgvzyVeWSkvN8eQX8+7AouNcQ=;
        b=bSiQjyQ9cogxT/U+hcN3agRa0EqysNDiTJc559urMxmAnCGmEszXPhKEEqZ7fth78Z
         H6tnlGnhLkh7b1jPRNk//iSEnhk3e93ZCmt98SbAMwoLbqdfOzYpQ7SCQwlc75KxeX5s
         gK3L7jTTcHxSrbX77SmmRpkUsvhRbPt4a00strgCZbO8l3KyCb6NBszIkXjM46pU4xii
         hb299TthEJFA5HyKn+rUaSwbYbn51yDrGMrovMOZ2kxzh+NZnZzerVsZcEhz8iTEqkWS
         lSQ1w90enjktGXpAoTrJrW2YvQWjAgm56JtLnzjk8ZOQiTrhs/Y7FWmPbTIVaMhAB/Rb
         Bdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718505060; x=1719109860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVSak/2X/IwDlKdGQQzgvzyVeWSkvN8eQX8+7AouNcQ=;
        b=i1qJ+NsSYH+qy438JrokXWATcHzFn+Q5W+Cx8d4bHk3OsDLMoTLuRKj5FbBC4VN5j1
         SjxK9NudIl6GYOBeWH0jnphlhHPb79iLncvY8g7Haa8fBccUutUbX+mIRvvOkVGi/Lgq
         1/s0aDPdfva+rNo/ov7UYyEMcXchGt8azGorFLXQkqjKZmx/vADxPRZqKo+g3xcnYwn9
         mXKnk50hrdn9fa1u3hCo3+KaZPfJtBINfqxrhtnkbqqdU/HYPQx1UjwUNTm0+aXSSVLd
         PgV+6dTmcjtDs6Si/Ykyq4ExQMYBnt1l2laqxM0W0l9TUrneKhQJwqAMgZZZaqUH6vbW
         8NEw==
X-Forwarded-Encrypted: i=1; AJvYcCUxUdiuat3cLOFzUnEqb5GuT39gNU9j7RpH5Lt2ovQ1AliAl8i+26SyuOLP23cFu2hZPhj2DR67Z9wAQufvASspQoe+P2laZK1pZHoX
X-Gm-Message-State: AOJu0YzNn/WNqI30bBJ2qn8vkHRTpHsPPmgBEF8ZwulCiNR383xXmtrF
	ZXrdx9ZQvjjSaYXfSTlG4g8giXSrEju3Joh9Qw6f2uBd5HZTIayCyEjb/xVGoOE=
X-Google-Smtp-Source: AGHT+IG8MRFHbtUBSzVWOgxiGuIFdTVlR9rAtbWbkR9X+BbLOkQa3sOeajP3P9i4kf5dBJcOkBplbA==
X-Received: by 2002:a17:902:f683:b0:1f6:7f20:d988 with SMTP id d9443c01a7336-1f86280604cmr74376395ad.42.1718505059587;
        Sat, 15 Jun 2024 19:30:59 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:f6d1:94e2:a616:9280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e99sm56591445ad.4.2024.06.15.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 19:30:59 -0700 (PDT)
Date: Sat, 15 Jun 2024 19:30:57 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-of-dwcmshc: enhance framework
Message-ID: <Zm5OYfzMSv6hnCdL@x1>
References: <cover.1718241495.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718241495.git.unicorn_wang@outlook.com>

On Thu, Jun 13, 2024 at 09:42:03AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
> existing driver code could be optimized to facilitate expansion for
> the new soc. You can see another patch [sg2042-dwcmshc], which I am
> working on to add SG2042 to sdhci-of-dwcmshc.
> 
> By the way, although I believe this patch only optimizes the framework
> of the code and does not change the specific logic, simple verification
> is certainly better. Since I don't have rk35xx/th1520 related hardware,
> it would be greatly appreciated if someone could help verify it.
> 
> ---
> 
> Changes in v3:
>   
>   The patch series is based on latest 'next' branch of [mmc-git].
> 
>   Improved the dirvier code as per comments from Adrian Hunter.
>   Define new structure for dwcmshc platform data/ops. In addition, I organized
>   the code and classified the helper functions.
> 
>   Since the file changes were relatively large (though the functional logic did
>   not change much), I split the original patch into four for the convenience of
>   review.
> 
> Changes in v2:
> 
>   Rebased on latest 'next' branch of [mmc-git]. You can simply review or test the
>   patches at the link [2].
> 
> Changes in v1:
> 
>   The patch series is based on v6.9-rc1. You can simply review or test the
>   patches at the link [1].
> 
> Link: https://lore.kernel.org/linux-mmc/cover.1713258948.git.unicorn_wang@outlook.com/ [sg2042-dwcmshc]
> Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
> Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-mmc/cover.1714270290.git.unicorn_wang@outlook.com/ [2]
> 
> ---
> 
> Chen Wang (4):
>   mmc: sdhci-of-dwcmshc: adjust positions of helper routines
>   mmc: sdhci-of-dwcmshc: unify the naming of soc helper functions
>   mmc: sdhci-of-dwcmshc: extract init function for rk35xx/th1520
>   mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 598 ++++++++++++++++------------
>  1 file changed, 339 insertions(+), 259 deletions(-)
> 
> 
> base-commit: d6cd1206ffaaa890e81f5d1134856d9edd406ec6
> -- 
> 2.25.1
> 

I have tested successfully on top of 6.10-rc3 with the Lichee Pi 4a:

Tested-by: Drew Fustini <dfustini@tenstorrent.com> # TH1520

