Return-Path: <linux-kernel+bounces-543889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E2A4DB31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF283AD8AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D8B200B96;
	Tue,  4 Mar 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WwZqQsYX"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E21F76C0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084762; cv=none; b=huA2ElRcEVYRJ1HKxpS2Lhgglan+DQRcEioZ2+y5hsYxAjBzrTlnLRB+TWivXK1Y2r/nIgoPI3yC2iYahyJq4gb4/BM+jAeMeGz7iclpbVfcYwvuG5Dc/Pxyfxn0/d4WPQ6lh4/5ZmP2sFkN/bSPhKX7BHeNXvBpEqOBbSYjzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084762; c=relaxed/simple;
	bh=tWpIb51koZ59tWr7xtC1KDp0sRGLFFDOXKc+1GgNS58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/1ecp7e8l7ZSmkUADUu1dlmv1YcC4aI5iZEn60btva9OO2hZXMQ49dpthP5UdnxCvD7uER4aRgpzS9jpswt6Ybms70TQpR39xpqVaSWiDRqvUddMuCrf6XKtSPG39/0tVYoHAPXeYIAn7TpE/EXPctU4RY+hc1CV5u6s9fqYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WwZqQsYX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3T3sYPEX+JC62Vhxsa8Zhe/nFCt5CfdO/GdFYuTHFqA=; b=WwZqQsYXOdXZAWu3fujormmlCf
	IkEDhT/0UQrypwdTm+q3qvnc58kQcEXLDR1yDZrO3yJ4pVSW87ISbLEJWRAD3YFP8i3i+FiLw8ZSi
	Vy4OLpMkG1YUOts9YKQrwGllP98x+3rCOB0pJuX2fmm7z4EetdIMdtLSel1RDWOqNzvox2pFTuO0e
	fp/f5Im449F2cXtMNuBBGfB2Xcq0j3xDIyNmDImdijZbzBIqb/2WvrgSBiA+Kp7HVyfmb92khWFtN
	dX2EsxS2YkUL0IoxxLlAk0QZ9mV4OJY2oHdgpjdAbVv/vw2AtebVHS+GNa+ZK5FofOf6Mx8w17AEs
	jIFSlE+w==;
Received: from [175.114.83.198] (helo=[192.168.45.92])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tpPfy-003fQq-Hz; Tue, 04 Mar 2025 11:39:08 +0100
Message-ID: <9db68100-65d0-43e5-a1c0-2aff771f173f@igalia.com>
Date: Tue, 4 Mar 2025 19:39:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched_ext: Add trace point to track sched_ext core
 events
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20250304012740.35473-1-changwoo@igalia.com>
 <20250304012740.35473-3-changwoo@igalia.com> <Z8agpJNFR30DmJG4@gpd3>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z8agpJNFR30DmJG4@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 25. 3. 4. 15:41, Andrea Righi wrote:
> Hi Changwoo,
> 
> On Tue, Mar 04, 2025 at 10:27:40AM +0900, Changwoo Min wrote:
>> Add tracing support to track sched_ext core events
>> (/sched_ext/sched_ext_event). This may be useful for debugging sched_ext
>> schedulers that trigger a particular event.
>>
>> The trace point can be used as other trace points, so it can be used in,
>> for example, `perf trace` and BPF programs, as follows:
>>
>> ======
>> $> sudo perf trace -e sched_ext:sched_ext_event --filter 'name == "SCX_EV_ENQ_SLICE_DFL"'
>> ======
>>
>> ======
>> struct tp_sched_ext_event {
>> 	struct trace_entry ent;
>> 	u32 __data_loc_name;
>> 	s64 delta;
>> };
>>
>> SEC("tracepoint/sched_ext/sched_ext_event")
>> int rtp_add_event(struct tp_sched_ext_event *ctx)
>> {
>> 	char event_name[128];
>> 	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
>>          bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);
>>
>> 	bpf_printk("name %s   delta %lld", event_name, ctx->delta);
>> 	return 0;
>> }
>> ======
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   include/trace/events/sched_ext.h | 19 +++++++++++++++++++
>>   kernel/sched/ext.c               |  2 ++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
>> index fe19da7315a9..3d04b9819548 100644
>> --- a/include/trace/events/sched_ext.h
>> +++ b/include/trace/events/sched_ext.h
>> @@ -26,6 +26,25 @@ TRACE_EVENT(sched_ext_dump,
>>   	)
>>   );
>>   
>> +TRACE_EVENT(sched_ext_event,
>> +	    TP_PROTO(const char *name, __u64 delta),
> 
> It shouldn't be __s64 here as well?

Ah, my bad. Thank you for catching this!

> 
> Thanks,
> -Andrea
> 
>> +	    TP_ARGS(name, delta),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(	__s64,		delta		)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name);
>> +		__entry->delta		= delta;
>> +	),
>> +
>> +	TP_printk("name %s delta %lld",
>> +		  __get_str(name), __entry->delta
>> +	)
>> +);
>> +
>>   #endif /* _TRACE_SCHED_EXT_H */
>>   
>>   /* This part must be outside protection */
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 686629a860f3..debcd1cf2de9 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -1554,6 +1554,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>>    */
>>   #define scx_add_event(name, cnt) do {						\
>>   	this_cpu_add(event_stats_cpu.name, cnt);				\
>> +	trace_sched_ext_event(#name, cnt);					\
>>   } while(0)
>>   
>>   /**
>> @@ -1565,6 +1566,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>>    */
>>   #define __scx_add_event(name, cnt) do {						\
>>   	__this_cpu_add(event_stats_cpu.name, cnt);				\
>> +	trace_sched_ext_event(#name, cnt);					\
>>   } while(0)
>>   
>>   /**
>> -- 
>> 2.48.1
>>
> 


