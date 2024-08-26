Return-Path: <linux-kernel+bounces-301705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D1C95F453
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7FC282E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3119148F;
	Mon, 26 Aug 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpl7VHqP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D83146D45
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683742; cv=none; b=cRvw3Sn+0fAakPEG6dQ4ODcvrdLx+v7uJ5LEqj+AYoOy9VaIePbsHaLNkLjXNbBXIVv5zyPUpQcGCczRDawNsRKwyuQUbaka8pGqcluZG1p8/TyHfSOEugijjwvb5C8tupEMY0TCpqtSnVrpzRxvDwrOQIsOMth2U4ISdTbYSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683742; c=relaxed/simple;
	bh=HyX0Ze5QaXmxGELMZYgDFfeGjg2lC9muxsWXetl7eUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgeMpMEFwihYW1aZ4EoiP6xopn19m9LGlaooyhPBFe7gYs8kHmlz6YvNwMRmpSYP7JZYjJk6tal/NGayTRJ1Q1O2w24otHIInHi8+pkBnP3b2XvL2crqKMcCyuhwgBkwXvHkaRJWf9NPmM+0ST6ZVuwYyKXoKyzX5g3lnw9KimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpl7VHqP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724683740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHaPjQf82fzJdve1/EL5HTCFbbWYrAUYnTsv/W9AQv4=;
	b=cpl7VHqPXPQeht93whyN2FJ79/b4XsP1Wkw9ahuIlhN4rwUAi8WJY2sSTwZlqZRPoWHnb7
	ZAvv4Cr9vrBpALVD7H9m1bvrF/avwsn73etDP9o8Xb62rAW7TKERlfUDV/uxBFqJE5ytdr
	gyLq35CIOfH4QChNxn5RMpy8WjJvsQk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Vwcv-COkMs2gR781e2wmrg-1; Mon, 26 Aug 2024 10:48:57 -0400
X-MC-Unique: Vwcv-COkMs2gR781e2wmrg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a864097e296so505173166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683736; x=1725288536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHaPjQf82fzJdve1/EL5HTCFbbWYrAUYnTsv/W9AQv4=;
        b=BZmOyKbsQan4IYP3wibS/+TfZWv+K8EwhXzqQvFOgTFOutYczTMirqUOefTaeEJhPg
         VjbE+dL5E7ZBvyRnV7iL99SqrZddcsEz8kKxjw0zFnx/sM7RCSL+4V/a2qWhKDmgi0AW
         tdWZlOUQiV9Jm6+GanMaGdwTWFsrWGLMBcuQmkNOjgMuPDyLru+9hsMD68vM21QD1VBK
         aggJeGY7sTsspBuM6mXhTZFrb3GQbp8jRI20XMv7ETI4risjUmddPGFOEtBIeuGuXNYI
         1jdCuxr+vhoVEnUdtDBmw39xkr5wwBGHBQy/S/+fJi0z5CKm5xUF2frOUrMQ7stJTf1c
         Osxw==
X-Forwarded-Encrypted: i=1; AJvYcCVLEtv9gVhq+kjgikBbAmIY95yED+c2KyTiZw1+wqPtzOEqbQldscA718lEB+86cux0TTMJywwlzMzwqkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OvDRg4jmofierj+i0L3fiiSIUEO2HbORiRgMtsgRTJRyhZSn
	w7mgdWiXZs1Rv7gRJl+RezAUBYSQmjvpEpEsybc0xtao8WwkLLTa7zmf0Nq2h29FM2v0CX/9Ma6
	L7Nv+RHJXTfBy8EnY4+T2ab/KDLv65xBfSoP3JJJ7XqgtuNS9RmrT7HAkYGnBwQ==
X-Received: by 2002:a17:906:f5a8:b0:a7d:a00a:a9fe with SMTP id a640c23a62f3a-a86a52b5d88mr747021866b.17.1724683736469;
        Mon, 26 Aug 2024 07:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ3oqNtMuoPDoeje2TW7QJXT5PrJA7ZTz1Cf6GJ/Y8fhh9JelE55xJ8f5WD2PBSFo7uTddTQ==
X-Received: by 2002:a17:906:f5a8:b0:a7d:a00a:a9fe with SMTP id a640c23a62f3a-a86a52b5d88mr747020166b.17.1724683735978;
        Mon, 26 Aug 2024 07:48:55 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4378f3sm675503066b.132.2024.08.26.07.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:48:55 -0700 (PDT)
Message-ID: <8c568307-06f8-46a6-812c-407d7b1dd695@redhat.com>
Date: Mon, 26 Aug 2024 16:48:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/intel-uncore-freq: Do not present
 separate package-die domain
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820204558.1296319-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240820204558.1296319-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/20/24 10:45 PM, Srinivas Pandruvada wrote:
> The scope of uncore control is per power domain with TPMI.
> 
> There are two types of processor topologies can be presented by CPUID
> extended topology leaf irrespective of the hardware architecture:
> 
> 1. A die is not enumerated in CPUID. In this case there is only one die
> in a package is visible. In this case there can be multiple power domains
> in a single die.
> 2. A power domain in a package is enumerated as a die in CPUID. So
> there is one power domain per die.
> 
> To allow die level controls, the current implementation creates a root
> domain and aggregates all information from power domains in it. This
> is well suited for configuration 1 above.
> 
> But for configuration 2 above, the root domain will present the same
> information as present by power domain. So, no use of aggregating. To
> check the configuration, call topology_max_dies_per_package(). If it is
> more than one, avoid creating root domain.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This is a forward looking change as TPMI is architectural and should
> support all topologies.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
> v2
> Updated commit description as suggested.
> 
>  .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> index 2016acf44f6a..e6047fbbea76 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -557,6 +557,9 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  
>  	auxiliary_set_drvdata(auxdev, tpmi_uncore);
>  
> +	if (topology_max_dies_per_package() > 1)
> +		return 0;
> +
>  	tpmi_uncore->root_cluster.root_domain = true;
>  	tpmi_uncore->root_cluster.uncore_root = tpmi_uncore;
>  
> @@ -580,7 +583,9 @@ static void uncore_remove(struct auxiliary_device *auxdev)
>  {
>  	struct tpmi_uncore_struct *tpmi_uncore = auxiliary_get_drvdata(auxdev);
>  
> -	uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
> +	if (tpmi_uncore->root_cluster.root_domain)
> +		uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
> +
>  	remove_cluster_entries(tpmi_uncore);
>  
>  	uncore_freq_common_exit();


