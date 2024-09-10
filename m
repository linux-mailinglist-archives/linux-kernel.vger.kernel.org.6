Return-Path: <linux-kernel+bounces-322307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D342C97270F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53141C22535
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030F1442F4;
	Tue, 10 Sep 2024 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="njptXeO8"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DC1420A8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934720; cv=none; b=kVC2SVxoK5LUncp0dxkTFA/s6iKfAvfZJYEVNsRNmWgGD7dtlxs+gNNYnvglfnHmcP5/e8H2x+s2mMPLxrKcpQLBH1MB5wUIq145GvrMlAT8PtOShVZXZtgIeZ86pSejh2PmJEKsXr8GBcK4uFtCPL1QJZLXGFENxqPumWThpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934720; c=relaxed/simple;
	bh=4/IPSbBj42XzxW4HV97Eva2XL0zbu4XfXXs2AwAsnwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Osq6czuuJejkLuXC4C78Af1Wzo6m/P5UhCZwzlPXK/dmcJC0WGPTuhSETil5VBvWDPuZXMiRshn8dnCCea7Em3dc+Dg11/RATiRggHMLjN4sN4lcKHystgRxRP96cqahpbnHAh6OecnF4v8DCWf/TNxb6a5Nr4YpVMJwMceTnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=njptXeO8; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725934708; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7sI9KaaYX52g6DOUH55ov1m3JrSic7QKcsNmJRT+LYY=;
	b=njptXeO8rJKOtq2DC6qI7JW54tlYUChiCjjX7x3rRxLNayQDFu21HVYWLIr2qh6ANOGvCY6e3OiLsHYz3sxLyoxiVTI7AHFqPFxIvoffsqQusldQZk/b0i6gIvlI4HSWpKg8utqYg1XRCIwojdmXOS/KUFncxjkrLav/nGuRW/c=
Received: from 30.244.152.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEiHvd8_1725934706)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 10:18:28 +0800
Message-ID: <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
Date: Tue, 10 Sep 2024 10:18:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
 <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
 <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/10 08:12, Colin Walters wrote:
> 
> 
> On Mon, Sep 9, 2024, at 11:40 AM, Gao Xiang wrote:
>>
>> Just my personal opinion, my understanding of rubustness
>> is stability and security.
>>
>> But whether to check or not check this, it doesn't crash
>> the kernel or deadlock or livelock, so IMHO, it's already
>> rubustness.
> 
> OK, if you're telling me this is already checked elsewhere then I think we can call this end of thread.

I know you ask for an explicit check on symlink i_size, but
I've explained the current kernel behavior:
   - For symlink i_size < PAGE_SIZE (always >= 4096 on Linux),
     it behaves normally for EROFS Linux implementation;

   - For symlink i_size >= PAGE_SIZE, EROFS Linux
     implementation will mark '\0' at PAGE_SIZE - 1 in
     page_get_link() -> nd_terminate_link() so the behavior is also
     deterministic and not harmful to the system stability and security;

In order to verify this, you could also check the EROFS image
(encoded in gzip+base64) with a 16000-byte symlink file below:

H4sICPqj32YCA3Rlc3QuZXJvZnMA7dsvSwNhHMDx350IBotgt0wMwsnegDCYb8FiVbu4LAom
kygbgwURfR1Wm12Lf5JFTIpY9B58GCK2BYV9vvDhee64226sXPlFSBrXHu5f7k4u+isT9X46
GlHm8+9nt5tpHaxOxeS364+Wjh8PXtvP3bn9/nXvpjvq96fPfmpFLObjj7q07lzOxnq9Hubn
eLvaapa/3N8YruVwP59+Rb54IYqoqqqzsd3xZ0uSJGnsSy/GAAAAAAAAAAAAAADA/5bmb89P
I3aXv+YBiuzn/O3azF6zMD8AAADAHzHBP1qf7k2HRABQAAA=

Here the symlink is already recorded in the image (let's not think if
the symlink is reasonable or not for now), but Linux implementation will
just truncate it as a 4095-byte link path, that is the current release
behavior and it has no security issue inside.

In other words, currently i_size >= PAGE_SIZE is an undefined behavior
but Linux just truncates the link path.

So I understand that what you propose here is to check the size
explicitly, which means we need to introduce a formal on-disk hard
limitation, for example:

   - Introduce EROFS_SYMLINK_MAXLEN as 4095;

   - For symlink i_size < EROFS_SYMLINK_MAXLEN, it behaves normally;

   - For symlink i_size >= EROFS_SYMLINK_MAXLEN, it just return
     -EFSCORRUPTED to refuse such inodes;

So that is an added limitation (just like a "don't care" bit into
a "meaningful" bit).

For this case, to be clear I'm totally fine with the limitation,
but I need to decide whether I should make "EROFS_SYMLINK_MAXLEN"
as 4095 or "EROFS_SYMLINK_MAXLEN" as 4096 but also accepts
`link[4095] == '\0'`.

No matter which is finalled selected, it's a new hard on-disk
limitation, which means we cannot change the limitation anymore
(-EFSCORRUPTED) unless some strong reason as a bugfix.

> 
>> Actually, I think EROFS for i_size > PAGE_SIZE, it's an
>> undefined or reserved behavior for now (just like CPU
>> reserved bits or don't care bits), just Linux
>> implementation treats it with PAGE_SIZE-1 trailing '\0',
>> but using erofs dump tool you could still dump large
>> symlinks.
>>
>> Since PATH_MAX is a system-defined constant too, currently
>> Linux PATH_MAX is 4096, but how about other OSes? I've
>> seen some `PATH_MAX 8192` reference but I'm not sure which
>> OS uses this setting.
> 
> Famously GNU Hurd tried to avoid having a PATH_MAX at all:
> https://www.gnu.org/software/hurd/community/gsoc/project_ideas/maxpath.html
> 
> But I am pretty confident in saying that Linux isn't going to try to or really be able to meaningfully change its PATH_MAX in the forseeable future.
> 
> Now we're firmly off into the weeds but since it's kind of an interesting debate: Honestly: who would *want* to ever interact with such long file paths? And I think a much better evolutionary direction is already in flight - operate in terms of directory fds with openat() etc. While it'd be logistically complicated one could imagine a variant of a Unix filesystem which hard required using openat() to access sub-domains where the paths in that sub-domain are limited to the existing PATH_MAX. I guess that kind of already exists in subvolumes/snapshots, and we're effectively enabling this with composefs too.

Yes, but that is just off-topic.  I just need to confirm
that `PATH_MAX >= 4096 is absolutely nonsense for all OSes
on earth`.

If there is a path larger than 4096 in some OS, we maybe
(just maybe) run into an awkward situation:  EROFS can have
some limitation to be used as an _archive format_ on this
OS.

Similar to EXT4->XFS, if XFS is used as an _archive format_
there could be a possiability that a EXT4 symlink cannot be
represented correctly according to its on-disk format.  So
as an _archive format_, XFS is more limited now (Please
don't misunderstand, I'm not saying XFS is not a great
filesystem. I like XFS.)

Thanks,
Gao Xiang

> 
>> But I think it's a filesystem on-disk limitation, but if
>> i_size exceeds that, we return -EOPNOTSUPP or -EFSCORRUPTED?
>> For this symlink case, I tend to return -EFSCORRUPTED but
>> for other similar but complex cases, it could be hard to
>> decide.
> 
> -EFSCORRUPTED is what XFS does at least (in xfs_inactive_symlink()).





