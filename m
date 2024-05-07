Return-Path: <linux-kernel+bounces-171220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D18BE157
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74381C21E32
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31428153811;
	Tue,  7 May 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAtz7jfO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483615252F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082348; cv=none; b=VjjRGhPMc71pxHOqaicQuRQfidyhDlE0WJoTagliRLIuuN9MNApZU1dq35lDgO8pBVsyJceti+en78JhGI57Nv06qVsu+HfGRl/OxoHM8QXXev8o9FRF4NUqShodg+Q644ccyKvsukAavKGCirlysHlYDjcrsZagy6MXVDMG/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082348; c=relaxed/simple;
	bh=03tF8iBLwiZ5nBsy+NXhdYr6wF9RCNp7BrfTjA/sELM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Drf/qovWtCEP3UJ/RPpzdQS0cIRlMXC7+JCK1opMD3kHNRab2wJNhcJVACyCe6FAEVTdsNmv51k+5j6figmU8aEU9SQgQwHhxtTe5mj4apGcWc+gGyWYcmG2iJomZtgJxXz/7jghUjDtMuj+Rknob2O5ZumwjGWBBeB+6gB4hFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAtz7jfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715082346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gw+eBuYVObw76H69rsfZWAD7p9vo6+GWt4aQA+c9k94=;
	b=jAtz7jfOFfdMqu3XEQciqiC4wfe29lxpH/g03+Tvgzg9BJzNVBm6uboSDQCwo1ZDqs4JEd
	R+JBa+O4+4V/7lTf3T7dHIhhwOlztUQ/GzzUn7sdoaTuHgq8LzPWrYfrNuPxYiObwlFa6n
	3r08Fmv5e3oZPDFZM4lovBIprKF8Aho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-1piDpo5COvOZZ6m65yA0UQ-1; Tue, 07 May 2024 07:45:44 -0400
X-MC-Unique: 1piDpo5COvOZZ6m65yA0UQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41d979ae1b8so11111355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082343; x=1715687143;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gw+eBuYVObw76H69rsfZWAD7p9vo6+GWt4aQA+c9k94=;
        b=N2wCpM2fSvpuvDeyl2V+TJexsTZP7/TuZvFIGwsmDtb99NQlDcDEy80qJMIt5b8EFE
         feR+FCnCuVD8nluLgrR6h1q/tPPnwyb0DDg015x383HHNAaV1ktTQa1Lf0sUWrdVGHue
         GTw/fdIqjpCAhvgmz5ogpaH7QnLCaGIUbxHtnVzRoKOaVRGnZC53iafEdyRCcE073CLT
         nXBEh0x5sRBhzaWdLQzI71rGjLOTxpfFagKB3YJTJ2tCcMT53C0L6b+mrqsar60s809j
         9o9TLLeInfEzt/keaNLjdUVYjp8h/c9qMge/TkQxMIyYfd5xlygd9CY76E7eNuglgFAb
         yCcw==
X-Forwarded-Encrypted: i=1; AJvYcCUVGhlG4OkCjxwB3V3SbU2kgKF/ltijbZJ6j4xuuvMaNLd4RL2o3zaLxmKfEUodkLOfqFQIm7dtIbqHJeFmLRwB1M7qU53cW7RRGwyf
X-Gm-Message-State: AOJu0YzzX5ZsHOfufpzhNbxws/S8B45v2F/HooAa2K/ukw32OBg4oWrb
	GezgtTSZvRPxmbQjWEHJCu9jDNT8Q9/lXU8SdWRDvH02Ihw4QlH6hdyNY1ZD5L0CsHe4uGWSMG+
	mMPCnImSwjnyRGjxTFauvNY1is/yB4+lsbYh+R3l31OQFCEbkD+QFtNd83eo4aQ==
X-Received: by 2002:a05:600c:5247:b0:41a:7bbe:c3bf with SMTP id fc7-20020a05600c524700b0041a7bbec3bfmr10354969wmb.22.1715082343455;
        Tue, 07 May 2024 04:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVVpaILy3HdArnEnNSSrujxPRdNN/fGHL0mFBfc6YFSw7QBdRU6ftJOZWTJ4XShbQWpKy26A==
X-Received: by 2002:a05:600c:5247:b0:41a:7bbe:c3bf with SMTP id fc7-20020a05600c524700b0041a7bbec3bfmr10354950wmb.22.1715082343039;
        Tue, 07 May 2024 04:45:43 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b00419f572671dsm19395406wmo.20.2024.05.07.04.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:45:42 -0700 (PDT)
Message-ID: <a980d401-6d41-4700-8775-c486a50f5c5a@redhat.com>
Date: Tue, 7 May 2024 13:45:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64/mm: Add uffd write-protect support
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-5-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240503144604.151095-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.24 16:46, Ryan Roberts wrote:
> Let's use the newly-free PTE SW bit (58) to add support for uffd-wp.
> 
> The standard handlers are implemented for set/test/clear for both pte
> and pmd. Additionally we must also track the uffd-wp state as a pte swp
> bit, so use a free swap pte bit (3).
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM, thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


