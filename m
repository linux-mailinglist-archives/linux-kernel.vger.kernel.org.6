Return-Path: <linux-kernel+bounces-390390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8C9B794D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D312284918
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41075199FCD;
	Thu, 31 Oct 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eEVrm90f"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B483CD9;
	Thu, 31 Oct 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372721; cv=none; b=UetsmoqcaxcvnSeUADnDoZ9aegv4OJboy3LsVvo3IpeQTr1tyPXuwyU3yP3I1abcz6h8N0yNcy/oAglwaRDqmq6/jJzlEqUc3LfC4Boh5FZ7pNLlgjsQ8Zg+B8L5DPKM5OSe2EGrL9n4gDCe9YHgyOZCaB7u/X/oKFi0W53deo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372721; c=relaxed/simple;
	bh=aWh93UdsW+ofCnEmC+bDfoHOGpAIraWLb+wruBoqjFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/xwUl9lMU1wmY2cPWMp9tuKc3qXTghkUjMJ1wOft34j37Nrz//QEXOH3f7rinVrBK6g8CSJppHAx8MhsjSuDI1yTqbSMxr3AnVmiYg4a4a5pi2pb2Vwre8HIenXUsfht9O65ZE1ZHnIpAfs3e203pCSPtxwsdniczXs6rIpTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eEVrm90f; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bgiB0fkkBLj2oc3y0qvgYJD9tY50zygRBIR9nY3SL6Q=; b=eEVrm90fdjL0prxhIcDDWd+4Rf
	xT2SPCXpv4VELMiX0JSNlOreeldkxHC9nipIE2muNOeFTNkQqhPVutgBHczyLlF5CHI79EFh7krHC
	9weMOsYxc3h5loQRZaCM7mmIVc4Kg41JYGNUSBmFzIWYQeFHPwSBSwAdQvBtysOWwog7hDtQNYF+E
	T9RVYEGqCxTjcB18AQS9sKfzSswu8gf+RqvST+rPtVoZsUg2FGbiLRLSREmg9tUml2Om3Z7V63RhJ
	rebyn7ujHh4RQKxh0ay9R0tPiNpSyfu4kxkPkHZEBccwhskiEnM4f9TFf8QPCjbWnCj1rMqdi1Wtu
	hISUBStA==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6SzB-00Ha8d-KZ; Thu, 31 Oct 2024 12:05:05 +0100
Message-ID: <f2a213eb-e69b-4572-b837-0c384bbb5960@igalia.com>
Date: Thu, 31 Oct 2024 08:04:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: add more kernel parameters to control mTHP
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>,
 Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030155059.9e27019842ef7c009b728b27@linux-foundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241030155059.9e27019842ef7c009b728b27@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

On 30/10/24 19:50, Andrew Morton wrote:
> On Wed, 30 Oct 2024 09:58:54 -0300 Maíra Canal <mcanal@igalia.com> wrote:
> 
>> The second and third patches focus on controlling THP support for shmem
>> via the kernel command line. The second patch introduces a parameter to
>> control the global default huge page allocation policy for the internal
>> shmem mount.
> 
> The changelogs for patches 2 and 3 both say
> 
> : By configuring ..., applications that use shmem, such as the DRM GEM objects,
> : can take advantage of mTHP before it's been configured through sysfs.
> 
> There isn't a lot of info here - please explain this timing issue in
> more detail.
> 
> Because the question which leaps to mind is: shouldn't the
> "applications that use shmem" be changed to "configure mTHP through
> sysfs" *before* "using shmem"?  Seems pretty basic.

Sorry about that, I'll try to improve the commit messages and add more 
details.

As mentioned in the example I gave ("DRM GEM objects"), my main use is
GEM objects backed by shmem. I'd like to use Huge Pages on the GPU and I
can only do that if I have contiguous memory to back my objects.

I can't think how I can change sysfs from a DRM driver.

Best Regards,
- Maíra

> 
> 
> Also, please consider my question to be a critique of the changelogs.
> If the changelogs were complete, I wouldn't need to ask any questions!


