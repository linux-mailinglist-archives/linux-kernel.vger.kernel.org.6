Return-Path: <linux-kernel+bounces-346583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA598C635
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35647285FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D561CCEDB;
	Tue,  1 Oct 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PF1Fgllb"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A691CBEB8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811985; cv=none; b=Qyq9iRq+kWR1Ap367JaaRZ8Jk4YhTBtBa45mVJM6ESbwz35rgvwOdPv++FTgqzenIIf94XoNK4OjIQTir2smXwlbOKjec8uX+dnLRUktd7vWiadWeDCDSwe0p558MjuMB6WntnAhtgdc6E1JacYQzT5/lLWHSkoU9/PR6i5mZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811985; c=relaxed/simple;
	bh=lClH7kx1zwCuN/2BS1fUoy5TRNfeGn5xuRCMGskUT7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS++GTADW+iJ5GDoZTJRDxvm1HfX7YQA4RlfHxqiwlgPyfOErXkfJ62c9VRfOf3MAjUEnCcQDIVYDpSEXfJDDZvjujwIkka7TSzabUiShQUEi9Cdo8cl6A8Ox3zuoIVR1x0DyZNCNJ/0QwMXGs+Pn3mpw3gSlt/4a2x77UE44gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PF1Fgllb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4582f9abb43so42417731cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727811982; x=1728416782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hi7mCUQzD6JkhoQ/eUGLVfKcJp7d1l6S5OTAwyi5pBA=;
        b=PF1FgllbMjfmShIwGwLHt40N/C1RPFcugQMg6kkQz1xiGr3lC/bG07HVMRxZlqd4oT
         rhjupRPiUege0iItVrbB2lvZbEaf4aFA3T6KC+A4HcLgA4oDxK18rmFqvQiCBPdY7GXb
         zhozmTMF/QNwowGLQQgSvAPsabSuasiUOLMx9hRnQ02WqNZzn5ptuNeHZqUn8e2ba1jj
         aH5kS0iVZHw7n1BSUbCCzfzajZay3WiRRR/S5R8aJ/3GRKHaXjOEU3Zz9W6vwviF7pqw
         CNQVNHAGtxTs/yzgiOZno3cIC3M8VP1wZOpBX7AEYUWSpKHBRm+fFEsaFGJsueQKCATm
         t8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811982; x=1728416782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi7mCUQzD6JkhoQ/eUGLVfKcJp7d1l6S5OTAwyi5pBA=;
        b=UwrQmmemzK3LDjodTbfYiogAer0+nN2tEILObZBrQ0Xyk/IVOzhX2xziKrFc6kOb7w
         EcKeQHziaH/cRVsGIv5pThTnzqfqkkiMsXjJIm/FpJXOR27nxcp8M1/T3CusP2+9U5Pf
         JBq/e0H/kNmRkvSMkQrqBGMjgl8vzuUdNRIxP++UkHPjHOKHeFYjg8mIYnQ4NgTaX2y5
         rnUbK4Ycby9wTtmKE+Un44LSUMLAXDfE62xNRvrnHJexbvguL04H71XBDvwaet2Z0GVX
         H4jVCzp68300esWu3LZsMdC1J6QCkU01BrjW2jBYrRjeIgK+2V31NQD0iLmDDXhxYCZD
         vLuw==
X-Forwarded-Encrypted: i=1; AJvYcCWuNs8c2UDPse7VAfWQVoEG3HVyyG3zTJfz+5DsWztpXjqU6aCx7jKl0NMWtb1eev7ckQnypBGBJ44ty1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySGfd2e1kjliquM1EcdmA9YoqDe6HNBeGC/oCch2F2lcKAYNSK
	YWhLXKl39RPkO/al1PboW7E+mqArQ0yNgAkD+w4vyu75BrrwUOQAEeNHCoTfL7o=
X-Google-Smtp-Source: AGHT+IGh6gXv4bpyyXnqKmtQ0rqP1K6fjZ7SN6KtsRfr6Byh9eYot2k00gZTF5o8a8zCtwu1culsvQ==
X-Received: by 2002:a05:6214:4984:b0:6cb:387a:dd44 with SMTP id 6a1803df08f44-6cb81a66115mr10632546d6.40.1727811982035;
        Tue, 01 Oct 2024 12:46:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b630438sm52957616d6.70.2024.10.01.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:46:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1svipA-0083Mx-W8;
	Tue, 01 Oct 2024 16:46:21 -0300
Date: Tue, 1 Oct 2024 16:46:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
Message-ID: <20241001194620.GB1369530@ziepe.ca>
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <20241001191800.GA1369530@ziepe.ca>
 <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>

On Tue, Oct 01, 2024 at 12:38:56PM -0700, Yang Shi wrote:
> 
> 
> On 10/1/24 12:18 PM, Jason Gunthorpe wrote:
> > On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
> > > > Also, there are other places doing "1 << smmu->sid_bits", e.g.
> > > > arm_smmu_init_strtab_linear().
> > > The disassembly shows it uses "sbfiz x21, x20, 6, 32" instead of lsl. 1UL
> > > should be used if we want to take extra caution and don't prefer rely on
> > > compiler.
> > Still, we should be fixing them all if sid_bits == 32, all those
> > shifts should be throwing a UBSAN error. It would be crazy to have a
> 
> OK, will cover this is v2.

Maybe just make a little inline function to do this math and remove
the repated open coding? Then the types can be right, etc.

Jason

