Return-Path: <linux-kernel+bounces-525971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54DFA3F7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E943270087A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE2720A5C3;
	Fri, 21 Feb 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dRaf2h8s"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59E1D5166
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150246; cv=none; b=ApdfkTlYYAMGr7ZlN+GOVasi65Qk/eeRQ3FrqJNIbbw5WXT2WuX5ZzMR5AXPkgxFOVI9s2g/I9CqIg0aAVWXup6b5vCcUseVv13YGCLjc7+08xdnDaXOyyBh4CcZL7ONfUpkWRxUg2Zh8TBV3mK9CBjCV7AIjesLr20+E5Oz8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150246; c=relaxed/simple;
	bh=KFRtnFkBQ3nC/ONHLc235b88cizu7aDwFPzxp2mtWKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3yS+k8ZAF8eccCPnVvEAYomCWYygZ/lH2LErIOAsy7FHx/xMJcV8ZlWRYDa7WLN5hFszvBNw/ooaj6wxeX0+zWAP5/hxtgSmJc5YmAVOwKbRb9q6jIPAWrgaQEwDCmAd8JBlm1CILH9cfZxzXwzJkxQk60s5as7BtyRSpqXk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dRaf2h8s; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4720cfc35e9so35353361cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740150243; x=1740755043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raGdtvv05v7TE9T3+zg6DVv8x4HSkjlAQxhegISHwbU=;
        b=dRaf2h8s1vPFB92blYlbw8Moctc10fxs0LcjvyDcA7Z7Xxpef2S1dXZqawh2BpEO+1
         wJrLmrV0nh6LgGRWcc+ATjFa/ghhC0jD+tISVlmw784aHUGGZq0TlNirGmBlhAqv9sdx
         pZnnMdC+CQY4iacbpewj4TayjbHSeTpMWgpw/RveJLYoi74a5yB4upO7n4qpT5J7N8Im
         4OjBR1laaFpeeD2XJFbUS8TFjb0dkTYFEv03BbV3i9by6BzEMuXhOKAmjYYVt9VlRDnf
         UrI1OLmJkH25FHaIVRCqt5uSnSlgv1svofW/Ec9hSm/wVVfoKMfX8UbxjJxFSmRSZtDV
         sQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150243; x=1740755043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raGdtvv05v7TE9T3+zg6DVv8x4HSkjlAQxhegISHwbU=;
        b=R0m2Carz6CtsoEgKEZfnXsB8X475FSdsI95/hgj1+QixtJ/YFR6HmuEtKUJWah/1ED
         LHDq4D80iokVxPS2I6MZP7j32XSZ01Mlr4n86HLbgVoMaudGlg5fIPUDerbbaE/TFwh5
         xMuR4CWd/zEqQNwPRwcMJuVZ6vgpUZsjB8HqSBtoDdSv6/LXpYz3BI7UnHsr7w8fPZNT
         aG2FEBXwQlkjNQlCbatS26pn7U0cJIn2FYYtrxfHi4hFHah5N9dF+Ga27+lXJFvRPNrd
         NK11sSFmh6ssqoKaTiDexuPraMEM0Mg3017FwpsMvKf4IW9YYgnxEN41M0+8O0kvkiDJ
         YMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWquKhbHpzLORZtxSjjCmQ49EmheJmvTGYr6wqFyaDE+TGxLuYskQHvB83qBy95xYUyi01qUuAcZ+FWD5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsCPAond9efNJ7ZC0AgTrlCKou1cUBA71BaXu4TXXB+eQaedb
	ZhAuc7fPJjmM24oHVlfHey0/blneeVcw70LAK107rfKMm9knbPNCYM0RtsfCoO4=
X-Gm-Gg: ASbGncs2eycuFUA8dIzUWfBb0lUV7voyp9EGMLyuYhZP4x31tP8ZcDlBe1ChAbhgPRb
	NhHt3lZN3yuSKSnbhjSjKfrvRtsBAH6FytbzF0ET9c5fEgSXpzBzKcEZjdVPtFhMzAAZBttac5c
	N6doCxOO503HQUATZWaO+Zceh5vIIFWfP/itdiEm4sEPb1qXRPpHzpoHq4PJdQ2wjekH1sPTyeX
	+tHXxW7Mslf3CAoe08emuCKwbub250PHP8yjFXoL/OAYyiHWiL1yL+oe/myl1N0WXHM2BKrIYAY
	SzsJuwKotH1LSUHunnuzgfSIcUI05JOIAW13acA7uv6Db30RCDqcwYx2n7oqlxQKzKBWcbcdmp0
	=
X-Google-Smtp-Source: AGHT+IEyhGHpN40DqDI/gpoNpoHjMZUsgC5bbatQsZIqzLlRoImR8TUs8p3nfPNs4rz85K0lqk/aKg==
X-Received: by 2002:a05:622a:148c:b0:472:16c0:202e with SMTP id d75a77b69052e-472228e4c54mr51741521cf.29.1740150243373;
        Fri, 21 Feb 2025 07:04:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f2b0476dsm56422141cf.28.2025.02.21.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:04:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tlUZN-00000001IAj-3wKe;
	Fri, 21 Feb 2025 11:04:01 -0400
Date: Fri, 21 Feb 2025 11:04:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250221150401.GY3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
 <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
 <20250220180004.GX3696814@ziepe.ca>
 <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>

On Fri, Feb 21, 2025 at 09:31:48AM +0800, Baolu Lu wrote:

> How about below change?

Sure

> -       return mock_dev_enable_iopf(dev, domain);
> +       if (mdev->domain)
> +               mock_dev_disable_iopf(dev, mdev->domain);
> +
> +       ret = mock_dev_enable_iopf(dev, domain);
> +       if (ret)

Though here the domain is disabled but not removed from mdev->domain,
is it OK?

Jason

