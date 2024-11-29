Return-Path: <linux-kernel+bounces-425992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858E19DED77
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504A5163CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1919067A;
	Fri, 29 Nov 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XgNcYBrS"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CC15667B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921719; cv=none; b=psIktrDXj7TOabRjfVkpsFDSlofVW3xI2I6PsK4KWo/jawMBsv2gBs2Mi6DKI+6fbCrtK/EqfztdfE2NscouHn1JkMd9wh+sZCw/cbQ3JcNhzQ5N/plfZwI6+AhKdT+I8miXKVAEz9Qkocqf5RSbtEUQXg3G9hRqbLhi/dvcR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921719; c=relaxed/simple;
	bh=hBcS/rWxL8Z16VubTFxz2tOkzDDUlWwC/vRzmnyPkLY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=L99yfOMChWH6g0zAaxuUlyF3gHZqsr4Iz9dXBwxSRy7B820dlFHULgVSUmOKvJ16BQahvq0AIFmvib2O72OtxppZLOsEZFClyeLJONoYBdU7ZGgc4YJsHQIIM/C3swuBvOTP2ALqly8KkyMJRl2pgE1YQnitLbFa8cIvbPYr4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XgNcYBrS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6600c9338so162342985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732921716; x=1733526516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN5bGNA7/bg9Ufs2Fd2xQf/aHKLWC0v8KWxMtmpgDIA=;
        b=XgNcYBrSO6FET0P1jtaHxpjRM3fqXdrdCQG+XY0UAJuk0aEOUcwpskn+lv6TRAraTq
         +wTSQi1LIw1l11T/24aeW/wp75vUlt8pO0+/BCbkFITK2GQB9lKawErWiijgELTb9B4r
         eHdZdF0BH81z18KuHPPHMtypa5QpzYKsG20cSqtDVaMHUVdWEnY8qiVGvrSoQuCXqGxM
         Jg36Zbz7JI0ytN54lBMcssG0qn7/bm8kH64vNHsfxIA3ESDyXV73Jp97BNSLOdSHjX09
         Y6KL9R839Iujq3LmTeVWyLYmlrhnqAJyL++BlC1pP0hnkyTxiMn9K0oZSNAdm10IVfMX
         YReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732921716; x=1733526516;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HN5bGNA7/bg9Ufs2Fd2xQf/aHKLWC0v8KWxMtmpgDIA=;
        b=fS6+NqFLCspO+bDAJTTpEW25vt9OFSaRTffpRff03mGL4h9G1qjxcPeafLaiF6qgDh
         f7UMmRkv7yGOJYTM3/YtIfGz8YyqSStdGVrXFltRMtVRwj2sB1CLZotWueDllRAHhI79
         6SBg2Xf/39B9TwQ/XH3Wf15vOsw4llv9E4UT1VgmNoJzsWvhVLMGSlWWbMlhvfla+nsh
         XujFBxiEBwF6vsnCk8Kdxup+zO3WXoZCXBfAmAhmzB1IysMdovUQV+F3CL0eijyRthG9
         yEkouYLbX8YsW5S59f5kkRxwIR85ayQ0tNVzxG5LziQtFZp1Vf5sOY9VSKai/DceYZR4
         Ns7w==
X-Forwarded-Encrypted: i=1; AJvYcCU1qwPxOkGi3xTZhtgODmRuEMfE2gJzVSkX4SYiakNjCojgM/V2l5V27NtiMjbkDY43dHBMN8JBJGrBWFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2+LKXDbZLU/CIVA+/N0gRjzgN9Jdz3cIaCH5czngxtq8Ka6x
	OaZ4RTL+QOFow/Rhe37hYYn7ohMz5BeiOAeZaZ7eHkk9Xc8Q8Z7C+LEFotNmJQ==
X-Gm-Gg: ASbGncuxb5VEzevKXBxP5F4oiARjmSuKTb/IxK7gZklhDNhozEm/UGriqlEMr3Zb3f9
	jHqI7u23w+gMRPyII+Lzh3ZdJ4IpJwYBzhxei10h5ZmTI3l2ZVc411yCt9pY6BSroRbh/9WcM5Q
	bqC5MPrWBWnQ6vUnuor24y8FEMDF/4uqMHfr/wpQmUf2JzdfFGUFTAUY4FS5Z7XbGyxWjCpquIC
	K+evg12M+cWEdJql742knnMo0pI9woOcdhv8zsAumGeGLb0SB7G
X-Google-Smtp-Source: AGHT+IExMxKJhFilcnoFuMS0wRFtUpZtDBMoV3qzKN2iJbHR+5C+uZxGBBCeLuK2DKd2L4g4oNydPQ==
X-Received: by 2002:a05:620a:1a9e:b0:7b6:753b:9b78 with SMTP id af79cd13be357-7b67c2c1736mr1644925785a.29.1732921716368;
        Fri, 29 Nov 2024 15:08:36 -0800 (PST)
Received: from [10.167.35.107] ([166.199.165.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849210a6sm181893885a.22.2024.11.29.15.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 15:08:35 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Yafang Shao <laoar.shao@gmail.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 29 Nov 2024 18:08:33 -0500
Message-ID: <1937a2ee168.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20241129082646.1341af16@rorschach.local.home>
References: <20241127131941.3444fbd9@gandalf.local.home>
 <CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
 <20241128155120.6e6cd300@rorschach.local.home>
 <20241128182435.57a1ea6f@gandalf.local.home>
 <CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpWX3ZkVtvQ@mail.gmail.com>
 <193780f6880.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <20241129082646.1341af16@rorschach.local.home>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: [GIT PULL] tracing: More updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On November 29, 2024 8:26:51 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 29 Nov 2024 08:14:56 -0500
> Paul Moore <paul@paul-moore.com> wrote:
>
>>> The issue appears to be a known GCC bug, though the root cause remains
>>> unclear at this time.
>>>
>>> A potential workaround has been proposed, which you can find here:
>>> https://lore.kernel.org/linux-hardening/202410171059.C2C395030@keescook/
>>>
>>> However, it seems that the patch has not yet been accepted into the mainline.
>>
>> I didn't pull that into the audit tree because it isn't a real patch.
>> Looking at it again on my phone before today's holiday stuff kicks off, I
>> don't have a problem with the workaround, but i do need to see it as a
>> proper patch with a commit description, sign off, etc. before I can merge it.
>
> Yeah, from the comment I was expecting to see a proper patch.

So was I :). To be perfectly honest I was really expecting this to get 
sorted with some compiler flag, workaround, etc. If we have to fix it by 
hacking around it in the audit code that's okay (the hack looks pretty 
minor) but it's not still a kludge.

>
>> For anyone who is going to put together a patch, please make it clear that
>> it is a compiler bug and provide the associated bug report links.
>
> If it matters, with that patch applied, all my tests were able to
> complete with success.
>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks.

--
paul-moore.com




