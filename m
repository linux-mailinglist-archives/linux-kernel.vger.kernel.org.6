Return-Path: <linux-kernel+bounces-535592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6525A474DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3081889FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE52343AF;
	Thu, 27 Feb 2025 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ti+F44t0"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D528233158
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631090; cv=none; b=RTG9hV9HpJP8ojMsFlJs7al8b3LkH94qY7TgfcyfJU7k9yf4j/YTLc92x2MgKIl0lcqk0qWXBvI5mrubi6gQAK5elmgWmBzY7+pNWNqyxI6fd6/03pvaz/vsghEx6QM1giijOawVeY8QVHKRSvD2fryPh6FRMGN2TUcwmieQj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631090; c=relaxed/simple;
	bh=c2QD9K5Zy9Do8z3+8XGb/TPkiis4aha7f1t+39wV7M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUungwODyj63N9JL6iPztYP3+e9j29QdAduNulllwwSGxD8qawtLplYOiN6SpJwV4/eFAamgIwc8Bs0L4+GmBe/PxKXK3d5Bqb2xwqd+TpuqK0wXF1Io0Fj/bJWNnT73y6xZj3AM2TAV0EaWf8lUdmjNZQUARpTTRtr9ep7hNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ti+F44t0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54843052bcdso419437e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631087; x=1741235887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NuhwZJbo550PrQsjB4y/he3bzDbUt6ahCDwi8PkPv8=;
        b=Ti+F44t0pCHPI/c/NbbnH9mV/ZEbuS9NHl5DkZcjtb9K6OXX5WoM3yfATALPxIoGXu
         79YR/gv1EVX9XXuQePUXqN12duv6e0oln+rfoqsBU371ZUzxIQ04YAenLb4MqONq+/zB
         y9cTCMnn1g8iIGLLIUBkkejPC0gQf2lBH+3UDE9KhJ5jpGsvLOAVUlxxy+MogbP9O1rf
         vNMtXFWxCqrPtlAVB+weE/QEiheAdYt/m1Fu0s7o1xYtfUXnNuVZ4lTQNpe9AA1s4KrU
         EVvR9PZq98tYnQ6oSsj2vRwxRdcwlfGw+sEY45Ij2yeCPsUadwt8uG2DDRJBtqCn6EAd
         9egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631087; x=1741235887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NuhwZJbo550PrQsjB4y/he3bzDbUt6ahCDwi8PkPv8=;
        b=O+MIpWyfcyQIKDmhfZVKnb1ayydB2xJMaPorQq3ykL9uyfIZspu+AxO6h2Kq1iFCz/
         0YsJ2Z/QzGerUti/UycEZJyC6ejGHOGQomPuVGhL2q+e/RlFtrnI9JyRza5XKl7ezL7r
         O6LNDLkp10YLv4t6Wf9KArMkcumwbxWkROPJV1eorYaMAPitADfnJXrCcksGUDEif7lv
         LwVOwo4qAHJ1PXy+pqyBTwIRiA9XJcsmiAY8flnwYIjkECvyLxA5oEP7IYyZxmSGsA3K
         rbDniWRdL7QIa8KFdyGvSA7bZUaJ6fNaVmVUKAGGfun0TuuDvu05w6jHEqbp/Wdr2SQp
         mBhw==
X-Forwarded-Encrypted: i=1; AJvYcCWBOOdjCjs3XBoebfGVj0bBXpMl5dGLqBFCdG96XZk7Iiyl/w7UCz9A1cVT7wwe0Gv2tYIXX57zuJ8xcc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQV9vJyLbXED5V+5Ag31dERFneJ9D5qoT4wzYwzYEB1tGnRtvM
	MAPSIuD2DS5IeOUbhKc5C55lDPtINxeFRQ1Fb9Ep857GxFrZpPgL4fgIe+VdHpQ=
X-Gm-Gg: ASbGncucE3q0FbJzZ+sEwndjyD6O4fOusPYvTzniH2c/tJDxatH/zPudNxpK+rfjdCi
	VUO0XIZY7ELrzI1cj2wmfGx/QhlU+zJGaFKT+7MSrzb5WHTuxSQ7YEtA1HUp8963r3bCXcxqzdz
	90KNHL0SBl7qvnmF7gvNf6ZvcpXBVks0jCiNwwOwxxAcy2uQRg0M2igxl7fdSXyhO9oyhcM3/p5
	q/onZG/Gqmk+23/o5cfMDdpDXkviar56no9O1s89dLsyZTYdsu/b/WDV/u4lKz+Lon6ZSAfdOMX
	iGKG93qaVajWT7eLK37a99qLXQRiKcUMO41AjBbNKg==
X-Google-Smtp-Source: AGHT+IGRIdnpgZp6aVSnIAMxXRNTRhCc98UJKotB+jjdDT229PrZTyGg2gjdq/20fQUotbRi1XPCKQ==
X-Received: by 2002:a05:6512:3f19:b0:545:81b:1510 with SMTP id 2adb3069b0e04-548510ce665mr5171090e87.2.1740631087427;
        Wed, 26 Feb 2025 20:38:07 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:38:06 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Fange Zhang <quic_fangez@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Li Liu <quic_lliu6@quicinc.com>,
	Xiangxu Yin <quic_xiangxuy@quicinc.com>
Subject: Re: [PATCH v2] drm/msm/dpu: Add writeback support for SM6150
Date: Thu, 27 Feb 2025 06:37:34 +0200
Message-Id: <174063096236.3733075.3181882897632312941.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114-add-writeback-support-for-sm6150-v2-1-d707b31aad5c@quicinc.com>
References: <20250114-add-writeback-support-for-sm6150-v2-1-d707b31aad5c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Jan 2025 16:55:24 +0800, Fange Zhang wrote:
> On the SM6150 platform there is WB_2 block. Add it to the SM6150 catalog.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Add writeback support for SM6150
      https://gitlab.freedesktop.org/lumag/msm/-/commit/23c0a9d36f78

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

