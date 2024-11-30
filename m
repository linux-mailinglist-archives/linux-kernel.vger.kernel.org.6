Return-Path: <linux-kernel+bounces-426121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00E9DEF39
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8622818F1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 07:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B6142E6F;
	Sat, 30 Nov 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eNrHfNZX"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D08C3F9C5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732951290; cv=none; b=l6NDwZjmz3+IMdJfAqrqJ4snqiXAuYaZTd5GbJQjEP9jdh0zdSknlc7MMgqDRZ3h9bdBP1Wjh1rbcyBkywcXAa1UG/rtgnrcHhceEesrlK8Uzy+00PZW13m85OmrbU5R7IK2LQC8oVEbcjcQgUtnbdgAIpVqWbZ9W44pAwHFyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732951290; c=relaxed/simple;
	bh=ZuGzMu1cAhdhKnxWmpQYt48/+C2Q2jjl167J8oEkP9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxWe371VRwiXfTVYnGlvnyZILY166da1bVWSXyoyv8QhigiBpk7rlEUYib3R7O/rRc4nWfWJBdJ3pWiixbH7j2/Qv2wyr4pySGN1y/XaTJnHvxQYahXPlRtj2uh/eHUtggNXK6Tu1pk08Ckfbhq+8gMVjyhWRxqXW4aJomMOgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eNrHfNZX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so2854245a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732951286; x=1733556086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjT13Cv4AdQa2fEkQJmI8w/5/0E5OcwQAJoY5vQggB4=;
        b=eNrHfNZXo0fUIuBB4CMsqj9qi/DUKOwh7i6rgih/JCqk6M3ARr4IpBNnnODNqY+nL4
         JVieZvpHKjItNvxPmfT2ro4GF0tosVQ4+0SI0lGvHvZZ6mQe81yIflvKZHQVvjmcfBDo
         RuiSYz2VAiEioTLsyrnVbAcZS9JvWtBmrv8oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732951286; x=1733556086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjT13Cv4AdQa2fEkQJmI8w/5/0E5OcwQAJoY5vQggB4=;
        b=NF8orsGgS+xYDB/FNXVHsoOOXlVzgWxEczdGUE4LFdsQ5b9R8RbFuChBf3NmE50523
         UlyMtQrcHlkIWShy8jRriWeIxWUCetLd4AumeQPj3Y4JQ9rfrE9stsLLqx731lb0F1Xc
         sJuXzzOiqg52v9RQwJyLrFQXqU2Y2YjcO3flA6K2bdLc5QxV7vx8bujFH20PEgV/Se7V
         SeQ+cbKc+Y91vwa0OjNFOFGOZAuiuIeT4YaLHidInYHYIZ6gIDiq/XSV01d/TAQAAH+S
         4ZSW184UrZgY4MhasdB/cwGTPD+k8rMKHwLO5yCt+1DxI3uOL87UUIjiZjK9rpO/pLmg
         qLWg==
X-Forwarded-Encrypted: i=1; AJvYcCWWuIuN0iSMTvkO/U1xZWcuZRI5idJemtyCrUKjiUPhPthcuvIzUsXA+J1/l1NsMKlZ5WQMPSWne2VjoSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBl+IRoou8lxx+NSdo1IQ2w2poqjDksU5SaaeTK/Atz/+c7oI7
	vCzI4aET5AYaCQR6cAOplhYdEVQN3SWl76Ua6rt6yn4EzygFnkMC/jGn91Tj/e5BqW8pVGQ3Q4m
	fQ7w7Fw==
X-Gm-Gg: ASbGncvnQhgHBeSPtcEnLBnc1IuASWtpS2ZqMdIF5aNi1iawUxvxsB0/lo686nGtoEV
	2AH6DE/Qz6CE2ldzvXlHtnVtxtjsIB0hQ3lap3tmYkPOV/qo7/gHpuMYRkGa9zNUz7eIWB+N4QA
	CUK8Z0tSK1tGuQCMZpOBjsSFklBymUT+ECbTVNjfe1tJm4rP0xC8UIxDT354rQDJ4H1k6jwMWs4
	OjWxIgJLsGZPf9ig6LcKbm7W1gWirfB+eD7HRiNPoUA9aLUNfUchnikHA6a2zOUPUNdp67PCbrZ
	4vFZd55Nwc01EljTIKNpSSsO
X-Google-Smtp-Source: AGHT+IHZji2eEXf073+SI2rjO4ZPcieESpq6xLsxFDQN5FKUwdUXtnvH8WPEkOMX/oZkswnkvsmxTw==
X-Received: by 2002:a05:6402:1ca9:b0:5d0:8359:7a49 with SMTP id 4fb4d7f45d1cf-5d083597a80mr10609567a12.0.1732951286335;
        Fri, 29 Nov 2024 23:21:26 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0bf49f159sm927220a12.0.2024.11.29.23.21.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 23:21:25 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a83c6b01so23243605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWceIyhpHtkMHgiB2t9le/R9Bwuz/khTbXaSz31s6OVx08eUQ5xRUnhC+Q4Fytoxo88WuT6XWOpNc+GTS0=@vger.kernel.org
X-Received: by 2002:a17:907:7758:b0:aa5:3d75:f419 with SMTP id
 a640c23a62f3a-aa580f2af8bmr1208100366b.13.1732950961012; Fri, 29 Nov 2024
 23:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org>
