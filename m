Return-Path: <linux-kernel+bounces-197935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630958D70F1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDBD1F217E3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD66152DE3;
	Sat,  1 Jun 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0B5+T35"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8617BD9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717256087; cv=none; b=CY2/xw5/41YSp3jJM5g7s/ZIkBr88Qd07hNFPPCBzeV+WaNqDSOmj1dz4xm7rNobY7NlkndFu0RFYW4SAZRHsEusLUkjwBc1jCbM+kBX2CszC21FFWpRpipg8/iEt1zMHYepWTF8J268KRfT9Q04Q25xbs2BaXlLULH41I/biuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717256087; c=relaxed/simple;
	bh=XPq6Qkhk7qdzGup1JfRdfVer0utZQJ5ZoyRpLPVLZ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC2dA6L0AYDQwIt4i4Dph0O+qpnF5O4m5eDzTciiPOEzrTcjvNZIwhATyRcESdeCcGK5GJ8tF5YUrzM+5vnF8iywkKWubpCp8gjDKsc8b1zJH/i+cz8r1yyAIhcirDSbvEv8HfBppWsAtKnN5nGUZ1eeb/N/AWYZSBa4mrIM8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0B5+T35; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717256084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2QacpLrWBt2KXDo0hOhXCAz+jwCknJSRzclX8saHx00=;
	b=g0B5+T35zr7F8fRtuM5TrPMV5DKgp1GtUVjjT003A5a4cHlWZMJAQ0JigPcKPd7UbYUQOh
	1SDhArJO5MJHCi73iN+uGAVRaRIkoH1Tn46WOhg0oWpCpi+D3/rSacAY5CVt7NT+94CdoB
	cgQI0w4Fiq3XvEc0hJpecK+hJUW0+DU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-t1PS9bhiOJyaIWxcBfisUA-1; Sat, 01 Jun 2024 11:34:39 -0400
X-MC-Unique: t1PS9bhiOJyaIWxcBfisUA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dca12cca8so1393354f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717256078; x=1717860878;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2QacpLrWBt2KXDo0hOhXCAz+jwCknJSRzclX8saHx00=;
        b=G6X2MA1GnDO82pE8/pHxc/AfQVgSromoRM+Np0zznSWRvhZ4W5Qp6Szdt0jlpUQWqU
         0Nukmo63j6CmGhpCWWu5HHPo6vURsDv+zm8MPOBLKVZiBrV7gZ5wHMQyD4L4v1G87iaA
         h9GeDqrhyIBF/bG2fgoJ8kvX17JwiwGTn+F0TY6oDsloEX7XK6zWfNWiP0xC9I1ed/v2
         xhTTQEndwLMxIOqPpyepLpB3hhQ0na0LOh0wDH3yGyAyhxs+GVfjBic1r9xfYygfxNwr
         mI25vKvotrkwy9fILwKXeWvK9YE9KQcZ9nSbU/mEQOLUl6H2eLSeuLzcCvdBpnRXoqeO
         zSwg==
X-Gm-Message-State: AOJu0YzxkYi0XSjjMU7MGErR2rmYNzKuzePUZk7tfPaP+gKkZYLdfoWU
	EVDmYbJi8TGUEFVJ25D9Y557sS1fB1skaiVib6wQ5QVIsgRXaFPMkShIP2gL0uKiJ94bnkdyFfi
	ChpE37kunrdryYqiIWZcYk6BMgxYE8Pk1Z9KUPBe55ayuJdl5+Q35NUAHP4SpWQ==
X-Received: by 2002:a5d:5267:0:b0:354:f144:43e6 with SMTP id ffacd0b85a97d-35e0e5f5b94mr4522600f8f.30.1717256078351;
        Sat, 01 Jun 2024 08:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA5cNtcDXSFaiYMlBj29RjQBo7zIkx8+s9BoybwEP0kR8HKL0lvOwd4zyavyjfQ3ucFiVKLg==
X-Received: by 2002:a5d:5267:0:b0:354:f144:43e6 with SMTP id ffacd0b85a97d-35e0e5f5b94mr4522584f8f.30.1717256077930;
        Sat, 01 Jun 2024 08:34:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:b300:1d59:157a:ba27:f7e0? (p200300cbc71fb3001d59157aba27f7e0.dip0.t-ipconnect.de. [2003:cb:c71f:b300:1d59:157a:ba27:f7e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04da967sm4263993f8f.63.2024.06.01.08.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 08:34:37 -0700 (PDT)
Message-ID: <4a62a028-570f-43f9-bee2-d91276e075c0@redhat.com>
Date: Sat, 1 Jun 2024 17:34:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: init_mlocked_on_free_v3
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 yjnworkstation@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 00107082@163.com, libang.li@antgroup.com
References: <8118eabf-de9c-41a7-9892-3a1a5bd2071c@redhat.com>
 <20240601140917.43562-1-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240601140917.43562-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.06.24 16:09, Lance Yang wrote:
> Completely agree with David's point[1]. I'm also not convinced that this is the
> right approach :)
> 
> It seems like this patch won't handle all cases, as David mentioned[1] before.
> folio_remove_rmap_ptes() will immediately munlock a large folio (as large folios
> are not allowed to be batch-added to the LRU list) via munlock_vma_folio() when
> it is fully unmapped, so this patch does not work in this case. Even worse, if
> we encounter a COW mlocked folio, we would run into trouble (data corruption).
> 
> Hi Andrew, I just noticed that this patch has become part of v6.10-rc1, but it
> has not been acked/reviewed yet. Is there any chance to revert it?

Thanks Lance, for paying attention. I think I spotted this on LWN and 
thought "I don't recall that we agreed this is the right approach" but 
didn't have time to follow up.

My opinion on this did not change.

-- 
Cheers,

David / dhildenb


