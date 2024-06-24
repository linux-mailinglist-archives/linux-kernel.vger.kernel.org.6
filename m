Return-Path: <linux-kernel+bounces-228065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B5915A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C61F2263F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCFF4AECE;
	Mon, 24 Jun 2024 23:27:54 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A91A0731
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271673; cv=none; b=lDV7g3ocYQTBsb2keaUfffVwE7v79phvY0egalIkUztwVOSXynzrs31hkms74b0/lJkokld1zxr6Zy0BjcDlGlE5CYAdHoTmiTPo80MXysUe9iHCRmNjDgYj2ednKGWaLyRffnvI0LByogeY3OBRRZ9O7eGkVDTAm3jH7y+ewWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271673; c=relaxed/simple;
	bh=UZqazkZPJpeazAOUHOZi8Hn82zP36UMCkFzsfu2KkqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=GtjisOgVX41R13rMe9WbRFhNvT2tGjuPA3AOvjrtfD15gpI+YZTwmK5OKo6ImXssuNPqLUF1PKqKcmnOYfOjaWEY2V2MNd7vfBoFAEDH/zV1E5I+7iNKKx1gYTSsoZxycPqyC+KRpj6HHRsh+DZHfeaorpw5+3DzQsafdqXk+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45ONRgXc036021;
	Tue, 25 Jun 2024 08:27:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Tue, 25 Jun 2024 08:27:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45ONRg4v036018
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Jun 2024 08:27:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5aa5558f-90a4-4864-b1b1-5d6784c5607d@I-love.SAKURA.ne.jp>
Date: Tue, 25 Jun 2024 08:27:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernfs?] possible deadlock in __kernfs_remove
To: syzbot <syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        Namjae Jeon
 <namjae.jeon@samsung.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <0000000000007de4c3061ba8ca57@google.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000007de4c3061ba8ca57@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This dependency is added by recent bug fix commit c0a40097f0bc ("drivers:
core: synchronize really_probe() and dev_uevent()").

Commit 4a0079bc7aae ("nvdimm: Replace lockdep_mutex with local lock
classes") changed to assign nvdimm_namespace_key on dev->mutex instead of
__lockdep_no_validate__, which made lockdep to report this dependency.

On 2024/06/25 5:40, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    626737a5791b Merge tag 'pinctrl-v6.10-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=143a383e980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b9ee98d841760c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4762dd74e32532cda5ff
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40


