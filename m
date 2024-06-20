Return-Path: <linux-kernel+bounces-222786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A5F910780
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DF1F21199
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916921ACE83;
	Thu, 20 Jun 2024 14:07:06 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1D1E48B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892426; cv=none; b=DeH4zG7VWQESfIzWhGaRTMB/ikb+bmQuqcUT18xIC7ppT3KiPRYrlIj2TLtsvbsuXl44R3mA6gv/S4sx0Ww3AXUirmOViKhiEmKj52L6G8vsgSzlvpL0D8dhyWEu0NUyyKkFUEsCVWlF9NYNCYBApqaZB7esdXhiolUq/SuSc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892426; c=relaxed/simple;
	bh=JS+FDRKJbZHvaSKrJc6d25NPBfmbKnAUt9Z/dztHKK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IddCreU7+kWppgMGzUG1BgsufQGF1iTXmRy6gVc3IRt6+hUX8jp+ZyHJtvDf1SOc4A3yCLhJFhvAzR+DwtPBKIFIEv+AtFofbeuJirZ7uEGTw+vv/ZNmMJhOHr2G4pTRJlAx9dwdvxEWKKkTfRZGqB+r8R8oTn4IWtdpQ1fJZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45KE6weB057993;
	Thu, 20 Jun 2024 23:06:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Thu, 20 Jun 2024 23:06:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45KE6vZd057990
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 20 Jun 2024 23:06:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fa7a0701-2035-4686-974b-273cbedcda71@I-love.SAKURA.ne.jp>
Date: Thu, 20 Jun 2024 23:06:57 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] INFO: task hung in addrconf_verify_work (8)
To: syzbot <syzbot+e6b87f5edf5469e359e9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000006bb5b5060cc9c999@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000006bb5b5060cc9c999@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()


