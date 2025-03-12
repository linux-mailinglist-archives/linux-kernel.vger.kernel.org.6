Return-Path: <linux-kernel+bounces-557673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9423A5DC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A000188DD37
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5CB2417C3;
	Wed, 12 Mar 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c54+rNTD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B741DB124
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781127; cv=none; b=T1DfYg0F9F5aMisohD0M5lELK81XpNp0o67HJH9q2bvuZqfgwLtmvmZ8ankI2W25VfYot2ypcQ6xw37am1uSet3NbpFmbyYCWvG7D06GXnIKatJuPFOcQ17akpXBH6tFFiQsS0LKaDS7izIqNLu98nxQllUiVzNzVJaLfLl1NOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781127; c=relaxed/simple;
	bh=I3eeBWE/LMZynG2czAXHMWKMLPqllq8LervyeDvhne8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMu7JpkJ+gNU93tPhaNchd0Ce0iLEPGFV4noBPIa6u/fXpYr63KB2pl4BZun9DXeamdNTJjm+WjiT1DvB8GFjEAPoyT5MCb0xu5Gxm6KJ2Zj2+mKHmWHeH/gWS+5ndgFl037KZL5TfCEwI5tbeGsjMQSdENBmvgUpA8doUOiTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c54+rNTD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf257158fso22506325e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741781124; x=1742385924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiqsf0HzzlGLhSgy/0lgckThk5pKGLIU6m9bddwieEo=;
        b=c54+rNTD2YZ/126Mzkmv4B6/hlF8/fHXU4gNKCUKZDDukmMBY6TIkszM0s7QD/EuTp
         ITMvodCW8bffyL8/IHPSPdklQb46wRuAJe5PzYEUsqNN76G3p+q7yxzweSaVr/m52ks2
         bBmDsdmADMSO7w22PguIOq8kXByCeVDwe1MxGEY3oXm+huwfQNdzpzz8mWq1NY8wMuNz
         ML9hXj0x8yAjSRYfrEDdp8Cn7vZK6WmAlFq5DqZvs7UVznBa//M5L0YeW0Q+Oym34geN
         4i6iD8uvAPY4xEfAF1WftGTvpB4NSXd53UOpCCUfvkkST81ekGqrrxhCFMJ6bcXLZ61n
         48gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781124; x=1742385924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiqsf0HzzlGLhSgy/0lgckThk5pKGLIU6m9bddwieEo=;
        b=Sbryfo7a7n0MAyD+pI6owOf1HxFAsJIiVkt7d8Jp0GCc0F2Xz/g3C1I3bfTldxRtkU
         p8P6dw2wzIwsdjB7Ha2pV1X0ibN3F8WCbc5l5kAkjzYJxL/aB56ZYHjaNmBrnJs8dU7z
         S0UTz5EFmWHh+RQqbnOI2IQGK+nnyl51+aQ8gJrdAJnkfejMjz/BflmBe+hblOM9DSOJ
         zFcuewHzMrVD9sVmCuUddr9qB4mlq4QQpLk3oovjwuyRBNqQA5Jl7ArnAuV+BfQqGRPT
         MiNwEFfy48VSs1E5BlX9cXdsrsdwTUqtqFmFXlWqVi9IyyEEQ3ZU58vlson29vmWi4NZ
         J6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+8yMIsNeOqMkSjTz1OvftzKgcsvG2rngg8GOdOsU+9BRRJRZoF24QgB3I02muK4MIbxk1YVspoE6ZOnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrtS9pObjZp15fLKDCXwHITH6sK5wlNzp5MQJ9VfAVygdZZv9
	6gG9nab6quKqx+JFygpD2p9hXF5s0JhidW74a5CiXVKJ225tOQ6+HL09+xYkafQ=
X-Gm-Gg: ASbGncuVmO2W1rWZ1XJud1O5jJg2D7tgNCuC8x0kOPTF3pueacMRqMsZ05LzqfQrMPI
	4C8p+xTqBjeeNjFC8gkvVHh/3KDRU0qVui6/jjyfw0EO1e5VqL9kPAmRuWqm3TACD+iH7xTiPWJ
	xxNcvEdvr1/VyH1xBuF5Mhk0NMdyvEZTBidpGZZ8zbjRuTLEHgNY69jd3qJv2JB3ImFPDW2X7zw
	BoirNiiWyEQA8iQmLxYODR8uQBBTveDqcHbYlfTYqhLXv7hsMtxnt7k8dxLnyWLD78YJREaLZJi
	bXMJNOPXM3ZawHxQhe+RaZzyCFLCvGjFC7gFdM5DndJekVlu
X-Google-Smtp-Source: AGHT+IFf2RijMv0k8lptg1AGDY2v+JyK5+tf/2Ywarp4agmGIrZlKJfK/ANZT3Qn+8OJjIC2rilIDQ==
X-Received: by 2002:a7b:c4d4:0:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-43cf5139abdmr130987575e9.14.1741781124038;
        Wed, 12 Mar 2025 05:05:24 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74cf8bsm19369895e9.12.2025.03.12.05.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 05:05:23 -0700 (PDT)
Message-ID: <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
Date: Wed, 12 Mar 2025 13:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after
 init
To: Sami Tolvanen <samitolvanen@google.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Daniel Gomez <da.gomez@samsung.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306131430.7016-1-petr.pavlu@suse.com>
 <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>
 <20250307001256.GA2276503@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250307001256.GA2276503@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/25 01:12, Sami Tolvanen wrote:
> On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
>> Le 06/03/2025 à 14:13, Petr Pavlu a écrit :
>>> Section .static_call_sites holds data structures that need to be sorted and
>>> processed only at module load time. This initial processing happens in
>>> static_call_add_module(), which is invoked as a callback to the
>>> MODULE_STATE_COMING notification from prepare_coming_module().
>>>
>>> The section is never modified afterwards. Make it therefore read-only after
>>> module initialization to avoid any (non-)accidental modifications.
>>
>> Maybe this suggestion is stupid, I didn't investigate the feasability but:
>> why don't we group everything that is ro_after_init in a single section just
>> like we do in vmlinux ? That would avoid having to add every new possible
>> section in the C code.
>>
>> Like we have in asm-generic/vmlinux.lds.h:
>>
>> #define RO_AFTER_INIT_DATA						\
>> 	. = ALIGN(8);							\
>> 	__start_ro_after_init = .;					\
>> 	*(.data..ro_after_init)						\
>> 	JUMP_TABLE_DATA							\
>> 	STATIC_CALL_DATA						\
>> 	__end_ro_after_init = .;
> 
> I like this idea. Grouping the sections in the module linker script
> feels cleaner than having an array of section names in the code. To be
> fair, I think this code predates v5.10, where scripts/module.lds.S was
> first added.

I agree in principle. I like that the information about ro_after_init
sections for vmlinux and modules would be in the same source form, in
linker scripts. This could eventually allow us to share the definition
of ro_after_init sections between vmlinux and modules.

The problem is however how to find the location of the __jump_table and
static_call_sites data. In vmlinux, as a final binary, they are
annotated with start and end symbols. In modules, as relocatable files,
the approach is to rely on them being separate sections, see function
find_module_sections().

I could add start+end symbols for __jump_table and static_call_sites
data in scripts/module.lds.S and use them by the module loader, but this
would create an inconsistency in how various data is looked up. Another
problem is that I can't find a way to tell the linker to add these
symbols only if the specific data is actually present.

-- 
Cheers,
Petr

