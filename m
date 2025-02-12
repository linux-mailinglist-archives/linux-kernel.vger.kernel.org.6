Return-Path: <linux-kernel+bounces-511058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAED9A32534
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6486E16548F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708120A5F0;
	Wed, 12 Feb 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOPjiH12"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B120A5EE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360588; cv=none; b=PyxuQgUyiVpF2UxcrJikToxLQbZZiyx6YmlQOpIg4WiSnakEpxlAQKPfekAfqCH6Ch+RzgsK0L3XfvMiQYlGftWLk5xnz2Gghvvfb/yfR3KLfq+1D8xohqTdlVhkfTQwIkpSDfoyttUu4xX8J3hxAjRORfkSUY/ePn5Xxh2YKhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360588; c=relaxed/simple;
	bh=NhqxhiZpfWPEn6pagf0thRaPnjSAZWlw7MZOS2drRSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRuwT0VD/mBXHBwyhLNTeAslfCRCEq6tHXc6dgTZNSyvkkZtjdE6YpWErljbFmrbUgME1ZWzDEcREbvpP4oQw9NPpP7h+FRLyaKqV2idAISbfTZpP3FGGnXRybFaptHaAXg4X74qQ+3HqBiAVp64P1/iBcvmnZnKZVDICBbgeaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aOPjiH12; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5204d7b80ccso1565590e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739360586; x=1739965386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3Pf9VLqr0zn74ybOM4AB3R6LkV9Kq24XCYfLCd4K6s=;
        b=aOPjiH121S9adQ10u5Y7Ely/KmhiEWk+RxqNIuOKey/tm/L785PAjnZ/oUY6Y+PSvF
         9GXy2oBKBTiIBqhdP6CxjDUU+kLxM2WNVGQ2c1bZRs/yMEtRFg3LElo4VO41VV9uw0Qo
         rPSMcmQxBywDf+92B9H4ofeLk2KohsQhmLbNk97IU/dT/pXlVarf1GqBKNPuI5+iXZlY
         l5RDWKX8P0WidnMDQT/hOi5lHMn6tq8TVQCuOTkRRHSW7K0McfNQYu6OMq2vtMU5Hlt0
         0FnzNzRx6Ga8xukYfVZuISotC9fCFxZBkVNeF5B5srqijrBMQQmG3EzW66YYa6tJOttM
         VGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739360586; x=1739965386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3Pf9VLqr0zn74ybOM4AB3R6LkV9Kq24XCYfLCd4K6s=;
        b=xF8PHumlVmATDENLDia48z7IJWJKf6sTi0JT/IokMvk48bcs4Dz5jx/DaOmb/XP26R
         JMCmAtGf7gSzxUfkG25ofUgPyhXXCU0Ut4nSaGaQ+2V2BY8nxRCAgghJYSSlCvlSvxyC
         9oLNHzmyfsSftAtyAv2VofHvS+DIfQxB8i5zfSnt3cHeje2MYlf8h83c0Ut7lV1L7wuO
         117z7PENEYJCm4rHHH+S0HIXdCseandhPRG76feLTkotuuQH1wtEq7JPo1QoPl0aYrnM
         P+0c/0togW6bFQ7zqJeZj03zYfYIvD2qYvBEpSoMXWyjyrZMmIFW3nXNrh3nOgbY09Sd
         AGSg==
X-Forwarded-Encrypted: i=1; AJvYcCUGazLgF7rPsIU82p3tA2szN8NAbKdPdxUz1ZmH/Et3XAcgn+jdOo/jAni0elClxFhifkjwTFzaximH44w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivzW8ytH+eympZ94zuhXKQTuhdRzJCJ1WAkGjI9rsM6TsoBnZ
	g1pgGqgqvLk7+bf0/VvH22Jhnsp3Y85wTs8LJId55YzbXPkzgE6zuFplmfT8+T83INwn1bTfgV7
	eRtgShxiMMc8PFDBNCHvPyXiMV2CaNM4V6MgcKQ==
X-Gm-Gg: ASbGncsGZ0PrpMJAgbJMHxgKDfKeqGdQGjv4y45RDc+9ZQY/RgCt/roLZ4Z94DOm7Zf
	M1CHmvR1LVysyN6rgdq+DSORfIxzxwJAJjufbabDikeBX4km8m0m8pFXy2P1gY9YmfDceSLo9Q9
	U=
X-Google-Smtp-Source: AGHT+IFOih37+KrqDaHnv2z1gD470AjQX0R923clhFtL4aKxyGDPMwXe6xkjFhG576o5Jmtsc4iPKFF92U7xej2AN4Q=
X-Received: by 2002:a05:6122:3c4b:b0:520:42d3:91c4 with SMTP id
 71dfb90a1353d-52067b4369emr1897998e0c.2.1739360585770; Wed, 12 Feb 2025
 03:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt6Cuu6=OO9w80yhJbZB77Q0qf7nzYdvjbgDbgAw6t1jw@mail.gmail.com>
 <8634gku30g.wl-maz@kernel.org> <3902208d-8814-46fe-ba98-3db833b9a886@stanley.mountain>
In-Reply-To: <3902208d-8814-46fe-ba98-3db833b9a886@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Feb 2025 17:12:54 +0530
X-Gm-Features: AWEUYZm2GCz4FlZi-oNTIdRy1QPKZCSG3F-OJRaS44oBL_Jsi3XOtSmcXBGZNeY
Message-ID: <CA+G9fYsjW2U0k2XWBESRpy+xpn8hHGYTEV3TQu6qdeqj7fu6OQ@mail.gmail.com>
Subject: Re: kvm: nVHE hyp panic at: __kvm_nvhe_kvm_hyp_handle_sysre
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux.dev, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 17:11, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Tue, Feb 11, 2025 at 11:36:31AM +0000, Marc Zyngier wrote:
> > For the crash at hand, which clearly shows nVHE, can you report
> > whether the following hack fixes it for you?
> >
> >       M.
>
> No luck, I'm afraid.  It still crashes the same way.
>
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/anders/tests/2steTT4f2J8ZJjc3jNJFMuow9Cb
>
> Click on "Logs: html" for the dmesg.

Anders tested this patch and the reported issue did not fix,

Link: https://lkft.validation.linaro.org/scheduler/job/8118315#L1379

- Naresh

