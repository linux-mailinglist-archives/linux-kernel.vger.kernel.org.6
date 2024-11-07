Return-Path: <linux-kernel+bounces-399652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFED9C025C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4F11C21224
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24C1EE02E;
	Thu,  7 Nov 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWGkMPNy"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F31EBFF4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975305; cv=none; b=LHvO3j2f6K/Fk9dSzqsp0+9y0JnKJBO7RuPPGiU/Q04Z0w85cCLjr6QJzoYSsP3xYejos1GXJ2uVD6ctElFsZQjav0t2VRUA/FhkC77DEAqihLvS9z9kfWZkRdjR72xLn/9VfBk6Z6OOmnVWnnnXxPWXA0pgSj9qrZPJBBKntsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975305; c=relaxed/simple;
	bh=zPW4RQP7ib3AAsmmMOe3wNgaOxasplolWrA9JBpP+Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rinZ1mcUMEy0s9rL9DC4YeVVfq20VPLBU+A6kg+MWEOu/jqtDKNpaKfUcDbcc9NEFxdsigCk78cZazh5zqvhnf1iqbey5OlXIGm4rJnNDwA2NWaPq0a0/6JXN51sLCvod6rE/0s2II5rqDDq7/wFDO3IMjPZh1U6pc+R8B0QZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWGkMPNy; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ee1e04776cso431220eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 02:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730975302; x=1731580102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPW4RQP7ib3AAsmmMOe3wNgaOxasplolWrA9JBpP+Fg=;
        b=IWGkMPNyTPtr2/xbW2b9E0AGBASrOFT/hZl6RzCkEBgS8d2AtBCD4/6v97ltX9LUXO
         TgNscLBvqyFeRhbM40xoDZhDc5LXcHOq+NBsO35pSj8jzguF0OD09AtobrUT/CRrCjGp
         pNeU+2QPjK0zaSklHNLVJy4wBNP23wpvITZeJqRWFggQRjBoK9OI8sfjV8A+vgHDufpZ
         22ywpeLFF87znVQAXdvv3+Lf1ZJkv9LiySyUhgeAyfVrlqvVkwXOeltDTGRxKCzexP5/
         5ay4TPxVDnfKG0Z4fkxEbhc90pPwztv9DNWRtKC1Ha+0e8gD0WImF11uY6DQf5mEpabE
         N7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975302; x=1731580102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPW4RQP7ib3AAsmmMOe3wNgaOxasplolWrA9JBpP+Fg=;
        b=svfefys0I2YmA7VCt+5ffpt50u6UqUsuwnrfc1SrhS8UcREDhrSgwsF/OByxPj+jh+
         VlBn4A2Yw291gIdTWnKojQRbbdbtZOLlpt7P4e+T0Hlz4T8lWrVERDtmEs+TX+SQ+Rqz
         v9agw68T708q6h4GCbAFFToOu91jyGcjqXPDQWWh/qkiN6IIja1unL434YZJsyYUA8LG
         YXJytWLY5j4ar5dFlKAfCYdkRZXMC5oi9GER1scaFydHiR3CmrfylKOj00/MSSKSEGT2
         m6CWohr7nDOqXw2oRDgriBqZQKy0QOGlDJwXdl+u1bkH4KX+uPwZ6Z8sCGyROv+06W5K
         YLiA==
X-Forwarded-Encrypted: i=1; AJvYcCXSbWFpasmE4VnOaQM10B+9Jd6KE245CUF10xObXEDr0whcjwoY7nteEp6G1dB6IV03WrqRp1P1BXM5t3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNwdnmMb/60ApPU3OHlghbGd2UHoz1FRQCs7WIt524RfS6Rgg
	RFDWAEdhLBN4aIeM087oRLpfXf35LHThxgm2P4n/WNAi9P75a0NaxfPO2Zk6LONlJmlIjzFANFX
	jI7pzMRBhOeH+aatZU5w/FUCuJYs15BDfqvC3Xg==
X-Google-Smtp-Source: AGHT+IFMKnoCwjkJOKUaR+JuoWoKm+qaHvhzoPAEmFGwh8CvhPiJdL6CFrkZE6oR1vfLCGTQ5HTejc7OEk/6lvThH0w=
X-Received: by 2002:a05:6820:99c:b0:5eb:fc8c:46ad with SMTP id
 006d021491bc7-5ee4ed7aea9mr564587eaf.0.1730975302375; Thu, 07 Nov 2024
 02:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
In-Reply-To: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 7 Nov 2024 11:27:46 +0100
Message-ID: <CAMZdPi_-uH6dk8KcrPRzNGJjX6YjkoNsYM1EJKJu5BYzrhd8gg@mail.gmail.com>
Subject: Re: [PATCH] wifi: wcn36xx: fix channel survey memory allocation size
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Kalle Valo <kvalo@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Kalle Valo <quic_kvalo@quicinc.com>, wcn36xx@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Nov 2024 at 21:00, Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:
>
> KASAN reported a memory allocation issue in wcn->chan_survey
> due to incorrect size calculation.
> This commit uses kcalloc to allocate memory for wcn->chan_survey,
> ensuring proper initialization and preventing the use of uninitialized
> values when there are no frames on the channel.
>
> Fixes: 29696e0aa413 ("wcn36xx: Track SNR and RSSI for each RX frame")
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Acked-by: Loic Poulain <loic.poulain@linaro.org>

