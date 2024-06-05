Return-Path: <linux-kernel+bounces-201730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251348FC26A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13A7B25B84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9661FEA;
	Wed,  5 Jun 2024 03:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkHAnDYY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FA200CD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559288; cv=none; b=Wq8UUV+fLQhBdwq8H1OA2aAH5xZpaXhgd7+kBV6P32ThaH/ebbUr0FdxbRUuDTzaqxwWw/YVq1cMDaYa3mMUz/yC0Ba2m6BXpKsP3S2lNZ5LVGqRQ50ivpN9wZgeYggliIHrYMffWTjXnTpAhvCUc5hH7k7jA5LjkKmB21E7SQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559288; c=relaxed/simple;
	bh=T9eP4KI3K8OSMVEJQuECiUhIO0oRZGwaLX6wcUtW6O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glF0YpnkiaV0S40D8ZGFGIJpYOOokle00aVPzzVdONBFNYbmStVaeir598Myex7NYOU2OlEehhF896qEiSxcs1hJIUSmxmp/CtAXs08GCwOprm2JqcS8mrLtAlwn3gVXgpW9hYNPbdmMmJ+CNSJVRLl1Wjjs//1/xKEFHIu1lwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkHAnDYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6609AC32781;
	Wed,  5 Jun 2024 03:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717559287;
	bh=T9eP4KI3K8OSMVEJQuECiUhIO0oRZGwaLX6wcUtW6O0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QkHAnDYYzNhfdAFgKa8tvoJde9rehpQUo9MYFmj0/5gN2VrnnPhGsKhFA0FZEXZpe
	 Y8TiIjeqcV53PIYUqx2f5OVSdpZQ08OGdLxH9RBJtn0APk2aQOlGZqdexwmfKG/FW0
	 qEazDguZ6GsAVej4GUMK27oLOjQSC48s/kpU7Y9mw93vp4dVGVC3w6b6M+nsw0AQoY
	 nEQWrrhUshCZjMDfm4A7ZfdqruWIKFMy2udMPmLFWvR455I2fXnQ/llKUw4E42Mf0w
	 xIA9dja/+i994wwdqA2XilSwxuj1TIiCXodMp0WvF7ce5JqZIK4Dr8H2TQzMpPR+6T
	 QpYex2czrdb3Q==
Message-ID: <8b841ec1-cb43-462a-9e87-aecdb0755318@kernel.org>
Date: Wed, 5 Jun 2024 11:48:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
 <446c7e4a-2a1e-402d-8238-2eee7cdfd5c2@kernel.org>
 <CAHJ8P3J2NkSfVTEcpxR+n3CjtywMxxEDMg4cLSL=8UOX8KcM+Q@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3J2NkSfVTEcpxR+n3CjtywMxxEDMg4cLSL=8UOX8KcM+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/3 17:05, Zhiguo Niu wrote:
