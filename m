Return-Path: <linux-kernel+bounces-530327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C5A43213
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F61517169A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706462B9B9;
	Tue, 25 Feb 2025 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMTOhzhO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F42571B5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444492; cv=none; b=Y0+1wgyfwzSYTsE9dBhicf0tUaSFaUEfBtIWo2zohXPzUprRY1RnLdtkh98tNWDfd5a0uWkuuUdBwAaU11KiSKPvqiZCB1H13mJxtbVprJ4afc4idxUVEoYi5mBsl+nSmupGx78HQPNBEh5N1AAaSPMgxhe6mbflGUXSd1jhMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444492; c=relaxed/simple;
	bh=4CswVMEEEmL46G+FL9zQI3xsW8eZmm+QTHsfodg5yWA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TqWeCoc7K+kyRdOPMNG55ErRlPaDXuYPhS0WxDpCzEiYLjTuKFXVMUNFY0M3wLU2mNuGYHv7AEd7lkJnm3hHYcxuvO0tWSAD+mpFiuMHRdfT/rWhDhxlOMVig8HlLnIY1we/xuRUAOs2ohJC+aLnuv82dUbT8PDPfihnOZk4Ll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMTOhzhO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740444489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/JmrwGEw3CrM+p3ANhfE1oWprymTvgwdlTM4Q6oxJE=;
	b=YMTOhzhOTKp8FcT58wb5VyqivHkIle1z9b6nTIdFiGqQz7w9Y05TWsH16btVxa6JI2X/9Y
	ageKXwC+kCH2uG7x6tcCy16DWYNnoWodiy5AArroQb2Xz1wyJdE3k845esVl7mQDvODa+4
	Bw6jqf8yAAnD3kcQhkVAyn4a8xgkG9Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-ETlBZnQiMT-IJJcEHvIEnA-1; Mon, 24 Feb 2025 19:48:08 -0500
X-MC-Unique: ETlBZnQiMT-IJJcEHvIEnA-1
X-Mimecast-MFC-AGG-ID: ETlBZnQiMT-IJJcEHvIEnA_1740444488
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0a587dbc4so450701185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444488; x=1741049288;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/JmrwGEw3CrM+p3ANhfE1oWprymTvgwdlTM4Q6oxJE=;
        b=Ju5PI3Vdr+T+95dkebsd9vjqqx3760TMSG8oOutfp3pg2VPI4YN5DHXvdxFCvhMUNd
         Etw+7Vghmm64m07xL7uUPcI59Tvjfwex1UKFUJ73nhO9PySBBeX70FhfHmQ/cxWxTd0a
         V1JjK6RiQ10R856aKd0HtAUfB4NO2FP+LwqfSCNlbvhBeRGqsa8bictfTdbOjKFkn5ol
         WIQcwOTSGVeROo/UUsE6q4ucCeMySEA1zH0fgEHex13sdgVeC1VQKijZlE0s5jXbpuFQ
         HxjCexBryWmDp2EYVC7CEbBA1mBTmLlGqw1hX32AVcLaZFI8RT1cJ0FeDcDX0VKoFRof
         ZaPw==
X-Forwarded-Encrypted: i=1; AJvYcCUwlXbU+B2FgUb5pnwZ6cEkfNZoR/idKBYsEn/G51ewqgUfKpTRPANOhSwnWhb6jDcDAOGg+TrlNLDGLZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SRU717pSkqElBqbFj+Bha6EPorK2YcgGTbhS9zdeSGpMZWmr
	1YeXKMsM45DityStgKVn+qKbfMtJDCf2l8PB2HbVkVfFkQa5+Htysuf8WXyEvjIuUfnofXoMFu5
	m19cLJN0FordHBOJq783rdwf3hby/OR6bXJPmuqCb7vShFwJWtFoDgCWDdpwcBw==
X-Gm-Gg: ASbGncv2AhQRArhrZZ4WmjvZiuCuxa7F5biBxvDfcQObZUGj+lEjyVi/Fp5hxOqtEGt
	SrJP+5A8PsGTb7TntOdRlc7hP9xQA2oqpIm8ZLQeag5Ny1up1AxfvQNlI0y8KvH2WS5Dh6nXbPX
	IjG7T4isNNH7n5ScKrTezCs38fkEK5T3DD/LB8+qfo/sWcxGiBTKpeRuqQYRMs5ixhboKuy1vhK
	pKpvar2JCAYBFfzGD5VfdrMgEA8et0LUDh2WJEG5fK1Rkt2xsseoI81kGUkzO7QVr3ySToK0IXx
	x0gceIMP+bFNe4v6oo0JhmxhzDzg4GdWshfct8h/y59pUzfajk3nGY29yyg=
X-Received: by 2002:a05:620a:4155:b0:7c0:6867:8052 with SMTP id af79cd13be357-7c0cef71760mr2048906785a.58.1740444488065;
        Mon, 24 Feb 2025 16:48:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuosyxFIZhqy9Ls2MawOO6Pk5YXA2X3Vszc+uR42FabLkge+AubVIYQgggue/TOu16J0vGqQ==
X-Received: by 2002:a05:620a:4155:b0:7c0:6867:8052 with SMTP id af79cd13be357-7c0cef71760mr2048904385a.58.1740444487796;
        Mon, 24 Feb 2025 16:48:07 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c3271e2sm41278585a.88.2025.02.24.16.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 16:48:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fc51b600-41b1-49c3-9189-8857c72d47b4@redhat.com>
Date: Mon, 24 Feb 2025 19:48:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
To: Steven Rostedt <rostedt@goodmis.org>, Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
References: <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
 <174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
 <fdb8adb0-efaf-45c7-8814-212026d7da53@redhat.com>
 <30f8fa10-4527-4e03-91c6-638834412466@redhat.com>
 <20250224095151.73e809f8@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20250224095151.73e809f8@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/24/25 9:51 AM, Steven Rostedt wrote:
> On Sun, 23 Feb 2025 14:53:28 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>>>>    +
>>>> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>>>> +static void debug_show_blocker(struct task_struct *task)
>> I think the easiest way forward is to change it to "#if
>> defined(CONFIG_DETECT_HUNG_TASK_BLOCKER) && !defined(CONFIG_PREEMPT_RT)"
>> to skip this feature for PREEMPT_RT right now . Otherwise, you will have
>> to deal with the rtmutex code.
> If this isn't supported by PREEMPT_RT (yet), then just make the
> DETECT_HUNG_TASK_BLOCKER in the Kconfig be:
>
> 	Depends on !PREEMPT_RT
>
> Don't put that dependency in the code.

Yes, that will work too.

Cheers,
Longman


