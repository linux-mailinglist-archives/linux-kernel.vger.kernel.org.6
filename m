Return-Path: <linux-kernel+bounces-555754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2348AA5BC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DEE166127
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35427225A31;
	Tue, 11 Mar 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDOGKZER"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4421B9F4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685668; cv=none; b=NGzx/5Q2qCd3PElH+cGWaY2NVhPW7xUzhYYMsEoDzqU0o5u9hQ2Mk3GM5oXqx8pluNUU2nNhwpv8Wocq6fYYhlkmlsu7SKe1Ze7exFSvWbwdF/zjYYYDHQj74acBPO4fw+r9xqCJMrDxtRdDfUsmvCeJuEsjGXalmHm56mi2FNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685668; c=relaxed/simple;
	bh=E0NwvKASZPyObVYbZfH3bD9VvpvMfX0CZCdK+phMkiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHYadxmu5SVElQ9Ba7kRvzvedIY51gRNG/+99V9bCmmz6G41ZxuRySt0Gaw1oG6dHP6gIwAqLknz9Rmg1UgRZDnnX5KyuyJOyxFQFLAxvcJqUcM6U6nA3ntkLn5JgYl7xzrI6Zgpp/hd1dM45HM+NDOJFBCbg8GjWk7lvf3cXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDOGKZER; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741685665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mjioXSOPh5nP948TjCS7H8ic+JRCdI3QY48+85X3Tso=;
	b=NDOGKZERVMbE287QeWuCmyREgRxs0KOjuOsdZysjElG2g/Qt1aYebo1kp9D4v7P+z88ugp
	f0NQUjr0ZKPVGRaY8TfKTla93eyMS2ltbakn8F+nnsl5UOjBkxab6QmK7XL+1jwRoNVflo
	23//xL94/jvMXlPqyDSAYhtb0gGEJsU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Vm5zNY0dOiqXnPgwc3xlRw-1; Tue, 11 Mar 2025 05:34:24 -0400
X-MC-Unique: Vm5zNY0dOiqXnPgwc3xlRw-1
X-Mimecast-MFC-AGG-ID: Vm5zNY0dOiqXnPgwc3xlRw_1741685663
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so11310405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685663; x=1742290463;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mjioXSOPh5nP948TjCS7H8ic+JRCdI3QY48+85X3Tso=;
        b=jS4JL4l0hhrGu+9VyNkaIgFXgsVXkMitTxqWC7wtSKfgY9vDfdfIeYb49cDF5LBmiR
         O4gASY4ePao/wfsB1QeLShk7gJzcPcw2qbISxqWPU7aXNQwfmcOHOEHFuU7Ox3LMWLPZ
         ZdFiuUO676xNrbFYH7Xa4FPv9kWNS+b5u/C6zlg1/IYmgnXHgWHm8xU8ZaoETJ3jA2r8
         mJQkpyWj1uULVYyzagAL9vbK07aXhvT67h5zGcm/bQIrZrr2KGShE9UKZ1HjecDb4NMN
         9xANmjhCdfMCgqfzHbDDXrY9mdIT/pQ2jmAhvYa69DqKwPRLZLRRXgG/NPbe+ykzltpg
         wQgA==
X-Gm-Message-State: AOJu0YzBjziWP/PbHWalZN9nTZHoqud0S7HmlrwTvSgI5nAAZzMemFnZ
	v6XHeLpBYvCnb1RedpBRxY0PHU/nHPgC/M2WlQ+jY7A03WD6PVbGhFK5aYxya5LAcefRe6HVchT
	ueDmQIAveZMyHn4YC75ZqC6p/VbSrYe8IuLNWGyNP33hlNuSQX0SMHQ43fkzv7Q==
X-Gm-Gg: ASbGncs29SvL6cfB5+CGrnC5YtyqhmopcYeLdLZqCjQqiyBtLhCdOYA9PWEfcG4sGPK
	apit1ZSp6CzD7KCodnTJMPB2yw+f8ZKz3hFlUjaiVaSMSMvpu5JBdqU8bCGvP9g6VaEOPhEuTQD
	G0NfjN26V+R1yiI1oScz/0msXXewSlMdW0UzGL09KPjkb3Wvuk0Qy3tVef8vA3UvWjMydz2ZQ08
	VBdxV2q1+plL6q0jEzhZK8V/3+rRB0TufqqjHOYSkRz8JJUPk/bK8QrxSHN0u0OT0vTWHiCa7/e
	KHHM4gVFUg3FRckTIWHNzI8k+JNaV8X0LFwALYbpIjrPTwbm+1a7QuPyzRXlXSzAvgcK1SVFb6Q
	D4ivWisj/zqANr2vGNMpQmVW8AkvWQHQ08fYGUi1VorU=
X-Received: by 2002:a05:600c:4f12:b0:43c:fc04:6d48 with SMTP id 5b1f17b1804b1-43cfc046efdmr68081715e9.0.1741685662026;
        Tue, 11 Mar 2025 02:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdoJMy9vsVDWD473gC16PsciRDiS18nsWVL/dMCkHDK+y9VzndPwoBOr20CgwfdN+HA28lSA==
X-Received: by 2002:a05:600c:4f12:b0:43c:fc04:6d48 with SMTP id 5b1f17b1804b1-43cfc046efdmr68080135e9.0.1741685660034;
        Tue, 11 Mar 2025 02:34:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427? (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de. [2003:cb:c720:ed00:a9b3:5954:823e:3427])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf27f8ef3sm79112145e9.11.2025.03.11.02.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:34:19 -0700 (PDT)
Message-ID: <8877fbd0-db74-4dd8-9ba3-8e49fc5e1bd0@redhat.com>
Date: Tue, 11 Mar 2025 10:34:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drivers/base/memory: Improve
 add_boot_memory_block()
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20250311004657.82985-1-gshan@redhat.com>
 <20250311004657.82985-3-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250311004657.82985-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.25 01:46, Gavin Shan wrote:
> It's unnecessary to count the present sections for the specified
> block since the block will be added if any section in the block
> is present. Besides, for_each_present_section_nr() can be reused
> as Andrew Morton suggested.
> 
> Improve by using for_each_present_section_nr() and dropping the
> unnecessary @section_count.
> 
> No functional changes intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


