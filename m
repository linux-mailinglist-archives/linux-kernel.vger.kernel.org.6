Return-Path: <linux-kernel+bounces-536825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E5A484DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695C917E368
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E263231A42;
	Thu, 27 Feb 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ylct2VKx"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629C1DE3C1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672767; cv=none; b=g7yJjmEFVQlsvMH6TSMCn5qgYc/LNK6Fzcxaa+Gc+urVYnAmGOeMLWDUWqy9PEVDFaiDUHqqlf9O9ZXNDmKjYfLh8+eUm1pFrLyzRBzt56VsxeQeejzGt0LHtN5pzzpxCmrqHtMNlkve/FCWjo7OU5cBcllBPx7syOqkNcg/zLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672767; c=relaxed/simple;
	bh=1B0baukk8wkKOrWBLrryYto1XBCAZ5THIRI3bdA1or8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBa+q7VbyL2YFNweS4jfHlSyx7/ayP7mnBHkG33rUbDbvEDmgCAeoEu1x646rVdWxUfjnl883Ad8u5v4T4f9flzh3o5MYElz/86o2vt7YcTL4e6CxOBHJqSF1hgCIL0jKFhF8iWm7OJL6yjs22kffslgdlVTreKXSBC7GNYgBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ylct2VKx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so1631880a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740672763; x=1741277563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+URe4l4GJhqH8ce+Ye1sM1VEzjf+QaS7p2yiXPuh81o=;
        b=Ylct2VKxaWZZpvoVaOoS4MSuId6Ql8tcOV6o6eXWJgb+7ku67keuM9q80UjtGO+bx5
         XAT1AqFja0HUenIOPycNS2nhT27CKd0plfG8kHeytllvhk2prM9vJ705OD6ofi+nbDND
         gBRC8va4a2olvt1O1HHUrqcPjnjLT3+hxIN9G6O1TxduWyTsKrgYLsxIf21uxswGrLMV
         SuAKZ5F8s53OUgqvqF7jsznHPYE9iLC7KvRsAiGEoEyD9aEujkeS3//rjsDb2J+4+CTp
         mcd5UrBDw94pYMfRlR+j0iLClRr44iMPPSRTqT1X0Du1dHAh0EkndHtxaUNBJ1X2eUh2
         wxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672763; x=1741277563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+URe4l4GJhqH8ce+Ye1sM1VEzjf+QaS7p2yiXPuh81o=;
        b=FSSy1l76etA4qlSmBrnKNPcKbP9nrzucKFeKuQg881NlEIadgpXT0hv1xjQykLX+H4
         F9/cY2PSbZqBHKN3j9K/09SzLmpcS1d0LvAg74+Hiuwhxv9rQOaZqphvbnY08Xh/rBSC
         Dew6j1G7XGgMZU9ndAoHzx7JnkkcRZKiPwGD8p2wVjDiyuC4ZhSWQoMx27z8qFRcO2It
         fBB6bmnN/P64nEJ+sgy6sbRwNox3IhsVSkib3NeYl0I7g2twys8yEhfx4u0JyzGp1g/o
         Lf6gyhYnHiYl1GZXsUXxGDTFJHpSTiWQvrXLORM0sPyVtkMDDhQVUwJaUXXUWNvOZxID
         nZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9rwWkelP5GFUK85DfGYyJpZNBdwI/umScqHnWUT2YBpEAlTCSJwZ5y5pdiWg1at0VLXN7D438jJyZpOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMHSPZSek6D/xjDrjsxEYUtN6c8cUtUywbSleOkFiLG2fJfvE
	uxlD4mZIoWLKOutg8JQ9NgWP78hiGNqI5QdJtuDDlsIMpcdfhpUgRRttWtv0iu8=
