Return-Path: <linux-kernel+bounces-355419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C39951FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DEE1F25DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9D1E0DD3;
	Tue,  8 Oct 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZCtlbn0"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CA1E0090
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398218; cv=none; b=LUfawP2pkw46Uzlrol+PXEyLiQR4KTkEptyoDh881Ctq1765dlFFRXs8g9OchTW1m9Hp1Cc45iDO2rp2vxqpklsNCep8UejWRo/t70mHuYU77zvt6JZytZHpdiAgc5uYNqRqcNFYzxEp1evYuPUG7toA0K9oWzQcmNzqMHkPMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398218; c=relaxed/simple;
	bh=GEH0TORf5ghIciVtZ7HkHhLC7ZUfQAQZ3HuiMQ0/5yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccKJWgX5vPo026gDGeeQG6qBrrPxW3KE+ZdjZljihY0bebk+Rud8vhTrt/AMJePL8DA3NAbSxWmaTGOvuHB0WERcfEEWYD3odoDJTSSAis+pez0gbmXRISJNBRTZgCFcsYO/Tr5TaphJGGCDGsBilvUOlaYcV3DYepHoiJhUI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZCtlbn0; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25d405f238so4983832276.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398215; x=1729003015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9oq3jezHlQMT6rg1nSIemrSZ1OTMBtx54B/fq7slMk=;
        b=rZCtlbn0BqM4tNGM8i+tKTZDLI9h5DbaB7OTL5mooQ9LLpNuZUcNtJvRZocbX9lpO5
         Qi1qRwlqwYtADdCvbaA8RjjLzxK6rlSZ9hFJSn70+mjB9r66ETwlW+H7jeRvkICLS4Qt
         BxMO++IBOX782GYRyhY4Bd4z1yJ47XAGYU6iPLQtemVSCesJ+Mx7FS8nSRewLA9zv9XU
         Ax5tqflqrz0Tb1cZ4jFK5wObgXHi2bxQlw9ow4mOG7ky14Ynu03yPn7WDbuTT5nZ+pP3
         nvGxw1X6S/rUwoz+O7Lu7X7yQK86QtxnJjPP3ow4fx10o9YGlPWMqwxmNJ/mhav6xgJG
         hiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398215; x=1729003015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9oq3jezHlQMT6rg1nSIemrSZ1OTMBtx54B/fq7slMk=;
        b=EsjwPwmZIoJ34YqyBrMXQt91DQaKop2x4IACYe8bmMf7HL38StNJbBIlWKSwOvBGZV
         wqXC+OuIPq+GhNkMvAvzyne0kid7tk77XpsgcY88wZ/ElhJ39+3sfsM+4kh8H5IPrhmb
         gwjL1tpfoXdmBgjSuqYutKkvC/8lOqpcblZtoo+Mwemp///JPHFHsFtBT/B8Eeuum5i4
         mXNPV5eUkoB9FoFX2gEJqxulIDVHcb+uQv+nhExr/phEVOnAU4gM66TbbxN6PxBk8Q9b
         eIfCekpHRs9nwu/uER2UofZ2HfmMP55vBOqF2sc62FjBSBICUo6ME6ksehR/2Gv7tk7D
         0xjw==
X-Forwarded-Encrypted: i=1; AJvYcCXagqntI9tup1+eajkvOpYukjKq44eL/BBlRR1JSAuI3qHX2F8IkD8PPyBRMqnaeooOb4WjMeYpnQ9b6wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTi0yjlMmKLEhydn1olZyUepOh8r3aX+y+M56AWYiptwm57lu
	tpsA/YN8AHeVXFBpBpUsUQkoJ5+XbVGjBbvhMtqbFe4R3uQFQNHV75d5efXhtmBRPraowi7OFXa
	417RiL2x0txCLKi7yB87DSInEUnMSrTVPf5t4nQ==
X-Google-Smtp-Source: AGHT+IEjM292qoxRSTMVZiEHGGPCXwidKp0QKEL9SSYcSrYZB36fSHw7uDxBp6+cKhZ+mA+gwRbbOrFaFvtkEpLB0WY=
X-Received: by 2002:a05:6902:1a4a:b0:e28:6b10:51b4 with SMTP id
 3f1490d57ef6-e2893951ac4mr10369636276.46.1728398215648; Tue, 08 Oct 2024
 07:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930224919.355359-1-rosenp@gmail.com>
In-Reply-To: <20240930224919.355359-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:11 +0200
Message-ID: <CAPDyKFo69H+653J=7eDqTSm2gz_AQH-3R+axqiTWqumOPQM9GQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: mtk-sd: add some devm
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 00:49, Rosen Penev <rosenp@gmail.com> wrote:
>
> Simplifies the code. Also a bugfix with devm_clk_get_optional.
>
> Rosen Penev (3):
>   mmc: mtk-sd: use devm_mmc_alloc_host
>   mmc: mtd-sd: use devm_platform_ioremap_resource
>   mmc: mtk-sd: fix devm_clk_get_optional usage
>
>  drivers/mmc/host/mtk-sd.c | 70 ++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 45 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

