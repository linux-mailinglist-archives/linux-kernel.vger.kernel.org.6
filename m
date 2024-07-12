Return-Path: <linux-kernel+bounces-251163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB39930168
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0341F2310F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7B47F5F;
	Fri, 12 Jul 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AobKsMNM"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D301094E;
	Fri, 12 Jul 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818158; cv=none; b=Na58oSgfC+/T6NkKA4Z5R1D3xI2DcwCqRThWgw4AwSJ55n9BTaClU99JTCWoQKu/MOZ0WXufBAg3eOHLq5XHy9JUW2nh8kzJW4sMKJwlPydsFGt3nD41Q9s0VQobyGDzMECOw9RaXJHH4bv6zL0bkA6q/RyhayxQgv86XP1R4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818158; c=relaxed/simple;
	bh=E3bqKQF9NupUdY1X3LoVgtwzmS81Qs1cr0Zy0zomHQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivgdivB/wSFsLfnkuvoCM/gt3ArCkDT2B/QiLJIEG2ESXd9INZg/36dQ6uncB8wiWwzCurmeW1Nfwcrwy7XfgUkvYyRz6MCWyjLOXxqv/eG6q5+XXHC3B2KV4I9mD7Fy5QZBODpaCU529GAHqnm8xtjSPlT9KSNbi/WBRmGscQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AobKsMNM; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso1086645eaf.0;
        Fri, 12 Jul 2024 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720818156; x=1721422956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kkkiGO/kyluSOIqlCphcpAU2FE2uhCL82aBXiEAD0A=;
        b=AobKsMNMv9zMTsH9Rf36U5Z+l3qD22PgeUX9D78xILhwNC99de2atQsslZtr/92tJ8
         oZtASE94nePv6/Hfaasba8p/xV3a1aGjbNmOsB4GzZWvWJm2s5nc/FRNGSJ5obooWoga
         g/BaqWW1rWqyG6k3y+iDi/JSnz9itAB7n1flwe1H9vUKdja6dttoCiUpHmymNPE0nv+N
         gjbsEtWyP++3s+r83PlovHpnYAlcVb9kJ9EjX8xRM06jb4rpRL0UhdUTo+uJLmN/m0Y9
         6jFBoPyWOa+kYwt+EYQxXt2tkwB8vqnu5x05S+dkaJINKvUxQgDD6LldGY9ZmaCBhLUw
         eA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720818156; x=1721422956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kkkiGO/kyluSOIqlCphcpAU2FE2uhCL82aBXiEAD0A=;
        b=YWcQLZeQZILE3yF62l5zx0VVvU2qBITMFuHfuzYx86ccOlUoUfpGdfg7ShZVoXodl3
         g/GevG/V870zP0Z3+6VC7ED5T70oZM4s+myCnyfDkg9kdGFecR1xUwyLMXjYganngN4w
         N7S1K7I44S0hKDDHfiwAvim0JKzaj4dvmy4W4RR4GU4Tutfxuk3RYO2AMlgjIn950GyG
         rAQiyFJQGYi9uu22SvKyiEbQGdYWHxBhHp//U8sEYfrv5eK2puaii4pU4gIVqCMkImqV
         rKROS6lNnFRE+lb1deHRGIfJdpmzNMY3CWuDe9Lwahbk2wQ7birqyoCtXWI/bonOFcSe
         5roQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnfbosaKS27DXmDzGDSY4gGizx5B+fvVe8GwYEUpt7z8dWRe4Jr5b7rBWWQLMFnnr4L3hzG3tNuMJsWX/ENUbJhVvdkr3Punnu9fn5Hbj2DLPFI3/uUF4gdPyAOgR1v1NRylE4/sk=
X-Gm-Message-State: AOJu0Ywq2G2EH78X2QtP1+fG5nWWPRspmqNo5m41BauqTJdiJB9Dm2JV
	oSaawUsZ9AgmIUa2ngIimREzlKaTPDte/60sI3mdsu+IStETAN1I
X-Google-Smtp-Source: AGHT+IE4ALT8roZ1t3XhXtyuD1j5gAIM1uqK7lT52poiDEEjqMhEKkUuMoBMs45Re6mEzDggCZ1AaQ==
X-Received: by 2002:a05:6359:740f:b0:1a5:7844:2068 with SMTP id e5c5f4694b2df-1aade0db912mr990636155d.5.1720818155728;
        Fri, 12 Jul 2024 14:02:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d621c6300sm6304368a12.51.2024.07.12.14.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 14:02:35 -0700 (PDT)
Message-ID: <0dd4e916-6f7f-4427-a217-5b7a290b1b3f@gmail.com>
Date: Fri, 12 Jul 2024 14:02:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Make SCMI transport as standalone drivers
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com,
 ptosi@google.com, dan.carpenter@linaro.org, souvik.chakravarty@arm.com
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710173153.4060457-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 10:31, Cristian Marussi wrote:
> Hi all,
> 
> Till now the SCMI transport layer was being built embedded into in the core
> SCMI stack.
> 
> Some of these transports, despite being currently part of the main SCMI
> module, are indeed also registered with different subsystems like optee or
> virtio, and actively probed also by those: this led to a few awkward and
> convoluted tricks to properly handle such interactions at boot time in the
> SCMI stack.
> 
> Moreover some partner expressed the desire to be able to fully modularize
> the transports components.
> 
> This series aim to make all such transports as standalone drivers that can
> be optionally loaded as modules.
> 
> In order to do this, at first some new mechanism is introduced to support
> this new capability while maintaining, in parallel, the old legacy embedded
> transports; then each transport, one by one, is transitioned to be a
> standalone driver and finally the old legacy support for embedded transport
> is removed.
> 
> Patch [1/8] is a mostly unrelated (but much needed) clean-up from Peng,
> which I included in this series to avoid conflicts at merge.
> 
> Patch [2/8] simply collects the existing datagram manipulation helpers in a
> pair of function pointers structures, in preparation for later reworks.
> 
> Patch [3/8] adds the bulk of the new logic to the core SCMI stack and then
> each existing transport is transitioned to be a standalone driver in
> patches 4,5,6,7 while shuffling around the compatibles. (no DT change is
> needed of curse for backward compatibility)
> While doing this I kept the module authorship in line with the main
> author(S) as spitted out by git-blame.
> 
> Finally patch [8/8] removes all the legacy dead code from the core SCMI
> stack.
> 
> No new symbol EXPORT has been added.
> 
> The new transport drivers have been tested, as built-in and LKM, as
> follows:
> 
> - mailbox on JUNO
> - virtio on emulation
> - optee on QEMU/optee using Linaro setup
> 
> Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
> testing commands, replies, delayed responses and notification.
> 
> Multiple virtual SCMI instances support has been tested too.
> 
> SMC has NOT been tested/exercised at run-time, only compile-tested.
> (due to lack of hardware)
> 
> Note that in this new setup, all the probe deferral and retries between the
> SCMI core stack and the transports has been removed, since no more needed.
> 
> Moreover the new drivers have been tested also with a fully modularized
> SCMI stack, i.e.:
> 
>    scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor modules ]
> 
> ToBeDone:
>   - completely remove any dependency at build time at the Kconfig level between
>     the SCMI core and the transport drivers: so that the transports will be
>     dependent only on the related subsystems (optee/virtio/mailbox/smc)
>     (easy to be done but maybe it is not worth...)
>   - integrate per-platform transport configuration capabilities
>     (max_rx_timeout_ms & friends..)
> 
> Based on sudeep/for-next/scmi/updates.
> 
> Any feedback, and especially testing (:D) is welcome.

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


