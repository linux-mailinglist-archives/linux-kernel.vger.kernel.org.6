Return-Path: <linux-kernel+bounces-367139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E099FF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA222284823
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF73E165EE8;
	Wed, 16 Oct 2024 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvYNGedp"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3C14F119
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729047283; cv=none; b=YY2M8Jb1MkZsxqAVboxmVnNW9wDtUlAnG5728dppk1HpZiKJuQDDZtwVpQYn/hnkvyd1X261k3V1tNbJFZjzEPfLHc1tyMDPMCjRM2p8v0/V58kjyTks6bxpCckXY8c0bzAr4z8kPNPWdX7KO2w5by9i9fyRMQj4+yLjMM/qk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729047283; c=relaxed/simple;
	bh=pyowq4cA8SE74Bj83YoZG2Gb86fhSsP0ELDrO57Pd/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omaX86wBphGzAlDT/nrR7Q2icotBVBZ3SbWMiQo5vv30wku5ZccIdKq275EqHlUn+FegridKa7hDIyJuJ4cJ4kKnIHuPWBHEd2KmMeaK9Xo6YEi3682phr4nFBNYylJsl9vZYnF3PUPfg6wNXxXB/tjFC9vZg8EyxCMNcdg6OW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvYNGedp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e72db7bb1so1524325b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729047281; x=1729652081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjSsM4u+z6T2URO29UDtPAQtkW1WFQpe0IZh8Z0p97I=;
        b=YvYNGedpTJKW5pHD0vSu5vB2vBDQTHfdApGwmvEv7RkhapB3KXknWZiacfZzdCt2bS
         AloxxTYa1RL5yhjsJl07XuM0x7lA7dZw2XWJ72CnLYFbFPSiBgeoIJ9CiUxjfCczATrn
         eyGUJqodpqFVd9SMd0ceSCDWEJgwyziuJInDUUIzaC7S9g2chbCpermuUMToJmiQ9saS
         tK9Gwjej6GIGAm95MKS+k/bVJiqB8UfkkVn/lVwQ5B3ta7XdPAbXzXW6KUZMHecBZbCx
         dFYn/FsyPjAEbyGdI31TWCE/oFAXhie3zB6j4pVHq/RSVTMOMP9ZSpljbHQXs0z//HVa
         tn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729047281; x=1729652081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjSsM4u+z6T2URO29UDtPAQtkW1WFQpe0IZh8Z0p97I=;
        b=V82yoSCZEVu1W59KEMcdJjneH5QZJyl5ZCS+6k5hCcknTrjPrpPk8DwH/JO/1lR5fD
         Lo5Mjmr4wnPy7OWlWIgow/kMbOJxwbNrXvIGKLiGtxPu2rSQ/j1l71lQI5y0e+zjjUaX
         96gxxSITKAjZTov3QYuusb63yXfyt+HFQsDYbAy0qz9cn0pTlH6iKgY0aRxCaDSIVpe7
         awBuCQQgpvkNnIM6rMRUN23W9SfJHameyD3Y8YGzt4tUQPRYPaCM6zbtf4K2WW12T7/2
         Ry00MethyBQXuxEHjAGsrcF7f1ZD59VZSVMTXM4O2rHmTwsLZEHNVe7BZ2jQFsnUPyVr
         WQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUI9jAG7Okx1xHKJcky6zV668FTReePue8cN08Zb2kvLvKqS5zCJ+NJCl/5qYSQ6jWDMrFZks5Qr4my6cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHt6ptZ0a0j8vLtSo7lUvYUept4GZ0aB9gI019yekH5N6BW7T
	DNAHk2JqYb35+Vu4f77caa6Z5xfKjDtBvIwqJYVOOcics9X28aC+UOjUa622
X-Google-Smtp-Source: AGHT+IFw7m6WgIryfgceLSDZkZOVayiRbDMwvS2C3teHJC2sgvh3Ey9Pd38bli1Qwsnc/LydWObHjA==
X-Received: by 2002:a05:6a21:e86:b0:1d9:2a8:ce13 with SMTP id adf61e73a8af0-1d902a8cf6fmr3988461637.24.1729047281282;
        Tue, 15 Oct 2024 19:54:41 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:e037:6314:f5c6:369b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773b1634sm2080937b3a.63.2024.10.15.19.54.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Oct 2024 19:54:40 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: a929244872@163.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	fengbaopeng@honor.com,
	gaoxu2@honor.com,
	hailong.liu@oppo.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lokeshgidra@google.com,
	mhocko@suse.com,
	minchan@kernel.org,
	ngeoffray@google.com,
	shli@fb.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	yipengxiang@honor.com,
	yuzhao@google.com
Subject: RE: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon folios
Date: Wed, 16 Oct 2024 15:54:30 +1300
Message-Id: <20241016025430.4864-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <014f01db070a$61976220$24c62660$@163.com>
References: <014f01db070a$61976220$24c62660$@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> +++ b/include/linux/mmzone.h
>> @@ -434,7 +434,7 @@ struct lru_gen_folio {
>>  	/* the birth time of each generation in jiffies */
>>  	unsigned long timestamps[MAX_NR_GENS];
>>  	/* the multi-gen LRU lists, lazily sorted on eviction */
>> -	struct list_head
>> folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
>> +	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE +
>> 1][MAX_NR_ZONES];
> This also divides lazy free filio into MAX_NR_ZONES generations.
> The gen of a lazy free filio depends on the gen in the anno list before
> it is marked as lazy free. Whether it will happen that lazy free filios
> are released in an order that is not consistent with the order of the mark?

No, this separate list ensures that lazyfree folios are released in the
same order they were marked as lazyfree. Note that any newly marked
lazyfree folio is always placed in the most likely reclaimed
generation, regardless of the list.

static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
{
        long nr_pages = folio_nr_pages(folio);

        if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
            folio_test_swapcache(folio) || folio_test_unevictable(folio))
                return;

        lruvec_del_folio(lruvec, folio);
        folio_clear_active(folio);
        folio_clear_referenced(folio);
        /*
         * Lazyfree folios are clean anonymous folios.  They have
         * the swapbacked flag cleared, to distinguish them from normal
         * anonymous folios
         */
        folio_clear_swapbacked(folio);
        lruvec_add_folio(lruvec, folio);

        __count_vm_events(PGLAZYFREE, nr_pages);
        __count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
}

Thanks
Barry


