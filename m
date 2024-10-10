Return-Path: <linux-kernel+bounces-359646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96D998E82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55031F21BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7719D88B;
	Thu, 10 Oct 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk9TVKhu"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAC19D07B;
	Thu, 10 Oct 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582172; cv=none; b=svMNaC3QpNHs8OqQ6g8fHEuJq79BNqcd/XlO/EZ/jaS5yODUZDYP4XKHgUMTXHigcOPIAyW0oG0uoqnjjBwj8B7fnPFjHItnngBx+20Yia8jAzaro/oaDrj+tysPjiXLN/Hv6CRqAhHLR32NqHlkVWQDjPigouls0/rWJi069OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582172; c=relaxed/simple;
	bh=r9Y9dp0ia21GJKEJhhjl4hsk6OfUJQDV0li1hpz2F4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je1IIKI8HxBMpHzTTcCLs3DUfxXTtThoH6I9b03234UxBIua43VkRPVTu8WSXYGMG3Qt8rPBTvNmgjvOCH7D5rqFwPSyXtAGUljupo4M6jjkENfZz4uURkjQ2DpgweEZa1bQvIhAaI4Y6lvKS62mfxgOtl8//Xyk0P4mNhoUpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk9TVKhu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71def715ebdso848795b3a.2;
        Thu, 10 Oct 2024 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582170; x=1729186970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9Y9dp0ia21GJKEJhhjl4hsk6OfUJQDV0li1hpz2F4Q=;
        b=Yk9TVKhuQ3hOF/C82MAYVmPJ3tstFcHJtezGCHOnDWAwDp/M14GMnUS4+t/corn/Q7
         UNvDQkonU5gXXXAIP70J7eJcfip/FLWAgsmrK4hGo2Bh1OJ2d5s2PXPDRoC37V6bR0Qv
         eITt3PWTvy8JHh/jPdsF4F5nDBbw2EFcMLujZo6XPtJldHxaUQfnqEMPUFLdhebISc9b
         8A+Hj65n5my0mZ2437Fz9sKW0wOXS7N/mPziconIOksAYVKOXzKWLxrCpOJ+kW0ves0G
         Iwv+IomrzSWvVlUZauDWg1osn3jUDiYNhj6pMZGkohh5QhXzbvsITv9EHYH6cljf53MI
         73kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582170; x=1729186970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9Y9dp0ia21GJKEJhhjl4hsk6OfUJQDV0li1hpz2F4Q=;
        b=vKo6kiC/3X2GahwUMwNKCxFYICB3iBHrCgPXDsyMEsDDNm1Dr4HhI4O3n9Ah3/rt5e
         Il1pMjddpChHN+adTgf9rza3WvvbSsfSEPLXWXyhc28HWi6IGJlCDMMyGKb/eirVNSWR
         hpO38aCrjZp2dxI+ZZWGsZCPBWqekWXIBlcIClAZ2jn1BgWK10caADmFSkRvZwLTQBJ4
         Ojlv11umocwSp59cZXsEq0Yrf543CfUFdAfEqouGraVXQwIcGYKpJ9WnlzGhHCOPfe1m
         J/wMMS54US+VRKtdfC4/B9nd8H+eOEtvOT7fO1qB4O4VU90Oe9+pZPzBwNCs92SGWp5Y
         T6zg==
X-Forwarded-Encrypted: i=1; AJvYcCWvfuzPg2ugqEiYLotifdnscgLr7FNGxZjrcVJQ710w6LGdXQ7Mg9bLfnNIS9HU+CNwosWvANeLbuav@vger.kernel.org, AJvYcCXTV7Tn8ENjKFVCE6O1FZZK5V381Re1ZwY9u37YMjvrIy6e6OjVrQR9bcLY+3oRKJ6rJP9nMbICsAk6rhYN@vger.kernel.org
X-Gm-Message-State: AOJu0YzJheZcArbCss2XZhTYxBkelFkQ2yJpFU6HhDUve3S2eyMDkgUy
	jpyDMKq0PJGoO7rj/Q7a2Egpv6JTFILT0Ber6kt2dpsP1KbtpioZmE7ankhd
X-Google-Smtp-Source: AGHT+IG/bt6GaqrKZX93wp3w6yysAt6/pJEYER+jwtjNsIXy4062y+ky3XgGBO7Es//CJOF0hXDglQ==
X-Received: by 2002:a05:6a00:1312:b0:71e:1cc4:2754 with SMTP id d2e1a72fcca58-71e1db63eefmr10819173b3a.5.1728582169664;
        Thu, 10 Oct 2024 10:42:49 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e9843sm1287240b3a.24.2024.10.10.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:42:49 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:42:44 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: imx[6qdl|7]-[apalis|colibri]: Update
 audio card names
Message-ID: <20241010174244.r4sjlapbw5dhuvag@hiago-nb>
References: <20241010171128.107819-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010171128.107819-1-hiagofranco@gmail.com>

> This patch series update the audio card names for Apalis and Colibri
> iMX6/7 to match their specific SoM names, making it shorter (less than
> 15 characters, as shown in [1]) to fix warnings related to ALSA in
> Apalis iMX6 and Colibri iMX6. For Colibri iMX7, also do the change to
> make it compliant with the other card names.
>
> [1] Documentation/sound/alsa-configuration.rst

Related ALSA UCM PR https://github.com/alsa-project/alsa-ucm-conf/pull/448

Regards,
Hiago.

