Return-Path: <linux-kernel+bounces-529717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3266A42A38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD90188A2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A59C264A97;
	Mon, 24 Feb 2025 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SGsrQj7X"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647782566C5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419093; cv=none; b=qJePxW+HEdvw8ZedxlvRtNvxBgltoqgcBtnxHTWuB/ujlaa8ME50X4a8ixnDS7JK4YlK3cTn5j1mAgRCW79w4jH8+AKmFdoXh+4LN3E9Dj8407BCVzRYoPfpn0euy23WQg+Mk4lhjhmLlXK0s+LTMJce3KTTwC8ctBOc80bOnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419093; c=relaxed/simple;
	bh=/wIuXP1CwOfD5FKUIOHFwNbyVgr6IBA4qqUVwMvdhEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGwP4lkVmwuX0gg4/Z1k+6jmWUQRQ1RoXzlGtVuu6yvHeIOLOCC5dG/l4vU3YbUODTKTnVxPRJVieFaxiclB0GWGofFtSQs3GvO8bec4dm/lIsp2CLsBIeB/zE6jBlP7WoAePtqN1V2RWr7J9TI/uEqBsma+e73onsZeX2zdQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SGsrQj7X; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so14778775ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740419090; x=1741023890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFYgpHAo4G8yagE/n80s92o1BJfsNSB20MjCQ27CjnU=;
        b=SGsrQj7XN90Kcg16d/zhZyN9z+XezJ0kMumfqz314TbLxJg4yx0ghpbwyR6i9088dZ
         4Mwp8oNxaToCBJv06hU2u8OBrvKzky9OCZAiRcbSZyLZpqvOpGNyWaX9GwRoYhY+cj/p
         /fz/0RwpEy9tGcsz65MVlFMCtiHSHfQvQMh1LgLbb5ieFRSoiCpWd7IWHHpCgPcakil1
         UJDjKamc/rYqEZ90GriSHJx6ZicrBVlfrKHfZfygp6AXwkE6+1P6RCKiAQcoSXYw5DQt
         Sq60KKcpGinekHOdKMIWr7S1lFqapHdd0A3Ubl9UbX2A/dbNjVWH4cLFhQinzCP50Izt
         pWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419090; x=1741023890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFYgpHAo4G8yagE/n80s92o1BJfsNSB20MjCQ27CjnU=;
        b=bfH2PvVEyLuspGz4xOBSPQLGFPPpwjGZsJQsw8JLV2EsheBTA0sQBGhns/O8z3gKYR
         1/9fsMMJpYzEdRcVjdhv9TMxPMSNtQa0qByVUrl5Am+17CFovmWTPxeOjdieO5QPd52V
         M+E4J7hMVzSmQd4ketyPUUqptfFJ0SSiSvtGALEADw0aqcQ44sOI8t7NDidnRCuPBFjy
         SA3K3Q5W0A+faMQ8NCNWWNUoEKk2NCYg2VLtVRt1O6gQhHANfa8ynHsSMcYWOzOefGPP
         KghSJ2utKUnhgZDF6mA4qe3TQE0Oac0kM3OBS6QBQuNxHOTZbjqyX5O41lIXTygcVoK6
         ajSA==
X-Forwarded-Encrypted: i=1; AJvYcCWucUlyPHW04fbADm0eX54fglowMXdTPgKzE41R0f9ex03X05iurTJgqUEoo9GZMfuefNPKkmiylvp/FGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywer6AzClqSZ/q8JttWVMMglbo1FGQRdVOb24Q/ruJjH9isEwcM
	W8gEDPFUmYdIxqAo5JZFaNAjTgmaXPY6W7ja591h20r7S86zuyIVWWLOZqjjtHI=
X-Gm-Gg: ASbGncvvF5qit6vrj7AC2amxQExNYS5kpYIAvK86ab5WYkQISW3/52+RuSMg1TjBbNX
	XUOsLOlu74xeM4+jtOFA0jL/DYPFNuEsmTHgrI8RcXK60h22TbmOwMHMIDjPmklY6NuqHgYMNTc
	iR/9qV2unIg9+oEo/Pux6mD/e+2tE+F3kUqQGPsomImnMTd0LVh2rk2dUiX7bK3k+FeTCjAD80F
	8V4Xhm9Q1ewOwEi9IjxGYVhrZOydi5lNY94SfG/21IMoHAryWJi2rrGgPP4UHK5bFCdYZ3mykAX
	PKnSDXbAr7Y5oLVYrC952vw=
X-Google-Smtp-Source: AGHT+IET7VWvxOoimLSqiCoSqQxzK1UXWlBt1CdNLGlMCKraTG1S9SrVYIY6g/f5afjVCWtM1J9gvA==
X-Received: by 2002:a05:6e02:198e:b0:3d0:1ee6:731b with SMTP id e9e14a558f8ab-3d30487b68dmr3037665ab.15.1740419090502;
        Mon, 24 Feb 2025 09:44:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18f9a8a68sm52379905ab.13.2025.02.24.09.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:44:49 -0800 (PST)
Message-ID: <ebad3c9b-9305-4efd-97b7-bbdf07060fea@kernel.dk>
Date: Mon, 24 Feb 2025 10:44:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/waitid: remove #ifdef CONFIG_COMPAT
To: Caleb Sander Mateos <csander@purestorage.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250224172337.2009871-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250224172337.2009871-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:23 AM, Caleb Sander Mateos wrote:
> io_is_compat() is already defined to return false if CONFIG_COMPAT is
> disabled. So remove the additional #ifdef CONFIG_COMPAT guards. Let the
> compiler optimize out the dead code when CONFIG_COMPAT is disabled.

Would you mind if I fold this into Pavel's patch? I can keep it
standalone too, just let me know.

-- 
Jens Axboe


