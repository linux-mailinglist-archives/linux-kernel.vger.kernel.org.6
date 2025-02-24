Return-Path: <linux-kernel+bounces-528450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0A0A417CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F86E3B09E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59D124168D;
	Mon, 24 Feb 2025 08:50:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63423E229
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387005; cv=none; b=GMF9JWvP+K/wHzwh4qQbap9JWxOeDpQZz2Th74y2e9SwUkJ6/fipjOT5KrtdLGpLMbfpRlrVZzVMhEjMNf9h+AucQ9ncxhVR8ORtE1wmVABSXVYOJPlF03CLyAQr7QjRiYDdb7tVCplN2iSKqja/7p2MGr8rmV7QWmYhrU3h0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387005; c=relaxed/simple;
	bh=NTQBoA/Re9LOQf6S9eC4YE+8T4L/xXTbEfMQqi0vkuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktZ6NYsSPf0Z/x8+pXDL3VX1niFjQd7NHqbH1jf4AWUMyOQdePr9bBotDLFjc2gAkdmL8M0G5QY+PI/tGgAzv0a1NYI/J1PLFScqD71zyxF9Aww/+h0bNwdTXxCI1I1KKnqSoBNzUuRrArR2AGOdLz2efSCARwwgeIWYVOoTYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z1X7D3xsVz9sSY;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FlCaqB87YQCz; Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z1X7D2md3z9sSX;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A4978B765;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SnYPeEpOAy8h; Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Received: from [10.25.207.138] (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 23FFD8B763;
	Mon, 24 Feb 2025 08:15:04 +0100 (CET)
Message-ID: <3223ec0e-c445-4bbf-ae72-276688e40908@csgroup.eu>
Date: Mon, 24 Feb 2025 08:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call warning
 for bl+mflr pattern
To: Sathvika Vasireddy <sv@linux.ibm.com>, jpoimboe@kernel.org,
 peterz@infradead.org, npiggin@gmail.com, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 llvm@lists.linux.dev
References: <20250219162014.10334-1-sv@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250219162014.10334-1-sv@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/02/2025 à 17:20, Sathvika Vasireddy a écrit :
> Architectures like PowerPC use a pattern where the compiler generates a
> branch-and-link (bl) instruction that targets the very next instruction,
> followed by loading the link register (mflr) later. This pattern appears
> in the code like:
> 
>   bl .+4
>   li r5,0
>   mflr r30

What compiler do you use ? Is it a very old version of GCC ?

That sequence is not correct and should never be used by modern 
compilers. It should be bcl 20,31,+4 instead.

All such hand writen sequences have been removed from kernel assembly, 
see commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption in 
__get_datapage()") for details


> 
> Objtool currently warns about this as an "unannotated intra-function
> call" because find_call_destination() fails to find any symbol at the
> target offset. Add a check to skip the warning when a branch targets
> the immediate next instruction in the same function.

I think this should be done in arch_decode_instruction(), just set 
insn->type to INSN_OTHER when you see bl .+4

Something like:

diff --git a/tools/objtool/arch/powerpc/decode.c 
b/tools/objtool/arch/powerpc/decode.c
index 53b55690f320..ca264c97ee8d 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -55,7 +55,9 @@ int arch_decode_instruction(struct objtool_file *file, 
const struct section *sec

  	switch (opcode) {
  	case 18: /* b[l][a] */
-		if ((ins & 3) == 1) /* bl */
+		if (ins == 0x48000005)	/* bl .+4 */
+			typ = INSN_OTHER;
+		else if ((ins & 3) == 1) /* bl */
  			typ = INSN_CALL;

  		imm = ins & 0x3fffffc;



> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502180818.XnFdv8I8-lkp@intel.com/
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>   tools/objtool/check.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 753dbc4f8198..3f7cf2c917b5 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1613,6 +1613,7 @@ static struct symbol *find_call_destination(struct section *sec, unsigned long o
>    */
>   static int add_call_destinations(struct objtool_file *file)
>   {
> +       struct instruction *next_insn;
>          struct instruction *insn;
>          unsigned long dest_off;
>          struct symbol *dest;
> @@ -1625,6 +1626,11 @@ static int add_call_destinations(struct objtool_file *file)
>                  reloc = insn_reloc(file, insn);
>                  if (!reloc) {
>                          dest_off = arch_jump_destination(insn);
> +
> +                       next_insn = next_insn_same_func(file, insn);
> +                       if (next_insn && dest_off == next_insn->offset)
> +                               continue;
> +
>                          dest = find_call_destination(insn->sec, dest_off);
> 
>                          add_call_dest(file, insn, dest, false);
> --
> 2.39.3
> 


