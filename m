Return-Path: <linux-kernel+bounces-442006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB809ED6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3BD165FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7571DE3C0;
	Wed, 11 Dec 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="JS9BChA6"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352E1C4A0E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946400; cv=none; b=AiO388SO/O/Wr0b05M2HJLeoyy+tPI93rRmYEY660ipZx3pa9I4bWfvuxbhuoNmClYzNlX5N0HgkJwD9lcHdW+Rjztm2+N0d0ih7qQ47GekCEy9WUE1VKelSzGij0oApKiLX2YMAf/pqkNOA/YYtXDAowamAi5ATkKnLByKpBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946400; c=relaxed/simple;
	bh=eQUvQmYviyvZsCQXnQAF3Bb7U4tghcJBDEIK2cr6SyM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=E5ZWZdbZ6i3h5XdqNrMmOtyAsrpnRzVnBzAAWRgmwdCfrcpOcAE5O/aBMmkvUijrh+SBkzpUPiebubvULdRPZBYONNJJTo2c7NriFP8MJ5HsvUZ+6pjBDMLK8shztNOMjt1eoxAh4yw+v5GMhLrSqflwsOQnmMBJthwSG0apNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=JS9BChA6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso111758a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1733946398; x=1734551198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTiBfu3LCijHwOIB1klB+vWcYLMQe6opMPGWa86HSek=;
        b=JS9BChA6VNS5aUv4bi2L8d3+4R9y9soAyuFSDd8mFqOZ8vv7jF6K7OqDP2P7xEI2sx
         cH8Nil8D6KEihsxkjkFfgN9rogL6NWCkBl/dDuhsha6WoyVUwqdeiPLJn+qEM5N3xpFE
         DF37Pve5+FlnowBs7KCjm9fJ8E7JlqRxfGaYWIarIBjr/MALcLOqfSLeCxRblgH2JN/x
         9j4ynkk4tpIua4/+D20HvwV3OBt2tusPlabKum85GLf85KmE0bQMgQgUeDkdX91WiWHH
         UX1QHMHkOgIxAKbEXldQYqcWUl+5fN0m1XwLJ25YNQLTWkISlrS4rj89IhLUY2qIlJ5J
         3E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733946398; x=1734551198;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTiBfu3LCijHwOIB1klB+vWcYLMQe6opMPGWa86HSek=;
        b=qUBSnLbbh3EzmlhEvLMOB+Oj5sIJC6yY8fKMa4lDIwEZLmPqmIJmFwy+9Rmf9EEP8s
         uyTZkgVpMxmImoSOAaAgUWvGqGDUiOu290EnagoKvsJI3gaf1qzAvR+qxjpdOeSWNxtr
         ny72OnKxtvHphYfukz1J6OM72MVPSYyLhW1kJcAI0Jo4HIu7UBblgW6qpzoRdvCY3YLU
         o5w9NYpqhdmdBILDD5tuYYq7ZyEiwkY0JdRXiIgmSBHECRyXR6U10VGoi+UE2PKOy2Uh
         L4zp/5hhAkzH0+7vCAKFK01GuZkhx0OFXIW+fmeB3Ed7gZ4WP9yP2RsPyOLEDbHpHt9y
         Nl1A==
X-Forwarded-Encrypted: i=1; AJvYcCWWajtnkisD9NzgSqjJOpCU9nTMg91QQ4AK73KRzP5S2YWqJVDN91T6j0taY1lIR7Cfe79dZznKwTbNXSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMaNl4cVjRK5c1S5ybWtejNXMUhz4lY5jQk4TwTb86DlzVIC5
	nlbCbwia2JRXAbR3zUykBOBLvVXlRiXzMLS4cTiVvzBw3HnFlorHmhR1UrRZia0=
X-Gm-Gg: ASbGnctwiubIj4hsbsnxcLbV7LlijBA7v6Q4Jdk/zbGFIZcfa2bDXnttzq3Y60Wk+Ub
	CS+ytDPwK+AuDA1SetloLBLw9mul6xbIjjBD2jVsawCfU9wEHpWwd2qijHxFlFb7xpK8R2CswCM
	XXEgK617Tr7+9Yo3JD/7DQT0UO3cKbrDg25GJfwYltMuEKWWmJRrZBnXy/XGPazRj3y+3IEjjTB
	eJcrEkR+Fdr1/6Lr0CuPVaY+Dmbon7bsCpMSU9qqVjSkzo=
X-Google-Smtp-Source: AGHT+IFnTOMb6O5sg4/hZzOJTSZlpikmzRhprbval79dvoemRTgwDyiy/kr+8d0qfhl4JQpSLR1kZg==
X-Received: by 2002:a17:90b:3c02:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-2f13abee2a2mr834848a91.9.1733946397459;
        Wed, 11 Dec 2024 11:46:37 -0800 (PST)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f7eaedsm11923684a91.2.2024.12.11.11.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:46:36 -0800 (PST)
Date: Wed, 11 Dec 2024 11:46:36 -0800 (PST)
X-Google-Original-Date: Wed, 11 Dec 2024 11:46:35 PST (-0800)
Subject:     Re: [PATCH 2/2] drivers/perf: riscv: Do not allow invalid raw event config
In-Reply-To: <20241209-pmu_event_fixes-v1-2-d9525e90072c@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, atishp@atishpatra.org,
  anup@brainfault.org, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
  mchitale@ventanamicro.com, samuel.holland@sifive.com, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-1c6ec679-02bc-4aa3-9b23-bb4c5f5f9b81@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 09 Dec 2024 16:04:46 PST (-0800), Atish Patra wrote:
> The SBI specification allows only lower 48bits of hpmeventX to be
> configured via SBI PMU. Currently, the driver masks of the higher
> bits but doesn't return an error. This will lead to an additional
> SBI call for config matching which should return for an invalid
> event error in most of the cases.
>
> However, if a platform(i.e Rocket and sifive cores) implements a
> bitmap of all bits in the event encoding this will lead to an
> incorrect event being programmed leading to user confusion.
>
> Report the error to the user if higher bits are set during the
> event mapping itself to avoid the confusion and save an additional
> SBI call.
>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 3473ba02abf3..fb6eda90f771 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -507,7 +507,7 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>  {
>  	u32 type = event->attr.type;
>  	u64 config = event->attr.config;
> -	int ret;
> +	int ret = -ENOENT;
>
>  	/*
>  	 * Ensure we are finished checking standard hardware events for
> @@ -536,8 +536,11 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>
>  		switch (config >> 62) {
>  		case 0:
> -			ret = RISCV_PMU_RAW_EVENT_IDX;
> -			*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
> +			/* Return error any bits [48-63] is set  as it is not allowed by the spec */
> +			if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
> +				*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
> +				ret = RISCV_PMU_RAW_EVENT_IDX;
> +			}
>  			break;
>  		case 2:
>  			ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);
> @@ -554,7 +557,6 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>  		}
>  		break;
>  	default:
> -		ret = -ENOENT;
>  		break;
>  	}

This doesn't have a Fixes, is it 

    Fixes: f0c9363db2dd ("perf/riscv-sbi: Add platform specific firmware event handling")

?

