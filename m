Return-Path: <linux-kernel+bounces-212032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F19905A43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A69428294D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B71822E4;
	Wed, 12 Jun 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ufG+kSfE"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8917554
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214839; cv=none; b=bCc/GI9U7twP5uSS8grz2m3EO8lZDKOO1NDoCMDmpYXQ0u1r1OUja5OQEI6+KWybYwK1NAdkxoSU3NqwiKih9dG7x4kEIziGJW6N8Up2i8zoD6TwVyy8P07SVqmSGTcqjkCGzflgxjMbRq5o2sIgC7hOijpOHVhzxe99jQovzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214839; c=relaxed/simple;
	bh=u2QoEwLJoX/vQ0Ubqa8Zd52sVn8RpYKvHli5EjglEuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct/Wt/XXn3JCd9l0c3lG4KD9j8yYvafxe1/IU5oYvHc1MtR4NHEacdCih2ga4v5V6J2cWyVEj3/q862o+cYB5Su/T3e/o3JJ9u7/ebGrEgnRUn+khFiLhBk9z+MpEGZP92dB/U2Lr9N3Y/k4eG5VyTX5q4CTCm4gPHHvhApFLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ufG+kSfE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-440f22526edso604041cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1718214837; x=1718819637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMgLKSW0t1aEhKWe+AkntdQhxYy02qeLrR+2holCnSM=;
        b=ufG+kSfEBw2fv7uVH5tUqE4lo+dDlyN2LtlFRWqc0GYwUQW1slxI2/ABNNX/UThDNM
         zkkJYX2k+rHZZEjCAikFNW3uDbONbe+ahukKbcRUkf99Nuy86VE8ye7hsvuIIJCw2qQx
         Oj6slwXOHVt6GcdU/GCPTINP3UwNFU9z9SNmozsf8XIKUMB4vPbam5VRGyYZRZnYpe3U
         iWeR5kdpBfb/swvSlwzFyhppdN2lIWzVOgU6MQiixj/37ZEc5XlGZKeSEUF9xrqYxIO5
         BGoM72HYD2lNzhq/FEMCVmIupdPrS0X6g1uQtZ5p8GjyW8P8wWzvkFiWfcM2NnCdGDp1
         TBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718214837; x=1718819637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMgLKSW0t1aEhKWe+AkntdQhxYy02qeLrR+2holCnSM=;
        b=C+EX8Nmbb+Tm5BgEIKylRTx9a7GcnWHgZbTvHzoz5HKf9jAOJu4UD+aW7z74/+31kh
         Hor7Oo+5MNX5178IXNaqipavQyK87/bIJwMTfRPNZHa8C93bBjY0xKF7Q21IlDDN4AyW
         DJAqR96LZfAiCMhzbaH5mXUn8f0KejiMDtmoHeuYPcc1FlklZvAvW38LvsD3RiXfO5XE
         MWJSfE9HYr4RdQzVTsqIQQJTJ3gnIQnsPlAE+Xilo37CKLeeKCaWe7LRM0ROdVPKkjgR
         wnvW8fPxrXLtiQJ8xyYw5AdZgOBy7MSUe0jvIsS2m9Wam685J2Hldj2VvWCYd2Ajwk0Y
         RFWg==
X-Forwarded-Encrypted: i=1; AJvYcCUUDxrQIaTcjXIMiN5Hj/A5TxnHl2g0J9HopSbMEm5AT/oUBcbkcBwsWqevvWdCvOdhZ+xCWCZFOGXmZ3pOku4F/FXgBer9iDjcOaj1
X-Gm-Message-State: AOJu0Yz6/0IziCvLMn+g489Gn6ICO+UFFIbKr2djSx/tfaqIKGF2jR3a
	tzlnjCZWz0nxW+jq74LGRjA4hOpHeUTQES4BNAdu8HCIQYZ2wIea+dE90gP3Z7I9Dsy4w5Fs+6t
	D5f/zK0JbDxm2q52XbA01vR1PrYk26Zi2gHT5ZQ==
X-Google-Smtp-Source: AGHT+IEboSl6cuP7DdeifGdtYnGd5qh7/n6H6xuvUtUtKpoRuNfSrEar8wpjtJrO/8OKTRTzH9jgVk6mIIwRg3sA+rc=
X-Received: by 2002:ac8:5aca:0:b0:441:37b:cd5e with SMTP id
 d75a77b69052e-4415abc6032mr37434341cf.5.1718214837393; Wed, 12 Jun 2024
 10:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605222751.1406125-1-souravpanda@google.com> <20240611153003.9f1b701e0ed28b129325128a@linux-foundation.org>
In-Reply-To: <20240611153003.9f1b701e0ed28b129325128a@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Jun 2024 13:53:20 -0400
Message-ID: <CA+CK2bA75p3LW95i79uiEfkg9AS0cKVfhKZMatHHQfRB4PJFZw@mail.gmail.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:30=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed,  5 Jun 2024 22:27:51 +0000 Sourav Panda <souravpanda@google.com> =
wrote:
>
> > Today, we do not have any observability of per-page metadata
> > and how much it takes away from the machine capacity. Thus,
> > we want to describe the amount of memory that is going towards
> > per-page metadata, which can vary depending on build
> > configuration, machine architecture, and system use.
> >
> > This patch adds 2 fields to /proc/vmstat that can used as shown
> > below:
> >
> > Accounting per-page metadata allocated by boot-allocator:
> >       /proc/vmstat:nr_memmap_boot * PAGE_SIZE
> >
> > Accounting per-page metadata allocated by buddy-allocator:
> >       /proc/vmstat:nr_memmap * PAGE_SIZE
> >
> > Accounting total Perpage metadata allocated on the machine:
> >       (/proc/vmstat:nr_memmap_boot +
> >        /proc/vmstat:nr_memmap) * PAGE_SIZE
>
> Under what circumstances do these change?  Only hotplug?

Currently, there are several reasons these numbers can change during runtim=
e:

1. Memory hotplug/hotremove
2. Adding/Removing hugetlb pages with vmemmap optimization
3. Adding/Removing Device DAX with vmemmap optimization.

>
> It's nasty, but would it be sufficient to simply emit these numbers
> into dmesg when they change?

These numbers should really be part of /proc/vmstat in order to
provide an interface for determining the system memory overhead.

Pasha

