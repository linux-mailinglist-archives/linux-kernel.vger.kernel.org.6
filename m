Return-Path: <linux-kernel+bounces-280047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C394C508
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208F41C218FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D914E2E6;
	Thu,  8 Aug 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="LuCI0TzI"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C333398E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143832; cv=none; b=eO/KWzYKROU7M4nNVPi9CWGe3hh4IA2WQSP7XmWnJKD3iLGbRHiRDwwYmt4bTLXgY18ERINcOMEhvWRZque+7NzJKaQR/UpEoqRgi5zyrltRdcqWFbZNP+AIPc/tB3zQCgTgp1diU2TkfOIvyFwN3ltIciMSKF1CJW8cuw9fwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143832; c=relaxed/simple;
	bh=wF3eSR4he3cxhVVV3Kr41yFivYxoCdqFCJsVBQ+Ik64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em0KxkYJrhbYfqGqanU2YRSOEYZOoleRcd6uAe5CjnreIPq73SW1xJtfJ8QJcy+Vn1tps9KlB83e2BJ0Hzar9yNPHeTvwG6Icm3E1H5DqsV4dRbVo/S7OcEkVD2seAZ84bbDCOX7WkawtNvoKD11J1Gi75q7NsfXK2oCxEWzMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=LuCI0TzI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-709428a9469so820503a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143830; x=1723748630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJD3NMKxCdaaPWikegeFRbNee15HLPMi9fn1KjdIIdg=;
        b=LuCI0TzIYnGBrQBHuB2jfaYrUf8Z7BIvdhAdr1mpsTm4PwU2/0BCLqa7HaRFRLb886
         Lp4vL77TCDYetKC1d6XW6cUZzDc6sSRfGkiY17LauCiDaJ34bRikYQc+SowUj3MTYas2
         w8cyBc4L0irl7gnyGfrUevtuiQIwlGD6oRs1v6aPT3SM5w9DJ+f3c/P26v3H/FIxcMdk
         f5OOq7HqzLR9nhzV0OJFScPVN53q6M7pA0iZPnx/k+E/NOE7Xv3YDsSddkOM8HN7VHbV
         z1Xyc2h4+oaSRiifzh13dNvpMYEQppjwqs6aJLRIdOttwWtk5q4wRVL/RWTf/cSUiGIX
         BhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143830; x=1723748630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJD3NMKxCdaaPWikegeFRbNee15HLPMi9fn1KjdIIdg=;
        b=r/8sdowZOu+9273Pv07pUxLRpYT4R01Tg+nom7bND7AwXPgw/M11EI726xpSQJFDLH
         qIpbFlyBqVrrynfRzjSAdiglawKT62OHQ8FZXmDXICJ2nwddYXUFseWmdTiRHhC5lHQU
         99ESGNB0hZZR9DMCTkYtAtBlW3XXIplnZ4FQPUxOPWInGyhi570lIuiSBeeAaFrFKIKV
         yiROzXmmCAUKO0LeTWA7r8UwyuNSFR94sYE17luMTWF6+ORUnnvI9Cb57EUxzJpZNDNT
         5EhKudRVv81eay4C0m5s35B+fPud41TWBWMpAWaB5r2OHgvkta9Y83q8kK5mH3XSornI
         7y5A==
X-Forwarded-Encrypted: i=1; AJvYcCVKgRl4AbBfDttIOS8WIWZsnmIK8G87N3P1+bsfOXegleXex9+a3tGHGqQWrmC29Q3SgRuzVwgnXo7dVK2a8X5+LbN0pq2silXtJEhd
X-Gm-Message-State: AOJu0YwqeJOZVGgVeRmwXH2i9xKbwmBjgp7QricwNd7ZgQqW9V6wQATF
	hX4HMmnZn5P8Z/yiU7j5YCdWiMbrLeYOYP2lhtWw4P380PS7YNJwzt280kldN0fA8919iYt9fpz
	r+ET6bUS+nowlt+7UOUIQ1x3TFDfVBZGFyrcQDQ==
X-Google-Smtp-Source: AGHT+IEQca1KIhdNSUI2/4IjEdXBF2eDVBstcisCNWacbs8Zj90oeDvngeCX/YUYlKJXyS6Mli9xj1i7zvInvyLokXU=
X-Received: by 2002:a05:6830:d05:b0:709:4578:8e06 with SMTP id
 46e09a7af769-70b4fc266damr3494134a34.4.1723143830208; Thu, 08 Aug 2024
 12:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-5-pasha.tatashin@soleen.com> <490ae360-50a4-497f-b148-ef077b73e911@redhat.com>
In-Reply-To: <490ae360-50a4-497f-b148-ef077b73e911@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 15:03:13 -0400
Message-ID: <CA+CK2bCxRimZFZkL0CdNhuqD6RmWM6-X3c8+-sUX6NGHn3ULRQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: don't account memmap per-node
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:26=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> >   #ifdef CONFIG_COMPACTION
> >
> >   struct contig_page_info {
> > @@ -1255,11 +1272,11 @@ const char * const vmstat_text[] =3D {
> >       "pgdemote_kswapd",
> >       "pgdemote_direct",
> >       "pgdemote_khugepaged",
> > -     "nr_memmap",
> > -     "nr_memmap_boot",
> >       /* system-wide enum vm_stat_item counters */
> >       "nr_dirty_threshold",
> >       "nr_dirty_background_threshold",
> > +     "nr_memmap",
> > +     "nr_memmap_boot",
>
> While we're at it (sorry, I should have found more time revieweing this
> earlier!) ...
>
> What is the unit here? Should this be "nr_memmap_pages" /
> "nr_memmap_boot_pages"? Like
>
> $ cat /proc/vmstat  | grep pages
> nr_free_pages 3618323
> nr_zspages 3
> nr_anon_pages 1053316
> nr_file_pages 3199210
> nr_shmem_hugepages 546
> nr_file_hugepages 0
> nr_anon_transparent_hugepages 0
> nr_page_table_pages 15215
> nr_sec_page_table_pages 0
> numa_pages_migrated 0
>
>
> Nothing else jumped at me.

Good idea, I will add _pages

