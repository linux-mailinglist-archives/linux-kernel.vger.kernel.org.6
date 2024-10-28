Return-Path: <linux-kernel+bounces-384912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B12869B3011
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126E2B23D02
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65691D9320;
	Mon, 28 Oct 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Piiv2uGJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272A1D90DF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118191; cv=none; b=SD+4Z69lH4Gjs97ol6Wim/qGNZGwn4XQBX75HQlRvO3iburzGFhzkG/i7Zd+KpyMWpEagzVP7tORmOhPpbZbxmT+GJu57Rv710qwjPMwtl+O6exwt9T+plFd/YtcfWGmN8eJ4YlEGkHL7ZdV0tNrR+gl63p9+WHTj5OLSw+bOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118191; c=relaxed/simple;
	bh=a/nnyQ+zfae655YuBv8EmeYJH/HiBuON4VPPnYC4nbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMo7BRHZ07oTSH5DtT3ATzGmFppLVdnzosVKU3763pgECZZT+XneKcyVoHXCwXkUOfIOtqhAbDDXDXeItsH8R4fZ8LFM7HIepHo5oQ2F8QzJ0gU1GLoN40N4l/09Vof4kbL12GAiRkkugXa6ZtlvVfosFG++pr77sawJAXTr+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Piiv2uGJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730118186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MORV5yy0spA4tfUDQCPuVbrVMCJayUKNKpG2rdJzsyM=;
	b=Piiv2uGJB8VXMNO0ToiueQMbnAy37q/riI69kqNeYbevk4pYFcUUFdkiGqeq5mMbBjTc+3
	QW0GUGHiAl2ND0DFzi+Utxp42AbZQzwrqswPWzOezGNM0x7alG7J2S0pqSL9+ggvywm4qz
	LvQOhaF2T4F2uYZ5Z+WTXHZe66afTlQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-cbZzi779NxKSZfZ0yGX0MA-1; Mon, 28 Oct 2024 08:23:05 -0400
X-MC-Unique: cbZzi779NxKSZfZ0yGX0MA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316300bb15so30759845e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730118184; x=1730722984;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MORV5yy0spA4tfUDQCPuVbrVMCJayUKNKpG2rdJzsyM=;
        b=DEo7M1DbMWO/D6ySCrQsz4qfyic5zBuqZSLzPAe4oKVPOgDwWf73OPstPLu36153jj
         V+Hmicxy0lNDB+fkjjhlK93kCcDnDIGApOow5tVRGAMJssUF5BEjDPaoKG66EbeATCUJ
         p2qo8rzxu3a/qOHySRJK6iKIFUmFCYYpqEWTDnnNUg9ETmCq+Ibqg0oiJAv8K+QsPMST
         jkSaBBuGWYrcpnTiWpVPe8LDOFMuwhu9BycUUGRIden6v2H0y9tmP7GmYc6qgRYtaC2d
         SlQ0LUhru7vUP2d8OMS+pISSU5GcadRgD3wnq93Oe5lhiJO3XbaXMF3SVCVALlSEhSlT
         e/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUZcMlXEGOc/dKg0knduU8LeJzjw5N0oSCDIMO9sYu2vml6DmM69vXF/bE7RwgQZukckGPlqy8yk70LSMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrePH9ww3bXMLa2IPo8znkPm8lRqH9AM3ur5Kj/V/joomzipW7
	MYjav+ODmp9zxaShv8P/x6vP+hMTu8h/cFzKJuviGrPMm6vQyNr/izPo5KxyITx+1hzTS9g/TrS
	DMcgOnheNTtUwjNKhZP11Tsy+2qRKDeVrz3jr5jagtfZyCynmK3ZwVejaUU39DA==
X-Received: by 2002:a05:600c:4eca:b0:431:5c1c:71b6 with SMTP id 5b1f17b1804b1-4319acad842mr87620725e9.17.1730118184057;
        Mon, 28 Oct 2024 05:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCVNCvPbbS1o6gbZLrQqKqiDJf3IL6lyD8KntULtiJqluCpEIF0xPP0Q+7x8jav29J9ePhuw==
X-Received: by 2002:a05:600c:4eca:b0:431:5c1c:71b6 with SMTP id 5b1f17b1804b1-4319acad842mr87620445e9.17.1730118183640;
        Mon, 28 Oct 2024 05:23:03 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b6bdsm138049615e9.45.2024.10.28.05.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 05:23:03 -0700 (PDT)
Message-ID: <0abc2d1f-279c-48a1-be0b-bc7e249d0554@redhat.com>
Date: Mon, 28 Oct 2024 13:22:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: fix the format of the kernel parameter
 ``thp_anon=``
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241027175743.1056710-1-mcanal@igalia.com>
 <20241027175743.1056710-2-mcanal@igalia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241027175743.1056710-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.10.24 18:36, Maíra Canal wrote:
> If we add ``thp_anon=32,64KB:always`` to the kernel command line, we
> will see the following error:

^ did you mean "64K" instead of "64KB" ?

> 
> [    0.000000] huge_memory: thp_anon=32,64K:always: error parsing string, ignoring setting
> 
> This happens because the correct format isn't ``thp_anon=<size>,<size>[KMG]:<state>```,
> as [KMG] must follow each number to especify its unit. So, the correct
> format is ``thp_anon=<size>[KMG],<size>[KMG]:<state>```.
> 
> Therefore, adjust the documentation to reflect the correct format of the
> parameter ``thp_anon=``.
> 
> Fixes: dd4d30d1cdbe ("mm: override mTHP "enabled" defaults at kernel cmdline")

As Barry says, this is a doc fix and we should make that clearer in the 
subject. With that:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


