Return-Path: <linux-kernel+bounces-310500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7B967DCB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE6A1C20A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1F2A1B8;
	Mon,  2 Sep 2024 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f6+LbhEO"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17D18C0C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243967; cv=none; b=ABzy+3A7peKjNlT+6M/AtFPlsOgyJDYXu1zvh/AXOVsPXy2Joqju+r62kBJEWdFn4Go6z6DwSy35Qac7XqQX93WQ7ZqvoXKr6IwknleuWIDW24HcgKwtLgP/cMjjhAohf9NP5fu9gYFHieOPZtDZxniA7FQfMZfBJMyrHBp3ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243967; c=relaxed/simple;
	bh=44VO/gO90/rcJmDutFagKFNRsueeIYthkugvlRj+Vww=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDf0oLslokcnRh6PobQjAcdKsqT5IBKTvknIw+2gOjlLYaGJYMSRftmMmvUAU7RYg5k/BpJOrvdhw7su61bOk3d94+EymkAOSP8UOJoTZgeFCZ4tOuR1+rrMxiKHOpFHog6JjSuoiOwVXATtyf5oNbj3a3tYaDhihTVz2yNZgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f6+LbhEO; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725243957; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ABiXjq8frTJLa6cOJxztaG8PEGA0s7qXwsKdZ5eveMg=;
	b=f6+LbhEOxJh7JDKdSVIBA5ByrQIDgrkcEQrMXw5y+3dYJhFNnDBX/gKBA11HF62ucKj/e4Uhekl/FeZlt4Jj3D/qtU2bNerR+GFaCSr5/bNiZQi6nfeYMn9Owh3eIfWp0lkkDn5TCZ9jZWotiEkPpTZrL9+Y3EZD9nWp9JFuT/4=
Received: from 30.221.129.135(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WE1-7SY_1725243638)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 10:20:39 +0800
Message-ID: <18e9dbe0-afe5-48d1-9788-6b13617aff50@linux.alibaba.com>
Date: Mon, 2 Sep 2024 10:20:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in
 ocfs2_set_buffer_uptodate
To: Heming Zhao <heming.zhao@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lizhi Xu
 <lizhi.xu@windriver.com>, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
 mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <1a063827-5cf3-42df-a690-f3c644c10996@linux.alibaba.com>
 <20240821091459.681136-1-lizhi.xu@windriver.com>
 <25f2be6c-3e9c-4484-a44e-d26e9c4c8a74@suse.com>
 <20240821143911.cec82fac50c08947523da2e6@linux-foundation.org>
 <20240901175402.816203db096c2e9e49d75363@linux-foundation.org>
 <b716d079-1725-4a89-8998-e0c88b8ea7c5@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <b716d079-1725-4a89-8998-e0c88b8ea7c5@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/2/24 9:03 AM, Heming Zhao wrote:
> On 9/2/24 08:54, Andrew Morton wrote:
>> On Wed, 21 Aug 2024 14:39:11 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>>> OK I think I found the correct patches - v3 of [1/2] and v4 of [2/2].
>>>
>>> For clarity can we please have a full resend of both patches?
>>>
>>> And let's please have a [0/n] cover letter which describes the problems
>>> which are being addressed and which also briefly describes how they
>>> were addressed.
>>>
>>> Also, it appears that both of these fixes should be backported into
>>> -stable kernels.  So let's please try to identify when these bugs were
>>> introduced and to add a suitable Fixes: to the individual changelogs.
>>>
>>
>> Again, can we please have a full resend of these two patches with the
>> above issues addressed?  Particularly the identification of the Fixes:
>> targets.
>>
>> Thanks.
> 
> Hello Andrew & Joseph,
> 
> If Lizhi still doesn't respond by this Friday, I will send his latest patch set again.
> 
I'll do that, thanks.

Joseph


