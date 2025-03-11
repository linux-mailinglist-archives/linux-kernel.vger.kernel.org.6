Return-Path: <linux-kernel+bounces-555477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010CDA5B82C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49573B0305
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C11E9B1A;
	Tue, 11 Mar 2025 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGpOwHvb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA51E0DD1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741669372; cv=none; b=c1DrJs/OZ6EPBVmSra1b4hVPcUhkkVr5uDgy6IeMgKXaBHIWaQu+iM2IaYgd/gl4x9GNZ/WbvStkVMrjgPtTD3l9Tqph9lXBlWpcvaZI67j8sCAoCxz2N/eIwcFGVmM0nbspTxqz7mY4S/Tw0qXVHMa5wRZzWSSjuXXUsXr0TMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741669372; c=relaxed/simple;
	bh=RhaZm/cSv+yC3HFSPC17iQsu6nY2OVc5d4bSK3oNuHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9ZNmHJKNHabXo1hctp6NWsvAH9H9yBHdQ/5VLxDtsgkiSHOtIqLu1vA1Fo1gerV3Fc8I8ncmoix3mcgERK3A8x1u+XaBNWQ0NRk1J66UXB1hNfsFG8HvxQeeSPJ41P9mLylI5hRfRTjYIvg3ZzdzYL9EoJ47D6htMpzRayTY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IGpOwHvb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22359001f1aso120151745ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741669371; x=1742274171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YsL06UvFaIQXEiahdE6DhBRWjwB8pb861e5j/ftXC1c=;
        b=IGpOwHvbnFgxNs+0ESrki4vAB3llPBkZT4bciVn7QuEVB1hOhhPFcqU9YavYEfOABS
         Blo3DfWxOj3KdsjwX80cj7mClPha/FKuNWDCGr9Ze1bdi92lOYVibmRIPmY5hu7YQ1Ef
         f3YIR75NU5EEVIFMctroZZ1V8Ad6hjYoAfcQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741669371; x=1742274171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsL06UvFaIQXEiahdE6DhBRWjwB8pb861e5j/ftXC1c=;
        b=wMHbydb1OusDxuDsy+Y5gE3/VBtYkQQ2U5uuXIO7r2f+Gx/kRgAeNsRveltmVyRIGv
         KEz1wciY1rvb33iFF8dXc6xM/aRiYM2dZvsX0eEQXsGG5uswvywzpPDQi0KXc0TO1PJ8
         0sm1+R2I7YJPNQum1qG0wUV/pNxQ+Snw1sJL7y6tBfUl0Qp1X3+4STFnjL2kaWy4LAxt
         7OT7BKbU4Q1Yi7CKDQca8ZC7gI1NhQhPYx6hVxWRGifmvWxu8QVt4n6T6FGurPVNCCHR
         ckLDSMqx3zxL/7PmGFjqDHcNP3NqzHW8kAFgG8ZwTtrDe5a/+tx4jnPT1N2cDP32v0SI
         +xSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1H654pfG5Lkk8IKHdR0GP4bEQU0vsO4V681LA2SoIt1+KzI+MOFS+LaY+Gemb5J1xnVEXDAqG915WPiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrl/elC69irTk4y2Tsdv4YbhY7EhQntGKHOj/RnlekLF9zD/ZT
	KAUnCOulLCSxUVoqtADvXxnDvbI6WZE38cFou7lR4vLTwI4PDKahQsbqtYD1eg==
X-Gm-Gg: ASbGncvrtFjM1SJ8dWSlzZpmvblaUf+IcLyDTzLcke5Zenl8meYXCfi8GM/ZfbHJEL+
	b8fERqvWYZIgR/+oONkioUM+en9Mfk0ho0A84pmO1TGPIquriYrrCnifWG66UO/CvDiwIWFVtnx
	4LlRdobAklWPwLcASkyjJw0sik7Jjy8dtzTTE1GNm/o3ObGjxIYT5Cn6dSBcEaMqgQGHvAiBoFh
	j3UIUHnLplT7XhJVZITL6KtzaUj8L0Qj6c/Yy+5Pp/5bLg9rrgvfrkX3P0RwAiHrHfSpwfxeWAL
	hWU3k1Vw6t4HwLbqc5aoE2wAJWoX99fHja9TaV+MFtABRSMn
X-Google-Smtp-Source: AGHT+IFKfiFQm8ms/qPRi+wcBaiWNYQfbAZZRcHY4n0zNhnBnJ9IpLaSuc9kTChF2fwrDmR2pqJfNQ==
X-Received: by 2002:a17:903:40cb:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22428ab7691mr283789275ad.41.1741669370601;
        Mon, 10 Mar 2025 22:02:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:cce8:82e2:587d:db6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddca2sm87480825ad.13.2025.03.10.22.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 22:02:50 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:02:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Qun-Wei Lin <qun-wei.lin@mediatek.com>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Casper Li <casper.li@mediatek.com>, 
	Chinwen Chang <chinwen.chang@mediatek.com>, Andrew Yang <andrew.yang@mediatek.com>, 
	James Hsu <james.hsu@mediatek.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram
 compression
Message-ID: <mzythwqmi22gmuunmqcyyn7eiggevvrzkpqmjkoxsj4q4jc46s@64jdco5s6spa>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <20250307120141.1566673-3-qun-wei.lin@mediatek.com>
 <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>

On (25/03/07 15:13), Nhat Pham wrote:
> > > +config KCOMPRESSD
> > > +       tristate "Kcompressd: Accelerated zram compression"
> > > +       depends on ZRAM
> > > +       help
> > > +         Kcompressd creates multiple daemons to accelerate the compression of pages
> > > +         in zram, offloading this time-consuming task from the zram driver.
> > > +
> > > +         This approach improves system efficiency by handling page compression separately,
> > > +         which was originally done by kswapd or direct reclaim.
> >
> > For direct reclaim, we were previously able to compress using multiple CPUs
> > with multi-threading.
> > After your patch, it seems that only a single thread/CPU is used for compression
> > so it won't necessarily improve direct reclaim performance?
> >
> > Even for kswapd, we used to have multiple threads like [kswapd0], [kswapd1],
> > and [kswapd2] for different nodes. Now, are we also limited to just one thread?
> > I also wonder if this could be handled at the vmscan level instead of the zram
> > level. then it might potentially help other sync devices or even zswap later.
> 
> Agree. A shared solution would be much appreciated. We can keep the
> kcompressd idea, but have it accept IO work from multiple sources
> (zram, zswap, whatever) through a shared API.

I guess it also need to take swapoff into consideration (especially
if it takes I/O from multiple sources)?

