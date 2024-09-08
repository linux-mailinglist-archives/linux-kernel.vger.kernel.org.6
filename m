Return-Path: <linux-kernel+bounces-320218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FA09707B5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180A31C213AC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C4166313;
	Sun,  8 Sep 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdUC/Uzv"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED061876
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725801185; cv=none; b=Z8SW9aDnQ9lGOoY0ne3vCIl5KwU/fX0LrL25XoXZ0Tw5oEbO1E1AvHfE4o9UbuRNEI60+XBJp/EcDqddvUjUv52r/hll2Ivwg4w/T0U4eHUT7Y6ldPaldQaCq8Pg04gtjCRVWcq2oMFtB5oOAKEzGEVZrDodHsds/X0gXYGkA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725801185; c=relaxed/simple;
	bh=NKiwk4E+1hUxFu6CCi5WcyZLUsFQZm+sYpKgdfCk1Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n15fl+wptAkgS1U43kPlTiJCpibRpBQm64a+KBBOwJ0xS3oNkIv9pu2kSebE9khD5S4BqQ9p5+QlDpZfhDCeehIGKanH2b6+8iS9Drd7890LvabHGER6wr0bl3PFOH7fZnUk0gYRLC3/JmwnSck77l32P2obqI68fwWMymKuHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdUC/Uzv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso2398671a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725801183; x=1726405983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QFv+GNCFsI4pY6KpEfbngQLTkjwWYYfX0SGlW8YyEU=;
        b=PdUC/UzvXFkGzgxHPfQcvvbcNIOTeyGb8uBa3mL11gmsHHTBU1oKisPGxjTfXS6GJu
         oPeBfwhhTAZ6+tVGVCnFJBLTlCheIEf2VO82ypI4/CpCHeeb5ufdfKuMGLnDVoEMG+LO
         JIItlygs7nnuSzx3eifPTa24gSOcTmmmlaKRShmXlcAUjTksFRSxIpLD4zv/l0XXrGLC
         Mpg8m0kJGLbyvr5iyK+SDShct4KmCpjxRmOk9sNtUoKYA97wDdduLJ5rqKVd7270ZTSy
         gmrqCh68b/tngU53UnEyoSuTcccwdEoWcY8/ComV5iKFGV8yBHk7zhTNhdZpRm+1RoLY
         Ny3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725801183; x=1726405983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QFv+GNCFsI4pY6KpEfbngQLTkjwWYYfX0SGlW8YyEU=;
        b=exJRZ3JeZkvwLwnEEHeHWU5fAvUsc6baCk7EB7EkZhWh3I7bdDsCDTaI8ZNWWBm+hm
         i5VGt+j9cFDdrp4E4M2wUpC/VsPa/48dL31vVUlRgeI5PAwnyHZEsDCzyC70JNp/l4Y1
         CrMwXCiPZAUHzuCmTnJ6ksoWkRmtvAg2BxOajGd/X1SjbU9KplDb64DhODKrhtcMqPDv
         h0Vw2a0g1MtV51RSwHj87oOAUWAdo2XbU6IxvzsnnppzGMqQxF1dARIs5XEedfQGasuL
         Ehih32zXyqppCj10TWpr7eHFJDjcIaSj5qTcylHHZUbS65epXgI5NHG3cCKLCdk2snJ6
         uaPw==
X-Forwarded-Encrypted: i=1; AJvYcCWxBXSVNNQu8gJemjFYPaOJK4iYbamHWyJiGZZDdbjRKcaUuGYKVYMsIze5wkdaspguL64xL5j2VSHRpfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9UjLZI7BrX3rwSqZLdAxNzHdMqVVJGfQP9+f+b92qHMQGxWH
	SzzSC6Cl4JfCaIvaAhwPcgZSkgapxOv0y6GKn5520IzKiG2ClbH0
X-Google-Smtp-Source: AGHT+IEfAWgV1CcdDM42hBbDeFjDbTFwOWDIC4d24tE1KlukJw+3/UVvLeds94DXNOk6wgRI4B09jA==
X-Received: by 2002:a17:90b:3846:b0:2da:89ac:75b9 with SMTP id 98e67ed59e1d1-2daffa7fcaamr6298933a91.11.1725801183059;
        Sun, 08 Sep 2024 06:13:03 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c3b65sm2721946a91.25.2024.09.08.06.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 06:13:02 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: andyshrk@163.com
Cc: airlied@gmail.com,
	andy.yan@rock-chips.com,
	daniel@ffwll.ch,
	didi.debian@cknow.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	minhuadotchen@gmail.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Subject: Re:Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
Date: Sun,  8 Sep 2024 21:12:37 +0800
Message-ID: <20240908131237.741-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175266d5.2a89.191cbb2a62e.Coremail.andyshrk@163.com>
References: <175266d5.2a89.191cbb2a62e.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>  DTC     arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>>  DTC     arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-wifi.dtbo
>>  DTC     arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>>  DTC     arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb
>>  DTC     arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb
>>  DTC     arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>>../init/main.c:192:12: sparse: warning: symbol 'envp_init' was not declared. Should it be static?
>>../init/main.c:290:16: sparse: warning: cast to restricted __le32
>>../init/main.c:291:16: sparse: warning: cast to restricted __le32
>>  CHECK   ../init/do_mounts.c
>
>>
>
>
>I can see same warnings， a lots of。
>And also see the warning in vop2：
>drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse: warning: symbol 'vop2_platform_driver' was not declared. Should it be static?
>
>
>Min Hua，If you are agree，I will split it from my patch， and add a Fix tag ，and also add a SoB of you， Then resend in My V3 series，this
>will make my patch series easier。

It looks good to me. Thank you and Diederik for commenting.

cheers,
Min-Hua

> >And several followed, including in c-code files. So I stopped the build
>>and assume you've identified a or several actual issues.
>>
>>I've seen several commits where changes were made because LLVM flagged
>>potentially problematic code, where GCC did not, so it's quite possible
>>you're on to something here.
>>
>>But it would be helpful if the commit message said what code was
>>potentially problematic and why. And then the proper fix for that could
>>indeed be to include `rockchip_drm_drv.h`.
>>
>>Cheers,
>>  Diederik

