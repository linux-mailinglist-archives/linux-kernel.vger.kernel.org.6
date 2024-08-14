Return-Path: <linux-kernel+bounces-286939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A395209E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112FD283187
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1E1BBBD1;
	Wed, 14 Aug 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9Luck5R"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11453FB3B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654857; cv=none; b=P10a4Vo8YnOHC8QVvwIJeE/xNZNBy0dp/4qLj4Kovpag6LDxqc0Q+hmc2MCrAOU60PpvemClEDEBfo9LSIetEzcR/1FpfnO/O4abdOiPox36Zl4YmNuSn/b1e8op3od3PAiM5y8dlKx1BSVOt3FB3sdwG4Lqg0iwDd5arnu+YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654857; c=relaxed/simple;
	bh=tMNKunLk5goW/y3VPPeJTH5gdtVob2YOFilXLryVWNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OabL7sRRKJWstqCJTYiUhmRw7nPwpbhW2aCyanKGFXwVUPRmfkJcYV8+a5oQH16bee/79NRJXr6w9gnqRkXlYql8JPepuaFmuyOzz1m7e1s1KzCe63lgdiDmHiJzHcjy45FBKoC4a/aXCHNlQCTy5AT3siy2PU3njUqKzz3pmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9Luck5R; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65fe1239f12so1740747b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723654854; x=1724259654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tMNKunLk5goW/y3VPPeJTH5gdtVob2YOFilXLryVWNQ=;
        b=b9Luck5RziTh8umvRJBV0/E+N89tPC8wwd+54j+PDPLcNtf5JPYUS/70lMh3DAN9IP
         gx3THKW/znXwd65L+R7MkkYra7f2LZaIhWZUgnT5jC6lPLmGhDBL5hcrsSvkyZulNO0H
         DVkyARHjy0qCk7AGeFuYKwUG8UJ2VzhQtO+MLeie/rTPZ6uvjSeo1YDGDWu/N/AewJ0G
         jWHLVX9rdSN2UUiAkRNAlRnV3/azOrLQotqn5PoFZbvwwRI8ZK9YYQbXR6djL9mPENnj
         nHNMLACmaBaMhZWKDXA89pUbptIAmD4NhH/h8/7oHhICvYK348MV51hcL8SolRbHH2OA
         FPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654854; x=1724259654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMNKunLk5goW/y3VPPeJTH5gdtVob2YOFilXLryVWNQ=;
        b=GFFQPP/B7qGWBBjPFOJ1aaYAKVpvCTVU7i6d3EEQZyNUz2YVyY5GfEgQahGnBG76Pi
         TwLhcRClYHl3iLIUdJx2XRRzQFJckHI3cxBLPjWJhuvTBJFpUaCl8LksnOcm8X3/0LgU
         dLBvhRf0CRXjfNxqgMOD7nwRHBgsOFO3llSJKlS7mnafLbPebpwOSS6DrLPTfAh8yUDI
         X8Z2Bm8rctMnberGwbhB2a0BpV99ALcMRSx0kCg83n8Jri8VL8+v0aPFMHHBRSwXQUQ5
         G+h8cFZx7B3Nmzlntha5/NZ9J4eM424c8bktXl2RioGPiZ/V2TQP6aaE91TCMn1krZVM
         zdXg==
X-Forwarded-Encrypted: i=1; AJvYcCUw75hyE9a5Ifn22CrujtiLlDUPt7YsNFIGloxWSG9Vb6V9IwOFy0PHWTP9wnHGUKLHWFu3ShkC1gFhLKCyJkgQVI7GwfLGrpZQ3keR
X-Gm-Message-State: AOJu0Yw0168sUV6uhYI8B5eUNQKBaGerdv4+F0Yos8q4IYNtQYyLv1h8
	nPHLQy/DvtqMgtIub1kwD59M6+2cTMcZZdvU3kb9W7UNR20yK762gyZDSnCEPf3n+6nrlDsLpln
	nguzY/8vBgkz5jacoiAazrn2jayQII5iyeEhVMg==
X-Google-Smtp-Source: AGHT+IFOk3VYqWbTKciKOosTCRuiEV6h3yG1e9kqTFin1Q7BiOL3QiVjeZp7p4oYQKYKWFnzBhvwTS75twwWuDvHaNo=
X-Received: by 2002:a05:690c:3103:b0:62f:67b4:790c with SMTP id
 00721157ae682-6ac97b10984mr33941527b3.14.1723654854591; Wed, 14 Aug 2024
 10:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813190639.154983-1-brgl@bgdev.pl> <172365034673.2714461.1759726822181293291.robh@kernel.org>
In-Reply-To: <172365034673.2714461.1759726822181293291.robh@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 14 Aug 2024 19:00:41 +0200
Message-ID: <CACMJSesrLxbgSFBOtdNsvkYv+3ytNPrws6h_DM+xFmjiw3yUzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sc8280xp: enable WLAN and Bluetooth
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 17:48, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>

Bindings were sent separately.

Bart

