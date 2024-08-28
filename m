Return-Path: <linux-kernel+bounces-305398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA54962E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DD1C21993
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF31A4F27;
	Wed, 28 Aug 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/3I1wkM"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059E15F3E6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864623; cv=none; b=J2Jm2ex8OiEPcWI4Uh1DOzhl7Y04tKwjHdMbQmIHoFpkA+0WYhnaCrftAIp9+dwUxRVx1RAvJAoZFVbj39GH4Hszkib1iyFZlMNqWL4+j2wLwv2dUmb1uHnVhx0FLxFmOvum2VwTGLXkr83F6DB9CqDyPr4cVv7AiB0/4QujhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864623; c=relaxed/simple;
	bh=QasJiYQ1cDw/pStQicO3S8JcebgaLLR56R+OjX3L02Q=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTrRKY8quIm4sJMArdnTHIMlAyiUFTDLq9ffdQTR03UbEOKRvZitF5WPmLkx1sWi1wch84aFfR0EpRwBCGFrGiTcg/robHnbhR9+46k6PMm6iWfMUsNmPWtdf5fcJyB5DVwcocFP2Jvs11QmK1KtIexnccPf5ySch62qiACFn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n/3I1wkM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a7f86026a0so51961785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724864621; x=1725469421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QasJiYQ1cDw/pStQicO3S8JcebgaLLR56R+OjX3L02Q=;
        b=n/3I1wkMOKH+bGMxL+yQlzYfp6qROm3K4v+wypIb2F2NGydGx7NvkwnFFoECDVTYPm
         vDoA97XRSHkf9PaWXySsakpKfQbooUxWJHeNLg/veERRbwVvR0Bs3REW/8wglLdHHV5d
         b38bqXOLIpis1bpZC9cMiuA/maV5T3pWaE4Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864621; x=1725469421;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QasJiYQ1cDw/pStQicO3S8JcebgaLLR56R+OjX3L02Q=;
        b=Mgvm056Z+dtSuq4D+RarR9R712gE8dkZ/HO1Aoat69zS/OzZJ5Eb4WMhfsCOLLZx/r
         j3QcPLxz3JLqm1gL97t095jrIxglcc/mlA16JL1PnRqmr9fW0Bf+MAnBHIY7zTVk3NKH
         Ry9NZZMHWoqazHp4zn5X22lfyxDjffMaeitFqv++pH9UVSaDF4JuYtvOGCg0sZZAjBYN
         eW7AxT9D8t1SD0GHPLrMQMhcrhUlBtirPiKrAT4QZFpEgAL80XzIr7zx905Q7BBAErm/
         /B2YdZ8w0wAB+Y71FB8TdKu3KioogYstr3PfwaYf47icoICgu8Q8620tsEC/W5q7dQBh
         VK9Q==
X-Gm-Message-State: AOJu0Yxeoo3avhN++4TI16jYOP3YqV5gIGlXg0/TBXfeIEKwtVvX85En
	QoBH2ig8/OJeau9syms3i2j1nP+OLvfdxX+PdK6zSxRE3aUzUWT7uzfQVWQycGxkmVa3/coSGpv
	E3NNOxzCB0v19cEHspxfUNzUkwRqQ8rSfGKlU
X-Google-Smtp-Source: AGHT+IEVO9KZmNWSFybfc7A1nURst7111SB2+UOWqLJ8aG+gb/58BS72acni8VLoQAEGgDW7MBt6MwGtixuxjlVQbiw=
X-Received: by 2002:a05:620a:2496:b0:7a4:f480:c315 with SMTP id
 af79cd13be357-7a804182b1fmr3651685a.3.1724864621186; Wed, 28 Aug 2024
 10:03:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Aug 2024 13:03:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8597375d-6c15-4d20-96fd-2598805c09d5@linaro.org>
References: <20240827231237.1014813-1-swboyd@chromium.org> <20240827231237.1014813-2-swboyd@chromium.org>
 <8597375d-6c15-4d20-96fd-2598805c09d5@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 28 Aug 2024 13:03:40 -0400
Message-ID: <CAE-0n50_+ci9H4M74FC1xVF5szE7kULFifEEnE+-DxaivGG-Bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: qcom: dispcc-sc7180: Only park display clks
 at init
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, linux-clk@vger.kernel.org, 
	Taniya Das <quic_tdas@quicinc.com>, Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Neil Armstrong (2024-08-28 05:22:25)
> On 28/08/2024 01:12, Stephen Boyd wrote:
> > Amit Pundir reports that audio and USB-C host mode stops working on
> > sm8550 if the gcc_usb30_prim_master_clk_src clk is registered and
> > clk_rcg2_shared_init() parks it on XO.
>
> Why does it change the dispcc-sc7180 in this case ?
>

The patch that broke it affected all RCGs. Let me add that detail and
resend.

