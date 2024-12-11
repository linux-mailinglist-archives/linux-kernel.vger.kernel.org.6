Return-Path: <linux-kernel+bounces-442332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128459EDB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9091689EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46BE1F2390;
	Wed, 11 Dec 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOUYG+Mx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8C195
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958877; cv=none; b=nYS69o92pPqLimbjmDru3EniR3Q1odBODxnzC8+2Y9QAxIGfpKVhesgzxnmn/v5eBre5a0eN7S9f65SSk+znKa6meviF1DWgqERKqev1hlAMSJ7M3lIIdG2HTvyV83H5dcHWDK9Vd91W4pA1e8eUJM+mVBGNOWgiiSKk+05CsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958877; c=relaxed/simple;
	bh=WrNfaLLMK3uWC1leCYvhijKU/AyCY0tnfOj8dWBChLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp6vMTPnF1PiWEcD/uRLGhrlF1tWbfX/LOpKYgJOtjyw+n+APp5vbtpB+wRz3Ulc68Bjv6KFbw7DUvqiINmGgonK2fWYiAgRuk6Fat37/Y2ZQ4PvZenRETdtfcedPDjmqsml04hDlCnVuI5vgOfipsPLRwQmeVIKT7uZWMncOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOUYG+Mx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1411277166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733958874; x=1734563674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lyrwn/8iC91fqxvEN4VFGVfM2i80Tjda+ammClFpARY=;
        b=NOUYG+MxDTMfGRKkAPzHOyofWQMGn/5aakOMTvddwRKmwG3aQqS8aX3g0Cojlx0M0z
         U/sdmp0EurlXXBTRkGK8kwE3pOU4ccViw3rblyiBwTvM1pXy9imyr1qcTxqc0RjxLuq9
         wygY7j0xA/98gSeq2wkiYZIW2ElsYCYaBC10YCXxvHS+QopaVFnrhHNsXPCUNIkXs7Nr
         hgwru27vRn667Q6cdS/o6i47f9TKdWJy7xzJmV0Vp0O8Ypm2ddwiEw/c5ein86ev+v76
         IEF1zgcEkkru8Bcjq9692hDt88eTnOjwOAUkzeeUh3prUEhfnFrfcCILzlpkQrcp/HNv
         tv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958874; x=1734563674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lyrwn/8iC91fqxvEN4VFGVfM2i80Tjda+ammClFpARY=;
        b=U5FpLl1xqkBXp93h8GhQmlOJvT/KbX+dEefu3SuhnpTPrDG3cs4O+/05amaoETFHHf
         T6vklnBcSNj5Sbq+lIX9KDxjHhFDs3u5RfsX5pF9kNP6ddKVfLSYskVk9K188kg1zzGM
         rGmKt4iRugTv/yetU+2bUlSkYoJ5hDdMXVyznJTw4LQZGm2K6YW7WyvUOgaF7ZekFnMl
         28VpuLkTTqKy9tzthRGgbT33TA9kzv+EdwE/B0PhuH+fIa8JIq96+zsONBLRwa1mhcOw
         z/ONU1BmU2IMZvGbmtpR5Hd5MXia8BxCaUnqadg/YNhEp65C6PdJp7knHOaK3CjknLJU
         vI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3DLEROQPUD78v4TgLpcpzCDVNNTVjgSS1F5AMZgeCKeehssGB1i6IDgRV8pWjHY/jmxIFxOGdEhoPGHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3y5TWImZKqwICi4u0qpQYNlW7kmlxfr5F5rGAgJ/c+uPChGwH
	IK1ihDmbgGb6h08zxnsPG37EjDad//kZ1yFG4l5QhRuPbFo5JgD7fOcy0k4tMbA6Eoy8CbczhXV
	VNA5mDtjncvjsy2HPuQYX2H13EFEzJa0W9NM=
X-Gm-Gg: ASbGncsCv6MYbe0mdNyljV5MZvh+UD4/dW+QBK5rwoPBaNFRQDLZG8IdLAXNNo2e8ya
	bfmvYnhjeC7OI97OCc5QgCgZ70+QR2h510Wd5Ph5Z8SRwWXApi0y6q7BeZkGnIDii
X-Google-Smtp-Source: AGHT+IF3XmfEYysIxUvDXnEBTbcGjvh64bFgdS2rcyofdKik49jXRaUIypCcc4ZKueDrFTFW+pFCU3B3eA24Sd6Hj5s=
X-Received: by 2002:a17:907:1587:b0:aa6:6e02:e885 with SMTP id
 a640c23a62f3a-aa6b13b1375mr349607866b.47.1733958873660; Wed, 11 Dec 2024
 15:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211213527.3278-1-spasswolf@web.de> <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
In-Reply-To: <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Dec 2024 15:14:22 -0800
X-Gm-Features: AZHOrDmu8xZLSzl7R7-uGdp3QXt7U4Nui-WfmacvNjW2x7XjjDnf99GuRbQHVl0
Message-ID: <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
To: Bert Karwatzki <spasswolf@web.de>
Cc: Metin.Kaya@arm.com, boqun.feng@gmail.com, bsegall@google.com, 
	daniel.lezcano@linaro.org, dave@stgolabs.net, dietmar.eggemann@arm.com, 
	joelaf@google.com, juri.lelli@redhat.com, kernel-team@android.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, 
	qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de, 
	vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org, 
	xuewen.yan94@gmail.com, zezeozue@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:46=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karwatzki:
> > I have confirmed that I that linux-next-20241210 is fixed by the same r=
evert
> > as v6.13-rc2 (ten boots without incident is the criterion for a good co=
mmit)
> >
> >
> > Bert Karwatzki
>
> Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've just checked v=
6.13-rc2
> without the revert and the following preempt settings and got 10 clean bo=
ots:
>

Hrm. That matches the case where the fix here helped:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D82f9cc094975240885c93effbca7f4603f5de1bf


I'm still working on getting a minimal delta from your config booting
in my environment, but in the meantime, I'd be curious if the
following reduced revert helps?
  https://github.com/johnstultz-work/linux-dev/commit/60c60f85670fb1f4708ad=
be55e15ab918d96f9f0

Basically just trying to clarify if the problem is moving the wakeup
to the wake_q or if some other interaction (maybe with the
preempt_disables) could be causing the issue.
(I'm assuming you have 82f9cc094975 applied when you test with that change)

thanks
-john

