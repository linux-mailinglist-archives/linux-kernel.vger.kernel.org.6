Return-Path: <linux-kernel+bounces-549474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29756A552FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEF6188BA77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E320025A632;
	Thu,  6 Mar 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sO0KykjX"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916721DDA35
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281862; cv=none; b=sTYW6dzgHjGrE39AoZJvsqtlL4EjI4mnUE76RA8/UMG1bN+sW8QZ1prfiW74GGUOYsyFpQ8P3SvpQ+gCE/mU1KeS33/quP5uoLNAeIXTvd39IZXhxwZuorY9NM/ziYYmI5OKeVLD4W94iySFMkzvps4txUf+8Y5MXkiH/m530fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281862; c=relaxed/simple;
	bh=YV2gLm0cS62bg7Ygbod3Qlemqyl2iSaMiGjNabsz2yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf9gPOl5yUYDUQUrbE5biegLSU2tbhmuXQezvScJ36IbBq1UQLFGgbMvS1g0KyAwY34JmujOdtDglIkKRS4B1A7/wm7mcnE6PAyYDN9ThnpnFMAxLwEbh7Z+eK2bWpqJlX/EDEKUpnnpEf09uZggpyPFGB/N0wrp/iiEwLWXPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sO0KykjX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3ca86e8c3so63377885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741281859; x=1741886659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z18vp3hcfAAtmEVVcfXDfC3uxyD2Eksp5BWnyHJtP6c=;
        b=sO0KykjX9aI8dFOrYH3E2AZ8W3tCIbSIiu26e41641rAoDJ10yALqr5bnijEU9zdWc
         e3fWsSEcQza9W5wW2kJeDjfk9mOw4df5XPzBdJF7jFqesnifAmgeA7+yHPNR+HmrwuFm
         /qIsVhPxnhVNP/ibkriOfXJh2TUozMC4n76Cc/PbDnO/hu5trAdlmZZGP2qg24dib1sf
         MGNyZQvL3zP959ZsemsaUOkdPaL+aiVl9QPw1nUx4KbFd/t3vG765x/O/Z7kNyHCka6K
         PFDsorv4Nz9WnS+3cdKWT7Oio6ohQcPMCnBRFQxCbiXa4qs0cW/5WabxN0HxCFX2JxfJ
         wydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281859; x=1741886659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z18vp3hcfAAtmEVVcfXDfC3uxyD2Eksp5BWnyHJtP6c=;
        b=mSnCASXCan2yTPVQ4f4DxGherHiNidsCYW3yNy+p9PdLCLxrlidFVdNnZ8/yuy7V9X
         CkmsPGuXS5Ja8lqF/haMNcy35OYSZxdzdVe3Wp6zsmT3NqCse9Vg4pvYdO/CnoPPhRsB
         d8rSU8W0Uwm08P8fdcvIMbKWXPEICxpaqXBdorbSv32C17FLvZNVRlkI1ACjOOMXLjCG
         F8KZyZXO84KUZ2knEnQR8PofmxM+QCpaS7a10HQgo8eldYHEEI3gaJWzyLQjqD7dO/Ps
         UEbCVcmcqZQ6O6/sme0IIqAuB7P3Dz0StG7QbC+UzEM3vfXG4LEQfDSGhLgVUTWqTiHh
         LfKg==
X-Gm-Message-State: AOJu0YzAYdEVq9R2OqtjAL/1mByYylyK7Kz6RwrdF3pMDlcFfIMGglm/
	pBwEK76JalTvL7fs/TiKAkoYJB5+AfJJg5SEb4sEsBYNAig5kC4KCHvcpnqiSKk=
X-Gm-Gg: ASbGnct/0atpUDTpEDkBzfEo+V04lOIlf0UwPBFR2sxKdMpAygAsWcyjskJL1V/K9kA
	+ZGHzpCcgYeEl6ICctKzbZG+Y06iIjYHRpPMG5P9y32oAkUwxBv7BOlXIIvPuOUo/+xM0ZzTIAn
	m6Wfl5RoZAZC7wV6VabZx41PULHVEROhVmyonuuohs4rZy/mHurHusu7qmL5/2MFAy+zPgxsKNo
	z17Te9dxNtP+D2DSv3fZeocDdZqOU9D7wifPlWUt3SS42MzNfJP7CacIxwnSZyINgdoCDoiETwN
	sPNJ2WwITZsCvfktfHRYxZNABtIaqGj12HChIX6ctMKHTB+k3DaoJZCeFDzG4E1fCsO1thY6YZu
	GuEUhu8zZVG4TGHw+ZiXE2UEZWc8=
X-Google-Smtp-Source: AGHT+IFaFQB0dxvzjPDAo9vpuiTrMUPugJggFt79Bts/b9J4+miCdW3ZQGREV91wxTs7E1EhXUvDkg==
X-Received: by 2002:a05:620a:28c5:b0:7c3:d969:c725 with SMTP id af79cd13be357-7c3d969c792mr1141025985a.5.1741281859209;
        Thu, 06 Mar 2025 09:24:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e553df80sm113353385a.116.2025.03.06.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:24:18 -0800 (PST)
Date: Thu, 6 Mar 2025 12:24:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Bharata B Rao <bharata@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com,
	akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
	feng.tang@intel.com, hannes@cmpxchg.org, honggyu.kim@sk.com,
	hughd@google.com, jhubbard@nvidia.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
	riel@surriel.com, rientjes@google.com, rppt@kernel.org,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	yuanchu@google.com, hyeonggon.yoo@sk.com
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
Message-ID: <Z8naQNirs4HfTX0O@gourry-fedora-PF4VCD3F>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-2-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306054532.221138-2-bharata@amd.com>

On Thu, Mar 06, 2025 at 11:15:29AM +0530, Bharata B Rao wrote:
> migrate_misplaced_folio_prepare() can be called from a
> context where VMA isn't available. Allow the migration
> to work from such contexts too.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

I have a similar patch in the unmapped pagecache RFC

we may also need this:
https://lore.kernel.org/linux-mm/20250107000346.1338481-4-gourry@gourry.net/

May be worth just pulling these ahead to avoid conflict.

~Gregory

