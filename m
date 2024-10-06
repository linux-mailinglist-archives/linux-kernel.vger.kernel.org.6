Return-Path: <linux-kernel+bounces-352347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFB991DE7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431F41F21A53
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2308171E55;
	Sun,  6 Oct 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKAxnwpr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8E13E898
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211340; cv=none; b=QAaADOZoq3y0knqBHPPHWimCOPvxA+BsRoMKlrVesK8iNQxP79MoC2AzurrIkzYgRtv4ygIAwzRTpxeUGutIOkgQf6ve31BMj3YjSomOGQB0mRLAEYYuZJgMLUsUA9taRyBKYkBwev4TVQ25l9qNbJqpraT4Bev6tTGKOX5uZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211340; c=relaxed/simple;
	bh=6+HRFrlF1JJWGvZhJT8wdokuF0DptbaKivkL+kbGYyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybmy9g7IfffcjNUV1PpIm7gybjWYTt01fKnXRRXEu276G4sHXHN1qfsaS8erS7FW4n5Sx9LtgetGOX2GROXtlNjiwKol1x3tLpKKzlKBvqjFnP1Tmy1zUZ7xjdiMDk2+a/offaG1bmyGr92rLj0jfJjzHTKa3J0a7qvqA4m4GvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKAxnwpr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728211337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGEmNTQRg1iJUZchi2KFmwCCrxi+C5MgkzAzy/SBH9U=;
	b=aKAxnwprQ/3LS/AmHEguRhqmFIztHBrR/m9DbUKCCqhStLV4WUJAVl9uk/Wj/CPYEVtJMf
	SBwxdMcM3XhH3ZRIM7HCQA2GgIrks8sVI3rqZgg+b/NN37MMDdF8qMizwZ44uI8Hiri9kv
	8Spx94uhHydPfCufwxS8J4KntbVP9Ng=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-GyG7IsBnMiyXXm0PmM61xg-1; Sun, 06 Oct 2024 06:42:17 -0400
X-MC-Unique: GyG7IsBnMiyXXm0PmM61xg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a8308cceaso511666866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 03:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728211335; x=1728816135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGEmNTQRg1iJUZchi2KFmwCCrxi+C5MgkzAzy/SBH9U=;
        b=Yz0fT/Hy0WRZ07+Zfv10L4rNglzDm9adLtulnz/1rFaezW+l6wwBrGWy2EK8UpJ/Pl
         7L96UgJ0JXRmd87RtZWcggLFzcEWWjzhnVyG9wgd0KrHNS4SRsPTlI9p8s60YlOhIDnX
         8Mh7/jUrp7lHSSntUo7Wo1ELzODTDA7cAb42+a5sMwWYGEUIxNLdhInROOQ9jP0WTOnB
         m6rsW+RkPbqMKI0jEtl7Dgc7QXoXPIlBbXHAKWnGh2XQyYhiNR0dBipII3yXk5CfxOo9
         I4GP9iAhEDFVjqluGwP/H20ONSW/NnirggFDP34HVH+/n1VGSyEti/bi4SW6Vb/PMV2L
         9ABA==
X-Forwarded-Encrypted: i=1; AJvYcCVzFcecG61Ny+NhOMkvrMwWuuniOJH1otfUHMdkOIQ0q664roJMxegfO0soQ4STnxeAOdhVTWUuCUYzuWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDRjnbYqgGwq09qgN9wxLLJxDRf4mqRoR/JDi4fmb2xE0AN07
	3ZXd/SKNx6ESii27q/ziYJ4OFZ7vSTA3YYjszDAGcScrNDSYopYY7f8+K7g3I+d3um4pfSuTCYH
	0d+MsoNj+VIGJO5HveVS0HiEAmdLf1F2lqWfT4kNiQVUTJZQsdhZhOvj8K+zlP60QvF8qV9Lp
X-Received: by 2002:a17:907:e6cd:b0:a99:3db2:eb00 with SMTP id a640c23a62f3a-a993db2ed4emr392264066b.28.1728211335438;
        Sun, 06 Oct 2024 03:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1VY+W6PbEw2v4TLZdEMEZPsIMqt+ujS5sKuUxZxjwgb7vb8W2PMsB+Lyfcm2VvU6Se05kdA==
X-Received: by 2002:a17:907:e6cd:b0:a99:3db2:eb00 with SMTP id a640c23a62f3a-a993db2ed4emr392260866b.28.1728211334391;
        Sun, 06 Oct 2024 03:42:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9943cb94dcsm133466166b.186.2024.10.06.03.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 03:42:14 -0700 (PDT)
Message-ID: <7bd5d999-c83f-4a37-82af-23f688c97f4b@redhat.com>
Date: Sun, 6 Oct 2024 12:42:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Diamond Rapids support
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003215554.3013807-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241003215554.3013807-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Oct-24 11:55 PM, Srinivas Pandruvada wrote:
> Add CPU model of Diamond Rapids for SST and TPMI power domain
> mapping.
> 
> Srinivas Pandruvada (2):
>   platform/x86: ISST: Add Diamond Rapids to support list
>   platform/x86/intel: power-domains: Add Diamond Rapids support

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




