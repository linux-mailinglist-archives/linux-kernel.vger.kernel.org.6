Return-Path: <linux-kernel+bounces-321553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA2971BF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F271F23274
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7411BAEEC;
	Mon,  9 Sep 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQzdo3aF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11911BA88F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890282; cv=none; b=Vsdnbvv6RsuNZmn0YVc01QrLtgpiHDgj4VOpHc+ZB2n0NjvD74gpjDWu7xXE6NSysuYP8ygaT4Z10wZLh34XssUuYsE2MLbnrzhNCJBajdsD4+CB5wNQp8GMP8bQ7lHM/Yb8I1wWeO4V2+aHfHHpMeFgdGIJF2z+7kZmT5N4M5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890282; c=relaxed/simple;
	bh=m89HePtAM5jqLthS8Unvo76yxW4Hbj5zAfRhdb4/VN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoznSP1+VbdjjtvGhqIasK6DvPT5dr7WBHPvaV1n4Q3uB0gL7Duc+ATFfq8z8rsz5N9LSxuUM2ARg+zs5ipFuDDxLs+2pbIx4qLEn1klr8TL/Ulvc4iFiouGqzR+BoxbVlZ17EYK2Jn31N3+dVgZ+xcTR7Z5IRag4t5pLOchvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQzdo3aF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725890279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KlPgFXD7wPaZgzFynuN1gZ+K301apFXfDx+sseASIks=;
	b=jQzdo3aFw7dYowuXIj6HjpZ+/XUTpLABNpKwJkNNBM9xPJXfpAkqEZQrTeAIP2rES4FqDa
	QC8/h7adpuekBNv5GJfSf7gm8ln1XHKlWNKeylcabxZ5VH4ywKUrz23vO5rID/zWqc3PVj
	YYZY++qHZq7mH6alXu9vi0jg9DWyZ3Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-T7Lt5ChCPK6Masei2rqKfA-1; Mon, 09 Sep 2024 09:57:58 -0400
X-MC-Unique: T7Lt5ChCPK6Masei2rqKfA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb827e9b6so8046085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890277; x=1726495077;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlPgFXD7wPaZgzFynuN1gZ+K301apFXfDx+sseASIks=;
        b=Be0tNJn8+oNIJwbNU0eAZNBkGLeXgyxTORHHJ0R90YmyDA9P2DGRHTDIsjDhB6ltuf
         ncncPgVk1nAHOIj1mW4GAkaka39GwkiB+cnxuvP2UmBC72jIdx1OqNoQxLlg32MczwJ0
         WjmIfeSRKwGo5XDOfrieKVtRJEDFAOHLjlKiPP4eXW38DgFmTNb1+UB6witCQVuPnUMl
         AdmSB2LxkV0TMLG+IDxLe4V+vzvUTinHtvlYmITZCuxWF5rwer/7wd9rI+rSj0gnxprT
         IEwRqmr2EsNjep7nYR2NDrnnHnGJmdwAhKb/lZmNkPkyy8BlEBXad3aKvmTGgeva+WYa
         zK6A==
X-Forwarded-Encrypted: i=1; AJvYcCXqNH1wFNMDm69JPOuVj+QIHEb7MXgYOS/RJGV7j5HqWD1d37nVLKXs9UZx0igxwwPVLQYgEgtPUno0UOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznxjvfo8/9pHxROdHjJiDdxflHX1PNtEOCzms0W+1+dBsLuXOO
	yhUHlWCkeSLQJO4Wa0fCVxlyN5Kx0q6PS57jKQCfL/nfa3SsD05F4cuK/jAqMNwnc18UCRBnHys
	GkulNeCwUhzOXX6XtD5KdNdmihaujkcWnBioyc2mvAfc3JDfCOeliyXgoHP8NCw==
X-Received: by 2002:a05:600c:3d94:b0:42c:b3e5:f68c with SMTP id 5b1f17b1804b1-42cb3e5f833mr38131505e9.4.1725890277115;
        Mon, 09 Sep 2024 06:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy68qP5UHwPHBPxwihOgDtfvFyTvsp7qXDbtvOkEi9QrW82XniVFVFQWT+XQiDMhccyaUJ6A==
X-Received: by 2002:a05:600c:3d94:b0:42c:b3e5:f68c with SMTP id 5b1f17b1804b1-42cb3e5f833mr38131295e9.4.1725890276613;
        Mon, 09 Sep 2024 06:57:56 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3789564aea0sm6109137f8f.20.2024.09.09.06.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:57:56 -0700 (PDT)
Message-ID: <a23c4f95-596d-420b-a446-797216fcdacc@redhat.com>
Date: Mon, 9 Sep 2024 15:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] KVM: VMX: Split out guts of EPT violation to
 common/exposed function
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, dmatlack@google.com, isaku.yamahata@gmail.com,
 yan.y.zhao@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-5-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904030751.117579-5-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 05:07, Rick Edgecombe wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> The difference of TDX EPT violation is how to retrieve information, GPA,
> and exit qualification.  To share the code to handle EPT violation, split
> out the guts of EPT violation handler so that VMX/TDX exit handler can call
> it after retrieving GPA and exit qualification.

Already has my RB but, for what it's worth, I'm not sure it's necessary 
to put this in a header as opposed to main.c.  Otherwise no comments, as 
there isn't much going on here.

Paolo


