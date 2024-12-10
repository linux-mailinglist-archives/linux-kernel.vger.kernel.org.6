Return-Path: <linux-kernel+bounces-439919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F39EB608
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220CD1884A01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6C1BD9F9;
	Tue, 10 Dec 2024 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a39Xg+HA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDB1AAA0E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847641; cv=none; b=fprYnpAYorwhZgoDTz7UCnGGjXHr9Ocsea1cq/k7Buq4DxAY0116sKCiHjYG6ouTlfSdIWP13hmGCL92dmFliA57JpjAql0gVhmBqTJij53NoBlrvuZLbFT5AHAdnW3JLHoJmSH1XqLvPBxm35TiU/mFcbnVZ+NhgLpBBxYcmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847641; c=relaxed/simple;
	bh=SwFKuuyDrUKR3aTUFbR7hOjvNKoNeq17ciZQCDPGEf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVIAS/MEgtdWxhnpCR6MzBwTjpGfo5LhD1uRzhF3GLDuF2Rnc5mKzls3g7xE6VtZGktyCbzSLGkWJR0iRaSQ+HVB8TPg+z1d8Yk2nE1ilyqUYohNCQWbPYlvZw3530L9qqpELUA/oimEr/1JisJ3fkXo0b586ydyJR5qwyhj1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a39Xg+HA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733847638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rY9ynKcb4HkcQm4ahyj78rsPHrAzL68gixkqyxtJ3R0=;
	b=a39Xg+HA2MvVTlNrhLvrVmU8Kx/K/f12Z1vFP2Hm2LbcELLMPP6C104072FbRSel2XFXw6
	3hmT7kgnlT+aLu2Snxv6rDMy6dwIIu2xKxdtgBfk8xqh6U4yDFKBoX+yhb1U4r8nZahhED
	wW0PgNzbU9oXHO65L+imLwHamW7JtMQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Q0JOOeMfM-ycNizlGY1wPg-1; Tue, 10 Dec 2024 11:20:37 -0500
X-MC-Unique: Q0JOOeMfM-ycNizlGY1wPg-1
X-Mimecast-MFC-AGG-ID: Q0JOOeMfM-ycNizlGY1wPg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43619b135bcso2820695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847636; x=1734452436;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY9ynKcb4HkcQm4ahyj78rsPHrAzL68gixkqyxtJ3R0=;
        b=iqUpUW8UoRFPR4N13b4uyvpCpj55Cd038tItjHyoVcAVBeBO2aPWt7uql/ChvdsUtm
         Icfchg38qvu1K891Bd71U3YUCXDImmwTIrpDJF9Y/vuUn6r6l+ZQZeE7KiSUgReJ72sz
         /FuNhY1ACOYgbWCPaDeDMyhkvOANxXihsKbcCFHACFbAGSuRbuP7b1485H/tmjIK/pLv
         Z79c7JtZdpk1sk5mGZhyyced2c5+6dR8Rk2LQQkejikEwEB2VDuQTSoMV9xcqK0ihiAg
         JTQDg0ZrP7xS/wND4hpu0FzErG2bD+EGpyade3e74ri0T/SRenGYzxPszqm4jYWeu3ea
         yOjA==
X-Forwarded-Encrypted: i=1; AJvYcCXGtkz+RHbtXsDd0V6IwKegUm4GE3SZ6BqqVurtim7LAEcWh68S+ndDRMg5tgu7du+uJUoLzQVEme/FZDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUUxz+/wlrJkBGDj0QdgUQQvhFlhCjgvz6sx7YbQMF5wacPrp
	EoBy40x15zWVQylGC4cpnjXIdHMp2AUo8HF1DAj29rRSTMIQ+vC0BQE5tKETkTsHifk06uAHqpT
	FTE9ZXxbDHFSg44cf8u1jDvXPqVkdtHGjIrZieGNHVQ5j72F4d+1sHIpHP4r+sg==
X-Gm-Gg: ASbGnctaNSBWYM7wvewHVgfEnU9ZJn16lqM9sCRMV4HoYvDBBgbM8PLcAywtU24+EXh
	/ku2v7O+2EKlv7JEHJ9mI5J2KUdKwM3PpHr9wijJLOGEQdbJB2U8ACcK6puqbt7LTkDSPNEHiko
	oP2SbrjL+kZduYIwLOZldnMYt9cOtMyrWePyMAjxB9vtv+8BEWT/JjzZoXoQrFOuBffaq4QCvDl
	igtWDghM0bAkFK/z17+mQXIeGtfXx2lIlvoBymdPdNIxjLbTl95PIwC8g==
X-Received: by 2002:a05:600c:46c7:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434ddeb5afemr143960815e9.13.1733847635984;
        Tue, 10 Dec 2024 08:20:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXIjd0UITMZZ1RM704dGj2qdkRrCQvXjXoueuBP7gFX4aGt9NVwuRrpIaPAkDiHyRSI9zcPA==
X-Received: by 2002:a05:600c:46c7:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434ddeb5afemr143960625e9.13.1733847635615;
        Tue, 10 Dec 2024 08:20:35 -0800 (PST)
Received: from [192.168.10.28] ([151.81.118.45])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434d526b577sm236701455e9.3.2024.12.10.08.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:20:34 -0800 (PST)
Message-ID: <6423ec9d-46a2-43a3-ae9a-8e074337cd84@redhat.com>
Date: Tue, 10 Dec 2024 17:20:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] KVM: x86: Refactor __kvm_emulate_hypercall() into
 a macro
To: Adrian Hunter <adrian.hunter@intel.com>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
 Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20241128004344.4072099-1-seanjc@google.com>
 <20241128004344.4072099-7-seanjc@google.com>
 <90577aad-552a-4cf8-a4a3-a4efcf997455@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <90577aad-552a-4cf8-a4a3-a4efcf997455@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/24 09:38, Adrian Hunter wrote:
> 
> For TDX, there is an RFC relating to using descriptively
> named parameters instead of register names for tdh_vp_enter():
> 
> 	https://lore.kernel.org/all/fa817f29-e3ba-4c54-8600-e28cf6ab1953@intel.com/
> 
> Please do give some feedback on that approach.  Note we
> need both KVM and x86 maintainer approval for SEAMCALL
> wrappers like tdh_vp_enter().
> 
> As proposed, that ends up with putting the values back into
> vcpu->arch.regs[] for __kvm_emulate_hypercall() which is not
> pretty:

If needed we can revert this patch, it's not a big problem.

Paolo


