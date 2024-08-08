Return-Path: <linux-kernel+bounces-280046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489594C504
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4583F1F23899
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064814E2E6;
	Thu,  8 Aug 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="nfTYu4hZ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BE23398E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143746; cv=none; b=oj7vo0NPmDRgmaKdWO96VLCqTywlaPVzoT/KNB9Xr0hh2CeMFKVquY0X4iryVGoZS7ThGnbiSQCpx3HVWOhSYaxgimkJiTeFhKusXG8V72i2nTYZWB33rc34mCYkxvO8VJau8oawNCoUooq2zOKcmMT3y2sBQdPt/LA3t6G/yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143746; c=relaxed/simple;
	bh=Y65uf6qqSRpIHJ9WMhbwfu83kOfz3UXQcvs4i5JT3n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXpxMBuvEjpORw3VTho81WG64NUhY+UawRCK08V0dHJ+IDc51Q/K8+PKK7JQT1jQrBtrDa7Zkcpl1jER0kaXQYFeoAwAs0Tgt47IU+gTcE37gR4B2Jekjie5BD8kjFNGdeMlA7Tgu5D3wDMr0czw5humruj19uCGuUkERHZTLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=nfTYu4hZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44fea2d40adso7367271cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143744; x=1723748544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y65uf6qqSRpIHJ9WMhbwfu83kOfz3UXQcvs4i5JT3n4=;
        b=nfTYu4hZnfFfUGWky2YK78XbUXlSvJb/1z1AjDVDVh8s0rtD049OBx1WHvV6bF5NVf
         B9VsJkcSob8UFSDdAGsq2H+0RgLPssBItONQN05gmtS+kcfoqtqgYHxKy9bY5d61H4uF
         qPXDjnLT2jXsus2rV1Qs6kviDvE4qRCfQ9td9G9A6lmznqjZ+1QQnu8CgLfEXwL+A3U6
         5bHzzlWOXOwRA1cN/WdXdIktAt+KJvrSQAoRrrVft/MqD3j10sRuWz0m2V+4m+xUmbzC
         WxSbfhN25Umvnughuxfem/ur9qDHIXnTx7ioxvQWdI7a/z2g6P88RF6ZR56Hj1rDPq+P
         onlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143744; x=1723748544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y65uf6qqSRpIHJ9WMhbwfu83kOfz3UXQcvs4i5JT3n4=;
        b=xJAam7gFfFlN3o5EmlvMp9XUyYzLfygcmbS+AYri7J4pmVHa2eB59Cx8WFeGh6XMyW
         2AxpLihgkbyMm+Wykz0SofkEkSHdYjVQ8uKeOu0ABNPJx9oYuRkmJjGAftdkEEXbY0n1
         HCWMuE1HvXpYCTnMifNuvd0VRC0uD5TJLjy1LueI6YyJo8z9y0+kz8XivK6FbKW/7k4W
         hP96PyccSZRYnzD6a9YvxQ8Xm2ZhfKSEn4gYynYb1uy40sGF3hDkIUwT8cTnLK56gT63
         RDr34j2fAWbgyWOQh0n3AeTDcXvk6u46AV28WTDQhowHbXmPuAuF1mlhlyqtZ8TbK7fP
         z2CA==
X-Forwarded-Encrypted: i=1; AJvYcCX+z3u1ee5+GYecPlGG5L8MZOMmgvroSJwcHlw/8hWVG0IwVgcugYjBivVMXjI40aB6JEvSNyvrGSNf0Rsh4304GDIsjxiKqaVvFK86
X-Gm-Message-State: AOJu0Yx5J1fXvXmlPDzyUvWCc2kY7yP4+bgVkDorfcoqhWH14KqmLaqz
	+xiiRHWXbdZLRwmL93hvA3m15hojLIpWJYnduJTfOKV2obJbjIB1Fui6iB7XtpqJtHXaSE9SBgt
	kudHPLHWsEtlACs+pyoWQmkbSMbzbsk0Tbf7fJg==
X-Google-Smtp-Source: AGHT+IExI0OeHf48EBthOwkTI3aIjxBBaA3Ik679zCw1G8yDECFvltEArNPD+bABqbdLjI6o0QR2sTPYH07apAlR/WI=
X-Received: by 2002:a05:622a:4a0d:b0:447:eb33:410d with SMTP id
 d75a77b69052e-451d421cefcmr36717101cf.18.1723143743702; Thu, 08 Aug 2024
 12:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-4-pasha.tatashin@soleen.com> <9cf6cbc1-67c0-4ae5-ae5e-5033631e61b6@redhat.com>
In-Reply-To: <9cf6cbc1-67c0-4ae5-ae5e-5033631e61b6@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 15:01:46 -0400
Message-ID: <CA+CK2bD-8W7AP+Oedm0m9EROQZ4euLjZBhqaZJARLW02HWd6iw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: add system wide stats items category
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

On Thu, Aug 8, 2024 at 2:20=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.08.24 17:42, Pasha Tatashin wrote:
> > /proc/vmstat contains events and stats, events can only grow, but stats
> > can grow and srhink.
>
> s/shrink/

Thanks, fixed.

>
> I think we discussed exposing this in /proc/meminfo. There, it would be
> much easier to simply have a global variable, print it, and be done with
> it. Like we do with TotalCma.

Originally, Sourav had proposed adding per-page metadata stat to
/proc/meminfo, but it was decided against, because all the other stats
in /proc/meminfo are part of MemTotal, but memmap allocations are not
always part of MemTotal which makes things confusing.

This is why it makes sense to keep nr_memmap only in /proc/vmstat.

