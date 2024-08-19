Return-Path: <linux-kernel+bounces-291449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F19562BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1017B2165D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCA13D62F;
	Mon, 19 Aug 2024 04:53:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F61870
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724043188; cv=none; b=JtdsMIFkoevCATIe4WzeSFhUuo7IdY2u9Bp9lFPKPsbolzvCl8MdrGJAgrOi10wm3LX76GhtvVZYKIJmH/OwfzxT76SHNiViJCMBUg5/ZrA/FSl2l4f/Oy+Q8SP7e8Uh6esdaw7cQlXatmVlhbBSd+hcg5fpqZEq6GkhtY2qoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724043188; c=relaxed/simple;
	bh=0fsrdcQ34Vw1tBJWvrY/8YWifHAV7zOQXTBcSOUDt6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VcDSCFyQ+fw3yKnlq6HQw1pV+hOLzRbUOK1IMpRK/p9gg5fAMlqNw14Q+YsPX67wEJq5G2NuZr8YOT89uHB7n+pfzYAEgrtuulkxo8Ef7sbT+IIGW2Rj+J6L92WU1S3wWkeDEorXsQezKbwJNG7PIhRN2tNv6piqVs660Mv+njc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 47J4qpKN085172;
	Mon, 19 Aug 2024 13:52:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Mon, 19 Aug 2024 13:52:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 47J4qpTN085169
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Aug 2024 13:52:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <07087c56-2358-4a9b-b325-f27c03c5887c@I-love.SAKURA.ne.jp>
Date: Mon, 19 Aug 2024 13:52:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
To: syzbot <syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f1e97e062001e6b2@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000f1e97e062001e6b2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer


