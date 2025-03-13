Return-Path: <linux-kernel+bounces-558970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB8A5EDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2DE189EA43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90625FA13;
	Thu, 13 Mar 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JUuLJH6P"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CC1552E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853839; cv=none; b=qL/Okg8GV+qQ0bcq8h9TRgTcfmSP7RlgKTF5HyrICa2DXWA8b2uC/U8VJTxB/h/X+hg23uIrCzmJkThhEQmUMhW5k4yPbrePL+/v64a6eNVzxWownKHenk9isJ6dIG/KgBjbbXySij0sTicvNFdEtP0QPZbnrwuzaPE440fd9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853839; c=relaxed/simple;
	bh=dgyBTKsI+bB0OKWM0EaP7qWti7HjeYx6dVbpYAIUWJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N96p08RfUDo2vxbYmE2fB60woI4DcWe8Beztb8jIszLtJe8GweN9xjWxEFhpdLPt5FrZIfuvklN+tSs3YTSn3isBOKGdmRHVqt/6oOe36eEiYE7xqAVP+rYWqIf/5JNHmXKgsEDUaBgiCj0gCW0hy4XFUCoPuOodhsWva0wmDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JUuLJH6P; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912c09be7dso377589f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741853835; x=1742458635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5VGHsIHk2eDWQ4Rw62qVaWVCnpCrvunnZzyL/N6scw=;
        b=JUuLJH6PrFqBSZluQTr+Cv2lzWnBbZixMeR4f9x7AYreVSj/+YlbDz/C6hQElX/ZFD
         f+GsSwzjTgOuF5JJBU0HNGrrsg0IFnUc1yvpZVAW0TX4QgdnjFv1VczugKL6HEsLrs5x
         qMeNTXxpiA1/xpsKQ3SPqsUj4pUSDUUozXOj/6IIwxuvvQVnb5uxYfDPS9nQaQHyvvkk
         e1PgjSpFd68sXteABboPzmm2bqvgmkpXTD2SxBfR5vAp56BLjRXJdY1t2w625A2ERXOX
         1Bp0ij6/emm50nPBxjfJMnFrelpWahFvzo1xgY8N2BYIX4NNAlw3LD7D6+dEl15kJ+wS
         Y8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853835; x=1742458635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5VGHsIHk2eDWQ4Rw62qVaWVCnpCrvunnZzyL/N6scw=;
        b=Nq/7IJzNpJs7m4xGaHio/T+L8xF7lw9W5VuBP8PG5DmRIGI2S88YSDz1MRDhu3SkBm
         mq2PLubX0R2cfk633ZD9Wl4YF7mpI3jNvij61GeKrQhOL/F3NAt+A2k3jwIPwKp9K7Ng
         tTXW2U0c0vVBYvqkDIckhxxtfmm6RdT0Psu4iC5y+EpLPLGzhaJQE1yIJ8pOiHlPHffY
         YmDQ3fvxIUflj1bJmGWjUKSpKFFqzoLGwn54k8oVc4C+cu1Ln5ptt01dCfO/Jttkj4MA
         ycASEHyA8ysOwABcKm6zAncsB5t7CjGtaMKkPaM8tHV5y7SNrW9xyr0bO8+QZeJNVJFX
         I0KA==
X-Forwarded-Encrypted: i=1; AJvYcCVQjfGcdbclI8xJtI2uiAujOSv4ZLUdu/wZp3jmJ5Ha+wHZT7/2sAaDcDcqEfSTH3FtnRYWozP+JgRtup4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Y/E9YFvWVA37pdLG1uaq9AnUgSXhiJALbuhpfc+b+e1Q/Enz
	5gE1N7otA+HS6M7o5S3JbYBAswkSRWfvVotV58h3vnLkpyU/f0Le98LBNXZ8AFA=
X-Gm-Gg: ASbGncsrO+kXzLqhL0KIz6UUwd9SePPlowD3gmNZrkvzpygri8gvx923UNmKxEcrE4o
	fn+FjkN6Wd/UJk5Dz/HcsUyn3OcK9NAg3gaXI0mxZ4dHbO+kOEclcFbMVgrOcEnMvai4vMu7BIw
	Cq7+qEvDWsQepHoZtLx85Nvbeox9uEZAs8/p/HVX4SvjnRXs1cZ3L8ACESWPOMnhmEt+uPVxRYt
	E/AywhPhm8zWHAkB5iKNXgC9pl4CWWQOkCEtk4KIGvSwYeox8i152KdNQ0Uk2kx3jaJAa/cEGoo
	3QyltiRI29jh0UH8WU2KZim2k1rN7awgIqWJ5MWbZW37jQrG
