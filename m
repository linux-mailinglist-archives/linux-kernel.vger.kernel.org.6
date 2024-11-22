Return-Path: <linux-kernel+bounces-418297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A69D600E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5841A1F23165
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997476036;
	Fri, 22 Nov 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT21EBqH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6FF29CE6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283802; cv=none; b=YXgl3zWTFkyST4VvTk0dWXdJm1rAyXSS/xawR2HP95wtsfZ/Qs5SyT7Yi+rfGLSH5GlcNR7Ll2mW6/Sh4V7eUYXkx3duhYgdZ6XaKesHBCKZ8rjTWjGE84FP8LNpt6G4xH+aCxRFer3tx22mORWzOrnWFO0HTJAREdugBp8YY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283802; c=relaxed/simple;
	bh=8WMrdbry8cYbb3PwBwFzfa4t8XIIPzo0aJN5xmp6Bzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AVcko5PEVaeKJ0WRVocb5Vgmxrs4pqYRaKSEgKrT+OBxFbcWOx35kWe5dCH1steaIfqkti9KlgV3q7ePBO9r5o2pQwzw8+7ipJh4JG+M77hrA3oisAO3fxd7n6uVTLyLMCS/Ez0bZUwUTf7tb+VB+y/Idh4sz+Gv6N8eNweGhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JT21EBqH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732283800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsHaI1ei1IfQPr0KsTU1Bgjr9RwL5hBLdlpSc5oHDTU=;
	b=JT21EBqHCsSyPl3ffxSYLitOS3ro9JY0IAUhMjt9E36t6a+G6X/H/tySP9VReojvYaO77b
	6IGOJhOGa70iW84GramlQRpeVRMH6U22TFnURm2+dF89PZ3SaG9KetU82JAEVLekpAqBe1
	AumAMroVV+cpwlFwA82P7JIRuEyxAVs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ofESuAy-NUmVUCrhTfFkVw-1; Fri, 22 Nov 2024 08:56:39 -0500
X-MC-Unique: ofESuAy-NUmVUCrhTfFkVw-1
X-Mimecast-MFC-AGG-ID: ofESuAy-NUmVUCrhTfFkVw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-381d0582ad3so1508550f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283798; x=1732888598;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsHaI1ei1IfQPr0KsTU1Bgjr9RwL5hBLdlpSc5oHDTU=;
        b=rZrbkoQaJGjCERcyMg2cRk6Bh7MPnZyJUCToQxBtRfAgSnpikSVh90LBrGvnASnZF+
         HyeYeHaItCnWY2rNsg4HkLyaqqMHOQLQMEVChqV1E9F2Qwm+wXMZ6eM8dnM3ufLr+9Qv
         dAfnZksHSNKI+hL0ftehNQ0Wg9jCYQ9XDwI1TfDRMQAGYtij6Yu5rgMzHxpSFJjofyxy
         3vI6HPRfc1v+7gm51pgJw1XfbFNB0DrvfdoZtnx/zDoEk7oNGmP7vI2cxQ3kh0VBC+Oa
         Op4i90x62pe6pYUjXSyHiU2yZfjJh2A/2Wzz+mfeJTin38k7fmzc+r+IplGYU/tOD72R
         HcOA==
X-Gm-Message-State: AOJu0YxcLAarJYVUbmNakarbXqGWNgMq4t9L3PpbA3GRZ4EiLR7i4KLb
	0aKlIRjIsjI0ycQ+VPzWHAw5KSUQ7mtnwYwTAnUWz3/Usm+mlSPd9fJ23tBNg7NBa9UHiJTemP2
	U92F/wPZjItE11PyrZS6KhQm69ezAOWdVHvQXs11vhcOyIxqhL4uR+N+S/PM7aQ==
X-Gm-Gg: ASbGncuxusMx5tGziUlfYst8E27hziVRUy/qiVu0FQ1/haXIvcwfh5wixUa9wrethzQ
	d+K+95nURa7eI3oC89nT+/olLnDk2EQt3SQU7VaI7e0CsIftteU/l5CPJVeP/aef0yyBe3Oh8tt
	qunRw9mHLrXLuqMOjJbKda51rIa48/pEHbUB8xlH88t2FjoawbH+3qCZbsjGEywNwyCGKwjAPC4
	zD/u0WZZjB568gMBFscW8a9Eh02+ss0qcySfso2uhWhBboNMsr8Yw/nnYrPwFSan0nDAgKoFLja
	PaImyeBpratcWLgXiAjVDi18Q3Qom1VGHCc=
X-Received: by 2002:a5d:64a9:0:b0:382:4fa4:e544 with SMTP id ffacd0b85a97d-38260b3caf5mr2941916f8f.6.1732283797803;
        Fri, 22 Nov 2024 05:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiRi9yMi/lEmTBvU6LjIZoyT2mo/EJzfL6hLaHeWfXh/dSLFhhXDExODAa08mxumRLkt9jSw==
X-Received: by 2002:a5d:64a9:0:b0:382:4fa4:e544 with SMTP id ffacd0b85a97d-38260b3caf5mr2941848f8f.6.1732283797392;
        Fri, 22 Nov 2024 05:56:37 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf40sm2418281f8f.98.2024.11.22.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:56:36 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 04/15] rcu: Add a small-width RCU watching
 counter debug option
In-Reply-To: <f85c0f84-7ae3-4fb5-889a-d9b83f9603fe@paulmck-laptop>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-5-vschneid@redhat.com>
 <f85c0f84-7ae3-4fb5-889a-d9b83f9603fe@paulmck-laptop>
Date: Fri, 22 Nov 2024 14:56:34 +0100
Message-ID: <xhsmh7c8v9xt9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 22/11/24 04:53, Paul E. McKenney wrote:
> On Tue, Nov 19, 2024 at 04:34:51PM +0100, Valentin Schneider wrote:
>> +config RCU_DYNTICKS_TORTURE
>> +	bool "Minimize RCU dynticks counter size"
>> +	depends on RCU_EXPERT
>> +	default n
>> +	help
>> +	  This option controls the width of the dynticks counter.
>> +
>> +	  Lower values will make overflows more frequent, which will increase
>> +	  the likelihood of extending grace-periods. This option sets the width
>> +	  to its minimum usable value.
>
> The second sentence ("Lower values ...") sounds at first reading like
> this Kconfig option directly controls the width.  The third sentence sets
> things straight, but the reader might well be irretrievably confused by
> that point.  How about something like this instead?
>
>       help
>         This option sets the width of the dynticks counter to its
>         minimum usable value.  This minimum width greatly increases
>         the probability of flushing out bugs involving counter wrap,
>         but it also increases the probability of extending grace period
>         durations.  This Kconfig option should therefore be avoided in
>         production due to the consequent increased probability of OOMs.
>
>         This has no value for production and is only for testing.
>

Much better, I'll take that, thank you!

>>  endmenu # "RCU Debugging"
>> --
>> 2.43.0
>>


