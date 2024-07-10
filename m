Return-Path: <linux-kernel+bounces-247081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083192CAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E953EB23F25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A06F31C;
	Wed, 10 Jul 2024 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpMW98EQ"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABA1B86FC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592601; cv=none; b=O8aQg0p1UZF2SQfbjl2AxZltIPYf7Ol6AdcidxaUwsEuWNSMOMllQSEOa98qiKeqN8uec2fsWrrCD6S8zNV550c2IxYQ9DWsJGYN2I58AXcanYeJ39MuKH5sHS/j5ptbn3jcmFJNX3grViANq6JP7W/Ui+HgkxDkWFJ5jNgyZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592601; c=relaxed/simple;
	bh=wVEF8y6xZNB+oKDSE8R24T0vBRM1iZVrY0XO/xNh7GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAQvCZBLtrjudGgN6tBkxlWTx6RsW9uJuljsVCiXSjYGud3Ut85rnWrTR96HOiF+CRJGtzU0twtSY/yUbMXj/kMsvjm9/oox17FfQA/znIVPx2vTokYKPRtPO+8Geje9t/ji7gZv0IDPcP/w4I00rtOjAaPIYFs2CZ+NFmu0aRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpMW98EQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447f8aa87bfso260131cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720592599; x=1721197399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVEF8y6xZNB+oKDSE8R24T0vBRM1iZVrY0XO/xNh7GY=;
        b=DpMW98EQy8tSnfw1iOOoleZ1mdBAmmwCE7jvPp9+UXfATRPH5KgZ0mZJVRW/rg2UFb
         zyUJxp7Z75cOPx/QlAA20QxL8GlKk0FrObIs7rgfFK2AxpdAnF729a9MUEbgALuKpdyV
         qmZyAP0wQfFLguAI0VnP7s0Lvx79jGJ4t58o8O/6zq0Q8Er4sTGDx08wOFGePciefeH3
         0fnWMM2g6xvT9LN0lSgY/pMKmqf8/6eHnnMez1Y35pPb+yNOIQ2pkzwanYd8fzFDr+IX
         fV/jjQWU3QZxqXLJOk/QlDqUUc/rAbUpI1VB+bLA85HUm03Jf1Wkb+wYwAH9+QK5JeYD
         35Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592599; x=1721197399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVEF8y6xZNB+oKDSE8R24T0vBRM1iZVrY0XO/xNh7GY=;
        b=oSEjGQLrJWdVKsRJp0Edr58Sg8IWsS2zUWW2y7HujGlx4tDMlL4QFmdvBgM3XRPmN/
         SnxQvbRzUSRMS/dBeSAWWyWz86/AVozAKkfIZ+B1qsWw40LVz8wbDvDCVLASLb/xwK/e
         yqMkhfwgWY5zEMnz7qGy0ZGSwb2X/yfw9ArWLrjmNCx7skut5TSh4gnPxE59TC4VReIH
         +0dDlOgCdN299f56jMU0/gqIqMzQ1K+awU7rm33zJkM0TiiElFjeEwfsckm4R/4dRQdf
         zxrQxd0iqbWiuS3fCRD2zX4szt6lIaqnVURHtkQ6Z6jj76lK78t5gnx/ZN7ueGX4nD9i
         pTww==
X-Forwarded-Encrypted: i=1; AJvYcCXBg9yaRYRZztX30WbCstAUj0OlsR8nznZvvZHC4k+Gpg/jf6BN1G5WI/7xKcKMqjbSD3ahFpHy7qh9r0uNXgM24YTMScO7N+mfs8qA
X-Gm-Message-State: AOJu0YwrJyyEMgu9cFwkjg07rhb+eW78BiLPwCKxVl2eXDZXjxYBntx6
	gauVjh/L/0XuAwJ3lVbTc0qG/LLF8fvkZejIVmY1QEG6BIFyMkLrybsJg+FK4W3Ktaow90gEEKx
	3eoIA8YGSzdpfkydU8ttP1U4J7MTFlCjf6GMG
X-Google-Smtp-Source: AGHT+IEO2hDzsb7JZgkOy3SSJpcUo7AcmhmbVcZB9D8ZLb/iEgICdqvaoNFDl8Ja4olFYV1ZNcgAvovm39xOVF1n4t0=
X-Received: by 2002:a05:622a:8014:b0:447:daca:4b25 with SMTP id
 d75a77b69052e-44acee81c74mr1902151cf.28.1720592599073; Tue, 09 Jul 2024
 23:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407091001.1250ad4a-oliver.sang@intel.com>
In-Reply-To: <202407091001.1250ad4a-oliver.sang@intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 10 Jul 2024 00:22:40 -0600
Message-ID: <CAOUHufYdGbgnqNprKVUH8woMR_R5Wcc=281vcmm3+NRO-=+-jw@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Frank van der Linden <fvdl@google.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Yang Shi <yang@os.amperecomputing.com>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:11=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
> Hello,
>
> kernel test robot noticed a -34.3% regression of vm-scalability.throughpu=
t on:
>
>
> commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: fi=
x race with speculative PFN walkers")

This is likely caused by synchronize_rcu() wandering into the
allocation path. I'll patch that up soon.