X-Google-Smtp-Source: AGHT+IHXRGv+qFJBjsVPj4BxsO5Tnkhc9lyYOb66yOTrVrPqTSzu342/y05U44Iy+nKr102NIVINaA==
X-Received: by 2002:a05:6000:2ac:b0:390:f460:77b0 with SMTP id ffacd0b85a97d-39132d3805cmr19978214f8f.26.1741853835019;
        Thu, 13 Mar 2025 01:17:15 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm1257979f8f.70.2025.03.13.01.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:17:14 -0700 (PDT)
Message-ID: <31f49892-a9fb-407d-b266-6fd49e3c2bbe@suse.com>
Date: Thu, 13 Mar 2025 09:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after
 init
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Daniel Gomez <da.gomez@samsung.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306131430.7016-1-petr.pavlu@suse.com>
 <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>
 <20250307001256.GA2276503@google.com>
 <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
 <CABCJKudevAT5PK09Gu_j_m-oaULumwXab4EkPdv=ZdSu6-PpJQ@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CABCJKudevAT5PK09Gu_j_m-oaULumwXab4EkPdv=ZdSu6-PpJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/13/25 00:21, Sami Tolvanen wrote:
> Hi Petr,
> 
> On Wed, Mar 12, 2025 at 5:05 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> On 3/7/25 01:12, Sami Tolvanen wrote:
>>> On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
>>>> Le 06/03/2025 à 14:13, Petr Pavlu a écrit :
>>>>> Section .static_call_sites holds data structures that need to be sorted and
>>>>> processed only at module load time. This initial processing happens in
>>>>> static_call_add_module(), which is invoked as a callback to the
>>>>> MODULE_STATE_COMING notification from prepare_coming_module().
>>>>>
>>>>> The section is never modified afterwards. Make it therefore read-only after
>>>>> module initialization to avoid any (non-)accidental modifications.
>>>>
>>>> Maybe this suggestion is stupid, I didn't investigate the feasability but:
>>>> why don't we group everything that is ro_after_init in a single section just
>>>> like we do in vmlinux ? That would avoid having to add every new possible
>>>> section in the C code.
>>>>
>>>> Like we have in asm-generic/vmlinux.lds.h:
>>>>
>>>> #define RO_AFTER_INIT_DATA                                           \
>>>>      . = ALIGN(8);                                                   \
>>>>      __start_ro_after_init = .;                                      \
>>>>      *(.data..ro_after_init)                                         \
>>>>      JUMP_TABLE_DATA                                                 \
>>>>      STATIC_CALL_DATA                                                \
>>>>      __end_ro_after_init = .;
>>>
>>> I like this idea. Grouping the sections in the module linker script
>>> feels cleaner than having an array of section names in the code. To be
>>> fair, I think this code predates v5.10, where scripts/module.lds.S was
>>> first added.
>>
>> I agree in principle. I like that the information about ro_after_init
>> sections for vmlinux and modules would be in the same source form, in
>> linker scripts. This could eventually allow us to share the definition
>> of ro_after_init sections between vmlinux and modules.
>>
>> The problem is however how to find the location of the __jump_table and
>> static_call_sites data. In vmlinux, as a final binary, they are
>> annotated with start and end symbols. In modules, as relocatable files,
>> the approach is to rely on them being separate sections, see function
>> find_module_sections().
>>
>> I could add start+end symbols for __jump_table and static_call_sites
>> data in scripts/module.lds.S and use them by the module loader, but this
>> would create an inconsistency in how various data is looked up.
> 
> That's a fair point. Perhaps it makes sense to keep these sections
> separate for consistency, and look into cleaning this up later if
> needed.
> 
>> Another problem is that I can't find a way to tell the linker to add these
>> symbols only if the specific data is actually present.
> 
> You can use the preprocessor to add the symbols only if the relevant
> kernel config is present, similarly to how STATIC_CALL_DATA is defined
> in include/asm-generic/vmlinux.lds.h.

Right, that works but only statically. Let's say I update module.lds.S
to:

SECTIONS {
	[...]

	.data..ro_after_init {
		*(.data..ro_after_init)
		__start___jump_table = .;
		*(__jump_table)
		__end___jump_table = .;
#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
		__start_static_call_sites = .;
		*(.static_call_sites)
		__end_static_call_sites = .;
#endif
	}
}

What I had in mind is that you can configure the kernel with
CONFIG_HAVE_STATIC_CALL_INLINE, but some modules might not contain any
static calls and so wouldn't have a .static_call_sites section. When
using the above script, such modules would still end up with unnecessary
symbols __start_static_call_sites and __end_static_call_sites defining
an empty range. Worse, if the module doesn't contain any ro_after_init
data, the added symbols would force the linker to create an empty
.data..ro_after_init section.

> 
> In any case, the code looks correct to me. For the series:
> 
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

-- 
Thanks,
Petr

