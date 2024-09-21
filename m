Return-Path: <linux-kernel+bounces-334792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB597DC32
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF81F21CC9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03161FCF;
	Sat, 21 Sep 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tg9Hkdgv"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7914293
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906776; cv=none; b=BnsSa8Jcbu35KLoWGRSshQGH4V/njmXn/RgZX5ri69GIBmVEW0yO/dAst/+GUhma8g5p0Kkc/Ep9y2hnXPw1lWZqWeaoBzScSl5FZSvN2EtO3gCkQ94Lk+MBGXeQT9/nPZwVV4913MaXr3evZmypbKRM4h1XlQZbdfxc/v/08/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906776; c=relaxed/simple;
	bh=Uh3pUleVwnOCeT4tby6kuWJ42ZkB1YImOcA5MLQA58c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmwiW9c9I5+IrpBN0b2ViuawfqcDgACGCxmrdW3WL8UWkQ2YnUxc5S4tLsEWov4p5PgXsXTGa5NM5IlEvLtvk/cxtWKov2CXjNJUK84CY7g3G/q84Q+bucVz4ZtaZ8xllmE4WFcydBDn9fQN6WFQ5mQG9Phy7dA4HOf4bldexVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tg9Hkdgv; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8af383e9-d90d-492d-81e5-91d8edfe1508@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726906771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cgodr5AMxP6TMSfm1kF9swOspK+DBO+lozScTDn6Nwo=;
	b=Tg9HkdgvwgorOjNwtbeB4xYmrKrs94noPsAhFHF2wLkR0XR9uWdIyc/WlM88eoqvAXJpXP
	qBM9CT9SMHT8rGKWmGiYB7bNMIk8DElqC/297JPTyR8kT7D+EpZBWbsTL55x5FIBDl1NO6
	s/QbNaE4LGpFqCOPwcRgXxg/0h+vWvk=
Date: Sat, 21 Sep 2024 16:19:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/5] sysctl: support encoding values directly in the
 table entry
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 Dave Young <dyoung@redhat.com>
References: <cover.1726365007.git.wen.yang@linux.dev>
 <95ca2bfb46a3aaef026623cd1a08c3c39366d5df.1726365007.git.wen.yang@linux.dev>
 <37ce9602-185d-4e8e-98d3-1097eb1f9ee2@t-8ch.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <37ce9602-185d-4e8e-98d3-1097eb1f9ee2@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/15 14:25, Thomas Weißschuh wrote:
