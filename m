Return-Path: <linux-kernel+bounces-229846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A677991751F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB26B22691
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3743FEC;
	Wed, 26 Jun 2024 00:02:26 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336AECF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360145; cv=none; b=F3i6622FODexaWhbwfkErGnvymzOVtvtfiJJqz4YLiS5Skqc831IAW+sY2+K5CHubvSG6CBvGxKaUV26fD+YWT76eysJgJi4AQFSUiM8U8C3DufYg143gJBBSwh1Vs/m4KRpxRKtcafYdHlio9W2bJRW3WHKwx72F/gWQUJQlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360145; c=relaxed/simple;
	bh=P8WMc6SdHWwKGH1qKS6540mzTyzC+vq9EKpHP8+gSxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STuZNSk+tmlx4L3ZeMfYVuRQ12QjgHr5TwRIqFLwlgTiOD7SdzNeGpjfhe0haGmgoD83R5qoKMbaZDOi0dafOsshMnOnyQnZxP5bIaaDqN9l2fjXxEF+jD52OYehknvcoI46fVLVdneRT1e4F85WuA8V3ia0s5kpyAPnJNduxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45Q02MjC051456;
	Wed, 26 Jun 2024 09:02:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Wed, 26 Jun 2024 09:02:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45Q02Mcp051453
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Jun 2024 09:02:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
Date: Wed, 26 Jun 2024 09:02:22 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de>
 <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
 <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
 <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
 <CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/26 8:56, Alexei Starovoitov wrote:
> You are missing the point. The bug has nothing to do with bpf.

The bug is caused by calling tracing hooks with rq lock held.
If tracing hooks do not exist, this bug does not exist.

> It can happen without any bpf loaded. Exactly the same way.
> should_fail_usercopy() is called on all user accesses.

Not all callers of e.g. should_fail_usercopy() are holding rq lock.


