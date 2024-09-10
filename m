Return-Path: <linux-kernel+bounces-323285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75130973AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9BF28907E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293119994E;
	Tue, 10 Sep 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oiQvIM3r"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BB199929
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980140; cv=none; b=ABz8bIQufjiJKcMxtL5BrexWyPYj/1L+p2hf/tOJLq5I1I+720oIfXmnk/O8FM+xIGaPUz0g+068yN4ETpUbN6JyzjNh6NV1SM2OaSkl6fGD9/PQmHO62en75fUKp7ONCBaE2pKdmy+Q16YqasVmnWl8q2gu/lFQ2YYLViIhsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980140; c=relaxed/simple;
	bh=h//wHtXRgtsnucxDoTRJMW20a6wxlz5iZ7J2mRsmAjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv/IVvTQvD0JrD/XchO50o4KebJob+pxAtqIN9IyIxykvE1z09/+dV2jIDs/R18ST9CLmJ2d8K4DfV6H9Wq5QXXw3wkr3xeH7YlttygjG8DVHGBVeoMzvZtyhdniieCqL3aIpEG90JJQnq3yeI54huXvLrLyRU5hsbmlFGZ+zN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oiQvIM3r; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d3872e542so23482325ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725980138; x=1726584938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Jv69Funzr32cFzMw3DAAVgqxxwV4rEJRwpwk5aDHb8=;
        b=oiQvIM3rfvlGbJ/2JJFPkbukDiasOrWpy2TtLv5AsvGDVsxM0ihZ0O4jY4fHlQvSVu
         l7IgMluN0dhVg1N6j0vhWj2W7KJXYoiMpDlfgN3hBKz6QAy7QP3HVCyghUbxkmm3ojoj
         iU2QYImfmnL2zNjvRjT7nQpG/cYNSTOzlFc0cljD6jaM8sC4UWfQUsmabR4XfOx03owo
         i/QZTaoriv9QAyxBL3Lbg32ouy+pzorv3AD5aIcFCFQJBG4fhV5dvkP/u6rRp5V91/H9
         I0UULUoV7JJ+eaBYIwn5PN/dAihI69w5PphbIY/pVM0bvqrAH/IcdGCWaTOgGuBnMIXO
         8A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980138; x=1726584938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jv69Funzr32cFzMw3DAAVgqxxwV4rEJRwpwk5aDHb8=;
        b=SfionAIBry3aQ3uZpMgHhcxeFeBta5n2abbWy09ykCZuDRxyxsNlCtA70VdXlNg2AO
         rS69scOQKNII7ER3MeTIOKF7BPMDCVeid0BJfmbvyu/vONur3yiu3bqOOtll7d+151gy
         vLyTBQ5JInjC/myFAqtsWd6fHa9wmZmAE54xmwJG1G5HBVGeRCSae8mBM1DIogqdmqhM
         WIAOl86E1Xs9R7reK3l4jSdzlR0Fbo0rYlitNaa2TrHx+0hwtI8MvRmYtiYUWWO3hbZV
         0U2slMO4RqbeZMltNgpSQxSDT0Y8RKHh/abiueaST05m029VXRMisSsdeTX8QNkvvsSs
         wTrw==
X-Forwarded-Encrypted: i=1; AJvYcCWeEV/8ulxrdLIkg7GE8JZi3AyjOxhyHalJRVvcK0xZLaGuud/7If4nvc05JIuHsag85Va47lAGsTy5uQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHId8HjfZ7JW1hb2594c99BsqBP0+YOWLtk3xf7X1fMCNtWbF
	XIH/NZC2fVTY2cPJ0t6G0T32m+5WV4dpt20BQSKDfb+3i9c87AkNo77zQ+bpFms=
X-Google-Smtp-Source: AGHT+IF78iPjvZ2auF59LluRUlSBusRRQ9F/bB7+yzwd4gEwpZtiPuztOVVZuatoClcso9ip5RWRyA==
X-Received: by 2002:a05:6e02:1d82:b0:3a0:45d2:3e81 with SMTP id e9e14a558f8ab-3a04f0670e9mr183027975ab.4.1725980137675;
        Tue, 10 Sep 2024 07:55:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0590161cfsm20423015ab.77.2024.09.10.07.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:55:37 -0700 (PDT)
Message-ID: <a0480aa7-4be5-49c5-a20a-3bdf936d29d4@kernel.dk>
Date: Tue, 10 Sep 2024 08:55:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] io_uring/io-wq: do not allow pinning outside of
 cpuset
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
 <20240910143320.123234-2-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910143320.123234-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 8:33 AM, Felix Moessbauer wrote:
> The io work queue polling threads are userland threads that just never
> exit to the userland. By that, they are also assigned to a cgroup (the
> group of the creating task).

They are not polling threads, they are just worker threads.

> When changing the affinity of the io_wq thread via syscall, we must only
> allow cpumasks within the ambient limits. These are defined by the cpuset
> controller of the cgroup (if enabled).

ambient limits? Not quite sure that's the correct term to use here.

Outside of commit message oddities, change looks good.

-- 
Jens Axboe