X-Gm-Gg: ASbGnct0H9NiZqXdZAeXg2aXqMEYuG/oRGFBcSBFxEDz7pFNQPxaAKEOwbkFLzytit3
	qTnoObonsQ3SilCPXgP1wCVO0kI3s1P+E9rIYpUKEtBz7fPFgKRlGGsZNWET7Q/ZZ/uj7hIuoC7
	QpaPRSRRa6H9sX1McbybgG/pcxzycpGvOk/OXNCaLUcUYHHGvpO9uCXQjAsqRiBN9d/gf8DH/EY
	P4kZGGX7ADwTn20duKucS0Ryosl/j+igxObEb4ULD+MLhq8FOoNfhv8BQmhr/98qTpN5Z+brM0w
	NtqD8XuQXUo+6vP2rbu86cTaFPAr+RAudkYQSLKBSYfCtpXvmWifJtOgfEF9s7VWF0ve
X-Google-Smtp-Source: AGHT+IE0fDWdYp4mhDV4izDKRhRUb/i7cABjqRBwrDib2YU3lQR3wBE+FeIurjA8jt4nIowndYjJ4A==
X-Received: by 2002:a17:907:d2a:b0:ab7:fc9a:28e1 with SMTP id a640c23a62f3a-abc0de5a487mr3052219166b.52.1740672763076;
        Thu, 27 Feb 2025 08:12:43 -0800 (PST)
Received: from [192.168.1.57] (93-41-52-155.ip80.fastwebnet.it. [93.41.52.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd6ccsm146200766b.57.2025.02.27.08.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:12:42 -0800 (PST)
Message-ID: <e052eb20-09ff-4917-8841-95af889afd9e@suse.com>
Date: Thu, 27 Feb 2025 17:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: livepatch: move text out of code block
To: Jonathan Corbet <corbet@lwn.net>, live-patching@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
 joe.lawrence@redhat.com
References: <20250227150328.124438-1-vincenzo.mezzela@suse.com>
 <87bjunqtg8.fsf@trenco.lwn.net>
Content-Language: en-US
From: Vincenzo Mezzela <vincenzo.mezzela@suse.com>
In-Reply-To: <87bjunqtg8.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 4:48 PM, Jonathan Corbet wrote:
> Vincenzo MEZZELA <vincenzo.mezzela@suse.com> writes:
> 
>> Part of the documentation text is included in the readelf output code
>> block. Hence, split the code block and move the affected text outside.
>>
>> Signed-off-by: Vincenzo MEZZELA <vincenzo.mezzela@suse.com>
>> ---
>>   Documentation/livepatch/module-elf-format.rst | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/livepatch/module-elf-format.rst b/Documentation/livepatch/module-elf-format.rst
>> index a03ed02ec57e..eadcff224335 100644
>> --- a/Documentation/livepatch/module-elf-format.rst
>> +++ b/Documentation/livepatch/module-elf-format.rst
>> @@ -217,16 +217,23 @@ livepatch relocation section refer to their respective symbols with their symbol
>>   indices, and the original symbol indices (and thus the symtab ordering) must be
>>   preserved in order for apply_relocate_add() to find the right symbol.
>>   
>> -For example, take this particular rela from a livepatch module:::
>> +For example, take this particular rela from a livepatch module:
>> +
>> +::
> 
> The right fix here is to just delete the extra ":"
> 
>>     Relocation section '.klp.rela.btrfs.text.btrfs_feature_attr_show' at offset 0x2ba0 contains 4 entries:
>>         Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>>     000000000000001f  0000005e00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.printk,0 - 4
>>   
>> -  This rela refers to the symbol '.klp.sym.vmlinux.printk,0', and the symbol index is encoded
>> -  in 'Info'. Here its symbol index is 0x5e, which is 94 in decimal, which refers to the
>> -  symbol index 94.
>> -  And in this patch module's corresponding symbol table, symbol index 94 refers to that very symbol:
>> +This rela refers to the symbol '.klp.sym.vmlinux.printk,0', and the symbol
>> +index is encoded in 'Info'. Here its symbol index is 0x5e, which is 94 in
>> +decimal, which refers to the symbol index 94.
>> +
>> +And in this patch module's corresponding symbol table, symbol index 94 refers
>> +to that very symbol:
>> +
>> +::
> 
> You can put that extra colon here rather than introducing a separate
> "::" line.
> 

Hi,

You are right. I'll send an updated version.


Thanks for the feedback,

Vincenzo

