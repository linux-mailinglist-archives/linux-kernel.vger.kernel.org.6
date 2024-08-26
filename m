Return-Path: <linux-kernel+bounces-301540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668995F247
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B571F232F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4116C84B;
	Mon, 26 Aug 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBxlJI9C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E181487E3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677303; cv=none; b=JijWbhUPypDj81MrHhReciTBhPJup58UD6k0m1dPolrO98wG4Cu65GtPVPj89EcQNeUjsO5STPYKNTbWwser+bSTYqFu1BU+5JevpV0HIxSpvrc5nF0TMmIBfE80rKyRAxjGFNg5ej2ZOE7FBalPiOUB+i/EoPId0mtVWvPL0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677303; c=relaxed/simple;
	bh=2Opw6vNFqtAowmYwHyECODo2kqem1ugNhw4ntDm8Jjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pu8e9LQ0GXwApZLyJ6MBCWTCHYeRZ7/xy2T2BRZs9TgUpSdS6D17Wa+t26BIZxRh8BfyRqGTJN2fN6jwDNV9FC5FqrET16bj3pL4ag/8w11N4T08p1vs+edDCbHLRFfBJXLADvhKQkjFeJ/mxrUzRVliGahenTTcw84sLZ+cBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBxlJI9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724677299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtUuKStDI/TrqAejzoVfdWdlirHG5pbXKKxkB5GlHAY=;
	b=RBxlJI9C5gJfvjPjskNjnu+TF2K/1a6eIsB89sfuHeprWJXLP6oEq425OeOAhHHCTVlWxI
	2rWCpea9dF/JM5+70nXvmJxcdEL0oy9HjONMItvYKh784hAdhq7gh8qYF588fkO8HmzQR9
	7dhSGQZ/1lVs92KhrlRuHfx6hqJuUNY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-bQS3ul0GM4WUq_bVKLCtAA-1; Mon, 26 Aug 2024 09:01:38 -0400
X-MC-Unique: bQS3ul0GM4WUq_bVKLCtAA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8691010836so404387666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724677297; x=1725282097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtUuKStDI/TrqAejzoVfdWdlirHG5pbXKKxkB5GlHAY=;
        b=Fig4FlzZPRwoyzNosP9YUkS+9gIRoJGdqk+Wta+nIinTVXXcXnJ3wJKSSxRCBX1B6w
         SjwZiQmbBsDEZU1yVfrxKs51+wK+7g/XyUaI3GDp8espDFHiqCfX/9KEOVu2PoU+nZYt
         a3RbnZpXO22Egxy+Zj1YV7V5iuyyZHkoidLwzY/TFs9r6YcuQApaez43SRA2YU5Sc2N4
         1h688oTh1/lY9WINJWAXmNEJekbwlCkJdOtblpDlJKIU/y0w8nbguzuzvvPYDXpGaz1F
         yUryO3nz9xtZwWprlCcO83otp3ifli6AXKDrUFroS/GDUBPek5PLcD67/GeTfIJOsP92
         FX7A==
X-Forwarded-Encrypted: i=1; AJvYcCXMiw/JCLeQFjAsCsi7Jpvq2S3Fv3jTZZ3RBW2iyY9E91IY/DOwJ6cVx1bV9JHoj1sDJ1dyJteci73UnYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTcuCRh5kuwwQCJCIYaLc1f7PXnWnKLR1URkwySzLZ0PW9Nxb
	u1t7rKTp+wWpTb5QrcuBqlglb906e7GKhyMrL9ZLbkDYpwkPweuvBnKhiQJ5e2Vf3dQOv7TM01u
	BXqqC7yY7rk0rhCGfxXAp38cDTvPenumVKyEzZ9URl2SBzjeRb5/KG+Or5UMx2BC/GJuZ8lojJ4
	mvIqD1zsgL2pdjVe9zn3EwITmXt9DOQ7K6HXkb
X-Received: by 2002:a17:907:dac:b0:a86:b727:3f27 with SMTP id a640c23a62f3a-a86b727424dmr392976266b.52.1724677296768;
        Mon, 26 Aug 2024 06:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG53fvNxGfjMtYsvqkzmA0t0VlDbb1UXlcCb0hnV4Mk6ey39DNiK7UN5zFZsZLnqKxLsPGZy+PWs1LiyX/NUfc=
X-Received: by 2002:a17:907:dac:b0:a86:b727:3f27 with SMTP id
 a640c23a62f3a-a86b727424dmr392969866b.52.1724677295454; Mon, 26 Aug 2024
 06:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home>
In-Reply-To: <20240823145211.34ccda61@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 26 Aug 2024 15:01:24 +0200
Message-ID: <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 23. 8. 2024 v 20:51 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> Egad, I don't think this is even good enough. I noticed this in the trace
> (adding kthread to the memset trace_printk):
>
>            <...>-916     [003] .....   134.227044: osnoise_workload_start=
: memset ffff88823c435b28 for 0000000000000000
>            <...>-916     [003] .....   134.227046: osnoise_workload_start=
: memset ffff88823c4b5b28 for 0000000000000000
>            <...>-916     [003] .....   134.227048: osnoise_workload_start=
: memset ffff88823c535b28 for 0000000000000000
>            <...>-916     [003] .....   134.227049: osnoise_workload_start=
: memset ffff88823c5b5b28 for 0000000000000000
>            <...>-916     [003] .....   134.227051: osnoise_workload_start=
: memset ffff88823c635b28 for 0000000000000000
>            <...>-916     [003] .....   134.227052: osnoise_workload_start=
: memset ffff88823c6b5b28 for 0000000000000000
>            <...>-916     [003] .....   134.227054: osnoise_workload_start=
: memset ffff88823c735b28 for ffff888108205640
>            <...>-916     [003] .....   134.227055: osnoise_workload_start=
: memset ffff88823c7b5b28 for 0000000000000000
>
> Before the reset, all but one of the tlat->kthread is NULL. Then it dawne=
d
> on me that this is a global per CPU variable. It gets initialized when th=
e
> tracer starts. If another program is has the timerlat fd open when the
> tracer ends, the tracer starts again, and you close the fd, it will cance=
l
> the hrtimer for the new task.
>
> I think there needs to be some ref counting here, that keeps the tracer
> from starting again if there's still files opened.
>

The timerlat fd is not supposed to be open when the tracer ends/starts
again, since osnoise_workload_stop() calls stop_kthread(), which in
turn calls kill_pid() to SIGKILL the user workload, which will also
close the file descriptor. Only one PID per CPU should have the
timerlat fd open at one moment, since timerlat_fd_open() will refuse
to open if tlat->pid is set. It appears that this is somehow bypassed
and osnoise_workload_start() happens before closing the fd, not sure
why.

> This looks to be a bigger problem than I have time to work on it for now.
> I'll just apply the mutex patch for the kthreads, but this bug is going t=
o
> take a bit more work in solving.
>

Yeah, unfortunately the issue looks more complicated now after looking
at the traces you posted, I will probably have to do more tracing to
see what is actually happening here. Thank you again for helping us
with this and also for the patch for the mutex.

Tomas


