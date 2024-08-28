Return-Path: <linux-kernel+bounces-305417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE1962E61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E60CB227E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8EF1A4AA4;
	Wed, 28 Aug 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL2Bysw1"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965814600F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865839; cv=none; b=AAlxJdoN2XPUi1/TvR2eYDEM+G5nQkW35c7fsJNXgXLOtk4ng43JWAQ81DXYCzjlyEhV1Dm1DYJhP4/zhvprp9wnN3vnZ6xriMR4S6uCwykSOje0bWqFZFdeqRnq8bzLY/quuE2Ahw+hgs2xgh9kpRuEcmsB14F1/rJhRKXyAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865839; c=relaxed/simple;
	bh=/M316tAWTLKcKxE7gxJM5T7FJXnafUqOPqYP3sEf3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US8fcL36utkYwuMRfEPa2kyyEPwax418FOWKBrhR0D2srGPU/BZpPoISs5hOYH7Ijcl7eCXS8UzrDTM9Xs4KiXRA711dzpN2xbaXrphmbRnx7hE46EclLXTtKv+NLtaTmqNAF7oPMp6h6mJFXIX14CompsmSHF6kEKNkXnyswhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL2Bysw1; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498db1fe5ccso2593026137.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724865837; x=1725470637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M316tAWTLKcKxE7gxJM5T7FJXnafUqOPqYP3sEf3u4=;
        b=WL2Bysw1GpiFKJ+XNKCHQnAw0rL6c2iGTtv4HmvK9ursqHv4WSFlh67v2EFbTQK8cq
         sBgQyk7T6Ta6oTs5lvB2DJWMSRSzBOG9O8FLtGZgHRU9AHr7WjFxUefWYpdq5VCGqGxs
         AGY0/fOy2p5f/zpjHJfW2EzpzecfdXG5QoP7tqmSOWxwDTnTmOCfX8YoMAfddhRQ3gZw
         G6PqO5B+MmYZnUavIqzyiyUURoqM9B+ezXqUIYeGup9YMEC2tAXd41ZojlVeu2c9dK61
         ealscFqxXE30Ie3VrjrzbdvYIgcFFXSrj7nwYRmxA++VUsnKc+JWWgXclRt7AsTnEVm2
         NyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724865837; x=1725470637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M316tAWTLKcKxE7gxJM5T7FJXnafUqOPqYP3sEf3u4=;
        b=noMWn813nJCvHCiWgQy7CcPo5PSnQpHB8doHH6nS4b3m4PWUambT7LsmXR0AtpVAYA
         vMjLRztdEqo5Ke+koGmqwx/5vbnlT9AYg2s9uSoiq7jL8Eb06JxtP/f016Kel2GDyG6Q
         MJFhhhmsCq8N6amRwEw6IHPhHQn33rMgMG2gnkzQGVeUqNtysGw7t2gBkJaXxYGbzczN
         DxmBbvh0PEW1LSsZacZUJ/S4AENWNHC8o3KPKk0zEuKCGivVlseQVfHx1szBK8zp8RTM
         u28GfOa7NtJYvgQtLAYFdis2GO6y8qa9qmN5VRdy1L2TKWykWI+b8ylUchKmtLlQ0Cow
         vu/A==
X-Gm-Message-State: AOJu0YzMMxsw36475SKdHTN68+lmWUYDVxLhCSnEjPCaDcHx2p570Z1a
	2wE8Qcwi+lpLqwFFK38MV/CabTdH9P2vdvBsn61QxqdSuhTpwdzsSBLIA2hoN1bDkt5fek/lYmc
	9/8Uv7OplWYqjs9Dj8eowiaXUim8=
X-Google-Smtp-Source: AGHT+IFgrfqwlg2sNamhGIavdxFzUnrCz3NMulWTE2Rwj3zxNY2vmAYPjEuz/Pt11KGDI28TK6MHbmwHcmItqFV/Mxo=
X-Received: by 2002:a05:6102:f13:b0:498:efe0:f91d with SMTP id
 ada2fe7eead31-49a5af35ce0mr576842137.19.1724865836918; Wed, 28 Aug 2024
 10:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com> <CAKEwX=POQzRoiqPSqkwDnVGH=KwyEd_vrW7XNx16cXBaLWbVUQ@mail.gmail.com>
In-Reply-To: <CAKEwX=POQzRoiqPSqkwDnVGH=KwyEd_vrW7XNx16cXBaLWbVUQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 28 Aug 2024 10:23:46 -0700
Message-ID: <CAKEwX=OvmMHANg0xub+SHj3ycgvRRqp=UDGOG4oJs7fnsQ6rGA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 8:55=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> better by definition... I wonder if lowering the memory limit even
> further would show positive numbers? Or

... perhaps with a workload that has less cold data? or using the
zswap shrinker to off load some of these cold objects to swap?

Food for thought :)

