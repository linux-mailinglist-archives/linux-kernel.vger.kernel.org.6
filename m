Return-Path: <linux-kernel+bounces-549230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B35A54F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E30165886
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43CF1990D9;
	Thu,  6 Mar 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQSW1ECI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EE148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275270; cv=none; b=jW5MMWyideX/shrwd2LjhSFnXLZugm6XH0cw9iuxwS5NYqKM7AoSVtcDwp/r6Or4vH876hpBOG7dNtj7iaJrKBDhS2sGQgO+58UBITVtydS88xeJLASMvRDqVxQylRHDXU7JGaMT7Ndng9io27iDjNHh9wpzN0OQYzr102FevLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275270; c=relaxed/simple;
	bh=dORqdHjRb/2M4lxt4tNcsfXso/ebmoXE/PjMano4zfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ban74D3HFww8znVGADEOfSABuX6YZlcQIUd2tjJflGAw2HRCcBGjkHqT9rdQCPPdI1W4EtkRY03FZAwJV0Et5Nh6xW8cGYFfVJ+S8Vso/xykokm0jm0kUUOHU6+dRJ5/JU882KJZoABp7VSVzyv0NmXMAXvnOl6oDtn+ppTxnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQSW1ECI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741275267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zFDTaFPgOjNV4XHI4G1otZrO16JWIPtLrzju+UU84Qc=;
	b=XQSW1ECIKU+UEkekkRIdgFuiPw0olruwK1BCuOhuWq/vFLkbZfRtnZMK9iDLOVDCv1FfFd
	qvo1iTfoj4xnyb94oZ2e60MEnxtXGkJDEGa9x5gsbklNpBXCbmZcxJKcRx/RLZQeQ+unPA
	gl/RUeHE2ThWFK3O3eSou+Oi9+bcTdg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-g33dSymyOVyicFmDwLg3yw-1; Thu, 06 Mar 2025 10:34:25 -0500
X-MC-Unique: g33dSymyOVyicFmDwLg3yw-1
X-Mimecast-MFC-AGG-ID: g33dSymyOVyicFmDwLg3yw_1741275265
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f3652842so493391f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275264; x=1741880064;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFDTaFPgOjNV4XHI4G1otZrO16JWIPtLrzju+UU84Qc=;
        b=Ff4oO9lvm8NgjZPXxuIY7PwoxZn4D1vsr016W23xriJLYqBhMM0kszuzVTWCJlQqct
         mCVyOmwlj2COLrw5qt/nXRgXRJRy3iLcYRYipkw9vLGdv5GLN+XwFPAvBPRRT7vkiRYz
         RkgRFNuDwiYr+4D3qFTzFsZ3gP7b1ZixZVel2vuhzPGmzSfJbS8J8eQ8s78OImByF4gG
         iulco9Q8gFmxM+k7uJvV9TyvZDFctuLm4fWvv6STy+DOWCpGrgRvl8WSykUt/MfhmMtp
         xNeD1vEqzIR7pZ0rZKBXMgNr6q04ouH/dFj0iIkukOBNMOp9fnNBLKXXXUNvMOMVJ4d4
         Ddtg==
X-Forwarded-Encrypted: i=1; AJvYcCVhwRZzv8PP1DN9zy4cZVeTVPnac8Rs38BM0SwbW6+7SEyqShOHoHfwhGbXxX29kTGRAvlR1QTrUd03LyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5aGiSCAsO0vHYN0m50yXLdg+QggYFwc5i/wUulw1UYEO5kPWi
	TbTYRnuz85uC/q3jvaI3a9BkxK83d4vwcIki9p4Vxu51lXny0+I1/9hokmuucJZl/zs1oVlILXd
	MLck9tJ4PETmsC5yOJgqULXniD/kKtYZp+32XFuzvLljiuXJcvLaEj+cFE2jsK8zPhOYmMD/k
X-Gm-Gg: ASbGncvcWZgPbrz8oRbOHP/N66bUQ4jkVVGXcaB6Vqw23vEIzSAMTGM/VUfYPwHBSk/
	GY7UxYRrfvcJMwWH9R9bxzoa0bAWbbFjzbqQ2CYbkAopwOpgBYphon5UWJYbnVS+8X9h7hd0hSc
	1qN9NALAmj9TyvuC97kDxlFm7dLXHUSiblJXMdu0yJjjEomdIbmUFcWymDkd7+0zgUcaX9MKCAU
	arq/q+koOgKG+1fmyb0HRwxA1t8xr+gF3lPL5GFAE93idC4WH7qkqajeFcfJ1fteVI4Nx4juvQP
	tnp3KUoh7Qcr/94UTkBgD5LJOjNsNQCNw2SBznpYxtQpMG9Lc4d8jXIBfp54J0uRiQuwS4p65dq
	QHF3NDcCz6UFrF+IobO1PWTiM9TIJmb2aFFFYz/1jNQg=
X-Received: by 2002:a5d:6da2:0:b0:38f:451b:653c with SMTP id ffacd0b85a97d-3911f72fe43mr5856296f8f.7.1741275264644;
        Thu, 06 Mar 2025 07:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNQhp/VRiJ1mX+q4SMp9ErfO69mHChDVohYCZYZAXtItPqxnjoLiHUFehIFb/vxV48tnZXmg==
X-Received: by 2002:a5d:6da2:0:b0:38f:451b:653c with SMTP id ffacd0b85a97d-3911f72fe43mr5856279f8f.7.1741275264265;
        Thu, 06 Mar 2025 07:34:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm2414373f8f.16.2025.03.06.07.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:34:23 -0800 (PST)
Message-ID: <0983d2b3-aee9-4432-b993-5617a5df0b06@redhat.com>
Date: Thu, 6 Mar 2025 16:34:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove redundant return in set_huge_zero_folio()
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: ryan.roberts@arm.com, willy@infradead.org
References: <20250306144315.21907-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250306144315.21907-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.03.25 15:43, Dev Jain wrote:
> It is the responsibility of the caller to check pmd_none(); in any case,
> we are not achieving anything by returning since there is no return value
> to tell the caller that we succeeded or not. So remove this check.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/huge_memory.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3d3ebdc002d5..f64212d674fd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1309,8 +1309,6 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
>   		struct folio *zero_folio)
>   {
>   	pmd_t entry;
> -	if (!pmd_none(*pmd))
> -		return;
>   	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
>   	entry = pmd_mkhuge(entry);
>   	pgtable_trans_huge_deposit(mm, pmd, pgtable);

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


