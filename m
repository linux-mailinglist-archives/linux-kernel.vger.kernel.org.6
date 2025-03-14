Return-Path: <linux-kernel+bounces-561514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C262A612EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A614E3B5160
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5B1FFC5A;
	Fri, 14 Mar 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DjoS4jAY"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19981FF7D7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959757; cv=none; b=qjq6K/PGf+5VltKddJYmvPfMIqqXiDAycEMEVnln3tz9YtKPYs4spEhXk9uyq58ZTcndSvsmDwucQo93rLL/zqh6oPZhuPpNHLos1hIsv0+6FuW3o82Y4aoUyEkOW9g2Sn6E6pz+dOo5hnoKevevcrsbbL/41VOtniaPcsvCBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959757; c=relaxed/simple;
	bh=9LDdxVMmfAwVLZ75Sv27qRjzqf3Pi98p73DWbKx/oMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo+mXvXnV4Wo7K7kaC/4luLZpSXNvxByg+zmZd6tmHPPPm93EIN02bgL/9oTC6yDTsQ/LXVvAldxYR3lHf8Iq+7n061W6yxcRIgZPSKUfCrkwOUNMp7KNOxMVg5bUaMFwQuRch+N+3TNdQb1T8m1u8yncXThFbj90YTRrCtaupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DjoS4jAY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fb83e137so18444556d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741959754; x=1742564554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPmTde2UkY8hmMygpptvq6ZcJy0VG5G4ypKl+rd41pc=;
        b=DjoS4jAYysdPEWX8EnRiWU0K9Mw4/k1fDmqhapb80Kg6ktkJydlDzOZtlBlKDOf433
         I3YH6bcHwcBohTTSS1rxn+gdBkffL7VJdVpNRwChuNSER8iyzt/ctrOlCou0dXAcLnlS
         yejrp7BUppDmnN4QvwmEY8o0gesX7TQXkkRWgcFAl8eK+2SZJTZGGsIy3rig3iLhHoy4
         6WlLcBdVRv26+vvZtj3aHRqesyFAdL9ZBfyfZGSc4GhDGdMxDtWHylSNt9N7HI/rmnKG
         zYiueTMT1gA4tnzlsu89xxfv5XF5/H1ndaQP/exQ3RLY7CBWKvvR+NKBK+rP8m9jVQtm
         iJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959754; x=1742564554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPmTde2UkY8hmMygpptvq6ZcJy0VG5G4ypKl+rd41pc=;
        b=eNmBU4zqct+Hjcc6tzTJKmY7PgRVNXIN6nf0ksUmHhvd5z7IiM8rqWU4r/uuF8imdq
         2IfTwByu8ESiKESQYyBE5SSaiHTVUFx0/UbS6uWYsiCNX/JFeia+vUUepozcvH+N/+Xh
         MeuyA3koj+AVxNjnoDJ+JHEeba0XR2DwflQtSBm0KzHHg05l/PVRqkEOpcW5EeTGIZqm
         yVwIWXGGn9Y0wnSuyUm8vO1WfcgH7HWYAchHfm2kgZdbWDr07BopRMcuI9hqvIVZBwNu
         2jBrbi1dZXRRuXkCCvqhb/ofgE518JFPfQ5HjdXlTF6QWGwFXJT1tZ7F7DqBBA6frqUM
         QLOg==
X-Forwarded-Encrypted: i=1; AJvYcCUD4SQqBGbijnNMiP6V0nQGJALU+VH4VP7bkntLvChWvhbRVfCwy2jhiDf2j0QpMDiXGj6BiHYRKr/QMYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyAnE8B7EZx4uVoRDShn2nQky+JnE1WXTo0BNuflfQGoXicV2
	xMEgMfFnGnEwniUMKfDNS6n+A6yTo2LWxeT3++mYfEK4FTK4nPOxSrsdWsHdQVQ=
X-Gm-Gg: ASbGnctsgkgfXIRmBogoxrhQHR74fjJEjntoce+XT3+DILz5wm/SFTPOWR2F2Tt8+Lp
	qVHjffvobYYjnDBdZquX0fCi3ag1p+bD9ViDQo9vHZIQQKf72iNpugPCU7Jvr1/3SO2DohMQnP3
	nwlyfLzojJkOr5oE2J60GRqmhO4UJqA6KvteZuZxs1ah5xZ6Bdu2tkNODzReX8RSD3uGYCq6pff
	43PB5/zaznwa+XYUWLxGBsPl21tEpRXozy0RbIVWlUurrBI5PS+WO/fJtvdgyh1u6TBqi6q9gVP
	Axt87n9MJ9miJRqwaoZJNc91ytRHggA7lpnf+yHgpH0t1HErqU6fqec1W5SCWrpSzmWfryxmiUM
	7tfdM5e9LdU/107fzQuDE8xWtWdI=
X-Google-Smtp-Source: AGHT+IGPUbrzvzxuTFoznGJ1NMG5BctIcsuLHRaOHo5xqKBuPTb1ZQUOrATYZjhY4w0Hpk5vfoVj8A==
X-Received: by 2002:ad4:5b8d:0:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6eaeaa98f3amr36986026d6.25.1741959754512;
        Fri, 14 Mar 2025 06:42:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209329sm23898726d6.16.2025.03.14.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:42:34 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:42:31 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z9QyR3mHw76u_Sq9@gourry-fedora-PF4VCD3F>
References: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
 <20250313063247.681-1-rakie.kim@sk.com>
 <Z9L_MgjuhrploEUm@gourry-fedora-PF4VCD3F>
 <20250314105500.00000157@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314105500.00000157@huawei.com>

On Fri, Mar 14, 2025 at 10:55:00AM +0000, Jonathan Cameron wrote:
> > 
> > 1) allocate node_attrs and mempolicy_kobj up front and keep your
> >    reordering, this lets us clean up allocations on failure before
> >    kobject_init is called
> > 
> > 2) after this remove all the other code and just let
> >    mempolicy_kobj_release clean up node_attrs
> > 
> > 3) Add a (%d) to the error message to differentiate failures
> 
> Given how unlikely (and noisy) a memory allocation failure is,
> maybe just drop the printing at all in those paths - allowing
> early returns.
> 
> The lifetime rules around node_attrs in here are making readability
> poor. It is implicitly owned by the mempolicy_kobj, but no direct association.
> Maybe just encapsulating the kobject in a structure that contains
> this as a [] array at the end.  Then we end up with single allocation of
> stuff that is effectively one thing.
>

Even better recommendation, lets do as Jonathan suggests. <3

~Gregory

