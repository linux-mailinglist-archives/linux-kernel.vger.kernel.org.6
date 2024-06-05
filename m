Return-Path: <linux-kernel+bounces-202643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B28FCF15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09022295E79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141701A3BAF;
	Wed,  5 Jun 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afrv/Y9u"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1091A2FC9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591771; cv=none; b=BufHRDgrK+R6bQIDc+NjkZWwvPAl+mGpSy2Lgs432N2KHrIbphnQN61kl1oZN5TGpZD729FURLPDIwpFTFRGHrW7B5n4+E6GIMnlvYAv+m64u/BIyU5Brz7z0LCEiSVDD+Yt7EASlYwBSViz9yxZZpEZZiT41a8N++GUU882xHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591771; c=relaxed/simple;
	bh=cmwmKhhE8+ws9LNQyLxf3bJmxZowr0qjjXCXA66CcnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFW8NL5FZFGSDk2vJAGS8/XrMIonLd1MuqPu52E07evq4fqGqnY4fL5F4nvvg+3F8dQmWeIOk6mvqQiObv6BtCA4oxZ43qSty9dmsz00+EccmASnAxfKqAHkr554rAP2JE6793sOSxCEMphEdmcQ0M7hXJpXwo3jaoii9/FNq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afrv/Y9u; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so7794542a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717591768; x=1718196568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmwmKhhE8+ws9LNQyLxf3bJmxZowr0qjjXCXA66CcnU=;
        b=afrv/Y9uW19V+IJNaQmUuODikHxt7M8fhzbtuDA6241qnMGGmBF1e7VBisuJAyxfR3
         rxxLKxkIQCPAjHMyCqHD+gWfiGAoYYD2SHUuknOYOPkO+60Zrtjd+G6tbiTykDTW1RPN
         fUPNuqMV1ABdiipG8iFW6CnKy4yLyFa+XZqE7ts9WOxxATIH/D6bS4x7LCiutXRdYgu9
         xNqjq+aht8IhE3klftEY7RKpOWpD1EiYDYmtO7nEExU1guKRP5g9jtTnwQN/+ekQpiUR
         +4qafx1ADlpivbZ2zhTmQmI12XTgu4T0cSuiPOkfYBZmN3LtZ1wX68f/aJbXZydnGYiR
         YrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717591768; x=1718196568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmwmKhhE8+ws9LNQyLxf3bJmxZowr0qjjXCXA66CcnU=;
        b=TFA/R6lKHa9Qn0G2gKX0sPVrUA8wEEuOsmv3woy9beQdIPRyNmqhysCri1TPYT7xc6
         cGP383eczSTD+lWAuT9ehirgW263ZbJNb/+ITRQeXgRRTEcHTX+90DN7f8p6mWOh+XxY
         ePhirlO9EGBOjqK/rgux/KucDoNBdCK2OvES69osGW5aN32qEuEWnBMYShPG/dArIMfy
         A91HcBGXzDVmeHDR3uCT+Q/OpHOodpcCViuwObaLbGpa0X4z7P8SXF2aSNjMVRfBIVIy
         Dpw6a2upjNbX+Rq/h7aWIrLHoCN0GZCZgkyKFS3ld712+BgfSeme0eKfANzf3SDo6+31
         ISWw==
X-Forwarded-Encrypted: i=1; AJvYcCWX/z3UERUPyfyGmEh2n1WEqe8/DvSnvcNxXQsrg25UgbPx5b7S3Ic5f8eTgujt71kOawLt453/SKIHhvivsbB6YxnPa3ADKD4yuEhr
X-Gm-Message-State: AOJu0YzkIGC5Zzh/0t0P65QKy87kbOLEURt5RGeEqxB9vHYA2/n5kMK1
	Dr4DLM3U5OV1lmua5Z2F+fk3+9zWG8LVGPNt4kiH4/IfFvEDtMt/Kxx3o1THWur1eycMB3eTpVr
	iVMAJCHzNOPIL5kPP3Hq6fkHPZmM=
X-Google-Smtp-Source: AGHT+IGkvhstI8ks3KYdHg4CttNp7gjOV1sWa4vXy3hHa/yAyvhmM/E5FM3inaS2CUSucLbDnI3J0gB6SqG1lD5KTe4=
X-Received: by 2002:a50:cd52:0:b0:57a:234d:abc0 with SMTP id
 4fb4d7f45d1cf-57a8b68750fmr1984017a12.1.1717591767873; Wed, 05 Jun 2024
 05:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-2-ioworker0@gmail.com>
 <d1b9b076-76ad-42c7-a173-85fd4534c56c@redhat.com>
In-Reply-To: <d1b9b076-76ad-42c7-a173-85fd4534c56c@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 5 Jun 2024 20:49:15 +0800
Message-ID: <CAK1f24n-9C5TBqz1oeeUONROGYcKD=T+FprmK9K5SQL0mVog5Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] mm/rmap: remove duplicated exit code in pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 8:34=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 21.05.24 06:02, Lance Yang wrote:
> > Introduce the labels walk_done and walk_done_err as exit points to
> > eliminate duplicated exit code in the pagewalk loop.
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
>
> Sorry for the late review
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

No worries at all, I appreciate you taking time to review!

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

