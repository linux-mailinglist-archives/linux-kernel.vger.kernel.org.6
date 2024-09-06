Return-Path: <linux-kernel+bounces-319173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3745F96F8F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA49C281764
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A71D3622;
	Fri,  6 Sep 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TO21w6Vn"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DA1CF2BE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638490; cv=none; b=kfE4x5fosMQ0IJAGNXOnOXC+fKXnMPRqiDSQhNuLFVHnRrQ+RmSrVMF5orN1I5wbEscsedM96q7CFKCOEWGqpS/wvUGrQpcSUXonVn8iFFdX3Hts9FAZPHxp1cxJzZxAt4DJoho6tTXxWXKpyrh/9xd7Xux22ZoeFA3/EuObua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638490; c=relaxed/simple;
	bh=E5dl+ODA7ZwdKUFmEhO2rwmI//8AUu2GNeSdPWItsxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgYtANPpwCn0UdV8KIXNW/MsDTNYWtm3ydhhPZI/YgT1BTFC5NtGhj/ZIkkgXTJAFER294zSLqqJqp3vTbjDAhV+wM2FLYFYI0aoaWpmKXZGoM+GLTCk/6CWmMKAz0OB+YhfIyBKRAIMyYtDS0gR5Ev4qgw1Rq6yLavt4A3pz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TO21w6Vn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20696938f86so21129675ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725638488; x=1726243288; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5dl+ODA7ZwdKUFmEhO2rwmI//8AUu2GNeSdPWItsxk=;
        b=TO21w6VnhjeQ2mxyl7nMCp8KRig0Bwwu/C8N61CN8whF8dKa0veH5uz8COBYfb0gOL
         Rf0F/VsNZg73cPuF1a+zhEfhKhwZiequNz9YLWh9zMWTu0OCVRj0RiPzG/DywRloglY6
         MkaqQ7AFVpSarS//qNtF8sCNqUJxlNge7Pb1Z955DjnYs9M3FGwGdPItonz6HgTfbUD0
         jmNN1Qz+1TwXh0a4lNso/XYIBNFte0BA78uP+DZQu9CcnOS3fFsDxGY9RMjbZfJo57Hk
         qrbzIqUf8xiJztq5/7HrUZrM5VK/uh3Ngj4ZhAtl6X1lKAtEv/nI1Gzq/Kwes1gL98yO
         cksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638488; x=1726243288;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5dl+ODA7ZwdKUFmEhO2rwmI//8AUu2GNeSdPWItsxk=;
        b=MCbbh7ZcCTjX7SkuJAwPlu9MZ5+6qrhLWdwTg43dHofFsSxAzmhXHZMdS1WR/xMqxA
         0oS/N8i0k1LNYoarV1dc2WU0j6x7GpfXX7cJXmZCrv4PEUAohmefTz2VnjuiNF0ht4eT
         2br32bR1a2Svi3zSlfIBZqkSSvrAAxYkkDeQf/TAvlOnOGXBprafc6GqjwhhnU3vFjoK
         JDkU//R8+rn75I6dug054U5IFp+zZtK4Vz86ErhMn2ek5JyAUCHC9nDQ+LwzPHhBIcX2
         3k6rmk7FFeZewJsdfIDFqrgRQypVEf16+3IcRjkwpNyQi5HWvsO+jNVMRUSAtS2pYo7l
         KZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiC5z8NZdwvshaRPwFR2Li0yKIUy4fT87t/mxvivKyx5tAJTFCkxRINK/OCQ5kQkuYtDDcURvIrrO8vJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsWIW6dAaCpB/85d9nzRqGMQbvOcfYImSRLquR2O/mdYNNwZU
	PmSwLIph64wjoFPOF3Vd6mZStbLJAgCJTwpJuMyva45GloPnDWpHmOjaooQDKZA=
X-Google-Smtp-Source: AGHT+IEVYSDo+Viz5H19s+SaMCawwx3yMXZY4ie5Hu87TIb+qJoh7/HUoevJqj/Y0xEHGnjVO/AdzA==
X-Received: by 2002:a17:902:e809:b0:206:ac11:f3fd with SMTP id d9443c01a7336-206f056f7e6mr36117715ad.30.1725638487275;
        Fri, 06 Sep 2024 09:01:27 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea65b54sm44784045ad.243.2024.09.06.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:01:26 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v12 0/5] firmware: ti_sci: Introduce system suspend support
In-Reply-To: <20240904194229.109886-1-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
Date: Fri, 06 Sep 2024 09:01:25 -0700
Message-ID: <7hbk10ai0a.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> Abstract
> ********
>
> This series introduces necessary ti_sci driver functionality to support
> various Suspend-to-RAM modes on TI AM62 family of devices. These Low
> Power Modes include Deep Sleep and MCU Only as described in section
> "6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].

Tested on k3-am62a7-sk along with my related pmdomains series[1]

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

[1] https://lore.kernel.org/linux-pm/20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com/

