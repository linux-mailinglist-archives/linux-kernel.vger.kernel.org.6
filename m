Return-Path: <linux-kernel+bounces-256929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB69372A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730141F21E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95954C8C7;
	Fri, 19 Jul 2024 03:01:09 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52290A20
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721358069; cv=none; b=JvSUD84cz9n8ELVVfCZR0XcOUBGZS4L0J8dzTC4bNSnjD0O8DOP8MrbE2JDhFUvQu1qSpmilnvuvmpwC9LExDUGOIYhjqJmi655u4ks7MRUsBm7y8XzopOx3JAVpaEfd3J+SE0Xe0pilz2ZApyB+0LtpE5DyxZo/98klRL0m8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721358069; c=relaxed/simple;
	bh=0fsrdcQ34Vw1tBJWvrY/8YWifHAV7zOQXTBcSOUDt6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gUR9F2IYuXvTwzP1KJ7YJUOPOALWBFy2Ue1eyvAP1XisABEwDS9KXh8AvYwHn5qIFa/nEx8PR0MGxOvIgl43CjvA3IOElal2Uv2svC6jCS+toBDT5cyqQ7wh8T4FgqnwbYtJ6qR3kb67hGCfXiLxr5YO5R//qLad4ly85SCjgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46J30w5H005052;
	Fri, 19 Jul 2024 12:00:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 19 Jul 2024 12:00:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46J30wYo005045
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jul 2024 12:00:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a0d2b5c8-50f4-4519-8234-a37a97b6d7b7@I-love.SAKURA.ne.jp>
Date: Fri, 19 Jul 2024 12:00:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] possible deadlock in try_to_wake_up (5)
To: syzbot <syzbot+4970d08867f5a5b0bb78@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000091fc6d061d8ff9ee@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000091fc6d061d8ff9ee@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer


