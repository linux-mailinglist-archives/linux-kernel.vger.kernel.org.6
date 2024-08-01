Return-Path: <linux-kernel+bounces-271485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97A944EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3001F23481
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5313D510;
	Thu,  1 Aug 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9086Yba"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987713C3D6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525307; cv=none; b=IdGm0n67YEQk3x059ZhX0Pqu6bJlGypB/3Wg1NSZ//kf7zBQY8aKuA+JANydwu+ieNfgPqWw4sh+HUkA3v6/981MkfMq8DEqXBNixnuzlxVPtFYLB52M+UAo+OImXIJTBr08wAiIrQ0yhLn4v/nQVFQGYzFtz/HaRWoaxBbslrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525307; c=relaxed/simple;
	bh=A6OP/jfK6PATMbKxzMFvI0PTC7EIM3acs2hwnW148PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsSCwapRKSpY7NmtQSDvPhNI8WtflPV4fhr77wC7GRJ/q3VfzVuaHoct9teyfbcDfDWo475zk2GJvw7Eo9MAI+taOJflUnHgx34o40SwoYcfatVQcKZXB6pH3MQ+lwbofShv9ZcMGQteoBnU+ilh9kws+H65cOcBhR5RMDOKBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9086Yba; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722525305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6Gz03hDTttvd+7tl5OFVJE3QFtRiPUFMKGDnDxPPCM=;
	b=X9086Yba+mAGF7VIIrurHCxsdhWLkiPSkml8WOcFBQFNaIO14nbvZi/HBdU0/TVSheHIeo
	QSMv9K08Q0yFgZgR7/XwwX1KCyaPZwq+irS9a7Klx7818DvcfuEZ1VyvClmSV8wgILwhLs
	XtKxqlflZkaMqGR53y1FjQXCtbwE+wQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-PDUAtUjROMuS0fF3B4BQ8g-1; Thu, 01 Aug 2024 11:15:03 -0400
X-MC-Unique: PDUAtUjROMuS0fF3B4BQ8g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7aa56d8b14so617146566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525303; x=1723130103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Gz03hDTttvd+7tl5OFVJE3QFtRiPUFMKGDnDxPPCM=;
        b=w1CK9CrQabavnEUmxBLsVoPN3qd77YRhkbnJ4cUffS2ty7iUEW3yATpRTMAFzO9cKL
         96osiCcZVjlONJj9QSuK42JGtNTmiLNIguvO5VHrxJANqaVRrDjICCdZNGVPV7Ce550c
         QREy9ga8erX+ddt42akgxQdNkAls8K48OMivzPmi+Uv7jZIoS3K5PuCtSbVgxCHg3dH3
         Bwl1akiba8d4VN88ouT1ZMd19nHY5iBwwdvFrNoLX0S43eRdoWQrejx5FvLGXfPjj9mQ
         o54muJQnP28VSXDhMgW5pqoWXIL90agdz3h41acWrld9b7kph6ulLeUetrr52NtWcmhc
         KHUA==
X-Forwarded-Encrypted: i=1; AJvYcCUwsQISZ/OPM8GpTBJyEXHWCYZizzInEV60+MINCfoksYnYShwUP1ArYj1bhhJ5AkbECkdOEmJDqcgf/cwI54Z9iuYYbru382+7AKDK
X-Gm-Message-State: AOJu0YxSrTmE5Vi/HjpjleExP/7DEpok2NcM7YIjVWTu9IJnt9EtITIY
	tavWnWM4K3FryeAQgPhkIlK0Sylu35YckryzSkRhlKqP63LHOK+49W20UAjHxA8YDk8q7AomXlS
	tbOcqjaYEVNO3jrGUP6gB2bLtn5rvxIooIG+CpLUgBejU/YEXTsV6KfB3TGkLcw==
X-Received: by 2002:a17:907:9689:b0:a7a:b839:8583 with SMTP id a640c23a62f3a-a7dc51c26e5mr32398166b.66.1722525302610;
        Thu, 01 Aug 2024 08:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh8sS8ASeCL7tbxerggOYvsOegLjh6xAqrTG3CZcz3y3qa/PkPBjyHfa+gnp10im9bRcd23g==
X-Received: by 2002:a17:907:9689:b0:a7a:b839:8583 with SMTP id a640c23a62f3a-a7dc51c26e5mr32395666b.66.1722525302110;
        Thu, 01 Aug 2024 08:15:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41621sm909036366b.113.2024.08.01.08.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:15:01 -0700 (PDT)
Message-ID: <9d9436b3-4a6e-46cb-a98c-f168bfebbe3f@redhat.com>
Date: Thu, 1 Aug 2024 17:15:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use pcim_request_region() in vboxvideo
To: Bjorn Helgaas <helgaas@kernel.org>, Philipp Stanner <pstanner@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240731193605.GA77260@bhelgaas>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240731193605.GA77260@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 7/31/24 9:36 PM, Bjorn Helgaas wrote:
> On Mon, Jul 29, 2024 at 11:36:24AM +0200, Philipp Stanner wrote:
>> Hi everyone,
>>
>> Now that we've got the simplified PCI devres API available we can slowly
>> start using it in drivers and step by step phase the more problematic
>> API out.
>>
>> vboxvideo currently does not have a region request, so it is a suitable
>> first user.
>>
>> P.
>>
>> Philipp Stanner (2):
>>   PCI: Make pcim_request_region() a public function
>>   drm/vboxvideo: Add PCI region request
>>
>>  drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++++
>>  drivers/pci/devres.c                  | 1 +
>>  drivers/pci/pci.h                     | 2 --
>>  include/linux/pci.h                   | 1 +
>>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> Given an ack from the vboxvideo maintainers, I can apply both of these
> via the PCI tree so there's no race during the merge window.

I'm the vboxvideo maintainer, merging both through the PCI tree
sounds good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





