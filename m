Return-Path: <linux-kernel+bounces-388647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9991C9B628B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F285282525
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5581E8849;
	Wed, 30 Oct 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/q3N7ou"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B11E882F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289935; cv=none; b=ospZzZdbcWt61DfDDFN2eZfp17we7jpowUQkDp7NNzKUOISIzJhxStRPF1wGOz7sUyce+FwS3UBVBESmaNDnOn3pAgMVlWWbNRxY8kC9S/dwEfsD/n7MvzfYQq9zasQX5ErZA1R/UZ26ZyDljrS9Vj+8TphfQmHiiP690izph/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289935; c=relaxed/simple;
	bh=s2jIZKjVASSagWv7J8y2mCoPBBGL1TgH2aw6o/mzsms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sk/RXOO6YwKhsqfi+g8MWplUXBdl0ixkyxFLEY2+kZ69Flg+72hz+xpYY0jVentdIgWEiEJxfQ8qsfJzBrFxCEKfFF3pLjc7Ol/+s0KjifwCi93F/0Wtf7YVCKS/wzEDDUyitSizZTyUnoZkxZA6/9Iiw2uUBgQXfItgXfp+Owk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/q3N7ou; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730289930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zN9Omir7RGktU56FM49D9j8ooMAVlCcEhdMTzZ3iJDM=;
	b=N/q3N7ous+sZt/NqO/3gLq7xes7a6VYv+yopqr0uPd1DiStCc66ha5UKxKVWc+Ol0prHlh
	l9BhNqoe1aQo744z+IL6ANhFpR/c5bC7RDgYvCjTxjBtTLRF+T0JAxsYdhyyI4I5N15OH0
	NOcr9UA3S3dDk/e2JAL0MSkviC5MrJ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-wf9kK_iROwOT5G8NK4JtjQ-1; Wed, 30 Oct 2024 08:05:29 -0400
X-MC-Unique: wf9kK_iROwOT5G8NK4JtjQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314f023f55so48931105e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289928; x=1730894728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zN9Omir7RGktU56FM49D9j8ooMAVlCcEhdMTzZ3iJDM=;
        b=MF/t25n4KijA190La8xP5KevTQtfD+nMBB23HdhA9WmPWBpzCMrvhND5szS22p4f4b
         68bp/cQDNd+fJpOc8Cg0fhw3Jmv2v/y4FncaDPWGXsUn8FctPvTtvCJq/x6hKLPzC1hZ
         VyOfpuRir864+yCbZM0fre8qIg9rfHg7l+sSz7ihLnkyUZ6nYmlO6YFm0lexhYY9BOXE
         KbNGlrMzOwnxmHxtA5w/zxPfHXgoduKhCCVHEkgt9zPePvDZ8LCrlFkhwupbzZI90gdE
         hSuRQBLyFyokAsMBGo4m2bmrX7sd/BgtmbOknNH7nNthsIxG5uR7p/HKZAYlklX311lb
         BAnA==
X-Forwarded-Encrypted: i=1; AJvYcCXQV+VWdCXALRJrj3C8aoM72MD3DmpvR2ft/3+bFVR8LkB4OIzSDxHrlbUglKnYx9ySyTx3TNugoXFeNhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4WNiKKhCkVNJO3BHDs2EgF4r80xmVNRDGFwkmlUm8HJib6Um2
	Xv8MNUZkqzssWjgV6O5VGHbSb9+pa7wXGuwiiD1nSlr2/xT/hEmYOES2ans0Avg9pAWsx9BY8He
	0QMbCumznmaD9v8fREnlxQiNiAfMWPefYrHaOO0A1j4hnOIV3T2PaJXenzEQA/nsY8QH616KxzO
	HhCHglZJNtdNvjpfaI3PmsF9RT/wvBnEdvc4B7
X-Received: by 2002:a05:600c:4f03:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-4319ac7078dmr138182495e9.7.1730289928262;
        Wed, 30 Oct 2024 05:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPOcTvI2OpHfBdeRHGM/CwVAnnPo4nT0ZvRaeeOvD/HvCljKuLnaVP9aPLTQINmXKlAk/UDwLwIy9SKX5EhrI=
X-Received: by 2002:a05:600c:4f03:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-4319ac7078dmr138182275e9.7.1730289927895; Wed, 30 Oct 2024
 05:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyAnSAw34jwWicJl@slm.duckdns.org> <1998a069-50a0-46a2-8420-ebdce7725720@redhat.com>
 <ZyF858Ruj-jgdLLw@slm.duckdns.org>
In-Reply-To: <ZyF858Ruj-jgdLLw@slm.duckdns.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Oct 2024 13:05:16 +0100
Message-ID: <CABgObfYR6e0XV94USugVOO5XcOfyctr1rAm+ZWJwfu9AHYPtiA@mail.gmail.com>
Subject: Re: cgroup2 freezer and kvm_vm_worker_thread()
To: Tejun Heo <tj@kernel.org>
Cc: Luca Boccassi <bluca@debian.org>, Roman Gushchin <roman.gushchin@linux.dev>, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:25=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> > I'm not sure if the KVM worker thread should process signals.  We want =
it
> > to take the CPU time it uses from the guest, but otherwise it's not run=
ning
> > on behalf of userspace in the way that io_wq_worker() is.
>
> I see, so io_wq_worker()'s handle signals only partially. It sets
> PF_USER_WORKER which ignores fatal signals, so the only signals which tak=
e
> effect are STOP/CONT (and friends) which is handled in do_signal_stop()
> which is also where the cgroup2 freezer is implemented.

What about SIGKILL? That's the one that I don't want to have for KVM
workers, because they should only stop when the file descriptor is
closed.

(Replying to Luca: the kthreads are dropping some internal data
structures that KVM had to "de-optimize" to deal with processor bugs.
They allow the data structures to be rebuilt in the optimal way using
large pages).

> Given that the kthreads are tied to user processes, I think it'd be bette=
r
> to behave similarly to user tasks as possible in this regard if userspace
> being able to stop/cont these kthreads are okay.

Yes, I totally agree with you on that, I'm just not sure of the best
way to do it.

I will try keeping the kthread and adding allow_signal(SIGSTOP).  That
should allow me to process the SIGSTOP via get_signal().

Paolo


