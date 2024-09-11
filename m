Return-Path: <linux-kernel+bounces-325357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE397586B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7251C23351
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE721AED24;
	Wed, 11 Sep 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w/27mDo8"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51501AED29
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072099; cv=none; b=PU9cy9+T9rlqSxqV7w5ax84jpJ6A1XGI2kKbjwSs9C5+wxxUS2p1AHp9Thp+9I9UbPZ0yzdjnLHiPlqgTKlCKkB32Qz4HoIkn9b1gYedRTp7Nct0dPbiJA38gHcklQbIDetFdgbExBnpaWDU0QSpNbdQqx97+Peg+ZETF/cQXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072099; c=relaxed/simple;
	bh=tzTpPj6JB+OGJA5fajUvUDBqkigFVyaXVi86a5AhPe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZQiyfD2HVh43s1FcNwpUaTHRpwdPdABB7zvY9Sy1aCK72WrTtpPD2Sy7PTblIgEUSFDmWzz/26t1dl5xCcKwBsrdKvN0SQmxTM7PAmFKOcEFNwr8L8jtYgh60RmUz93hP/pJZnJuci2/5hai+mk7Qv+pFDqh9pkqBApxzo8iAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w/27mDo8; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82ceab75c27so185097739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726072097; x=1726676897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=var502O8AdEcPofnm3n0MJMBP1NCf8qy9e9DtiMVmWk=;
        b=w/27mDo8Tjyr7ktZ/rxJSgyRxb7SH4BZvtnkXmFXPJDmLowh2LTb2NvySGSVjIa4mE
         aOzyDFZtPY2MM1mfUUkV+q3Pshr7bwyQCs0g3yMjl2aYjdI3UHwpKNghR/jFGxasMlm8
         fsZNcZaHe24gCTWYuEf4Xt8TsgVACtxT8xdKd6O8HL/0gC07R5DWBPOGQJLQBJ1q0877
         0OvU9sw5JuMpbthCB1B9nE25yrKNBQtF8fFFstO5uMku2eIgLUHNFc8dEQ4d3Ic86aSh
         zyB47aIRFanV+2+Wja2MOdAgybpjlKC7QdFAL8asYDpqI2X2JDv+bTInmKZPrU1W4XT2
         5M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726072097; x=1726676897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=var502O8AdEcPofnm3n0MJMBP1NCf8qy9e9DtiMVmWk=;
        b=rcqxJrDc7mAeG1g4jg7Lov4sw6BUy9Zss95YdINekiBQ26C/ND7HUHu+Ad/IoPYoQH
         Vv/hYwyhLXQMjnvGtv38yg6WfZzXT5qaMNkGcNDXlQDsi0N6/vFM+xCT/ePuJwOUNUx5
         FwotE+jHEs+JnhLNf6uHFEyEnczJfjfLywdWBfW0nJ196P7D+czu7uGgadfHs2qisNxC
         93DuPCH29tVH6kbDms+2x96YSAorwr54cPUp/A2lNIJ6WPWxAbmmSbl0Qs0pm0iFphx7
         4LzGm4VWAZdy6qPmkblv6Zq4YHSHkLFSURiRcN61IzSAv4tedI8ZIqR5ERVktfGaumBU
         El9A==
X-Forwarded-Encrypted: i=1; AJvYcCUnkxeVdw2ULRboJ7e//7ftNDmpmw5K9g93M3UfLpmFEqssuo0TWVfx0z3eW8pi3v9NTmpp7LVTxgYVFLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0LMYiw/BtnB1v0QMuxPxUOqb7hiogWvzjXsfC9C9LOHVRMCE
	VIcBsnNeIa+Zd9MmiNOndQ5N4cTaxC8xePBbRDjJKiZANbHw9wrC7KTM26zOqyU=
X-Google-Smtp-Source: AGHT+IEOAHWAK6/GldVHC+a73yGd6kwIS+31Iy8D7c2tKpxIayyx3VhAXsleXj/4G1VFA/tiJKjY6w==
X-Received: by 2002:a05:6602:2b11:b0:82a:971d:b4a0 with SMTP id ca18e2360f4ac-82d1f978fd6mr21465139f.13.1726072095997;
        Wed, 11 Sep 2024 09:28:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa77b292bsm276246139f.47.2024.09.11.09.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:28:15 -0700 (PDT)
Message-ID: <2a424df7-8114-477e-ab5c-484d2ed8d9a4@kernel.dk>
Date: Wed, 11 Sep 2024 10:28:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0/2] io_uring/io-wq: respect cgroup cpusets
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: stable@vger.kernel.org, asml.silence@gmail.com,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 cgroups@vger.kernel.org, dqminh@cloudflare.com, longman@redhat.com,
 adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com
References: <20240911162316.516725-1-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240911162316.516725-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/24 10:23 AM, Felix Moessbauer wrote:
> Hi,
> 
> as discussed in [1], this is a manual backport of the remaining two
> patches to let the io worker threads respect the affinites defined by
> the cgroup of the process.
> 
> In 6.1 one worker is created per NUMA node, while in da64d6db3bd3
> ("io_uring: One wqe per wq") this is changed to only have a single worker.
> As this patch is pretty invasive, Jens and me agreed to not backport it.
> 
> Instead we now limit the workers cpuset to the cpus that are in the
> intersection between what the cgroup allows and what the NUMA node has.
> This leaves the question what to do in case the intersection is empty:
> To be backwarts compatible, we allow this case, but restrict the cpumask
> of the poller to the cpuset defined by the cgroup. We further believe
> this is a reasonable decision, as da64d6db3bd3 drops the NUMA awareness
> anyways.
> 
> [1] https://lore.kernel.org/lkml/ec01745a-b102-4f6e-abc9-abd636d36319@kernel.dk

The upstream patches are staged for 6.12 and marked for a backport, so
they should go upstream next week. Once they are upstream, I'll make
sure to check in on these on the stable front.

-- 
Jens Axboe

