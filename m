Return-Path: <linux-kernel+bounces-441563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D119ED024
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A641889A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A21D5CF5;
	Wed, 11 Dec 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LudMsiQs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4C1D5CF4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931720; cv=none; b=ggl/uQ43ZsZViOjeRCgdzH3mxvsJJK7WVAn4UHBloXwb8lAnz2VIAmaBh3i7/En4uGl/4SFSRjQvT/Y1txjdiHdFYOyhphvE619qhKJEfxSjGFTwlAyBh5NDk7IKgR4cZNV0LCDBMlbgwWhGzMRJolSfYcDj1KYGnoDm7+iG5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931720; c=relaxed/simple;
	bh=9WXVRx/C0BrKo7ppuXd8NFYWBvQIlT4HwsewDeKEJjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fm0L7/ht21HnYMwnTQALag5i79Q+MhBMw9huCs7lkyq/NrNpE2b408vA8+Pcp72IWVOsSwq+zO/ghSGN/RhDq1ayNzW1TZQDG5jcI/nl8uAx/E5u5ZtIUn0fvIprAZb3aySlkZCn1Waux6mq3b+BV5bW/ngUCUC7W1Nhu0+wHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LudMsiQs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf3e36a76so61472685ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733931716; x=1734536516; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=//mDW/gsbivh5WLVGk2+QEkus5s+/UGSEuoa5vork+c=;
        b=LudMsiQsgXUK4rADU+ylntIbxa9NCQLzKgITqHHgfRW6KR7ETmJrlQ7v+SxvJlZb5r
         qZkp5Qq4uaXN3L+4NxQOICnRRqYhuy6Kbnaj0iXSTSyFdVbdV6o9mB+5afYBx+EHJ9ES
         3aVgnqk0D0VUtrvL57LaD2DQcV3Dx39nr5mEW1maO+xBsMTUXXwa/R7fUBI7d/uQUHIL
         cqKytdJobnEm39yvAy9zLlmv6Jt6lGOEZljpMMGp/jrWEMdkuEuzbAzN1ZxYnXPoRju6
         LyjPylyyxPusouw4EcVCs4pZHWdnz13Wb3z0A+WeFkJ13fLvSc8viD9WO/EyMzUfvGny
         T9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931716; x=1734536516;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//mDW/gsbivh5WLVGk2+QEkus5s+/UGSEuoa5vork+c=;
        b=t///ND/Yv6/M6iJYEp0NZxgbEIAmdLAJu/SE8i9E2sRIEXUILICep5aWMIMZ4dC2wy
         h5nzwTbYbOJWR5mXPBTi7p2QpP0pej+ACgOpUYeI64sZ4uXDpcSk/gPszd6yCoRiKqnw
         gly0IS3sH3wr+WxzSG2WLCZPpQ62cSNalND958u3I39Rz4VphzdD9psK//C5Z7nxCAlK
         xY5XrPFYQk2lhcxKLsxg4Rt+mN8/4CrenjfMYrAb+h7RzdZ/vb1OLP3yCVSwdWL/k5uv
         pVck90doKNANevCfC73vordJ4WgVVf8rSslaiAdPQkA3+C5ztn7kLH2YLLOVP7kgqZbE
         +8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUOPbIOtgQfue0CJzsaTDjlSJAwpAp4pM2huk5MLyO6dvKrb7Tn4Y0mg9suDSFPB8vIeCEKad9nysb6BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCtnrQMSCDHPDHe12m6dCdSrhT4L53vvdPns7cI22LXlcxpPU
	bbxGQmZV1ipmccsBHDmUu/i+WhkMwamVXVNSGYoSZIYv4rsTazH+5aoILr3u2oc=
X-Gm-Gg: ASbGncvgpWpyVWYSxZYAB+Sl61jcDErSPH0thbIj1XajJTvMGYyOZeYThtVXhuGc909
	tC3SJWAQbEMQC+RcEAwo+ZG9EsOJ7FRzVeVqN/IqjIuWAFr4CyRqFdJiYQRdVCW71oyHJBoNBn6
	/fCllQA0PXPNNua105yrkIIaqvULvdm5aTyFxbegghbyNsyjesrjyUYZ4xY46LRENrPomf44gLl
	MKdm3nfsGoaQxqer8aU32X8D11XGxGvNFD+A6gqLyu/BsLl4eis
X-Google-Smtp-Source: AGHT+IGgFiqQwkckid54v7HaXWCbBV/jyXAb4y5c25/cFVUIUVFXXoOTd9qO/0TbDhMvaeZjSbFGWg==
X-Received: by 2002:a17:902:cf0a:b0:215:854c:a71a with SMTP id d9443c01a7336-21778532306mr57358265ad.34.1733931716599;
        Wed, 11 Dec 2024 07:41:56 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e21321asm74338275ad.279.2024.12.11.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:41:56 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis
 <sebin.francis@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] pmdomain: ti_sci: collect and send low-power
 mode constraints
In-Reply-To: <CAPDyKFo9N8M73Z6Ltsbnd-WR-jYAqBedAHndViSD7YaKKYgBsA@mail.gmail.com>
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
 <CAPDyKFo9N8M73Z6Ltsbnd-WR-jYAqBedAHndViSD7YaKKYgBsA@mail.gmail.com>
Date: Wed, 11 Dec 2024 07:41:55 -0800
Message-ID: <7ho71ifcqk.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Fri, 6 Dec 2024 at 23:13, Kevin Hilman <khilman@baylibre.com> wrote:
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
>> Changes in v6:
>> - fix build warning on arm32 when building with W=1 and CONFIG_PM_SLEEP=n
>> - rebase onto v6.13-rc1
>> - fix latency units: convert usecs (PM QoS) to msecs (TI SCI)
>> - all dependencies are now merged in v6.13-rc1
>> - Link to v5: https://lore.kernel.org/r/20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com
>
> v6 applied for next and by amending patch1 to deal with the sorting of
> include files, thanks!

Thank you for the fixuup.

Kevin

