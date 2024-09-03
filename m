Return-Path: <linux-kernel+bounces-312959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3D969E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFCE1C2378D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28931A7266;
	Tue,  3 Sep 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToigPrgc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A881CA6A2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367680; cv=none; b=MrOocBbRzzWX5aIy2B/XXcOUnNJekt6d5mb8q24mcf/QOX7sNVpr6A026MKb1hd87kYPs03GNkBkaJQW3XyK9wgY1n4VWisyEjJt/zIErdohZRAk/mmGbBWXpydjGiGJiYI5/e7n2fxtLVHmrlKw7+ZlwVexOZXffwsVRtDT5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367680; c=relaxed/simple;
	bh=38nBdhN362xzFrHx9c/SvDQTiddRNmNAVsbB48MBuY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocrS1m/WMDWXUgMDPAErIZ0k8HyMoJONdYsC2R3Mi88JjzeC67gJL1ZKJ1QnLDr5hG/1bkD7UDb9hDwy+9hhD1VucOW7leJHziasBbTKg+aztpR1x2V0PiK0c4c4jZy0fAo+a7jLqzon8pN/L0jnzLmYj+LCh7bRSzQVm78H2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToigPrgc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725367677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4iuXyfKhiI8SVaO+kKMaEMJwXrp+yyDs1DdjgoBNm8=;
	b=ToigPrgc/vkrY5nJTrH+YHTMC7x20lQB46cpFmi61x3cj1+vNboX2hDXw7ygwwbC5mmsh8
	4a+pWUhB390e334LRmbKA0O7q4c+TdR37/yc/60sDTRCX6bTocQGLb70qOQxgxzkKQ6+FC
	3VtdUNcbeS/xXKsiSu+KjyO7EqlVglo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-SIFmmIfxO4W9RU5CyovPag-1; Tue, 03 Sep 2024 08:47:56 -0400
X-MC-Unique: SIFmmIfxO4W9RU5CyovPag-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a868c4d16a6so360443066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367675; x=1725972475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4iuXyfKhiI8SVaO+kKMaEMJwXrp+yyDs1DdjgoBNm8=;
        b=P/otApeNcNz9UDWTLHXiJZXKSzK3sz2Lm/6sTDM6Fp6N6EHbF77ymyhPvJxbQO8PNL
         U2CXKd3j22JCMWU0K3YLTwhBJHYZyqCzQ+PsbOo29v5B74/ZGbL40FdEP7Y4+bjpxCMl
         aX68ybNkqWCLaAfpW2j5Rh77B2y56u1EXEaUAUAu/RH9QibAqmGk4ZiNWQLXCeQP9Ixo
         wzk9Xl18FHl4hS4US95dqjpm71vCZzpvrEcFWNuthPZOho2xugNBrf9wnoMHK0xGtN6w
         iIwzOgcpUyDN8+N+U/5yGizeVIcMq1rwxtjS96afcl36wPyTidFnxVk9fatD3K1aK2ZY
         Q+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVo4drNfZ2SGVmh13QjOYfpqk8EDgkqN+KaXi7gGLa0212TSpErFDrwCfRT7S/mfafEIBS+oIdOVALHK6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRhFrvasu1sLVrfWADfBEE2G2axvkvUQD3NwA27+8JISN2D75
	wopXbxxeroBBsoxIe9LzNtEW76/fteqgeC6dNXTwCm57UtVZchUDSuX2PC5e2RJ1M6TdGhtPeOy
	V5u2TdvPdvvQZosBNWWYtMx/LdP9+KliKIos6M0S/sVDL/dBSvBr3ifDmcFRiEHsGEmWXLs5rji
	Z25Y+8+e2rAdS7s1/A3qgfZmaFZJ31SIYF47ydrrVmJfhS
X-Received: by 2002:a17:907:94d4:b0:a86:9258:aeed with SMTP id a640c23a62f3a-a89b9729521mr686424266b.61.1725367675000;
        Tue, 03 Sep 2024 05:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEub8oka8LPUWP6yKVSkigULGv+zrIVCG2rIIRYWLoPTZzPEC/tfBPWRqRO2UuQ4cI0EJ02w3kgBfcBOEs8gxs=
X-Received: by 2002:a17:907:94d4:b0:a86:9258:aeed with SMTP id
 a640c23a62f3a-a89b9729521mr686420566b.61.1725367674086; Tue, 03 Sep 2024
 05:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home> <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
 <20240826132620.1618d201@gandalf.local.home> <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
In-Reply-To: <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Sep 2024 14:47:42 +0200
Message-ID: <CAP4=nvRfkZ2CEbFv+MFBXikZ_p2K-1uucgkdgp27JeTxe58qhw@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 27. 8. 2024 v 16:34 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
>
> I think waiting on the threads to actually exit in stop_kthread() is
> the proper solution:
>
> /*
>  * stop_kthread - stop a workload thread
>  */
> static void stop_kthread(unsigned int cpu){
>     struct task_struct *kthread;
>
>     kthread =3D per_cpu(per_cpu_osnoise_var, cpu).kthread;
>     if (kthread) {
>         if (test_bit(OSN_WORKLOAD, &osnoise_options)) {
>             kthread_stop(kthread);
>         } else {
>             /*
>              * This is a user thread waiting on the timerlat_fd. We need
>              * to close all users, and the best way to guarantee this is
>              * by killing the thread. NOTE: this is a purpose specific fi=
le.
>              */
>             kill_pid(kthread->thread_pid, SIGKILL, 1);
>             /* ^^ here wait until kthread (actually the user workload) ex=
its */
>             put_task_struct(kthread);
>         }
>         per_cpu(per_cpu_osnoise_var, cpu).kthread =3D NULL;
>     }
>

I tried a patch that waits on the user workload to exit when doing
osnoise_workload_stop, similarly to what we already do for the kernel
workload. I added a wait_on_completion in osnoise_workload_stop that
is completed in timerlat_fd_release, mimicking what kthread_stop()
does. But that deadlocks if the user workload process attempts to free
a file descriptor taking trace_types_lock before the timerlat one,
since the caller of osnoise_workload_stop() is also holding
trace_types_lock. There seems to be no way to prevent this deadlock,
since the user workload, unlike the kthread which has a fixed program,
is free to open anything it wants.

I suggest using the workaround suggested in
https://lore.kernel.org/linux-trace-kernel/20240823125426.404f2705@gandalf.=
local.home
for the time being. Together with the patch that adds locks around
stopping the threads
(https://patchwork.kernel.org/project/linux-trace-kernel/patch/202408231028=
16.5e55753b@gandalf.local.home/),
this should prevent the kernel panic at least until we have a solution
for the race itself.

Tomas




Tomas


