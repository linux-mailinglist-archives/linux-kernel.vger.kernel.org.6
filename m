Return-Path: <linux-kernel+bounces-250272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B7F92F5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557A61C22830
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86513D896;
	Fri, 12 Jul 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKwxMSCB"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81C13D636
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767961; cv=none; b=WZjDFV1F8Oc/vMIPniaJZ6buDWPvHXhkjGRdr8iZG+j7KgINvEHcNV//nX+jLsLNNo+cjGVz13Rf+5VjJMe8zRpY/l6lw821UiI/d+VN+9zGPrRVG5gJKHnbrz6mhoHD1xDyhiWw4KSw4SLIOINQIcwipJbuWephaH0W1ck2dwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767961; c=relaxed/simple;
	bh=6+M+15Jtqb9r9vxu2BWFpc7n1m87DlN2aD2RS8uf2FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBko1XieR5e4lZwXAIFPe1l8uP0jEkiINqtDTqdXwHEivBddDcvXY5tGsV6/wLaLt+TwzWxrDh9K8GZpJj0V80uL7eQX+l/rz++aI4XQIN0Ar9YQknYT2DFu+33k4Rs6W1sMzJxH1OC54NIbxlkW5q7PpeHoC/QVf9dfdIC5epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKwxMSCB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ca4649ad49so1295222a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720767960; x=1721372760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+M+15Jtqb9r9vxu2BWFpc7n1m87DlN2aD2RS8uf2FU=;
        b=pKwxMSCBtbwiYq5tM/hJPHYnuGtIFW6gDvdq/Q0ZIp/NHEgpvM0aB11JkxIE6zwKVC
         5RRf6eqijTC8Z6vyuy70M5f+9tuQY6jovGwapn4GIFt68Yw41n9Jp05iaxXIY0PLrmJs
         t+1s1ASZv4R4MM5JZ9VfSfzL4uXoyeY7JG6zKck9z795eZae/b2FHpMxBUMHOgH2eyaJ
         t51PjGnpgiqtpRQDqK26EHf9ZwYzeO4hkPr98RSaYtPLOVw6XDzl8xXuTo/fc1vh1W8P
         zSNvnroqy/yWA7HwpKkBz9ecEqjoJ5VXhX1cZem5CP2YezKug/47o3EKlT1mcaibAaoD
         iQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720767960; x=1721372760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+M+15Jtqb9r9vxu2BWFpc7n1m87DlN2aD2RS8uf2FU=;
        b=kqlHcXRUkjH7r3MPekarfjc/y895vkhWOY99/0y6lYFU0B+bRUjO5jU+oKiy3fSmek
         m+Zs2JIpZVFH4SxqnA4lXUnFYBMsGpJ4tvt85fX69dsCgrzLSm1fVCF3qWDzRoAQLafW
         apQLR66MSvrv1FAdw4IEB29gzoL0wAAmW5ynGBVA604WiI5+Y0sWVV3cM5j7rvF0SZLo
         kMVidbZvkTsFsQDfhKZPQOmxWsE0BKpe1eTfSlIaREhMH7slR9HkIvLM31uv1QdJr6wL
         yriYubO9Q2I0+i3ORfxSwhUBiN2LB/qqKzwHGh5Z9JVqHVucG9N31d2Bb0nWoRZpEt49
         nxwA==
X-Forwarded-Encrypted: i=1; AJvYcCUaR6TbAp8gkoQy3Vhrw0wCs8M/AlfSoOFG8rBQ2Bo1evCQIiijwEyD+HIyKUJl/TCFyMs5KAaPyVXjccs3U+JuA2i3fNDD+AtmvnwU
X-Gm-Message-State: AOJu0YwaAxmGZZfzXdNcgezKesQSWE7ZRzz0Ry5xnPMwFxAOrtRkADyB
	f7880V1PN4EvEd4VL6IYPqVib+kknAsVp4vbksFFmkKwYBu/apE0JlwLW4nqHxR0PWatpmIpIBR
	lO5kNg2NLHwTTBC8bJEwRatyni/G7D7V61iyt
X-Google-Smtp-Source: AGHT+IHA6cMwwcGt/hYxQqxC+XLWB1NWuPeNr+1qD7Xfm36w7VO6oEsb2keJWQBU+9mFLJ6Ez3xKy6D3cbgPnLqBHNA=
X-Received: by 2002:a17:90a:66c7:b0:2c9:815a:80cb with SMTP id
 98e67ed59e1d1-2ca35c69b06mr8978501a91.21.1720767959437; Fri, 12 Jul 2024
 00:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709234913.2749386-1-pandoh@google.com> <BN9PR11MB5276C05D3B3B8821420BBD6E8CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276C05D3B3B8821420BBD6E8CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 12 Jul 2024 00:05:48 -0700
Message-ID: <CAMC_AXWbG_6DSOekjjoUnzPCR3UpS1P_p1AL7kLHO=AnVEhHtg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:49=E2=80=AFPM Tian, Kevin <kevin.tian@intel.com> w=
rote:
> s/aas/as/

Ack.

> > Fixes: 5dfe8660a3d7 ("bootmem: Replace work_with_active_regions() with
> > for_each_mem_pfn_range()")
>
> this doesn't appear to be the original commit introducing this bug.
>
> Even the old work_with_active_regions() way used exclusive end_pfn
> while it's not adjusted when calling iommu_domain_identity_map().

Oops. I did not look far enough back. I believe the correct tag is

Fixes: c5395d5c4a82 ("intel-iommu: Clean up iommu_domain_identity_map()")

I'll send out a v2 once Baolu's comments are addressed.

Thanks,
Jon

