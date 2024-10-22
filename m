Return-Path: <linux-kernel+bounces-376969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A2C9AB832
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC6C1C21A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F81CC164;
	Tue, 22 Oct 2024 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol3FfQ6p"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9259B71
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631321; cv=none; b=HvpKT0j2N328hmj/cw4aSomVUaUzRuBpcK/xvcqRic+DHPFKIg3R2ppEV/Pj2JqIJgqWnI2owYui8wo9o4Ullds77mrkgedn3YgFaoddknncaZX0OiP52Gw4mTZVLGOQ2RAShjMxeNaMzXZAIVEGKTaXcp/oEWUBEAsaBRNEXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631321; c=relaxed/simple;
	bh=Xjkh40l5vufdwsVJi34MeQcxCKaA1g1UjKdcEwBvBQs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buorz+NoyAKWqIRd5hBUUbZY7vW7WT6F8S2JgbwWIRtk+VTzbRiNHl+7W4lzUKQhlX5oFMC0c9Jfog9+1+d+hEgymAkQUYGUiejPEu/1d2rnIa2jtXb22LVQGtjRYQp/tjnNh/fJ3a7ZAS2AGDvf7nEbJEc2bNgQCc+tirtgmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol3FfQ6p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso7358250a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729631318; x=1730236118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlGVD1afRO0J0hySzv5lIBijcdOAPnGH7GUqjHaMbBA=;
        b=Ol3FfQ6pgPBxDBTwXiZZYEQRZfqQ3jc9xiOZY6e5l+7A9qLi21y6jgBkfix6iD1vNn
         18fBIZi5++/JUbcSJ+r0xsSH9TRLDxVpmoEtkLFZMZVGuvvlC5STbDff60U3g4BMgGW5
         ksbKwRa+BgsIIOreK0DOHKgBn07Kf/DbF652+MGZzKIwRWnoTk1GxG+k1kGt2KDuAZge
         z6mFKLgNkq0xVaHenI6vFBuGbK1/RO7J8M+VJLt0gqNyDP5l4chYvCwtnDIQA6nvT4/Q
         SMN2k8bboKzCE9G+3sN3S474UhbGxjWt83g+QBXIcC8l9rOSY23Yyhei6TmOrZXuZMMw
         Cwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631318; x=1730236118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlGVD1afRO0J0hySzv5lIBijcdOAPnGH7GUqjHaMbBA=;
        b=OtUazyngg7m6Dnq6wueoQB0lfD405nFfTpZp+cXG6fUm6BAAGvhkczzcEmgeMpB6EG
         gROUXsN/Y0LwszvGd0z25mWqbG3PWuRA1mlGP37X+vTW1+w5MUQFRrYrcDvrZZmPtSvB
         FX3cZWuXRKmNNBLeGX5KfqARIREUAjFle9NsCVoM74IYTPL30ecDY8teFHFFhsj+M4il
         e7I8RmRisv9PeDQj1KBt8qmNBCHr+mNTW0LGwnZHdDUPqwLXDBRNHpP/zPlSbx7bcba8
         OcJSES6ee2Wse0qnFSP+XU+k/qMgJR9uNWqF9nJ8oHB8Y5PiYwZDTJNrhkC/AalaJ3Vf
         ukqA==
X-Forwarded-Encrypted: i=1; AJvYcCXiVJn8hiFxFQ7i0OjiooLdRHoBzWcVaZnE05IIX9wsuuQsVlK3ojg0WYrexatd26Y5ZUuxoNhap9tU/po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAoDsCeRZP6Z4I8+SEyCucoiszVfYty2qo9vkXF4w/yxSdGsaO
	aJ1ZY12oO5ZPGLj9LavN2W8zuu4HXR0oZTmEpcyFeHHjeLXFEtrp
X-Google-Smtp-Source: AGHT+IFFVdf8pqWTuEQkBRUxBKqit4E0lHS9zIxLQSP7StFEjoXKZHYFRqZpd6WtkkmoMmjw7nwC2Q==
X-Received: by 2002:a17:907:3e02:b0:a9a:222f:45d1 with SMTP id a640c23a62f3a-a9abf86a5b5mr27086766b.20.1729631318215;
        Tue, 22 Oct 2024 14:08:38 -0700 (PDT)
Received: from krava (85-193-35-199.rib.o2.cz. [85.193.35.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f7db1sm385074466b.89.2024.10.22.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:08:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 22 Oct 2024 23:08:36 +0200
To: Sean Young <sean@mess.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	andrii@kernel.org, yhs@fb.com, linux-kernel@vger.kernel.org,
	daniel@iogearbox.net
Subject: Re: perf_event_detach_bpf_prog() broken?
Message-ID: <ZxgUVMnopmXEm2Vg@krava>
References: <20241022111638.GC16066@noisy.programming.kicks-ass.net>
 <ZxewvPQX7bq40PK3@krava>
 <Zxey1hxhnp9_BebL@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxey1hxhnp9_BebL@gofer.mess.org>

On Tue, Oct 22, 2024 at 03:12:38PM +0100, Sean Young wrote:
> On Tue, Oct 22, 2024 at 04:03:40PM +0200, Jiri Olsa wrote:
> > On Tue, Oct 22, 2024 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > > Hi guys,
> > > 
> > > Per commit 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return
> > > -ENOENT if exclude_prog not found") perf_event_detach_bpf_prog() can now
> > > return without doing bpf_prog_put() and leaving event->prog set.
> > > 
> > > This is very 'unexpected' behaviour.
> > > 
> > > I'm not sure what's sane from the BPF side of things here, but leaving
> > > event->prog set is really rather unexpected.
> > > 
> > > Help?
> > 
> > IIUC the ENOENT should never happen in perf event context, so not
> > sure why we have that check.. also does not seem to be used from
> > lirc code, Sean?
> 
> You can deattach a lirc program using the bpf syscall with command 
> BPF_PROG_DETACH, and if you pass an incorrect (as in, not attached) program,
> then this commit ensures you get ENOENT rather than success.

I see.. so that's for lirc programs, but we can't detach perf event's
program like that

the program is stored in event and is detached and released only when
the event is freed, so even for ENOENT error (which can't happen) we
still need to release the event's program

I think we can just remove the check like below

jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7370a321126..e4e22499956d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2240,8 +2240,6 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
-	if (ret == -ENOENT)
-		goto unlock;
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {

