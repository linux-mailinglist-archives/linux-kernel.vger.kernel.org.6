Return-Path: <linux-kernel+bounces-317925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBB996E597
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7D0B2191D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359981AB6CE;
	Thu,  5 Sep 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f56qms4f"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0A197A9F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574048; cv=none; b=J7ZtRknpCCwSnrdSe5thIC8U2/+DOGMv7J6y4ipo0IHMXhe7+WfTC0j2EBouPQvD+ksED855sUjheDUadEJQPHOVgZKXePML35JXBPlO1rrKOWSaZ3ZmL29nzEh6Hu9cIpQ31aTPgAX43C4YB8e/QpYgWSgpXz2r8LQiZ0fUdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574048; c=relaxed/simple;
	bh=hhxAdERSDtm2YMNAv9tC9+fZCN+vEHBPgrmtZVRb+Ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3u45Ezs52XgyWk/VJQ5Jp32P3h+EThnRpnP/j/o64FvpIosVz4ZqUigTYvJXODj7HYZTZGUrBFXj65jWPxY9q4E16bEcfqvOiqTtb2aQiP9+SYFkCJq9bx8jrI/PdpVfyL9wd1ucsTQzLjsusP9tQUHfFwisHdX/szy6Va/kSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f56qms4f; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so1016878a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725574045; x=1726178845; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxCoJ4d7AGkUckvbkcsYkJvEDQd98iS8I6ecIyIUBWQ=;
        b=f56qms4fCGntiFBxE5u9rIl008c7GMxTaH9/sOR+9mhaNyso+jV7Z7pgQoxH6b+YuW
         UOes3hhRkuEVZyPROtzZdJqslhwUe4s3qZAJyqAjFJYYn3kuiaY/g7dOy53ci/0falG8
         bs2jIwB0eDTa6RpUyqctV8ns1wQxTA7JkOEed5R1vJ62mrpm/ZNmVsipotZ8ZMjGCSur
         sGhXtZP5Qv0RgmVgifdi3h4QGJBReED6rXDTdC5KVrvrmbbOxOaAl1qeUv71VrwMd/Q9
         X2SbPNuysSjBcVLggaqXNxr8AOfV0ft/UmcS4mwlZHj6JHNF67BWEjJyRixHV0Mn4msA
         Ox/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725574045; x=1726178845;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxCoJ4d7AGkUckvbkcsYkJvEDQd98iS8I6ecIyIUBWQ=;
        b=nkYCCO2ZQOnOvPZvGB1lPbhaDLdwkwuJmvSxp53gcNdtMQSJBUQDyvV6qHEB3HtKpl
         A95FfSoGL4ne+13nH5CVe7c/BYIeMiTIlxkJSvOa7wTnfzNlfheOh+cDQTp8+8fZ7u2M
         wqkuoyE1JY9fmRZg8S+2FtyRFAbUTXXGytN6NfODTB5MOQeEcFoUEM1R7gFx2pGgK7hh
         Z+X4uzQRFcCYgNumne0gw/5WXHad7egh5U5MWrzI6QO60U0h1ieHx3Kqnw75P6AhRpPr
         6s2AvaoB0iDFcON6eLKIhAJgOZOVePhzuJ0uYilbKHYicIfFIur3KsJiI/SB5FIwKMIO
         Qg4A==
X-Forwarded-Encrypted: i=1; AJvYcCUIJwilcMkSGqD/KKwieUJuYOBxBc/kch2C3/e+cevlsKknkyqXCe9CtlDOkgh9gJ/jebrKnzded0C4OXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVGzWRW0Yw9QA9rQ23NWpHQqajzss6kcaavWeGo5anfMHytGB
	BTyvLo3qljs9KgFTNP0GJCey81tyrc9wzfYCOd2P4Lp+h+H91/VQJUhqzrp4xRZgh4C920O4KG2
	lCdw=
