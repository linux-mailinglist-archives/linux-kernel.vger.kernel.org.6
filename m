Return-Path: <linux-kernel+bounces-319157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A696F8B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F8B1F235C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC8F1D363C;
	Fri,  6 Sep 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j5MXDLXw"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232961D0DC6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638033; cv=none; b=QERwkjRnm6HlrYt51iLHTBrRh6jkvz+waQGmhJKaoLS+JxytIMH8IsSiyZWd0/DLP7bHR4Ui3kSdtQHSCiH3H5W6zs2RjYU9LVh85abiV3NsaZSftl4Xugo0WxmuDTyDH8A2cfATv7GcNi//GuPs5ym604/t0zRYO/wTeRjxK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638033; c=relaxed/simple;
	bh=73+bdBPq1AOzINIRfrSoaR2wZA28NZeimBgV3a3wDjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QFnYPzPdnNsfeT1RVtti2pINJZw2Hn9qRQ+lHSd+KDhrBAkbvtMBQeWa2VRTviTfAz1VTlc9ghSqx4rattGerR3KqnhoO/LYR75ZQKCYp0/G6hrLWwC7cufhuPIWpJpYT0hrksULziS4gwXv/FIcZtM9UAu6eHEJyBM45gpLU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j5MXDLXw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206e614953aso15262825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725638030; x=1726242830; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=st1kODhvyTXk6TV1RcdKVdBXoGE9hcS/ZZYObHLT4cs=;
        b=j5MXDLXwakArlruciNjt8Ulzzp4zZPjxfUpRF1/z0RAwo9JxLRRPovK5ED8ZUIW0KT
         pcgjqtLIQZPajf2D29aLuP+YtQoUFKfrvkCuLUDtbQjXUX8qOeaH5BWeH4wfLN3WxSsl
         KUzIpgctUquNpcSM1RxG2bgJCbdY7B0sJZYyYyDpkGnH6ediiitOfMFxM80+pUpDJpEQ
         bnixf4IuZNOuX/CQ3axL+4Z3B1N9IeVw189Af+LqzZWf3Umleo7lMmyp83kY3JUFksXO
         OncHmY0uZ4qifgO4VbSfFeWbqL+kKh+AyyGX7pjmG/BBG1tgnUMgIPwOfTDAkO57TibS
         yHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638030; x=1726242830;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=st1kODhvyTXk6TV1RcdKVdBXoGE9hcS/ZZYObHLT4cs=;
        b=JJhj5JQ5DWScf2wWvQHu+UOurKSnNlnuMA14qyfRIWv5nONfvDp5q6xUxJByKto/jI
         ZvxK29Zdc+yx5y3MjgNjnzQxc95bUR8yFI3adz2txPcM1DrkyetBJ+JVvHZr6ZNWfVmT
         8xpvljSP1OwdiGqnEKUFHQZvqlcQlJ7JJW6syWAydbNrwjP391lXfwfZgLauLWyngVDQ
         kHZq4Ujn/0LEmVxt6hNNRUHfnhbTK25Q9SWtRRctdeJVyMoPBiV/ApH1sm6iFMpJRF1n
         PSu+NvhJ6k8t40WffAqaGDh7dtgFaevepzQpQitB0G46vnHLSFYrn8486acfeUXLtaLm
         7kgg==
X-Forwarded-Encrypted: i=1; AJvYcCXR1GLaQK3/oDGSuMQtGj29WmHtxMnXBrByd5Z3P74olDUqoiZuO3gk4KFnnQtKv9qfH6Vd61pa4d0Vhfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnWLLnK88bnu6tNbxIGyPg/sGdpmadSc7Vz/C8EAYgDuaIU+z
	fgkI24NVU7aLjHdPoqy+zEtfK3M9n7NZLbU/TMNazvYooZIhRZEfLeDdBlg7yt0=
X-Google-Smtp-Source: AGHT+IFw9PxcaxQ7+rDmkcLXn+siO6V9uqYxbdPNfcgdVRHimfqKWxh65K7oC05RbvA9mJZ5BZgqIA==
X-Received: by 2002:a17:902:da90:b0:206:9060:c452 with SMTP id d9443c01a7336-2069060c57dmr180473135ad.33.1725638030419;
        Fri, 06 Sep 2024 08:53:50 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae94dcc4sm44569565ad.67.2024.09.06.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:53:49 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan
 <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
In-Reply-To: <CAPDyKFquSHYLGzd288K3JSOF_p+UyRO8GoBP9TGCR_3syGXTDw@mail.gmail.com>
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
 <20240905-lpm-v6-10-constraints-pmdomain-v3-3-e359cbb39654@baylibre.com>
 <CAPDyKFquSHYLGzd288K3JSOF_p+UyRO8GoBP9TGCR_3syGXTDw@mail.gmail.com>
Date: Fri, 06 Sep 2024 08:53:49 -0700
Message-ID: <7hfrqcaicy.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Fri, 6 Sept 2024 at 00:03, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> When a device supports IO daisy-chain wakeups, it uses a dedicated
>> wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
>> wakeup constraints since these can happen even from deep power states,
>> so should not prevent the DM from picking deep power states.
>>
>> Wake IRQs are set with dev_pm_set_wake_irq() or
>> dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
>> driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
>> when the interrupts-extended property is used to describe the
>> dedicated wakeup interrupt.
>>
>> Detect these wake IRQs in the suspend path, and if set, skip sending
>> constraint.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> index 1ab1e46924ab..747a7a33c0a9 100644
>> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> @@ -82,6 +82,13 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>>         int ret;
>>
>>         if (device_may_wakeup(dev)) {
>> +               /*
>> +                * If device can wakeup using IO daisy chain wakeups,
>> +                * we do not want to set a constraint.
>> +                */
>> +               if (dev->power.wakeirq)
>> +                       dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
>
> return; ?
>

Oops, I meant to remove the "false" return when changing from bool to
void, but mistakenly removed the whole line.

d'oh!, good catch.

Thanks.

Kevin

