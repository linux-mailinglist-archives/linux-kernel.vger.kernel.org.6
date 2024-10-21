Return-Path: <linux-kernel+bounces-374283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D89A67F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A342840FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD551F8901;
	Mon, 21 Oct 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3zZg6LW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218771F76C2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513075; cv=none; b=V0ad7zAphKboD7MfJB6wxfyktQKtbysF17VMJ7BiGpLsREdpq7DSlaBzVVFwlPZaR1xkbxgLzHqbp+n16Rt90KR4gpUfXdccDX/IaCOa5pPGxbFbj/hHVHSA9i1LkiNKOR2P/DI2bc45q5Yyz5RXFET6EYbnLXA3rRT3uJVCdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513075; c=relaxed/simple;
	bh=jFR0GuTQWYiA0tkVkUxdxqWwZ92Gh4oNyd8l8SbpTLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgDqcESSnQSjplfaJO3LAqaCCPxrb4u/dbNzHsMOYtABfMUepRxjC0oCZh3EnKytcTNBnehrlwDgAbSJgEnfNY6aiYybpBWklyfwuE+dLd0Yj/ir1Tz37cs6gGASWStER2SVSQCoxKTUYeOk3nhYdCzd3DDY7F3x15WPnAw5oHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s3zZg6LW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f72c913aso5086877e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729513071; x=1730117871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4XbVxeeKZbvEtWB+ooKpQYase0x2chrzmDf2sWa5VY=;
        b=s3zZg6LWiaDwrENcYgM6N84o+KB0pQNIAsfSlfzcZRPaOdJDGmpPAVDxxLo8mBBYJQ
         WFe2qSb2YlV4e61+ZuOLfsPwI4gHvD/zijSfrnvGHBn7R44qiPqNgxqtQBYOIS0oVuR7
         E9eZ3vxXa0UN09NknPQQyemr6TTC1OeyUu1WsZ6dx8HBaisgAgjUtjG7CQPz0y46d/qM
         gL14XV5rP2Tq8pdP9ij1WPckuygP5qs7wkPO6PgFEreOvGIXvC36hmw8bZyJ410cMo5V
         +ypDpizwOu5d7ZrNsdotice1qK6XEYieOsuAOenAJWacOQeadO1aFs7uzyy9Q6dJ8Emo
         bUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513071; x=1730117871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4XbVxeeKZbvEtWB+ooKpQYase0x2chrzmDf2sWa5VY=;
        b=qSdzHWG1gE5bvBPqOftwHKCs3S/IHXf9x98+HIWJ+w8Rk5ECGZBQxLLnHsRL/Dh99F
         ankxdSsEl93mo5a+A3oQq/M4A8lk3q/Vy4Uml1As1It+uFq5weXi41lCJ+QVBx5lxGP+
         oVkq2QFUAf5L+NZx2mpXGhOFw56U3HKi9QjcRTyc73J+nCxLoGwihn3OB6AgLO4naaky
         Z/1yaS7aUCrzY1AZdeNWOqplbLTR0F+rNIdk+BLMt3CHOW7ucJ3gIkF3vuhB+xwWRqgD
         9mmgUp8VaO9YaRcb3XJSiHQREznsf4yZxfnc4f1TbZF3MoyQkfgqCeQh9LgUPVkRQiTw
         TmxA==
X-Forwarded-Encrypted: i=1; AJvYcCU1FNmEVLtp5KGVUMiReEl0uo1Rv82/MC0jUWCXGdJ6/zIH93qdaIXTM5i7E4Vu1f3hjxuTPM9wEpFOYBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6XcsgSY+UpIGiX1W7pAs+cu+v88RdNkm40x/MrnmCHiwLyZQ
	YaUk7Jz24rMlyCaU4cPv+bZ5DiIc/SOmeX3abckJbmKwy+C3UdG7MmByU2nxktM=
X-Google-Smtp-Source: AGHT+IHqv4mwsIjXZb0v6O893ub1mSBOA8nkk9+gOrcJG9wQN2aV6SmO6D5BhFYeJg15xKOKgafh2Q==
X-Received: by 2002:a05:6512:2356:b0:539:e317:b05f with SMTP id 2adb3069b0e04-53a15229d00mr5612832e87.28.1729513071088;
        Mon, 21 Oct 2024 05:17:51 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22431454sm464210e87.212.2024.10.21.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:17:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] dt-bindings: display/msm: dpu: merge bindings
Date: Mon, 21 Oct 2024 15:17:40 +0300
Message-Id: <172950935863.2053501.3423333346021124580.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241003-dt-binding-display-msm-merge-v1-0-91ab08fc76a2@linaro.org>
References: <20241003-dt-binding-display-msm-merge-v1-0-91ab08fc76a2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Oct 2024 10:14:17 +0200, Krzysztof Kozlowski wrote:
> In 2022 the bindings were split each device per file, but this makes
> not much sense.  Devices are the same in many cases, same clocks, same IO
> register space.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: display/msm: merge SC8280XP DPU into SC7280
      https://gitlab.freedesktop.org/lumag/msm/-/commit/897ee967257a
[2/5] dt-bindings: display/msm: merge SM8250 DPU into SM8150
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5a1f6295a434
[3/5] dt-bindings: display/msm: merge SM8350 DPU into SC7280
      https://gitlab.freedesktop.org/lumag/msm/-/commit/30c38fcd50d9
[4/5] dt-bindings: display/msm: merge SM8450 DPU into SC7280
      https://gitlab.freedesktop.org/lumag/msm/-/commit/abf0a19c493e
[5/5] dt-bindings: display/msm: merge SM8550 DPU into SC7280
      https://gitlab.freedesktop.org/lumag/msm/-/commit/342d48210577

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

