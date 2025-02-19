Return-Path: <linux-kernel+bounces-521773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C22A3C220
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66443A4A16
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CED1E5203;
	Wed, 19 Feb 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5lt7oPQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93E1EB5FD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975229; cv=none; b=ojz6622sKvR9ADr4OGVkka+2JmjD3mMp4ziWEYftdqMYAOnOYUNRe4RraxXTKnkJYXqkpU0cICAarYyK/7y1oWF1xfq+CACvxsyJzGBGSEMuLcx3XbT4LwtkM8lAqNBYyr0STn3WOjQgnhgTUdDW2gDV82rHYQ4HBc1gywd4+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975229; c=relaxed/simple;
	bh=72EuZvMdd07piylkq+qnrWqr5/zLRwB/17q1RfYIf8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPXcgDjqjrisE1ujw2nTgHkooutYH2/a6vDSC+QGWuP+MBVfA79SDStLgTVupWAstMpCdp3ES5PDZ3wKEq+ySbAN6DiZiRemSjp5sncQ+dPyhCjMTOBwsaszatvaqF+vZIkhJySuS3v8i0fdv8N1yaVmsSEaKyD3wN+H2d2flaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5lt7oPQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739975226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5kXQZ+eC5UGlAspGME2/vd0jXGJDk+3LXqrC+fAcrU=;
	b=G5lt7oPQLEwrBT1RraIlS2mrWIvSwNnn3DcW2ccF8I5Kbz3LlaAM5FUBGJamu0uHwxJ6gr
	EsR3LGSUvknRbf2dBL8UjSVbARiWtveM3J2/9sJOfoHC668wdyAWMlg3gQXlGtatCN6sRG
	117Jv6IJkAeDpI8eM7eTJOCSn6gSab4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-3zt8R62FOVmrQMf_Vj5zEA-1; Wed, 19 Feb 2025 09:27:05 -0500
X-MC-Unique: 3zt8R62FOVmrQMf_Vj5zEA-1
X-Mimecast-MFC-AGG-ID: 3zt8R62FOVmrQMf_Vj5zEA_1739975225
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7272acb753bso2542506a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975225; x=1740580025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5kXQZ+eC5UGlAspGME2/vd0jXGJDk+3LXqrC+fAcrU=;
        b=k6+Wt2tcgZ6x1RhbPjOlGatvAUweNUmUqNiU4L5heg7K/s6Z7f/ajN2BbeLv/7QIyx
         4A86g+NwETmpDFi3QPtYm0d5KdN9gYh/rH1Ff2PSzjh63AjbavcmwECMfIVBnJmcpM6m
         f2T+6cbae4zHavaap0c89SfM2yb9iqXYU4MPdgUGvqmv/gXcbupxnN2SFzmrubuuhbWP
         nRF8JDfhIMKAq+RDXw01JTWTMN0fzqYPI3ZdTBMZn0Xr1Vme8OBfLES3y83HfuefcP7H
         hZIybdxMcMXQfYvpyYNhmAFeFhfll9IDwmsjDs1NQn7UySXj2NRLY/2W+IXvBM7SHMzn
         dhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLn9GtN67SGsaHQasLy9Kd92Df42PHBUoK6T9l/yy58nGc0zik+dNyT2GOHeSfx9jnFTqSOb2w9Z4/9mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyFmA0yfW+lLJC2mBm4iqcxskeCFthm7Q+/WwAbIS6DhCLqDo
	f9FkAuih4lp0vtK3u6KYCxFVF+oIGno3s2z0ZOI8Yyg259A+A/cV3CJOIMPFsgPJAi7lost3xy4
	T085dwT05zW5O69ZmKoTSn9giZD90F2ARd/awdaqQ8SFg68jaMdw/6oGEv/IgJQ==
X-Gm-Gg: ASbGncvn1+KJtJ1iG7ql2wDCov59PmuhFw6+FgAFWBObAgu6W66OC4odzHWmZYfIpFF
	x918FJ0T/K8uL8c7RyMjHN7b2BBgJhR31jcDWpZ4bvb4ZMAqsk20Exy5v/pJxbZz6+1rabH4wSc
	B9QwvB9JX4mO++KJYXoa4x2rim28nuHXUgIldWETHo0G9Mw+3R7xg9s2GuZ5fbpIgTNVeTo7OYd
	qLtJeYtjH+NysPJYoXBLDNpCaEk/qfSczLDfrmiWPguPd+T8WecsVJs6Hk=
X-Received: by 2002:a05:6830:3881:b0:727:2f9d:284c with SMTP id 46e09a7af769-7272f9d28e1mr6334026a34.10.1739975224833;
        Wed, 19 Feb 2025 06:27:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe2Jy1S/ef+XCanbcwoVdwjMu3KsSLGol5t9LBgIHWTVgTQUJ5yIjtd/FzoCMUVyUc7zq5gg==
X-Received: by 2002:a05:6830:3881:b0:727:2f9d:284c with SMTP id 46e09a7af769-7272f9d28e1mr6334003a34.10.1739975224544;
        Wed, 19 Feb 2025 06:27:04 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72726ce6bf3sm1768025a34.68.2025.02.19.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 06:27:03 -0800 (PST)
Date: Wed, 19 Feb 2025 09:26:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Rafael Aquini <aquini@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: fix half_ufd_size_MB
 calculation
Message-ID: <Z7XqLQmmkDjWNM_5@x1.local>
References: <20250218192251.53243-1-aquini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218192251.53243-1-aquini@redhat.com>

On Tue, Feb 18, 2025 at 02:22:51PM -0500, Rafael Aquini wrote:
> From: Rafael Aquini <raquini@redhat.com>
> 
> We noticed that uffd-stress test was always failing to run when invoked
> for the hugetlb profiles on x86_64 systems with a processor count of 64
> or bigger:
>   ...
>   # ------------------------------------
>   # running ./uffd-stress hugetlb 128 32
>   # ------------------------------------
>   # ERROR: invalid MiB (errno=9, @uffd-stress.c:459)
>   ...
>   # [FAIL]
>   not ok 3 uffd-stress hugetlb 128 32 # exit=1
>   ...
> 
> The problem boils down to how run_vmtests.sh (mis)calculates the size
> of the region it feeds to uffd-stress. The latter expects to see an
> amount of MiB while the former is just giving out the number of free
> hugepages halved down. This measurement discrepancy ends up violating
> uffd-stress' assertion on number of hugetlb pages allocated per CPU,
> causing it to bail out with the error above.
> 
> This commit fixes that issue by adjusting run_vmtests.sh's half_ufd_size_MB
> calculation so it properly renders the region size in MiB, as expected,
> while maintaining all of its original constraints in place.
> 
> Fixes: 2e47a445d7b3 ("selftests/mm: run_vmtests.sh: fix hugetlb mem size calculation")
> Signed-off-by: Rafael Aquini <raquini@redhat.com>

Oops.. thanks!

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


