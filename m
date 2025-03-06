Return-Path: <linux-kernel+bounces-548544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA33A54646
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EED1716F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67591209692;
	Thu,  6 Mar 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBaPY+11"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACCD2FF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253304; cv=none; b=IvZiCJCm9LWRCqClZ3bXJUn40Nw5HgrbAy+BnG0AkMtbPR1ZE8mYNHBGtOiFFm6VJ+vpXyl2rD/h/JUHi/dCBIDQfSAh08qyVAvLuHcmpBMdBM6XN3uTyY9Kt28KwFXI73eOo1ZXafRJlKVp9khcdlhH2GefPRNxLzyhI0Dlxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253304; c=relaxed/simple;
	bh=e1FU4/LUiVNBTqldIDpCuyOXjaB2MNtq2Q3AsgjVgO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyEhdSSMPX9L8XHAgLtz26zRBAx6JUqikr+GUxQYETZFCBrSRt6dfBTpq7svSMhGq35qPcdHGqAfttq+hMlaoI/VMWYd5R815FniTc2C8sdT8lR6FaJJsXpUJjl94cHWVM5rmURVWH3VvQtQUjgW/TC45mvLQ2U/0EeYYJrmi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBaPY+11; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741253301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fgOIGFO0KNslC6ocif/kgfcUvHoBKSQ+gkoKczc7WGg=;
	b=QBaPY+11CwyQgfH3aHpiIMqWniYGmHJINowulLhKMb+0Lq0r1ezpKEaqrSiFsHusw8WadQ
	CcqiyM+Qbeo2RHsOgi6uFR4JJz1/DXve3oiRgA9+8hF6okiSArhtEksDhJZSjpx1Bb3x5b
	vAF4uuKt3MEYlyHT/m5Yvdc25TsNW1Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-afIIqJm9ONK1zCv2jn7I0Q-1; Thu, 06 Mar 2025 04:28:14 -0500
X-MC-Unique: afIIqJm9ONK1zCv2jn7I0Q-1
X-Mimecast-MFC-AGG-ID: afIIqJm9ONK1zCv2jn7I0Q_1741253293
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391079c9798so197114f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253293; x=1741858093;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fgOIGFO0KNslC6ocif/kgfcUvHoBKSQ+gkoKczc7WGg=;
        b=A/Z1KxP7ngG0FJKYTku41E4C/F1Mi2cd4RjBi2OGcbdS2R22P2ECQcp1Bzwhd6cD4Y
         JlS9aXACA1bS+FS2MKR7kaWsNyje3f9xSYbshRY0/GE+0/qbYeGxP6zxVVxY9tiRhjEo
         6hi8Y/oydVaBzQ348ackRdZ7/qGsaeg3EJItSjquby77zsL9Yn0ck0YW5Mua5c0yONbN
         rWjM3tVcK3EqBzLPT0VmWnspwmqLOgIWo/ziZQHLdOJ/DQGDNHEOkJGpBjCVhMhDpoa3
         Mc+k8giNAGYUcHn8RwMSVKXSfXz8G/KKRQvy244riNZSknYUjuWfYNGHdnBviRIFAYFN
         7JmA==
X-Forwarded-Encrypted: i=1; AJvYcCVQh2huemPqhFn1wISDq4Npp3ep6tUVGNyG+s4F1W9u5P3wq+Bjw0RJ57U/imIT8iwnObUUVVJECYxmnh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYcrZUe8Z4QSKqRJNqZKPV1USo7ZuerimFjxBckqfYsABogS8
	2p3yAi7JGzAKWPHgI/FOmUCOuPnctkYiJkgCiRR3b2oDEf8tsokcculJtkmpr3++WMJwrGPUVsN
	AwcmiK8M6PuubkCEZX9v86MLb+t//UdSF+RbQqem43dLQbG7DK/WxY/P9+vQQ5Q==
X-Gm-Gg: ASbGncsY6en4EdmemhntrsZfJA1O+7A1jJVPkjmz1ngtNUymF50tS9aCYSPyb7uLii1
	EON4k0HEh8afG4O/RAfrLGlHo/ZIilmSfKfb/4askzZK1Z5u3v/qc6uZrWEevhaE/5YsQpeleMU
	4hctsxFmW9t1ixOC+qAMlTF6wDSObsXtgVUSpF8YYAJjiOXnUGtXqA2FfKigtMw0y0yePUfFcvN
	Shm+4Wdg0VLsgh7z7zZDSsuM8BQmrYisVzNq5UqFtJFy7+lT/Jw8Lw+F9sHXE7n4doryx15bqIF
	IpFkxvvgVsmb4c5VFpQ2iFg/AP1A1FxlbKo7prTlQaE3M3kKXXKiS1/9YIqdmBDefJziUM4++9D
	zRAO47CT+kJFBp5GzeM3dAMwX2HXasekTkDCsHrzqHKw=
X-Received: by 2002:a5d:6c62:0:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-3911f7ca744mr6005776f8f.43.1741253293331;
        Thu, 06 Mar 2025 01:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwciK0KkFRXPVUO9aQuqIhjlXAUuInlRk5dnn+MniJZY8Vq2QFnXscKZmGMNQehLBVRxPJog==
X-Received: by 2002:a5d:6c62:0:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-3911f7ca744mr6005752f8f.43.1741253292990;
        Thu, 06 Mar 2025 01:28:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba66esm1470172f8f.18.2025.03.06.01.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:28:12 -0800 (PST)
Message-ID: <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
Date: Thu, 6 Mar 2025 10:28:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.25 17:54, Brendan Jackman wrote:
> Some filesystems don't support funtract()ing unlinked files. They return
> ENOENT. In that case, skip the test.
> 

That's not documented in the man page, so is this a bug of these 
filesystems?

What are examples for these weird filesystems?

As we have the fstype available, we could instead simply reject more 
filesystems earlier. See fs_is_unknown().

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/mm/gup_longterm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index 879e9e4e8cce8127656fabe098abf7db5f6c5e23..494ec4102111b9c96fb4947b29c184735ceb8e1c 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -96,7 +96,15 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   	int ret;
>   
>   	if (ftruncate(fd, size)) {
> -		ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
> +		if (errno == ENOENT) {
> +			/*
> +			 * This can happen if the file has been unlinked and the
> +			 * filesystem doesn't support truncating unlinked files.
> +			 */
> +			ksft_test_result_skip("ftruncate() failed with ENOENT\n");
> +		} else {
> +			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
> +		}
>   		return;
>   	}
>   
> 


-- 
Cheers,

David / dhildenb


