Return-Path: <linux-kernel+bounces-422672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064989D9CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1724F167D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB01DC1A7;
	Tue, 26 Nov 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiNBDnRH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180841DACB4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642880; cv=none; b=XBdXcPoj0o/AFaNIrCiRdTGPpIKWmc70CZObt+rpv29AoOQ6ghja6FXYaV6y4LSnCK5cCb5RqPlkfKAvCSa1sm/T0zAK97fb+WjMiYs1gQ5ahAY+m4nROAgkJa9kH3oa+d2k6aWqtSaa1LatVWUoPpsh2+yhj4ZidH5YOvpRyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642880; c=relaxed/simple;
	bh=2VA5r14k1YmFRvRtLFEcH3a/zWqGggcmq7A2YmH4w0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOjKCbPM+XgkGAYpnqRM2MqZGltw9cLr+3eOUqA6Z6o1C/OyHBivEe/GS4+aitnZyqgXsHRo0rCiX35Tx82qe3Oe1stvV0pqlpUWBX1XFZasOW4snt8876l7hGB0VJs7V6U8SK5fxNmo3IRHHkKJSrOf2F4WvjGzf4GsIRdR4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiNBDnRH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732642877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yy4BXFb6cimidAgaEvPnIiXK/EfHWyMt9+bAsPsgZUE=;
	b=NiNBDnRH2fNQ5YYqDU3UP9PlIfcm2/CDPWncHIppiQaEtyMpyI/VUN4sSWTxcVLWzm5DFi
	lxWcYZOyMHyAWQt3R6PFTdpYAJcvd4gjO/KSgoe2JcZ3DNEpxgtxaG1cxR/58HSn7nCCXG
	7kS+17eJNZME74O0oW2R5F6QdzreX5U=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Un2ViudoPVyR6c6SIL4-Pw-1; Tue, 26 Nov 2024 12:41:16 -0500
X-MC-Unique: Un2ViudoPVyR6c6SIL4-Pw-1
X-Mimecast-MFC-AGG-ID: Un2ViudoPVyR6c6SIL4-Pw
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so65744725ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642875; x=1733247675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy4BXFb6cimidAgaEvPnIiXK/EfHWyMt9+bAsPsgZUE=;
        b=Bgd7lQVgB9ZCI+2hg7p66I3tlQUOQ7SIi5JNR7jB954q2odq+gXZXK2Z6sBJzpF9AO
         6Tes+uws4oDufr8euPag1sb7U+musrgUC5LFkxjrao1+ciiGFNd0yE521DQ4Oit86/uk
         ZeU0h7GaF1rkTQSlXrnmzLxFD5oH7mrAiyfcve4kac6uJWr5XsAW0UDW/9uSsRXGcBt3
         oG85QgDzV6WlxPDIA+VaMeV/dHYXR+RCZgYrLe6Wa4zqCg2gyw5chhgREqToXIZr3Ats
         birri/y9fUNDKM3eJzq2wp1PawDFB4+dXto1IRw1ncrGsy0fJq3mcs/4WPRpfTOvShnP
         Yu7A==
X-Forwarded-Encrypted: i=1; AJvYcCU485udFCjXGfYVEaQ4PG8fYOBAy2Cbihi7TPoKMsPGsy2Rgbo6BIw+4E3qqvii/aKA+Y1q1TxJhQvGZEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59Kg3lT4Gxm5KL7v3n0b5Edq2Sr461q29H+fMfr0X9YH40Tsk
	ytvjaTOc4oreTiAJ50K5PL757GamQDQ84QhlGWzFOR9SdMf9tzsnDFfqO4X/K2Ie/2xdpoJ7W0x
	uS6jGdcM7Oyfd6tScoM/43RY293I72BfOQ4NdHwcXp5fjpAfp9bkkLw/ZvO+7CwQuUzCK2w==
X-Gm-Gg: ASbGnculXdOVT/MQmwrYbipFiSw8TLhzTo8epl9hyxRA6s9e1qykvHrwDIMBxsg+EDj
	X0W2p5jUk6IIWezmR8XUHgbw0HlvOnL5KB7ws2eXnOLNgs2uWorqs7V1H/z/oU+yWTRTzrOKZoc
	MVYogrYtsPu3U5hOgQ0LYSRx+m7og3K3WtMO6z5ZQ6tQivyYVcDL/+P910uN+LBrql4+BogmE4t
	/f6M9ijZT6hkgjvDs6OezHOoYuUU/rL2Dk55CzQ1hkyQy1s4w+fMcgSmiHw9FPIY7EfeHsIwXUy
	TOt/oKw8UWY=
