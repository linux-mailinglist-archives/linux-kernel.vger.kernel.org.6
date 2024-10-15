Return-Path: <linux-kernel+bounces-365812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E55E99EA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527792884CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139691C07EC;
	Tue, 15 Oct 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j2DLWB3P"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C41C07D2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996447; cv=none; b=e97z/YWYkoIo+AVhUomkS4h1Pdf5UNZPGTTnChf6HnVqR68v3IR44x+VDdqlEKxbb6tYRU1KEJJL8GXu3Jh+sbh8NOwQ2ZoQYlc+Fgu0wt+LaZ5BQhQu9xqI4gLi8B6GQGnR1N16gqKAPrObbgtuwI0fMjLWvqSUlKAI/puKGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996447; c=relaxed/simple;
	bh=9S1snqy0sUlcGrxSkmAISPY4bKaFGc5qSCVtFcrN4RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biLx6exSKirejWuxpCCWecrJVz5LWDdmxmx+BCuVQqM4LF84F8ru2iUn7F0l5GOVeFLzLI3WEge6Q7Lmrk8SZ60rzT8T+TuOOKqbdTHIbrdqFSPPaXe4JzfawUqDDmRZiX8yyEd6HcyengX/GUdvqdDc+0Y4ZRelanUbkQE+Bk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j2DLWB3P; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fd057a973so1257241241.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996445; x=1729601245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9S1snqy0sUlcGrxSkmAISPY4bKaFGc5qSCVtFcrN4RE=;
        b=j2DLWB3Paan6KBP9L8uoyRVkBC4TNnT/hpUMlcw7GzrWf1k7WAfybHi/1u0hG1h+gV
         Wxtbnke+cFZy2rfgug2oh02DdYq1NeejYggkKA8Pwa0KipziaEHdi15SxJdleT3OpOpi
         McgjZr27Lf0Cca0lkXEuKnwwVh+w9yt5gdequkc1ric4a2AfN1jhNVxkzYWZp9PNrfCN
         77zntjuP/Q1qAPlULLcDiVABb7mUaPgaNOLP6OkT6MrN0Lax0IMyrlbnhDc6eVM2C4qM
         +gvKuihwpmnwfbFqvA97BJwen+JKbjXw4SjArky1+Z/uxaeoD+p5hHgWS4TnyRMCqQOW
         gN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996445; x=1729601245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S1snqy0sUlcGrxSkmAISPY4bKaFGc5qSCVtFcrN4RE=;
        b=kOY4yejdOMKvXaLfuyEhAnFkA2sT2J7eqNo8JAqqOF7Q1FnIUzS5OMvvIY1DgxrYk9
         AMTQCDso5w37tMHdvLhtF9iUqSibb1TJ5IovNNkAC7iYYO7W4oExQD9dXaED2WyVtk0p
         F/yl4GmtsHTL1bdY173qIB8JS4az6tF20rCpOsM6QY7PL7a/8BuQsANKG5RsSSmWGMva
         yM1kS+PXWAi//GmNAr8ByTH2xGUj/OGRDrWMrv8yVlQVVeNnKxzDdgUe9ws+089Vi9j3
         8SHoqu9VII2fqRVQCVWX6yPIyRAI/uQ1S5p5D2N4Fr45UNhlT3DtjM6zWxPBQnq20ZH+
         Zx2A==
X-Forwarded-Encrypted: i=1; AJvYcCWdziYqcJxEEs+KfU53bDosd0mkGvDvQzBwUW1XHJM1Y3pbXf+35/UeWqCXq3lFN7SwlN4RQmM4VTcNd5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHmQq2B7E4qiKww2V1gq2O7McR7a9sJ6PMR9/CzOJnxNq0Vnv
	f92JZT1jTyyFI5Jv9CB0FFkfjXvdI38CiaoJwD28pgugAQ/fHT/5YAEfaaIAsPg=
X-Google-Smtp-Source: AGHT+IHIRxePA9J/5yRqXfxDEQAMQhA+JMP40CVAOrPRfL5HhzVbrqqZKc4spR4QAm7PXjUlxeCV1g==
X-Received: by 2002:a05:6102:3752:b0:4a4:9416:6a18 with SMTP id ada2fe7eead31-4a5b579b8e7mr231229137.0.1728996444983;
        Tue, 15 Oct 2024 05:47:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13616611csm67089085a.14.2024.10.15.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:47:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0gxP-00D2Mx-UU;
	Tue, 15 Oct 2024 09:47:23 -0300
Date: Tue, 15 Oct 2024 09:47:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <20241015124723.GI1825128@ziepe.ca>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4kKDFOcXEC78mb@google.com>

On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:

> Umm.. this was specific for rmr not a generic thing. I'd suggest to
> avoid meddling with the STEs directly for acheiving bypass. Playing
> with the iommu domain type could be neater. Perhaps, modify the
> ops->def_domain_type to return an appropriate domain?

Yeah, that is the expected way, to force the def_domain_type to
IDENTITY and refuse to attach a PAGING/BLOCKED domain.

If this is a common thing we could have the core code take on more of
the job.

Jason

