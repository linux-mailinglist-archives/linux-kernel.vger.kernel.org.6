Return-Path: <linux-kernel+bounces-511077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2256A3257F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6438B188AE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7620B20A;
	Wed, 12 Feb 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fzxDle9Z"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD071D86F2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361499; cv=none; b=lZvvoe2ql12oVaya3N41PXm6kvv/opdzOsdrf5seCwrkdKWNSE67hCCwu9ieid2jaZ+I8VrViwWPVzjS/7eymHdaSrjdgSsXNeUXBR/XrNRoAcddMFJUaXt81cSj9zPuTSxJ3mZTYg0yUfqRWfIBAZCo3P66y7Utfgob6zB0FeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361499; c=relaxed/simple;
	bh=Zr4yGBYQKB2JkRxHIXXJ2oz/3gXI/b3u5EhL7+/O86Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn61WuDtAPlpOJCsbeYgUSLXV4Q/dk0Y7EpyTnOZR/HS9e2EGBdP+nnJIJ3SOjxlApbZqb6i66F0NkfvpOz5PXbea79YvuH1g2NoapEqEnvE5U6XbIk9pxFjPLRLwm0hnqk3NqCqTuvOKXAt61ebFhN4Ju2frL+YHk8Cc7mAxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fzxDle9Z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso6677597a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739361495; x=1739966295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Me0chvjbJ1pFFLI2sZT0ghALOrQAWMmkakkHmyi7IVI=;
        b=fzxDle9Zwxv9UpqVmDh6UN39iE2L7E4XB1maiNJnvatR9rFpC/OqDguKPhkYrPMoQD
         EVM8cR/xT3uj2z6xlXARrO035aIe1wOcRgN+ezARuQuOkZXgSAWu1bUdbIioNKA35GLa
         yx1kyJlwGJH4TZdtjyKs3SRze/0iCS2ARw5J5K86iDMUEdi8RS3J7bs6ZgPVgheXtGFe
         3xQKCCvtbBXXPaRlv04pJRSZ67bPi8kOLBzcQbrXul2I6oDErCWlByVt3QHpTTQIbB5K
         DzctIxkRGqfvTuvJ8wFjXSAWd/R0nNdcvT6K01lEFsPfdNBrcqWwzl8CJv2M0YTdOsQF
         lwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739361495; x=1739966295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me0chvjbJ1pFFLI2sZT0ghALOrQAWMmkakkHmyi7IVI=;
        b=NTDJ/oeJ7HcRlbwxGnN5ZFZDO0HO8DLDjO3VNoCV0rfxbYPQuUBbBzPRATlDh423pj
         TQbDqZMds6x7eWR0l+YGEXoJncZGGUu4H+HZAPPmHzoqw7nQjd7L/Fo6xCu3drdLzHnP
         D8uNabK7zLx/rKz2PIISnlBA851R0GK5s36kRw49Bnsx9dS5fimDW5wBHXA+2TXElgc3
         5jj/mlgvptfjiI9xLcWryVou0pz2cPbwCrNu6RW12Qgf/LMdHIfOxxygfYTSKGweJ7Y7
         X8yMVegAW90hMh1QsHi9J+09OElyNpqDeZ9F2FFmR+ae8h28hiNYptFFI3aHsR0hWwkU
         sUYg==
X-Forwarded-Encrypted: i=1; AJvYcCXOrKQQ1WrcE8KuHBK/9q2ST8IFV9QnDlzvv9kDS6c1E/+7dP7Lr9MwZBxIznU23ury4qi+yytEWcbCfhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FITRuqLX53MHrdcHtKGnMBF9xt/627/0RDTO9H20pNx5YguU
	KmHOZfPRhu+YzOc025vhpJpch2vEsP0bCRb5qgcp03E+xE+R2lpFvn4dgv8H0NY=
