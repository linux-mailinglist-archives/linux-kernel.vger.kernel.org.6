Return-Path: <linux-kernel+bounces-276550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAD3949521
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8050282744
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140240C03;
	Tue,  6 Aug 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ae82Rm2c"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3B383A2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960082; cv=none; b=DlElrzkM6nZ1kAifKAB4t/4AyTKQTem2Gzsi8bMG3Mow81Pi64t165isoyjE3BJ2dApDuvqvF0qubzXLEgH3yuLBlxIjtvZA4z36bxCsqeUU0C35afBEN6Rplh2VTCoyvOel869C/NFt02nIgGQHFuMwUxf5eU9iyc7R2e3CLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960082; c=relaxed/simple;
	bh=X5YBMoqQLUFM306H1Z2BXgo8qpT6MtNLQreM18o6X8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpzMkYAOYdquUa9EqPcJ7bfqLoLBENSM+XGUIhtVcIw32GyKgwMUEyQtkTdm1UPHIKG0xoCfAdJN0wXExRyj/1pkJxsTXVjXH4p7mPr6aQPSKl0stzyhoIP1rauT5KF8EoMI31cJ9+sM/qtmMKhxzW3LgoUJTPUBs8gRYDRAF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ae82Rm2c; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70eec5f2401so634251b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722960080; x=1723564880; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmUn79CSM7NGeo487+spu1nhxVJFwzeytMXnQ3voN7Y=;
        b=Ae82Rm2co4yFomrdAEl6luXLAjU8DU8/5kBbJWPx3XYPmbY7nWyLs5BdWYDoVtvIhu
         3FQiT1J7w53x8ko86R64g396kUAWBaeaQIghnkH82dbDVc182dsqL+wweM/ZP5aXc4oO
         Bv+bDQ2UZuL1mTjRpxqlW+zzgRgh7WlYgL7Wl88I8kW+FyLE/cx3IAl5PMkPhXzblqZc
         9PD5nzpVr/qRmUTH8dgI5CGT81llf8vjmMycZwHTLICQT+pPNxjbP/m5dBC7jj4y/Mrc
         Cb04wievWZ1+9GfKF3eOGXtFhW3Im3D0auwcUijWzlec9+hWvHxMl7eu8OE/Jq1l1JIs
         JadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960080; x=1723564880;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmUn79CSM7NGeo487+spu1nhxVJFwzeytMXnQ3voN7Y=;
        b=CuJxtGy1/P9LfjUry5BLe/6r1FI+6FniYhuCxOWLV8xmV4XeLeRrk9EEpko1nrJw0/
         Y78YyYKUR5OAWaS60jm5i2LY4x3LcBEvwEkQVEYZFSAUBxkJrQwpuLLTWqK0RhgFTlOW
         sxVOhc/0Ij1g1QqNLk32ba5/QDLnqBT39XpenKf1IwIufYQ53AB+jD+/2gdzMAFQxLXk
         orqW154t9SP7lCvRK0f5/gfSQ7rwK2WIVFmDe60beRYYID7EKHVjad0zEaGtIIOiaG1K
         bhgRgmTrlSQIJ9IyieWwaNurrIi3lc4rHYhXDi9/uDrdtd2rJlEItoYL2zQG9zu/elwg
         Eo8g==
X-Forwarded-Encrypted: i=1; AJvYcCW99QSdT/7kJLGllz1WnlEUhJRLXyK9Xwz1htlmoDjb6bv8x3jw/eM79XETM/vJiVoyOYFCfdRFjAhmHiwqxRYQmUv22JZT6yl5DAuF
X-Gm-Message-State: AOJu0Yx4UvW+av7JOkXVRnLy2E1f6ufhNAmkyNQgYPAL6lElX9AavhkK
	vZ3X+4dAJ4Nr3K3o32LfcjApD2MHkI+rK/4Yg3cnkKmF1cFvC+wuFXU/UTMXKnJkzVbQ40AVyRN
	Rn2U=
X-Google-Smtp-Source: AGHT+IHZaJbZwjYGzEHemmAnuTugwT01mg2s+D+SsDgnI0QKvC++U4SuJnwQ2R973hkmWe3Sq0R9Yg==
X-Received: by 2002:a05:6a00:6f25:b0:70d:3354:a19b with SMTP id d2e1a72fcca58-7106d0474dcmr18128108b3a.22.1722960079863;
        Tue, 06 Aug 2024 09:01:19 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm7116181b3a.75.2024.08.06.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:01:19 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Akashdeep Kaur <a-kaur@ti.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>, Vibhore Vardhan <vibhore@ti.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3] firmware: ti_sci: add CPU latency constraint management
In-Reply-To: <20240806154415.wrsqxgyqdi2y4ae6@candy>
References: <20240802214220.3472221-1-khilman@baylibre.com>
 <20240806154415.wrsqxgyqdi2y4ae6@candy>
Date: Tue, 06 Aug 2024 09:01:19 -0700
Message-ID: <7hwmkt1vzk.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nishanth Menon <nm@ti.com> writes:

> On 14:42-20240802, Kevin Hilman wrote:
>> During system-wide suspend, check if any of the CPUs have PM QoS
>> resume latency constraints set.  If so, set TI SCI constraint.
>> 
>> TI SCI has a single system-wide latency constraint, so use the max of
>> any of the CPU latencies as the system-wide value.
>> 
>> Note: DM firmware clears all constraints at resume time, so
>> constraints need to be checked/updated/sent at each system suspend.
>> 
>> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> ---
>> Depends on the TI SCI series where support for the constraints APIs
>> are added:
>> https://lore.kernel.org/r/20240801195422.2296347-1-msp@baylibre.com
>> 
>
> Unless there is a reason to maintain this patch separately, Could we
> add this to the mentioned series -> it is much easier to review and
> merge them in one go.

Sure, they can be combined for the next version.

Kevin

