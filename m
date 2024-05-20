Return-Path: <linux-kernel+bounces-183985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A28CA0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1039281024
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F613793F;
	Mon, 20 May 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m6vHjLOA"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB711184
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224519; cv=none; b=VsK3gQrMWu30tkz24xJlUgg38XThUnd66XxxdcYlFvEwR7WyJ2EnfBPteY5sHW1xzr+Z8fotjPfIvLctr4zGyv1n9BkDMNwJsF/eYPwiFg3DC7Pxv2AYgyQwQRXv4N2viP3cidz/rQjTB74tNUrhsIS4Bq/hEGuByhp0vUWWEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224519; c=relaxed/simple;
	bh=+61SlSFs+bK47d9CKe64gm4Q05wLUYPddacTpbPUX94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwSIDx5oDViAkWzDUozIcgWqOPfx92FDoH0pztKeTFduBnZB0tN+vWNEzD6hHZKncOA/suR1UnlR8CMbQEqBC/zHF8Xc4phbO1iwAitR4pJ+2eTDnt3jOmhgBSm1aXrExbA3LM0JgJjUaiVWiMSaRj1iOJDbdWaj1F5h2Bjwj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m6vHjLOA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716224514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAgmPQxenfiA/ZhiTeo4I/5YK5kI+JEH9mMpDcYcRdg=;
	b=m6vHjLOAF12YD8MlEZSeLfBS0wuKogqiwdOsKP3RkFH7frV7s3Tszz5kY4HxxFD3aQ6rTX
	Vk/JwnCmzc0JCWOeVV5rTOqfKO+gzf2Srx4MlI3KM8+HeStcHVNjaFjbUJkSkHpmo2xvm7
	HplM9mUUtzRO/Ou8kJfeehPXeb8dzU4=
X-Envelope-To: ivan@cloudflare.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: llvm@lists.linux.dev
Message-ID: <5cb46d34-f4a3-49c7-8dd6-df6bc87b4f25@linux.dev>
Date: Mon, 20 May 2024 10:01:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpftool does not print full names with LLVM 17 and newer
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ivan Babrou <ivan@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>
References: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
 <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/17/24 5:33 PM, Alexei Starovoitov wrote:
> On Fri, May 17, 2024 at 2:51 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>> Hello,
>>
>> We recently bumped LLVM used for bpftool compilation from 15 to 18 and
>> our alerting system notified us about some unknown bpf programs. It
>> turns out, the names were truncated to 15 chars, whereas before they
>> were longer.
>>
>> After some investigation, I was able to see that the following code:
>>
>>      diff --git a/src/common.c b/src/common.c
>>      index 958e92a..ac38506 100644
>>      --- a/src/common.c
>>      +++ b/src/common.c
>>      @@ -435,7 +435,9 @@ void get_prog_full_name(const struct
>> bpf_prog_info *prog_info, int prog_fd,
>>          if (!prog_btf)
>>              goto copy_name;
>>
>>      +    printf("[0] finfo.type_id = %x\n", finfo.type_id);
>>          func_type = btf__type_by_id(prog_btf, finfo.type_id);
>>      +    printf("[1] finfo.type_id = %x\n", finfo.type_id);
>>          if (!func_type || !btf_is_func(func_type))
>>              goto copy_name;
>>
>> When ran under gdb, shows:
>>
>>      (gdb) b common.c:439
>>      Breakpoint 1 at 0x16859: file common.c, line 439.
>>
>>      (gdb) r
>>      3403: tracing  [0] finfo.type_id = 0
>>
>>      Breakpoint 1, get_prog_full_name (prog_info=0x7fffffffe160,
>> prog_fd=3, name_buff=0x7fffffffe030 "", buff_len=128) at common.c:439
>>      439        func_type = btf__type_by_id(prog_btf, finfo.type_id);
>>      (gdb) print finfo
>>      $1 = {insn_off = 0, type_id = 1547}
>>
>>
>> Notice that finfo.type_id is printed as zero, but in gdb it is in fact 1547.
>>
>> Disassembly difference looks like this:
>>
>>      -    8b 75 cc                 mov    -0x34(%rbp),%esi
>>      -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
>>      +    31 f6                    xor    %esi,%esi
>>      +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
>>
>> This can be avoided if one removes "const" during finfo initialization:
>>
>>      const struct bpf_func_info finfo = {};
>>
>> This seems like a pretty annoying miscompilation, and hopefully
>> there's a way to make clang complain about this loudly, but that's
>> outside of my expertise. There might be other places like this that we
>> just haven't noticed yet.
>>
>> I can send a patch to fix this particular issue, but I'm hoping for a
>> more comprehensive approach from people who know better.
> Wow. Great catch. Please send a patch to fix bpftool and,

Indeed, removing 'const' modifier should allow correct code
generation.

> I agree, llvm should be warning about such footgun,
> but the way ptr_to_u64() is written is probably silencing it.

Yes, ptr_to_u64() cast a 'ptr to const value' to a __u64
which later could be used as 'ptr to value' where the 'value'
could be changed.

> We probably should drop 'const' from it:
> static inline __u64 ptr_to_u64(const void *ptr)
>
> and maybe add a flavor of ptr_to_u64 with extra check
> that the arg doesn't have a const modifier.
> __builtin_types_compatible_p(typeof(ptr), void *)
> should do the trick.

I guess we could introduce ptr_non_const_to_u64() like

static inline __u64 ptr_non_const_to_u64(void *ptr)
{
         static_assert(__builtin_types_compatible_p(typeof(ptr), void *), "expect type void *");
         return (__u64)(unsigned long)ptr;
}

and add additional check in ptr_to_u64() like

static inline __u64 ptr_to_u64(const void *ptr)
{
        static_assert(__builtin_types_compatible_p(typeof(ptr), const void *), "expect type const void *");
        return (__u64)(unsigned long)ptr;
}

But I am not sure how useful they are. If users declare the variable as 'const'
and use ptr_to_u64(), compilation will succeed but the result could be wrong.

Compiler could do the following analysis:
   (1) ptr_to_u64() argument is a constant and the result is __u64 (let us say u64_val = ptr_to_u64(...)).
   (2) u64_val has address taken and its content may be modified in the current function or
       through the function call. If this is true, compiler might warn. This will require some
       analysis and the warning may not be always true (esp. it requires inter-procedural analysis and
       in this case, bpf_prog_get_info_by_fd() eventually goes into the library/kernel so compiler has no
       way to know whether the value could change).
So I guess it will be very hard for compiler to warn for this particular case.


