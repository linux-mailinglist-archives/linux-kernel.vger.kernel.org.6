Return-Path: <linux-kernel+bounces-281002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B594D1C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5BF1F223FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3D195FE8;
	Fri,  9 Aug 2024 14:06:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294EB1957FF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212373; cv=none; b=aYVypOUXHReDipt/0mJXAZVmuAphWFEgGGgxBIbhC7MkmSbxrrW5qj/sjFP6EVpLOY0sgipmgUJW5bMOoeg5FRWy0uAUyGuar7NqOmKv43IUSG1+XuOazKoCehV8LEf/sq7rxIzP6prT92wNcUO34KGh3QNop5xmmR2lajqLECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212373; c=relaxed/simple;
	bh=Cogyoh4hJqwNNHNrXurWEt3HW3wDpfXJPxduH7jcgH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXGId6N5vN70CxxWGf9zQ6R1HC6X3toYazZTBZM4cq+cqmc2U3lLowjU7OyU6Pz3Zz0VhYZ51NCTag2CD9VATwVj6kXO7GuDy5TH3T8MouAjOu2/jGjeePv+1tGEHAfZFKqivmjuelepItZ+SbEtle73xFzIK1ILXgskBi8Rv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FEA213D5;
	Fri,  9 Aug 2024 07:06:36 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE0C3F71E;
	Fri,  9 Aug 2024 07:06:09 -0700 (PDT)
Message-ID: <607b4abd-108c-4d3c-97e4-906a0a21aab5@arm.com>
Date: Fri, 9 Aug 2024 15:06:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf scripts python arm-cs-trace-disasm.py: Skip
 disasm of discontiguous packets
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 james.clark@arm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: acme@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
 scclevenger@os.amperecomputing.com
References: <20240809094047.319917-1-gankulkarni@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240809094047.319917-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 10:40, Ganapatrao Kulkarni wrote:> Script uses contiguous address range of adjacent packets to generate
> the tracing. When there is a continuity brake due to discontiguous
> branch address, it is resulting in to a perf tool crash(segfault).
> This is expected bhehaviour since the decoder is not expecting the
> discontiguous packets.
> 
> Adding an option "force" to allow the decoder to continue and complete
> the tracing without application crash by dropping the discontiguous
> packets from decoding.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
> 
> Changes since V1:
>          Updated patch as per discussions[1].
> 
> [1] https://lore.kernel.org/linux-arm-kernel/ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org/T/
> 
>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..65d59db3bcec 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -36,7 +36,10 @@ option_list = [
>                      help="Set path to objdump executable file"),
>          make_option("-v", "--verbose", dest="verbose",
>                      action="store_true", default=False,
> -                   help="Enable debugging log")
> +                   help="Enable debugging log"),
> +       make_option("-f", "--force", dest="force",
> +                   action="store_true", default=False,
> +                   help="Force decoder to continue")
>   ]
> 
>   parser = OptionParser(option_list=option_list)
> @@ -257,6 +260,13 @@ def process_event(param_dict):
>                  print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>                  return
> 
> +       if (stop_addr < start_addr):
> +               if (options.verbose or not options.force):
> +                       print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
> +                       print("Use option '-f' following the script for force mode")
> +               if (options.force):
> +                               return

A redundant indentation? After fix it:

Reviewed-by: Leo Yan <leo.yan@arm.com>
  
> +
>          if (options.objdump_name != None):
>                  # It doesn't need to decrease virtual memory offset for disassembly
>                  # for kernel dso and executable file dso, so in this case we set
> --
> 2.44.0
> 

