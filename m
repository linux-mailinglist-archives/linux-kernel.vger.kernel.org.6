Return-Path: <linux-kernel+bounces-430239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA49E2E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8F3281DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0D1E47C6;
	Tue,  3 Dec 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLxDsN+C"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6D187561
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262345; cv=none; b=IzAl+R9KcIJEiP9XUxEILJS2FEHOFfr7YQ+Ey71xnJP7ROg/PLIIXXbBvS9NKXaX/MAeNN2+JZRED10NjTgq6aBIEt5Ooq7DCvPeibW8+Wri9yLLTIUv+Qs3iFAQ2V5JnmPGUaXKpJ3Te/d5PvshcBVI4Q61+7LXamIJJIfPm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262345; c=relaxed/simple;
	bh=1e8zQj8g2V3GUiD7dPLLSuvG+z/Q+MOLOzeDjD5fzw0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI1l7kFomQJW2olUlKcjdM/xhKjrU9FsGATOPJaogrFV4NOnx09ZG/idA9hn0o7J0r7Ff9bn9BTcByjKKLOgB1BWi3rSpmTXNaPg4jillwDzPM9RDgL8w9mq0Oh6wvd6lIDsrp7/UwKMCGvrJJmVE3U66WyPdNUc8/kx95HfOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLxDsN+C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215c4000c20so11137795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733262343; x=1733867143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qs8g8TfVrzMP3nfe0JT9vEzBGBKRI0HwFLAlhcTSKWg=;
        b=GLxDsN+CzbXVjH4tQo/GpvrhUCo5+BhaWc2hkDkXEyxyHJ2mywnnpgG6Xdx77m4+dj
         Kn/oAfSt4Rq2ca3Sn95dZUsFiRi7oeaKij42ZHd2p0Z1e7awkgprP8nHelZz/ahkd32Z
         mfPimo3bdBEVnh/fUGxp+Kq1NI++ILIIAfICkyiceFSQ+LES/Sevm68ZfO1ntWESHyGN
         2IwXORCM2gGiwshEhlpL43TVU2pwiolPsIpsj7+TwuVyKVz3V6sFoH0RnI8enqEhkHus
         aCZu4kgKD81YqeVUekpjpMs80Va4yskbExGK5ba7mMbJPdKuGxKfqV/62Pmj+2B4lpcJ
         VT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262343; x=1733867143;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs8g8TfVrzMP3nfe0JT9vEzBGBKRI0HwFLAlhcTSKWg=;
        b=XE9RLBcWi/nP8lNdiIlrehVIpRy3lz/d5FbKlwgNswtHzAIialYc0XlKfeWHw1vhGD
         6scwDXp99x0FWZn3CdOH+X+duOBGQl+QoZVO4sJ11s1rBsperU4mtNa7PlO7hsjMLS34
         K5M6SXWfctPA6t6WZJecjv557toITprbWjaI17jdYU89Rl5wRai5cDDzX0U8qMgyRf+H
         JEBfAs/PxBntD58GyxS3VG1UtrZoNs1dISuFGDzUMclTxkNGbnZdOxWWRhbSFiu4rJM/
         NzFZ0dPRn+RtJfp0OihlRkOStIstg6898oPWDexwsM3C/RLEm1FJRVi37I1MBD2kkMU2
         e5/w==
X-Gm-Message-State: AOJu0YzHrN1EgowmWzRTj6YJNVUv5K+oZd/V1MRfe2PcD1x8nVqRokLM
	2wuEOSrVR+GkNxDZfuxxejBiUhWI8sBwfL1QHhn4Pp5PgoWbP5ag
X-Gm-Gg: ASbGncuPg2gKAiz9reCQk2MbRMTtBfV63oCE5m/OXN3qGpCO3cBnQbj/EWmldD/eP1q
	F6GknLxuhQ8Xqr1orG1Fwd0QLsBDMTONsc1uAPpEeG0HtJwnBWkSCXgQRMJJioSztyvBgFuMeET
	nDB0m4IZJGspCz4A1aBX3RZX4xmHL9Emoxlj2QWte4FR8fs0P9cL+iV2sv8UeO608XMZAVoZGR/
	ujLmfGNfexsjt+MZhEWKSmS7ZXNcxn/lO4iOGJap3nNyay00AQvB3TRx9OwxzBtLMcAKWg2Tfhv
	oVnsfqqn4XvWopZxT4I=
X-Google-Smtp-Source: AGHT+IFH94IguKLdgVw+VaVbk0Dgd3wlsWzR0YzD34u1W6McikqACVjvflyQTMBVfkngrgHBYaF02w==
X-Received: by 2002:a17:902:db0a:b0:212:51dc:3d51 with SMTP id d9443c01a7336-215bd200db3mr39103915ad.27.1733262343149;
        Tue, 03 Dec 2024 13:45:43 -0800 (PST)
Received: from DESKTOP-DUKSS9G. (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215bd2fd69dsm17513345ad.189.2024.12.03.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:45:42 -0800 (PST)
Message-ID: <674f7c06.170a0220.348678.b687@mx.google.com>
X-Google-Original-Message-ID: <Z098BOv87dnqnHHC@DESKTOP-DUKSS9G.>
Date: Tue, 3 Dec 2024 13:45:40 -0800
From: Vishal Moola <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 3/6] mm/page_alloc: make
 __alloc_contig_migrate_range() static
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203094732.200195-4-david@redhat.com>

On Tue, Dec 03, 2024 at 10:47:29AM +0100, David Hildenbrand wrote:
> The single user is in page_alloc.c.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

