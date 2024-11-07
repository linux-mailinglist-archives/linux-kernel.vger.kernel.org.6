Return-Path: <linux-kernel+bounces-400378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2519C0CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF3C1C2437F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E0215F71;
	Thu,  7 Nov 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLnNPBEe"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3239212EF0;
	Thu,  7 Nov 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999904; cv=none; b=HiWATJGyJBxS/zheoqwZit5JcDv7WZH9mWOikvFeQp7lDkrBBQXr/bLU5b8WJGLasbv4z4EiYqlBU5X4vIlmQBwJcVDxHVTxzNpU2pUdkVsaxZwgYVTKjv3Ot28xoctpZMELbIKCALAbDPengLHM4ZhIh7CxADgP9b1QttoosFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999904; c=relaxed/simple;
	bh=3L2w8sk0IewHmNOdYMkEGuOpJA2AnrnOMzLbeG9YLuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQEpS9oYPkmZAFjdNbzmAdoIT/v5nB170AP4GLKwGPbLF+V4IU7CC7XAK1GEK+3jx908XkTckYU77iXhGP5dX0Rqity9Fhdtq3Sy+Ea9Y8P68t2VBZTlAaVG0Iihad1BayD5aLhVKRa0zP1hPqzb5ULjD19mnteTCXVyEegLqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLnNPBEe; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso18194841fa.2;
        Thu, 07 Nov 2024 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730999901; x=1731604701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCQcscgVQW9TCpLgV+TKeC9YuIl0nvTbO9Vm0LDTTMo=;
        b=aLnNPBEeUJH1AuwAIHa0E6zd9qLGKzGsU9oWcmZmohExhKuQGux2Se/HZu3iiWDP9c
         B89PtbRxw11WcENltxtGgK0bkZHlZjEQ1xpwYZq0Znq0Na1b+yIXmuica92c45n579Jc
         3ARx05Dl3JtTgsVc1P6M9d8BGAz76DoBqR+8C78ka2EANWm2sGOfFJTiYa19a/VsUTrv
         +pKipyh6GXPDSVSY286AGiZj2YhvnYRqJbKVlmzHiA8oCiBcwfrYtDgvCorNJkouugZ3
         VrsQJMRTqsNJTHsW98R5gYkEWnbSn9LeUsR672Klz9+5KULA+5YU6hTyr5dWl30cJAKm
         CF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730999901; x=1731604701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCQcscgVQW9TCpLgV+TKeC9YuIl0nvTbO9Vm0LDTTMo=;
        b=fxJiG7c932g2lLvp4FIJl0KLsvTtWxH4XZIkTFMJ/DpkJjuOcRHtTsmHBTqomCo4NV
         vXuO0VxhJR7m70U6mv5SaYCLnIwatagcgpuWwdOM36zT8jNWyCEnj60Y9ABekGL4T/PW
         wSjuvOMa9Xfw4xG3DXMySR9vT6ptPiZ83fto4S7DP1N9kj9r8Run6wXo8grj3yAiMTe4
         qGTlwBzBnifzjbyEsRDe5WQR3e+15Rs5u8W90oRqzrpH8ua2XoasmRhKhq5VpoYZQmNP
         dDnXhzB0SDWJCxuFS2Uel9pgMEyWtdADwryq+BB9I0roqqxzoWxYO2CoIfMPiwhfDHco
         W/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU01vfrIcCUfz19KwTjRiQQHK91/V1M7cD2ShrEnXYJXutdPp3Hch3IxC6B642itMo3yEo9m2Pa2G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Py5pOymfqA0JpVmtuAiLIJHo7uUqcZtMAbV6pja9ls1P0dU/
	hK4Y7JdWh4sAQL6fWN379PaqIlFNUbAH0lych14lbhxA36AHw4zdAt2TUMCmvSlHSck9+1BwTVP
	0kKJALYZ1oJkUBAtcLVDZPmQeUqYKVvXzALc=
X-Google-Smtp-Source: AGHT+IEwkOTrQhYLXYKOVmXFMdan5Xz1LVGnbN+vdBDj11DstOSVIbAfHtM4ppHEWuEpf40Q1zC+Rcgp0Eu169Gf63E=
X-Received: by 2002:a2e:ab0d:0:b0:2fa:c0b5:ac8c with SMTP id
 38308e7fff4ca-2ff1f68df7fmr2046251fa.21.1730999900430; Thu, 07 Nov 2024
 09:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105045535.84071-1-yesanishhere@gmail.com>
In-Reply-To: <20241105045535.84071-1-yesanishhere@gmail.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 7 Nov 2024 09:18:09 -0800
Message-ID: <CABCoZhAK7wTrUFouz306QJ_i1ytgo6cLEKemc_5qhez6Wo-1Zg@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Clarify EPROBE_DEFER retry mechanism
To: corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

Wondering if you have any comments?

On Mon, Nov 4, 2024 at 8:55=E2=80=AFPM anish kumar <yesanishhere@gmail.com>=
 wrote:
>
> The existing documentation for EPROBE_DEFER explains its purpose
> and usage, but does not specify when deferred probes are retried.
> This patch adds information about the retry mechanism to provide
> a more complete explanation of how EPROBE_DEFER works.
>
> Specifically, it clarifies that:
>
> 1. Deferred probes are added to a pending list
> 2. A successful probe of any device triggers moving all devices
>    from the pending list to an active list
> 3. A workqueue processes the active list to retry deferred probes
>
> This additional context helps developers better understand the
> behavior and implications of using EPROBE_DEFER in their drivers.
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/driver-api/driver-model/driver.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documenta=
tion/driver-api/driver-model/driver.rst
> index 06f818b1d622..c86b948d0dfe 100644
> --- a/Documentation/driver-api/driver-model/driver.rst
> +++ b/Documentation/driver-api/driver-model/driver.rst
> @@ -171,10 +171,13 @@ released all resources it allocated.
>  Optionally, probe() may return -EPROBE_DEFER if the driver depends on
>  resources that are not yet available (e.g., supplied by a driver that
>  hasn't initialized yet).  The driver core will put the device onto the
> -deferred probe list and will try to call it again later. If a driver
> -must defer, it should return -EPROBE_DEFER as early as possible to
> -reduce the amount of time spent on setup work that will need to be
> -unwound and reexecuted at a later time.
> +deferred probe list and will retry again as and when a device or driver
> +gets added to the system. A successful probe of any device will trigger
> +moving all devices from pending list to active list. A workqueue process=
es
> +the active list to retry deferred probes. If a driver must defer, it
> +should return -EPROBE_DEFER as early as possible to reduce the amount
> +of time spent on setup work that will need to be unwound and reexecuted
> +at a later time.
>
>  .. warning::
>        -EPROBE_DEFER must not be returned if probe() has already created
> --
> 2.39.3 (Apple Git-146)
>

