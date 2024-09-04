Return-Path: <linux-kernel+bounces-315256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7A96BFFC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4991F212D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C111E00BF;
	Wed,  4 Sep 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="L//CwsBT"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB41DC048
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459458; cv=none; b=ZkstwfjkZUmuJZ1w5J6A2VjTYpW2pc6euOCdeHG2XSf+/L5dmmKk7x/o9jXCUCkdx0xcmnnhpLDTGEgLcR1N2dZuilziPzykNP4YcGTFJjqcpgCRhY34LGMoCSQjSJSwzFY/7/4p7moCmTZxeD92EMc0O1VHcQSHAirGc4+kMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459458; c=relaxed/simple;
	bh=YpWYjehxqSoX1O2diBW3rQ+5LlYEhl8sX1+bGP7Buqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCKthkdgzsrLSHP4RT+F9uWMM39SZnwe9QXzB/CzsUkUs/VIZm8he0F4xZi92bytYo4y4xoDggCJ0KSnC+s51asc73866jPBbVne0ZQwboJOg4KtPySOQTstbWjcD9l4cbV6Rz9q1WiRNwKM9dEbsIo5CsvZs6b+xybD4wl8hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=L//CwsBT; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70f5a9bf18bso2837088a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1725459455; x=1726064255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpWYjehxqSoX1O2diBW3rQ+5LlYEhl8sX1+bGP7Buqg=;
        b=L//CwsBTdGKXX6ghHsPe+1TKAGSg2/sAr0ZjZY+oa5oVrAjuHMSWcmxS2dGYW34FhT
         LzgQNowoSi/vrR8zwEw+zWJTAMIxPEhcgF4leEJwJBc4HQrNxvi0IjGFSGcNnxXPhXdH
         Qtm7hTEzOq3PsnTO/gHtFi+pmZFkthGtXd1Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459455; x=1726064255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpWYjehxqSoX1O2diBW3rQ+5LlYEhl8sX1+bGP7Buqg=;
        b=H9DwDfHfIUP3f8/FxI1l+nsH5ylPMnP0ReBicCKjyc/DrSX+ceO2xBkBgaKVijiUSf
         hv0SlOZUf01Cx4ItDX3InqxDEG8YDd71+0f84NN2JwtkRCHK9uQ0s8E7bf+E99gUlAHa
         2/itl6jjle1+azs37bdI5pyBKikvNlpbXx+ouywuklgoHTUEVU9EIoUejHiiE3Gg6KLp
         bK2kjKFg1WCm10InzQ5KUL0o4wb5Kky0wTVf+YaHq0/eX2ZDp5XAyMc+u78E+lXWURS7
         fYIjMpSxGKdDwE9EQrCul5DVGEueDp8LksW5e8WtqZV/v5EaydAyyRA50BAW7W7D1uQz
         /v2g==
X-Forwarded-Encrypted: i=1; AJvYcCVWxQwQEfIt84SJKlqKzeFFKh5FvEO0kWIAHtzloiMGVIobLR0n8eBkxhp+xGjq8p1k9NM0LOVRXhFgXsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkkXFmf+hUFjf2uEEHiAbYmf3Km4z4M3ARz9IcXQa+tzqMI36
	D5ejFNUz9aPtUIpX7vEtPRZz0h9HGNxYogkgDYhKL1674kBCtASmxZAD3kCdT/E=
X-Google-Smtp-Source: AGHT+IFwP+H+wYQzxGErCD9EQq5D9dyUypa2eD8A/emS3WXcZs6w9iPVclsGE4DXjzqy2S34HJ0W7g==
X-Received: by 2002:a05:6830:438b:b0:709:415b:8ab8 with SMTP id 46e09a7af769-70f706e25a3mr16758972a34.2.1725459454651;
        Wed, 04 Sep 2024 07:17:34 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f7781ca5dsm2028225a34.18.2024.09.04.07.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:17:34 -0700 (PDT)
Message-ID: <c2d0df0d-85ae-4605-ac37-71794105f3cd@digitalocean.com>
Date: Wed, 4 Sep 2024 09:17:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec
 compliance
To: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: mst@redhat.com, shannon.nelson@amd.com, sashal@kernel.org,
 alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
 steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com,
 johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
 <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
 <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 9/4/24 12:58 AM, Dragos Tatulea wrote:
>
> On 04.09.24 05:38, Jason Wang wrote:
>> On Wed, Sep 4, 2024 at 1:15 AM Carlos Bilbao
>> <carlos.bilbao.osdev@gmail.com> wrote:
>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>
>>> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
>>> with vdpa_config_ops->set_config(). This is needed per virtio spec
>>> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the device
>>> configuration fields are read-only for the driver."
>>>
>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> Note that only the config space of the modern device is read only. So
>> it should be fine to remove vp_vdpa which only works for modern
>> devices.
> Just out of curiosity: how will this work for devices that are not
> v1.3 compliant but are v1.2 compliant? Or is this true of all devices
> except eni?
>
> Thanks,
> Dragos
>> And for eni, it is a legacy only device, so we should not move the
>> set_config there.


Understood. I'll keep the ENI as is for v3 and will reach out to the maintainers.


>>
>> For the rest, we need the acks for those maintainers.


Thanks, Carlos


>>
>> Thanks
>>

