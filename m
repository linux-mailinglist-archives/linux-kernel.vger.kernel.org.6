Return-Path: <linux-kernel+bounces-560912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4196A60AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51463A261E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB61198833;
	Fri, 14 Mar 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRyWSnqM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6C13E02D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939931; cv=none; b=cwyDhgdueoexTjmNWRYK0qLLdyxNgr4hoHC0Br3BnY2YWmCiYtoMmKpW5YjlkOxDKbVqahBqatEN7l9ZMdOBm+ozDKLX9YXnrmVwpDSirWLlVGqSNU9I7bFBTJxh+HlTbKlzQS6JMmgfXIPlVb6z5aEX4YKXA0VtFwVGJHdEybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939931; c=relaxed/simple;
	bh=8cylVulYPsuLj2+UhzkDhFzJQRXHh4cjgiNVztEekzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiPPNZjcDerZ1LFK5m6AyikB4+GjJIqWeOeASSaKZkuVDuw5csP436aP8cttTBdx6BHsaKRo0C/DVuHVT0mmKu53QfGPfwE18oe0DMxmfhXHwPtXXsBiZAGldG9uZnYzs3Wqnz30tyVT4a0wqGC1bsujP+pNh975swvS/WIIhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FRyWSnqM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54954fa61c9so2235675e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741939927; x=1742544727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8cylVulYPsuLj2+UhzkDhFzJQRXHh4cjgiNVztEekzg=;
        b=FRyWSnqMEyPY+gP/jY8GMChTQDD7FoaYmdrauibjYspGsEJpAZpgxaKKfkNUczeEcR
         n29CanJ+CrsFvqe3vIAr9F8Qp7U5bhf48RtP7aa0+K8H3QHt+oiNYj9TtLMreBp6Tdpz
         EYT6K365tXBiP6Bw4e6AFYc0BmBKUt0b/fmfMYCq23jKWJ3ApVP0TlxcfzlND+if5VT+
         I8jBv02KNzzKfjwxHKPhnAxmq61HjUPlqOuD8DOADBABX83NCYk01Jhz74qhknMP9pAY
         6A+MW3txCTp1F5ev2lOic0gowPqPutxDtIR29OzpIZGZ6o6UZlu/adXHAzaVXAYV9+o9
         JrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939927; x=1742544727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cylVulYPsuLj2+UhzkDhFzJQRXHh4cjgiNVztEekzg=;
        b=dg8MN7E9qCoLx/6q40P0TbNG41M4ohENld1ouqYmiFfH9zj74+nFYPm+iczAB4SciE
         xplAXzdU0InnQQTkbnkIE22GKW6lgSz3uvGYjMSkrk3fwX/q+LQyPKQvebokX/KUwF+c
         +4qHmsAJcz8n8tkiYBJKPGFocuy++lyk5vhNY+UyUaE3sGsOMpN3TKtBDt0dKXTnwAGz
         9wlskuXjg2NZFDBT85DCS6Ok/9PWhbm2N+3kWaUzKIrgLjTwmH1AgqJhzsSHJdl+gMVv
         Om+PvI5mls5MKhRLU5jVchTiIliV37gq09fEl812zozrlM8NHxalhK4GN5I1mXrglmZ/
         GXeg==
X-Forwarded-Encrypted: i=1; AJvYcCUw7AbKTYq3WNQyLq5fyovieFYtmduKI1DsQdyEJan0hn9LBYrCTXGn/u9JXyH/oDC7LV0rWb/a9R1fb4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMi4YrtpBHkxaPNVWrxq5K2cVbNrBYJQgP+r7csMVVocZOOwzw
	bPRfwwH7Bz+ObTyczvTmZC7JhsjvB4nwLxZdyv7FF/RynKNL/80q8quafsbXX2JOqa6O4bRj9j3
	PuFq0DxZtgDMXpw270oxcZb9cCwJMeFqdpukgtQ==
X-Gm-Gg: ASbGncvkrJSB6ar4+Z6tJ0HlGFDuVmChnKRrrB6OlKBn3/z4d3BDtntKdqTSvvN1ldI
	QpRRJLx4O272F7q15ZNGsN+f7NMOw5JD3TAwZRd9MNe3C+0ywc1pkyFKDY9xLxx0SVY+wHQjGbn
	kHClA46Ds9e/tk5IGCU4NRw7ihanRx7J8=
X-Google-Smtp-Source: AGHT+IHGGeVJFh8IQpmki3V8LS3prqRn4mV+TlJsniBWV8GinnRd8uZ8FEwuJhvhNULLOQP3lZKdtvLj/4wJYkEQLZY=
X-Received: by 2002:a05:6512:10cd:b0:549:4e88:2e6a with SMTP id
 2adb3069b0e04-549c38f52b3mr415545e87.6.1741939927425; Fri, 14 Mar 2025
 01:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 16:11:56 +0800
X-Gm-Features: AQ5f1JoAIzauNjyPIPxiG7nniTwbUahcmK3Y--Iy4ho8pIyBMKTUSfeN7GKy6pY
Message-ID: <CABQgh9G2kTqWvjDTMupCJ_YNMxTg75PwgooMSsvEuT_hvemvDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Thu, 13 Mar 2025 at 13:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The new method for driver fault reporting support relies on the domain
> to specify a iopf_handler. The driver should detect this and setup the
> HW when fault capable domains are attached.
>
> Move SMMUv3 to use this method and have VT-D validate support during
> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> _IOPF. Then remove them.
>
> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> further clean up.
>
> The whole series is also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4

I retested this branch, and it works

https://github.com/Linaro/linux-kernel-uadk/tree/iommu_no_feat-v4

Thanks

