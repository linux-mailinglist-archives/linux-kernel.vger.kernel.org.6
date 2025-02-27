Return-Path: <linux-kernel+bounces-536837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD617A484DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7141D188A2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C11A841B;
	Thu, 27 Feb 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UfpU/5r7"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA18F40
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673180; cv=none; b=KMl4bghorchrKCBTcRVLyQC9+1IHHy6SPGDkX5Ns2E88a0yCVjTHRbbYRN/Tm3l95LF3dfwVzhvjYKm+lLkmZGEgGwYqa4LQ0Bl9rGKddG7AovT3XDj0PfNvaS8Dg0eKkY18XjB2cqSiimOz2ePAHR3LcTPQJdRozt5I1fSwHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673180; c=relaxed/simple;
	bh=tgV1Wb75cir2EFzuzyM5Ol3nH8g2ES/QqY7HVqZ8SDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzzOHYQV6WlnV/phIEefnvTVHNTEQ7AMHilcH4g9pzFM5CSJhhlHRm5R0fFQEPE4vsFnZTHiszF7vDreVmzC2/gucfUeTed2pe8KLyUtFUjSusafa77IWrKlSOo6cRX1BWpCDOoKM+1petwSw0Q08QIblA80rs7v3fByQk/DLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UfpU/5r7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471f257f763so11023601cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740673176; x=1741277976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmwhSsv/XWooEXVhNDscUh2O/fwxCYTE2ewAwwf/PEg=;
        b=UfpU/5r7s6eOrpxTc3aU4juhWwIK7vi3VdF6vafxELbrPKsI3+YrYEVmwh7++Cok5j
         9naU+U5hedVqns9ObVPvYY2N43V4kpaRgJSXjrAHBU14SVWU9/XcmNyCylQYp1WYsUv4
         0vaBthft+6QsGfvNTWkm3yXDod9ibxU6JXK6qhZcVk6xq5yvDM/wqoLK2oyvD+IYjaQZ
         VPCISNdryKW4cMY5mX8IQVmHWi2Kv5yRsxY1VaPp21yqXogzlebvhSGU6kwYvCC3lKgw
         a8jW9CFyR5glskhZdtdOf/zuUawHke6IJS2SkIobgypK9r9E5sEuPJvbITqU6yuEkHao
         Yjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673176; x=1741277976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmwhSsv/XWooEXVhNDscUh2O/fwxCYTE2ewAwwf/PEg=;
        b=bWV4IecS6v1DclSySbnUK5Vo1Yqqfj6ePbl8SAvrKETgoZvdmDMqL5lychMLfzYfAy
         FbVxglnxarwr2Q9PGPTagqyix1yroPr7kYYUEDr4Ig5REtE5vnH4MquNNZ4umO0yxZe5
         e3dACyjf1GcOPIMQ0kjErD6cQ8u/ib9aFaoB4ldVp/vAjE0+S4qvGEdO26R1h6JroDjp
         X1zhVTiVUR8my6StW8LLbBMk3vVA5JmYtf121VTJWROX79VWtNLC5pZRBDRXphmTKNfY
         Deig/4B0OoZv/ruSlSnfwLRso1HMaDVd5yQ4wQl5HNMcPoQfTuMyqrBYAXWbjm1rONZt
         UEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWXpb3rdwFllYO93M5JJXtuAlRtRyLc6T+JmUuzRFbxo1G/6knW3GB/WjjRVq64n4GPgiXuMu5cm4w4sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcEIwZPJ7v0wmIyRFajUZTFaTA+k45Q2v65X6+ff9JkdrudpT
	2Us0oN/Zb63f6eh6fyTTPcQCnHn7UDI2b4i/6zKbkVy2ryzawnDu5WpTgQUuvrU=
X-Gm-Gg: ASbGncvAFfF6dVRcPKr4pKzZbYRz1EvvtIE//TcsxvzvwItpvS0GcdgheIq8WhnK7JC
	ylFnMzcIKnjkwD5smIoZdmFVeOo3IjA+RZFRNJfGwcRlebNyh6spFA0V7VPCnvt4I8HcrXGf1kW
	iIp+0zFSiTHdmbLB5wx2Xm+EKowQwZ2WVuNah59/UW+7lRD68XclJckf9S/zuesGP/QpYvZJDMn
	kWTzIEjZPzGHuIWiYElrTk++ZgeVrSL8G4RetkiVMshgyuTijKuYG/DBKud1umwgBe4ZXZDWd6h
	ZHU00lNCrI2oT1QzyLq1VUig
X-Google-Smtp-Source: AGHT+IHRaHuaosZEAeqgzup+sWlmY+z9YMwzc1/l26fkJ6+wOi0mYWekRfZhL6Q95PpZgS+aTZEHFg==
X-Received: by 2002:a05:6214:1c4e:b0:6e8:9bcd:bba6 with SMTP id 6a1803df08f44-6e8a0c84efcmr652896d6.7.1740673176094;
        Thu, 27 Feb 2025 08:19:36 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e897634a77sm11386876d6.16.2025.02.27.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:19:35 -0800 (PST)
Date: Thu, 27 Feb 2025 11:19:34 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: ying chen <yc1082463@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory
 swapping should be prohibited during the global reclaim process
Message-ID: <20250227161934.GA115948@cmpxchg.org>
References: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
 <20250227155431.2534325-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227155431.2534325-1-joshua.hahnjy@gmail.com>

Hello,

On Thu, Feb 27, 2025 at 07:54:27AM -0800, Joshua Hahn wrote:
> On Thu, 27 Feb 2025 22:34:51 +0800 ying chen <yc1082463@gmail.com> wrote:

> Previously, when the system is under a lot of memory pressure and is
> facing OOMs, global reclaim can create space for the system and prevent
> going out of memory by swapping, even when swappiness is 0. If this patch
> removes that check, it would mean that global reclaim can no longer
> "bypass" the swappiness == 0 condition.
> 
> I am also CCing Johannes, who is the original author of this section [1],
> who clarified in the patch that swappiness == 0 has different meanings for
> global reclaim and memory cgroup reclaim.

Yes. It's been the behavior for decades that swappiness is merely a
preference, and that the VM *will* swap to avert OOM. You would break
users making this change.

If you want to hard-exempt cgroups, set memory.swap.max=0.

[ Yes, it's inconsistent. But it's really cgroup_reclaim() that is the
  oddball in this. Also for historical reasons... ]

> > when the vm.swappiness is set to 0, global reclaim should also refrain
> > from memory swapping, just like these cgroups.
> > 
> > Signed-off-by: yc1082463 <yc1082463@gmail.com>

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

