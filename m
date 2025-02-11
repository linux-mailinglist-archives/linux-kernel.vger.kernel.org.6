Return-Path: <linux-kernel+bounces-509915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC93A315FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5514316253E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF889265CC5;
	Tue, 11 Feb 2025 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w5azk8/O"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFD265CB8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303409; cv=none; b=Gc3UjWDiaWcmXOtpXBq270mQuWheFU+O1bwL416agnJWCaQlJp06DN1iloZh8G7YhprzLjV8peA+qFfXXzpkJpb5mFSicO8f6wr7LaZ6Nax+LEQKb5ioBi9QsfieJfa9bjVR1IAxPjExCHSlpu9RfXS837oAzRFofgOCd3USLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303409; c=relaxed/simple;
	bh=4Y+wde6FTequXKMit8DFeMHtsKviytt4h9vl35TgHZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H30UgXyvX8xSCDafih4qYr241VtBluQJ1MhLh/k/wONmX4l2sgPGhJy++de9IQutIRR7vKGTY2yWnBw5Xkk+6Ua5N5qEBOjNlZMfgf6fot03JFEkvoNwVoDGi3Q2PlmeeSfybL6vADeT8aBEa/l3OJ0nUrp2++KZHilFSJy6fI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w5azk8/O; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-854a68f5afcso136562339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 11:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739303404; x=1739908204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsIvwEcUTBMStw2MMLLuDVcTGQeCcLwOBqA9S/j+YXs=;
        b=w5azk8/OdnAJUSh4X1kTEcxqNfwO2/awEbTMqx/uC26WkMs4cGCFHzprnPR1nooAR3
         Py2+1yBpC42SMFRhMEvKugE1QBpBKtr4RUr7qqsxZ5XPgOgGCbDnu55GSeAdDxHQz/a6
         bcai1jxKbMGeKtiYv4hav2Y55fr3L+2HCAc3qeraMKR756Q9fvxd/Cte/z0pTNW92zEi
         edMdg5C86e1HlwwBi7iehJeq7lv705DvyFFaSlqhVGxk34GYfeXyPIEA3AH+X+wSERMo
         yUETMumsq5h3B9NJWE0JQj2M5Sq6IWwYnwL5fjAm1u8Cy9ljmZHMOQ3kojCXn2lQ2S9a
         YBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303404; x=1739908204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsIvwEcUTBMStw2MMLLuDVcTGQeCcLwOBqA9S/j+YXs=;
        b=bJq86DC/wRNSvN+o4q+fzFLemoDDQHJejTzSSOOf5KRtmpF115bFYs/HoAjk57qTtj
         FXqSJbpYCPUTZ1s1RMc2JR/Bqn3sZ4Q9Dv74nGrHyOrFumF42ffEexZktpU131cfZO7r
         2id/IaXXIB1NUtBPLm3MzpQqJL/2kUzQfDI0h9dN5p8xs2hA0D7cJ+frj8G8RaSChwCB
         S/Sb52FtUEWdJfoTrRV297BpCozSKraIT/elNQ3hauLvLqx0diaBO6dgkF5su4p/rF3h
         6pYcy1YXAUxYhlV7mQ3Gq+lEKsz3Vd6fM3mmXO9H9ArFHMi84KOdRqbi1lffJ1HmlgmD
         1o9g==
X-Forwarded-Encrypted: i=1; AJvYcCUWcM6HhtKlAFFiJUMWKymEAaIH0NEWF8K+miN3XLVFiPy0pntgQ9FogOVD6U7JOgyNip6EhWMCoBnvcbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpZHq6DBPpJjVKOV7M0Ea2FxP90AZIH1rGdLKti0/lt4/l1Y8
	4S7aOR5NydPuA4P2xIOIh3XJQctZPaPvzuwJFSrDDgFlAWIeCK+MEtL0Vw1NFVU=
X-Gm-Gg: ASbGncssuMdS6wchGjCcrKi9SsXdV2JZwCfF/NmdbmJWhSG367tgegTpOBgePrzcWk8
	tyONo+53pUkadndzBrwwHK5GBzYN7DuqN++o+yKjeM3xYGynsHNKNS7w6rWMcDyoAftcmxOjeMq
	Ztulv6Rd8HAzwR5keONXQQy0dR/TFnxROq0CmPfxPuEnpgRvc39GmuqedKJxe9lod1r024yrIdC
	NXMJSVLlJqST3NZXeJrDF/QCMhBLHCCnQuK9r/60Z4Wy3WaugNPSedFThMtKyAFpNZATIIasz1t
	qvdpIzE0zhM=
X-Google-Smtp-Source: AGHT+IFrTVAEGiw2EoTh/b9YW5R/KtzW2+Oh2EsbSrKLQH+zV7TjtxzGKsJ/H8T6kpwj7fxcn/baxg==
X-Received: by 2002:a05:6602:14c3:b0:843:e667:f196 with SMTP id ca18e2360f4ac-85555c8c4eemr91680639f.4.1739303404598;
        Tue, 11 Feb 2025 11:50:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed1885b085sm77104173.69.2025.02.11.11.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 11:50:03 -0800 (PST)
Message-ID: <84447986-6cd7-499c-834e-9aa01fad98da@kernel.dk>
Date: Tue, 11 Feb 2025 12:50:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] apple-nvme: defer cache flushes by a specified amount
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin
 <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
 <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 11:25 AM, Alyssa Rosenzweig wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Cache flushes on the M1 nvme are really slow, taking 17-18 msec to
> complete. This can slow down workloads considerably, pure random writes
> end up being bound by the flush latency and hence run at 55-60 IOPS.
> 
> Add a deferred flush work around to provide better performance, at a
> minimal risk. By default, flushes are delayed at most 1 second, but this
> is configurable.
> 
> With this work-around, a pure random write workload runs at ~12K IOPS
> rather than 56 IOPS.

I knew this one would bite in the ass at some point down the line ;-)

I do think the feature is sane, and to my knowledge we haven't had any
issues with it since I originally wrote it 3 years ago. But I also
think it should probably go in the block layer proper, as other
devices might benefit from it.

That said, I'm fine with parking this in the apple nvme driver for
now, as we don't have to deal with multiple namespaces etc. Can
always get migrated to a core feature later, if desired.

-- 
Jens Axboe


