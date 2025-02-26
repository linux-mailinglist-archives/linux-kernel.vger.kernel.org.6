Return-Path: <linux-kernel+bounces-532908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE626A4539A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F11E1894EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6F225760;
	Wed, 26 Feb 2025 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MRCK1cMV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58F225415
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538917; cv=none; b=dNdqxVyqnaL8nUkXCOLkRUjQhQDvMbeG3kEt04cfrBhsp4DwtlYk4e1wvh2LOarJQAJfQbs4f1hJ7ugioAb1bjY0sQ9sCeUnC0WXXiks6FwLir3Eqgeo8tnBAvpjuwy6fVpVDL5KwzMMdEvMPR973UQk0tv8+7BhSJZiqhWIhpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538917; c=relaxed/simple;
	bh=IfSVBQx5VKJjC6OckF9k8DDdLAHZLQuOmSckaiQV4EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV6F4a/n7/tsEO7qFWKLit0KRsmrIWsArrwPuGRjEEAawjusxcuMS6athah1w2/naA5jn9T/po26I2xgqd5cqOl4Z8b3eimMuZasALvmKNfqt38yiqd4DqMWdX0PNRY3/go0eKAzwoZzvhZHdfaVtQ77nlnmOd6QgUhZd7azSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MRCK1cMV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2212a930001so60149095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740538915; x=1741143715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBSmrlZ5Z2npuLebcW1eC8eFV3vV+lfwwK1HdKGIVgk=;
        b=MRCK1cMVQpZOqZqQAUKJChFNZ9t8+sMF/YNyEA7d/2y6gIlD3gyDFPf9AuJXL28Eoc
         QAaFZPfGCNqko9bV/7nXhDg4ZT1RAvdLAqyBunKwdOBphjrk2dGkm8pM9hTwP4f5eHG1
         ASj+zDsqQ06+4/4Ls69gJZ+DSO2vQj8Uz4dTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740538915; x=1741143715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBSmrlZ5Z2npuLebcW1eC8eFV3vV+lfwwK1HdKGIVgk=;
        b=nL7T3uIpTKeJgJ1H5K2LvgbdkwvlTl0I0htMxh/eAL2rrEfl4d8Sv8ULVBc9n3iK92
         edObQgPVB50wB5eRfruna1Qj47SqrS1ZCt2iQBT+nQDvFxjQ1dVMKzAvjNFeR68kX/Zu
         LhfhW6J1RJmeIa+DPHQExxvOSd+M4MrB5sF+9w68WVHuOx98aJZUDf4bM+qwjENRhQ/e
         oJOoDpLy2XwtW6tm3MJ/XtqAMtMcGeIaZHlMLjlz9ZewenGwjoK70e5UnYp1j2Aiee9h
         IP8KAKkxRXyrBtGx8HGGe/6ig6ZZQVHflpc8lxlUDQxxeTbeIh6lhb13AhYdK3Pa252r
         BPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTe+KiIdMzHWMT3xefkGcHgvuxIotOQARxqGVDb9oBqFFnUPopmzpxZvhqqP3SNJ7IuMcokWglWln/swU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeXy/xSYu5Pnrnorg77kfrFB/TQUvtgGPAZ6NEvxso+PfCnO2
	cIQpKq/vRkNHSLXyAqkBEdHdjH79LNGtdxLLMJ3y4VtuKUU3txj9ik/Q2Cfpsg==
X-Gm-Gg: ASbGncv5OzK1mZMl83dKHkCNvjx7v6OGoqhncnkGkV8JvhYkTiWvipzqyBL3JqYcX9M
	M9YQSLxNOzTOuRxv2juEDkv+iL1GwlipkhcZm9qOQeqo/6ti9Pk9jfHCexLpXIxxDfVwGaNDy1H
	3PMTIAbWXdyYmF17+WnfUGMAr3I86csArzkUxKV28UcYpPNe4cpjdshY6lBSDEpwQIaVGq5ERaA
	sAj7kemAmRxZZ0YvbrDfQl23l61VICYL/nJbM1bmnhaFKqMr0GBaGf9dTH2aDdgWWu1bEFnW6dz
	dUyZWR5GZ+lWSkwHp3VJosR3vIpydA==
X-Google-Smtp-Source: AGHT+IEvhlGRA17pNkoWOuhYMDxK7i92vFKHtRCKajBBzAfKp5HwPuyEHlnSFwDzg7+RqM1IoExpMQ==
X-Received: by 2002:a17:902:b205:b0:220:ff3f:6cbc with SMTP id d9443c01a7336-221a1148e8emr244494125ad.34.1740538915198;
        Tue, 25 Feb 2025 19:01:55 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e27d:842a:e0d1:29c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000a2csm22088445ad.32.2025.02.25.19.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 19:01:54 -0800 (PST)
Date: Wed, 26 Feb 2025 12:01:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/17] zram: permit reclaim in zstd custom allocator
Message-ID: <hfyjus7dgb4raclpllbmkmycvaqhwouhjdtafd43p7wsccioud@wnwa2djahfi2>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-15-senozhatsky@chromium.org>
 <20250224091036.Y9fHrKr-@linutronix.de>
 <vh3uzody42dfcfduwrhnha3wrjm6wi7awwferzed35zuodn4zu@txo4zpftf2uq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vh3uzody42dfcfduwrhnha3wrjm6wi7awwferzed35zuodn4zu@txo4zpftf2uq>

On (25/02/25 13:42), Sergey Senozhatsky wrote:
> On (25/02/24 10:10), Sebastian Andrzej Siewior wrote:
> > On 2025-02-22 07:25:45 [+0900], Sergey Senozhatsky wrote:
> > >  static void *zstd_custom_alloc(void *opaque, size_t size)
> > >  {
> > > +	if (WARN_ON_ONCE(!preemptible()))

Gone.

