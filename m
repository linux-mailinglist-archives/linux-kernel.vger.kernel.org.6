Return-Path: <linux-kernel+bounces-514536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71701A35836
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22C87A4A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4621CA0E;
	Fri, 14 Feb 2025 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJrjcONd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D321CA06
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519637; cv=none; b=lZzlXZ/fGiqwVtObcjFjXOZk4jlcKBbgE95jJ0HqhGyeL9c/OYSoivGNOnUljoD9R2vQKxod+cAy/zovXL1DjkYEC+LYxXguCgAGsdhReM5+ReT+258ub4Iru8isbB5okVSNtTNgG/s7PvMOC426PXio76Rce82+B8kdATlmCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519637; c=relaxed/simple;
	bh=vDxUBvxmSKyz/FzaJj69Nv0aYAfnN2Mn9MrnGbX1rno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPTq+3HsR15qQslQtSYGRnbjTYw7nh4P87lnuGhy+aO5XnvVCcY4YZg5H1PictM7Q+pmxfLULb+1GKXXvzxzXJn23NRRX7xrBGZCMiczS2eqrRThEpcViK1ZCXi1WgsiNhqDYvuOUDlUZMk4rcoMV7QzICXDwytg6b+mgZY41kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJrjcONd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739519634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kEDZ+JIDcxpD3GGJaWx3MAWVot7Pm/fMogHxIZP+k5M=;
	b=RJrjcONd2KH/32oj/CnyIBURsQ7ycOymUdxdDU/Q4e4hEy7ni0t76Cr5vlNURFQ9fqdQGx
	wXOeAiPFSlplUcAgaTOlOIiJLCFMSAeROcjWQW+bJ61qAUbCRv7709w/ucbMfFJ9DBo+bx
	3Zc3o/TM/o+jZERgD2r/hI9SeBM0DG4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-mXkxG-JzPHS2xOQRJADiBw-1; Fri, 14 Feb 2025 02:53:52 -0500
X-MC-Unique: mXkxG-JzPHS2xOQRJADiBw-1
X-Mimecast-MFC-AGG-ID: mXkxG-JzPHS2xOQRJADiBw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393535043bso10281035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739519631; x=1740124431;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEDZ+JIDcxpD3GGJaWx3MAWVot7Pm/fMogHxIZP+k5M=;
        b=wOGLitiydR7aCHvOq7GNI7PO0pOpBsqie23OD5fb3SKfGy/e678bdg4oR90/IpD+f1
         SnNgpK6nUjjM0mtslhchAWqZFLdaw0u3ZAEaF3+JqV9BJ7BbeO3knHGCzAtgH6/ph2gu
         jRafdgAHkeGrBmlc/uTLkWlis5Y2b2q5XDDys655iVQI066bCdGc/yPHhbKORBmiGNkb
         rRH2UPDNWLJIS5Zt8c8tUUR84ewTJTBKIoU3b/luIX+sfDm7q1IsVooCVwvyUqsvsZ64
         oP+dFDd3Pysm5QUGYiwXw4b32s9OdSrELv62hibsF00Q0Zh2Prn45qBgS3JPFin4VzaY
         b3RA==
X-Gm-Message-State: AOJu0YyiwrMrniF9AzfJ2ZEisWh57k+mGO72M5KaXmfThVFnr8nyvX5f
	jIF65FnZzswWGWSHV7hCSfe4FDV9FMjjpaBPD/KcEKrXIVvNKWqReLzi2BYO+hchBKLGm3svta6
	1LNLWV2e44QtoTrEro7vxRbu5AfSX1IJZN6vnC+udOTrOfx+SV7wDBw02Zy7yaQ==
X-Gm-Gg: ASbGncufNZ0VxYrorSy5Ofxy/z9Offoap8/y8WE/9MOjbk+qGC7COp90owNqhILVOwp
	N1UnbU+SL/N2xl/B+y3YK0hPDyiH/i36Xj+1LB6qslj3CVVdaSMeKEm5L7cjYsQ3CuAp+0Ks2OE
	IWOgffddftN49XOWMI4Rjo4w0eFUnZMwPb2z1eEF5CprBqjVCaopUT3aXVh9DUxgQ2/MbaPcTOh
	yT/DT+p3hztuE1q0zmhq0j9VGLawg34c05CAMDIJ+85uqIoxDwXdPYioGL38TdjYGc9DIfcj7zu
	vQRQ1AM27ADqjiJdjUkBHoM+KfU+WticoQ==
X-Received: by 2002:a05:600c:214:b0:438:a313:cda9 with SMTP id 5b1f17b1804b1-43960c068d9mr72489135e9.10.1739519631421;
        Thu, 13 Feb 2025 23:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+5CuK8f68ZCU3asDK4TGtwN1BvpdhynBS+N5ryuDYoRVIUWvkTxhqxKgzKxTARu8gmxe6UA==
X-Received: by 2002:a05:600c:214:b0:438:a313:cda9 with SMTP id 5b1f17b1804b1-43960c068d9mr72488895e9.10.1739519631028;
        Thu, 13 Feb 2025 23:53:51 -0800 (PST)
Received: from [192.168.3.141] (p4ff23654.dip0.t-ipconnect.de. [79.242.54.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618262d3sm37260545e9.22.2025.02.13.23.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:53:49 -0800 (PST)
Message-ID: <bfad9746-689e-4275-9d68-f8d062526412@redhat.com>
Date: Fri, 14 Feb 2025 08:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/base/memory: Simplify add_boot_memory_block()
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 akpm@linux-foundation.org
References: <20250214063504.617906-1-gshan@redhat.com>
 <20250214063504.617906-2-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250214063504.617906-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.25 07:35, Gavin Shan wrote:
> It's unnecessary to keep the variable @section_count in the function
> because the device for the specific memory block will be added if
> any of its memory section is present. The variable @section_count
> records the number of present memory sections in the specific memory
> block, which isn't needed.
> 
> Simplify the function by dropping the variable @section_count. No
> functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   drivers/base/memory.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 348c5dbbfa68..208b9b544012 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -822,18 +822,17 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
>   
>   static int __init add_boot_memory_block(unsigned long base_section_nr)
>   {
> -	int section_count = 0;
>   	unsigned long nr;
>   
>   	for (nr = base_section_nr; nr < base_section_nr + sections_per_block;
> -	     nr++)
> -		if (present_section_nr(nr))
> -			section_count++;
> +	     nr++) {
> +		if (present_section_nr(nr)) {
> +			return add_memory_block(memory_block_id(base_section_nr),
> +						MEM_ONLINE, NULL, NULL);
> +		}

Superfluous set of braces for the if statement.

Not sure I count this while thing here as a "simplifcation" -- the code 
is IMHO easier to read without the nested return in the loop body.

No strong opinion, though.

-- 
Cheers,

David / dhildenb


