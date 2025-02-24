Return-Path: <linux-kernel+bounces-529803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F271BA42B19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E7B3B2D51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBCB2676D3;
	Mon, 24 Feb 2025 18:20:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081D2676CC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421205; cv=none; b=rVPU7xfNjcFzHcQLFEoF0vqQ3M0EN6F6o2fa+Ay3xoldaa+yWVV+AM3wzpZKR9Tp4PPhWilc9JeXRA2WvG5MtVdZQ7ZUXkxVXNuIBAdP65yVkLIJsYhHE76rJhFSw8ZrjvyOUl682BS3GfelDLX2PHD17nmCVkFXg29HlEy/UHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421205; c=relaxed/simple;
	bh=qX6i8P+Lvx2UxBOov0jLP9vRTlNl0FMv1d14HJk1/i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQwbxgeVSmg68/eLv/y7Euz38EK62IDE1K7hI4GB4ROup+mLDapopTCpFPNwl56+QY/VWEZu2q4GrLb92UlBHRJDblwSb3qkcWKcBM8eb8ftsteUuOiKR7ycQoovQmyG9Dc/ys0U5Ig76yVUhez0w+MOunKeNEajlTV7olc/Ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z1pKK5Fkrz9sSH;
	Mon, 24 Feb 2025 18:54:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L0MKA8qxQct2; Mon, 24 Feb 2025 18:54:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z1pKK4Vknz9sSC;
	Mon, 24 Feb 2025 18:54:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 887038B780;
	Mon, 24 Feb 2025 18:54:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xx2jkbRBAbLX; Mon, 24 Feb 2025 18:54:45 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F34B8B77C;
	Mon, 24 Feb 2025 18:54:45 +0100 (CET)
Message-ID: <9435789c-cd05-4ec1-bcef-42d81fd87053@csgroup.eu>
Date: Mon, 24 Feb 2025 18:54:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call warning
 for bl+mflr pattern
To: Peter Zijlstra <peterz@infradead.org>,
 Sathvika Vasireddy <sv@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, npiggin@gmail.com,
 maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
References: <20250219162014.10334-1-sv@linux.ibm.com>
 <20250220195940.ely2l2fpsozd2tuv@jpoimboe>
 <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>
 <20250224162542.GE11590@noisy.programming.kicks-ass.net>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250224162542.GE11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/02/2025 à 17:25, Peter Zijlstra a écrit :
> On Fri, Feb 21, 2025 at 02:20:41PM +0530, Sathvika Vasireddy wrote:
> 
>>>> @@ -1625,6 +1626,11 @@ static int add_call_destinations(struct objtool_file *file)
>>>>    		reloc = insn_reloc(file, insn);
>>>>    		if (!reloc) {
>>>>    			dest_off = arch_jump_destination(insn);
>>>> +
>>>> +			next_insn = next_insn_same_func(file, insn);
>>>> +			if (next_insn && dest_off == next_insn->offset)
>>>> +				continue;
>>>> +
>>> This won't work on x86, where an intra-function call is converted to a
>>> stack-modifying JUMP.  So this should probably be checked in an
>>> arch-specific function.
>>
>> Thanks for letting me know, I'll introduce arch_skip_call_warning() to
>> handle architecture specific cases in the next patch I send.
> 
> Can't you detect this pattern in decode and simpy not emit the call
> instruction?
> 

Yes we can, simply do:

diff --git a/tools/objtool/arch/powerpc/decode.c 
b/tools/objtool/arch/powerpc/decode.c
index 53b55690f320..4f9b1715caf1 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -55,7 +55,7 @@ int arch_decode_instruction(struct objtool_file *file, 
const struct section *sec

  	switch (opcode) {
  	case 18: /* b[l][a] */
-		if ((ins & 3) == 1) /* bl */
+		if ((ins & 3) == 1 && ins != 0x48000005) /* bl but not bl .+4*/
  			typ = INSN_CALL;

  		imm = ins & 0x3fffffc;


