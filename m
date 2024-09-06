Return-Path: <linux-kernel+bounces-318976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8A96F5FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050CE2840B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587AD1D0488;
	Fri,  6 Sep 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qSQm27Ke"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4D1CF2A4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630911; cv=none; b=MK3nelpdpJsUH/kcPtjegysdK0KGO6WI7zziEuyEkM8marCZTqrmV09NeKUOHxHue8Wtgb/wqxRFjja/TCG3c5+vfwGCfs+zOkCneb3XqEIqRmajCnxuizhNrEoq5srrBWr642Z45afLfKavjPtBXtnQ0Ewq9SVnIVMGRDpKt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630911; c=relaxed/simple;
	bh=ysqgFOzc7u5mYuScsJMJK2Tx6mINqCIwwJvlm2atdQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgI0syDs+IZTqNfJwEMLPKxlFy4g2u+dAkACzdDXqO6YO7cCeevOaitJc7Cze/8nGU51WvQSlUnOmKdOR+L8dFa0omsP2kEx6F2pPMFkxZKrHleMVp1e7mf8Rz/7kq2aG+XR+JT3P1OekfQL31h/aJ2uNH0KRFGwzoeIWtfYM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qSQm27Ke; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20570b42f24so26409735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725630910; x=1726235710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjkR+6prfjNtw0/YurYKkirWzdqG2Tn0k31bMIkNV7U=;
        b=qSQm27KejjkcivzZFNs8iKSFqgxyoINepXivj/CM4nYtHNBftRGmLBo/O4iuK+3viK
         i4mmXzpNDZzb1ncvyynZrlEfCZ8MzLwtUCYPSGgmwgyqnccyY06llUZEApnuXDoCwBo5
         bpai/bn2nJ1R6S6rwGuyzXIvMP7bcu5YoaLik35ZUQt8c3eoxX2WkMGHOhAg5ZTUEhSJ
         iZ5/xYV2LrAI9QqdRLxLqKlr32p0qEr+PezDzrZ1eqZ6pUgC6v7ssyQoodfsJnWn8Jpz
         T+3wbzYxwsJJoeZ0xY/6QE/8YF1o+hcpnBncziYC/hT/iiqGrkTx3nId93ewLEuE35Ii
         lftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630910; x=1726235710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjkR+6prfjNtw0/YurYKkirWzdqG2Tn0k31bMIkNV7U=;
        b=QMovzTWhVVW6Jks7azLZlTZvfAwS3nICY9T4FcPszpyU1zBUZHLzOCO/LDSsnvKFa+
         Xp2aMKIhheaWriZ3AoeokCD5hzd/mTo5EeLBMNQcKy/q5hk91NhC5yM7+7s/EZkNtsEw
         A2chPifEdx+BC4+w/zZh/kqkn2SSctQz2H27kXyOwl5EOP8G6gmljHkWBM7GFrNlbzcT
         2WhxsYNfcGjkQjjbbWIkAh9Ij5FKl9EmsrJbvJCUI5qcbNb6wz7x/3RVOhqOnvkcAblS
         a7ld9vHSiBIX7CUcv54fFdJd7UmrAmsMUlMvb1e9lFVAnyncCyGDrO2hU0o/A02U81U4
         /+eA==
X-Forwarded-Encrypted: i=1; AJvYcCXr31suFpWXKcP7qCp98iXbfPJpjYrXH9B++pGtiQp+nWfEGvXjleOXSNW8ZMvVt7mwUJNpHT6JMZ1nxAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgYmYu8Iqtf1dxKkNc/ychfGg7/MaIElu9R7XP+u5LSR3IneO
	LdyCDNCPO2x6LQhjBfZP1RDBH02Vd6i8ZQLd/XIG3srXBBYLDqjK9MtIN+vSwXQ=
X-Google-Smtp-Source: AGHT+IEGUg8ytNJsx1K39rURRTAcikF4e9KdoySsDDIzEfjArGrWGKO6PciB23bCCREALgq5YelY5g==
X-Received: by 2002:a17:902:ced2:b0:1fc:6cf5:df4b with SMTP id d9443c01a7336-206f0622e7dmr33102945ad.49.1725630909736;
        Fri, 06 Sep 2024 06:55:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae94dcf3sm43580005ad.80.2024.09.06.06.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:55:09 -0700 (PDT)
Message-ID: <10937dc5-ef82-4228-8724-c5a36f66985c@kernel.dk>
Date: Fri, 6 Sep 2024 07:55:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/sqpoll: inherit cpumask of creating process
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "longman@redhat.com" <longman@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>,
 "dqminh@cloudflare.com" <dqminh@cloudflare.com>
References: <20240906134433.433083-1-felix.moessbauer@siemens.com>
 <8633f306-f5e0-42f8-a4c6-f6f34b85844d@kernel.dk>
 <236f0c6d019e8c25301f3db0a5c9d4971a094eb9.camel@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <236f0c6d019e8c25301f3db0a5c9d4971a094eb9.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 7:52 AM, MOESSBAUER, Felix wrote:
> On Fri, 2024-09-06 at 07:47 -0600, Jens Axboe wrote:
>> On 9/6/24 7:44 AM, Felix Moessbauer wrote:
>>> The submit queue polling threads are "kernel" threads that are
>>> started
>>
>> It's not a kernel thread, it's a normal userland thread that just
>> never
>> exits to userspace.
> 
> One more reason to behave like a userland thread. I used the term
> "kernel" thread as it was used in commit a5fc1441af as well, referring
> to the same thing.
> 
> Shall I update the commit message?

Not needed, I just amended it while committing.

-- 
Jens Axboe


