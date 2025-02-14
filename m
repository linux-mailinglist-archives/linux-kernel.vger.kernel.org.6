Return-Path: <linux-kernel+bounces-514830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A90A35C49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CF218934A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ABE260A4F;
	Fri, 14 Feb 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhkovlFz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C425A652
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531741; cv=none; b=DpoBe/Ek54B5KTl7UElYAC+OzCRVele2azPi8ystTsMEljlDes2K1ebJrwSghw/4fLaihlRRg3F5GPSvrOIX+5RRU0t4rkDgWGwIeCABc1ZcEdSAW9x7ekCQfzXDyijwFyWBzR1nnxlMF7VV1XImKVIQw80JxBq/ANQx5iNZoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531741; c=relaxed/simple;
	bh=Q1iQIbvDhgSHZ4WT/gbEt1daMYEMQVwHES/A7FJ/qNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVnhX1TgoCVbn4WzVWgv18A6i7AV2kIj/Jdpn0yVOQxJ4w2ECUVZ/97EJD254oE98AM+UFvMxVqF+BU7GS9sDZfZyhjhk2rqi7Y9iCpQS/ia1kwXwNxwEtWN4EWqBa8M0//9z76uKGRluNOkXja6sWNitAFJob8FekzO8huKlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhkovlFz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739531738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q1iQIbvDhgSHZ4WT/gbEt1daMYEMQVwHES/A7FJ/qNY=;
	b=VhkovlFzoQ+pezq9aShmI1ig64tWJnAbGMR0eB7OS5nFzjRw5IlWrEgifsKa4buhSDYyei
	gBM+1X5spfVjyvu+0lsWxhIt+CDYISRgBJZY6BdU++rAw3Y0iI9iZPCYmSQnwcHiIvhJMh
	xlMrhX4bmXlkxQo4zWf7gsy/7BggvS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-soo9juPRP5aht2AX8uZ1lw-1; Fri, 14 Feb 2025 06:15:37 -0500
X-MC-Unique: soo9juPRP5aht2AX8uZ1lw-1
X-Mimecast-MFC-AGG-ID: soo9juPRP5aht2AX8uZ1lw_1739531736
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-439622e9113so12571035e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531736; x=1740136536;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1iQIbvDhgSHZ4WT/gbEt1daMYEMQVwHES/A7FJ/qNY=;
        b=ZKgj1sRRfNn17P8DhTHbTnocVoAerrGtxL3GcAch2BV7hpp77/DnKsrymLN9o+Arvr
         P2YfAprexgH1j6v/5bhddP/+3+o8C9mz5Zo7KGM7D3tEDz7mjSj7isVA1OVFVIB411xA
         uGDBsW7v7PjOJcqqLGC0Y11Ls6VN55ikPxGe+CLepysuf3W0BQ5Fn5En2TQJ1o7LkT84
         mQf3h8ENLiDQTxM5+kXrl/b101/32KMB0yOVJ1Ilap/SWSyst/o7YYr5mImyPogAo7wI
         YiSEpCEOhSsUY/Oj7qk8gqiCEuxUF+34aYkUUZIWg53LfeKL97nEPkx6oL3UOyk12gjq
         t90Q==
X-Forwarded-Encrypted: i=1; AJvYcCX21uTxdkXGlLnl8KZGqKgoGgFKObrCActi4RO4i6I4HDIAHKVWKf5oSlUFVw9Ig6w0Cy7kgWpO2avj1N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNh8SjJNjGZG9HeGKwstBAwAxLMsmkLF0nCG2J2LI5JLNoijU
	Fn1qj+cVxGA3PHxZmD31XXZrJOO5jX8AmkcMFhe/HxLOiVi0SvnKj9vZDOOjMuS8ZX9RfwQqk2y
	V7qHrB1OWWkyix/4YU93wj59jZGUm/FrdKqTdY3KWxl1TscYL47F0OE+ON2udDMV3R3AbYhQx
