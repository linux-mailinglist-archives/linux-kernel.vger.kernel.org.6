Return-Path: <linux-kernel+bounces-553022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B184A5829F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F003AAF1F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2915852E;
	Sun,  9 Mar 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xd7I4R8K"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40CECF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511959; cv=none; b=MM+jgXgEVHVpfoe1IzbNJVvgp/Q3himHOU34EnUZmi2xbZ5Co29bLpPu4hwi3M+ooUgbA7pv0rZOSa/xpQ9XMPbhBcUunMyCJOb42vU6rFRpFhxqxYy6qzzsHhV6DhoG/MVv19cr4n2MFFMo/sUOQkR0D4GS/FvcQCLSbtul/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511959; c=relaxed/simple;
	bh=C79eWlbF7InHwwOP9OaSjewygrzEXx9Xd6vVQn57Qlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uqt69d4AQCxsIL0zCK0NI0no3DYRchVEEhOPIfAHYlWmu8iUKzZF6IPvjUQ1UgvDgv3bRF0l906NVdmAPT++kxNEIV/YYbP/hebhzX6YBla8CM2rV5IdQbotOYabX3CRbotjW55MPG3pswUD0JKoJ1jX8k0VzFQH3AF+P1PFpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xd7I4R8K; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so2760488276.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741511957; x=1742116757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv9BJK8h1smkPFin/eoitVvyZGcBn6mtj+ZWUnOyrrM=;
        b=xd7I4R8KMldDM1Mq9D4ebO0S4NiMFWgVfsRmukQhlA8CJMGXBFCfFLJqF2Jg/A7ij5
         UH8U/0lJ/k3e3/pNE/tTT/NGHd5gmvbKF4wxOPYqgXfLB6rLXroMIGY3+T2p4BDszWVZ
         r+6oqdDLe1JjhkvbStT6xzKsS5bXuahmi+0/eLbNTVH/g6fWcAJDmOJRFMioNUn4oWZy
         5IACDz/oWMQ9JE3hPU05KTmPzOITNBtoVDFbr3hGjugSZ82aOFZRkgolVd7EtaDKx57j
         4Ty0kXge4pyczDr6vKxNfWB7snuS6LJdlSneYFcyaVveKyhSqeNHkXZrQU9afNU+eUON
         3oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741511957; x=1742116757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv9BJK8h1smkPFin/eoitVvyZGcBn6mtj+ZWUnOyrrM=;
        b=mbWxjA6N7iYFhUN3d2GLSDWUs9qDMhk8H7463PgnNLQo/EnhvlXQpn2ORu0OijUygu
         j47hLXYdnvqn+VnOF8Jgmsv9Vggw3Pif5uzrnM0fnuIDgiRVqvfx279dfUXUJR46DLNs
         33NfGpruprk7PF6S0NJ4Jk9AMOQmWglzpDkOBjc0XITPz9nFYrfq0Xva6rlhYjJj/7N6
         Qqbw5tXMFr2CfcZDS5zhQ/hKlHjUc9jpcz/pxM5CZz/XZ7npMjso19xVyclAaUzw3Dsr
         GqSLNxN6TVNHRs+1F+v1BXlFEl6fbm7O8Fj6ELpX9UGCpLr50dNYjaa38O+bLUyKLAN2
         RkFA==
X-Forwarded-Encrypted: i=1; AJvYcCVGfr60YdWqyHJxl+awPleiAbzC9ymWuXVMZAwiiK/k68d4bPT7d63Fb4rBkNtFtl4BprOherW5Bu/lS9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7e83J11Z6hGQPAYOPCKmArTYeoSb6V1AXToXkOpIQ/yOqY5d1
	EypCBt+BSFT0JRgGF0pHD+lQgoszbKY9+UJ+W9DvQazw1+kAr4MD8xRKUWfpXDKxzAZXUeeRqyC
	WKK7WEWF9OmMpuoFxEyW6pPIA8RqQ5EhbJgaXag==
X-Gm-Gg: ASbGncvrtYFZvlbqubD9bSf4vKX8iovOFyl9fullTDHi2KMwRWLYV2rak2y6FooiF7e
	DTSmUIWexx2CORJ6sdCmrz3mkmACHtRNap3Z+3PWN2HoZc4q7T0wB0kCPzMzYEkj5WwjfuQUHW2
	70fdkPhbWO3ms+lS1kVbQ1RlfuyzOifmVZNjWg4rfM
X-Google-Smtp-Source: AGHT+IEu/PQ12bVNZYXCd34qYJvUqyHf2vmlZ85Q5AvR10mVaF6BlXxpWuNpl9htbiSsYttCY66TAN4aoeQg9Ypsf2c=
X-Received: by 2002:a05:6902:320c:b0:e5e:2428:fa56 with SMTP id
 3f1490d57ef6-e635c1ed376mr10933687276.41.1741511957257; Sun, 09 Mar 2025
 01:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-6-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-6-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:19:06 +0200
X-Gm-Features: AQ5f1Jo6fNACL-x0ajpVmroongj8VydVA56TBkhnTi7aC2zOMYCGM315yQKl7gQ
Message-ID: <CAA8EJpo_AF6BHCDThNncuH36VHZy1ZJX-=Qj8mj7-UZY41rCuA@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] phy: rockchip: samsung-hdptx: Drop superfluous
 cfgs driver data
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> The ->cfgs member has been introduced via commit f08d1c085638 ("phy:
> phy-rockchip-samsung-hdptx: Don't use dt aliases to determine phy-id"),
> but it is only used during probe() in order to setup ->phy_id.
>
> Use a probe() local variable to store device match data and remove the
> now unnecessary member from struct rk_hdptx_phy.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

