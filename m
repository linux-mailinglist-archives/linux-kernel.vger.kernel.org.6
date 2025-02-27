Return-Path: <linux-kernel+bounces-537283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD74EA48A10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97E23A1CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB226FA59;
	Thu, 27 Feb 2025 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcADpQHH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B91D61B9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689005; cv=none; b=pYYIxtpc8F4gJtD/zxfOoMHOq+h8oP1ElwyiQ6j8aVVRcmsSvDFxzWrmK4R5DtwsLgX7HGm+jrHvdGsd22shf3AXg6exkOVO9NYGUBRV8ymlE8Ny/H4+TYIz66ftX9BgwiRuSQh2aRpNVX1ZKBx3SGUpR0ryCrsgKHeH6atmrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689005; c=relaxed/simple;
	bh=CvdwKDg7xY2gSv0lU9vQ5UGiP0lcMBC5UMzd/6dg4G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfiZiWzfTr0RytTZjIwgzFTgQGAoPrayFk+ZZGC2e5WER6D4dsBFhZKQujfSFYmBNE2/Mjo5puqnlPvzxkPW0LxTpnS0s5LvFyE+ic6L8KI/hRF45t7qIaUTh7P+7qF0iSR5Usq2RZvliwgH6gDDGBVRDOPkhEklL+yOGwPTXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcADpQHH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740689002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLzVMGpQ3+64AmofLOM+OD8cJgxT73OQ3RwaxSr2hSY=;
	b=VcADpQHHFE4X0Fd6oTBo28t63RFLi0EfDvpBZWBZWpijlB/TwNhkNduAOJ9lcEgxRy5BgH
	Bc91th4kCRVRj41xYRGPaH5MTkMdF5NGm9M01nmTSy9XsQPD6991n07elP6NTpLtpc5RoD
	We1PmWicfoytVqWl6z3KJWJP9By5nmM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-_CE9FGeyOSOlkUmJnaLfUw-1; Thu, 27 Feb 2025 15:43:21 -0500
X-MC-Unique: _CE9FGeyOSOlkUmJnaLfUw-1
X-Mimecast-MFC-AGG-ID: _CE9FGeyOSOlkUmJnaLfUw_1740689001
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-474bb848a7dso2879841cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740689001; x=1741293801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLzVMGpQ3+64AmofLOM+OD8cJgxT73OQ3RwaxSr2hSY=;
        b=gOPVxFhELKuvhRb7cVJuoSorXOmXxzp0NfSpnThBFQV+8FYBVOv539waKj82ZQnZEj
         uP+OeKfsbOdIuApx5YzMKHjftG5cFES97y9uMQHXrNv6cxUV0k4PgFM3uuUlUeVJZo65
         9GvRJbiXF/W9oIy+sT2H67Atq/mWwC/Odel6EDGTjg3nZXnO6tOIBgYIXRtErwQyWUm8
         tgLERnTWx2q54doMBMSUFaYgtytjFRGeBga4U4cFc2hluX8ROk1qxW8a9UslpGtGOXXq
         kq2Xtv+GlbcEwvYtjDODv7cyCQn6+hR8bHOsUZ9LyrdbvIwgQbs8Gwh7cy+fSC1O+qyY
         pUIA==
X-Forwarded-Encrypted: i=1; AJvYcCVJO0od8KRqpuEsPPWdlF1aB+9mFbOLCyUaOE1o+HUV2Olu2dA0u9m/lb5pq/OoqJmMlQNMkfSnjfLjdW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwyaebQnwzJGCWFcJ5c1RaPjRUGUgQpvE5P+qfi047lYsVEq5
	KPXr4Uhl7Tp6m/xX4GD2rwDul/h9I3HxXhzS8eMeBFsAHvoZuDQVIoxXCZfiNNybsWrXVY3azR2
	3HaBQA2ad1wJyZtWJldWPeG7msCkReQRYivEhtbebM2kIrKjn5KiEUdvKChfYdA==
X-Gm-Gg: ASbGnct1dbaeE9dFRBCYsFZUg+gJFcOxFUFBQ8IThvpx5HAAQK15bpTbbFWUEPe3sZ8
	hom/+glaHPtP7mbwUI6su4i0SaOTHOx8FM9d0cVZAywn7IbIF4v+8pXxlaXtLyvvG9XkOikfdt0
	tDnN2mldvWkvWKI9kOTIwinLBupiqiLtxmV+bls0M7iTNuUqelc9Ny+Fovxs5zLlSTAFuNDgmNy
	XLnf6DkvnFwjVVEHkGv4xE9XgZUGWGyAgmZvQYJvSxR5JR8snA6pgF7/x7TbnDgaD4x+oJ7np07
	JYERSgZbjnXGawk=
X-Received: by 2002:a05:622a:1ba1:b0:471:bd5e:d5e3 with SMTP id d75a77b69052e-474bc0f42f6mr8394281cf.38.1740689000791;
        Thu, 27 Feb 2025 12:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE47+5mOAR+v6wUfVnqg2K6hIMrSfsz3wH5rCj9Z7Js/E9C5WjePcsXbpi83rsrpfI2eYeUrA==
X-Received: by 2002:a05:622a:1ba1:b0:471:bd5e:d5e3 with SMTP id d75a77b69052e-474bc0f42f6mr8393941cf.38.1740689000497;
        Thu, 27 Feb 2025 12:43:20 -0800 (PST)
Received: from [192.168.2.110] ([70.52.24.57])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bfc76sm15531991cf.46.2025.02.27.12.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 12:43:19 -0800 (PST)
Message-ID: <4196e42f-7b04-44a7-ac34-6ca2e9190c21@redhat.com>
Date: Thu, 27 Feb 2025 15:43:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
To: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <174052227763.2420464.2784848656225511807.b4-ty@kernel.org>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <174052227763.2420464.2784848656225511807.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-27 13:50, Will Deacon wrote:
> On Tue, 25 Feb 2025 11:46:36 +0000, Ryan Roberts wrote:
>> When the range of present physical memory is sufficiently small enough
>> and the reserved address space for the linear map is sufficiently large
>> enough, The linear map base address is randomized in
>> arm64_memblock_init().
>>
>> Prior to commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and
>> use it consistently"), we decided if the sizes were suitable with the
>> help of the raw mmfr0.parange. But the commit changed this to use the
>> sanitized version instead. But the function runs before the register has
>> been sanitized so this returns 0, interpreted as a parange of 32 bits.
>> Some fun wrapping occurs and the logic concludes that there is enough
>> room to randomize the linear map base address, when really there isn't.
>> So the top of the linear map ends up outside the reserved address space.
>>
>> [...]
> 
> Applied the reduced version to arm64 (for-next/fixes), thanks!
> 
> [1/1] arm64/mm: Fix Boot panic on Ampere Altra
>        https://git.kernel.org/arm64/c/2b1283e1ea9b

Just in case:

Tested-by: Luiz Capitulino <luizcap@redhat.com>


