Return-Path: <linux-kernel+bounces-200177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE48FAC61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D27D282CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F02F55;
	Tue,  4 Jun 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAUaZu4z"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1A23A0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487164; cv=none; b=o70VcJoAfdEzKzrk7SF5bfrPs16Ucnwae+0cJ3yXPh7d3lconhsodXrAuBE6w/duWNa7x/gsJXMdMhrYl33tpI5PFQRRUPqh3bFNPKlHl+LtbDotDeZDt8on5KOPnnKAN3MK4h3E2inQad4rYCk4/qGyCFbADsktvMnOIm3zSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487164; c=relaxed/simple;
	bh=15pEe5GNPxLteORBQfGrvAQ4jQMZUEhpWDnsiYVvo5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dx+GHHMzH0JGA8oYMg3BuS88ue66hdq2m+6/rWTuc7rFHqNBEj7Hct7J3miUtGaILR/voMvjUoGl40gal/qJSJ26PIPYidVoooNCqqDwRD/l6KDIYRKEihQjpwd3/PbNVWLB9r7fPro0uZxS/MW2yIuTsK8H+ruFtxKMRS+rY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAUaZu4z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a63359aaaa6so670708266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717487161; x=1718091961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15pEe5GNPxLteORBQfGrvAQ4jQMZUEhpWDnsiYVvo5o=;
        b=qAUaZu4zHVOAAJUljR09fPip433Na3ninkmq6OqZCHyX7NBWdU2ebNJup/aA+feqDS
         gFA3A6eOQIO6Ncq3cfKieRPnfasHbAAGzCh+NFY0n2a6sbsvHYuZ1Mup682cJ1z1FTlq
         WtBBYHCkpfb45WvsvHbNlPE6U/Hxv6ZXjbC7JeRbbocrNtBSzDj+28uWu7kpbMEPL70r
         Wl5DSkdHmjYdG0sTJHa1oSMpDJZfisD8eDnvdrvMcDzyYeZnDd2SgjiZsyPu7//G9WqB
         y1/GhriIG4bjqurVQht2abZQMt/yUT4roFf51rB+SxlC+RQhTVpV6iCfQFpzVvVOsdhM
         TtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487161; x=1718091961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15pEe5GNPxLteORBQfGrvAQ4jQMZUEhpWDnsiYVvo5o=;
        b=srJ/+7iwffQVWKpeNTEyq+Ui+d4MJCrlHuLHbfeSNMU9IBrmchQcZyMRA+NOs65une
         fb5xjfhybv2J6AJC6mR/ZiXadSgNTmoblDDBLPrvOS40d1rhoufaHjZQbdhtp3uznTvX
         DJho3Azw5xsRUxX1/DAQaXWn7yGNl/67CKlkxmQqpDD9IuEXoJYkO1v2xzQsR5Dcdrwf
         0u31qlwEHswHFOQGUdZuSe9ePu8+b46GpPEr9nBbU9FfncgK2HAIdpDu0l73n43vX18l
         DGyxqhHYIf9xlslgeMHcIrPghOweq99aml+blxGSO+d4Oox6G7vqNtDH77sLzL1w03gr
         AuSw==
X-Forwarded-Encrypted: i=1; AJvYcCVTYOoo0DSt/m7GjiCxxHCnkVU3b4CF0Ovqu+sevJpusHotBchLOnvCT/CuBG0i357jONSrbmUp/fbnJikIjmOliosmPsEP7PKbLH9r
X-Gm-Message-State: AOJu0YyuZlAL08MLqu+FVktvKTPL51MIF9AOPhzBAYBc0dGQJFTeOvmL
	VMSUnKDYBFXK2dM9uit4DxM7CMwv+0AQzi4Jr4cvIZT6jpgwmthllHqHNprawBM=
X-Google-Smtp-Source: AGHT+IHvUcA/6Oaq3UarCZk0mfTN19uu+Ne4PDIdlEpwTxN7BJtF7D3Gf5q3AHla316Pq+3QWSworw==
X-Received: by 2002:a17:906:eb46:b0:a68:bfe9:a111 with SMTP id a640c23a62f3a-a68bfe9a651mr545404266b.55.1717487161129;
        Tue, 04 Jun 2024 00:46:01 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a552c902sm475478766b.191.2024.06.04.00.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 00:46:00 -0700 (PDT)
Message-ID: <9e5a3c7a-54ce-4219-a37d-c08ae2af9c10@linaro.org>
Date: Tue, 4 Jun 2024 08:45:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thorsten Scherer <t.scherer@eckelmann.de>, Marek Vasut <marex@denx.de>,
 Imre Kaloz <kaloz@openwrt.org>, Andrew Lunn <andrew@lunn.ch>,
 Flavio Suligoi <f.suligoi@asem.it>
References: <20240604074231.1874972-1-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240604074231.1874972-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

