Return-Path: <linux-kernel+bounces-324128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8E974835
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C4B1F2791B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57E2A8D0;
	Wed, 11 Sep 2024 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f9u9/hv+"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FD24A08
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726021668; cv=none; b=ClG4IBQPNsu5nzOB7GCwCIDgIzwcwB2tB7cfkXiQP1NmE8UWCrefVn33N9nL9rS4gaRFEOSMB/X+r3QiPkg97yBiXeorkpLiASx1rv/fxGYL6Yep96Y7qP1bFcXBXEtYMqYSiGX5gES8bcQ303uj66cc6mTqFQpAncOK7RYkNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726021668; c=relaxed/simple;
	bh=Uk2KNmW4xe6kx+QrKy+dzso8eaUQDasnmmDT6TlwcgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA30HYG7GAnUVZpVOiDmNsZg0XHXdFbgT+R0ymY3uXRHaHiYXgqaqsI47A9T2fWfFagq4R6iqYhfaGujupe+o40UQrM/+fffUyEo8jMQruDBO2/2Pk4Ff9q3+490/AuKCgsHoz2d9j2S/Y9yMlttH9/lCBkekPe6YdQbyjE1Cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f9u9/hv+; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726021663; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UWMjma3Rts0LkXJu8WbmRMT3XVCO6b3DjN7/mIcP4eo=;
	b=f9u9/hv+G7a0U+t5ckFvuwqaUl+YyIkCp7LJYZ+wSL1bHCMaL1kbv2gGO1ISU7KmqrD9NBhz/4zCqReMdI3qqYsbIf3d90/1syKKcCw5ePjbe+bk+RYZHIg9SGGPAVxM9AJDoHuaLYfPvQFaRHf8lwqBzF/BlObVnJNWV8nWqbI=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEm00X8_1726021661)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 10:27:42 +0800
Message-ID: <0e3b056a-a5f8-4203-8524-16b5fecb2ca1@linux.alibaba.com>
Date: Wed, 11 Sep 2024 10:27:40 +0800
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
 <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
 <ba83ef6e-d4cc-4ade-9dd0-e3fdfa8fde70@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ba83ef6e-d4cc-4ade-9dd0-e3fdfa8fde70@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/11 04:51, Colin Walters wrote:
> 
> 
> On Mon, Sep 9, 2024, at 10:18 PM, Gao Xiang wrote:
> 
>> I know you ask for an explicit check on symlink i_size, but
>> I've explained the current kernel behavior:
>>     - For symlink i_size < PAGE_SIZE (always >= 4096 on Linux),
>>       it behaves normally for EROFS Linux implementation;
>>
>>     - For symlink i_size >= PAGE_SIZE, EROFS Linux
>>       implementation will mark '\0' at PAGE_SIZE - 1 in
>>       page_get_link() -> nd_terminate_link() so the behavior is also
>>       deterministic and not harmful to the system stability and security;
> 
> Got it, OK.
> 
>> In other words, currently i_size >= PAGE_SIZE is an undefined behavior
>> but Linux just truncates the link path.
> 
> I think where we had a miscommunication is that when I see "undefined behavior" I thought you were using the formal term: https://en.wikipedia.org/wiki/Undefined_behavior
> 
> The term for what you're talking about in my experience is usually "unspecified behavior" or "implementation defined behavior" which (assuming a reasonable implementor) would include silent truncation or an explicit error, but *not* walking off the end of a buffer and writing to arbitrary other kernel memory etc.

Yeah, agreed. "implementation defined behavior" sounds a better term.

Sorry about my limited English corpus, because the environment I'm
living mostly is used to professional terms translated in Chinese..

> 
> (Hmm really given the widespread use of nd_terminate_link I guess this is kind of more of a "Linux convention" than just an EROFS one, with XFS as a notable exception?)

I'm not sure if other kernel fses have their own internal issues
(so they need to check i_size > PAGE_SIZE to cover up their own
format design in advance), but I think (and tested with crafted
images) EROFS with pure only Linux VFS nd_terminate_link()
implementation (since 2.6.x era)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebd09abbd9699f328165aee50a070403fbf55a37

is already safe on i_size > PAGE_SIZE since EROFS symlink on-disk
format is just like its regular inode format.

As for XFS, I think it's a history on-disk behavior (1024-byte
hard limitation) so they have to follow until now, see the related
commit message:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6eb0b8df9f74f33d1a69100117630a7a87a9cc96

> 
>> For this case, to be clear I'm totally fine with the limitation,
>> but I need to decide whether I should make "EROFS_SYMLINK_MAXLEN"
>> as 4095 or "EROFS_SYMLINK_MAXLEN" as 4096 but also accepts
>> `link[4095] == '\0'`.
> 
> Mmmm...I think PATH_MAX is conventionally taken to include the NUL; yeah see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/namei.c?id=b40c8e7a033ff2cafd33adbe50e2a516f88fa223#n123

Agreed, but honestly I have some concern if some OS or tar format
or other popular archive formats support large symlinks but EROFS
have no way to keep them due to on-disk limitation.

If you don't have some strong opinion on this, I do hope let's
hold off our decision about this to ensure compatibility.

Thanks,
Gao Xiang

