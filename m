Return-Path: <linux-kernel+bounces-396143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5689BC879
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D08F1C211ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162211CF7DB;
	Tue,  5 Nov 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvyHSUjw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06341C4A18
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797014; cv=none; b=BpYUREjtCIh1cR1/gV3wUOOejWsOQVLyqemzwPKD+74ZeDJ8gdc3J/n/+YkRBTOmiSEbbacOUuMoFWYs/A6VrO3vPz+30Q3u9bjBfOig1YL1Py8eqwnQ/VvSGbHYZbcUYKMJzLJpPV2i2Js5lbQUEwaqXBOdbIXiWqf2VOvKp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797014; c=relaxed/simple;
	bh=whM9GHfph6mVAmx3sUCUNxmfxly4iAyY5a7saMaZIU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAmkXFm466DP7SQINlXkyRvh51VyxzAWURjtBd3S1Ej6M5/VotUp3nMnzqMTOo877hhxLgAF6yLzxmJEjtYCSnMeRvKwc/yHjscnfs9ZwZhn7EkqUXqRsAsv7ABg/rP69IKEM22CpmSni58klRs5IdpYyXJFcd1UazkVe4wPKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvyHSUjw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730797011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oI/RD+qbJilGmZQ0OyHECrO1kP9vrPDTW6pPLpVgj7Y=;
	b=JvyHSUjwDhwxN7F+RAJZeaTtRWqoD7m0XItQ/k6jvKmr4xsMUIUESWQfrDaQwV76KuXv/e
	UJgJUTgfPDRgRI59wVo5aDYAaj0FBf4broQJCzrdRTyfmTggNd/5Jq3foyV+H10xAgB6On
	xpEpfromo13TY9y+NSmk/Dk8pTNT0pM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-_0k8kIe8MkKPB7iUaLndDw-1; Tue, 05 Nov 2024 03:56:50 -0500
X-MC-Unique: _0k8kIe8MkKPB7iUaLndDw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43152cd2843so30546555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730797009; x=1731401809;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oI/RD+qbJilGmZQ0OyHECrO1kP9vrPDTW6pPLpVgj7Y=;
        b=gDbNTLs+PfPr5cEN4oLkQTL3wGUJWgXfrjONTFzO1dQvZr75tzq6kCeosRPk1P+Pki
         KyP+j95eQrwcawoYCDBOEP1Hf9CSHdfhVF/az6wENpaIEwHnynVKjWvJUniOvcVGfm8J
         lhBuz4aqjJbyjygfceaGqs1xWgbM2FSiKkeVt7e6iueSXq+xUW032OdlSneu9KB6PBCi
         DkxjG/IP595+U6uDWQc3dK6NLpf0Z7qPFZ/nlyexGVgQdnNH23nZhwmSA2Vi1YjmJG5I
         EoeZtSgYxtolkD2F0zsQO9VgrmYAOaZv0BjcQE+JVZDZGJ/OAWq6ak29FF+8IkV8C591
         DpbA==
X-Forwarded-Encrypted: i=1; AJvYcCVUoFRkAC1UDL7HKcTXiuOwNF9+j2WgfLURqefZaadD6x2aIg6PWL0JGYvYGDI4oziZfgMcEYdgofNOtlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMN9OrYfLtk75jeQ03NtSu698B/q/0r9fAkMSEa0ePUCzcJm/l
	RzXjedSN0DayI61ZioQ/zuHyTpykLUUhEof1cQm17jPrxazP4sAwjS5ffAp7ateYGAd38IizGjQ
	FzEsTIiihdn7lMRnO+df5I5KEEjeWIsHIhirZWKzNzwZ+pEBLpgr/h+Eb17SoNjLcEgfl5g==
X-Received: by 2002:a5d:554f:0:b0:37c:cf3a:42dc with SMTP id ffacd0b85a97d-381b70f080dmr15436451f8f.37.1730797009532;
        Tue, 05 Nov 2024 00:56:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvDfDJcUJ5KLl/0KyWaHgjAevnISRf625sgDSVlbIQ8suHJxyyUaA0BdTBGgc5oIQsg5TQwQ==
X-Received: by 2002:a5d:554f:0:b0:37c:cf3a:42dc with SMTP id ffacd0b85a97d-381b70f080dmr15436441f8f.37.1730797009141;
        Tue, 05 Nov 2024 00:56:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7280sm15443596f8f.59.2024.11.05.00.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 00:56:48 -0800 (PST)
Message-ID: <ba06e9e2-c0d4-45be-99bd-17a3eb3c15d5@redhat.com>
Date: Tue, 5 Nov 2024 09:56:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfs: Xen/HPT related regression in v6.6
To: Andrew Cooper <andrew.cooper3@citrix.com>, arkamar@atlas.cz
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, willy@infradead.org
References: <202411584429-Zyna7RpVesXAiTBM-arkamar@atlas.cz>
 <df10f269-0494-46d9-be8f-7e5dc9cd3745@citrix.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <df10f269-0494-46d9-be8f-7e5dc9cd3745@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.11.24 09:55, Andrew Cooper wrote:
>>> At least years ago, this feature was not available in XEN PV guests [1].
>> Yes, as I understand it, the hugepages are not available in my Xen
>> guest.
> 
> Xen PV guests are strictly 4k-only.
> 
> Xen HVM guests (using normal VT-x/SVM hardware support) have all page
> sizes available.
> 
> But lucky to find this thread.  We've had several reports and no luck
> isolating what changed.
> 
> ~Andrew (Xen maintainer)

Thanks for that information, Andrew!

-- 
Cheers,

David / dhildenb


