Return-Path: <linux-kernel+bounces-422556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D59D9B28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D49C28377C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBAD1D63EF;
	Tue, 26 Nov 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gIdgHF41"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD92FB6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637788; cv=none; b=BapnZqrxowCZeNx9reLAjUXHIpwX0JobNuXOg6Gcp5ATKct0hMKyzuFVvm6a49U9FWMpt2i+F+BwLMxhRhQgkW51DmbhfzUnG9UajLBFDtkc1fIXubcJhtSD218YLzKWTbGjhMdZRcC+jkVTpLISMqu6QBkc/mvHFMmiOdTDLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637788; c=relaxed/simple;
	bh=SZvEzt6nyOq5bSimQ41p73CSvJoxAYoNC1GBX6ld/K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDSEaFoDHrd3jeSFvJ7Uv1t7+5gRNTkHy+kNrn6Mt5WknGqW81TScOG5Md/plVtHmoiYR+13JEuoDZ4n+ViryVnrtN8dH8aOYDwMgZ2FZPU4jb2LZ1GiPJXR78VthVAhFhQL33VXmXuGoRAyDEOsQE1F3IUX/vAQuauzb5tPQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=gIdgHF41; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 650BC61388;
	Tue, 26 Nov 2024 19:16:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JGbrA8tOdW20-nqKT82Ga;
	Tue, 26 Nov 2024 19:16:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732637779; bh=P/Y7odP+QjVmPcorcmrQEldQhT8hxD9z3LXLCV/3hF8=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=gIdgHF41RL+sLPSbyMRrHe2jdzNlVkbK4IMsxE0GuBu9dgxpTzvM5BtAiDrDPLIy2
	 LWxo0KlITR3huGxrM8KwwbXmqOGR8ur0wRquiQC3heHM0pqoViLhipJhTlXOTMrlOS
	 DU+zzS3IOuY8gZhOWZpT7dARaUC8XHkEy6wH2d/w=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <3d4c1c59-4b01-4fa3-af84-e2d84f4ebf44@yandex.ru>
Date: Tue, 26 Nov 2024 19:16:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Linux kernel <linux-kernel@vger.kernel.org>
References: <Z0Se4BuVfqwjeCWV@x1n>
 <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru> <Z0Ssq15MQd3rimBr@x1n>
 <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru> <Z0SwOILi4R4g9JBa@x1n>
 <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru> <Z0S3isgc-QlEF7oW@x1n>
 <4689f014-2885-42b9-91a4-ff8b8133599f@yandex.ru>
 <20a1d49a-1f5d-4d3d-b59d-29b9791b72bd@collabora.com>
 <2dd0bcee-a594-4de9-b499-a8ad37be155c@yandex.ru> <Z0XvwitcZ6ujoV9Y@x1n>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <Z0XvwitcZ6ujoV9Y@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

26.11.2024 18:56, Peter Xu пишет:
> This doesn't sound like the right thing to do.. as the fd (returned from
> syscall(userfaultfd)) should be linked to a specific mm.  If the parent
> invoked that syscall, it's linked to the parent address space, not child.
> You may want to do syscall(userfalut) in child process, then pass it over
> with scm rights.  Otherwise IIUC the trap will be armed on parent virtual
> address space.
Ok, thanks for info.
man page doesn't seem to describe
the multi-process case, so both fork()
and SCM_RIGHTS were just a guesses
on my side, one of which worked.
Probably something to add to the doc.

The last problem I had (last one, I promise! :)
is that if I remove O_NONBLOCK, then
the entire app hangs. It turns out, w/o
O_NONBLOCK, userfaultfd's fd awakes
the select() call with the ready-to-read
descriptor at the very beginning, long
before any fault is detected. Then it
goes to read() and blocks forever. My
code is not prepared for read() blocking
after select().
I then checked and double-checked
and re-checked that with O_NONBLOCK
nothing like that happens at all: select()
is not awaken until the faults are coming.
It could be that select awakes anyway
but read() doesn block, but no, its not
the case. In nonblock mode select()
awakes only when it should. And in
blocking mode - it awakes immediately,
leading to a hang.
Is this a bug?

