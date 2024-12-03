Return-Path: <linux-kernel+bounces-429171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1985D9E1856
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E4DB47B70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69671E0DE9;
	Tue,  3 Dec 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LPzoQvbu"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046F1DFE07
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218981; cv=none; b=Lkim9ayJcGBbika46uhEdVJPpvexSYtLusa2pbinzevd2+fr3OFdBdiLQ/mAsnZRD2JnFBHMx/H8AKeNS3USUZin/+t3FzkQz9dkVEF63A9Wj0fnNVER+zi1v3uCqrssjDzpNVOvGfuS6AzthvewbB99sUaCjZ+3TvO8cRYUQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218981; c=relaxed/simple;
	bh=eI/zlvotZwgY5z3hpeCnHw7eRH68Seup4RbHSkhiGkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEoV7AxESH96gT+gZa/J/ZJXqPkkf5THWgoMw0VOnAenXlKRH8FtEkCtpaX5totcOli7puEYTJYg53IY5wYqPd8KgKVoZw+/Cs0XxXHP8L5KaIgwFMDgxNoZk1uzIms7a7I5xi2WmKZaWZBx7MTACCpLwquuID/LXyfjPgTC7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LPzoQvbu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so6274541a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733218977; x=1733823777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZ65AI7tC1O9ChcL3cBFeeFnnzp7y2faeUES++bs0As=;
        b=LPzoQvbuVyWF12nFcV4LxWmRbEMOc3zBmmZPKZ5Or6awjzlk0Xoj7h4IK8pt2OkgLu
         yrZLRmVts603gf+EXs2CnjeKCxhH3btsHb79DTz+4YnqA5aEVVGClZRqCLaWFWcinUQw
         +KdntxFvRus6KNq96W2ueyNUElbHzfgDwU5LrAjzK7XB5foGYkr/988tnqWTJ7hKFJVt
         6jx3QdTpdTPiZ7UkflOGGy6ywkMawDOWryfXa5xvaWeT5LkegIdGsBFyAigRCqnPcxc2
         KTZWYLexlVX4VRPORnPmEAF6URNFa850TmVQfDfOm8y1p+yCmldqUCa+WOG0zeRYCenW
         9rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218977; x=1733823777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ65AI7tC1O9ChcL3cBFeeFnnzp7y2faeUES++bs0As=;
        b=kG0rgBJOiuWUKypIjs8YHFBM7AU8o6c+XK9urbElPivcdb8PRFNx27vPSCtv+7L33J
         ZfWJ7HsXr0lmtCLiklqCSxh5SqR/q88Wd8XGC0F+j0jKKKng0LVHHuA6FMh3kr35ksgF
         4ZTK149foEHqHV6TDIcZ8aT9/1bK/vdYgbpHUoxdwOEqfHrDzFL/psR0btV/ol9RSFIy
         B+EjnEeDX4y10FDUhWKBQ1tzlE1SN8wYdbCXvW+uh1nOR11TuijJ1uc28fMSLM31Kkgo
         86GUA4IrX3bY0hawn3LadZrX5Jg2ViQK/uS9VAqXRSPOyagBbxphKeA8ly5eK1ZZ3h79
         UOcg==
X-Forwarded-Encrypted: i=1; AJvYcCWorPUmg6rCLY8fr/0D1ErrjH3/RX2fuo+kTFfm69HHG/qDByY8YiDcxTFEPBQrcmk79CCRl6XC2lfj4sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7PlSd5muNkTyX65Favkbj9pVEwmnJegYmBKso5LCtv0QWDAyY
	mThFvAJnua7nBxdu06H6oXgrcvWGHtKmDlzDlvZ+nX7KzvtKWPMUS92tb7UK4UQ=
X-Gm-Gg: ASbGncso1bK8gXXp4i7ER2l0rpQojjoY4l7b+EysOBhppMmeVemqROJpkzsnnX1TvYG
	vETtZzkAIK0/hJxI2oj9eJbODbK6kgzhMQXVoWshPZNnAl6vOPtZyOt4VBoE95BZqDawRZ3CzgN
	T5jR3opxbnbQ9ZsRen1G5YNkwcpK3hUE6O+O13Z1cYUQHr4NJdxh7ldB1A6z7Kr0Y/hncktu1gF
	3Mm1ehX7tESTuAtmELRW9sMsoh43b0N/YnMr98LflJBa7z9oKA=
X-Google-Smtp-Source: AGHT+IEWivrrnwu01aHjd05LieGWf9F73ovQH7u5YJJEWQyT7aV4tCY7q79YBHBj7VdFuUyY7CbEHg==
X-Received: by 2002:a05:6402:34d4:b0:5d0:b9c7:479a with SMTP id 4fb4d7f45d1cf-5d10cb7d34fmr1417735a12.25.1733218977310;
        Tue, 03 Dec 2024 01:42:57 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6011293a12.14.2024.12.03.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:42:56 -0800 (PST)
Date: Tue, 3 Dec 2024 10:42:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	Linux Embedded <linux-embedded@vger.kernel.org>
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
Message-ID: <Z07SnoKSwHQ_y2j2@pathway.suse.cz>
References: <20240930184826.3595221-1-isaacmanjarres@google.com>
 <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
 <CAMuHMdX_r05iUFw6-Jj8Utry5bHdE6=U46uB4Za1NTsdZOuOMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX_r05iUFw6-Jj8Utry5bHdE6=U46uB4Za1NTsdZOuOMw@mail.gmail.com>