X-Gm-Gg: ASbGnct15CsoecDlyPB5IyYYYfBq9gEHAh6jqm2QJgiZ13W/j0pumdPXNQEURGAnMJS
	B18TFC2aTzW2NetutM6hC+nze9Cjlvmp9qopRBl4vldNFEMpHp0yLH3QvIsdlzg3StiO4M40VOH
	VCBbR8Qbbo/EuGuVF2f3GxMus4DTayVvoyXu2T6yrdsdfaUfxNAnmAesi2N6tlPe3/LtBDq6MfB
	BJMPcqQBcMf/ONqAmN1TRpJNNIppVMpHRCCcc7huSu6x9o3msq73G46lBn694IX7QZR0eLhjlIf
	0LcxuPFBMH6oUn7LC3nut7eoL68oLIL3vw==
X-Received: by 2002:a05:600c:19cf:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-439581b88ccmr119294135e9.22.1739531736300;
        Fri, 14 Feb 2025 03:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkfOw2bzXtZt2kXV8bZhrLtsOBgcZjNkpTqtdBEsmjzhSmT9IDyjozv2rFlJKM3Au+7OdF3w==
X-Received: by 2002:a05:600c:19cf:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-439581b88ccmr119293675e9.22.1739531735938;
        Fri, 14 Feb 2025 03:15:35 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961645422sm27024865e9.2.2025.02.14.03.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:15:35 -0800 (PST)
Message-ID: <789b56973c0e6419a6a44210a18d1b31d0daf8e6.camel@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
From: Gabriele Monaco <gmonaco@redhat.com>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>
Date: Fri, 14 Feb 2025 12:15:31 +0100
In-Reply-To: <202502141516.OkUInaxw-lkp@intel.com>
References: <20250213090819.419470-4-gmonaco@redhat.com>
	 <202502141516.OkUInaxw-lkp@intel.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=20
On Fri, 2025-02-14 at 16:00 +0800, kernel test robot wrote:=20
=20
> =C2=A0> =C2=A0=C2=A0 kernel/sched/core.c: In function
> '__do_trace_set_current_state':=20
> =C2=A0
=20
> =C2=A0
> > =C2=A0
> > > =C2=A0> > > kernel/sched/core.c:503:9: error: implicit declaration of=
=20
> > > > > > function '__do_trace_sched_set_state_tp'; did you mean=20
> > > > > > 'trace_sched_set_state_tp'?=20
> > > > > > [-Werror=3Dimplicit-function-declaration]=20
> > > =C2=A0
> > =C2=A0
> =C2=A0
=20
> =C2=A0> =C2=A0=C2=A0=C2=A0=C2=A0 503 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 __do_trace_sched_set_state_tp(current,=20
> > current->__state, state_value);=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_sched_set_state_tp=20
> > =C2=A0=C2=A0 cc1: some warnings being treated as errors=20
> >=20
> >=20
> > vim +503 kernel/sched/core.c=20
> >=20
> > =C2=A0=C2=A0 496=20
> > =C2=A0=C2=A0 497 /*=20
> > =C2=A0=C2=A0 498 * Do not call this function directly since it won't ch=
eck if
> > the tp is enabled.=20
> > =C2=A0=C2=A0 499 * Call the helper macro trace_set_current_state instea=
d.=20
> > =C2=A0=C2=A0 500 */=20
> > =C2=A0=C2=A0 501 void __do_trace_set_current_state(int state_value)=20
> > =C2=A0=C2=A0 502 {=20
> > =C2=A0> 503 __do_trace_sched_set_state_tp(current, current->__state,=
=20
> > state_value);=20
> > =C2=A0=C2=A0 504 }=20
> > =C2=A0=C2=A0 505 EXPORT_SYMBOL(__do_trace_set_current_state);=20
> > =C2=A0=C2=A0 506=20
> =C2=A0
=20
I honestly don't get why this build failed. The function __do_trace_
exists since cff6d93eab00ba ("tracepoint: Reduce duplication of
__DO_TRACE_CALL"), a while before that it was just a macro and not an
inline function, reason why no one so far used it directly.

Both failed builds are based on 4dc1d1bec898 (where my patchset is
based) and there __do_trace_ does exist.

Unless there's a strong opinion not to use it although the compiler
allows it, I'd consider the two kernel robot results false negatives.

Or am I missing something?


