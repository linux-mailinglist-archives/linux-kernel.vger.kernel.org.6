Return-Path: <linux-kernel+bounces-523219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE09A3D3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270F7177D46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985A1EB9F3;
	Thu, 20 Feb 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHnU1gcI"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF41EBFE0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041393; cv=none; b=SbXTF7oaquUt//cPiSQxx0nT2c1F0pVjPnA4FNnXwXinvoLxsnyLngCN38oxuAVDIwn/O84d4F8Znt7UiObvxSxtrT5PbI8w7DvJY0ComK8zA7kFC3n1CPxOOhDY67K3G0NFHML5MlrUR8d1eTFfjNktsXtfCBvJLpf9aEwd30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041393; c=relaxed/simple;
	bh=W5nOMo69AdAuvEE/n5g3INk0QAS4xz2MkzVOW/xgTbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiJ719a0EuWedBQtIzMuj1Fdarynmz9Am0Vuc4g1Hliy5sT4Xlhen9wejORkdg1mV9//vpAHxbJDs9HsO1JaASG+cmmcGcwxKLiVQkJnvhG4AB7cgZRk2BwyDjyRIXr9qjrQ/5PAdi/Fy3K4oXOMMzE+MtCvKeq/f9XGMcdg7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHnU1gcI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso1036503a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740041390; x=1740646190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5nOMo69AdAuvEE/n5g3INk0QAS4xz2MkzVOW/xgTbY=;
        b=wHnU1gcIQ0GtMOKWI2c0zMZ5car+vJ3aHSEXo3/2XewcPWKzMfyrvwf60S4Z3JQOqz
         Z2j+vzjR21Xq3ruXlW/GwFXd1uI0VvaitgDPt4/j/igcBE4hLBXD2ee6vP17WwS5BTaB
         Jy1vlJfYeaJvY3YhARPzBD6Ovy96cCYI22Qt0TWoUlDFbrvdjIls5dq2X8e0SV+z8rZ+
         Bu5wKhLJcLgONe+grvyiTPvpbUaGGgzc9N2pBwwxUwxzJYyN+GCQWuFJeombC1Eoy9SE
         fAeV9ytxhr+/ZnT/ckEueEkfaRMDZG3BcwqLkxmZOdt9Gj4DAQnBF3dugHg4if+fCymz
         xg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041390; x=1740646190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5nOMo69AdAuvEE/n5g3INk0QAS4xz2MkzVOW/xgTbY=;
        b=eR2GgFtIYSjPzrbHSp3+R+9INKf25DL3EOu6fkOCC9Wu6LckvocIhfl816d4WkZtDz
         ew7ZqPtcryKHEzp6+vLlsbfh1Zu3FrZwasVOohm18HJ/G/W8WcEYB7pUnvDYRQYNqr4P
         onGq2cCqLKm5UR9f89Vn/f0zBnCyKxnl3xe1uedWFROVZWypNt84PLsqLYSK8jtvH52c
         K1bxbz44TO6kozInuApwivzMpk4HETBLG6GgbsfD/gB8SgAQW5u79kdRRl06y6yKsusd
         rqlrZAIL6RH/TZdDswMAdqgW0SY1lkpRzXMwGjbgRypjZhB/q4wCXXY8q7JX2lXgY7v3
         MdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWreveWzAPz1OASG5LZMlFh7nA3luW+6n9IgyUQLMJVrLrPHllDd9Jp+G9teKmKIduw4azWrvVucp3+EKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNy1ywPni9wQpuQKP37A29jNO2/F9OWrjcbsdnnaTv3jZ+SuM
	Txnq8L+bok/LlVnxfEXyjsrrrvcqau6oB0/cK57ZpBIPB3mbUGPMyoPNtHqcciQVflX/5SPoL0L
	oRVGfEXLEtmMi6EyloDXbePo0IoZpenF5UDnq
X-Gm-Gg: ASbGnctzceLLPcH+9JjtnDcvg/nd7kF8cYB+wu3bmNKxHMsjunL9UaDFX1J1z6YPp0u
	9+SqbgWe3bQK6kWmFehR9Owbj4w3wiXaclQvw+XVL5nMMGGjb7Jq8y5h7wu1tPTsWjq9jXdABwL
	alvLj5M5mvSA61U1wHQk7rrTwymzwrYw==
X-Google-Smtp-Source: AGHT+IEYFLNPrFaEhZIryudV6m426tLnyJJ/71T0N51E/lSmbAZcJywdsPhrDXLYWamZxdThvkbMeHkA70PKPulF75U=
X-Received: by 2002:a05:6402:3553:b0:5e0:750a:5c30 with SMTP id
 4fb4d7f45d1cf-5e089d0bafemr6818947a12.20.1740041390181; Thu, 20 Feb 2025
 00:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com> <20250219125522.2535263-2-edumazet@google.com>
 <87wmdlhwa8.ffs@tglx>
In-Reply-To: <87wmdlhwa8.ffs@tglx>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 09:49:39 +0100
X-Gm-Features: AWEUYZnVkPf_xcMsBuStMhR2ScM3Zy9XfuFIYO22MULTqoL7005ujlAGo8vh_XY
Message-ID: <CANn89i+LJFHhA=VF2T5v_kN0=sFLeropuRERnhWdadj5w6kiyw@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] posix-timers: Make next_posix_timer_id an atomic_t
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:09=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> > Instead of relying on a global and shared hash_lock
> > to protect sig->next_posix_timer_id, make it atomic.
> >
> > This allows the following patch to use RCU.
>
> Your patch ordering is slightly off by two :)
>
> And it fails to explain for what RCU can be used....

This is explained in the following patches.

If I add nothing in the changelog, you complain the changelog is not
explaining anything.

I suggest you write the patches. because I feel a huge resistance,
which I do not understand.

Thank you.

