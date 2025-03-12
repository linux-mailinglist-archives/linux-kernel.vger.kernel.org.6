Return-Path: <linux-kernel+bounces-557166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90492A5D469
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B013B7547
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3018991E;
	Wed, 12 Mar 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjxyxJFP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38983566A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746951; cv=none; b=QHKzfU+PUw1sR9LioGwSqorF098AmHT56mrc88qIpA61XaEDuV9QdFjZSOk/lP4BVtlYletowVpdmR9mm4K8PGv3uhzDhwC9TynqwvgiFGlwledzVUzYBJeFfxRioeQNJAasxKP4kNU2nilZn2A3eGYA2V3V33kW+KlMyom8C8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746951; c=relaxed/simple;
	bh=UEAHi17+ts4HOh04QR7v1Aa6611eN68qG1WScTXkm0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL3A4SbgyZTnLCujAjx+aKg95LlKyyCyPHWYBa2PhG8T3Jl5bupueoxlFdIS1lO/MmjJyIsZ6NNIJtz8US0H91xXt3hnVOgLNcC2O25uqymy7RTnrjXNBslw3ee2cjQo4ZHVRt4BK3Ptra7MlvofH/c99i4RxHa2FeCrvSrzqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjxyxJFP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741746948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B74DKmkBkIdJM4Sb1P0qf00X8M+idQpMzhYOiFT1AYY=;
	b=MjxyxJFP2PTzoTF3d48X00yZfIjFh+0m0DCC8Jx8+5Cwub4JQnlJ9gR45PZc1fJGJx0NDD
	nZxIjnG8s4k/5f8MzoL+XZhNZXUmcXNWyR5gp/TBPvYFxPEs890ra18NS8Py69V17pWPd9
	htOVBoVQBv7EAmXHOlVf56qBLAL/biY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-UgLV66XYOUyJX1HkQt1YGA-1; Tue,
 11 Mar 2025 22:35:45 -0400
X-MC-Unique: UgLV66XYOUyJX1HkQt1YGA-1
X-Mimecast-MFC-AGG-ID: UgLV66XYOUyJX1HkQt1YGA_1741746944
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5D7F180035C;
	Wed, 12 Mar 2025 02:35:43 +0000 (UTC)
Received: from [10.22.65.26] (unknown [10.22.65.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8371195608F;
	Wed, 12 Mar 2025 02:35:41 +0000 (UTC)
Message-ID: <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
Date: Tue, 11 Mar 2025 22:35:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, loberman@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com> <20250305143353.GB18526@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250305143353.GB18526@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 3/5/25 9:33 AM, Christoph Hellwig wrote:
> On Thu, Feb 27, 2025 at 10:25:39PM -0500, John Meneghini wrote:
>> The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
>> parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
>> and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
>> the multipath parameter is added and multipath support becomes
>> configurable with the core.nvme_multipath parameter.
> 
> What's the point of adding yet another confusing option?

If you'll read the kConfig description, hopefully it's not confusing.

The whole point of this patch series is to remove the core.nvme_mulipath parameter.

This is what the patch at: https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/
does, and this is what this patch does. Since people didn't want to remove core.nvme_multipath parameter
in  https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/ I've proposed this
patch as an alternative.

It provides a kConfig option to remove the core.nvme_multipath parameter so those who want it
can keep it, and those who don't and compile it out.

/John



