Return-Path: <linux-kernel+bounces-316857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C2A96D644
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0501F238AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2A91991C1;
	Thu,  5 Sep 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjCBEM7Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D3198E81
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532735; cv=none; b=egLXf1cN0INQg0xwrhQ4W2EhWi3lCjFEpZQRFlIZ93NABxZGm+ng9oNRZiIkOULIAsX0NLgRXGa2CEhoWiO7WZk9zqQzIfTGnyJ2IOAv2Vvm0AM1nkMwxxR6+IGzHyOYvHlGiM6Cn0/aTKLZ6Y5gOygG5/edBzBryPPBQ2qN/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532735; c=relaxed/simple;
	bh=5eaa+rSxz7RV4LJNTlQaXt482DTfawXdnh2HOEs2v/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZGSnRfCh5BxB88nzkEYtmw8lhbR0Jjn0JhH9FmR4bzuohbyK5K/1Nqvlt0/JqomXzvmoG0qW49OrCVZROfNfXM/K7TwnLwFro2mWNsE91s6ZxCAPzfp0ys45i/LYEDhpttOdbKw+Z+mi9hMhgNwpX/dlfVRTVQJaeBpO3+1hcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjCBEM7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725532732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wV7mzlpoDJEIgZcv8pSkUgGLoTQH8N21DlR4ywl2M0M=;
	b=fjCBEM7Qo4D3M0BjFvdOLO8ovU2KmsEZY/JHVpqqsAr4zzkvjCp+Qfco/zcbl0HBCYrOSm
	LJJagnT+k1RbqAM0RhVBTqxtzxmA/7rADRzQVlSf5d1glMHecSs1FgVMxjt5Pr7NpJhBHV
	41o2bh6bMIDZW2yEN/KtpfGYv1z5X5U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-qWnJqUm3OxKOPYque_t2Ww-1; Thu, 05 Sep 2024 06:38:51 -0400
X-MC-Unique: qWnJqUm3OxKOPYque_t2Ww-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7d2d414949so72420866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532730; x=1726137530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV7mzlpoDJEIgZcv8pSkUgGLoTQH8N21DlR4ywl2M0M=;
        b=kQ5KQlmyKFrJKUHyMTqYfH91WY9YLzElO8AeetA8cKhkRo0JtTw8MYP48lznAE49R/
         8QMPIx0LMyQViiIzuT0cXeyjZme6AILQm944r6b0D9M0xhzxbsHoewCk/Kf+GxAGI5cE
         my5XQh1h6Z715BRzqEu+1lZtkIy2rSm5egwek3bTonIOgsODJWCVftAIL9tK7Z9NTUSv
         uBerOWdu0203cMGP+anCH8GSqnTQSX/q2SyL2vINFqaKDa4QOjziA1Zb0pSzC5FTdto7
         KKk7rQUi1O4TZLqyEn9SiS7WtTGFhUelzc3BIEeGPgsZEmcjltgCChkxauD9HH8c48fV
         bAzA==
X-Forwarded-Encrypted: i=1; AJvYcCUCOzSzakB6TOoG2QQkM7pmHjfZMWwnASmnCiG4PDAUhNjSGysonHgFDT5jooeg2xA2os2KPyXtQ4P1NeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1/KVuHM7bb7SwIxKzaVXe6h6f0kIR+E3wbO6zxJdqnBvKyq/
	RzVfAHkvOu5b86u5tr9AqBoq4xBu9A936Mj4fX8HT0QoEHwqLNJU1oBcV4ZVoWLLciEPpshIyRd
	iokoBVuwsQvmubSNJvSDHQWhYSI5BDgg4b7G8wiX59ZAB0uYmypN6G1re4tS2S29R0kv3GRyloq
	w2axvS89zcRlBV64ws/XuQ7k6Zr1aJBFKB4mlO23OQsmNDmes=
X-Received: by 2002:a17:907:7e90:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a8a32e72ebcmr610762866b.20.1725532729772;
        Thu, 05 Sep 2024 03:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE98kyXo3s0NnZGdnqKCaiXTRoquo7eiLgNbREY5yttSLKxxqdUm8L/2aoPfmxvVVbNnuPcjPl1DZFVAQgZavU=
X-Received: by 2002:a17:907:7e90:b0:a7a:a138:dbc1 with SMTP id
 a640c23a62f3a-a8a32e72ebcmr610759266b.20.1725532728703; Thu, 05 Sep 2024
 03:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home> <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
 <20240826132620.1618d201@gandalf.local.home> <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
 <CAP4=nvRfkZ2CEbFv+MFBXikZ_p2K-1uucgkdgp27JeTxe58qhw@mail.gmail.com> <20240904102104.6f2a35af@gandalf.local.home>
In-Reply-To: <20240904102104.6f2a35af@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 5 Sep 2024 12:38:37 +0200
Message-ID: <CAP4=nvQPPd5nb3ao4tc9dCyd+fy30wX6=dziFEJ_AyaJOpnCmQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 4. 9. 2024 v 16:23 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org> =
napsal:
>
> When running my tests, the second one would end up deadlocking and
> triggering lockdep. I found a way to do basically the same thing with a
> cpumask and no added locking. I'm currently testing it and will be sendin=
g
> out a patch later today (if it passes the tests).
>
> -- Steve
>

Oh that's unfortunate. Your cpumask patch does protect from timerlat
trying to stop a user workload thread via kthread_stop, but I don't
think it prevents this race in the code from the other patch:

static int timerlat_fd_release(struct inode *inode, struct file *file)
{
    ...
    mutex_lock(&interface_lock);
    <-- this can now run at the same time as tlat_var_reset(), since
the latter is not done under interface_lock in the latest version
    ...
if (tlat_var->kthread)
        <-- if tlat_var is zeroed here, we still panic on NULL dereference
hrtimer_cancel(&tlat_var->timer);
    ...
}

Either way, the results are much better: before, the kernel panicked
in <10 iterations of the while loop of the reproducer; with the
cpumask patch and the tlat_var->kthread check patch, it has been
running on my test VM for a few hours already with no panic.

Tomas