> On 2024-09-15 10:08:28+0000, Wen Yang wrote:
>> Eric points out: "by turning .extra1 and .extra2 into longs instead of
>> keeping them as pointers and needing constants to be pointed at somewhere
>> .. The only people I can see who find a significant benefit by
>> consolidating all of the constants into one place are people who know how
>> to stomp kernel memory."
>>
>> This patch supports encoding values directly in table entries through the
>> following work:
>> - extra1/extra2 and min/max are placed in one union to ensure that the
>>    previous code is not broken, then we have time to gradually remove these
>>    unnecessary extra1/extra2;
> 
> The union shouldn't be necessary for backward compatibility.
> It could just as well be a struct.
> The union however saves some space.
> 
>> - two bits were used to represent the information of the above union:
>>    SYSCTL_FLAG_MIN: 0, using extra1. 1, using min.
>>    SYSCTL_FLAG_MAX: 0, using extra2. 1, using max.
>> - since the proc file's mode field only uses 9 bits(777), we could use the
>>    additional two bits(S_ISUID and S_ISGID) to temporarily represent
>>    SYSCTL_FLAG_MIN and SYSCTL_FLAG_MAX.
>> - added some helper macros.
>>
>> By introducing long min/max to replace void * extra1/extra2 in most cases,
>> unnecessary variables can be removed to save memory and avoid attacks.
>>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Joel Granados <j.granados@samsung.com>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   fs/proc/proc_sysctl.c  |  8 +++--
>>   include/linux/sysctl.h | 71 ++++++++++++++++++++++++++++++++++++------
>>   2 files changed, 67 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index 90c99eb1abf6..e88d1dca2a80 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -848,8 +848,11 @@ static int proc_sys_getattr(struct mnt_idmap *idmap,
>>   		return PTR_ERR(head);
>>   
>>   	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>> -	if (table)
>> +	if (table) {
>>   		stat->mode = (stat->mode & S_IFMT) | table->mode;
>> +		stat->mode &= ~SYSCTL_FLAG_MIN;
>> +		stat->mode &= ~SYSCTL_FLAG_MAX;
>> +	}
>>   
>>   	sysctl_head_finish(head);
>>   	return 0;
>> @@ -1163,7 +1166,8 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
>>   		if (!entry->proc_handler)
>>   			err |= sysctl_err(path, entry, "No proc_handler");
>>   
>> -		if ((entry->mode & (S_IRUGO|S_IWUGO)) != entry->mode)
>> +		if ((entry->mode & (S_IRUGO|S_IWUGO|SYSCTL_FLAG_MIN|SYSCTL_FLAG_MAX))
>> +		    != entry->mode)
>>   			err |= sysctl_err(path, entry, "bogus .mode 0%o",
>>   				entry->mode);
>>   	}
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 20e3914ec53f..8e27e8350ca8 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -28,6 +28,7 @@
>>   #include <linux/rbtree.h>
>>   #include <linux/uidgid.h>
>>   #include <uapi/linux/sysctl.h>
>> +#include <uapi/linux/stat.h>
>>   
>>   /* For the /proc/sys support */
>>   struct completion;
>> @@ -61,6 +62,37 @@ extern const int sysctl_vals[];
>>   
>>   extern const unsigned long sysctl_long_vals[];
>>   
>> +#define SYSCTL_NUM_ZERO                         (0L)
>> +#define SYSCTL_NUM_ONE                          (1L)
>> +#define SYSCTL_NUM_TWO                          (2L)
>> +#define SYSCTL_NUM_THREE                        (3L)
>> +#define SYSCTL_NUM_FOUR                         (4L)
>> +#define SYSCTL_NUM_FIVE                         (5L)
>> +#define SYSCTL_NUM_SIX                          (6L)
>> +#define SYSCTL_NUM_SEVEN                        (7L)
>> +#define SYSCTL_NUM_EIGHT                        (8L)
>> +#define SYSCTL_NUM_NINE                         (9L)
>> +#define SYSCTL_NUM_TEN                          (10L)
>> +#define SYSCTL_NUM_SIXTEEN                      (16L)
>> +#define SYSCTL_NUM_THIRTY_ONE                   (31L)
>> +#define SYSCTL_NUM_NEG_THIRTY_ONE               (-31L)
>> +#define SYSCTL_NUM_ONE_HUNDRED                  (100L)
>> +#define SYSCTL_NUM_TWO_HUNDRED                  (200L)
>> +#define SYSCTL_NUM_S8_MAX                       (127L)
>> +#define SYSCTL_NUM_U8_MAX                       (255L)
>> +#define SYSCTL_NUM_FIVE_HUNDRED                 (500L)
>> +#define SYSCTL_NUM_ONE_THOUSAND                 (1000L)
>> +#define SYSCTL_NUM_THREE_THOUSAND               (3000L)
>> +#define SYSCTL_NUM_16K                          (16 * 1024L)
>> +#define SYSCTL_NUM_16M                          (16 * 1024 * 1024L)
>> +#define SYSCTL_NUM_SEC_PER_HOUR                 (60 * 60L)
>> +#define SYSCTL_NUM_U16_MAX                      (65535L)
>> +#define SYSCTL_NUM_SEC_PER_DAY                  (24 * 60 * 60L)
>> +#define SYSCTL_NUM_MS_PER_DAY                   (24 * 60 * 60 * 1000L)
>> +#define SYSCTL_NUM_INT_MAX                      (INT_MAX)
>> +#define SYSCTL_NUM_NEG_ONE                      (-1)
>> +#define SYSCTL_NUM_LONG_MAX                     (LONG_MAX)
> 
> Are all those constants really needed?
> In the past they were useful as they referenced the array of constants.
> But now people can just use the number directly, or even better a
> subsystem-specific constant.
> 

Okay, we will make the modifications according to your suggestions.

>> +
>>   typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
>>   		size_t *lenp, loff_t *ppos);
>>   
>> @@ -131,6 +163,9 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
>>   #define DEFINE_CTL_TABLE_POLL(name)					\
>>   	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
>>   
>> +#define  SYSCTL_FLAG_MIN			S_ISUID
>> +#define  SYSCTL_FLAG_MAX			S_ISGID
> 
> Is it ever useful to have only one of these flags?
> IMO this could be a single flag.
>

There are a few  edge cases that require two flags, such as the 
following code snippet:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/sctp/sysctl.c#n103

	[SCTP_RTO_MIN_IDX] = {
		.procname	= "rto_min",
		.data		= &init_net.sctp.rto_min,
...
		.extra1         = SYSCTL_ONE,
		.extra2         = &init_net.sctp.rto_max
	},

extra1 points to a constant unsigned integer, but extra2 points to a 
field in the struct sctp.association structure

>> +
>>   /* A sysctl table is an array of struct ctl_table: */
>>   struct ctl_table {
>>   	const char *procname;		/* Text ID for /proc/sys, or zero */
>> @@ -139,8 +174,16 @@ struct ctl_table {
>>   	umode_t mode;
>>   	proc_handler *proc_handler;	/* Callback for text formatting */
>>   	struct ctl_table_poll *poll;
>> -	void *extra1;
>> -	void *extra2;
>> +	union {
>> +		struct {
>> +			void *extra1;
>> +			void *extra2;
>> +		};
>> +		struct {
>> +			long min;
>> +			long max;
>> +		};
>> +	};
>>   } __randomize_layout;
>>   
>>   struct ctl_node {
>> @@ -214,42 +257,50 @@ struct ctl_table_root {
>>   
>>   static inline unsigned int sysctl_range_min_u8(const struct ctl_table *table)
>>   {
>> -	return (table->extra1) ? *(unsigned int *) table->extra1 : 0;
>> +	return (table->mode & SYSCTL_FLAG_MIN) ? table->min :
>> +	       (table->extra1) ? *(unsigned int *) table->extra1 : 0;
> 
> All these repetitive functions could probably be replaced by one macro.
> Keeping the users more direct and avoiding all the repetition.
> 

Okay, we will make the modifications according to your suggestions and 
send v4 soon.

--
Best wishes,
Wen

