Return-Path: <linux-kernel+bounces-314701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1196B736
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B257C1C21D95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C941CEE8A;
	Wed,  4 Sep 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIsXgIZ7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F71CCEE6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443004; cv=none; b=mA6HPVcZ7KFG/1Jvsnu7d3snQT9cb/lAZfOrsVq7LxLA8ykatIZJ+isOAcYXZgzexyOtUgYfAUFQFwWOfA53NXmlWbR96XSWoMKUv/IOJ7gy4kYALoDWGEpso9wYKn6AUq3cz2Ia52oCzNDeNR7dhVf0zVGdytPHpnTi+fVBR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443004; c=relaxed/simple;
	bh=kl1VpBp0hN2mGM+lhSKLvBfxDKtkWSfiDDLjjHLOzOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AnvJcZDLzWcpCyOx2KlM/6oLlSWCGTSzX6xgs/nhpaJnqZKGmGZjmnwmDg7y2Z5Wv+OVza53KuoFTpdEtQkoFEU0cyn8/AiWwXtDe1S+Kttbfu/1wFXYimj2np+dSHtOoKdIjgRkcvVancrM2Q34hmOBCeTefs47y8u3kpUFdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIsXgIZ7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533463f6b16so791452e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725443001; x=1726047801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWZolsXsCTYach8lH36h3ott3yh0cTGFzhMl58gyIUQ=;
        b=UIsXgIZ7iSFUd6eAWnAi5KmH0T4qhLmMPzqqycMyMlD78IbECSNmHi30J8Muzrqkqd
         ATUUO+Vz2V8CyQp9il1jGg32xd20CNj/p8FZL8SLz3ypomleh9uKxaCxAQ8Dh/LCFLgm
         xchfVy15NhMtPjvK+6AnbcymnbZk4d3NWGVCrU6Xb3GRoFj2I1qqf3pciFvvUWrV7oUv
         1Yb2AmUuJq+c7/wyTaKZlfjPoGc5LIo7Il8aK5QeZK55fMUejYcTXwMtL8NjB+mCtiEW
         PkKy4Ls1sIB/fGqVnh32lEe9W4Is497eMDIKIqrItnktrE/Si8WNWkyvjSmGwIL5yMBg
         KdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725443001; x=1726047801;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWZolsXsCTYach8lH36h3ott3yh0cTGFzhMl58gyIUQ=;
        b=emI+rUVpN+4I4IhYXkOZ14TQW2hSvC/zZG7gHRIkZonXGkxa1nw1TZ7H7oowMprzu4
         eiZiRY/MMU00pugfOf5+OIKUGC13tbkurZhTpmAvYAFJ4DYaCG2n875kNMXiSGah2241
         PlkUPS7VsEHoljQr0r1S8LkNaO+F6kuysYn58kS5o9YHPev+Hla1negnTGNeW6yhCPFW
         Hbmpr7YdntlSemAt1WQtIS8qL+Nyo0qOOwseuoJUbL9TQnILPHXEotrEIYqxq/WOK7kg
         wDi3dCxCcHQH/HJmFi+2++KTeFZOwsj+kFxup+Ui5mo0LQMe0FdYHuG9eCxa76VJWNR3
         vSnA==
X-Forwarded-Encrypted: i=1; AJvYcCXc+M0ZctmcP8+PS1vbYRGtuFUDlg4/XXQwS9sZYjL8pC4gs2Lt/ygSGrWscVbxuG0aXFKpr3srloUpdUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27j53tn/R1F3KfaSzi8yiS1WnVvU2qBlwGUEN/52WJGFrdnVo
	YsD1STAVBYEKcwy31JRp9rqgLjCroQpnge9LdRuODZtzQ1H6xyPLt4/+bhuEWUc=
X-Google-Smtp-Source: AGHT+IHQzzEaWIdg5FQFeuNQ9jdB9UOFp8iR16R1FSzfKc0rt/an2lTY0zgJAfLv9/Z5bc7o2LfPBQ==
X-Received: by 2002:a05:6512:304b:b0:52e:9b4f:dd8c with SMTP id 2adb3069b0e04-53565f22b01mr1327352e87.35.1725443000659;
        Wed, 04 Sep 2024 02:43:20 -0700 (PDT)
Received: from [127.0.1.1] ([84.232.173.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fefb60sm788159666b.43.2024.09.04.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:43:20 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, richardcochran@gmail.com, 
 Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: o.rempel@pengutronix.de, lee@kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, netdev@vger.kernel.org, 
 Waibel Georg <Georg.Waibel@wiedemann-group.com>, 
 Appelt Andreas <Andreas.Appelt@wiedemann-group.com>
In-Reply-To: <AS1P250MB0608F9CE4009DCE65C61EEDEA9922@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB0608F9CE4009DCE65C61EEDEA9922@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Subject: Re: [PATCH 1/1] clk: imx6ul: fix clock parent for
 IMX6UL_CLK_ENETx_REF_SEL
Message-Id: <172544299910.2790271.1284838688580694607.b4-ty@linaro.org>
Date: Wed, 04 Sep 2024 12:43:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 02 Sep 2024 09:05:53 +0000, Michel Alex wrote:
> Commit 4e197ee880c24ecb63f7fe17449b3653bc64b03c ("clk: imx6ul: add
> ethernet refclock mux support") sets the internal clock as default
> ethernet clock.
> 
> Since IMX6UL_CLK_ENET_REF cannot be parent for IMX6UL_CLK_ENET1_REF_SEL,
> the call to clk_set_parent() fails. IMX6UL_CLK_ENET1_REF_125M is the correct
> parent and shall be used instead.
> Same applies for IMX6UL_CLK_ENET2_REF_SEL, for which IMX6UL_CLK_ENET2_REF_125M
> is the correct parent.
> 
> [...]

Applied, thanks!

[1/1] clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL
      commit: 32c055ef563c3a4a73a477839f591b1b170bde8e

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