On Sun 2024-12-01 12:40:13, Geert Uytterhoeven wrote:
> Hi Petr et al,
> 
> CC linux-embedded
> 
> On Tue, Oct 1, 2024 at 5:55 PM Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2024-09-30 11:48:24, Isaac J. Manjarres wrote:
> > > When the initial printk ring buffer size is updated, setup_log_buf()
> > > allocates a new ring buffer, as well as a set of meta-data structures
> > > for the new ring buffer. The function also emits the new size of the
> > > ring buffer, but not the size of the meta-data structures.
> > >
> > > This makes it difficult to assess how changing the log buffer size
> > > impacts memory usage during boot.
> > >
> > > For instance, increasing the ring buffer size from 512 KB to 1 MB
> > > through the command line yields an increase of 2304 KB in reserved
> > > memory at boot, while the only obvious change is the 512 KB
> > > difference in the ring buffer sizes:
> > >
> > > log_buf_len=512K:
> > >
> > > printk: log_buf_len: 524288 bytes
> > > Memory: ... (... 733252K reserved ...)
> > >
> > > log_buf_len=1M:
> > >
> > > printk: log_buf_len: 1048576 bytes
> > > Memory: ... (... 735556K reserved ...)
> > >
> > > This is because of how the size of the meta-data structures scale with
> > > the size of the ring buffer.
> > >
> > > Even when there aren't changes to the printk ring buffer size (i.e. the
> > > initial size ==  1 << CONFIG_LOG_BUF_SHIFT), it is impossible to tell
> > > how much memory is consumed by the printk ring buffer during boot.
> > >
> > > Therefore, unconditionally log the sizes of the printk ring buffer
> > > and its meta-data structures, so that it's easier to understand
> > > how changing the log buffer size (either through the command line or
> > > by changing CONFIG_LOG_BUF_SHIFT) affects boot time memory usage.
> > >
> > > With the new logs, it is much easier to see exactly why the memory
> > > increased by 2304 KB:
> > >
> > > log_buf_len=512K:
> >
> > printk: log buffer data + meta data: 524288 + 1835008 = 2359296 bytes
> >
> > > log_buf_len=1M:
> >
> > printk: log buffer data + meta data: 1048576 + 3670016 = 4718592 bytes
> 
> Thanks, this is very useful information!
> 
> Isn't this kernel log message bookkeeping becoming a bit too excessive?
> E.g. on a small system:
> 
>     printk: log buffer data + meta data: 65536 + 204800 = 270336 bytes
> 
> Why is the meta data that big (> 3*log buffer)?
> 
>     #define PRB_AVGBITS 5    /* 32 character average length */
> 
>     unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
>     meta_data_size = descs_count * (sizeof(struct prb_desc) +
> sizeof(struct printk_info));
> 
>     struct prb_data_blk_lpos {
>             unsigned long   begin;
>             unsigned long   next;
>     };
> 
>     struct prb_desc {
>             atomic_long_t                   state_var;
>             struct prb_data_blk_lpos        text_blk_lpos;
>     };

I am afraid that we could not do much about the size of this part.
All the variables are important parts of the lockless machinery.

> i.e. 12 bytes on 32-bit, 24 bytes on 64-bit.
> 
>     #define PRINTK_INFO_SUBSYSTEM_LEN       16
>     #define PRINTK_INFO_DEVICE_LEN          48
> 
>     struct dev_printk_info {
>             char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
>             char device[PRINTK_INFO_DEVICE_LEN];
>     };

This is probably the lowest hanging fruit. It should be possible
to write these dev_printk-specific metadata into the data buffer
a more efficient way and only for records created by dev_printk().

It would require adding "dict_len" into "struct printk_info"
and reserving space for both "text_len" and "dict_len".

We bundled it into the metadata because these are metadata.
We wanted to keep the design as clean as possible. We focused
mainly on the stability and maintainability of the code.
And it was really challenging to get it all working.

>     struct printk_info {
>             u64     seq;            /* sequence number */

I do not recal the details. But I think that we need to
explicitely store the 64-bit "seq" number in the metadata
because of the lockless algoritm. It helps to solve
problems with wrapping of the counter in
"atomic_long_t state_var".

It was not stored before. The following global values were
enough when the log buffer was synchronized by "logbuf_lock"
spin lock:

	static u64 log_first_seq;
	static u64 log_next_seq;

>             u64     ts_nsec;        /* timestamp in nanoseconds */
>             u16     text_len;       /* length of text message */
>             u8      facility;       /* syslog facility */
>             u8      flags:5;        /* internal record flags */
>             u8      level:3;        /* syslog level */
>             u32     caller_id;      /* thread id or processor id */

These metadata used to be stored in the "data" buffer next to the
message. Here is the declaration from v6.9:

	struct printk_log {
		u64 ts_nsec;		/* timestamp in nanoseconds */
		u16 len;		/* length of entire record */
		u16 text_len;		/* length of text buffer */
		u16 dict_len;		/* length of dictionary buffer */
		u8 facility;		/* syslog facility */
		u8 flags:5;		/* internal record flags */
		u8 level:3;		/* syslog level */
	#ifdef CONFIG_PRINTK_CALLER
		u32 caller_id;            /* thread id or processor id */
	#endif
	}

>             struct dev_printk_info  dev_info;

As I wrote above. It should be possible to store these metadata more
effectively in the data buffer.

But note that it is only about the internal kernel code. These change
would require also updating external tools, for example "crash" tool.

>     };
>
> for a whopping 88 bytes.  So that totals to 100 bytes per entry
> on 32-bit, and 112 on 64-bit, for an average of 32 characters per
> printed message...

It would be interesting to know how much if these are wasted because
either struct dev_printk_info is empty or the entries are shorter.

Best Regards,
Petr