X-Google-Smtp-Source: AGHT+IH4wynbAkE58c46Y2j9xwqdI2xq2ZpegRrBUsA7WgnctZ7I/TqzM7iUt/Xmue7/tKSritBwAw==
X-Received: by 2002:a17:90a:788e:b0:2da:8e9b:f37b with SMTP id 98e67ed59e1d1-2da8e9bf63amr7752455a91.24.1725574045447;
        Thu, 05 Sep 2024 15:07:25 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8538dsm3802879a12.9.2024.09.05.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:07:24 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan
 <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pmdomain: ti_sci: collect and send low-power
 mode constraints
In-Reply-To: <CAPDyKFrFX_UeYWuZtQPoxHbZb0CwpLRA=QcMFsALwuiFTY3T5Q@mail.gmail.com>
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
 <CAPDyKFrFX_UeYWuZtQPoxHbZb0CwpLRA=QcMFsALwuiFTY3T5Q@mail.gmail.com>
Date: Thu, 05 Sep 2024 15:07:23 -0700
Message-ID: <7hplphah5w.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> The latest (10.x) version of the firmware for the PM co-processor (aka
>> device manager, or DM) adds support for a "managed" mode, where the DM
>> firmware will select the specific low power state which is entered
>> when Linux requests a system-wide suspend.
>>
>> In this mode, the DM will always attempt the deepest low-power state
>> available for the SoC.
>>
>> However, Linux (or OSes running on other cores) may want to constrain
>> the DM for certain use cases.  For example, the deepest state may have
>> a wakeup/resume latency that is too long for certain use cases.  Or,
>> some wakeup-capable devices may potentially be powered off in deep
>> low-power states, but if one of those devices is enabled as a wakeup
>> source, it should not be powered off.
>>
>> These kinds of constraints are are already known in Linux by the use
>> of existing APIs such as per-device PM QoS and device wakeup APIs, but
>> now we need to communicate these constraints to the DM.
>>
>> For TI SoCs with TI SCI support, all DM-managed devices will be
>> connected to a TI SCI PM domain.  So the goal of this series is to use
>> the PM domain driver for TI SCI devices to collect constraints, and
>> communicate them to the DM via the new TI SCI APIs.
>>
>> This is all managed by TI SCI PM domain code.  No new APIs are needed
>> by Linux drivers.  Any device that is managed by TI SCI will be
>> checked for QoS constraints or wakeup capability and the constraints
>> will be collected and sent to the DM.
>>
>> This series depends on the support for the new TI SCI APIs (v10) and
>> was also tested with this series to update 8250_omap serial support
>> for AM62x[2].
>>
>> [1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
>> [2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> Changes in v2:
>>
>> - To simplify this version a bit, drop the pmdomain ->power_off()
>>   changes.  Constraints only sent during ->suspend() path.  The pmdomain
>>   path was an optimization that may be added back later.
>> - With the above simplification, drop the extra state variables that
>>   had been added to keep track of constraint status.
>> - Link to v1: https://lore.kernel.org/r/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com
>>
>> ---
>> Kevin Hilman (3):
>>       pmdomain: ti_sci: add per-device latency constraint management
>>       pmdomain: ti_sci: add wakeup constraint management
>>       pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups
>>
>>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>> ---
>> base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
>> change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
>>
>> Best regards,
>> --
>> Kevin Hilman <khilman@baylibre.com>
>
> Besides a couple of minor things that I have commented on for each
> patch, this looks okay to me!
>
> Taking into account the other series that this depends on, what is the
> best merging strategy? Is it safe for me to take it through my
> pmdomain tree?


That other series should be merged shortly, so I will check with
Nishanth (on cc) if he can create an immutable branch/tag that you could
use in your tree.

It has a build-time dependency on that other series, so I think this is
the best way.

Alternatively, if you don't expect this to clash with other changes in
your tree, with your ack/reviewed-by, Nishanth could merge this series
via his tree and we could avoid the cross-tree shuffle.

Either way will work.  Up to you.

Kevin


