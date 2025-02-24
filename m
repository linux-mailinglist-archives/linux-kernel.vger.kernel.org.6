Return-Path: <linux-kernel+bounces-528737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C07A41BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1791A1726AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73210257ACB;
	Mon, 24 Feb 2025 10:50:11 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F629257456
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394211; cv=none; b=GN565u5kBDs6v6Wxo4a3K+Y/z0WQhzHEZeVfzyk7DxxfDNXXtDW+NvT+8du67DNX3A4zXH4HYvuB/JGx6bhasfZUV/yB7GR2Ee0Za9ngTeWd6LtbpVoM5Z6/570qmIjCb2lb4WfvwAWfBeXHOcqZuvIytrQ32h/UTyM/7xux9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394211; c=relaxed/simple;
	bh=+5dgnycedFYjCfpv9nlh2kaRz6IOGUBOWQxH0GhJKPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7ZuVMAJX6g5v2fix6iuxFhm+6ig5p+yHrEbpYzJcMrc2hbzLyISBpNr9mY46uKS+DAirsKDLzIINgJWgNoepjhAtzubCQ5zz5yuHFEZE5H57fk3PWkyKeWwWijd+vMuwhTlTY3xtEmN42v5zsOdYcv2Qjggjve9WeBAHnbqq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z1cbK3Xnhz9sVQ;
	Mon, 24 Feb 2025 11:36:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rAyZKr75BxfC; Mon, 24 Feb 2025 11:36:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z1cbK2FxHz9sVN;
	Mon, 24 Feb 2025 11:36:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 39B398B765;
	Mon, 24 Feb 2025 11:36:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id sYvQOoZx4V4Q; Mon, 24 Feb 2025 11:36:13 +0100 (CET)
Received: from [10.25.207.138] (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A1BF8B763;
	Mon, 24 Feb 2025 11:36:13 +0100 (CET)
Message-ID: <055e567d-771c-4031-952c-1bcdbf921c90@csgroup.eu>
Date: Mon, 24 Feb 2025 11:36:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call warning
 for bl+mflr pattern
To: Sathvika Vasireddy <sv@linux.ibm.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, npiggin@gmail.com, maddy@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 llvm@lists.linux.dev
References: <20250219162014.10334-1-sv@linux.ibm.com>
 <20250220195940.ely2l2fpsozd2tuv@jpoimboe>
 <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 21/02/2025 à 09:50, Sathvika Vasireddy a écrit :
> [Vous ne recevez pas souvent de courriers de sv@linux.ibm.com. Découvrez 
> pourquoi ceci est important à https://aka.ms/ 
> LearnAboutSenderIdentification ]
> 
> Hi Josh, Thanks for the review.
> 
> On 2/21/25 1:29 AM, Josh Poimboeuf wrote:
>> On Wed, Feb 19, 2025 at 09:50:14PM +0530, Sathvika Vasireddy wrote:
>>> Architectures like PowerPC use a pattern where the compiler generates a
>>> branch-and-link (bl) instruction that targets the very next instruction,
>>> followed by loading the link register (mflr) later. This pattern appears
>>> in the code like:
>>>
>>>   bl .+4
>>>   li r5,0
>>>   mflr r30
>> If I understand correctly, this is basically a fake call which is used
>> to get the value of the program counter?
> 
> Yes, that's correct.
> 
> Also, just out of curiosity, how does x86 do it? Does it not use a
> branch to next instruction approach?
> 
>>> Objtool currently warns about this as an "unannotated intra-function
>>> call" because find_call_destination() fails to find any symbol at the
>>> target offset. Add a check to skip the warning when a branch targets
>>> the immediate next instruction in the same function.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild- 
>>> all%2F202502180818.XnFdv8I8- 
>>> lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cdce2affdaed147a6058008dd5254d85e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638757246560427230%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=dhUS9PNZKUpz%2Bc1hePG1tuTIWbiKqS46uoAJOvU76sU%3D&reserved=0
>>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
>> This should have a Fixes tag as well.
> Thanks for catching that. I'll add the Fixes tag.
>>
>>>   static int add_call_destinations(struct objtool_file *file)
>>>   {
>>> +    struct instruction *next_insn;
>>>      struct instruction *insn;
>>>      unsigned long dest_off;
>>>      struct symbol *dest;
>>> @@ -1625,6 +1626,11 @@ static int add_call_destinations(struct 
>>> objtool_file *file)
>>>              reloc = insn_reloc(file, insn);
>>>              if (!reloc) {
>>>                      dest_off = arch_jump_destination(insn);
>>> +
>>> +                    next_insn = next_insn_same_func(file, insn);
>>> +                    if (next_insn && dest_off == next_insn->offset)
>>> +                            continue;
>>> +
>> This won't work on x86, where an intra-function call is converted to a
>> stack-modifying JUMP.  So this should probably be checked in an
>> arch-specific function.
> 
> Thanks for letting me know, I'll introduce arch_skip_call_warning() to
> handle architecture specific cases in the next patch I send.

Not sure what you want to do here.

See my other response, I think it should just be handled as an 
INSN_OTHER by arch_decode_instruction()

Christophe

