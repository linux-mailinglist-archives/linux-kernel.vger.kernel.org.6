Return-Path: <linux-kernel+bounces-323287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD05973AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA01C24BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46A199231;
	Tue, 10 Sep 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w3RdYqLm"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7C1990B5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980159; cv=none; b=etf3kio4RQF+mxT7cp255OC3yyJ74Ou12rbEtX9QUgOh1N6xMC2tev5XIPRnQVbsP7HIuEVSd7TkhvrLvvTZ6jdqdDvL2F7jur9z+QLLfptmopnCsjWtfSH8ElR0u7j3O3l1+NB+usUxd+h+X4SaHXOm+dlFZSkwid+MzXLNzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980159; c=relaxed/simple;
	bh=LRKHhEG+UPUrru0gQJA2Slcgr3K1BQ2xzSCLu6g82rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsC2g5A1TwfXAxboBYqhBHDsi6Bzq+BSCJ+yjHASjovkRdaRE+HXML+lIvqXQyn4Cy+5vIwVFE25rU87FcL1SiKcPWXZZkGMEUzl4j/YCDM8/IR5G4k7KdW4+tDtkFlV7osIctELFjCz3qSnTv+90G9xpR6FK5nD94sAqtvWf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w3RdYqLm; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cda617e1aso225716839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725980157; x=1726584957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0UcPXNBDPdAI3YKo5hRUr1yzJFMOK3YtStJSZ18Rfc=;
        b=w3RdYqLml4tbdiR27ZqgUGchmFYTY6g7/ck36TEmY6csPLiIQy1wO3zrspbP7/s1t6
         AgMlzLVc3El7VV7PI04ji2roie5VBviP7Aa9nIpJ2xbBM60j9CQ17aMgvmWEYxnnDaeT
         P50awePkrx77nxpo8YRdNLlX3Kcd2qMvcu0ClJ58dS47HCZoX01nvvuQuny4S5tQJ++f
         Bg26Gd4PgdZK8yEn+ahjYBkLc7nhrxVXSAA2EeqKNw/Oqjrh2JFA1XBMM7z6l6LK509R
         JQ0ZyeDXRErSkxqP8dFWv6iWaHaovfVAmgQA3p42Olv54D8DPHyhREfS6EXshPBdU8Yx
         VXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980157; x=1726584957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0UcPXNBDPdAI3YKo5hRUr1yzJFMOK3YtStJSZ18Rfc=;
        b=tseBPmR7Q45M53YQVK9TjtEJjf6jIldg/kSO/Z/oyHrTIWflJ6L463FCqwYjORxmVa
         FiieMpizoLIWPYJLPnCzU+24/TbbtPO4ZA2mL0PKGpTMRE1ktf5oBJqYrNEimpKx/5ad
         BGNSDkGIPqZexe2fZt1d9p/angYTQDe2vKtlxo6uyb/GagAgwX0SI0AUTQ8wrUr5uS1o
         spCGAafipdjseS0ZeP/4nBKW/RMNA70l3/jajjd9Zng2jSYh+Soq8rB0OHtvYCLju3s2
         oTrii9+36efSHEU8NFw3Miut9pA2Tcf/tr3J51s8o+lcGaWakWdz62FpKjz00+LuqPCD
         KVGg==
X-Forwarded-Encrypted: i=1; AJvYcCVFMYIcrPaUXSISP2SFCqkAll4Jy2yRR8KyLOnhD7Xorl9uSrgV2M7gX1XYt9DDfaZYI5p+oQVyNwCErUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjydh6jmcbOW2pPG9RxueifQ+KX65BVwNFa5dE7QhPa1JULmIW
	6QJ+NVtzx96+ikwgBrZpj9E/x5EJcE0KGiANFJ2VbFdL7YRvnZYTQRaXq8oP5ZL2+8RX6zcPKFt
	0
X-Google-Smtp-Source: AGHT+IFwciO5QAOs/QiVqDCZYsdUuwqBkWFwbfoOlmZLRRbNYyabu5+ctk3jZHmS95EKdBS9715lNQ==
X-Received: by 2002:a05:6602:14c9:b0:82d:8a8:b97 with SMTP id ca18e2360f4ac-82d08a84650mr111604239f.10.1725980157605;
        Tue, 10 Sep 2024 07:55:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa733a30asm207850639f.8.2024.09.10.07.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:55:56 -0700 (PDT)
Message-ID: <03b4c259-ab70-4a61-a428-82b0261752b5@kernel.dk>
Date: Tue, 10 Sep 2024 08:55:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/io-wq: limit io poller cpuset to ambient one
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
 <20240910143320.123234-3-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910143320.123234-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 8:33 AM, Felix Moessbauer wrote:
> The io work queue polling threads are userland threads that just never
> exit to the userland. By that, they are also assigned to a cgroup (the
> group of the creating task).
> 
> When creating a new io poller, this poller should inherit the cpu limits
> of the cgroup, as it belongs to the cgroup of the creating task.

Same comment on polling threads and the use of ambient.

-- 
Jens Axboe


