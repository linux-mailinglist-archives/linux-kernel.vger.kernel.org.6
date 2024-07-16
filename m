Return-Path: <linux-kernel+bounces-253742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866A932635
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1A51C22C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF819A284;
	Tue, 16 Jul 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TWXHEMRF"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA01993B8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131674; cv=none; b=jF+M8pSn6u0eL6iA2BQSL39cB02krN2Xp17ZWT9yXAydKhOxRZYY3DXVZ1n6cpQM1Z3TFy2r7H3lg2d0n1XVBug2rMQcOhNo5O0mi19ctAzB6ABa8ve57kkPxNLAQHG4zEkkB843nmax+cMCL5wfFI2Yqfcm+kPmFbIJTh9rbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131674; c=relaxed/simple;
	bh=9tdKXiUW1emhpRoJyC0A/ZAaagaEMpMZC+d2cbyR0JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlLiLMM33PSZ+8aivtnsDp+aNmrKrG0waTCxwiTJLZSHX8k3fxh1m01wSHIIPJsnJo25J5Pkvphm1imSLlgUc1qudFiAVUr6TGG+YP3ty0jcQH01EWWQPeRSzmXg3i8W9otcHFe9EnZHhWMnipuUti0x+KD6qicu7WbkWAUJt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TWXHEMRF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=5FJ3771MefSZUORIT8lVfanWU7zDIpnrF6buocn/jp8=;
	b=TWXHEMRFUbY9/MIaeyRSeK27Ze91YzTfloX4B/ggstxCpI+W0P1rwo1dcWXMKg
	k8fFQELybYWVRQizQLUhMVp/H5L4//N9vDH+e3TPJ7MNuCYnjsffqgV2LS924TvY
	pBoNbYXka2YSK7dALFRfCP70vSC/nVLrPNbr4lGnpwbhE=
Received: from [192.168.1.26] (unknown [183.195.5.95])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Xxt0YpZmOuT3DA--.15946S2;
	Tue, 16 Jul 2024 20:07:16 +0800 (CST)
Message-ID: <3353d6c1-54ce-46c0-8b65-a0383c8da324@163.com>
Date: Tue, 16 Jul 2024 20:07:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: udev kset_create_and_add() with own struct kobj_type?
To: Alexander Aring <aahringo@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 gfs2 <gfs2@lists.linux.dev>, David Teigland <teigland@redhat.com>
References: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Xxt0YpZmOuT3DA--.15946S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWfWF4kCw15CF4rCr1UGFg_yoW8Aw18pF
	W5Cr17Kw1DXr1xuw4kZr48CFyrGws5Gry3JrWrW34jyr45uryxuFy2ya47Za17AanavrWY
	qa1Yv3s3Za4jya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UciSLUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiXxceNWXAlHF2PgAAsr

On 2024/7/15 23:27, Alexander Aring wrote:
> Hi,
> 
> I am currently implementing namespace support into the fs/dlm
> subsystem. The DLM subsystem uses kset_create_and_add("dlm",
> &dlm_uevent_ops, kernel_kobj); to create the "dlm" sysfs directory.
> Underneath it creates for each lockspace a subdirectory using
> kobject_init_and_add() with a non-static name and being known during
> runtime.
> 
> Now I want to add namespace support and need to change the "default"
> kset->kobj.ktype = &kset_ktype; that is set by
> kset_create_and_add()->kset_create() to my own kobj_type because I
> need to implement a different ".child_ns_type" callback before
> kset_register() is called.
> 
you maybe use kset_register() instead of kset_create_and_add().
you maybe find example codes from below kernel files:
fs/nfs/sysfs.c
fs/f2fs/sysfs.c
fs/ubifs/sysfs.c

not sure if this info is helpful for your requirements.

> So kset_create_and_add() does not allow me to add my own
> ".child_ns_type" callback for the kset that is required for me to have
> my sysfs "kernel/dlm" directory separated by each net-namespace
> without breaking any backwards compatibility.
> 
> My current solution is that I mostly copy&pasted the code of
> kset_create_and_add()/kset_create() to have a way to tell my own
> struct kobj_type that contains the implemented my own ".child_ns_type"
> callback.
> 
> I am writing this mail to get some advice on what I can do here
> without doing the copy&pasted code?
> Add a parameter to kset_create_and_add() that allows me to set an
> "struct kobj_type"?
> Introducing a new function that does allow me to set the new parameter
> (I probably like that because then I don't need to update all other
> users)?
> 
> Thanks in advance for any advice.
> 
> - Alex
> 
> 


