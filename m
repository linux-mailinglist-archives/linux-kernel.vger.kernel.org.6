Return-Path: <linux-kernel+bounces-261966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9624693BEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1907E283B18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA01974FE;
	Thu, 25 Jul 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WaTjUVnO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC715FA60
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898804; cv=none; b=VjM1qVQsOGG0+OzMdKesvhMpxa0j6FWS8Fz6vsBNBw1eQKsqO8t9UTD+Ypi/KZzeqbDX7mU679tKz4PlH6p3UnFlDBlqnjxwkvCWeSzMQndRwR6VdClshvFP9KKKmLoESbRCdR9zlKbB3Ho+23zB1XzFDfxbYzmx70yWvEmYFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898804; c=relaxed/simple;
	bh=M/5gkuaN/Yp33WS82w7kZz0gTv5VAosXlk9UNGEMSSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeH320ZPLP7YRfYEIymHS2V8ZcDgy3bmJh6cgGV/IumYunUNA79lA5gVmqxfSO1HTA1ijbtILfreqhWH5221XyVPIs7d94oDaw8v7AjY7AMysHdsup3gAEBXB4s/F0zSFgoXA9noVCAb2AmQefKSpgbaBMvJFSoNsvDUHcs8RWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WaTjUVnO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so767643a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721898801; x=1722503601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbOh1YnLRGUof5jIdg/YaLDXWdX8IKsWKWEs5XtNUCY=;
        b=WaTjUVnOsmYiwZ3IlYoiMtEvEVOWU3/vxHqK8X5Hb8bpx8k2nYZc9dydu5rnXW826D
         hSsR1ljq8/hre6ktwFqfc9iIWgTWwC5CJZGHFSjqalTJKmavfQlqD2FiH91qe7haTaIN
         yxIzov3ehSXS0uXHLBlTrfWrHOdXvEwnAeisLgQMJNwE/qlCifMi+jVrdF+MYxF/AL+q
         fJ92KJsVmAHMD1OflZ0XGPPZPjQ0TGtRzycMv8Xn8XpEoCJbihvzq/omFt2M6i9NpLG1
         4G9KyB4puXkdHOJ3dPKWsBjVsfNBWcwVf1sgPp8cBYM1/Hv8WoOTmUHKTxLSrLvwFK2K
         HWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898801; x=1722503601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbOh1YnLRGUof5jIdg/YaLDXWdX8IKsWKWEs5XtNUCY=;
        b=g71OaXo8nnpiRo22cSqf0VmQhKgUEfVc3rOnx9R3VyGM3TjUS3JlblBXp13OQVLMXF
         nxpdcnFs6dfQNb4vmrEUEGDXVW4t2FJEdHF63z3NzlMyfUdhKQbZYKNNQcVO7u9WVYga
         JmIbytWY/ZSo6UyzCn7UhVcTe+eDN/rp+HX1m/JPasxmQ1FUxEDpSAN6XwK38ViHKNgl
         CEocK8m3hj/qA+fnDpK1/0mWbJ1zbI3aXJHY1CNp688sZMUjYN7Brn4VbbXVPfcsIE+I
         jORO1kSbWeH21Vdy0ONmyhsltL8cjxkTBaO8WdeDA9oidRMlGIoZg7Y1vYGeCZYJ4RLM
         /6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCX1VHcoFv0SCJb48kIKTOtekP3KOGaoZUn0LziOv7iNev3PhvOGmskdSIP1Dvxw5o8bGtC82D3/xZrhbmfCLndhfgv/SU07FOzVhzPS
X-Gm-Message-State: AOJu0Yy7j43rSSnEL2W2gsBDGzOFaDijhqiqikhJhINLN/6YUhqXjhiP
	Qf0zq//5rmSyrCVEvHZ/UChMPa+muFXpLC65kDsnBfDxucN2Jtvp/3Euoeftzmk=
X-Google-Smtp-Source: AGHT+IHxmwgcPOVP7EAaplSEN4sDlAIuvKhcJZrN3BNDqOUMOcNM4PXGUk94TQFdyWJlKa2+KaDWzQ==
X-Received: by 2002:a17:906:c145:b0:a7a:a138:dbc5 with SMTP id a640c23a62f3a-a7acb97172bmr106298066b.65.1721898800661;
        Thu, 25 Jul 2024 02:13:20 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb98a2sm49682166b.217.2024.07.25.02.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:13:20 -0700 (PDT)
Message-ID: <036855d4-b1d4-444b-92d6-84376ecdffb8@suse.com>
Date: Thu, 25 Jul 2024 11:13:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/xen: fix memblock_reserve() usage on PVH
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20240725073116.14626-1-roger.pau@citrix.com>
 <20240725073116.14626-3-roger.pau@citrix.com>
 <a249e651-a2a1-4ea9-b262-0d04a8abaf0e@suse.com> <ZqIIgc9xj6wmDJtE@macbook>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <ZqIIgc9xj6wmDJtE@macbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.24 10:10, Roger Pau Monné wrote:
> On Thu, Jul 25, 2024 at 10:01:17AM +0200, Jürgen Groß wrote:
>> On 25.07.24 09:31, Roger Pau Monne wrote:
>>> The current usage of memblock_reserve() in init_pvh_bootparams() is done before
>>> the .bss is zeroed, and that used to be fine when
>>> memblock_reserved_init_regions implicitly ended up in the .meminit.data
>>> section.  However after commit 73db3abdca58c memblock_reserved_init_regions
>>> ends up in the .bss section, thus breaking it's usage before the .bss is
>>> cleared.
>>>
>>> Move and rename the call to xen_reserve_extra_memory() so it's done in the
>>> x86_init.oem.arch_setup hook, which gets executed after the .bss has been
>>> zeroed, but before calling e820__memory_setup().
>>>
>>> Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
>>> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
>>> ---
>>> While the commit that introduced the user-noticeable regression is
>>> 73db3abdca58c, I think 38620fc4e893 should have been more careful to not
>>> initialize the memblock ranges ahead of the .bss zeroing.
>>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>
>> I'd prefer using 73db3abdca58c for the fixes tag. Otherwise you'd need to
>> add this patch to the stable branches, too, which is technically not really
>> needed.
>>
>> Additionally I'd like to drop the Fixes: tag from the prereq patch, as this
>> one doesn't really fix anything.
>>
>> I can do both while committing.
> 
> I was unsure myself (as noted in the post-commit notes) about which
> "Fixes:" tag to use.
> 
> Is there anyway that it can be noted that this commit depends on the
> previous change also being present?  For backport reasons, if anyone
> ends up backporting 73db3abdca58c it would also need to pick the two
> patches here.

This is normal business of backporting. This patch added to a stable kernel
would at least result in a build failure. The person doing the backport could
it either fixup locally in the backported patch, or look which patch did setup
the source to make this patch work.


Juergen


