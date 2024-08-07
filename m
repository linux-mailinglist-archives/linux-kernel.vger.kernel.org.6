Return-Path: <linux-kernel+bounces-278167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0407494AD77
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F70B2B5EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281CA126F02;
	Wed,  7 Aug 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZBo2z7w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AA78C92
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044822; cv=none; b=hZC4htgT6CDl4J2VJ6zJ4EixhSRVT1TIRP7VeXukuYEclLwF+39RV8viu7BdhAKz/QN8gKDP2jxjG1qRbOzAlnB4oS9LBiWJ2ijjtTmLGI5j983ggJbt9dFiO5N0JnBop8cJLWJfIPCrxLFKdO8IpjfvMjkcbzGmrvSgQtctOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044822; c=relaxed/simple;
	bh=FQDm6uPHaMYhDRuuw4zkGlvCn596TtwS824ahUpTCj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpSGeTRn8ZzokABNv8VaSNkDo2ZyIZaxGCnWLvm9nMRZoInHAmsiC1C7xvJeOTEtMLdbHKxrg8ieoZFT1XmB0h/dSfc1TCyHBqToGynJDqGvzW3YJH4xlq0s5ojUmZlyw3xyEhcLHZ0SmRy5b99/nyab1UIs/FxHvJGgFArlgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZBo2z7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723044819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W8Fg8Pv+3HchKikqnrzk8gQaiejBKWgDRh2fN7cA4nk=;
	b=FZBo2z7wZTa7ayZyYV5pbsw8K/GPJQc+9XG/ZiyuTh3u33kftL8NwA6+q/PQQcCs0uin4g
	/PRRT/0G4lqm7vCynN8mzMRNFAsTLuJwFl4XCO6vSRsMHkpG1ea2SG+qAbRre2wr6Ot8TK
	ghWYsCE8ZVtUIb2B8OJuDhfsGbvM7R4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-kCMIhRpBO6OPWM9LAruzmg-1; Wed, 07 Aug 2024 11:33:38 -0400
X-MC-Unique: kCMIhRpBO6OPWM9LAruzmg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef1b9a466cso21802301fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044817; x=1723649617;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8Fg8Pv+3HchKikqnrzk8gQaiejBKWgDRh2fN7cA4nk=;
        b=nLhXu48QEiq8d+sauZ+Ls9ktsa4ScVLaw0PYcp22tB5NPI0qxk19Mc28MQyvlgAGbS
         L9+IwCPceh6K+1HibuldGKSktTVfSzFyGQ+nRP7OIwhHXtANcLdv3aiXZ3p6rgnF5hVt
         si5cfGRR8a5l4hxp2Mc5Wdf7MDDvgfzWbY8pDRoM263xnbTPEjDr/UrWkR3R6sJTczl6
         mbw1tx6SAyFkKpYlUEj//YkY5KWOIKWxTk2QM4AiRnifhB4OGnuvIOe+u99f27HTZ6t4
         5TGeN058ZrQjoONlCzj8stWcR7zIfBfSeR+wpwoa/+t2ydzgVS0YQirwOnIQpFHKdrZL
         wVow==
X-Forwarded-Encrypted: i=1; AJvYcCVgPuSrHT5Ahqb8g31dh9BTtfsf0BrBvdI4wzs1FqdGS/cB4RZpPo0OOwLunAnbgWLzsJ8TTwR6FIKcsfbAgZN8wKNvR3AwIzYBZ30A
X-Gm-Message-State: AOJu0YxAuRpfkUg31HIUzEYlhPtqXCetSfR0++qS8jQru0m/vlqnFuxe
	qsZ1uGLUJNFAXtWkcPfRxnznCCMWteIp3GF6MaBM+2sPYrFAf4jaiHQDccv7xaHgaft8I/nKi1t
	K0whYzLX1sr67H8YxA5C0wr4r/AFiInH4Mq15VwKaqm0j5eMA++2q9AySahFf+g==
X-Received: by 2002:a2e:3505:0:b0:2ef:2e8b:1802 with SMTP id 38308e7fff4ca-2f15ab0bcd1mr130996321fa.31.1723044816913;
        Wed, 07 Aug 2024 08:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk8y5+FegzpZO/Fru7AN0xnfLT7UbdZEsxslpVwmH2aOUZDQagKfggY/VwKamE3uObs5lFuw==
X-Received: by 2002:a2e:3505:0:b0:2ef:2e8b:1802 with SMTP id 38308e7fff4ca-2f15ab0bcd1mr130995931fa.31.1723044816259;
        Wed, 07 Aug 2024 08:33:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059714d5sm35409145e9.13.2024.08.07.08.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:33:35 -0700 (PDT)
Message-ID: <ed2e3668-c6d3-4669-a340-06fb156d3369@redhat.com>
Date: Wed, 7 Aug 2024 17:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] powerpc/mm: Handle VDSO unmapping via close() rather
 than arch_unmap()
To: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@chromium.org,
 jeffxu@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oliver.sang@intel.com, pedro.falcato@gmail.com
References: <20240807124103.85644-1-mpe@ellerman.id.au>
 <20240807124103.85644-2-mpe@ellerman.id.au>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240807124103.85644-2-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 14:41, Michael Ellerman wrote:
> Add a close() callback to the VDSO special mapping to handle unmapping
> of the VDSO. That will make it possible to remove the arch_unmap() hook
> entirely in a subsequent patch.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


