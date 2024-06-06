Return-Path: <linux-kernel+bounces-203964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEDD8FE25A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6957128382B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE273153BFB;
	Thu,  6 Jun 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAfALXqk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707E13E04F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665219; cv=none; b=CloVZ1e6FdeXjsU5aEQFuzfxDTt3LfvDnNyS+XbJjfuwgWxeSFhRf45qsL11EXgVhHQqFtCLr8NpUJQ8scl3aoopQEvPM7kGFzmWjrKuNUguLJm4U3PEVGidAGhyH2D8Xae0DLUhEy4Woptjt9kXRFlEkmiZmuDNBAniEiYFN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665219; c=relaxed/simple;
	bh=tLjnEJxTEbTUEOSitLDXul844uJlercAoqbBN7ytkNY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tDpPu8jF8RmAs6mPbeWh++UCQT8VaR9wzwrmArLXtjDz0BSpHLFnYdJK8ydzdfbprJVc5pzUgQPX2RIHIyw5d0Wr/LGAyTuqm77uiLigoGj9EiKUkVUwW7ofiDivyhAMOSHgktu3AshIqmkjUudDwvopZvHRKwhApfDxK8L+WqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eAfALXqk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42147970772so4767015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717665216; x=1718270016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeksLIX2BzaZCNAN7y72dDwBN6DfppMxjFM7Q5oi4xQ=;
        b=eAfALXqkuq+XB7rnL9sdxqyhCN0zq1cJZajhAUFQXBlbD1u9IfB8ZfjrJ13s1sBOGx
         M9L/5K7DCAq548EpVgw94MSreKROQ1IDVbhDo9w994oXL927R2YrZKDXQG7vhEt1/N74
         JDBKyNLTP4qvSroz86b20K9wla6rkHSWjWohNFsB/8pZUtotY3g5Z6Hq/JWyODKJ3OgM
         H8LMzAMkPJLgThik/oDXEd5hwZau+ZtOa6VMQa2KqydJseUHf1wRE8KFI2T8AT/Vyd27
         KpNgn8214G8bmaEW2SYFU/yXwpEmqyrow5IIZFCIbjEp5rGwcdkkjYTJWcWFmLZ63W1r
         rKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665216; x=1718270016;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeksLIX2BzaZCNAN7y72dDwBN6DfppMxjFM7Q5oi4xQ=;
        b=d+et6Ga8p0k+H0Ii6sCm7n6oOXGz3fZp0boe+AANSYcFisCr0GQBdWoAUBZqNM1BOt
         5+ng6pTDOAZbEvxWDO7p12jctaqg3nx6iXhW88Uu79x6kCPtHx2ZBSPsthWOuszRgPde
         WI5BqSmotkkZxlaFDy7lQW8FmKT2vYQO8cmnGjKMZ5V+I1RAmSDTNB6vkKRL1QJh8I3d
         H6revrnd/bf6bWClWhXrrJoMBT6ks9hgso0i1O+0+fPhGpEU073OE/wMLip8Vd5L6I7+
         hM2kNPUtvwZUYxEePeh4qV6RGKAJULkztO7wpyoFOB70CWBXeWc4T1DpQ4BgiSeN3Xri
         Stgg==
X-Forwarded-Encrypted: i=1; AJvYcCUSdRaweqTITXrOlzdpT73MKdpeU0KQKiIexoOdj1loU/R77GJyK3l3GtKgE73mNarK0JOs5H+rQqFUkAEeofupCUCLgw7JhcQQ3GqZ
X-Gm-Message-State: AOJu0Yw7n5zV4H/t3RZ4/Gkd2XbUrFYYbR24NwrH3iWTAbIEwXqfQdyY
	ujDW+wMHskrknzNZev8kpV8zuc0lTpfQLX/HhymaMA+qCO3peh2Yu7sUdTB9KCU=
X-Google-Smtp-Source: AGHT+IGiTcenUwmrVbwMZ8CWLNgOE8eMGra87A9ikPjy4LKrOALDBu62I+rUPEWsyHUIPgFuKNgcsw==
X-Received: by 2002:a05:600c:a03:b0:421:1d8:add4 with SMTP id 5b1f17b1804b1-4215634e602mr46190305e9.35.1717665215936;
        Thu, 06 Jun 2024 02:13:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a544bsm15038175e9.21.2024.06.06.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:13:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240604050752.3312468-1-christianshewitt@gmail.com>
References: <20240604050752.3312468-1-christianshewitt@gmail.com>
Subject: Re: [PATCH] soc: amlogic: meson-gx-socinfo: Add S905L ID
Message-Id: <171766521524.3911648.14792995642693649032.b4-ty@linaro.org>
Date: Thu, 06 Jun 2024 11:13:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Tue, 04 Jun 2024 05:07:52 +0000, Christian Hewitt wrote:
> Add the S905L SoC ID observed in several P271 boards:
> 
> kernel: soc soc0: Amlogic Meson GXLX (S905L) Revision 26:a (c1:2) Detected
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/drivers)

[1/1] soc: amlogic: meson-gx-socinfo: Add S905L ID
      https://git.kernel.org/amlogic/c/d1d0f1f6ff6013211e3ee00237e4cc25ad0cd64b

These changes has been applied on the intermediate git tree [1].

The v6.11/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


