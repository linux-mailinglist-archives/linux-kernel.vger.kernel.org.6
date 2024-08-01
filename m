Return-Path: <linux-kernel+bounces-270016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524C0943A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC928244E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735413A256;
	Thu,  1 Aug 2024 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaRnac32"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9887139CE3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470867; cv=none; b=AWpJck8WXpvNg8YktxVgzMhrX0vkelcx2MSm1ZkC4YFcoVGRJGXVQziV3jWwzdlGtWz/rj1qWxdBVA0SoofM7M94kAZPgpSUedGd6LhKX64vql1sMCS9pI579frneuRcck0eWFgLwzxuWCqPFH7LOMqQiY6gM7YATG9S7UaNETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470867; c=relaxed/simple;
	bh=uZitoXw3AJCG1kG4vmZt8cbhyjbq/8hxAKKufUndCW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dScVjyxPHisxX7atto1NMhzNWcTo2SRL/6FBX30BcOVD4eVInTBu6RzD3lQwl66X3EndbPOFS2wwO7LB3sEvRtOZv5myQPpGx8pREpyS57up8EN4A8nKAQN6mNTzEl1tGuZEkpNXi8xA4WAMCRsjfNbw6bPF6WWHnFeJrKrEKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaRnac32; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso879238166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722470864; x=1723075664; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSn5iYZ3XPPt6Vm0cC+2jgi08W20+j2x54YW4tsdYTE=;
        b=MaRnac32XTU1frH+VsVUBnYuMX+gJSEtImKf5k//qwHdybfPiIj4I5pu2k+AHtaq7f
         zhBsXhcFi3HlIzLwjNbcmCGYTWChXsJkFo/YlpwhTCtu7pNNDqKmm6wBa5uCqOhCSEIf
         JYT+m55JCdouGlVsXWIOP7KpGsIcPORLt3j3DYMCYzBU8AZRk6M+1SCen/cdZ+rtmEW9
         U8g94sfUfSxTh6/5LgpcRsd/062ENhUflevwQzHVGdNXc0LJq9CLcb6jXzU5vQK/n5fi
         /gYZ/h9XLzcct1ZOtX1G3GjG/2A9mdJvlOi3Uu7SO/bp3u62zo86GTlYrsWQEHNUzaHj
         t4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722470864; x=1723075664;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSn5iYZ3XPPt6Vm0cC+2jgi08W20+j2x54YW4tsdYTE=;
        b=hQPEId60X1NB0FEiEfYbz4/LhrCsmQu+bCElJuiu6/SEk/iGxdKJC2+XYnTgxhfrlx
         YPH3h+HP2a/f0/kg8jNmbmEUiGt+k1iX8BHzCth/VvigFsFpHJ4R5yvBr0uaiVkHmBMe
         FaVXK62ANpw6GRkkKB78UmG2jiLYOpndEgp2ZamAY+3hW6M56tUNlcXc+ieW+sCBHi90
         qFoKeTfmdxz79AuX29sJwJG6wbS/igPncbPopq623WD7Aem3f4JrjZG9gACf8quv4jtN
         kWSkr8b6xM30Fqu5lW84FgISYH1MOnxGqVblgUBIT3hkXp6sVqpKoM1TVKjXCq0bkqjq
         aiew==
X-Forwarded-Encrypted: i=1; AJvYcCVRV824q5+rlucQ2r175hFlYz0AHVhhvv7BUQ/6FwvD2HbteJ60vcy1lmNZwi2Orp7RKyrZ942h/pKskTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmqauuNVIgS9KFy7gNpKOpDNDMo8MUBeQZ8YmO3PNwr4W909J
	3Yda1xDtsVN7J83YrlVFELtTK31ZPeP0FiaOC2Nrc6pMljOM6MpGCTwkeQ==
X-Google-Smtp-Source: AGHT+IEJmMdZpxTUR4SqcCLTsphnTuppYKhH6EhhyPRrTD+adMLVFclhOxowV6t9RUOkeu3X9FoqXQ==
X-Received: by 2002:a17:907:2d92:b0:a72:af8e:15af with SMTP id a640c23a62f3a-a7daf657bffmr56104366b.49.1722470863643;
        Wed, 31 Jul 2024 17:07:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad411a6sm813676666b.117.2024.07.31.17.07.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2024 17:07:41 -0700 (PDT)
Date: Thu, 1 Aug 2024 00:07:39 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/5] memblock test: fix implicit declaration of
 function 'virt_to_phys'
Message-ID: <20240801000739.lrgmokbbgvikrlkw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
 <Zqcqky8XdiQy3mO-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqcqky8XdiQy3mO-@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jul 29, 2024 at 08:37:23AM +0300, Mike Rapoport wrote:
>On Mon, Jul 29, 2024 at 01:47:21AM +0000, Wei Yang wrote:
>> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
>> alloc") introduce the usage of virt_to_phys(), which is not defined in
>> memblock tests.
>> 
>> Define it in mm.h to fix the build error.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> 
>> ---
>> v2: move definition to mm.h
>> ---
>>  tools/include/linux/mm.h | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
>> index cad4f2927983..9db45c5d00fc 100644
>> --- a/tools/include/linux/mm.h
>> +++ b/tools/include/linux/mm.h
>> @@ -20,6 +20,8 @@
>>  #define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
>>  
>>  #define phys_to_virt phys_to_virt
>> +#define virt_to_phys(p) ((unsigned long)p)
>> +
>
>Please don't break #define of phys_to_virt from the static inline
>implementation.
>

I don't touch the definition of phys_to_virt, so you are willing me to adjust
it?

The macro here will be expanded to code at preprocessing stage. I don't get
how static inline would help here. Do I miss something?

>And please make virt_to_phys a static inline similarly to phys_to_virt.
>
>>  static inline void *phys_to_virt(unsigned long address)
>>  {
>>  	return __va(address);
>> -- 
>> 2.34.1
>> 
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

