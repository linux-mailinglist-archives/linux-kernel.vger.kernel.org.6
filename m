Return-Path: <linux-kernel+bounces-223387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442891123B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4056B26A58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F161B9ACD;
	Thu, 20 Jun 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCVjuZzS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C11B4C3D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911884; cv=none; b=duOAZPfS3HC5VQ3Wh9orGsk0wx34WP1Gxv+YoK/k8iSGekGngUX5aoGZF41ThplWPeOZiSwDihnBPM6WjJxNHJPh29F4ooS/YlkKaNtckeKyRJJF6kylopf5uCxMnbQ2C00smjqwcSTIcJDpmHmBbNPkTeilTxgmW3ypa8znZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911884; c=relaxed/simple;
	bh=IKAfJej3/bz5YlCG6l6nJNqS8jTbUdfavV3jmwAtIRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBo8/JkGBEbFGO8/7etI262vtXQvNbdE9bD1VnIXfxP7F8TtVuBqpUbv0l3wTRdVtK6ZI6wyBwiPu1FvdIVKS2fKzzP4aGf6Sl0u3In2kycnpT7jKfk2fNh6jMuWGtrAz7y2Rjf2k5BKqfGTWmg+7wcBxDRVhyZYKNRLcnD3EuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCVjuZzS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718911882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G45UoON6v+it5Xc8gJfipBY0/k2jsQBfWJWN4FYkCH0=;
	b=cCVjuZzSZGMnHjq+prV+ZsuaR1ZNE+w8HoJKOLGyBpSmIMYiK+V8XyL8s5GoM0qaTSTAXc
	oIj15FBMZo3jB9jXhLSzaUSacfrwnDQbgkSaX5toxeJeC6glPicPq2N3LvT8H2b+2j9uBd
	Bjp1E7blD/osliqszt5vofye67nGYgE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-Ij3dLYJ3Oee3gRUR4TZY4A-1; Thu, 20 Jun 2024 15:31:20 -0400
X-MC-Unique: Ij3dLYJ3Oee3gRUR4TZY4A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36248c176c4so489356f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911879; x=1719516679;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G45UoON6v+it5Xc8gJfipBY0/k2jsQBfWJWN4FYkCH0=;
        b=AlVTGJXS6IqcMK7wBmhqNsgB0n8SRXCM4XXoccedkRWL08rdO7qBMSSzrpg3ge74nr
         wNalzVIl3vyx+oass33VFRbc7eQci/3NLgemCWX+H9sZjr5CvCiMmme1rINXkPxNg99y
         WfOvCgEjZqBMCiB4U1pOh/B66OAxI8KZYpOQMiTT7OTgZ+4cVwzt7kJDLvpuvqV7mu3e
         B6R/ihuyhNj2Bez/tim7z53FAijBEdh1zXTGrRXY5SMZGO0UgX6THumNS3MRESX9QMuw
         0pxhE2qvWNld1fFoI1Gx63AkFxa+FZjLQXwxLTa9ZE+SBxu7ghs4bSuLr9hcY+cw4/Ro
         lraw==
X-Forwarded-Encrypted: i=1; AJvYcCX0DiHYX9nWWrfZQXBt5HbxXiRHFzn2gtADh0Te3OvHxDBCFSGJtl7rZnUa6WHdkpOcoHtJpkc6/90YV5/Pk5WN6H4n36x70VppAfWb
X-Gm-Message-State: AOJu0YzJFm5+dYzJyrCBGs4JnygKM6zRmy0s7CuM/Qol03dzjnMPn+c4
	2iYYNbzQ8QsHow2hVvjrGTYSJiA41tOaSG0PO3YZ0TQlSoIwb7WZOAxUJU5b3nRiiQyuDELx28E
	eDQ3VF1USQz4qojt7WaQAVoAL6GPhQCZQ4L4lFzQU+6J5qFPjyE13dTIeYvnXDA==
X-Received: by 2002:a05:6000:459e:b0:35f:f90:f383 with SMTP id ffacd0b85a97d-363195b1a17mr3954385f8f.56.1718911879366;
        Thu, 20 Jun 2024 12:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFPX9p5DHYoAnqSxI/KYGBLxNvxCKZJ9fr0+v5glAOA4M8Akmwl58KZHLYUyco+zkPvuXAjw==
X-Received: by 2002:a05:6000:459e:b0:35f:f90:f383 with SMTP id ffacd0b85a97d-363195b1a17mr3954365f8f.56.1718911878933;
        Thu, 20 Jun 2024 12:31:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3615d7a1a0csm8022368f8f.23.2024.06.20.12.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:31:18 -0700 (PDT)
Message-ID: <d961070e-d261-4227-b044-dc73f9f8ca16@redhat.com>
Date: Thu, 20 Jun 2024 21:31:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Cgroups <cgroups@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 jbeulich@suse.com, LTP List <ltp@lists.linux.it>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
 <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
 <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
 <CA+G9fYutNa9ziuj7aayhukaMdxKFU9+81qKAjZbQ=dQa3fwYYg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+G9fYutNa9ziuj7aayhukaMdxKFU9+81qKAjZbQ=dQa3fwYYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>>>
>> Trying to connect the dots here, can you enlighten me how this is
>> related to the fork13 mainline report?
> 
> I am not sure about the relation between these two reports.
> But as a common practice I have shared that report information.

Yes, I was just briefly concerned that we are seeing the same issue as 
we saw once on 6.10-rc3 also on a 6.9 kernel -- also because the patch 
list don't contain that much MM stuff.

-- 
Cheers,

David / dhildenb


