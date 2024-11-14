Return-Path: <linux-kernel+bounces-409675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6509C8FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF41F21D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904F016BE20;
	Thu, 14 Nov 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ion3QOxy"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09B81AC8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602444; cv=none; b=M7/m+bhdq48fSpasvXKsXEHPARIIaKSgPVIumrMt4sF3JSh+KyiobPlBaimzTUSPyC8JJMzMGXHJKCRn3NoxzXxms6E7LakCGhJdM9hyhnQQhdrsSFS6okzFiKai7gEILQ7lHX0xS7EciDlVtozmjMzqThWsqAqrr2hwmWsdyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602444; c=relaxed/simple;
	bh=ab7UwlMkA6Bfo9q8TO3PBUY9lsnPBn9IGdHTgMbMxJ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tuBDnglrKUyVYSIrieZgFq5CYi75dxC+1WsXcpc83AlmfKCgMu7zYj6er0nAKlCNJuOHG1Hn3Oc6nZaqoNCLdz8U9GFUZtwvp4KZIS+DwXa4cBq9hICeJ6/60Cm0Zen42HOHyy1m+4MSUb5joor82Ghxp5tRJx3fND0C4/BWQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ion3QOxy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382185ed80eso551686f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731602440; x=1732207240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xkyq+ZrMmoh6gWEOgE4rkAB8kE0YpmSqvfOUn0QWPI4=;
        b=ion3QOxyH7t0HZ8o1qLrQ/Rqwiac2a5ZY4Zol0TiPROQM4Eu5Zk2HC/5qSLEnGeSDi
         QSyBT7QbtXizgDdMa8mpMaI7eer9UCFBjX0l5FvR3q64Ps3PMhEoXbpROYRQ7QY0rrtT
         RujKQcoYnfC6QqcdoszEqaYoPn3OQAFGzj2uX6GYWHbXOc+LyMFm3wogfwTYxjtHyzn/
         UiAjbWhfEqq+kZ2jiIKQGigxukqISXnVuRXjzex/Ye6iIeH4JF0n5IaPCPfdtx8YAoV4
         /1ywzsuWmEGaezLAxhZcvsCnAlsdWvymXdGFH0zq31ksEUI64oVJZYmEi2eOzpMMtrPI
         1bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602440; x=1732207240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xkyq+ZrMmoh6gWEOgE4rkAB8kE0YpmSqvfOUn0QWPI4=;
        b=f/nt9Tf5AQKoJrtbhsXsMcRE2hPtdcrA12Qp0J7VabDUMqEBaRS1kl2T7nmJrZ/vVw
         /LVx1Xt+jruNLoz0d/W4khKBdlB+hzgmbi+mA/F6qHjwY3uu8FSJDLe9G3UAsHclnWEH
         cFMZGleLQuZ5R1D96T9VQv/pn86aI1l4/8TT0Vo2MilskZipIkz0qqilN2sjVH6K2csb
         GtgB7pLk3yGhCh7AuXn9mjk4Zq9i8EVNvPgwXBkXUDpv4HY6/+JKIGm/QakQB42np9Nd
         nPfQ1CfuajBUuhfT2XabiwJ/uXPLoIzS7g8sBy1a6zSHhKNGfXiINkmelnaUyydDViDD
         QuCA==
X-Forwarded-Encrypted: i=1; AJvYcCX7kgABNMq6qvUm3+RyNC+MR4KOUtUv99OO7vquqwBz7yEqPkYe+8SgWiRICeYNvG7Nbu23b1qIkRa73IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijStYIcEdvfpAQZz+v1Eg3igzTUh7Dp7o9plEkMMiuIWahdbS
	sIyCMkbm4uziSjuiFNfSccfmRcM16be6hOw8TYUfPmKP+eYmTI96rIqe5MoUKDE=
X-Google-Smtp-Source: AGHT+IGEdyWzIWUpG/b6aJ02gw51X0tvXl/fUgfJ3mohgzneD77kZ6krmaQpn0iidFQUsA8ZPFrKTw==
X-Received: by 2002:a05:6000:1f86:b0:37d:4ab2:9cdc with SMTP id ffacd0b85a97d-381f186cb45mr20459744f8f.13.1731602440547;
        Thu, 14 Nov 2024 08:40:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae2f59dsm1935085f8f.86.2024.11.14.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:40:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240926141246.48282-1-francesco@dolcini.it>
References: <20240926141246.48282-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] drm/bridge: tc358768: Fix DSI command tx
Message-Id: <173160243967.3308246.14721966174558554057.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 17:40:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Thu, 26 Sep 2024 16:12:46 +0200, Francesco Dolcini wrote:
> Wait for the command transmission to be completed in the DSI transfer
> function polling for the dc_start bit to go back to idle state after the
> transmission is started.
> 
> This is documented in the datasheet and failures to do so lead to
> commands corruption.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/bridge: tc358768: Fix DSI command tx
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/32c4514455b2b8fde506f8c0962f15c7e4c26f1d

-- 
Neil


