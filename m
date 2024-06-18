Return-Path: <linux-kernel+bounces-219031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3778990C906
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ADD1F21855
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090413AD1C;
	Tue, 18 Jun 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0COPhka"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328716A33F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705396; cv=none; b=IX3nuw0Lbbbzg2AGx38WRBmf3onn/ebo5edXSguHwp6rDsXKKmrV7iZrJ1joDwS6XThfVNIqpQBmQrBcm/nkvYPmDNlr6n7WIOZQGV5XMq23QcdLNOUH/BXZ8j4rAvfAgdRiT7ZJUrcX8qJ4YiPV+1PaRwJaK/po2jTGMTkCKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705396; c=relaxed/simple;
	bh=7oxJcCqLRhSocPcJIPCN/nopqjreH5+gh/HYi4HAm8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYRsOOMkhkURAz+ZMIeAq1pYVeEbTkOkzWsajgXqtQYJUqN+juqvJs9UD+3OEMyFjbRVu7UQUzRLlUSUn0Had3ICKBuOsqtos0uJnxRGWXKL4270kKg0NLInemneNfqwBh6U9/gRHmD+BVLQk+N0tf/SWGvJT1WhBwknUz5bqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U0COPhka; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02b571b0f6so297553276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718705394; x=1719310194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqR5wZUp1Tx3xq+bP/edl3bl9htsL0tG2NWiQ3t5YmQ=;
        b=U0COPhka2fJHarakC/UPCuLPh8POWGbEoa/x/28PwNG5bso9U8Bj3Db14LdmLE3wNY
         60TYiwGn5UTYdQErSmsoPZCOz++h0id89mor6afRV4N6konAJ+eArVLuKX5XGRDqaPzP
         5GAIcMR+CWvtWZ+CjxkgvVkXlZwbEigVyUZXZ7UgHZ/odDhdVuZKaGARByu9b5x8lC4o
         Vh9JW0Ac4xGWDXogQvUkKu4eU7UUFo+ACG0tBY9YGBbOmq6Uxjrz01s4pbWvBOUzFSH+
         4fDiSNV12zXHolwvaL0oJfMwK04B0lVThOHsz/zMfb3ESb0GB1FGlHzTlSTTgX7yLGZU
         u0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705394; x=1719310194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqR5wZUp1Tx3xq+bP/edl3bl9htsL0tG2NWiQ3t5YmQ=;
        b=GdWTpHmRn+hMyBd/07ZNjO8xvI6cmeEcSOWwgvYycCThdz3okX5bfK2/BtBJ3YP1Q7
         omsXrcMx3FZec9WtCGhL1iG1Zko9hyoCaepL0Js3g5Bj8ndRJfX4xYkJ7rqDaN5vrlgu
         T4UE+4cyDYzKv1L3rm5veF/aKX/j58QjGsvIpXFA8UP3aTrEbsBwF4ZPrkf//sQDV2s1
         eM+M2pYR5s1GQyxN1+kFymQXCOm0P9kMzp/y2BvaAcrd5AjV1NEs1BpYr2Sxvkx6tOkF
         nj1ZcmIt67NL1br1GZfvB8nv5iMeRdVCH32DndDAusCUs9gV3yuSQmrRQpilkTimZMN4
         z8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUSakyJBMIWKv4LI9vVyukiNFweCyOsnsd7oAvRiZJgVI9+azKjlTV1UV9vkE7SR6iAZJ+ytiO/dccWuTLo3CW3/17Hb+fCVY60UAqe
X-Gm-Message-State: AOJu0YwX4rhz3gVAuoNPPg/QXY0gwXp48hRSTmIKRntCyzXuQKA68bI5
	azh+K88Vaw+mMmRIFdxWFOe16CDKxq3ZKoVKlifz51yatOLThSPfHDgU8kE91FLraKvlshyk4+r
	g7Qk/HNWyOfhH2h66hE0bvBxxedOoi5t151yTdA==
X-Google-Smtp-Source: AGHT+IHRwPCQfQa69fMu0wKjL3vPrpLu3LBFBhI//GsCDP56r0T5z4Wbx99DpWuIJj4GMQDFqn1DNosmf91VMnQnZz4=
X-Received: by 2002:a25:6b07:0:b0:dff:4a3:2de9 with SMTP id
 3f1490d57ef6-dff15385bddmr11704923276.20.1718705394187; Tue, 18 Jun 2024
 03:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618081418.250953-1-j-choudhary@ti.com> <20240618081418.250953-3-j-choudhary@ti.com>
 <k4t7zcvweap6e3fqrcixu7szqtvykn3nnqryyd3hdybhhufcgk@snimim34rrwh> <a34116ff-989f-411b-8846-2f53b16b3773@ti.com>
In-Reply-To: <a34116ff-989f-411b-8846-2f53b16b3773@ti.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 18 Jun 2024 13:09:42 +0300
Message-ID: <CAA8EJpq2UkMn9ArSNaJcOyw28H4uUcRwvUqfUBBqSCALmozBrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Fix ti_sn_bridge_set_dsi_rate
 function
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: dianders@chromium.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, spanda@codeaurora.org, a-bhatia1@ti.com, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 13:05, Jayesh Choudhary <j-choudhary@ti.com> wrote:
>
> Hello Dmitry,
>
> On 18/06/24 14:33, Dmitry Baryshkov wrote:
> > On Tue, Jun 18, 2024 at 01:44:18PM GMT, Jayesh Choudhary wrote:
> >> During code inspection, it was found that due to integer calculations,
> >> the rounding off can cause errors in the final value propagated in the
> >> registers.
> >> Considering the example of 1080p (very common resolution), the mode->clock
> >> is 148500, dsi->lanes = 4, and bpp = 24, with the previous logic, the DSI
> >> clock frequency would come as 444 when we are expecting the value 445.5
> >> which would reflect in SN_DSIA_CLK_FREQ_REG.
> >> So move the division to be the last operation where rounding off will not
> >> impact the register value.
> >
> > Should this division use DIV_ROUND_UP instead? DIV_ROUND_CLOSEST?
> >
>
> Floor of the final value is expected according to datasheet.
> The error was due to taking floor earlier and then error propagation
> due to multiplication later on.
> I think we can come up with a case when DIV_ROUND_UP can also give this
> error. So this particular approach seemed okay to me.

Ack

>
> >>
> >> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
> >> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> >
> > Fixes should go before feature patches. Please change the order of you
> > patches for the next submission.
>
> Okay. this was supposed to be code snippet movement in the first patch
> and fix in the second patch as suggested in v1:
> https://patchwork.kernel.org/project/dri-devel/patch/20240408073623.186489-1-j-choudhary@ti.com/#25801801

My point is pretty simple: fixes are backported to the earlier
kernels. non-fixing commits are not. In your patchset you have added a
dependency from the fix onto a non-fix (and
not-selected-for-backporting) patch, which is not so good.

>
> I can fix it in next revision.


-- 
With best wishes
Dmitry

