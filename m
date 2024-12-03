Return-Path: <linux-kernel+bounces-428617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0FD9E116E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87909282461
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0B137C35;
	Tue,  3 Dec 2024 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbk9lsDY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA3537E9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193985; cv=none; b=HEhMYbEj1vb0eCG2Bzv2j5qCEdmo6jFZ2Veyvg8zPM0YIrpc8l681oj73jiVkXzUiC7Q/kHdrBuHquQ5QIBUpMxIEdi26UP905OI/rDBMdrpg9sO0dM+a6FPoBY35AMC/81Lio3KwTnTh9CfzIQJIIDNn1WU/2jxDYuK+TEhz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193985; c=relaxed/simple;
	bh=l/nyYVGpxJ9UEBkJAtAMDMa8e1TqbCgvU4N5oQ7slpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQaSHbLqOh7WCWtdylMZxWG+Xc544N5G9qY8seO+P9+3TyxxtoFM4CYeF3D/OMeMs6XA1oTA+G1qq5ncqJPxlIMvfxglbLDPnjRHyTKFfHKfwJREZsjkMbi1PQU5Itcl2ihXO3JJob9OPhXIDwpT9hvtvzmRouX5djoqMAyW9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hbk9lsDY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733193981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLmg0HNuVhVbc0Ci2tnRLaoOQXcxlr9qcL/zPSb0TYw=;
	b=Hbk9lsDYLikypAo6zD/SQz6nNhcW4HvdCNKyqpCu1z/nWRpqSBEgRQNUA1Ta3oXlP4hBsU
	Tr4Ql8fF/OrA6T69gOTvUuBDUJp/VowBfbpzrIxb8OkIkS65a0iPgp0Kze5J+WcH84YNDc
	KHF3mTi70QlqVIhDEyl9dFdf7KYFad4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-7hY7URdeOo2TFZCNEWyPZg-1; Mon, 02 Dec 2024 21:46:20 -0500
X-MC-Unique: 7hY7URdeOo2TFZCNEWyPZg-1
X-Mimecast-MFC-AGG-ID: 7hY7URdeOo2TFZCNEWyPZg
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-72516cbe91bso5744768b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 18:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733193979; x=1733798779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLmg0HNuVhVbc0Ci2tnRLaoOQXcxlr9qcL/zPSb0TYw=;
        b=T9mATTN0iq+I3WenOiJI6dVXh3ghthGrb823FTEHjYtch7r8kqV19XRruVxdhUeLks
         0UKGuVjjVO/f0tgAxCA2wT5mKYFpnhXQMp0Q59/xzlAz331+3NA2YyiV6ix2cY8Yw9dC
         /NBwSX4eP0mcnf1K22Ncvb/5LaohXw9fwfg4fylOjTFB0SMkvjAyC0LkF9CYCYNlL2XY
         tbgeOSx7b/VrLKXEqolvaXP5xZb7yunXyX4yg0lJ9yZKmFotdU3+rt8IUkZ71Se8ITmz
         cZqlHSeDimbZCm1434yWHQ4CP9rDoY2H3LYKPM8jTbDJ/dI+Uk2iRUcNWfV+7312Nx69
         MeVA==
X-Forwarded-Encrypted: i=1; AJvYcCXmX6KqErzF1HNjdG+eS6dcTPYOWk54AX4nlw5RmU4o+kJpctzNijHiAkKenTywo8Vk2K9kEm+xLsEsRkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLLDJ+v7X9K2Lmnbe2F+2QbktBn2sbxPyaHpp3wGCG+bJ4Z+K
	auuG5vuvYYyDKOQvpCvjuz1dsDn1sFC5GzyI/uASiI8epXB61/tjiHUhJqp9Y5WxRrCr6Y8zq+T
	7QRy2EVxqxTEg+o19bvL2zwCJvIojt5SynlKWhUig1xt+Tb5KVd9RzGSCvzAh2g==
X-Gm-Gg: ASbGncu51ehW4lo6ta0MOf+RNgoNtUedJn0+m5O21y4bqDeB4WILOZX+rcxR3r0F90/
	u4+z4mI/xTHIlVBNRcA0cbI1+d55MQM1AkFeA0h+ZaIeTEjvAgLMdSC4holosynqVzAyL8Jv5MA
	nS4k7Vz0wKAbMUBofLtwUBRx9cB6fxq1fWawqbuht0v8eN7TnPQhCtD7vypLQGiM/yfwn33yxMx
	UdfL948CuyWas3URvjRW4EVJ4zyNeusnDQ2tAOfDKJXHuNNeR0=
X-Received: by 2002:a17:902:e841:b0:215:9a6a:63cb with SMTP id d9443c01a7336-215bd200df9mr12107365ad.28.1733193979587;
        Mon, 02 Dec 2024 18:46:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfseCusa820FVRmwFbT0mZlAFscpctykYf9htwJewCjZEfnFSGZPbVXSuGQjueevB6XoMygQ==
X-Received: by 2002:a17:902:e841:b0:215:9a6a:63cb with SMTP id d9443c01a7336-215bd200df9mr12107185ad.28.1733193979272;
        Mon, 02 Dec 2024 18:46:19 -0800 (PST)
Received: from [10.72.112.107] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159ebee334sm21262215ad.67.2024.12.02.18.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 18:46:18 -0800 (PST)
Message-ID: <65823dec-8af2-494c-88a6-0d4683cbf5df@redhat.com>
Date: Tue, 3 Dec 2024 12:46:13 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop INIT_MM_CONTEXT()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20241202043553.29592-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241202043553.29592-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 2:35 PM, Anshuman Khandual wrote:
> Platform override for INIT_MM_CONTEXT() is redundant because swapper_pg_dir
> always gets assigned as the pgd during init_mm initialization. So just drop
> this override on arm64.
> 
> Originally this override was added via the 'commit 2b5548b68199 ("arm64/mm:
> Separate boot-time page tables from swapper_pg_dir")' because non standard
> init_pg_dir was assigned as the pgd. Subsequently it was changed as default
> swapper_pg_dir by the 'commit ba5b0333a847 ("arm64: mm: omit redundant
> remap of kernel image")', which might have also just dropped this override.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.13-rc1
> 
>   arch/arm64/include/asm/mmu.h | 3 ---
>   1 file changed, 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


