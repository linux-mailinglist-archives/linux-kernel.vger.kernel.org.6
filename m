Return-Path: <linux-kernel+bounces-245824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F492B9F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FEB1F22616
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88C415B980;
	Tue,  9 Jul 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvDFbFxi"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75E15920E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529389; cv=none; b=WXvumQ5hPky2ZNp99k66PbDhbAOSWFf7e/q9g9C4Mr03LpINTj0YZ019FvCntdh7yo5D6AEiZ1tc8Cokns7RJo0tBUtONG1TZDMNqwJGwtuYlcXu3OHX5EZKCjasho61M+lo3yH0tO8yO4uatnAQFpyt7fywQOUYyYxkIaWVM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529389; c=relaxed/simple;
	bh=xLQj80Ax5A53kCDIEH0CeRwTcjiAv44v06SljeueDKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BhQPooALOMSfz/rpV+tGjXzFJlSKTy789B9h8jXCfklqmaAYu0hIOtuL3FPqX8ocjfudzaGVDvUdVTCLS6EuWR2IoI7d9IX2MPQfTXKaI6NBvuF5xTHAldYm/GrYiaFsDIcRBIatvUlfZDJJwFSbtc2+2lchZgp8dH8zjV9sbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HvDFbFxi; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee88c4443eso53977051fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720529386; x=1721134186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvRk9NRwvi4Sad8kAKb8C0nIgxvEumP7Jqs1X0zsqU4=;
        b=HvDFbFxi7UC41GCMxLhxNtKPuePF21BrkQkASHSqoLbDrG198pbknZQnSLZAcLXsTl
         ikGTEhACuIZgClzS4affS5VVsEHHon3sgET7kW5bQNIjSKSaYDgVJ68nVLiH+J+eEBtX
         lou8plpjH7hI6yyvf7vWYVoetg/Acv11VVZyOQ6UZKHUfOg03eH1MIv32DgOoY8MDuYb
         ug+rGkdfUCX35leKDnNkr0ATqmgKJM1M56XVPwDvNs6AIODoRfChjLvccI8zWHaMgUQs
         GQWsOymE81dfK/2akFaMP6ZQZkSuBRjsQFEiSnRoP+vAB/gm1QdKnDg6QwpOOU/IIdOy
         BSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529386; x=1721134186;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvRk9NRwvi4Sad8kAKb8C0nIgxvEumP7Jqs1X0zsqU4=;
        b=T3PdsEOzeJ9iUrI2obYZO97slizr0162VI08GpNpiXKFBWAJz3KnX6GhpvbYLhyubE
         H2GqK7XMvJUI3BAWlj9CfL+p6EVG/U81C8h4ZpPxACouDXj+TVw7dgDR7tTokmkXzJtd
         mKweW3iUM4FFGuIFl6YO9uOuwkjZQAS1jHJsir50eZjxsETFyM0nIEwakMX4XovX6pB0
         cpQSCfXVSFuQdE6jr2gMJxZvvv0fM/60Zut9ucvS3wIbBI+TpIBod+ywc1Hsle5DFod+
         PDoFdc1Yo7X8bJQ3T3I3zA6KiPkEBVQAzC1UB8XztKgj9yHPIk524uFqycbnDVIIeYJK
         fFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXceatWXnUA+HHUYsNAJ5IIeSGox+Y5QnFFjHcpPizs1Oz05WOJcxJMXafK0B6T187P6y7ZYreg5x1ee114QaoPMX1susc0hoAsNnlV
X-Gm-Message-State: AOJu0YzCU2gqTywsxgXQl7gjeGYsmWXMeVtVCNc/Phzo1fKvDoKMv1hV
	nIH3GyEpXjSqHLUh7FlPhJhtsect0L5IPXCMU+8tQa+oxtsW83OrSJe9rAOmotw=
X-Google-Smtp-Source: AGHT+IFzyDrAISLmyfMTkD2U0CnOaEiWNNhOh8Yt33K2jGcGj4upmTfOI84CZT5z68/EAKIkTu9l9Q==
X-Received: by 2002:a2e:a612:0:b0:2ec:5668:3b93 with SMTP id 38308e7fff4ca-2eeb30dc16emr19340391fa.12.1720529385501;
        Tue, 09 Jul 2024 05:49:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e9666sm39540095e9.9.2024.07.09.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:49:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: sam@ravnborg.org, daniel@ffwll.ch, dianders@chromium.org, 
 linus.walleij@linaro.org, swboyd@chromium.org, airlied@gmail.com, 
 dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: lvzhaoxiong@huaqin.corp-partner.google.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v2 0/3] Support for Melfas lmfbx101117480 MIPI-DSI
 panel
Message-Id: <172052938462.987180.17478336258755727379.b4-ty@linaro.org>
Date: Tue, 09 Jul 2024 14:49:44 +0200
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

On Thu, 04 Jul 2024 12:50:14 +0800, Cong Yang wrote:
> This series support for Melfas lmfbx101117480 MIPI-DSI panel with
> jadard-jd9365da controller.
> Add compatible for melfas lmfbx101117480 in dt-bindings.
> Break some CMDS into helper functions.
> 
> Changes in v2:
> - PATCH 1/3: No change.
> - PATCH 2/3: No change..
> - PATCH 3/7: Break some CMDS into helper functions.
> - Link to v1: https://lore.kernel.org/dri-devel/20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com/
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] dt-bindings: display: panel: Add compatible for melfas lmfbx101117480
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e7305ad465b50deaa7a9f3a97dde3b22cbd00474
[2/3] drm/panel: jd9365da: Support for Melfas lmfbx101117480 MIPI-DSI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c4ce398cf18ae2859cc9930a9486b576ce262de9
[3/3] drm/panel: jd9365da: Break some CMDS into helper functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/533ca79cd9f734aae56814445e3f1e6cc1a50358

-- 
Neil


