Return-Path: <linux-kernel+bounces-366079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BF99F08C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0EF1C23717
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B81DD0ED;
	Tue, 15 Oct 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+aU9gEK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BA1C4A28
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004422; cv=none; b=REhBN6tXKtbvNuUBplE35lHQFbD0pft3bRkoJWa/7kF1PwA+ewlyxdfzAbLWLWYhAndK2HGcSftvfpNtkT0Ie4+AE23sPMFeYl8uZq9YS4E2jsDNqlvRGUwBMk9B/bIehLeALzWBP2Vih8kpJ3jC8FszstAE6Anj0+G7H9VW5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004422; c=relaxed/simple;
	bh=PnhrbquGrhgBwdZIayWClMTgqMfcJs9XO5QF7fKdce4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyj8gk2EUM/D10pELHipaDqr1NBVd3xHyM+BJQkNaCnnRCtVtZqXaIcCCTiM/hkSoT3s9rkN39snwupOPwX9rXTsJp8OTa0TAKHlsbysW3lzzy2nuhy2UezMayzmPVGrr+uZR3Zf4/VpGgQvcHW8UJF6H7vTYgFa2FBAm3FJh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+aU9gEK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c8ac50b79so504975ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729004421; x=1729609221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9TrApoPekr73hkTm1MQpMBodsXouta6HBY56R3r8KIQ=;
        b=H+aU9gEKbvPQBxfLza3WXaRr29ySOni9h+Kwz9XdO6mfplabBmm0JobmlJX+tSS2+a
         CMFvfjjOOVvFRc+AZKzEkrgJ95vGYIQ8yWJxBoIfi2WbwcvquirMXpSgwxOQjGSzikAg
         Ntl+9XFzpVPEPfCXAcFv2ANbRs5iV6o78eYpJUsrMMeCjq1sCNHMiZ8yoZ6rJhdxBxMK
         XJGTdCxe3+u1X5vLadQm2/XXUN57A44H9/748HZz9ZvbQyHzyGnKUIHluaYM2uwDgu8e
         246feNpNYELdgSyrga3R39VzZRum2lR4idKbGS6tnK2rDkbNkc1s6CzhwB2e+kJsWpqD
         RXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004421; x=1729609221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TrApoPekr73hkTm1MQpMBodsXouta6HBY56R3r8KIQ=;
        b=oB8xFphL9XQljs9aLsk9V1V90BKuxQomjeA/bapms6ykvlGryxVkl6ZAS+xw+8t2Hj
         QjrRr3Gf5Lwygn/Xahq6TLcW80RSuFRAmJyF8Ew5ejoBkiyjImHYAv497Ijh9CpA+rl2
         hdTYawoLMc5u04y71KY7qw08rCVOgWaUu+JXdG/3Rtx1EQvQsanrzyYSpJCLP5O1SNyK
         TICezqpRh74sGRqxpYV9BS3Fn017D+sV+ES6Jg3BpVtbNyVCNKAs4F8dVHAoWVhxel/e
         rgvSzWZdDJGQvJcbCpRRNnTqTBbyv8dJiMjJWBg02x2i3U7WmbfZGgaJqTIiXKkC0+qm
         Th0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX26f1IFVMa2/f47DCOCHlJrIoglX1SWER8qKv03B8DO+KC2OAqZ3lvhCSmXeNAgaqvEajoZ4XTPbrAn+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRMPsqQNxfGaDyui+4kgh999YU6ctqunSECjBa5RKiJqe6tOk
	5wYlRB8lcwLUXQoVHzVEwcNrMaEK0OzDMyOmtJrTzYn5uxSdPA8DAnrXbcI2mwiaasgt6uVF/Ti
	TfiLU
X-Google-Smtp-Source: AGHT+IEnO8qRPAnMZSsYcAU1umBH7w7hOtggGkej45WKFStRzR/jIUoEFsR5i+TfpWF2NyzCUeroWA==
X-Received: by 2002:a17:903:2442:b0:20c:769b:f04d with SMTP id d9443c01a7336-20cc02bd0c7mr6105425ad.7.1729004420408;
        Tue, 15 Oct 2024 08:00:20 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c6fesm12949855ad.299.2024.10.15.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:00:19 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:00:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <Zw6DekI9X7lL4f1G@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015124723.GI1825128@ziepe.ca>

On Tue, Oct 15, 2024 at 09:47:23AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> 
> > Umm.. this was specific for rmr not a generic thing. I'd suggest to
> > avoid meddling with the STEs directly for acheiving bypass. Playing
> > with the iommu domain type could be neater. Perhaps, modify the
> > ops->def_domain_type to return an appropriate domain?
> 
> Yeah, that is the expected way, to force the def_domain_type to
> IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> 
> If this is a common thing we could have the core code take on more of
> the job.

Yes! I've seen the IOMMU being bypassed at multiple places, primarily
for performance, people like bypassing the iommu for "trusted" devices.
A few examples that are publically accessible: Qcomm SoCs [1], [2].
Seems like Qualcomm have a DT property `qcomm-s1-bypass` to achieve
something similar.

In fact, *blast from the past*, I tried to do something similar sometime
ago with [3]. Although, perhaps that wasn't the best way (and I was a
kernel newbie :))

A little off-topic, but I think there has been some interest to bypass
the default substream as well while still maintaining PASID isolation.[4]

Although, as far as arm-smmu-v3 is concerned, IIRC, I think there was a
way to tell that the region is reserved and don't map it.

> 
> Jason

Thanks,
Pranjal

[1]
https://github.com/realme-kernel-opensource/realme5-kernel-source/blob/master/arch/arm64/boot/dts/qcom/sa8155-vm-qupv3.dtsi#L22

[2] 
https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/Documentation/devicetree/bindings/platform/msm/ipa.txt#28

[3]
https://lore.kernel.org/all/20230707104857.348353-1-praan@google.com/

[4]
https://lore.kernel.org/all/CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com/

