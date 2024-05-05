Return-Path: <linux-kernel+bounces-168955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E578F8BC027
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0562817A5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556214267;
	Sun,  5 May 2024 10:55:36 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E3DDBB
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714906536; cv=none; b=mWuiXvceZ/IUIxFiPRFpvQBeysPfPuThNHsnAua+M2fEPoEl92WDx7y7ERZjMFLRDs/sSyC8RRaq6gn6Q4ZIY3a+IUJnTjTh/exe3l5xqxyVSwEi3Jo6JRfCWfwTrHgInA04JvEnQFMj5ND/hD8hfK7q2KDsjdoEjjbxwe0qgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714906536; c=relaxed/simple;
	bh=sJ+juBy0G9A+u+mexxH8zMT6BNEytzWhP5Ac7Teg6rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwL7k1jH/QkHgn1nUiqcVglp0GeshfFBSkWvgRkFHFevKXcS7ba+NSWvJ1SQxcC1Id+RrWH4SRCS9h8bXvISR4nhUCmXPDLEak1uJ2zmbdRkYxXIbTmcnI/oEPHqnGGvNiivXsBdgQ5wzItxliVKTebOHI1SH0jWNMhYHhAn6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 445AtWdA027807;
	Sun, 5 May 2024 19:55:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sun, 05 May 2024 19:55:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 445AtWdc027804
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 5 May 2024 19:55:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dd5d511e-9b02-4481-b22b-28da7b188b29@I-love.SAKURA.ne.jp>
Date: Sun, 5 May 2024 19:55:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
To: Ben Greear <greearb@candelatech.com>, Lee Jones <lee@kernel.org>,
        "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <20240411070718.GD6194@google.com>
 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
 <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
 <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
 <8ab88be5de30bcbd0d1cac3cfde6b2085dcfc8fb.camel@sipsolutions.net>
 <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>
 <20240502071908.GB5338@google.com>
 <8054cc9c-fbfe-a08d-5968-57b90a25af65@candelatech.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <8054cc9c-fbfe-a08d-5968-57b90a25af65@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/05/05 14:48, Ben Greear wrote:
> If someone has a different suggested fix than the hack I posted, I will be happy to
> test.  On my system with lots of radios, it is 100% reproducible.
> Maybe email me directly as I don't keep close watch on LKML.

Please collect stacktraces of all lock holders using
https://lkml.kernel.org/r/77e32fdc-3f63-e124-588e-7d60dd66fc9a@I-love.SAKURA.ne.jp .

Depending on the output, I might ask you to decode addresses using ./scripts/faddr2line .


