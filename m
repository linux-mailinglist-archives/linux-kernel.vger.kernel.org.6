Return-Path: <linux-kernel+bounces-303872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4290096165B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF731F24C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3971D318B;
	Tue, 27 Aug 2024 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G8O/SP4/"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709A1D2F40
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781846; cv=none; b=IsVGOJtGVb2O3tmhOUS0W/OPXzTVm4BLA9gk1MiOJtYdMB4Jr8urhNMbaCn/IYuJdOYBseNJaS5tNLoP/umm0/eF1lh2/5vLCM6lJ+IWeDXw2TLQxBZYApFgXMFn3ZW6/lb1uTqrsQadiS4DTBYvTLyZuVFMm+TL9k+NIFfnsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781846; c=relaxed/simple;
	bh=ljNQ7arYgd97/fkr6o6r79Qw0skRIiKXIc+DDFjF02k=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbwZj5hl+B3r+1ysZoFY+O6F7YUvB0RIrWBGyBcf1hXo6b6wXA4n2q+aTsyK/CF3ObqbpEKi7VLR9bGERLY2Ioxf6BwkxDBeU5xY1Yjym8X4HmwDuw4iLnB/KMYvs2TuPhyeTWVxp5R0EYFS+6C5mvGNV72m4hJ1GOoBIPJo7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G8O/SP4/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27010ae9815so4387024fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724781842; x=1725386642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljNQ7arYgd97/fkr6o6r79Qw0skRIiKXIc+DDFjF02k=;
        b=G8O/SP4/tz0YAqLt+hbyysVAfCzMk4ChGbmev+hKLZb6JGwgE08S5PSdwXkSUi/OF8
         Bi0c/W1MnmtsJqCeyZANtXo0iIbkkOVsLZ8DSRJLOmN9xD4K0SJbwM2Kfylo3WHm3loz
         g5odXwNba7KYb22D/J8GvyDbVKg4BqXJeVGqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724781842; x=1725386642;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljNQ7arYgd97/fkr6o6r79Qw0skRIiKXIc+DDFjF02k=;
        b=VQxnB7rqkfKtBOlD7R2vaXJC9K5e9m/8DJgf3MaOqDGMZCYvHjoLVHfMuo5ooyoyX9
         B0Pbxd7N0U3Z2tzlALj9cZwj0BrhFBnEFxs+6pLX6PMp/XcwsDxb6RyfXSL0B7gqzGoB
         Atp9zTgbic8av7NcvHobKGcs1nE4FS+lK9NCnQHQc0fX2f5aHVbWEoT5wnk8W3a9ZOpe
         2kJFnMeztXP1108hC2U+pUbW+i7wkp7LQ3EHvM8UV0FPC37kuzZC6XtP2HIhjkRNiApN
         sapWAWVuR0y/xlMFEmvcI1TwEtLx4qypSSPyYmicbmI00X6L/IWXL3mgcQIsJ/hLjw/v
         KPKg==
X-Gm-Message-State: AOJu0YzWPExIYkop3Jdmts9qjFPbIvsfqbVu+OpwRjRkdZLc9hHvtTLb
	Ng/Caws/P5LvIUG6eB+6kAfnWCfXdAMInwBW1EzHeo5jSDnqXHT9fSF4pWUBXDYtqqtwZEIyLMH
	lvbztm69DvLThOdfNmE7AK9LLUkI5S+vzWM8U
X-Google-Smtp-Source: AGHT+IGb5F/ggcI3jz1RUx44031WcBMTlky7xP6DWT8xj1loQKewOpYzcoFYeVm5Bcffm7Nj9lhcl1vtTTW4UO2x4wE=
X-Received: by 2002:a05:6870:970a:b0:268:2efa:2de0 with SMTP id
 586e51a60fabf-273e6469d6dmr16662999fac.13.1724781842495; Tue, 27 Aug 2024
 11:04:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Aug 2024 13:04:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240819233628.2074654-2-swboyd@chromium.org>
References: <20240819233628.2074654-1-swboyd@chromium.org> <20240819233628.2074654-2-swboyd@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 27 Aug 2024 13:04:01 -0500
Message-ID: <CAE-0n51fjJ8QO2eAy5ZbQOwo9Urzrv1NnXw6KzB=mwHoVoJKzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, linux-clk@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephen Boyd (2024-08-19 16:36:26)
> The QUPs aren't shared in a way that requires parking the RCG at an
> always on parent in case some other entity turns on the clk. The
> hardware is capable of setting a new frequency itself with the DFS mode,
> so parking is unnecessary. Furthermore, there aren't any GDSCs for these
> devices, so there isn't a possibility of the GDSC turning on the clks
> for housekeeping purposes.
>
> This wasn't a problem to mark these clks shared until we started parking
> shared RCGs at clk registration time in commit 01a0a6cc8cfd ("clk: qcom:
> Park shared RCGs upon registration"). Parking at init is actually
> harmful to the UART when earlycon is used. If the device is pumping out
> data while the frequency changes you'll see garbage on the serial
> console until the driver can probe and actually set a proper frequency.
>
> Revert the QUP part of commit 929c75d57566 ("clk: qcom: gcc-sm8550: Mark
> RCGs shared where applicable") so that the QUPs don't get parked during
> clk registration and break UART operations.
>
> Fixes: 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration")
> Fixes: 929c75d57566 ("clk: qcom: gcc-sm8550: Mark RCGs shared where applicable")
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Applied to clk-fixes

