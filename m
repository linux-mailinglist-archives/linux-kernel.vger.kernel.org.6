Return-Path: <linux-kernel+bounces-182264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD08C88EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F88285DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA76BB2F;
	Fri, 17 May 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZSaTH1nF"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2A612D3
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958024; cv=none; b=Egw0/tTglEB45yYjJHWFozh+sqctGZOZlWcUyDdmayg9TxXNOhqMmWMBkGgwD5pOopfWaHwvBby6p25vmSzNXvJQuL/YxYtqijcPMWuvtXORAh8fgDhW0b+Lh/Lv7EzNPHiJH1kGqILux4EUJEdBU0Dr7GrT2uDx6mhrvkHedas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958024; c=relaxed/simple;
	bh=0Nr8Y4+/ZJBHsC4fobZER1qRfUEhosErOFS9K3ZUB2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2gCf4Prq1IrMidSlgysIqgKOv7czC7osdpr84OMp0P58rbgWkLG8vdAp5S+CGXEJfuYbTKGqk0i2z5ChaoyCrK6LT0StKPsrtJxx3klZA1Hm3WuHhASQPN4K/yS8MxHAtfyk5npVXVE2nOOA2FBHo30FC1UA4OmtoJAgu8H0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZSaTH1nF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59c448b44aso483118566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715958020; x=1716562820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90vcdryrilbiLp2GC0B+j36kxSGrzIvMk03oWLCbJRo=;
        b=ZSaTH1nFQtgMhpDBgCZaTp+lrD2iwRsMFVQ9BWXVQGee9YpO2j3tzVretodIfB6ddk
         5gq8+/MUtxSTaM1wev0serOA5UxzH6d9MJ0rZVLRkQIX9MV4KtC7GDU56rO8RYtuqbHj
         FWmqKymDvC+rH7r4jflQKay5yF4dKTqw9BmdNMkY7tTUeBr5kmqwGbbZRsWhgx9TfJAf
         5N249nf+AMxWArbBnTZLbHILERYPKaWsnifjYxhEFVhlZxgLDJLwndK/ABLQSYvujSGQ
         0EFRkI7KQAwfKB7bzQi5/m9ojYHEr+sclnlSUAuaAVO9eY+S/XvjTULjQ2ghWt6o9WrD
         MD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715958020; x=1716562820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90vcdryrilbiLp2GC0B+j36kxSGrzIvMk03oWLCbJRo=;
        b=lAcrNcrAb/foFdGm1ThAuyV3KQ6K9sdxXCybSUzqqXyMz0CecrvDb+OHN+DDUyOzT7
         Nlpx5APVbAU/KKxFAD40rXPNzmABmeYBlno8CPdf7Nv9vT0x08ewaGIn3pCV0wOcu1f2
         VKdYw0DBqHPHo/8sUIX61RCngGZu+JzNDOr+W12Jy7tVXDH56ZAVCG2Al5M3huh7JrjS
         3hhq8sQvO2kFuSWV0TY7fMX06wZrkVUkvSBdg9Gut8GEnFC1yapameiGQTiFQ0zwvBeW
         FsUlgxdXCXnUSZ1h6WkUAYip6Kw5MC4iQ+fdVm+q8ozf2EwEDlHr8D7ct/fdoZ3o61xN
         Nfug==
X-Forwarded-Encrypted: i=1; AJvYcCUXmXDPuGavoTtfx46wPl8OwXmLCq2Ffa0bKoRO0VnRHCzqvqPBgq/9bDPr09bOgmCkXzosB1jDoFSacSXsn8iaMjP+rPQKSvvsT4zD
X-Gm-Message-State: AOJu0Yz7WFamUxUNeY0XLWNSyo5RAg7T7Mx5BQytn3xcV3GBHxjgm6aX
	kAjvoNQqVJL4qYCc7y7ulYwtd91kOE/VvPHgcKkM7Li8BDtNr1e8Zbqoa4RDqrk=
X-Google-Smtp-Source: AGHT+IFH3sGsvJWbmCtch4QWwjnUqxDk98n6psu+IdrWC/5EPw3YDGX0Tv7xzZxM8iEGEh81fQB4aA==
X-Received: by 2002:a17:906:3cf1:b0:a5a:8248:253e with SMTP id a640c23a62f3a-a5a82482592mr717938266b.36.1715958020542;
        Fri, 17 May 2024 08:00:20 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d57sm1131261766b.73.2024.05.17.08.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:00:20 -0700 (PDT)
Message-ID: <e8b36230-d59f-44f1-ba48-5a0533238d8e@suse.com>
Date: Fri, 17 May 2024 17:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 039/130] KVM: TDX: initialize VM with TDX specific
 parameters
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
 Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>,
 Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, hang.yuan@intel.com,
 tina.zhang@intel.com, Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <5eca97e6a3978cf4dcf1cff21be6ec8b639a66b9.1708933498.git.isaku.yamahata@intel.com>
 <46mh5hinsv5mup2x7jv4iu2floxmajo2igrxb3haru3cgjukbg@v44nspjozm4h>
 <de344d2c-6790-49c5-85be-180bc4d92ea4@suse.com>
 <etso5bvvs2gq3parvzukujgbatwqfb6lhzoxhenrapav6obbgl@o6lowhrcbucp>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <etso5bvvs2gq3parvzukujgbatwqfb6lhzoxhenrapav6obbgl@o6lowhrcbucp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.05.24 16:53, Kirill A. Shutemov wrote:
> On Fri, May 17, 2024 at 04:37:16PM +0200, Juergen Gross wrote:
>> On 17.05.24 16:32, Kirill A. Shutemov wrote:
>>> On Mon, Feb 26, 2024 at 12:25:41AM -0800, isaku.yamahata@intel.com wrote:
>>>> @@ -725,6 +967,17 @@ static int __init tdx_module_setup(void)
>>>>    	tdx_info->nr_tdcs_pages = tdcs_base_size / PAGE_SIZE;
>>>> +	/*
>>>> +	 * Make TDH.VP.ENTER preserve RBP so that the stack unwinder
>>>> +	 * always work around it.  Query the feature.
>>>> +	 */
>>>> +	if (!(tdx_info->features0 & MD_FIELD_ID_FEATURES0_NO_RBP_MOD) &&
>>>> +	    !IS_ENABLED(CONFIG_FRAME_POINTER)) {
>>>
>>> I think it supposed to be IS_ENABLED(CONFIG_FRAME_POINTER). "!" shouldn't
>>> be here.
>>
>> No, I don't think so.
>>
>> With CONFIG_FRAME_POINTER %rbp is being saved and restored, so there is no
>> problem in case the seamcall is clobbering it.
> 
> Could you check setup_tdparams() in your tree?
> 
> Commit
> 
> [SEAM-WORKAROUND] KVM: TDX: Don't use NO_RBP_MOD for backward compatibility
> 
> in my tree comments out the setting TDX_CONTROL_FLAG_NO_RBP_MOD.
> 
> I now remember there was problem in EDK2 using RBP. So the patch is
> temporary until EDK2 is fixed.
> 

I have the following line in setup_tdparams() (not commented out):

	td_params->exec_controls = TDX_CONTROL_FLAG_NO_RBP_MOD;


Juergen

