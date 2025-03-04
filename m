Return-Path: <linux-kernel+bounces-544913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC6A4E6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E7619C6B81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45EC28368F;
	Tue,  4 Mar 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="d9qtE4lK"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F89283680
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104982; cv=none; b=UVOYQ1RRTd3IQ3FuG2W8j77H8ocHIVY2s2J7xxTOFOdm84fr7jEAPbg3XYsgmII5AtH8U9fmjqJiK6blmd4e4Y7MGsXsNqYbYH0La6PzdhurXnRPCrLo1CN4kPQxjYI3WdMnlGJORHVWIA+hf6GrX4lzi22xaeETp0AqFtJytHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104982; c=relaxed/simple;
	bh=vndrgoHzO1JbxR/Uplci2S29F5Yak6PffbtWYRGDCLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9botLCZ9wg5NlpxfOlS7L6kHpM39AZyHSeSYcfNWa/XOZkeU0dgyP3aRpDyhOpCB2gtf6QsQrtrqmZbWdUzeZMQMPQV9aLWxNPZ4uqpEF669iZLhrpmU9uuzRNoDr88qdmZ31JmxhKu1ieyrcyk2IfnuNFmdiGDLRT6TXQOB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=d9qtE4lK; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c04df48a5bso588012985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741104979; x=1741709779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdH3AKQlJjVPXu/3oVyqdmU7Zg+wJAihXQK8/YRYybU=;
        b=d9qtE4lK26a9aB7KbztbpPQHL7+8I5u1Y70I3fUrUktCXAhWXku95PKUcRx/GsmBl4
         wu8uaLjZ2p838Z0sNgT2uSh/OdV3DjNokzona3tDgu+0Zuh1WVUk1xT17xGJv212OexR
         raoYLc2FDtrcU/7SRDSCF7HnHu5WGgEMgRVOtDJysMkNazurDqp0psgPk63ERJf7ycpd
         R8mY26r9O6G5rq/HAzy1ytBr2mAPRZkLMBMDOsai4RgH78s/ITm8K6sOLPErggRv+qDd
         UI1lipV+ttsU0Hx85JJrCH14LW2gcsLW3GDWR4ChNs3VQWKJe+EuevB8J4ihLpR+uqwg
         aGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104979; x=1741709779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdH3AKQlJjVPXu/3oVyqdmU7Zg+wJAihXQK8/YRYybU=;
        b=aKrC8LwNkQAvIO1HCTp11yca5bn6OWvY/NCMUodiliq2ZWSmApZJB96hSRM5KOxSbI
         DEbFFHqf4mXRA6i2QJOzJn9aFJo2nR4w71oAACDOtxA5ChyGV18Yhwte6zN9YBEoyhpk
         9RROqznfwfSTQyQ9j0k0k8V9UgOzUOyvJYjJwEdVTIrym5kSaYC72ZQbSQqC5R4pZ6oK
         4fVlrXGcn36fk5i7C2lUCTd6EWkhlIYPYXyFrSNevlCbitig5q6QfrevYVtMRjAP0sXF
         dKBJT0dxxnqQPShSv71GbGNxjApEQs+qRi8AtmBOL/838LL5ADHJAA51RxOgB6JkNKkd
         l+hw==
X-Forwarded-Encrypted: i=1; AJvYcCWld1UVuAIVuAfFY78bbmshQXTHe3vNZ4yfUmovK+if/FXLkw8XfMfi9YjjUtd3HpQaPY9EgQ0ChaYMpLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnymw8A1WPq/Cv8TMZicbUcFmHp4vWj8LgD1SLUne5DchF2wU5
	KqAgH0C5TWvMGxnwJyk4g76ioqB3LIwSahCk5+1/p1XFxQSkqCQ7Zu2jKnrzKzk=
X-Gm-Gg: ASbGncuJYkk/VYMiGSjP1znIV0mKpUMBun604JdJjZqKMrwVU1nFd+y8X997obQUffC
	kkIMDjZoGWR53ct6Xjnf2yR0+qtFqgcYwgL0ttU82egRXKCBHuDwMbzSkwbhsQDl2mICDweRpy8
	9u7fX6HnHirxrxkRp0OXamOyZvDV/4s9MOG0K/+R77m+gfbZI7Av3lJtY8SQiddVbVYq0rhJc7Z
	XiHmWoJKrpk/RaoWOSD/m+3i6VL/52giMq43qGl563bv9/mdPJ6i7vQe4O8NKPTRqKzSIndGp1v
	kPSeQmIvWUxf4IwPRJfBKlCe4my6wWCqZPqSXK/AYzXnK4hpWT9WAaqXH69zGQsYBttbdfK9NVP
	BQOEN4xt8IrWZGt8vujXYFkRrCJ0=
X-Google-Smtp-Source: AGHT+IG+8gkxb5a4FLU8HNw0RgCDeDarhruq85hL2w5mldbW/rpOd9s+9LQfuwgtmnJwF45uXgCLwA==
X-Received: by 2002:a05:620a:26a8:b0:7c3:d3bf:d1c0 with SMTP id af79cd13be357-7c3d3bfd3d7mr258875085a.43.1741104979239;
        Tue, 04 Mar 2025 08:16:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3be1f0c05sm279200385a.102.2025.03.04.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:16:18 -0800 (PST)
Date: Tue, 4 Mar 2025 11:16:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8cnUA9WqsscbUtm@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8XWqQdPC7245FA2@gourry-fedora-PF4VCD3F>
 <95541985-8d40-4ded-a83e-46203c441640@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95541985-8d40-4ded-a83e-46203c441640@sk.com>

On Tue, Mar 04, 2025 at 10:03:22PM +0900, Honggyu Kim wrote:
> Hi Gregory,
> 
> > This patch may have been a bit overzealous of us, I forgot to ask
> > whether N_MEMORY is set for nodes created but not onlined at boot. So
> > this is a good observation.
> 
> I didn't want to make more noise but we found many issues again after
> getting a new machine and started using it with multiple CXL memory.
> 

I spent yesterday looking into how nodes are created and marked N_MEMORY
and I think now that this patch is just not correct.

N_MEMORY for a given nid is toggled:
  1) during mm_init if any page is associated with that node (DRAM)
  2) memory_hotplug when a memory block is onlined/offlined  (CXL)

This means a CXL node which is deferred to the driver will come up as
memoryless at boot (mm_init) but has N_MEMORY toggled on when the first
hotplug memory block is onlined.  However, its access_coordinate data is
reported during cxl driver probe - well prior to memory hotplug.

This means we must expose a node entry for every possible node, always,
because we can't predict what nodes will have hotplug memory.

We COULD try to react to hotplug memory blocks, but this increase in
complexity just doesn't seem worth the hassle - the hotplug callback has
timing restrictions (callback must occur AFTER N_MEMORY is toggled).

It seems better to include all nodes with reported data in the reduction.

This has two downsides:
  1) stale data may be used if hotplug occurs and the new device does
     not have CDAT/HMAT/access_coordinate data.
  2) any device without CDAT/HMAT/access_coordinate data will not be
     included in the reduction by default.

I think we can work around #2 by detecting this (on reduction, if data
is missing but N_MEMORY is set, fire a warning).  We can't do much about
#1 unless we field physical device hot-un-plug callbacks - and that
seems like a bit much.

~Gregory

