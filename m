Return-Path: <linux-kernel+bounces-570064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A658DA6AB98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143E6178FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C6223311;
	Thu, 20 Mar 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dPzcQ9fa"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDF2222DC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489977; cv=none; b=FOpmaZPbbARhXoUWbBlHYUZH/6Ql6ZNNr87Soxt0BDBS2wY6L9tD+EvPhlXzj98Nuprikcm/r/HTIrFhgveGw4rErjHheLozLbShLAyDmPpA17wvSJG+RB384Yr85LHm9l7ml84fR1GdM7Z+/v7sBPXurn6C0hXndfaTIOQhXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489977; c=relaxed/simple;
	bh=1Yk7hgNgZeHmwZa8RkOaLbHEcPIA8EWKztrD4+fPyyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhSTzdb/lWHeSP7XrUzUlsbGUrRX61qszWtYPgGnJPC/7QmtRTXIXuMktxwOB+8eYweKKSRcw58+Rt95KRtwXFDc5lsvrSRgUtBRjxAhHhfHpl+iB2EebXQDjmL1uX8s6TaSuqfEOAYN0Hmgf8FuZ7rzWDko+31XDpQakdB/xOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dPzcQ9fa; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c55500cf80so85057185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742489974; x=1743094774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipib33z3sn+yQKX9c566UprPG9ZeHYaheF0uNRUCV3M=;
        b=dPzcQ9faTxWJ9okbH/bncnjZodsRWNYW5ufiWdJOmnnaeFltcSYqqphKZzzeAUTrZx
         ZpObSzAEd6KA3JgjPFHY7IisPih1mcCXGGMdR3yXHjTYnu6J1HrxfpygizWbrLiJs9pS
         KNI9fSgR9JcFEVcV6E9PGKGkksiVmmCSFEtji3PP+J7kq81cH83NSn2k8aFgvB2G+88m
         n1j5mGruBfmTDcB5NSl61x5rRMcoEDiFca9x5a+SNfuMxB7Gt1diB3CQtqASDUE3UXSu
         kfErwEgM0LtNwqHqOitiZwIv5VdzNlSktI1Tsk0ml/P7JpN0HBztwkv1c6YiE1FetfQK
         UKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742489974; x=1743094774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipib33z3sn+yQKX9c566UprPG9ZeHYaheF0uNRUCV3M=;
        b=DNPc8mnFlg9/Aei+7O1FIyDRs5yHskHHxELKpQBxXnEEVd0AnJ38ZoWarld3fCEn1z
         VcEkUEZbo6Qj8xOIvU2zTXmo6p+i4ixvoNb44BE8ip3PAGWPzIb3G5R3zm4quaMkcbXN
         E8aURMJMYm3saYmIGxpN9cB7hqJc2aWGsWyoC+qi7jZuhJ5byoSXSxESA+ioRDd7uoMy
         lR9J0mkQ1212h74iYi69MsIQZd8LIlK+Kb7AHH4qaHUN+0tdIfzR8Y4mK0Nwntrvr1yt
         KEicxsw5IcJksjWgDaU+QZQaQP2uLraeJGNaMJnsg5sucnDW/HNPjweX+pdTYgwOhQG3
         TorA==
X-Forwarded-Encrypted: i=1; AJvYcCUPY6NwamT3eqZ6hmHZYw5xb8VuDqTEGu+Xg5aQUvn4IMccjFLlD82rOhVYdtyzVUyIidLll/IAKY1LpZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ueDclldZ7b2lmYdSlT/Lc5W0ajP7ZeEswmH5eP3+K6K6x6oL
	CZ8OtAwnMyspmOBkYNyPxDjvSoEEnPfz803KQhurkk5p8HEu5kfga89LwB9q4V4=
X-Gm-Gg: ASbGncuwnOkfwQ/TtuDA0sxu2hLQlFOZgfiylHhVJBEkk1dGBmdHgmUmB9BNQCDMMvN
	TukkJ4TP4RymGSyLI36LIZ4z5iKQ2jodrn3JMXPkvyOCC8Aeru2Z9GZubxh7sF9j+N6/xvlMccb
	CNr1/Y4YPkTzRjGGcRw/TsK6GP9y1stVk537RitZCZ0CNejhsXDX3QBt6qm1l0W6Wi9rlVLWNe3
	IvZtGnVhs9RtjHnT7PNQG0P4/3c5svRgsGY7WZL0mRPY5Gar6nGRvYhdPLWwSW+E8kko0qhY2pw
	JG596aGXXN3wAB8sXQVUFxyOjs5DjBvT+elMpc2cG1LCBAauGm2aKKfTMP6Wn1YNDohqcRISApl
	GvZ19uMw0Bl6JOD6AQ5mkftFLShQ=
X-Google-Smtp-Source: AGHT+IElzU98u73kWcMh/UGf7sxJFt1GG443MOL7RYcIkJXTEKBGeUAa+MD93tb0ZxGrkPDd7DzAKA==
X-Received: by 2002:a05:620a:c4c:b0:7c5:5909:18d8 with SMTP id af79cd13be357-7c5b0c8875dmr458154585a.14.1742489974499;
        Thu, 20 Mar 2025 09:59:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec688sm11579385a.64.2025.03.20.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:59:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:59:32 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <Z9xJdP29XEz6CljB@gourry-fedora-PF4VCD3F>
References: <20250320041749.881-2-rakie.kim@sk.com>
 <20250320054010.914-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320054010.914-1-rakie.kim@sk.com>

On Thu, Mar 20, 2025 at 02:40:01PM +0900, Rakie Kim wrote:
> On Thu, 20 Mar 2025 13:17:46 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> 
> Hi Gregory
> 
> I initially planned to separate this patch from the hotplug-related patch
> series as an independent update. However, after reviewing the code following
> Jonathan's suggestion to consolidate `kobject` and `node_attrs` into a single
> struct, I realized that most of the intended functionality for Patch 2 was
> already incorporated.
> 
> As a result, Patch 1 now only contains the `kobject_put` fix, while the
> struct consolidation work has been included in Patch 2. Given the current
> design, it seems more natural to keep Patch 1 and Patch 2 together as part
> of the same patch series rather than separating them.
> 
> Rakie
> 

The point of submitting separately was to backport this to LTS via
-stable.  We probably still want this since it ostensibly solves a
memory leak - even if the design is to support this work.

~Gregory


