Return-Path: <linux-kernel+bounces-352509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6794992022
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0242E1C20CAB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637018991B;
	Sun,  6 Oct 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3GHxGEZ"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8ED28377
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728237179; cv=none; b=qm6LeOm2Kmm89RdIarU+aCQulRROWmFhz2sMcMwtMtyVOuhkQWEJdzSDTn+xgIyDCvNXVTADrKjALvvBZLEAJhm5Pbp+nJhfTKhtzv5ekwjW92UtsZs548KfQu5vYMRU4Sh7kZTbaz/6era7htSD/X+vn2ykbJFYmLHaY+Uqj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728237179; c=relaxed/simple;
	bh=uCTNLqGYGJBN8F9X0TsRm6AjMi7eTfuDTAZs2gcxcyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEw1sQi5gy305XwYjHEhpUERqe3pSNX2ikzs2Y0hwRgs/G5XfvGkyfqPi7Rv9rnKFDmuJ5YVGeGweQTIsoXKB8G2+e8hnmBnXOcNUpC9NB49mwceXsmMmjeoPWF2el+3L+winQXPMCjtY0etP5k4bH6v7ivm5n8faneOy/F6/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3GHxGEZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dbc5db8a31so27793527b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728237176; x=1728841976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fRmbHG3KTWcHELv1H5/kg1uMVewLUgezzMCppUgp7qk=;
        b=W3GHxGEZNDMwRGlzKbubL1Xfok/NRDjizkQp2Sg/BCFB7If+jyb6ghYZ+YvNxzX7uR
         jxJATWd9zM1c5uoxJVYb+VMdRABZsd2F28i4af/84sht2z519jLvbZC1fdEBW+RA055s
         jmMuMmOFTdInYFKxCT5NuEM215/T53f1qwGWHvgo+N1km7RuG7n+RoE4JUde55WKCbfc
         h6Xbf+qwLv4g2dS2qccKeee8MX8a3XycQVRT6AOlzFviHTRpFj1877bDHoPo0Yn+rEzp
         92i5FT+/PSNA1aD+5DpxtWdbdk8JKXsNYAvo6YPRioza+d+iaZ0NhGnQSl23ZyOY2Pdh
         kGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728237176; x=1728841976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRmbHG3KTWcHELv1H5/kg1uMVewLUgezzMCppUgp7qk=;
        b=kNKjyXSNBZZYO1L4SxkONks4+1x04apBEPhFquvgnlQfZHOm7KBYCJqNlZ95iCqta4
         CGCBGx36jA2rUpX2YexWn/yU1cHnOvPcV8YhxeQ+cW9JoOppLOY2d8+WVXtMlKVAxysh
         /Om9Dte19xLPXmqTMEc9bmi9iqCp9mdVNTnpsz/2WCS3dQyFySyTV/0hDzB5Yr4rMaQW
         nX7p4TajqUFtoC10LsMatC5DqqoZa9TTqJ/mmiNtarRPeiy8tgP2PhwcSgPRioYB1EcC
         B5BLrx63cLuTqp8ssy1SQ64uwRNXprZ1APVL4+fqoWb/oaRLMRhTZDKuKT0lMSfw6FBa
         y3ZQ==
X-Gm-Message-State: AOJu0Yx4ryiUry/UjYtkyzDCfKGiZ3W1tqAc9Y8UV1cq/xys95S5oE12
	SNvELAXc2OBJyRe3JeSBsJFziG2Co3dOszCETRVWSSvb/eumjv7QwHZGeAdS5FWTxVCyoe3OoZN
	As1dN+AgCHISEinLBIHp9baSfLUU=
X-Google-Smtp-Source: AGHT+IE8YaA8HEQyMZgsUgRyeL+AwEhcNAm6/PndcUFQtq1TcbLlsm381l72S3hbT+eqRrt8JwXbU7EhwVC87UWN+rI=
X-Received: by 2002:a05:690c:4907:b0:6db:d221:b739 with SMTP id
 00721157ae682-6e2b5350533mr93012167b3.10.1728237176328; Sun, 06 Oct 2024
 10:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006145727.291401-1-luca.boccassi@gmail.com> <20241006172158.GA10213@redhat.com>
In-Reply-To: <20241006172158.GA10213@redhat.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sun, 6 Oct 2024 18:52:44 +0100
Message-ID: <CAMw=ZnS1GTC9RGQCeTqB8g2b78mFXi4zLfg6bumrp+zmgx0VXg@mail.gmail.com>
Subject: Re: [PATCH v5] pidfd: add ioctl to retrieve pid info
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Oct 2024 at 18:22, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/06, luca.boccassi@gmail.com wrote:
> >
> > +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> > +{
> > +     struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> > +     size_t usize = _IOC_SIZE(cmd);
> > +     struct pidfd_info kinfo = {};
> > +     struct user_namespace *user_ns;
> > +     const struct cred *c;
> > +     __u64 request_mask;
> > +
> > +     if (!uinfo)
> > +             return -EINVAL;
> > +     if (usize < sizeof(struct pidfd_info))
> > +             return -EINVAL; /* First version, no smaller struct possible */
> > +
> > +     if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> > +             return -EFAULT;
> > +
> > +     c = get_task_cred(task);
> > +     if (!c)
> > +             return -ESRCH;
> > +
> > +     /* Unconditionally return identifiers and credentials, the rest only on request */
> > +
> > +     kinfo.pid = task_pid_vnr(task);
> > +     kinfo.tgid = task_tgid_vnr(task);
> > +     kinfo.ppid = task_ppid_nr_ns(task, task_active_pid_ns(task));
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^
> The same problem as with "info.pid = pid_nr_ns(pid, task_active_pid_ns(task));"
> you used before. You should use the caller's namespace, not the task's namespace.
>
>         kinfo.ppid = task_ppid_nr_ns(task, NULL);
>
> should work, see __task_pid_nr_ns() which uses task_active_pid_ns(current) if
> ns == NULL.
>
> > +     /*
> > +      * One last check before returning: the task might have exited while we
> > +      * were fetching all the data, so check again to be safe. */
> > +     if (task_pid_vnr(task) == 0)
> > +             return -ESRCH;
>
> Well, this looks strange. It would be better to kill "kinfo.pid = task_pid_vnr()"
> above and do
>
>         kinfo.pid = task_pid_vnr(task);
>         if (!kinfo.pid)
>                 return -ESRCH;
>
> at the end, but this is minor.
>
> I don't think we can rely on this check.
>
> Suppose that pidfd_info() runs on CPU_0 and it races with __unhash_process(task)
> on CPU_1 which does
>
>         detach_pid(p, PIDTYPE_PID);
>         detach_pid(p, PIDTYPE_TGID);
>
> Without the barries/locking CPU_0 can see the changes above out of order,
> so it is possible that pidfd_info() will see task_pid_vnr(task) != 0, but
> report kinfo.tgid == 0.
>
> Oleg.

I see, so what should I do here then? Check both? Or none? The caller
needs to verify that the data is still valid at the point they use it
anyway, so this helps but provides no guarantees anyway

