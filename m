Return-Path: <linux-kernel+bounces-567396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAFCA6856F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40D8179BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6001E24E007;
	Wed, 19 Mar 2025 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlEmjcmB"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F3849C;
	Wed, 19 Mar 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367886; cv=none; b=ZsGznRnaULEinHhEVbKopQ4dK7iZYPW7NnowYZ6XNFEjVwf3eA84NEJi9Tb567Lc2kg0Li58H9ioov3mSbPMMEikhfN5H7H9mTzJXNmnVTHrTzCA4ZqmcD14RErfcnTM/D6okj5WDgc9QlZvn61TRaR+PNn7Hpk/hXKHNKXQScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367886; c=relaxed/simple;
	bh=jiAfj4IElgBqEg5+PLChSU4IpIj1nxRfVkLGRm2D6Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWXtT0NlLwitLQ5aTIahhbgS6acfTC8U94j9D/jRwBPeOefXN/LOp3RHAZQs3wjse6c4xawVTTiNjmqIx4nbwYVbYmc+dJ/yT+/GxNNzkuKVY6YGNtOZTr3312WGvPi+/Mb7BllDrr5xB6IR152L+4RQ5XM5z54Z+P+MrJv85Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlEmjcmB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso5435486a91.3;
        Wed, 19 Mar 2025 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742367885; x=1742972685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jiAfj4IElgBqEg5+PLChSU4IpIj1nxRfVkLGRm2D6Bk=;
        b=RlEmjcmBMO3Yjf7BSxkhA3YIH23Wvne0HmCRlvT4JSJQg09CHKkozt/IaJd854qWsI
         OCyJ+YEM8EnM/JwfF61HY+VTTrcfPjC3Sz2S4S6wkdiB25+4CYNUKwtvHsoB4EIkr+nn
         rRHGoXa1Ga3Ene+E/wRtF/eJex/KbgDgA0j+bk817tFW3IupOHE2Uyk2nXohpHvqy2hg
         NLL1lyzw2UK60qZERRn9bCISUNyOgUtFoCXdGa0yQLEg2+vU+vzmu84TXQTOdcf4kqwK
         H8fmqKRFnQCUVXf4XvN68OdySoYTR+UfSrkpCwzBzabHgrQKJQkGCaD0ctV+lfVtMEyN
         0rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742367885; x=1742972685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiAfj4IElgBqEg5+PLChSU4IpIj1nxRfVkLGRm2D6Bk=;
        b=pHaVltXP0OZNNql0k9ykq9ccFuWYUb6W+bXQqP68YHCZe/7G1QEb1UPuqTWd/guI69
         JkSPRmY9Y/WE8irWnf62W6/1Y/5tMMqXPaFAsmzQZ2R4zxIJO54NN2VhyvfRFA/GU6rM
         jIZP1agkXaTvMhffj/roFxlHf+Vpc4iPI4iKQEvDzfUpCxZ26qpygQFZ/YPdK/JLLHSV
         ninpURcIQTlNAhHzMj0CslydAAlgZ9Mxr/VACDtADtjTe9lfCsZJHWUk7pkKePoQPg1p
         lxbV0IVNR7tPo5v+OFbukN5tgIVyAIwip8qGz29l5+z45PmJlBeqoXlqTQMidEtXnzIP
         8opg==
X-Forwarded-Encrypted: i=1; AJvYcCUMUpW0yluVHfTxd4r5Y3IWCLdd3LgHDy0dsa/t5puDKytD1zSSutW6EHBgmrVAi4QhkAJYnBpUWfQJD962@vger.kernel.org, AJvYcCVjnnoF2oNPhB3MT2N4K5zSAJesG8iQaxeIgAnCOJdxi8n1r4Mw4ITztUAeYiv6viraqCshZ2naPpkM@vger.kernel.org, AJvYcCXXYWtU6rWnS8wJo82heq7FQ/vv3rTFfItwb1GfK/nKGAwNgNG70d16SgeekFp512VX/b1OZ1Eq5hm/JNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxMWX43dmLP2RL3lnN4fB442EONN6KjXVoNNQg5e45reJhrxi
	yb65MpsiAHqIbJ1pPpz7kprn3BT704HfB/8rACQLrP9SDLasqcGDJTURHOdgvkVagKaspVqLKDn
	4bi4IbSm0ewW0fEvyY3F93ZE1pHM=
X-Gm-Gg: ASbGnctIaurPL/aQQrOECHQoywHrOft0gnhLrDI6//Xh/RLWOMhSnhe7XZfW9hqRoXI
	E1rVUvIUpS0DwortKEmUHJ878e1jVPwO3OTxpIiMQ8BKhSUe1XuPSxzK+eSiSeQdKJnwReracxs
	C1yTuYHrTcyp/d+K73b/FFJ3U=
X-Google-Smtp-Source: AGHT+IF7sF+rEHN+McOd/gdhxtrQC1m+FhYZvpf4dWKwkOdb9hKSjw3U2gTtL2CCTwVJ/KBH2mS5pciMbrLsv3G0xEU=
X-Received: by 2002:a17:90b:4c4e:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-301bde41b97mr2645278a91.7.1742367884632; Wed, 19 Mar 2025
 00:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
 <20250318085444.3459380-2-florin.leotescu@oss.nxp.com> <7afcd224-1154-4e2f-b383-10f6a89fdae0@roeck-us.net>
 <CAEnQRZBmYdLh29ha1FKz8=CbxjFBFFTgDkjrEmwTxW2WcxodfA@mail.gmail.com> <ca734f66-593f-4e7c-bc76-e343a7eb88d7@roeck-us.net>
In-Reply-To: <ca734f66-593f-4e7c-bc76-e343a7eb88d7@roeck-us.net>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 19 Mar 2025 09:06:17 +0200
X-Gm-Features: AQ5f1JqTh1OKvsFHXWbBK7NlMP4RU0DewPez1R29Ybz774cJu_EpcSsA7szRxbU
Message-ID: <CAEnQRZDf_ko2p50EwR6q=dfkwdqE=c7fZe0jO2JdSmbaDa=j3Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
To: Guenter Roeck <linux@roeck-us.net>
Cc: florin.leotescu@oss.nxp.com, Jean Delvare <jdelvare@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viorel.suman@nxp.com, carlos.song@nxp.com, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, festevam@gmail.com, 
	Florin Leotescu <florin.leotescu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"

> >> Is it necessary to make 'pwms' mandatory ? The current code works
> >> just fine with defaults.
> >
> > The code adding OF support is added just in the next patch, so the
> > current code isn't event
> > probed when trying to use dts.
> >
> > Or am I missing something?
> >
>
> The patch introducing devicetree support to the driver doesn't evaluate
> the pwm property. That makes it quite obvious that, from driver perspective,
> it isn't needed. I don't immediately see why it would add value to _force_
> users to provide pwm frequency, polarity, and the output configuration
> if the defaults work just fine.
>


Got your point now! Thanks.