X-Received: by 2002:a05:6e02:440d:20b0:3a7:a3a4:2cb3 with SMTP id e9e14a558f8ab-3a7a3a42d9fmr104815425ab.15.1732642875713;
        Tue, 26 Nov 2024 09:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEung3vr4gfOD06sw0eHZp93kuMsajiVz5nPY5nn7aeOWDKXy2xMKmY5PcOvsXODB/cYeSpeg==
X-Received: by 2002:a05:6e02:440d:20b0:3a7:a3a4:2cb3 with SMTP id e9e14a558f8ab-3a7a3a42d9fmr104815325ab.15.1732642875442;
        Tue, 26 Nov 2024 09:41:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79acb762asm22770595ab.73.2024.11.26.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:41:14 -0800 (PST)
Date: Tue, 26 Nov 2024 12:41:12 -0500
From: Peter Xu <peterx@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Message-ID: <Z0YIOOfxr14tp8Am@x1n>
References: <Z0Ssq15MQd3rimBr@x1n>
 <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n>
 <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>
 <Z0S3isgc-QlEF7oW@x1n>
 <4689f014-2885-42b9-91a4-ff8b8133599f@yandex.ru>
 <20a1d49a-1f5d-4d3d-b59d-29b9791b72bd@collabora.com>
 <2dd0bcee-a594-4de9-b499-a8ad37be155c@yandex.ru>
 <Z0XvwitcZ6ujoV9Y@x1n>
 <3d4c1c59-4b01-4fa3-af84-e2d84f4ebf44@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d4c1c59-4b01-4fa3-af84-e2d84f4ebf44@yandex.ru>

On Tue, Nov 26, 2024 at 07:16:19PM +0300, stsp wrote:
> 26.11.2024 18:56, Peter Xu пишет:
> > This doesn't sound like the right thing to do.. as the fd (returned from
> > syscall(userfaultfd)) should be linked to a specific mm.  If the parent
> > invoked that syscall, it's linked to the parent address space, not child.
> > You may want to do syscall(userfalut) in child process, then pass it over
> > with scm rights.  Otherwise IIUC the trap will be armed on parent virtual
> > address space.
> Ok, thanks for info.
> man page doesn't seem to describe
> the multi-process case, so both fork()
> and SCM_RIGHTS were just a guesses
> on my side, one of which worked.
> Probably something to add to the doc.
> 
> The last problem I had (last one, I promise! :)
> is that if I remove O_NONBLOCK, then
> the entire app hangs. It turns out, w/o
> O_NONBLOCK, userfaultfd's fd awakes
> the select() call with the ready-to-read
> descriptor at the very beginning, long

I highly suspect it's not a real POLLIN, but POLLERR.  See:

userfaultfd_poll():
	/*
	 * poll() never guarantees that read won't block.
	 * userfaults can be waken before they're read().
	 */
	if (unlikely(!(file->f_flags & O_NONBLOCK)))
		return EPOLLERR;

I suppose select() will report that in readfds[].

> before any fault is detected. Then it
> goes to read() and blocks forever. My
> code is not prepared for read() blocking
> after select().
> I then checked and double-checked
> and re-checked that with O_NONBLOCK
> nothing like that happens at all: select()
> is not awaken until the faults are coming.
> It could be that select awakes anyway
> but read() doesn block, but no, its not
> the case. In nonblock mode select()
> awakes only when it should. And in
> blocking mode - it awakes immediately,
> leading to a hang.
> Is this a bug?

Not a bug, but, AFAIU, a design decision.  If you're interested, you can
read commit ba85c702e4b.

Userfaultfd is a special kind of fd, and poll()/select() doesn't always
mean that the next read() is not going to block.  Fundamentally it's
because data-ready event is based on waitqueue, while waitqueue can change
between a select() v.s. a read() later, so the waited entry can be removed
within the short period.

In short, please stick with NONBLOCK on userfaultfd.

Thanks,

-- 
Peter Xu


