Return-Path: <linux-kernel+bounces-547737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A69A50CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148917A6C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E51F3BB2;
	Wed,  5 Mar 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3fGq4nx"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17ED1DA53
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208641; cv=none; b=PNB0DsVwB8PItiYYGCz29kSGHglhul5xGu6Hf9oiwotLBwiLEHWnrnw3W5oI4s5JI5jqgN9Ydd0qsq6cdP2JK4NAQ40XOjs2auo0B3ybf0NR0C5yeNrZC/eL+qukCyUCec4UsDADADUsZtJ7k/iTdvu26yrVuyikUhhLFy4jtdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208641; c=relaxed/simple;
	bh=jv3DxTvDXDkuTkEbE6Q2uUExpW4dgNtpHbMwBKfbtpE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bvI2ehPqwZziDmgpDtwdo3JTLS3+ovR+PkkdRC1TzL4nrVFxHhENnubtPyXYqLHTHHfwPGJrQSSBWgpVgRlrVI5KgTsxYhZjcjoLPRkGVOqWRti7DFs76kRty9v1J6Blgm757JoOaZC8LT3NRbXmNgXKc270/Ae2fjv11IHS2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3fGq4nx; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f66dfc205dso2320374b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741208639; x=1741813439; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZYeJ/EScM+XbrFd+pb08dty+0axP95E0mTq9GlRXcw=;
        b=Z3fGq4nxGe6g2XsBfB0U9zhq7wGib2u+Xb/VVJxBoYEHX5/zn2BME0OiC/TAPCkVhG
         H9ublbBNVCURelFJX0GmLVjmpdYHNgUsvpzoOdQlcYdSnk5LrF4nXjc5ic62H5p0D1bd
         sf9YjqmyEQ7xqp8Jb8zcn9Tj1sCDRGtNFtxh+MtssKzL0BVAD9LgXCJxZzlO14PM9wLc
         NwJGD52TjmGaAPoGKlXMXdqWikFTRiAVVUtan8TNnMoCTNnjhKOzIbOYqOkjKI652xAZ
         wiu5SgbfTOaQjI2kR7DfVjlte7w3NEMYjtkvnmkfC7hEWxlMTXs2GFqhxxiR1dI6iZpo
         qlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208639; x=1741813439;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZYeJ/EScM+XbrFd+pb08dty+0axP95E0mTq9GlRXcw=;
        b=WrykbR8l6oag7SnF9/4522GMMrBvw0XOnOcnfowSR2W+j49BLKl4CoIUX9AiDpIlEx
         83hBzT31v3WGzolceD77//oHsgD8Z3IMG7Irl8HPCzpiQEn4mvLCewPWdQqBLW2T1mu+
         9WsMOkcr+B0O5Y5Q6+VzeglVkzh0q+dLIN7nGtdQbp8dWmLVMxPur0H8ehYVvpXA0kNJ
         XVShv352Itz+P3CyMDhHsa2S7jcqp+G6D4cbKpDRroynKpKkNbLLZZ4yX/rMWl1k0eZE
         /OUE+2KY3/rxKWksLa/i6LEd94jvsH+eRyuMd3z+fdNfdMhnPwA3SubAhg3d3wkfsPAm
         ouZg==
X-Forwarded-Encrypted: i=1; AJvYcCXHkeDDnNlE7u1cADlJJSdFsb5yPN04HtNxWGun/hUcPYW7YgNk7TRcff0O5Zs1AMC3yQCjHK8kVA7oUDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKkFBof1QelQVldkbUQIn37PQSJr0ei70ompS9agcwtIPniCy
	SvwuptAkmI2Y9ksrsnBSAnWjBmGgjq4vVONj8E5ZRB5/BHfp/H5LtWNXMEuufg==
X-Gm-Gg: ASbGncvZB/lOrdwYYibM1A3XYCiei+9niBNCsKfGwFK5VdiHAtp55LEv0sonxCTveoc
	0pXtNET3pY3kxCVe0j2jTFlwYmgLnzJvOiNpguqzJ5nHyhXN2kq5eNfnIN6ApUtddsYIV+Mhoc5
	fPYL+OSp0A5t1X5t5xl1KTB6r0zkFt3O13ecQ2vr0Ls9ihGfQTJva2KHCjZlpO8pep0GmTT/4wp
	mPab3naRzlIzozmqLMHVVFNmBX5ON69MnPR7yObeujYnSoOecHhBw8GuPONtE+OOuMy+7HHJunW
	r7gfc/5a8xiekrDYWMhl9tF6jtruXCq0A6TrJa2R1EimpuZ7JWNdf4ScU4erIt8jqCCYbhTEW4v
	1mXJDENOQDAl8n6sLKX+wYzpQlVBS
X-Google-Smtp-Source: AGHT+IGx1qJShlThJeyjHrEAMBYR7T+mgBzxLucPBySnraPp5/gczg19cu7Q2YJzDpIj/fypmompCg==
X-Received: by 2002:a05:6808:e8e:b0:3f6:8048:3778 with SMTP id 5614622812f47-3f6831f4006mr2653572b6e.26.1741208638532;
        Wed, 05 Mar 2025 13:03:58 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f667108460sm1429003b6e.41.2025.03.05.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:03:57 -0800 (PST)
Date: Wed, 5 Mar 2025 13:03:40 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    linux-mm@kvack.org, 
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, 
    John Hubbard <jhubbard@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
In-Reply-To: <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
Message-ID: <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com> <20250226210032.2044041-3-ziy@nvidia.com> <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com> <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Mar 2025, Zi Yan wrote:
> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
> >
> > I'd been unable to complete even a single iteration of my "kernel builds
> > on huge tmpfs while swapping to SSD" testing during this current 6.14-rc
> > mm.git cycle (6.14-rc itself fine) - until the last week, when some
> > important fixes have come in, so I'm no longer getting I/O errors from
> > ext4-on-loop0-on-huge-tmpfs, and "Huh VM_FAULT_OOM leaked" warnings: good.
> 
> This error should be related to the other patch I sent out on using
> xas_try_split() in shmem_large_entry_split(). Great to have you confirm
> it fixed some of the bugs.
> 
> >
> > But I still can't get beyond a few iterations, a few minutes: there's
> > some corruption of user data, which usually manifests as a kernel build
> > failing because fixdep couldn't find some truncated-on-the-left pathname.
> 
> It is likely that this patch might fix it (partially):
> https://lore.kernel.org/linux-mm/56EBE3B6-99EA-470E-B2B3-92C9C13032DF@nvidia.com/.
> Andrew has picked it yesterday.

No, that's a fix to a truncation issue which I had not hit:
I did try adding that patch, but it has not helped in my case.

Beyond checking that, I didn't have time yesterday to investigate
further, but I'll try again today (still using last weekend's mm.git).

Hugh