X-Gm-Gg: ASbGnctw9u/P3CuxEilwmaZzRwtcBF0sJ9600bOLp0WARQCYZDKrzOqPPMlEVwya400
	HphyfE7om4+g4dDSDtGoaGOnqNPncoNQcbjmM0nZTrsjB1+B8OQiAUI2D93i1FJwd1D1WlSOfIn
	uzeHFaT5B9MNCAGz8vBP4LVzJn/8ueur6eBk2Zn2M1nAqmX4esXmQYwDGaLURHJm7GqKMKlI68w
	eSWVie1zKj4LfEKKzAxlVoLE/sOYQL0q/iaFRcFshrAjIijMR65wG0BN6XbI4jEtKcFCLxaZBJO
	hpFbFw8UK9BPMBMRDE+Zxcbpoimx
X-Google-Smtp-Source: AGHT+IFZ3F6WfAtZKj1YYoqYD9Alxhol5RnT7Ux/XbgtcW0L2oEEJ4Aa1ufzUnzaMa86H/wd3EO7cw==
X-Received: by 2002:a05:6402:2345:b0:5dc:545:40a7 with SMTP id 4fb4d7f45d1cf-5deadd9c9a0mr2372357a12.12.1739361494610;
        Wed, 12 Feb 2025 03:58:14 -0800 (PST)
Received: from localhost (109-81-84-135.rct.o2.cz. [109.81.84.135])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de4d250084sm9533100a12.16.2025.02.12.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:58:14 -0800 (PST)
Date: Wed, 12 Feb 2025 12:58:13 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	mkoutny@suse.com, paulmck@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH] mm/oom_kill: revert watchdog reset in global OOM process
Message-ID: <Z6yM1dycm5E7vfT0@tiehlicka>
References: <20250212025707.67009-1-chenridong@huaweicloud.com>
 <Z6xig5sLNpFVFU2T@tiehlicka>
 <d264a73e-966f-4890-9e23-88d476f0fc81@huaweicloud.com>
 <bccc9e06-af8b-4a55-a69c-98596f1c1385@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccc9e06-af8b-4a55-a69c-98596f1c1385@suse.cz>

On Wed 12-02-25 10:34:06, Vlastimil Babka wrote:
> On 2/12/25 10:19, Chen Ridong wrote:
> > 
> > 
> > On 2025/2/12 16:57, Michal Hocko wrote:
> >> On Wed 12-02-25 02:57:07, Chen Ridong wrote:
> >>> From: Chen Ridong <chenridong@huawei.com>
> >>>
> >>> Unlike memcg OOM, which is relatively common, global OOM events are rare
> >>> and typically indicate that the entire system is under severe memory
> >>> pressure. The commit ade81479c7dd ("memcg: fix soft lockup in the OOM
> >>> process") added the touch_softlockup_watchdog in the global OOM handler to
> >>> suppess the soft lockup issues. However, while this change can suppress
> >>> soft lockup warnings, it does not address RCU stalls, which can still be
> >>> detected and may cause unnecessary disturbances. Simply remove the
> >>> modification from the global OOM handler.
> >>>
> >>> Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
> >> 
> >> But this is not really fixing anything, is it? While this doesn't
> >> address a potential RCU stall it doesn't address any actual problem.
> >> So why do we want to do this?
> >> 
> > 
> > 
> > [1]
> > https://lore.kernel.org/cgroups/0d9ea655-5c1a-4ba9-9eeb-b45d74cc68d0@huaweicloud.com/
> > 
> > As previously discussed, the work I have done on the global OOM is 'half
> > of the job'. Based on our discussions, I thought that it would be best
> > to abandon this approach for global OOM. Therefore, I am sending this
> > patch to revert the changes.
> > 
> > Or just leave it?
> 
> I suggested that part doesn't need to be in the patch, but if it was merged
> with it, we can just leave it there. Thanks.

Agreed!

-- 
Michal Hocko
SUSE Labs

