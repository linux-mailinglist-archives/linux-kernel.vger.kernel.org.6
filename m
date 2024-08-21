Return-Path: <linux-kernel+bounces-295087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE2C959679
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F4B238FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000F1B5EC0;
	Wed, 21 Aug 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gNcbPSH5"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE31B5EB7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227129; cv=none; b=UnT/0Rh0jTsH0TMtp4p1oaINq/z5ww4mMRSju+0xM41Tp9gSDl/NhiJhBMPekIW8dJySEQg2WfNp9lRtV/yNYDwiIVk0pEaGMLkLzBuKN6XURf9ZKPqDQGyG+t4B82DlGtYGBLB70Sdpkp55Qhxo01GhYQCH5hbBXNqZYGGrEVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227129; c=relaxed/simple;
	bh=8osB/wcFehwq1pA0msz9b7FFVSe5bxbfn1XCWsoKrs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWaARW/04B34WvViIPmPVy7p/rRd7wvgecR0HFsaK+9VDVYcYmgO+uigX5Sjczp8pC9p8pIF/RaagI91dwnZT+PUFJ8K1T94lfcU+HBF0KiS5vzVF99r/8bYohgx+3y0Iu01AFm81LHKiLMe+DnQ8HZkp62Oa+DYFOeqpQ+XLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gNcbPSH5; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724227118; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LEqqDi/krVo1lceJDkIrISzHv6al/xT2SjSgavb2vck=;
	b=gNcbPSH5Z9Jxsj/R7tB/z5LtzewOb/3uwA3GBahVdz5s+IiAOYGOuOq3S4Gf0u1l1Gxr3zaHQu9rEWXVBLbXkwfQYI4cmC0ecty1XDP2ieYVIUZ7IKYVcK/vi8tTo7NldfnWD9CjylIBZ9s3qFE0oQKycRKu+nA0sa5QarYmavI=
Received: from 30.221.129.221(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDLAvpM_1724227116)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 15:58:37 +0800
Message-ID: <1a063827-5cf3-42df-a690-f3c644c10996@linux.alibaba.com>
Date: Wed, 21 Aug 2024 15:58:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in
 ocfs2_set_buffer_uptodate
To: "heming.zhao@suse.com" <heming.zhao@suse.com>,
 Lizhi Xu <lizhi.xu@windriver.com>
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <0dd1d1b4-5e83-449e-af48-3811abd2e6a4@suse.com>
 <20240821065517.3844044-1-lizhi.xu@windriver.com>
 <9e4daf9b-a8f6-4d95-8e4b-125ef7b03911@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <9e4daf9b-a8f6-4d95-8e4b-125ef7b03911@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 3:37 PM, heming.zhao@suse.com wrote:
> Hi,
> 
> On 8/21/24 14:55, Lizhi Xu wrote:
>> On Wed, 21 Aug 2024 14:23:08 +0800, Heming Zhao wrote:
>>> Where is my "Reviewed-by" tag, and where is [patch 1/2]?
>> Sorry about your "Reviewed-by" tag, I remove it, if you don't mind, you can
>> add it by yourself.
> 
> Good answer!
> 
> This patch issue was found by me, and I also pointed out how to fix it, then take the time
> to review your code. But in the end, you removed my "Reviewed-by" tag.
> 

Seems a misunderstanding, take it easy:) 
Lizhi may think since this is a new version, it needs a new round review.

>>
>> In my previous email, I explicitly stated that only this patch should
>> be sent separately, as the first patch has already been reviewed by two
>> reviewers. If the second patch is updated with the first patch, I
>> personally think it is unnecessary.
>>
>> [patch 1/2]: https://lore.kernel.org/all/20240820094512.2228159-1-lizhi.xu@windriver.com/
>>
>> Lizhi
> 
> It looks like you don't have basis knowledge of how to send patches.
> 
> I will never reply to or review any of your mails/patches.

