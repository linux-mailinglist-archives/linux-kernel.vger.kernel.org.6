Return-Path: <linux-kernel+bounces-221544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90AC90F531
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C671C21815
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F031156255;
	Wed, 19 Jun 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h3tsHZXm"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220055884
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818469; cv=none; b=dGrBwca4pzBrkw76yROOVPJzPLZ1txpxQtQun7CKyzk2SP5OmhvofnVXwdipurFWwM9EnzuqFIX3iSeugVRfh5Zzxvf+z+yLshkHR+YIATYhSMhcMSIMsN6BPAYaLJ0DSNcQ6OmHVhZUxjDNVdYyFhZ47pRzKQHasdpcDHI/fCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818469; c=relaxed/simple;
	bh=gH3oGfMqS4kzu7B67Mvqr/4UBQoAPWhsBQ6/w+YZYcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+i7ocQRRSP/3ueirRjeYskBo6N9ncMX1vlvNWjpYSuJ9fyqQyJmBEMxreeO8/yXm8mcCPCGEi4BJDlCH++S/Hwf7neDhmHXQ8tt0m6utITEJRwXRe7KozF2TPm7JwhjGY8DYhx0RpgwzoiAGOoGcSVVDvl0QhDwAti6iQ4bwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h3tsHZXm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-64ecc2f111dso2909a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718818465; x=1719423265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZ4zwIDnnKIalzS0ZDDoJ0VyYnGS2z3S1zxJBVJg9NA=;
        b=h3tsHZXmh7uB/oDJUcz1vk0MNrMm8WL3vRQzF4m678YyCE1vyqTCHjW3xkcCyGBnOn
         5BMq3rjrkr7zIYfScvAdsamcghu3adci5IoB1Ai7tjsZkkJ7syOwW6heB3AKcVLM7H3T
         ELSS1d7PB1Z3LlY9qIsDtZKL7adLo4Wpc2tkttskJwUcD+jgsAc39ULo+AKhGkS5mmWs
         NGuoTFOtkJpoRe/8HoHS6b9Zx6L/TOvbnk3a/a1ANkfN9UmN7wiG+bF74ICDPx4G8tVg
         fJfBtTer0LrrFcycEO5d8cBpIWCSeNtUZdIvLonBzAIZK92Fv8ovjjeGPul+joX1qTNw
         BJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718818465; x=1719423265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ4zwIDnnKIalzS0ZDDoJ0VyYnGS2z3S1zxJBVJg9NA=;
        b=VLXvYpdUeDXV7hezszpWOZy95A7A8UZyYCH2MNcHrB2F+nALJmravrMa/M8buWB+ar
         ofRQoOki6TfkIsB5s/r00bF8C+4mtKSOotI/a6bA5k2A45IObv5VfeQ5GMlourM2akg3
         WaXR/ZcWl6B/d3Yzz6+9q1LnfdkPzUFQJYXMUGisudgNbyfIUMDu7ww7N0gXTa5vCNh8
         CQKxzbVRgAnUvkNeb4Uf0BM7Q1xW7RqEp6LISxoR3vmrcDCtThPoAhYIuDBQjjJBrOWD
         iETkBMFb7kWh91DyI8eK1+kh5DNLobXM4q5T5ncfBVOzOD7gdb4CvJvZcNhAxwKOLVAi
         VCXA==
X-Forwarded-Encrypted: i=1; AJvYcCUwA1Kw+MDFvz2gAbYbC4m0kyURuqlCurQL7180DBou9gyGq3YAQlroSJJZwjHScD1XcSJ9CD4w4q2W6lffeM+MxX9lR33MBNpW5ICT
X-Gm-Message-State: AOJu0YwdCaL3n6AOydhjRbc3BLBIR4rpMAqZo7ciVsOaBgBfW+tDgKsb
	/aE8x0Y7GFGuSy5RSbBkOXDQE3Xvt1IoZuvdrAJMgCpMfLPy6ZIPLS284BEu+RoYP7fzOSP7pzt
	/
X-Google-Smtp-Source: AGHT+IE5pBl2myAzW23kPeuMrQgGPYpwRUhThsgUATrzEh52SnuolheqaKQqp15bUsCeHOnsZg2dZA==
X-Received: by 2002:a17:902:ea07:b0:1f7:2046:a8ae with SMTP id d9443c01a7336-1f9aa263810mr33560165ad.0.1718818465295;
        Wed, 19 Jun 2024 10:34:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b17f9bcasm17222755ad.161.2024.06.19.10.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 10:34:24 -0700 (PDT)
Message-ID: <51f64ee9-35fb-482e-aa50-e2a446dcd972@kernel.dk>
Date: Wed, 19 Jun 2024 11:34:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240619150814.BRAvaziM@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240619150814.BRAvaziM@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 9:08 AM, Sebastian Andrzej Siewior wrote:
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
> lock on PREEMPT_RT and it can not be acquired in this context. In this locked
> section, zs_free() acquires a zs_pool::lock, and there is access to
> zram::wb_limit_lock.
> 
> Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
> the lock has been acquired/ dropped.

The conditional code depending on CONFIG_PREEMPT_RT is nasty. Why not
just get rid of that and use the CONFIG_PREEMPT_RT variants for
everything? They are either good enough to work well in general, or it
should be redone such that it is.

-- 
Jens Axboe


