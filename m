Return-Path: <linux-kernel+bounces-295056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673795962A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73531F25392
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8CF1B81DD;
	Wed, 21 Aug 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AUqgrjWq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766B1B81A8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225842; cv=none; b=S5p2E8AEEuWmTQ2wZMvfCLrAstU4oB4BPM7QZiT5hQJs1+w2FxHYZS7l9e3h0YSx1Xhj5feiOZZLyyUSvqz3sho2MgvhxHhhTZZll9wXJsR626C0eAx/JrG/N8uoPhT1qkmm/JVyZxYMYG0tNye6jiyBs3yxi5swQhX5U2YXOzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225842; c=relaxed/simple;
	bh=JxeIMOH7tHkUbbP7UxL38C9nZ0hVrilR89mYIuejGhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORZRhGfX4FTdWena1O8QEA5u5MvnJIwLswMhghY6cp7Q4L+FGzta6lqDL9xN5E5zmfrL0jOkJLIFbbpQ7m+uTYr3Ym/ZEYKI82JiZR4fV4sQm2PGhQg0whCE0c9TCc4fHcv3u84XCiXkIAIiZlIB4TvxRegSgt8oiej8XCRJqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AUqgrjWq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e09ee91eso690835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724225839; x=1724830639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lL7B6IjERhBSc0QSjdaMtUg31mh3lLJGucO+gpGJk6s=;
        b=AUqgrjWqNDKes7JM1n5SBvQZAMRAAcxig5GNAPOWxsao/SrWhLVhx3e1MpifqsMrOH
         HUZ08hYs8OipJ1evOvSc/Z00JHWOpbtWJnKBxDqTOCZd5H2bfnQcDMnCNUYD/hjLwjHS
         3Hl+eFwn8FpygeL0obVS8yCMUB68QIRTORvRfXa1iSC0ZQjBuCeQX6jU74uJo0K52jRJ
         0bW5UKyvG1gqv1p+/bye8KqrEMMZ6ue9xe7UoUtp8cqgKg6VqhaGWZZC4Nqt+T0S2p0V
         8clnUhcCcWEO09tazJVR1xVacjHHP3tz93Z5I3tjamoys/xZROJnWnLe885YRK3ZdUNn
         E9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724225839; x=1724830639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lL7B6IjERhBSc0QSjdaMtUg31mh3lLJGucO+gpGJk6s=;
        b=NYAZJjR7EcTuSheN1yHj2sD/T43/dxGaCvZUHsfMZ6a84gXB/D8WJiTPocONes2Cpa
         2UYMtmo8kuVmmK3al8sIgTeu1kqF5mFJNygmay2OX94LiS/gxpyKvzeOY0uOb4x44c0j
         T5vxVXhUCoKGL61K3FOIiJTXo3jPyYXpU0SaFrOBxHMkPvVXm7fUzwBGVhb8Gdu+JBQZ
         uGm3jh4InN5zQoUGBvwt49/HxUMenvOgmEFUZeRTV6wV+gB1L89R1XJIlRUA+659FVqA
         zmnoGacHZ3ytuYByHf3hom/36e+3UHyqur+h3/UI81ts1EGqg5RHURedWojSG1pk7ay4
         XlhA==
X-Forwarded-Encrypted: i=1; AJvYcCWuRDg1ohMD6ds4Y6/TObDIpg49ZhmqjNOk5dwZaaW3YVjrmksuUhh3eTNAVCKwYGmwooZYxLo3OuUUh/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMZVZ5PMuYn6MWiboTfqGNlo4A75QVJumgeJFUJ1N1pcENPmB
	46a3TAXZiBek0m6VPmidyOYZ16MLtNtZYhXPerlG0Kqs0jIvbKFhwk8RNweAIG4=
X-Google-Smtp-Source: AGHT+IG43W+r2EfrrKQ35MWuJIlDTBeKYES1yVcjwENM5hwanqQ1S/tnZbm2TleEW9AHkY3K/2H23Q==
X-Received: by 2002:a5d:59a9:0:b0:368:aa2:2b4f with SMTP id ffacd0b85a97d-372fd5753e5mr482295f8f.2.1724225838688;
        Wed, 21 Aug 2024 00:37:18 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa4e0sm88132775ad.7.2024.08.21.00.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:37:18 -0700 (PDT)
Message-ID: <9e4daf9b-a8f6-4d95-8e4b-125ef7b03911@suse.com>
Date: Wed, 21 Aug 2024 15:37:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in
 ocfs2_set_buffer_uptodate
To: Lizhi Xu <lizhi.xu@windriver.com>, joseph.qi@linux.alibaba.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <0dd1d1b4-5e83-449e-af48-3811abd2e6a4@suse.com>
 <20240821065517.3844044-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <20240821065517.3844044-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/21/24 14:55, Lizhi Xu wrote:
> On Wed, 21 Aug 2024 14:23:08 +0800, Heming Zhao wrote:
>> Where is my "Reviewed-by" tag, and where is [patch 1/2]?
> Sorry about your "Reviewed-by" tag, I remove it, if you don't mind, you can
> add it by yourself.

Good answer!

This patch issue was found by me, and I also pointed out how to fix it, then take the time
to review your code. But in the end, you removed my "Reviewed-by" tag.

> 
> In my previous email, I explicitly stated that only this patch should
> be sent separately, as the first patch has already been reviewed by two
> reviewers. If the second patch is updated with the first patch, I
> personally think it is unnecessary.
> 
> [patch 1/2]: https://lore.kernel.org/all/20240820094512.2228159-1-lizhi.xu@windriver.com/
> 
> Lizhi

It looks like you don't have basis knowledge of how to send patches.

I will never reply to or review any of your mails/patches.

