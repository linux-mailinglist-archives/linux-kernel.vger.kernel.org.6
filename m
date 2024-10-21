Return-Path: <linux-kernel+bounces-374063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D5D9A6182
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B33D284F72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3E1E7C2D;
	Mon, 21 Oct 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekeUIhGo"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E81E47DA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505178; cv=none; b=AFUh6YzlFjezU38nHnzj3TMKV7ha1qD5kPq6LcWojw1T95kbBf/xEtjo0tJ0zWKTmFt2eGAYMbPzxOtrD12FIXK8dW7n3AXXUyll6PjnhPyGdCpIfUBsd7VMtaQUfqtbn3DNKOkBA4orkIQCCyuAGdkfiCvDpYAXuz4LCSzB1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505178; c=relaxed/simple;
	bh=IkIwaxiVQnThLvGv0yyixcoZ/tGJwbeD68R0Qi8SrPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5OJGesvVe5s0Ard2JbcEv2qaEmIZoglH9U4aQZJGVLT9+uJqt9s+A90jwNG2xWRdah9P48eU9KXEcYJzkiOnoiNiXwSCevvWhdAWpP/NqCPlHXaFUi86chG2PQx3B75XxjKz1krcb7aECMjgnj6KjwsH1ZpcZGQ53RhHa9bJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ekeUIhGo; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e35f08e23eso38786767b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729505175; x=1730109975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GsmefuCLy3782StxBxP88Vmmv8aDiOgUgCUBIcd2Ybk=;
        b=ekeUIhGoDf1doLlsnYp/mpGeZEL1nbiYAXWbfae3/TjZazJRB9b4/yyvsO1N9QOY1s
         aaXAtt0sUHf8HYF4YIWp/KejB6N1FTzdgaYOrUxK0sSF71eIZEX5ohmWh6l4S5YAihjT
         M0vLaIku9mP6rdoNUCVkKsVtBga9sbPSudSUEIXQGtMdckiLqnvb5HlBO/IAQfZB5Qkk
         ujidnX6RpDUqI9BXMDHRU+PrvTSOCFHhQkjbh/5be86cmTW+Ypr2faQWz4Zj4PAB1Hfa
         vdZYslrrZ2ZLQprSzoAjfzvC7pt8gw1IVDxzwQ6bYi+Vq+JHINHfh/QFNGWeFlZJyLYI
         2eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505175; x=1730109975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsmefuCLy3782StxBxP88Vmmv8aDiOgUgCUBIcd2Ybk=;
        b=J47SEU8OnbFzyG5mS+5aazx89rpuw7aY1R/j7R+58D1g9tQbm71RKremS+dc0T+3n0
         yeyCldPPEHfojay0jtvdZijPgzRDrLpUBTiD6xK+i40vZqeTFGDNMm55LP+p7xDqB3UT
         CXM280GV1AAnKzuj0lQ8AEru2xHqcoY/gg+O3sgNI/kc1vgRnYLLouOQs4Oz2NHxwDHU
         gp+RF2blskWDnL8Av0H6pYMGsCUEonVO6St2JOGVkMnBpvxCAEsHyTYQBM2d4/22xUbB
         ZRsku8Ead6+GxlY90pTWCfrdJeWg7On660XV+BaWs7dFTuB2DK6VmOj4+oA4hh8ZzQFi
         NqOA==
X-Forwarded-Encrypted: i=1; AJvYcCWbWdOyB7XTHWdvfKPBTbY3SajMsmfhyt2ZVl0mYEI9vuK1gZ1wFMbQs1D7IDqH9M8bjJQkxS1PzkGF014=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLeTolYvwCP5ezpf+nzdDL6EqFMDzMiFSPT46ifNJeIFvSK78w
	MvZNLbif1bYGsKCLYteBvn4rfKbl42B54hWgDjZtbGjDXq0y+iUKQPp6bLjPiiboHu5wGba2094
	cE9+OoYn5yZ+6aSvyvWa800tV2tFoVm/g5XqbRA==
X-Google-Smtp-Source: AGHT+IGOSTY2exEdjJUwtklxk91bFNLum+uKyLKxuCCBfJbzs2BqXrT/kAOjREMkniMhG0JWTTfDut+gz1PbEoQ0YQ0=
X-Received: by 2002:a05:690c:87:b0:6e3:29ae:a3a5 with SMTP id
 00721157ae682-6e5bfd4f8c6mr101900967b3.34.1729505175322; Mon, 21 Oct 2024
 03:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019-sar2130p-phys-v1-0-bf06fcea2421@linaro.org>
 <20241019-sar2130p-phys-v1-1-bf06fcea2421@linaro.org> <ZxYEV-hS9NhlnhYZ@hovoldconsulting.com>
In-Reply-To: <ZxYEV-hS9NhlnhYZ@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 13:06:08 +0300
Message-ID: <CAA8EJpo++Oo2CfG3E56piuyFW4yBSC1qzcFwJMV2TizcrxZN5g@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-usb32dp: Add
 SAR2130P compatible
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 10:35, Johan Hovold <johan@kernel.org> wrote:
>
> On Sat, Oct 19, 2024 at 06:44:50PM +0300, Dmitry Baryshkov wrote:
> > Document compatible for the USB+DP Combo PHY on SAR2130P platform.
>
> Looks like you got the patch prefix wrong (it should include 'usb43dp').

Right...


-- 
With best wishes
Dmitry

