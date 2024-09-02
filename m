Return-Path: <linux-kernel+bounces-310448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B2967D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7531C21411
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623AEEB5;
	Mon,  2 Sep 2024 01:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wb2qrcmu"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349779C2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725239027; cv=none; b=tXTcMJMX22KzWp+F2/9AeHAfGBpPqPI52qQjf8dMhIskimjQy2XAn9jVeYQ8DxB0422vxoqm2JqycskHny46vjVX7mRZ6gB1kxgDrY+lAPLxMeSdty7Zkvpl6k+dTKIX+EQyxYK/rj2i2EY9lphOXo6dCpoWzga27VHXIAF97mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725239027; c=relaxed/simple;
	bh=fsYVC+tRluVQCdwwY+bKcaaUnBiGi0rTwc3GN8Yg8Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TgHmLvficI0c0MfiiTH6JoZu8CxhU9/9r6ofMras0JX+S2G3927u68KYlVdruXGR8rJDpCNCRnD92ihrYj8czBmdAOIv8NdtpDHTLM8w2tAA5b0tmkmAcjHqEZ2fVrE4sQg9cRCibYKWMST7voqxp7bM4KTvSj/1MAA+qZV8gEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wb2qrcmu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bbaf45044so3762785e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725239024; x=1725843824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mndv8DRB4gi1GjBSiLtZXqU5jiAp3af5moutOmXPzIE=;
        b=Wb2qrcmutfZLTCtkDW6sk/JxF52pZAtguiwtaq+pcZCzq6BMB4ygI+XRPISgons9qK
         GcRGcBs41+oFS95PtKVTnLt1DEojMwDQaPMiDqGXq1T4QbVmHWBj46JwHo7KG2yiT8Zh
         QMYrTcdXVStd06pLJO3qzr65LM0+qQxAPyXJZUaQcf8aHiJOYv3+Ogn05EqYAA+9tqfw
         1cwSmJsiBgSKyqZFHRPfu6lpYA5ElLux3VKwUatxjVoywEnqW6OnaY1tUlVoaPLFoJtG
         wQJGitfuwfEUxW6VqnQKlvao9GMz2AyubeiaYUU6U5IoXxeiwJwQWi2KapldQmb7Z1/O
         wMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725239024; x=1725843824;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mndv8DRB4gi1GjBSiLtZXqU5jiAp3af5moutOmXPzIE=;
        b=SUZMqwAvn7fX4QX1TzNAEQZhbf8gX3YCYtTOfGkeMSEO71V0XC8Dxo5xXj1q0l0kUe
         dK4XP/eFAJj1J2fYOewIe3h87yranV+IRhZTyiOjqBpxgaFXJiy2Ax8ca/yHYbKxCY+t
         QqxelEnRTOXbVG9pt2qDwD7m84zA+FVpyxifkgGotPrfs7H0NsbCMPEOfX2KAyNJV/BF
         2VnMsu3AeN3dhYnXEp6nY4RCBhos0sckyFAF5f2YJtIhAh0txaAzs5jJT6/GlO9ps+UV
         A+ydD/AuPYCXpmvqJM/ANj7qCZKE1uoexUrvot9ucTkXQdCe6oh+Xm69B+ZhzhpKzX20
         Fxuw==
X-Forwarded-Encrypted: i=1; AJvYcCVAWajyy1NYpDIIqsB6Q8obEMTfegUgl01ZgUk2Z6D+zgnvJ3+NcyYayKMhRKpRFICqEFMVVxqWclbHNKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ElQx8Vv7mc4WZ8WYzLyrMWema5eFL3iIqqeoyBnlcfz7RENv
	L/VOvBJDoj6/CaK+pFLesn+Ui9t3mQNHtTvm5xVPGoDl19xV5J+rUQ9upvOD1/w=
X-Google-Smtp-Source: AGHT+IFLeyaCM6YzT5deLam+r6JrfsCR7XaQszIQ/J0VOEZvMDpwkzlj543XeMkf6pJ4Yxqjnf31qA==
X-Received: by 2002:a05:600c:4f4a:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-42bbb10d61dmr35742415e9.1.1725239023016;
        Sun, 01 Sep 2024 18:03:43 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2056f4158b9sm10495865ad.120.2024.09.01.18.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 18:03:42 -0700 (PDT)
Message-ID: <b716d079-1725-4a89-8998-e0c88b8ea7c5@suse.com>
Date: Mon, 2 Sep 2024 09:03:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in
 ocfs2_set_buffer_uptodate
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Lizhi Xu <lizhi.xu@windriver.com>, joseph.qi@linux.alibaba.com,
 jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <1a063827-5cf3-42df-a690-f3c644c10996@linux.alibaba.com>
 <20240821091459.681136-1-lizhi.xu@windriver.com>
 <25f2be6c-3e9c-4484-a44e-d26e9c4c8a74@suse.com>
 <20240821143911.cec82fac50c08947523da2e6@linux-foundation.org>
 <20240901175402.816203db096c2e9e49d75363@linux-foundation.org>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240901175402.816203db096c2e9e49d75363@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 08:54, Andrew Morton wrote:
> On Wed, 21 Aug 2024 14:39:11 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> OK I think I found the correct patches - v3 of [1/2] and v4 of [2/2].
>>
>> For clarity can we please have a full resend of both patches?
>>
>> And let's please have a [0/n] cover letter which describes the problems
>> which are being addressed and which also briefly describes how they
>> were addressed.
>>
>> Also, it appears that both of these fixes should be backported into
>> -stable kernels.  So let's please try to identify when these bugs were
>> introduced and to add a suitable Fixes: to the individual changelogs.
>>
> 
> Again, can we please have a full resend of these two patches with the
> above issues addressed?  Particularly the identification of the Fixes:
> targets.
> 
> Thanks.

Hello Andrew & Joseph,

If Lizhi still doesn't respond by this Friday, I will send his latest patch set again.

-Heming

