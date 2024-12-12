Return-Path: <linux-kernel+bounces-443251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B6D9EE932
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4791F168B74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BCE22371A;
	Thu, 12 Dec 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyqiVGFZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB7223328
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014453; cv=none; b=bG0/4aZMn14ISBcLbvfGq4n/ILbtReYW4uLilL2t4KRq3bc4Wp5jNy3SKeIT5T16im7JzZEbd1MSGNBgu9Hgr5AiofBCvjuhmLj+wyMUE+W8yY4ertBpFPiUoXFdBwOED8oX4mvox6wqjqpMmlKj2QMqjvy/8wVzq8aExc4jVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014453; c=relaxed/simple;
	bh=pq4kjx6wXYmsn3m+p8xjTXclvk0n6mJpQJ27GCP51m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRlnPIsHi1ji0ebbI+VHffEbYZ2WyZMp3c80l7oK490+mjGL0hT1aUAGiU6Sxhqm+0I4L2o9Piv4dzJsm82IKaKoD72jxTBAvT3kwcIVt7aWii0ZHvXpn+vtwWzwiIcIlB++xyVijndL6V/YQIuJV7qkyDjn0ZAOUe62yx4gj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyqiVGFZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734014451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VUrQl5taa27uq6chWOmspETUHgzTYXj17hV2zmDfUO4=;
	b=TyqiVGFZd3CPO+ugNutlSfh4jv1jU4CStz3nFaG6JU43W73lhPaL4aTGOobkMnNLK8EefW
	rcIvFAfu/N6vJWoHk9doOM7CfeEzf+y3Fvkni7zdDZ4oSR7BY1Ko6PhXDpN7rXcB6QgNBJ
	6uPLNbxlIcYGEO7EHXjpJmHD9fuMzNY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-dPGk8xQAP_6c1SOM7ImnIA-1; Thu, 12 Dec 2024 09:40:47 -0500
X-MC-Unique: dPGk8xQAP_6c1SOM7ImnIA-1
X-Mimecast-MFC-AGG-ID: dPGk8xQAP_6c1SOM7ImnIA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3862c67763dso317545f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014446; x=1734619246;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUrQl5taa27uq6chWOmspETUHgzTYXj17hV2zmDfUO4=;
        b=MiRqyUGrrOrBiVk7dUlQB6irb7ynI5PWt+/lLPgec9FO4aCdCsNQNFB9rpEac/O8uU
         dkRuA5iqAr+V+QGsQp3jyDib9jjQBIt/xCGIu0WxXKrLYFFD2TUiutC+oGeES1k9S48f
         nz2IKxlXE2XIEu1+50FYrObgr0S9pTjP2PWilbokDpI4IAuZS0EuQEbGTnZ0YZTpTtTZ
         RN50Cu+gdqZ++bi10zFOl8arRREFJxXf3d6K8+HwlVUolVoZ1hn1Ac22/h3A5/lYd2Kj
         a794EXbjgDUS6+PV/uzwM93DNXmFYjPWPBrmE2X+s+xFFslOxBPXPN5YO7/NQGdO9Z+O
         1J5g==
X-Forwarded-Encrypted: i=1; AJvYcCW3roTDcwaCPsc4+re9QCHQ3mXSjqnOVbZvdbLSBQwUxRB5opN4WSHehELHr8CrEEFbFQECQVVsK6Dzo6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRBGIsevfwcPI54W5jeErmdTLeGyTTIL7II99/JVnTlIdWcS4
	Sr4N/jLrMqaU6lswlwk1LkhReMDzgcpNUuDrrwevaQowR0Q064eAjKEhdxFuDITQ3pVjpUH77HH
	MLda+EI1mDkSYIHp83P+HofOkFAKA0gQ9N5xY7Jb/0T3SrTq0ftYhQ6B7iyTU5A==
X-Gm-Gg: ASbGnctaK9163+kQn9TJxrXZkveK0IDuJOJysn5lsU3n36aaFZkUtl7NmLpJqAbDNTp
	milBHAACXxxjTDxY5SIe0bTyDtfdDaSNCIU7DYXq7mYfp/MItbdHtbsPDzgjUZFxBbIVbM1R04p
	EhJQhNtky9N60K7j46v0LKRxOqbwAsnKvyURD6+R0F6lTl5QhaUCy9uXyrYfWN4BUco7kwWilV7
	rwfv9in2VuOJ3XjF41q6sSWBQMNjl1Bid5qK1sFJbGVY1R8q92mSkr/eyYtWH4Ulz/+BBqtkPjI
	I1jw41aHHfzo8wSs7UEvB/zkI+v8IZueRIk9E3wmkDQySnS3HBcuI//X4LfMRHkuQR1Um1zUBii
	oMWeESxAe
X-Received: by 2002:a5d:6c63:0:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-38787685894mr3428487f8f.9.1734014446601;
        Thu, 12 Dec 2024 06:40:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK/pUsET6J8zXMw9kouZtd8hC/UB9h8dY9F+glFGxq0itDCU/4ifn96NPsFeDK1eFMPBFy7Q==
X-Received: by 2002:a5d:6c63:0:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-38787685894mr3428468f8f.9.1734014446287;
        Thu, 12 Dec 2024 06:40:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c716:2b00:720b:42a1:ba95:a3db? (p200300cbc7162b00720b42a1ba95a3db.dip0.t-ipconnect.de. [2003:cb:c716:2b00:720b:42a1:ba95:a3db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362555333esm18518125e9.4.2024.12.12.06.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 06:40:45 -0800 (PST)
Message-ID: <033e50f9-b85d-4b66-932b-ae21ca85b16e@redhat.com>
Date: Thu, 12 Dec 2024 15:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.12.24 11:53, Lorenzo Stoakes wrote:
> Update the MEMORY MAPPING section to contain VMA logic as it makes no
> sense to have these two sections separate.
> 
> Additionally, add files which permit changes to the attributes and/or
> ranges spanned by memory mappings, in essence anything which might alter
> the output of /proc/$pid/[s]maps.
> 
> This is necessarily fuzzy, as there is not quite as good separation of
> concerns as we would ideally like in the kernel. However each of these
> files interacts with the VMA and memory mapping logic in such a way as to
> be inseparatable from it, and it is important that they are maintained in
> conjunction with it.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

LGTM, thanks!

-- 
Cheers,

David / dhildenb


