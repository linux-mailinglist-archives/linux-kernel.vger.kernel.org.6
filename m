Return-Path: <linux-kernel+bounces-354766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA2994251
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D161E1C253E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA741DED70;
	Tue,  8 Oct 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPv80auk"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0550537E9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375292; cv=none; b=dNcKBrWRSbSFkGWxOnUtNwiLK9kCHR25tU6ty5+hXVlyWuJ0wKKC755UuLO/DwXVwN3APXoyChTawN1/iuJa1RTQgNiTfK7GH6170aZinp5+pQmitEL4SNr4nh/51iInmRZ2JCxA/yGm1f/TCvQRFIDLHoKyGy24OacQ/NterqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375292; c=relaxed/simple;
	bh=dImWPU/BxlMZAX9hdjUlvNkdPt4Nc+OtlHFhtA1ztow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTauJZcYychARPzQsl7wInk5LbkuemAA/feR/pBGhwup7dkcH476b0SZ4cRxSNIwRilQEq812ui1jmw4ZoUf9PtS1gerLIyWLjeredn9xrQWUVpveU/MJYTu4uME/qBakizxVmIV/qoPnCgUuBRsiRYXebB6a1tFoc5vV2C6jZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MPv80auk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-208cf673b8dso58926345ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728375290; x=1728980090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0h80cpJbTKY9snEXjb48T6TTGldHGobiLvAdg9ndyJE=;
        b=MPv80aukav5lTFewxc27TqQQ4KpWMLgnPzkAmm635BtFHvl/Des2bSex34kEUXyIF1
         0Hr0Kjkn97ffqsC5+7jEYPk/fROCBm7IKlZTr6bWQHKHqEVOxrm2Zw9ROYPM1FyyDMBu
         WoN9bKDFpKv/7bTYtxnvoBWE9akRM5ahHlqpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375290; x=1728980090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h80cpJbTKY9snEXjb48T6TTGldHGobiLvAdg9ndyJE=;
        b=SkOo5N4Wzzzdj0ZkJ395HvxZzX+viOrPLxcXD1yGPAD7aNa1xFDlK4DyfxDGl3uTUx
         bWCnIHTQfAcAU22hVE0vQuduBgauSc93NZ1+7kaiXKragD/6+fdhyGBWcTOE6jehZ2YA
         FFi/nlZak/MHxti19U8lcNdnVLfNywWIrW3gYEqj8Hb0+Z7mMTMgv2dcs7U08pfLr4TZ
         RRHtpzI9MsI7FcX501ENSkCaiQXmmWwVTYzeV2JHdUkFOhdlqqSrWir5Z8EdCr92Hrk7
         XT+POZDw1CjP8NeEgvKUXX63gKzLnwtl1ve1srQLB5R5fMByGM+wdgdhu0k4Hf3Kg2z6
         D+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVPOFMMR3NhDuhVSQVQNM3vZm/zwLaaW+dsJmDhcWRScmCIYvY95bRY/wdn3XtZk9+7393L0k7y4eleUTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OCYrwMbrOxKaJKt2XZUVpyJEL+eRVUOcG8elTYqxDIG2w9fp
	iiXbLZ9cz4jkLyR+nKJ+puaz7Ikiu1egXEWxvAQQtNJF1jkoPWD/3GltVMIyhw==
X-Google-Smtp-Source: AGHT+IGtu1645imzPCSgJdgHdyAJGDlUUwPsS55faURj/n0zsXWGqvLNNPizXP2mkdPY9fimKxH55A==
X-Received: by 2002:a17:902:e550:b0:201:f83e:c25c with SMTP id d9443c01a7336-20bfdf6ae9cmr25646925ad.9.1728375290013;
        Tue, 08 Oct 2024 01:14:50 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b137fsm51168505ad.12.2024.10.08.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:14:49 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:14:45 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 0/4] arm64: dts: mt8183: Add i2c-scl-internal-delay-ns
Message-ID: <20241008081445.GA3999626@google.com>
References: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
 <01020191d6992288-f834e61d-ad1d-4de7-90b4-77525530532c-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020191d6992288-f834e61d-ad1d-4de7-90b4-77525530532c-000000@eu-west-1.amazonses.com>

On Mon, Sep 09, 2024 at 11:44:05AM +0000, AngeloGioacchino Del Regno wrote:
> Il 09/09/24 09:29, Hsin-Te Yuan ha scritto:
> > Add i2c-scl-internal-delay-ns for each device.
> > 
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> > Daolong Zhu (4):
> >        arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
> >        arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
> >        arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
> >        arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns
> > 
> >   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 3 +++
> >   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts   | 2 ++
> >   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts    | 3 +++
> >   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 3 +++
> >   4 files changed, 11 insertions(+)
> > ---
> > base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
> > change-id: 20240909-i2c-delay-6d202918ee0f
> > 
> > Best regards,
> 
> 
> For the entire series:
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

I guess this can be applied now?

ChenYu

