Return-Path: <linux-kernel+bounces-348928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7977E98EDD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02713B20F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD018893D;
	Thu,  3 Oct 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D4QMyWJx"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99D155325
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954171; cv=none; b=e4Kl4EwuVF+9IJGnxDzzTPsIcb19gEKMOGt0AZhb27gwRqQ5tdX8/w99KUQKlPymR+zRsMuH4HpVZ5mITKX6zJ6BE2pA+14HmXpf8WFz8XNUi8Fvd3NABv0MLjR3brUYPuYl1qINY+Ru7t8iMjP1GoNGXpxYDSzJMHk1+leTKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954171; c=relaxed/simple;
	bh=8rQYm6rtwxuir+ifBxd1wSN/hSb+QNtacKr43I2KIS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxpi96m/JmJdroHdaDnHyeZOc52cBFHNr36tW8rvxnMSR+LKsI+rYnD1RQHpchwlfBu6AT0Y/04ipBiBph/kq0Fihtt+q/gJOfMlmNea8K6TprSNCZTg54N9rrzuXTv+6/f0bpAQl0Nc5UkO22S/k29wk3Xrjm7vSC/PwEtfUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D4QMyWJx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-458366791aaso3577391cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727954165; x=1728558965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGLXkZTI8lFIxokzB+lI3gIzGTATKncCCeuzE20IZFs=;
        b=D4QMyWJxZJlNLgKrf7s2dAE7LOJGcq0jMcVk+O0MkDHTIbZD+LlsylJeSoBLKEkdod
         kIknEqq1W0kTDbPBs2feTZWqr6145o9MAKCpTlYkJ5QV5em98ZfG6w0xcWTwCTqTxThb
         0y5ZMasXfIpL9ZQzLZna0WPB+bYa1dWvI5IY6+BSSIlNThmaArQ4jG5VfqasRjwFWx/Q
         HQ7UQb5J3V40lo642YN9DHmCWPRhGWBD+vVL2gESGY0UUk/f3Fx5gyIQ21aa85/Y2Yxo
         Js9WzwV1sqJtTm7IApOyfT9A7PzzIF4NGrDmZZgZVY8vaNiAGEoKT1jzsMWbcl/Pnag+
         LViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727954165; x=1728558965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGLXkZTI8lFIxokzB+lI3gIzGTATKncCCeuzE20IZFs=;
        b=m3NwGNaJBgvb3xUpd7NwGkkjQhrrlljuB1uInuFyO4uS3uSylw+NgqADv7BIJwc19P
         qtF9HtXNIP4brzAfqRVApFxrMbgMXtkJu5cu6rSQ++9d/HuJjQRQ1uIf5Q6fdd7iKIcI
         qIPA5iKYj8ZYjL4EzAfXbCJPDERzwCVz12NEej3/lpcuo3NHBnAtetqTwMbCU1e//QnX
         ZzgOSN9JgcFgdwdV4WvUqZU+nsBHkyVAfnzmiUar7vqzoPoG5MEC2hrJXhiXri58A7oL
         kQHAmQPUQ1lMAaAyQ/qLEYkMqgIeQ//FHZOA+5OUeq4nzk+DcR3WxalcYlWo4UIjnA5i
         wTnw==
X-Forwarded-Encrypted: i=1; AJvYcCUI4jVzCLY2dz/EnpPUlS4iF7OMSUdh3EKE7mM1RBlWyGJoSr6wVJSmKKBiJ+8wCPVPZg1YizyT2cUs2ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAsid758d6gkAb34uwct4XNlRqhCnmInKaQzqmXqw0iFNzRhn
	GMj57UFDOvJhCXe1s5/xT1IuF1mLASR0inKMpYFVCKbEf5OxnGOpzkFZUFt/VOI=
X-Google-Smtp-Source: AGHT+IF1GIYcqrw39Lg9zk5IEgMG8jnEkRhxXjJbsdkvBWAWMDPO2zPjThgyC+sA7a4HTcu9pAF9Lg==
X-Received: by 2002:ac8:580e:0:b0:458:3ed8:ecee with SMTP id d75a77b69052e-45d804eb757mr86748451cf.35.1727954165380;
        Thu, 03 Oct 2024 04:16:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92e0ed8csm4660151cf.36.2024.10.03.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:16:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swJoR-00AILi-SH;
	Thu, 03 Oct 2024 08:16:03 -0300
Date: Thu, 3 Oct 2024 08:16:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com,
	will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241003111603.GU1369530@ziepe.ca>
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia>
 <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>

On Wed, Oct 02, 2024 at 01:05:08PM -0700, Yang Shi wrote:
> > It would make some sense to have something like:
> > 
> >   u64 size = arm_smmu_strtab_max_sid()
> > 
> >   /* Would require too much memory */
> >   if (size > SZ_512M)
> >      return -EINVAL;
> 
> Why not just check smmu->sid_bits?
> 
> For example,
> 
> if (smmu->sid_bits > 28)
>     return -EINVAL;
> 
> The check can happen before the shift.

Sure, but IMHO it reads a bit better to check the size computed from
the helper

MAX_PAGE_ORDER is often 10, so kmalloc will always fail before we
reach 28 bits of sid space.

Jason

