Return-Path: <linux-kernel+bounces-207088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFF90123E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1906B28257C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883B1791F2;
	Sat,  8 Jun 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b0bvSqHd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE945589B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859722; cv=none; b=r5871HzBB2i/k4bs6qJFs0ye2zJk8B3f5k1iSTWNoGTfIh9HuY4+D7aAz2XRrR91kmsICNewLCuX0DovcMknWLJmV0vigO+orv29mrsWy2L1ORrQso9FzukGb3C6iBxZZJXCQnxRCYbFYwj58CX0MZ/g9WZyD6oRVpa9+JSdXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859722; c=relaxed/simple;
	bh=pTETjRdpu7kIj3OEdA2zb7A/1I0q8SbxH5BShj3G3Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=louCMT+Q28Ku8T/bIUHusdqY2WonZ0auORJAyu0TvRq1DtZZjo0qAZTDAUyMti5bgZMOxW5obXzeGXqO0oj6uDhj14Mf9FWHnSSaTMUbCmVOeOO1dYa9IwaRM6TA8NSYZ3015m+3btNmVhrp/DOPcmb83Pj7qpf/MuN3SP3a13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b0bvSqHd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Zz8vX4pW1P6Jn3NTMHPQV3Gj3dsMMb4vvh1Nd2Xc7E=; b=b0bvSqHdRMz1oEeNGRnZrDQoBK
	hjCWqa6AlwEP585nHcNFAIFikKHVuefZ7Vgg3NBG5I9gCl60yhzi2FqJFHwFtRQMZ+G28Vi7SMS6W
	phn2zcGNc1zAYjQRvlSMdDcPXTHi4nndLDOYYPWwNUQf6WWkZq6VMQexw7w0y1gBucNI1+P68nsI9
	7SsNyvRWje7RUW8MhIBtNX5Ey94ABLGLrb5FM5sII1ePqzEwmVlFu22ydgUwlndWEZ9Xcv51Wb96+
	o+T89bkVbcnED+Lb4koSWExW7MuoIfFYupXm6BDS/jMu7a2bEe9XiDkR8oFSFOHKDufkrWKNgKsTn
	vCHW+dTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFxmX-00000007MZs-2oWV;
	Sat, 08 Jun 2024 15:15:01 +0000
Date: Sat, 8 Jun 2024 16:15:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: yangge1116 <yangge1116@126.com>
Cc: David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, liuzixing@hygon.cn
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
Message-ID: <ZmR1dVUB5mE2If9t@casper.infradead.org>
References: <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
 <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
 <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
 <d6deb928-3466-45ea-939b-cb5aca9bc7b4@linux.alibaba.com>
 <3a368e38-a4cb-413e-a6d9-41c6b3dbd5ae@redhat.com>
 <48fb0e58-16d1-7956-cf35-74741826617a@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48fb0e58-16d1-7956-cf35-74741826617a@126.com>

On Sat, Jun 08, 2024 at 12:38:49PM +0800, yangge1116 wrote:
> Can we add a PG_lru_batch flag to determine whether a page is in lru batch?
> If we can, seems this problem will be easier.

Page flags are in short supply.  You'd need a really good justification.