> On Mon, Jun 3, 2024 at 3:41 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/5/20 19:36, Zhiguo Niu wrote:
>>> Now atgc can be enabled based on the following conditions:
>>> -ATGC mount option is set
>>> -elapsed_time is more than atgc_age_threshold already
>>> but these conditions are check when umounted->mounted device again.
>>> If the device has not be umounted->mounted for a long time, atgc can
>>> not work even the above conditions met.
>>>
>>> It is better to enable atgc dynamiclly when user change atgc_age_threshold
>>> meanwhile this vale is less than elapsed_time and ATGC mount option is on.
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>>    fs/f2fs/f2fs.h    |  1 +
>>>    fs/f2fs/segment.c |  9 ++++-----
>>>    fs/f2fs/sysfs.c   | 16 ++++++++++++++++
>>>    3 files changed, 21 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 1974b6a..e441d2d 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>>>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>>>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
>>>    int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>>                                        unsigned int start, unsigned int end);
>>>    int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 71dc8042..44923d4 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
>>>        return ret;
>>>    }
>>>
>>> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>>>    {
>>>        struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
>>>        int ret = 0;
>>>
>>> -     if (!sbi->am.atgc_enabled)
>>> -             return 0;
>>> -
>>>        f2fs_down_read(&SM_I(sbi)->curseg_lock);
>>>
>>>        mutex_lock(&curseg->curseg_mutex);
>>> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>>>    }
>>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
>>>    {
>>> -     return __f2fs_init_atgc_curseg(sbi);
>>> +     if (!sbi->am.atgc_enabled)
>>> +             return 0;
>>> +     return f2fs_init_atgc_curseg(sbi);
>>>    }
>>>
>>>    static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 09d3ecf..72676c5 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>>                return count;
>>>        }
>>>
>>> +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
>>> +             if (t < 0)
>>> +                     return -EINVAL;
>>> +             sbi->am.age_threshold = t;
>>> +             if (sbi->am.atgc_enabled)
>>> +                     return count;
>>> +
>>> +             if (test_opt(sbi, ATGC) &&
>>> +                     le64_to_cpu(sbi->ckpt->elapsed_time) >= t) {
>>
> Hi Chao,
>> Oh, I guess you want to fix this:
> Yes,  Sorry for not making it clear before.
>>
>> static void init_atgc_management(struct f2fs_sb_info *sbi)
>> {
>> ...
>>          if (test_opt(sbi, ATGC) &&
>>                  SIT_I(sbi)->elapsed_time >= DEF_GC_THREAD_AGE_THRESHOLD)
>>                  am->atgc_enabled = true;
>>
>> What about enabling atgc_enabled during checkpoint once elapsed time is
>> satisfed w/ the condition? I guess this can give another chance whenever
>> CP is been triggered, and it can avoid the racing condition as well.
> 1. I'm not sure if this will increase checkpoint time consumption?

Since it won't increase any IO time, I guess it's fine tolerate time consumed
by initialization of atgc curseg.

> 2. dynamically enabling atgc may have other problems. Is this confirmed?

I think so, checkpoint has avoided most race cases.

So, how do you think of below diff:

---
  fs/f2fs/checkpoint.c |  2 ++
  fs/f2fs/f2fs.h       |  1 +
  fs/f2fs/segment.c    | 26 +++++++++++++++++++++++---
  3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 55d444bec5c0..4a73bd481a25 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1718,6 +1718,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
  	}

  	f2fs_restore_inmem_curseg(sbi);
+	f2fs_reinit_atgc_curseg(sbi);
+
  	stat_inc_cp_count(sbi);
  stop:
  	unblock_operations(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9688df332147..8d385a1c75ad 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3693,6 +3693,7 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
  bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
  int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
+int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi);
  void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
  void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
  int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bdc2247387e8..6d4273faf061 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2949,12 +2949,12 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
  	return ret;
  }

-static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
+static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi, bool force)
  {
  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
  	int ret = 0;

-	if (!sbi->am.atgc_enabled)
+	if (!sbi->am.atgc_enabled && !force)
  		return 0;

  	f2fs_down_read(&SM_I(sbi)->curseg_lock);
@@ -2971,9 +2971,29 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
  	f2fs_up_read(&SM_I(sbi)->curseg_lock);
  	return ret;
  }
+
  int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
  {
-	return __f2fs_init_atgc_curseg(sbi);
+	return __f2fs_init_atgc_curseg(sbi, false);
+}
+
+int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi)
+{
+	int ret;
+
+	if (!test_opt(sbi, ATGC))
+		return 0;
+	if (sbi->am.atgc_enabled)
+		return 0;
+	if (SIT_I(sbi)->elapsed_time < sbi->am.age_threshold)
+		return 0;
+
+	ret = __f2fs_init_atgc_curseg(sbi, true);
+	if (!ret) {
+		sbi->am.atgc_enabled = true;
+		f2fs_info(sbi, "reenabled age threshold GC");
+	}
+	return ret;
  }

  static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
-- 
2.40.1

> thanks！
>>
>> Thanks,
>>
>>> +                     if (f2fs_init_atgc_curseg(sbi))
>>> +                             return -EINVAL;
>>> +                     sbi->am.atgc_enabled = true;
>>> +             }
>>> +             return count;
>>> +     }
>>> +
>>>        if (!strcmp(a->attr.name, "gc_segment_mode")) {
>>>                if (t < MAX_GC_MODE)
>>>                        sbi->gc_segment_mode = t;

