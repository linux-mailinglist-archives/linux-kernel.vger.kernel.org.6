Return-Path: <linux-kernel+bounces-408345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C82719C7DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594B91F22291
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35C18991E;
	Wed, 13 Nov 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xUcVOnYv"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA96173347
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533416; cv=none; b=PNHXCkou7/c0vO4gUioqY4g9fXcHElCrM1oZPAGDhIENt6EZ72hgPQXdANfIvRjUPEbOt0VbyHzxarKJaWl1YjbcCL+ZtnizScJiZq2V6i6ydKCpP0rGqLpEgdXaEx/DVcnMVdRtwdugOoXWqGPQlmpI9jqCD809XidCZo1EQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533416; c=relaxed/simple;
	bh=MzhtZC+sAdW7ocxyjFe6HCYuMm4W7Ffa1+WZAqkv7H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSxKjZmKhbF+oIfoAqmzSUlvJnai28K/BjJ5s7Mc20c+yMoQhZfanJ2oQRvalYwgINQ/SN73sXJfLj5zfuWCvgjvunjph2VZC6N0R4iAc1zsrOo+crjm9Ypme77EyJB/RjS3y7p2/HXDiBeIMM71aKWbcIndpBZbXlDk3CJ7h14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xUcVOnYv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b152a923a3so476255285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1731533412; x=1732138212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCnYVFKewS6JOBSJeC4//MFSscRrp4qLeEy2x7eJ/Wk=;
        b=xUcVOnYvQL1/nGisxRRqZXDyRfEiukAlPGrJHc6UUVlZ+/gotDBKxrVjfk6GHN2ctU
         IekKZPaLFdnsY7EN/me0Fx0pZKzvSkY6KKOJusPltXbaMeEajqpwyykm3Uxqo6ue25aG
         AiNAdS4KB2CcMHhAsWZvcLQjs8xMb6N50RrJsM9aH3Yhs/YYRN/iwY3LqYHSdWxTnuVS
         ekUInn0JvnMt2FlZ8eaNMESeJp9cNFocfiv4gZncVET45PIT/DAfSm4D8SwtxLUaYQNL
         bQQJZdmH/vLlfAsQbpeT4z0f+mupzutMQUl6yBXvsnpfOBX+N/92TKhKd/MhIIIdWyp1
         c+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731533412; x=1732138212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCnYVFKewS6JOBSJeC4//MFSscRrp4qLeEy2x7eJ/Wk=;
        b=bX9fFXoUBZhriSH8iU86Wrst+eoE8le0HkI3b4jTd1OxVrnhKjaWQcanOUDAE72x0L
         10n/JzYWRaUj6I/nBL4Ed6yCks/HFEcMwhQ4q/np1I7xM+h3mfwnWaatLLJpo16YH2+L
         dVcSvaarR8gQDeCuN/glGzKQ71GPbrE4nf+DWuZsjRRGctuHMQtdzbfMXk1Mss7JYNA7
         7WBNzAKDHNIhHAjvswha/FM4TGa3cN9O6fyGwSUxVCDNV2gHkuq5EL3rMTfaM1lJzQFH
         9WdjhWsUtOzPCCf3W8DtpMJYivDa5JtowetJMjPRZgLbHe/dg4OizLjFiWizHOKfZGYZ
         /ZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXhJDfAqrwBdzLYyEAbtysCjqM6t1c4RUZPDYxSSHIluiJT25ryUNrsdG24e5yOa2fFZEoRaLaZlEv1ZeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZRltbh8Vtw7Jpm0xApI72QOeGQPsnAEkEdPrh96wsUsdIa97
	bWwAvDzhIAWBNZFUcibDTj//DzBb64uNH+uwgfBbOHZv9iu12X+lmZyMAuiQCxM=
X-Google-Smtp-Source: AGHT+IH2O/cl1hA6SnZJKdkbu+3Gecehn6ueBK7Ird4RKYUmg+/r+YehH5EkU1eCHlz2iVJlS5risA==
X-Received: by 2002:a05:620a:31a8:b0:7b1:522a:b07 with SMTP id af79cd13be357-7b352a00c20mr512252285a.61.1731533412355;
        Wed, 13 Nov 2024 13:30:12 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acebc86sm731538185a.118.2024.11.13.13.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:30:10 -0800 (PST)
Date: Wed, 13 Nov 2024 16:30:07 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Message-ID: <20241113213007.GB1564047@cmpxchg.org>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>

On Wed, Nov 13, 2024 at 07:12:18PM +0000, Sridhar, Kanchana P wrote:
> I am still thinking moving the mutex_unlock() could help, or at least have
> no downside. The acomp_ctx is per-cpu and it's mutex_lock/unlock
> safeguards the interaction between the decompress operation, the
> sg_*() API calls inside zswap_decompress() and the shared zpool.
> 
> If we release the per-cpu acomp_ctx's mutex lock before the
> zpool_unmap_handle(), is it possible that another cpu could acquire
> it's acomp_ctx's lock and map the same zpool handle (that the earlier
> cpu has yet to unmap or is concurrently unmapping) for a write?
> If this could happen, would it result in undefined state for both
> these zpool ops on different cpu's?

The code is fine as is.

Like you said, acomp_ctx->buffer (the pointer) doesn't change. It
points to whatever was kmalloced in zswap_cpu_comp_prepare(). The
handle points to backend memory. Neither of those addresses can change
under us. There is no confusing them, and they cannot coincide.

The mutex guards the *memory* behind the buffer, so that we don't have
multiple (de)compressors stepping on each others' toes. But it's fine
to drop the mutex once we're done working with the memory. We don't
need the mutex to check whether src holds the acomp buffer address.

That being said, I do think there is a UAF bug in CPU hotplugging.

There is an acomp_ctx for each cpu, but note that this is best effort
parallelism, not a guarantee that we always have the context of the
local CPU. Look closely: we pick the "local" CPU with preemption
enabled, then contend for the mutex. This may well put us to sleep and
get us migrated, so we could be using the context of a CPU we are no
longer running on. This is fine because we hold the mutex - if that
other CPU tries to use the acomp_ctx, it'll wait for us.

However, if we get migrated and vacate the CPU whose context we have
locked, the CPU might get offlined and zswap_cpu_comp_dead() can free
the context underneath us. I think we need to refcount the acomp_ctx.

