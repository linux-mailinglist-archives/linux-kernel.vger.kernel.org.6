Return-Path: <linux-kernel+bounces-547385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD1EA5066F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D2189121E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160962505D3;
	Wed,  5 Mar 2025 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHxYOIn3"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031FA95C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196133; cv=none; b=CFQy1AoeMxal6ntJcf+ybO0u5qQ3pBCN7dQf7lTQJwbQGkOJT5dHqtkZXFGmGS9PPdRz28s3cP1XDE/uY2VBj8L/OVyciKMxNTz9fLrpXMKVTPxInJVWINzK77Mbc2HO7qja4NTNULfP/ufmzyFe82CpwLlgPDgPqVKF88sPSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196133; c=relaxed/simple;
	bh=pHTYXfPrj8V8AbHEsvsY+SiWSQhwTD7mKEix6kuTEp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgBBARRWQn9q1xsJvf7FFvnHslHq4GlVftMbGy+i7gA8gHpllsQBSZyD1kVlTDh5NswQ3LS56nSem7/FKALQ0jzdQgNxML5W6uobZ2ctO/qn4J2gvDs0kp1h6f2UbvcDKKyO6Q/mVIhUNs7BpWkhZImZ4zf9cd8ExcGAvGgfFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHxYOIn3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e535d16180so5299598a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741196129; x=1741800929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SM8bR6f4jLNAYKl22df1LLHJ43Y/HeDR/Ded9gUNkcw=;
        b=IHxYOIn3cwrCs86XEl45AYoavl6RiKxO4AKuZwtRfufZkWsR4CeDQlM3Cs/pO1tGTf
         RjSs3gD3eDp39+dVpWuA8kTk+qSVallfsD/hrJSNe5U5pK9BugIV33q9oIIYjepZw2aD
         dM4zsDaV64sWy8i5hEeaTklKwg13EnLIGFUao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196129; x=1741800929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SM8bR6f4jLNAYKl22df1LLHJ43Y/HeDR/Ded9gUNkcw=;
        b=xMfwhidaOVju1/pDzaYXoDNNkgYhnMlsIiKVmIoBg8h/IpduWkOHPdgnF7TZC7J+5X
         yhXWHo5r20RwD6j/cXwpwPuMQQdDluoypKelRd1iMaYK3R5aqR/K6KfSfYZNrTmldH65
         Sa0WOHiG8gMsHwieD0zqJrMuvL/Uc9gLrFRgiq0MlDVYNSlv/cWPh7f2oLLPRHI6U98D
         +n6NqTmfXJO02WWlFLP/wWLPuuGKifagJz/Uerl54URXUYX5QBEZbnUXtcYxsDfuqgD+
         /zzccF3XpRghhAc4feu9WdOkeT0ib9NFzMoev31CfWec/QNd18zfuAk9XG2kDx9JY38s
         oz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTaN9kKC14GNZX8QrtKVpqcnwdzafmkVAGwcg/KO8Sbatp+xyQ6uKWmnaxo7al8YyGB3TrJ2RznHfdZvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfn/JXRP+UWjj3xnM8pGnyWpdGzVd2DTlSgfaKm10eHR0/NxwM
	Zme7Sd/Q4TSTQFJiVUu+l8Aby9TaeoNJi6QSpeIm1AxvUGcaN9KWk30aH7nqYZ/GEc4AIdZRE5q
	8gH2Prw==
X-Gm-Gg: ASbGnctM4Pt1l9CwAieXV2nEUpqTuL5EzlIhvm/atl5DZf+XsFSWXJKHZHwcOSv+sSJ
	qTz8Jql8Q+96z+r3Vuc2L94Xyp6K4cVwxSQVV/eRbqBqnAluK71aSPSUsRHrxOdp1uf52T7tDMQ
	yzIxyJnY7Z0zU2SYLHbwlDJPh938bumkKLIAKxXiILnSHGEQz3TMDu8p5gJYYQJ69bHyKfkj+ka
	nslZn9/5dicrNZ6Lpb8bTUlLnsM1seGv2pCcc96RBP6/zMHH0ikcK8yJMy9p5IMQJnMsvgb5D0F
	C9qCRBX6eHv+ZmY+Dr0TAF2T0tFIdv1zIuTNN0gM0a3YdSICtnyeF1tFQDO1CBK0zrk+g7rWt5i
	FTMqMA8EEojh99nUH/8g=
X-Google-Smtp-Source: AGHT+IGl5CThi90QVbC7Po/FDzmL65eTG4ZVhU2Dd9qiq7SAPHzMiFFK7kQFbh+P5PhW96J7lmnExA==
X-Received: by 2002:a05:6402:274d:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e59f47cdc3mr8386810a12.25.1741196129035;
        Wed, 05 Mar 2025 09:35:29 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e382a04bsm418377366b.163.2025.03.05.09.35.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 09:35:28 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bbb440520so41965085e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8xW6NnjkzGb6pxbJjIRc6XqOqsYDjE2Pr0uZU89l1m9OnRLZFbBNhzQ/rCsSNxEZnyrnbvs4JfU6kxN8=@vger.kernel.org
X-Received: by 2002:a5d:598d:0:b0:391:158f:3d59 with SMTP id
 ffacd0b85a97d-3911f74088bmr3981462f8f.15.1741196127813; Wed, 05 Mar 2025
 09:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305204609.5e64768e@canb.auug.org.au> <20250305112301.2897-1-kprateek.nayak@amd.com>
In-Reply-To: <20250305112301.2897-1-kprateek.nayak@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Mar 2025 07:35:10 -1000
X-Gmail-Original-Message-ID: <CAHk-=whuh+f8C4u+gCkxRZyrt7Gw_FFw_pKn-2SnTovZOvEKmg@mail.gmail.com>
X-Gm-Features: AQ5f1JpVncbQJB8CMWOiHCOAk_h_Z8i-dDxgl5v-NmRX9Bj6aemi-yO_tNgOHd0
Message-ID: <CAHk-=whuh+f8C4u+gCkxRZyrt7Gw_FFw_pKn-2SnTovZOvEKmg@mail.gmail.com>
Subject: Re: [PATCH] include/linux/pipe_fs_i: Add htmldoc annotation for
 "head_tail" member
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 01:24, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Add htmldoc annotation for the newly introduced "head_tail" member
> describing it to be a union of the pipe_inode_info's @head and @tail
> members.

Applied.

I also committed the pipe_occupancy() fix for 32-bit, but did so
without testing - it was ObviouslyCorrect(tm), but considering that
everybody missed it in the original patch, "obvious" is all relative.

And it turns out my worry about pipe_discard_from() was unnecessary.
Yes, the code is buggy. But no, it doesn't matter. Why? There are no
callers of that function ;)

That said, I still hope people will take a look at the code and see if
there's anything else I missed.

Oh, and testing. Testing would be good.

        Linus

