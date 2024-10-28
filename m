Return-Path: <linux-kernel+bounces-384834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E39B2F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728361F233F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E41D5ACF;
	Mon, 28 Oct 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtiIxZNz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1E1CC89D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115416; cv=none; b=BF1VIi478bkvhcUestcZXTQkRZ+sjApTBQMo5f0K4ImJ9luXAkRjXwrCAqDmEBduWBpeT4fr8BogYu44cxo1vY/BcIk6UHHN0BMvIKgjlTh11zeNQKjwJJzLVfu7rp6P0PC9BzuYUxrbcXD2VQxkVp6GLRR4W6nvsj5jsd9VseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115416; c=relaxed/simple;
	bh=RArrHGF2YIg63gV/XEn/Mjgwbf5E87zkb6MWL2Cs69w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMSkPyoRwK1SaRssrCUdzd3M7Uo7cFO4xLeJrGdFx0XH4tVFwxfQaRWJ/qlLzSN73ajKHfUgtYLfN9Vqs2SLWEd4RLKk9J4kmEO0xegWDHzou7OTTpuoW1OVIk5UHwUQc3Ed7sCoR+FTB2Pd6ldc4tufymv/EmB/GRig1/+dBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtiIxZNz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f58c68c5so6863220e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115412; x=1730720212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RArrHGF2YIg63gV/XEn/Mjgwbf5E87zkb6MWL2Cs69w=;
        b=vtiIxZNzPF6iwiZiBck99Ic2G9vV+W+nP9ux4e18AY1rQ2vhpQulqE23yACVMsgCRX
         VdeiTxi7A8ZJO1RrI+EAoihg4kXTvVHxwyhDOlllnRX0gI3fXrgpWa38sHfbngNxinN/
         sRZZofpFaVR4mS3FciCGHXOAJ7zMaTCQHMQyE7KvcR+RkZTx3RESsGdlfV3t5wDo+mSc
         3zLir7RWvmhHNHhD/KsTxMD/zBcyJu/xMw/2npZUEiGaIGHeer5mu0WTUewjA6Tp4LcJ
         Wv8EIGyCS6+Yq1oaLMAWaZ7IIwiV2KmL5BPRZVSTLx9bPtKfyKyjy71705ZaMEOOndII
         TEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115412; x=1730720212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RArrHGF2YIg63gV/XEn/Mjgwbf5E87zkb6MWL2Cs69w=;
        b=numKGyrq2KC/dYf2KF0nPiSgVSB9qCZbHi1FDEQ/bWHGu49qCg3w+7fWI7ggI9+PPA
         FAsvERP1TGYcR32PED6H5EzqNxKC28DswAGCPH5aUul0G0UUbfX1gF4LhRcjQ1K4YfdY
         1f9wbSOg58LYXeqQCK75LIPhf6Ne4htEfbep/jdP8DVidzmEwK3Hy4D3luApb6ymZEo7
         pjpWOA9gkQ/DpXaazzSFBqd86CNTPzPZvrdCMY0gTnVGSG/mr6L3WQhdo8aSpnUX6bnk
         G9IwBlmQUYVA8o53kjk7k0bg+b5UEkmBeRGfEmtwfEyeTa2/TRD4hAmxmC1X6JqPUGro
         yOUA==
X-Forwarded-Encrypted: i=1; AJvYcCXgJjG7+KxdCON2ndo7V9ry2bO/IjUN9kBOkp0akaR7CnTudVQbZ2c+XM61TvlP9h+etF7P5SRQlmHjHb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWa4JpmAEkOMmgsameGNclDtx51xsB6KbZXx2vWLv9py9UHWO
	JWQtGV/LFaLRrNNlam6DZOmjU52kAeJ1/4XUndItb7zkbC6MwwthiYWFO794lsERcPmAuaVm+AG
	WgseR4cSl/uQUMYKJpflsjaDpBhgj6TcoOTOqCg==
X-Google-Smtp-Source: AGHT+IHCQ3wGv8ZOcI+3RyfHBAwIMvlM2QesKjoj+hXCwieVABwtxCo7klOO7mF1F+OJkyzlIbwSliMQSyYprcP+Nck=
X-Received: by 2002:a05:6512:b8d:b0:539:89a8:600f with SMTP id
 2adb3069b0e04-53b348cfdefmr4961269e87.23.1730115412461; Mon, 28 Oct 2024
 04:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014192930.1539673-1-quic_mojha@quicinc.com>
 <CACRpkdaAVE8VMNCFA4jQ1+YLuC9=4mc9Bp2PRxeNFQoHB+NJrA@mail.gmail.com> <Zx82vLyD1JMv4Cx6@hu-mojha-hyd.qualcomm.com>
In-Reply-To: <Zx82vLyD1JMv4Cx6@hu-mojha-hyd.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 12:36:39 +0100
Message-ID: <CACRpkdbCox2VcTRRwN4EJ28SivP1R_bF6nAV0kMimDycZTsa6w@mail.gmail.com>
Subject: Re: [PATCH v3] pinmux: Use sequential access to access desc->pinmux data
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:01=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:

> How to check if this has passed the criteria and not regressing anything =
?
> Sorry, I have not subscribed to linux-next mailing list to get
> regular update.

There are a number of automated build+boot tests going on on linux-next
and no news is good news :D

So far it seems fine.

Yours,
Linus Walleij

