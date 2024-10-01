Return-Path: <linux-kernel+bounces-346558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2EC98C5E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1209B2200A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2373A1CC173;
	Tue,  1 Oct 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ul+juyE7"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D85286A8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810285; cv=none; b=nOqv+z+Z69mK+a0eQBWj/cEZMXQxVTL1JqlRPc9hdhZNLKK2q/LKqxknlZ0wIKvAsGFisXYCY5ZRSFegfI9dGyYUmjMsn70FRfU+eYoxgxSWH0wtrliAjozftEcxG8SZV85mwrJDQQxXCg4mb96+paHAVuKgL0HYxaHKfdY9G0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810285; c=relaxed/simple;
	bh=E6Z+CyPtB7zMXQ89xhW2EMV+rFyCkE+qRayB5aJFLt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtJp+Nb/XsGDM2IGkSOIMYJuGf+ETDcVUKzKSeqxxpKT2ZHcWzLvlRHs/Z1ZYhZyKuYW1b23mraN9/PYaj57xHKKeKIBlErgMTQ57rOkQ7GsGm085WpGQtg25S0tj1ePPeP6JfiHlalJgZ3/g6yQH2kzHeHis6QbWRMQ2XLe4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ul+juyE7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7ae3e3db294so236411785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727810282; x=1728415082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ync2YqL83Ti1/03r6F1+z3iqK/jNEsxjllkEFbrF83Q=;
        b=Ul+juyE7b3oDk1oMBvMrqj4QUURO37Tn3GTyHzJf0YyQFsIXGC7LBRM/xZybiqY2ee
         4uCWQLfKYNS4oHIm3h6QCtE4JxPMAoUyomzspZR/yOU4sIALLzXRGlXJN9ogE8Q94Su5
         VIFO3EXUYqNpSLqkyaRC4RhVVuWSXTFjiNSuH20UAiwykTT5vNK3kqjYuzXPSvWinSCW
         yYEKgin8qfKswcPxf3tUDFmhusMjdC4EhB8lbR5aOU70PrJjN5h72DjQn1bae2zghcK3
         Zkeu5FkfdepZHrL2t9COH6JXbCdP9DO0sl2cbpwyQQSGh9VGGC4/qLxzxTBs4wild8Ck
         nW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810282; x=1728415082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ync2YqL83Ti1/03r6F1+z3iqK/jNEsxjllkEFbrF83Q=;
        b=cUKHKwYu+tufgeyMFDxd6Xueibdx0DsiYJvBnb4iaj8aynksiPmLUTKXslqXrw7mHO
         iYhj8+GAtconcyKoriyEJPBzRJaADh7rqtUbrZdH+qedSrnFgeHGiZZkKxcQKlfFiTm3
         EgNqtrsxK0raiB2VO/p9rsfZ7Zus3jMIziL+xBYBXsGQ3CPEyHR+bJplSdvb+9iGX7bx
         W1S1NNxd2jjZyP9J3jXqvAhpaGsa/NRDavT8N+ZSMzt5cAdJ2f5Ge6MaKWuj5b6AxoCW
         RFga4EtAMEnzF87bELA08OL1OPXMJOtMQUCOX+LcpVO7YRX2cRM6pdfvC+nW4pu4hvAC
         m7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCURRy3IafNY686ynitQSE20clio71O4xuZE9/5Lb300sG5Bs8HzH+dc/xo9f/Vx35nR49z87xiX10CDyjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaRCLoWfGgpuCAdXR5EkKJlVX8Fx0fWxoVdq85Q/RrP1pSLmt
	MeW4wbh0goxgYVc76S7bsvw6YpPWyAbuTuOXWBRDJiAytoHmRDdA7R7+fWUd1co=
X-Google-Smtp-Source: AGHT+IHtXFnT4ve7jeSEvuD1KpPbHcIiORqAONIeEOBb0g51+u1DkuBd8/Rf+xnqrY7qMBCFoRJm+g==
X-Received: by 2002:a05:620a:3711:b0:7a9:dcbc:f82b with SMTP id af79cd13be357-7ae62738fcemr88826585a.54.1727810281578;
        Tue, 01 Oct 2024 12:18:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377db4c5sm528333085a.52.2024.10.01.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:18:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sviNk-0080vT-0C;
	Tue, 01 Oct 2024 16:18:00 -0300
Date: Tue, 1 Oct 2024 16:18:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
Message-ID: <20241001191800.GA1369530@ziepe.ca>
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>

On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
> > Also, there are other places doing "1 << smmu->sid_bits", e.g.
> > arm_smmu_init_strtab_linear().
> 
> The disassembly shows it uses "sbfiz x21, x20, 6, 32" instead of lsl. 1UL
> should be used if we want to take extra caution and don't prefer rely on
> compiler.

Still, we should be fixing them all if sid_bits == 32, all those
shifts should be throwing a UBSAN error. It would be crazy to have a
32 bit linear table but I guess it is allowed?

Jason

