Return-Path: <linux-kernel+bounces-294053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D695884D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11C91C20DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6119067C;
	Tue, 20 Aug 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hFo8jADf"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DEA18FDC0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161954; cv=none; b=Luhpt2ylIzzgclW5uJr2CtYbCYQcDfjNJseXUHafGeCk8njz7qvrr5Usr+N0uoKQJv6AxWSVYc8ZAVDVjMzncCMGcwweMwgQu/5/yP3lsktzH17aHdrCgNv2sHTUHviHfB8jCyBtPz8494cMThbKhdgtsfLUNthQLOHn+vuIe74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161954; c=relaxed/simple;
	bh=f82abBbg9jguh/VDRR9fMf/RDo5qRnRxbSo6To1gBvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3KHiZX5vRSHL4qRqSFSnKqRePBCKAIBcomA0B8UvuHHSQjMMKyIbjuAO8hFThtrmbgJbJsOAgYSmmWBDRqLsXcsknCuhgMBsbmCSMK+NGxugBPhpReuCOjOWzWY43xz1AbDLeK+DRVI6EU18XoXGQsv/3WlPulpx+CXXY4Y0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hFo8jADf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a5074ebb9aso268031985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724161949; x=1724766749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67FW9uiQtDU02nDB/lzmQFYFhmPDEgPJ7AO31offMAw=;
        b=hFo8jADfBOD+HifhJCt6ydFK56/UqChBwxwVvH7Zo7qJGyO0WfuVi7w2nQUishSRWs
         Nnr7ilX8lVmv8c51hdwfYWVbC3l/oQc9xqyDHDn17vuuvLWzPD7k55qi+/6qfip03IyH
         hTUvrDXNvDKn85A1K0LPXY1Eb074/AQIUaNYdv1bY94EmuoL9PtQQCtM4WrYX/jWXGlk
         P9C3POc5bCvW/WRUxR6dwv8IJkVYoVPWedOOQJix1faInPE9KuAOi5qi4i7iB57DO9No
         TxmYUZxAEBfmKPl2V87ziKC8v9LLcGXGT4lWThhPQ1v5vykun7Ciu1fb5odaCl9+bowK
         39lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161949; x=1724766749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67FW9uiQtDU02nDB/lzmQFYFhmPDEgPJ7AO31offMAw=;
        b=LWue2bzqZlq229IxY5lIVazesZyBnPjP3sKfIK2sgmwZqqnEsa9599LeUFVCtLWXkv
         Id4P7iS9ydxdOzxNxqpiPd1smGqYCX031O8+25gOX1xOhPbkzSw5jmnkrxpOaZna0vAQ
         yOldxLkqr8XQqucFRKaobZa3cXg23tUZGbZ2Wi6b/J0ZZvZsfHyg3GJ5ZioQ+EflbiEg
         wtmuh4ogyxp995D94CLk7YEXJ8qfrMMRE1AOzHkTo6/nuzwd1V2RKtOCHxkzPfvtauap
         RifzmD5pD0Crbh67+MJeLzXvLHOR3rYsRMMR0NZU+apo1zFTVD6sDZSUy6vp74lYXnnM
         7HFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlxA6CuJ1Tnc9UJdqTpjn9jZXS7rNqld/QwIFZsayHobsG2dMaRLR55BlHEZqr+noDaKmzmViEIKZm2Gzqf2YvkMDdtfabQYt1z7ds
X-Gm-Message-State: AOJu0YzEdAo+gQY/fvB7PDPsO4Rapldmt+fN0ACos11y/bvBw1Q5vhVf
	btA1zDEHX/avTCJh0gXiG+BkW+L3Trdks+486xWthhC+3WDEKA63GCCvPqAUSHM=
X-Google-Smtp-Source: AGHT+IEhNIv0Ij2MIGvabq4gRCT+4B/5w3shoRSv5yF3X/yF+fiI0jyRZ5wjshZ3n7mQC+eePGdBkA==
X-Received: by 2002:a05:620a:1a94:b0:79d:8153:57aa with SMTP id af79cd13be357-7a5069d48b7mr1515182485a.48.1724161949724;
        Tue, 20 Aug 2024 06:52:29 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02f89bsm530357085a.23.2024.08.20.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:52:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sgPHg-002W0g-35;
	Tue, 20 Aug 2024 10:52:28 -0300
Date: Tue, 20 Aug 2024 10:52:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Message-ID: <20240820135228.GX3468552@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
 <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
 <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
 <95473081-db0b-4802-b875-24605ab2ef37@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95473081-db0b-4802-b875-24605ab2ef37@intel.com>

On Tue, Aug 20, 2024 at 04:55:26PM +0800, Yi Liu wrote:

> Are we sure that it is ok to enable PRI before enabling ATS?

I did not see language in the spec prohibiting this order.

Jason 

