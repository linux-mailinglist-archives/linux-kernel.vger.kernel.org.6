Return-Path: <linux-kernel+bounces-299852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465BC95DACA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 05:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A841C2136B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFEE1DA3D;
	Sat, 24 Aug 2024 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTukmscy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672FA5F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469013; cv=none; b=qn0GBhPTJRX0DGRmKBAs8IEU4m91wHb6c7EASV+57AOnYK1acUdjfln9PxIxNzFLQvkrb7RgEiGXx3sGcEWSh7SEnExrRwv25rMQJCKgtWeF6JampckySnY+vejr22s/ip/2zVU6O7joHR2ioD5dCHIw4c632AJAYXFDZaJ06IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469013; c=relaxed/simple;
	bh=XORFhPA9LEtA/V5kQAn4yXHuw3jMEeUQojjMaEcwrBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S07wLZXVMExibxVf1m26zVncs+dU7ErkT3Ek+7paymy2dL5BS4/BD2ZtSEsnTBXbtSugMJFFgXjr/C1VeCOdy5TZ26NpO7otEuQXKR/+esyJtXaQTkN5yjLYeKC6xnTK7DFhkfh47Qi9T29jvkhsJQmYiGDhhqJNswixsqLM9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTukmscy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso27027445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724469010; x=1725073810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XORFhPA9LEtA/V5kQAn4yXHuw3jMEeUQojjMaEcwrBI=;
        b=wTukmscy2pG1VeagP4PeRJa8Dhm4ykgcY/CRq6OxzKnAD3xaIOX3DcQe7GuenXRv15
         ieCxgJYmKPb6+xHZnUfCBo+IhJ98rMKaWoyp2S48Frb1kGzRZh3TVmSZgIBooBPJZLgE
         9L9GkViwvRlMI7lAsv13EzJ/FDCiLRtRoPhyt38FlexsMb2i5HAow8cBZzuwKaGI1ND+
         MthpiqpJR6LzOpiYSRj+Sky0jthu2Ks7CwUk8uo3/wFPmkgvuiUCOnWRGtjkYWIQZaq1
         zUYA2/WlaFTNahmwDfrPogLsyYc7EmNVynYc7MyMwb/ii0AuHrJN803tse9mxPCmKHpT
         yR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724469010; x=1725073810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XORFhPA9LEtA/V5kQAn4yXHuw3jMEeUQojjMaEcwrBI=;
        b=e2BNHdOBREnPA2Xa53Abv5cbXgQ95VKGedWv9hy3X0lrZq5XoE3tDY2Q9d3LqOmwPT
         bgLIJiG2efyn1HQ2ZIAzp0Pvg7CRnTII4q9CwnoZHQ/Cj6utnk3sOJ9zcurfhP9uYunW
         /3dlsCt6wVzMDYMnFGUzKx3YUjG4JsE43OjRyYnuirX1bNJWFLksV/SqKFCFMe3xnTDJ
         WkLixfDgA4eSqadw/2FNHimjY2tCMY00TVcMh2+wjr32hT8EmHckrvFmUDH+f2FMHaf0
         tmS6NaUyyyZFHR288jDISngbc98L2KQD3ACd1skz9e0DHdQJPp28TeEZBggPsRwUMabc
         a0kg==
X-Forwarded-Encrypted: i=1; AJvYcCUSP4WqzTP06Lxe8QneOpaTla6Vv4tJx3fJvydSF2K/zMdCpvs45mlj1P35YhJ9Q8i9ciZJgQYr47+klJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTn8kbueNwwrscXVr7Ju5XmCXaxfFJIf8AXae0MYTe6CromIIC
	i9mk6Ycr8oRecHhwe6NDlB4wFkMA/k0pn390ervVnZFHnyyCWMVfhsbQP+2pWoXiivlZJZJyV6p
	URZDsIj44OtDaHu/TInPa3Eu0y3bma1SegcMW
X-Google-Smtp-Source: AGHT+IELhA72NHC4z7MDWu/g6Bo07mDNlKl5sXzEkop4+mWRb9GKDUqRiGc7qQJH9zIj34nNwLIqRqMTn2bJ9lNB20Q=
X-Received: by 2002:adf:b311:0:b0:368:3f6a:1dea with SMTP id
 ffacd0b85a97d-37311840050mr2810804f8f.6.1724469009384; Fri, 23 Aug 2024
 20:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com> <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
In-Reply-To: <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 23 Aug 2024 20:09:32 -0700
Message-ID: <CAJD7tka1KcL7O+=YanStLz9VnsJtoKkB0d5SDyFUrezno0Z2Sg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"

[..]
>
> I'm not trying to delay this patch - I fully believe in supporting
> zswap for larger pages (both mTHP and THP - whatever the memory
> reclaim subsystem throws at us).
>
> But we need to get to the bottom of this :) These are very suspicious
> and concerning data. If this is something urgent, I can live with a
> gate to enable/disable this, but I'd much prefer we understand what's
> going on here.

Agreed. I don't think merging this support is urgent, so I think we
should better understand what is happening here. If there is a problem
with how we charge compressed memory today (temporary double charges),
we need to sort this out before the the mTHP support, as it will only
make things worse.

I have to admit I didn't take a deep look at the discussion and data,
so there may be other problems that I didn't notice. It seems to me
like Kanchana is doing more debugging to understand what is happening,
so that's great!

As for the patches, we should sort out the impact on a higher level
before discussing implementation details. From a quick look though it
seems like the first patch can be dropped after Usama's patches that
remove the same-filled handling from zswap land, and the last two
patches can be squashed.

