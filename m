Return-Path: <linux-kernel+bounces-511473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF5A32B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF81886B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05E2135B0;
	Wed, 12 Feb 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRAuzmba"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408C1E766F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377359; cv=none; b=ToJ0SlqBTzoR6ZO332FyZmr/Oagj0LJNLesEaW8GOqkUnXP6gm+BaHsMK19lGIaWYQ2FqT4dfPRPu5m0nsrPaelC1+oy4AcIDn4/Kmn+YDiylsN2je96ZOS14DJNd/mAc2PQzeIuLA7HqWbTXOs5UaWdNAnS/sqAjpgpz3jY7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377359; c=relaxed/simple;
	bh=/H0Ow0ax49EM+cGZKbbSFk8TFZ/F+XgIWPGd+ZN1HO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUE17Nr89d18qVwBMnNMNfuwjDAlP7tq+QskR5qmaSMCGWUPx64LivS3KSjO6TnX7XPbmiVAG5FcOdDfWtGuDwuV1/Cat5j839s7aB26QN1SLjebZsQLkZicFnd14JFC8C+m/l0VGS7O4zqdTc8v2vnV9rUIwnm4c/ATczZILn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRAuzmba; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739377356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VSICeMZDAE5cXiPbi9c2jhMAxahUxcdP42mCuizDPM0=;
	b=VRAuzmbaXu0DrF/p8N7jqFhvfINzDiz8UqWI4lUoHFzbHSCGccmliQ2SLWLkHGPfHimSEG
	s9HH0Du+IdqeCb5KV9iKTOl5SySeSVrTIN+CZe5OiddZxLbGiQ+SkitVimPwvfGQHP0/7A
	hZ31PU3IgVux0y/7uHSaTrTaXbvAj2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-rV4PGNiMNeKkCjZqrolaew-1; Wed, 12 Feb 2025 11:22:35 -0500
X-MC-Unique: rV4PGNiMNeKkCjZqrolaew-1
X-Mimecast-MFC-AGG-ID: rV4PGNiMNeKkCjZqrolaew_1739377354
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935bcec79so20469965e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377354; x=1739982154;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSICeMZDAE5cXiPbi9c2jhMAxahUxcdP42mCuizDPM0=;
        b=lC+ZNzrznGzzuZNR8uioXTotD9vbDk1X20lLq3IIY6E4MW77R0jmlY82XLH1W8I1+Y
         Up52pu3itL7VRHwDXRemGz5tAZyHS/YGFnEeX8b3PSGqgBoMkFQeBJOw/SF+8KPNS5yU
         Rpn+wis1BGfMpwsuuPPd6fjti8Yxgy0lOnAsWXwAWQ13cIERXfAvVOx8JiV3L/sc9vvU
         z2R+UWvSN+I9+n4fku32AAtl4i7GuRstaWK7cqcbPyM4jVkvy76Fq4BfmIi3NKhCtQEh
         lIzy5vic/WB1objNTHoHG/07BeFNypNInKdFru2wp+7oqXIqBeXqOXzslf9HDW3fYJnm
         ATNA==
X-Gm-Message-State: AOJu0Yz6ntm1wIo0s3+lrVnzV05DbN3822ySh6/cWGyKqbWys5OJ5DU7
	1dtegn1GY+Viq12gZ3cT6YgzvEwBcsFctJcSXQbhUirzXNXAzzsq+FPKeEd6TPOC2ofw3UjiCNo
	poscjK49zY5ghqs5G4vVfOWc4y8xWQYvtTy8eO4t0eJviEqjGf/zyHrw9f3yezA==
X-Gm-Gg: ASbGncsZYMKs0s6H7Xt46Z6/U3bpOsIFyZVXF3fUp9ixbpEsygVo7EzfxAT4GzC3avH
	3pylvw7877dd+XJCOWgtmgnXCZs3SVR2tIISjuPKeDYb8iKEYlS9K+7b1VM60vAegUhVxEcKGU8
	aPGr9c7bvtfckkJcWZPVnqvVcn8+iatv6EaCqLi0UMB6hDyRUGspfHog5X3KWpQGY7p+vtsdnT0
	LlAwFhBTVe503JuRgFFoogDXo9k5No6r39WnB35AK5fGRkaDbYztzmh4oLBLrQwpgInu5sYtMU6
	2cSiO7j2PX/zNMZFsnL+C9OX4gRfZ9UvtOZQoW4vhaFy4GYEx2qqhHNBYMklogFz3o7hD73uU7y
	EwNM5r90OGVIT9hDPbS6+FyzEDh+IJg==
X-Received: by 2002:a05:6000:1f8f:b0:38d:cdac:fc02 with SMTP id ffacd0b85a97d-38dea256d2fmr2848201f8f.4.1739377354267;
        Wed, 12 Feb 2025 08:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBBmQiWWUITzSTxmiIJL5JQLmWCDtdYHugQMW2LYEH7hp9pX6mIuLiZfsBTytJr1/YP78MYA==
X-Received: by 2002:a05:6000:1f8f:b0:38d:cdac:fc02 with SMTP id ffacd0b85a97d-38dea256d2fmr2848192f8f.4.1739377353953;
        Wed, 12 Feb 2025 08:22:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:a600:1e3e:c75:d269:867a? (p200300cbc70ca6001e3e0c75d269867a.dip0.t-ipconnect.de. [2003:cb:c70c:a600:1e3e:c75:d269:867a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc5a8a9e4sm16625450f8f.10.2025.02.12.08.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:22:32 -0800 (PST)
Message-ID: <e5ca0482-a193-4449-837c-d7e3fd4d1151@redhat.com>
Date: Wed, 12 Feb 2025 17:22:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro
 definition
To: Liu Ye <liuye@kylinos.cn>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-3-liuye@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250212025843.80283-3-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.02.25 03:58, Liu Ye wrote:
> There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
> used. Write it as a macro definition to improve the readability and
> maintainability of the code.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>

I have something different (better) in the works:

https://lore.kernel.org/linux-mm/20240829165627.2256514-3-david@redhat.com/

-- 
Cheers,

David / dhildenb