In-Reply-To: <20241130044909.work.541-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 23:15:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
Message-ID: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007218e906281c16e8"

--0000000000007218e906281c16e8
Content-Type: text/plain; charset="UTF-8"

Edited down to just the end result:

On Fri, 29 Nov 2024 at 20:49, Kees Cook <kees@kernel.org> wrote:
>
>  void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  {
>         size_t len = min(strlen(buf), sizeof(tsk->comm) - 1);
>
>         trace_task_rename(tsk, buf);
>         memcpy(tsk->comm, buf, len);
>         memset(&tsk->comm[len], 0, sizeof(tsk->comm) - len);
>         perf_event_comm(tsk, exec);
>  }

I actually don't think that's super-safe either. Yeah, it works in
practice, and the last byte is certainly always going to be 0, but it
might not be reliably padded.

Why? It walks over the source twice. First at strlen() time, then at
memcpy. So if the source isn't stable, the end result might have odd
results with NUL characters in the middle.

And strscpy() really was *supposed* to be safe even in this case, and
I thought it was until I looked closer.

But I think strscpy() can be saved.

Something (UNTESTED!) like the attached I think does the right thing.
I added a couple of "READ_ONCE()" things to make it really super-clear
that strscpy() reads the source exactly once, and to not allow any
compiler re-materialization of the reads (although I think that when I
asked people, it turns out neither gcc nor clang rematerialize memory
accesses, so that READ_ONCE is likely more a documentation ad
theoretical thing than a real thing).

And yes, we could make the word-at-a-time case also know about masking
the last word, but it's kind of annoying and depends on byte ordering.

Hmm? I don't think your version is wrong, but I also think we'd be
better off making our 'strscpy()' infrastructure explicitly safe wrt
unstable source strings.

          Linus

--0000000000007218e906281c16e8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m43u8l1f0>
X-Attachment-Id: f_m43u8l1f0

IGxpYi9zdHJpbmcuYyB8IDE0ICsrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi9zdHJpbmcuYyBiL2xp
Yi9zdHJpbmcuYwppbmRleCA3NjMyN2I1MWUzNmYuLmEyYTY3OGU0NTM4OSAxMDA2NDQKLS0tIGEv
bGliL3N0cmluZy5jCisrKyBiL2xpYi9zdHJpbmcuYwpAQCAtMTM3LDcgKzEzNyw3IEBAIHNzaXpl
X3Qgc2l6ZWRfc3Ryc2NweShjaGFyICpkZXN0LCBjb25zdCBjaGFyICpzcmMsIHNpemVfdCBjb3Vu
dCkKIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfS01TQU4pKQogCQltYXggPSAwOwogCi0Jd2hpbGUg
KG1heCA+PSBzaXplb2YodW5zaWduZWQgbG9uZykpIHsKKwl3aGlsZSAobWF4ID4gc2l6ZW9mKHVu
c2lnbmVkIGxvbmcpKSB7CiAJCXVuc2lnbmVkIGxvbmcgYywgZGF0YTsKIAogCQljID0gcmVhZF93
b3JkX2F0X2FfdGltZShzcmMrcmVzKTsKQEAgLTE1MywxMCArMTUzLDEwIEBAIHNzaXplX3Qgc2l6
ZWRfc3Ryc2NweShjaGFyICpkZXN0LCBjb25zdCBjaGFyICpzcmMsIHNpemVfdCBjb3VudCkKIAkJ
bWF4IC09IHNpemVvZih1bnNpZ25lZCBsb25nKTsKIAl9CiAKLQl3aGlsZSAoY291bnQpIHsKKwl3
aGlsZSAoY291bnQgPiAwKSB7CiAJCWNoYXIgYzsKIAotCQljID0gc3JjW3Jlc107CisJCWMgPSBS
RUFEX09OQ0Uoc3JjW3Jlc10pOwogCQlkZXN0W3Jlc10gPSBjOwogCQlpZiAoIWMpCiAJCQlyZXR1
cm4gcmVzOwpAQCAtMTY0LDExICsxNjQsMTEgQEAgc3NpemVfdCBzaXplZF9zdHJzY3B5KGNoYXIg
KmRlc3QsIGNvbnN0IGNoYXIgKnNyYywgc2l6ZV90IGNvdW50KQogCQljb3VudC0tOwogCX0KIAot
CS8qIEhpdCBidWZmZXIgbGVuZ3RoIHdpdGhvdXQgZmluZGluZyBhIE5VTDsgZm9yY2UgTlVMLXRl
cm1pbmF0aW9uLiAqLwotCWlmIChyZXMpCi0JCWRlc3RbcmVzLTFdID0gJ1wwJzsKKwkvKiBGaW5h
bCBieXRlIC0gZm9yY2UgTlVMIHRlcm1pbmF0aW9uICovCisJZGVzdFtyZXNdID0gMDsKIAotCXJl
dHVybiAtRTJCSUc7CisJLyogUmV0dXJuIC1FMkJJRyBpZiB0aGUgc291cmNlIGNvbnRpbnVlZC4u
ICovCisJcmV0dXJuIFJFQURfT05DRShzcmNbcmVzXSkgPyAtRTJCSUcgOiByZXM7CiB9CiBFWFBP
UlRfU1lNQk9MKHNpemVkX3N0cnNjcHkpOwogCg==
--0000000000007218e906281c16e8--

