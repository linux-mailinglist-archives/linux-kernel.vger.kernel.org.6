Return-Path: <linux-kernel+bounces-515859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512D9A369EC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24EB3B138C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A658C2C6;
	Sat, 15 Feb 2025 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHPuxCs1"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5B539A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578848; cv=none; b=bxdBDteTdzqiV5A5ovKZnIlQEZdIFHvTRxRCwTawxhc2k/zkaqybHyTpxdbaW13weezCRJwZJll3CKkfFRalvEp5qPkgVSkZc69PoM8opBLhUVxMpFG57C1P2++dzg5AHgtERSZOs0ZDNY+q7830QGSMEi0iXVUbDm4/eo0NvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578848; c=relaxed/simple;
	bh=yVGzHqB6DvP18TzRdgqG2YZ08xeusfNaDgfVq0S6Zp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZpZocaTpjCNPRix76FFcy+NM6Hob8c3M5HQ6krKh7QwTzuJMJLe3BOuO0W4/pZQEDuNV/oDhQShxnBeyLFv0XeMZiTWoKRwJUHiNqfrf52mGJvZz3gGQyHDppJZB/11stZ54plLvE1z4CjbizkFDfnHndqXPBvGel4mrUpIib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHPuxCs1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so1820600a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739578846; x=1740183646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze2Xz4XXqzMfbEKdIMXfLIcH+8ibVSVZmXZeYawsRVE=;
        b=aHPuxCs1OfUSHBAdNbgFDf+glEvIOTJ3S2jWxbrqgIeU5NWCp9pfct1RSPP3GV4y5x
         Bf0rt97GKdfDTn0Es8IuTF64a/Os5iVOx+LUDZ1MHn5MyVT88VsYJx5sqzRHqO7kFLph
         U4n1KAwcRBdTz7zheNqLWahKYyoAO+o7nk69IKUcxkQnqAo2KPtLkxwYi92+4avzQ7YT
         4WoGZ4UVwHZ7TLXvmsSY04U1vArcpIDHaMcmRLI0LxJYJDCmAQ0J5GJnHUN/JZHULOsw
         4smCwHvDBUSRxXmc0N9NN+9anLiRUQA9UZq/9ItKUP05/H9Ei9kW4DSZ0Tjdo9Zkp68L
         UTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578846; x=1740183646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze2Xz4XXqzMfbEKdIMXfLIcH+8ibVSVZmXZeYawsRVE=;
        b=eOeMz0FXivrn0BtE3a4GDWI6pFAaFr1UbtjQ/KM2u570YtbnhbouZXNmtWM50EDLvt
         wlSG0lj92w4xfs83E65V/+eILv88lAI6ZUatwejQamjvuC6co4OVlzgBo1ahPpRZR+i+
         1ETeY9CFJ5ylwoiNhLMEf/bCIMjmMWLSYLP4c5RpS7lkq2xrWz7VS8hz/b/p3n7k65wi
         pbE9h+jRltMagH6laaWJHfjwAmiljehtxBNM89jhTe0U789nw31Tu3LTP7GNpazoLQ7L
         cpbMu+QbuEqZkrK0agkiPqqFvJrVONt1g/MUixWtBsq82tyQcfoOIHfHg0o4pwApSwba
         A2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy/VVwuhfhFROL14zQoKvmQbkPkj2t/JzCYNQo3C5W7zFe9QIDjmuGPIIfVyu5tim53qF1lagZcFG0bS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj18f1YPJokQHzJFLqmFCbilfd+r+n1V2aTJ1wJdajwJP7+GT0
	iOLYVjjKlMKmeS9JGeunlqEDQ6iwDT7tbUhkk6AxsrdUwdj0dT4y
X-Gm-Gg: ASbGnctddUvZ/DOolU/njDG5MuBk39xRQJouXFT+5LpAvbIEM7z+36wt7z/g3OCOdrr
	I/8r7xvQ6ac8erojkDaRonq0d0yRZ2zj0SRZn93lce6GSjg3FeaIcO8mOLJilWC4CXNyZdtFKil
	Nhr+Jdb20CfJrQFoqSshnzlpW3u49vlC5Q+ojNLI2JRhVAmZQxMqnr4vAwABn/saR7q5FefnXSV
	SrH5LthD/kpx9jEYXGzg1yTqYDXxZi/xA9nEahn+BYETfkeRdp9NP4gOeB3XsG8/qyxBhkPIaX+
	Vw6zpumN6R3NePnl4yrTzpT5ZJomgm43I79ZtRs=
X-Google-Smtp-Source: AGHT+IFjULYP12YEy5fSd7xGbP0hgbXOWUtqaLWgDUP8bxyuH+QOI2fa266dyIo2Py+3lYT98/XVWQ==
X-Received: by 2002:a17:90b:2b48:b0:2fa:2124:8782 with SMTP id 98e67ed59e1d1-2fc41049fa9mr1645186a91.25.1739578845803;
        Fri, 14 Feb 2025 16:20:45 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556f97dsm34411035ad.172.2025.02.14.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:20:45 -0800 (PST)
Date: Sat, 15 Feb 2025 09:20:36 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	linux-kernel@vger.kernel.org, osalvador@suse.de, byungchul@sk.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, max.byungchul.park@sk.com,
	max.byungchul.park@gmail.com
Subject: Re: [RFC 1/1] x86/vmemmap: Add missing update of PML4 table / PML5
 table entry
Message-ID: <Z6_d1MvorGFpxdU1@MacBook-Air-5.local>
References: <20250214195151.168306-1-gwan-gyeong.mun@intel.com>
 <20250214195151.168306-2-gwan-gyeong.mun@intel.com>
 <25b9d3f5-bfe8-48a9-b11b-819d19cfae1e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b9d3f5-bfe8-48a9-b11b-819d19cfae1e@intel.com>

On Fri, Feb 14, 2025 at 11:57:50AM -0800, Dave Hansen wrote:
> On 2/14/25 11:51, Gwan-gyeong Mun wrote:
> > when performing vmemmap populate, if the entry of the PML4 table/PML5 table
> > pointing to the target virtual address has never been updated, a page fault
> > occurs when the memset(start) called from the vmemmap_use_new_sub_pmd()
> > execution flow.
> 
> "Page fault" meaning oops? Or something that we manage to handle and
> return from without oopsing?

It means oops, because the kernel accesses part of vmemmap that's not
populated (yet) in current process's page table.

This oops was observed after increasing the size of struct page (as a part of
developing a debug feature), but the real cause is that page table entries are
only installed in init_mm's page table and then sync'd later, but in the mean
time the process that triggered hot-plug accesses new portion of vmemmap.

If the process does not directly use the page table of init_mm (like swapper)
this oops can occur (e.g., I was able to trigger with `sudo modprobe hmm_test`
after increasing the size of struct page).

> > This fixes the problem of using the virtual address without updating the
> > entry in the PML4 table or PML5 table. But this is a temporary solution to
> > prevent page fault problems, and it requires improvement of the routine
> > that updates the missing entry in the PML4 table or PML5 table.
> 
> Can we please skip past the band-aid and go to the real fix?

Yes, of course it'd best to skip a temporary fix.
The intention is to report/discuss the problem and a fix as a starting point.

-- 
Harry

