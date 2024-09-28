Return-Path: <linux-kernel+bounces-342478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D317988F7F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59464B212E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E16187FFA;
	Sat, 28 Sep 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="irnTO/xf"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FA125DE
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531216; cv=none; b=gGiXwf2kQbIMMK/v1gNlQzkH3UIT8VFD/7VzgiFx3eBj8vdc/YKMtY2BGvWobbrUUfKXUlRszsjWrdkAIQaXgvxsawz5Rme1kbcGiOK5DHPf2x9Pp5529nL1plAJ/ELV+Me6HOOEPhHjkNBhRMz8g16AAyqv22h42FHKBO52yNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531216; c=relaxed/simple;
	bh=IL8xBLJREca9rMBxbuVHs5rU2aJT++kRH/l2KtCt0C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9I/SfoLjwyHmuWsM5h2Vt+OSs1I0IMQEGJm3QLXQeasHtpSigDR1VFA99/k8LzEndugtjbZ6/lVw1reryAfx/uGYFzFkkAkxvTATtF8zAq9ak83/2Nv1e37OrOObZqk1AlbPC2Ag2UMnj69z5zB5LG+1KVQuYPgKcbmV50YKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=irnTO/xf; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb22e9c6dbso16936066d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727531213; x=1728136013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S8JOGBPqZbM/PkiqPaqV8oIZHf+pr+xC3kn2p1ap7dA=;
        b=irnTO/xfOh30pMlIhcDmiBxMVatHGN9FtnIMAbU0kWsFKMBHStwyl3Ch56btlFsqU1
         5iWYcL3tR3LOTkEIMcTvz7muUFVEGu1X5xr6osGLiNV5Cpdn5XPuWg4JjRoqpajs6txp
         4jyRUKaPfVZY+M4D1lUUaepNZgZztPLw2HTqKE42Q9wqGMXD7qcpIlAhy/RUUx3McrwP
         JniAAyNP/8WXEbsAHA+SP93oqxGVrsHqoIVdd3Ym5TWbcH8yOTSsOuT1d+Be3k3QoL1e
         024orZQAuaYfXIw1DfBzOUsc/Jp6ekTBc1VXQWXGKAB7dGIMmqGE1wUy8c1Hxd2SBLEb
         ECUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727531213; x=1728136013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8JOGBPqZbM/PkiqPaqV8oIZHf+pr+xC3kn2p1ap7dA=;
        b=Sw65SHJO1n7aHLirt7BVAhtUeixHHPCd/TEwF8qI/umzz45jP2FVSouql6h5qCryhR
         tNDcPbcnjzY8FsBy7FKxAvl4rUAT3n8Qs0SC8SnlJQ54ucpBgOomzlu1/1ki8LdKemx8
         RBfQVCcTHCphLtWV+7ttDMMOqeoBPKQxkVZL59/TeejsaRr/9p2Xyig/OgbaPg0yXr8v
         qxsAqqb6TYsKAMPTzd39rRRDtfNhsEwtBWxs06TV+lUA13mABbotj6Z3XE+dJ0mWAfpP
         YXbpqkzQG1g+iiER+FbbL4t6lADsGen+Bs0Efj87hB/LHvUPx+K4gCw7MFR643aEA4yo
         xzTQ==
X-Gm-Message-State: AOJu0Ywfao/Ryq1ZVfvm1Be+ZMYOPJpr8qnqC4Rjz1P7CMAFRZB75wSx
	yEizheMKEzDgpM6czaxZ4yFPLsdxOLo8FIal8b7JhllQjEYxzN3sfQ28hOTQNMI=
X-Google-Smtp-Source: AGHT+IHjdapb+iiRR+dWaAlEof707qeMn1MsOs/sm7PrpIpbiv+gLhvrIp5R2uHL1m4bnujig96KeQ==
X-Received: by 2002:a05:6214:4303:b0:6c5:17cf:d9fc with SMTP id 6a1803df08f44-6cb3b64a42amr93498666d6.46.1727531213408;
        Sat, 28 Sep 2024 06:46:53 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b610b12sm19398486d6.39.2024.09.28.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 06:46:52 -0700 (PDT)
Date: Sat, 28 Sep 2024 09:46:51 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 2/8] mm: zswap: Modify zswap_compress() to accept a
 page instead of a folio.
Message-ID: <20240928134651.GB957841@cmpxchg.org>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-3-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928021620.8369-3-kanchana.p.sridhar@intel.com>

On Fri, Sep 27, 2024 at 07:16:14PM -0700, Kanchana P Sridhar wrote:
> For zswap_store() to be able to store a large folio by compressing it
> one page at a time, zswap_compress() needs to accept a page as input.
> This will allow us to iterate through each page in the folio in
> zswap_store(), compress it and store it in the zpool.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

