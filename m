Return-Path: <linux-kernel+bounces-198196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689C8D74C3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8651C20A37
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57058376E6;
	Sun,  2 Jun 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCVOL/rZ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B82D60C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717324865; cv=none; b=OQypd9U3Nn6Cyo6Yr6kSY2OHPjc5giZ/gxz8KBAbxCyApxuSYO4jyS83CUywoYKTjuWCo6Yoh3YN59XIG/bjxwFXctmyoj819X0NZLb7o0w/6zIIjMqtm/gXdstujZy/RL0+1/hKNG6qmRgEq1EmO/meiWMjOhqFHnj0ewyBxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717324865; c=relaxed/simple;
	bh=4lF60Tp1ZKHlgeQKqBEl0y1eoXo68jynVkVk5IO43gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emqt3CMll/ElUmhP4YByFck7+uf8FhmnE4qkiY3ZB/MVwKK4yF+dEzN20606zMNSg3Ju8o8tsmhTuP+i5qS75H552rZ6q5F86IdYtXsKxwY75JC0o9hBXEIZypB0eQ1IwhfNuH0Qp9UuMxSzRzG3iPk0pNs+nPIFGkIM4A8sx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCVOL/rZ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df7722171bcso3336025276.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717324863; x=1717929663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFM4fI0BfVhoIuFo3oNmTS1/Tw1vlv77X7lObWK8gXo=;
        b=UCVOL/rZ46y+nqDNCTB2VxHDzLs7OveTj1xFO+V9xTTVZGDhNCKeMBFVMDp2cSzSFB
         EslNoMOsssw1/Zd1oSM3SZ23gSZ89oULhtK89GyTUu6mUlWIT4AO/tq1t2ayTaC9ptVg
         +cRUWKEFxe6lftRuyyppC9Uyt/9fxt5dxCGObSDFmXX3G0JiuTAhCakJO5UjLF/bvK2Q
         u9MFM3IhoZJhVJHlS2YEp9bmKZJ3YCUMTBqPFKFLY8tJ0BCDBPBBI7LTDxfeVLtH3LNW
         nACTdTMWx/yocZr3nh5Sx+3TWCrb/TxIiBkjFzjV24/KaT4tbncXYBWvREPpFwuAXe3+
         tbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717324863; x=1717929663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFM4fI0BfVhoIuFo3oNmTS1/Tw1vlv77X7lObWK8gXo=;
        b=fzI6dzjgE2dQtr+Y7RYwqxfpojPZrZqKukXUGI6Xr9rSTNm7NAO8foFhVAptxSs5Or
         sTJ3dMjYfqX3xzZIe7PowuryYNHmUFaCZLIN9cj71ToGkZtUcOuRk0j9zfms4ZmUHEsQ
         54dlg8QGj8ARpgFVhgz2fqjGdgzWGbAOtQJ9ByKsI12r/H5d44DBivE1dBpB2TR3fDu1
         juGjz/PiFN8xRBEtMxPHzjJtVaJ+s1CMUrl4/rmVIjvQwNk/02LKyB2ZMLC6hFpJ7wmS
         blDDuZrcw5t1TXZ7ChI2os35CUwfNZn3G2mI44GCOZL1uLpEnGfOODRSNS5tNXe/Ft+h
         gxeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZQWKrvIvni72wzDdZKayx9Qzc1LxEpqe7Lm3y+h/lM3aOkrVACI1BA3jnnIkAzLPXZ8LAwbxOPIPMdqbYIn54I0FFAnSuFmiXwv+d
X-Gm-Message-State: AOJu0YxVESUWYjr2L/K8viOP4xDFW5tc9926+NzEDOL66jNJMyryKvmx
	7mja4zk01nrW+W9jlSJEx7wtwR9qjedI0GcjtcudSIHQqk19k3yhumiqr9BgQ8/4iyA7WE4q1+0
	1h+eswy72s47MARq/S4dDRTpTWKJIwR8xoM0tlg==
X-Google-Smtp-Source: AGHT+IGAvjZUn9usqBaQXStHYMiIq+xkcrPxemQDbOh6Td+kMNg2WV2GXfOZ2G0rsURmY5+qN2Tsi0NdkrstgDyKMNk=
X-Received: by 2002:a25:ac95:0:b0:df4:ab39:8c1f with SMTP id
 3f1490d57ef6-dfa73dd2735mr6280143276.53.1717324863129; Sun, 02 Jun 2024
 03:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514030718.533169-1-victor.liu@nxp.com>
In-Reply-To: <20240514030718.533169-1-victor.liu@nxp.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 2 Jun 2024 13:40:52 +0300
Message-ID: <CAA8EJpra3jfmhEmAM6PSpu6eKNdMGuNN3eX2r2JT6YEd7hWsiQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx53-qsb-hdmi: Disable panel instead of
 deleting node
To: Liu Ying <victor.liu@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 05:59, Liu Ying <victor.liu@nxp.com> wrote:
>
> We cannot use /delete-node/ directive to delete a node in a DT
> overlay.  The node won't be deleted effectively.  Instead, set
> the node's status property to "disabled" to achieve something
> similar.
>
> Fixes: eeb403df953f ("ARM: dts: imx53-qsb: add support for the HDMI expander")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso   | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

