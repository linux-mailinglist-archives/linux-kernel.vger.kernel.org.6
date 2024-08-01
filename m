Return-Path: <linux-kernel+bounces-270566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE094417F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6856D284072
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C413C9A6;
	Thu,  1 Aug 2024 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQT+69gV"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86971EB48E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481236; cv=none; b=ZbKj70jndO0aUeomPfXZfU2vP50sou4QXIg/6uoqprEaLG5sf8UMk8KArOZvL6CsTJ/b8SWsaw/i+UFZUHg19049MYaiuaylsIt0McYd5ulhaBmfLRsfdhtM+4UKy3jxKXJAmOYuUJe96MJeL5G+HCmZZs2WGqSnSY5OQJHlr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481236; c=relaxed/simple;
	bh=MtUmmq6yBKso5i9314S6d2IiMTs1j2Q0wK20x4d/9iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLyDhbf5jwbMMLOjjPuEp4zSvtrM7O9ESIJEAqL4BlasSKx3xIzNVyVj4eqXHBv3l2PTxhn2UuR0mrFjx/K/ZfqxMEAtR7kbmO5wPKzwD9vZuBBwseaUEKGDZhhmWpn3s1H2rWSJJb1mNz+PYJF3/rY+aKvZFfQUBcrCwIUNcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mQT+69gV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ff4fa918afso1242105ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722481234; x=1723086034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MtUmmq6yBKso5i9314S6d2IiMTs1j2Q0wK20x4d/9iQ=;
        b=mQT+69gVhQp4sGx/ZRa+MZaREoNAMoTq1c4hlq3C8/uanKWOVkTf205EaprCI2JaR/
         ZWEl1RHoclMgrJuoEuTyaT59B6MgV7j+eqD1OPYrmQu9oWCelkF5IG6FRFL/bTxfsQHX
         PKDRqNbkliTI2DGgbzYqS+vhv/BVtzQs4YupA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722481234; x=1723086034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtUmmq6yBKso5i9314S6d2IiMTs1j2Q0wK20x4d/9iQ=;
        b=U3VHJFVYl5CQ5yMIjOvrXIuPYqLKJq+xXRygSaRgbn7S+/kkcODkdEjdzYDF79vlky
         /OGsbrGhqHobGyGdptwTUpJLGtCMBW05e9kEPRobwx7BrFn+h9x7gc6rVE7IekmWAmzF
         esf9MjzYvJNh46MAhe8NOvQ0zo9jOPDxE9RY7mk9SAYRFmDBx0SB0ueCcUNBEv7l8U5p
         GP7HyLHVjaWywZm8OnLVW2l242QgOx2I/bx3l5CheTEBEwyD673wd7YbXpcB0WW5VWIf
         pAi2qyU/VtqRoHQgWXQJ3p3JXvx6m1PZGrvHSNMTI0ru6wpTal2Roqj1BjXmuegYfvUZ
         zpsw==
X-Forwarded-Encrypted: i=1; AJvYcCX/INa4/t/T5FbOIYiXrti1yfH472IUsr7E9Gn8bDtm0l3i+KWpYYM14QsWsfLf9Qn0ZZ2YPeR4mzsu/BztoZZKs0r48D7Qi6PbuGV1
X-Gm-Message-State: AOJu0Yyx3opHf8On4uolkMr9mLw7BE17VdBvWTmZbpPLPyhc0opO5ywu
	rhl5XDE4lrNgcMU1f08fx6GONtpJtj/QojT/TC+aDqf+pn/n5qzc0FX3DU+Y8A==
X-Google-Smtp-Source: AGHT+IEsL5Gq87v+qEaRs11Lh5ivrXrJeRxCteG3ySDGaOUjRhYKO6M9k3ESlfLcaLBWZq3GDDRxCg==
X-Received: by 2002:a17:902:e748:b0:1f6:fcd9:5b86 with SMTP id d9443c01a7336-1ff4ce4645cmr16096285ad.12.1722481233993;
        Wed, 31 Jul 2024 20:00:33 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:153:1133:6aa8:dcc7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f67528sm127081175ad.227.2024.07.31.20.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 20:00:33 -0700 (PDT)
Date: Thu, 1 Aug 2024 12:00:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, ryan.roberts@arm.com, senozhatsky@chromium.org,
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
	v-songbaohua@oppo.com, xiang@kernel.org, yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Message-ID: <20240801030027.GE16599@google.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org>
 <Zqe_Nab-Df1CN7iW@infradead.org>
 <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com>
 <ZqkVMpbl5pH35uOq@infradead.org>
 <CAKEwX=PETirC4P3CXW1uvoHW4H-ozEYpXUGCoi-LnN=jAzMKLQ@mail.gmail.com>
 <CAGsJ_4z1koYbroafQEUm0Sbm3QM2Ag11huUMKA6REQM_bWgRng@mail.gmail.com>
 <CAKEwX=N1S6Btd1Bb=FnMHwXnM_74O+8_WkN97hfqgdV-2k-t-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=N1S6Btd1Bb=FnMHwXnM_74O+8_WkN97hfqgdV-2k-t-A@mail.gmail.com>

On (24/07/31 11:35), Nhat Pham wrote:
>
> I'm not proposing that we kill zram right away.
>

Just for the record, zram is a generic block device and has
use-cases outside of swap. Just mkfs on /dev/zram0, mount it
and do whatever. The "kill zram" thing is not going to fly.

