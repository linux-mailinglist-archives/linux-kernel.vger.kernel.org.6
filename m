Return-Path: <linux-kernel+bounces-262320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069993C411
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C201F21AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BAF19D081;
	Thu, 25 Jul 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="H6GAjNov"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF119D06B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917558; cv=none; b=OD4XGp+rSE/GAZkqqP5QCQcHNJwlJL6gBgcPirVp+/Hatmrvw4M4ynQF2PF7AeQoNbgnTDGf7FOc+2Qs4oqeNyzhwtcWbgj+divpusEVCfaeo4JtXXuXoceaCEW/w+KSzmRXa6TRvMd9hseceufv+ktkfbJ+Rm/zcfswpcYWh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917558; c=relaxed/simple;
	bh=MBfD1/D5cPpfICDCFT7gng1IYECRRvYfJbUcM22BawQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6szQsREfvib7m5cLiv+fotDMzMiN6XaWlz46K7MrYbmvsZuLZOpB2dFF1t+93m6BxXs+hTu9JoHLje03OnzI0Dt8wgwxW9Ug793Yt6einaOQ5pUWE/wVURO9DaIvTzKnmeAP4naWCCjfwKnb1ib7TXx+H1yHLKyLSHYIdL0Og0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=H6GAjNov; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44d1eb90522so4601701cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721917555; x=1722522355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4BFn3DT43cgevtotyewIlYg/Ec//Lq/B6vnxLTCmlg=;
        b=H6GAjNovuK3mSpbFi4wGnwKJz4ZCTc962ut1/vZDRZ9YSZWH+S3T/uMZ4m917VDRjB
         FlWEHJAJsAS+SVvd8tSb4ysQe//QO7PSDoe7NpaY10Bqg3dG6hzmgp1uP2rdm6JYr5vU
         0F05hLLoMgp+pHp2K8MnDC/h/oT7/6lFDp4qezGhtYegWQ0YevaA9Cq3vusaTkgxgVku
         aZsmEvoVdKilL8ol9PhCAQBgmu6ddWO7O2PzhMA968IoaWZFoVLpQ7b3ovuYXB+tPnxo
         jsIbZa4oE82COLCc2qW6blgD7WtCwQdztP2CjSrIa3JlgdBmJVqpEKTOlwOL+rbNsHPP
         1YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917555; x=1722522355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4BFn3DT43cgevtotyewIlYg/Ec//Lq/B6vnxLTCmlg=;
        b=mGydAH2eA1cU5bKbXKcQ3llVqm/rKcdoqGTJzJzTYPvZHOsEsebdENPHUh/qIf/QnF
         iyVXZrBIAjYSZys3yqOSQPizjBFYI9ZzzBprKuP1S10jLMGjBQZYkjMXPp4Mg6/XyH9p
         nqetYXwylhz0w+axD2hHeoUbxtm7vjn9c0OTGrxtFApMMJTPibaSruVl8k7A3/us5kDL
         UU0P2yaEuX/r43BWR9hSaBpXmyZcZ064g2vhZcS9raGR3YB4t89lxaOW+o1/9Meyy/aY
         /NKJkuUwfFnE3/c2pT50R09Vl04Dazher2OGFCQ9LHhUl35EKWcaucnI9qW52eP3kkKe
         oLQg==
X-Forwarded-Encrypted: i=1; AJvYcCUKngkjsRpdLZfE/R4CUlNm+yf1fCo6r9yoEwqcimsvr+8e9VTtXsj602lLArE05A5ZZMH/NmxeLC2E0Lp99sLTz/UEcsbIa4CddOhN
X-Gm-Message-State: AOJu0YxoOAlK/7c3Vs2vhIDrhhOxn63ZqKS86oSokuiuAYpccHphIdmO
	JKkPt0JclLGB26fQ5Ees9VG18ihhzX33yhPXST2HdQaKbbf/fYE7HGLuBVl8v10IdBNMZ0W73pA
	AfLrf/WR+G25wuSMOzfP9E57AtdOvqxZbHyoEWg==
X-Google-Smtp-Source: AGHT+IGAO4P7T0XMvKIOXQVTUEE0Gf1K/l8rsVu08E73s3q41wTcsWaGYT0emRfHfYVA/MAnmP3HtwiaJ16cT0INeDQ=
X-Received: by 2002:a05:622a:514:b0:444:b2ae:97ac with SMTP id
 d75a77b69052e-44fe48a18c1mr38217791cf.50.1721917555177; Thu, 25 Jul 2024
 07:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
 <20240724203322.2765486-2-pasha.tatashin@soleen.com> <CAJD7tkY+atjCn=3o4tCKt-PsRveMbv5mzM+QppqM6jBGHUnwqg@mail.gmail.com>
In-Reply-To: <CAJD7tkY+atjCn=3o4tCKt-PsRveMbv5mzM+QppqM6jBGHUnwqg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 25 Jul 2024 10:25:16 -0400
Message-ID: <CA+CK2bAHrq30ss1oH2uqBAPg-vbyyeYGdOVUJLrdOEcRCwk8tA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] memcg: increase the valid index range for memcg stats
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@suse.cz, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> >  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> >  #define MEMCG_VMSTAT_SIZE (NR_MEMCG_NODE_STAT_ITEMS + \
> >                            ARRAY_SIZE(memcg_stat_items))
> > -static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> > +#define IS_INVALID(index) ((index) == U8_MAX)
>
> The use of this macro extends well into this file, should we use a
> more specific name (e.g. IS_VALID_STATS_IDX())?

I will redefine it like this:
#define BAD_STAT_IDX(index) ((u32)(index) >= U8_MAX)

1. A descriptive yet short name.
2. Check if the index is equal or larger than U8_MAX, which feels safer.

Pasha

