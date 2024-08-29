Return-Path: <linux-kernel+bounces-306215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B158963B34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FD5285CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02B14F9DD;
	Thu, 29 Aug 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed/hTtDx"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778814A4EB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912494; cv=none; b=VCIR/VxcZpfOskjbI1JrF7GJiFraBMLBtbApzKtABVWju7NCPgc+734Fj1dlOcOSi3GPvdp6NsRuACn84u8isQsojig+85bmO4NvWruBvYxasG0UEV31OhRn/zuNA7g4n/tZ5WcmBceyyaIsfOQSJcpBaUsmN/duP/EMfaEntcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912494; c=relaxed/simple;
	bh=4m+yGSdBhixhxvtmH1e1egnd1m06G0SnfHvjAyZhdsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWjFassIY4ueL1vkjEf/oR/XHFNnMc4iSOc+d4ouLfxFNTEjLYBVYjH5189FmuvEoLk+7T+eVRq43a9t1KWl4hZfaozeBJbdzX6omLntwIotBpbcPonmXtFpkcdBn4U8Rt9zGZlVnkh8x+y1vcgOkZ5wG4GKCMhxgjOUDCa0uaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed/hTtDx; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b8f13f28fbso2805327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724912492; x=1725517292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4m+yGSdBhixhxvtmH1e1egnd1m06G0SnfHvjAyZhdsc=;
        b=ed/hTtDxATFooCygmqy2GcSrpbNuUHXhLjgAMxr4UGRn2XPKZkQy4NwrA8ciT8wXQy
         GZXqAIzjVHjSb4bZkm5sU23etNROyfbYje9y5B7eyjThMerLUJFNSPRXFy0EKrMWTjSd
         5NAh+On745txIlpHJMM6gRp+al99uRdnOviir2MDJGPanh1Z+U2rVqcv/laetblo/MYJ
         6IcUYChV17Wg6c8ECn+D0qLLeE1dBOD4Xug5Do2f5yL4Fvu0a16xQrtYyhWPvbXiDXUV
         AU/QH+CVq7mszMfTOdbAfQ0ZK1FSQf5Seeg/wooYHJx5JhY/buwbc8w12JMCpIEFCaXp
         HSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912492; x=1725517292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m+yGSdBhixhxvtmH1e1egnd1m06G0SnfHvjAyZhdsc=;
        b=G6lXaYsRRS1dN0MyNeXA2lRspbuXqcJdNxDQ8MIicUA4yNW3qIlbR97MToO1E06AeJ
         q1sx1lat3pUVylGIaRyvecA4u5b/uQ3baf/BnKz6t4uxUGijQuI0Y61deXPRDz8lpaYM
         wRMIR/4rtzyiQJtPrixHaWMc27NtztSkdMFQnfq3GtbFWwzG1kZPS0dBgw+R207IZKN3
         +AfVG8z61FuKMPj1YMqpIGQUnbkpXE6P0vt0ZtC2lmsgrmynsdEAVp0PYrCeSjgaFT4j
         CDAxvbmdlwndhv7NuAc5H5el5Uu41xQoOS/npRtFaTczMxoR567oyIEeHv7PsweLTNEd
         e1VA==
X-Forwarded-Encrypted: i=1; AJvYcCVBYm/PdOK8Xqm2/yiFoDCsnvg3bEvRcAkzjndcNBwzu/H+H51MNVT61og39rh1pNNQD66tw2RGbMOW7zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/pRBdahdcSjKV46i01exC1YWsG3SfwW7FqzaB+qVMlq5u2sH
	q5DICBHM/k/7frY0BdYHzFhlFys0R7aKcoTqDtXOmCkai89PS9Prq9rdvMO1OfUmTMV0EHTyWSF
	faeg9dz+lZ8LevtW8nhVfnhwyt60=
X-Google-Smtp-Source: AGHT+IHMLEKsLhvNrpFB2co1aHPpoSBzoSmaC8bal4WcNj5PJZQOLOS3kwAZjR3oI8mxlBYACeDUFi9uQ35Ii9qQaX0=
X-Received: by 2002:a05:690c:38b:b0:61b:342e:91ae with SMTP id
 00721157ae682-6d277778e64mr16682037b3.36.1724912492142; Wed, 28 Aug 2024
 23:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info> <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 08:21:20 +0200
Message-ID: <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> Probably f90584f4beb8 ("iommu/vt-d: Add helper to flush caches
> for context change") is more relevant. There was a bug reported
> against it and fixed a few days ago:

I added a comment on bugzilla, too.
While adding additional logs to the bugzilla entry I realized that one
commit has not been tested.

good: 804f98e224e41c16e3b70f97790f84894745a392
untested: 2b989ab9bc89b29dd4b5509408b8fa42337eda56
bad: f90584f4beb84211c4d21b319cc13f391fe9f3c2

I do not understand why git bisect told me there is no remaining commit to test.

