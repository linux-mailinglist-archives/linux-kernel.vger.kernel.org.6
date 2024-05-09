Return-Path: <linux-kernel+bounces-174345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275478C0D71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D634E283708
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A814A623;
	Thu,  9 May 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exFw9P43"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3F127B54;
	Thu,  9 May 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246544; cv=none; b=NEcuDhayQKkP4PjhStePPZ8nTHMIPzYDuXHQYuL5MADz+8TXwel9Ic8YmE/CbVDxh8t0WY6D52lZDDz1E7xlGeJykjwzgznDRf0qdmshEgwozoxbdfdpyYKdbdGbvrOCU6g4yzjPLUxIEAR91VXOiwF+vly+RAbH3dpkumH7i1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246544; c=relaxed/simple;
	bh=qCW6djtPf0oxkmETgj00Kr+81wYTNJ9Is5zK5I+UC6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITAbypoYhVykAAGxIqi0TYovLIr1ZTl0mPU//G6RwJzqLO69zGBSc/HUKA5/hVL5qnowXPa8GsAxvOde8jhImBoHdc+7pPRwoosCDnuy0V1xMIwV7K7xpvoO1a5SR3TPh3LP6I9YeDFuy3V8GleYpLCqPU9Rt+dQYpOJ4SXw7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exFw9P43; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43ae2a44963so2488591cf.3;
        Thu, 09 May 2024 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715246541; x=1715851341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMSC96ss4NMD2RoDgjg21x5MWAAKjQcuYtyRz+P00M8=;
        b=exFw9P43MIuz1c3jvJ86TcbKKyfLoFQsVlwM95SSDykpPnO8d4VrL1NTeuKMwDnnD0
         3P+H05/HTJfLz92PmNSkoH0bvHGnINqtZRUmWZgYYvBaTC7YXMHPiV6QGhGx5eLOMCEh
         Pngufhv2OkRmdenwmaiBNU13XJQLdJIOIJqJy9Fu5ttGbU07xed+EtpvA6FBPbVip/2P
         5oULMrpjFjpbKb28ymTqtYzSwO/e93HXgctqaBrrEbAnIuGJguR0+tb38Yn4su8/46+e
         PHUKvBq5g57vclYm7y3ewb4Wb/RxmUh1o6uEqo+KVXKvWd88I8/UvvAmdS6ola/3sfZ6
         r1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246541; x=1715851341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMSC96ss4NMD2RoDgjg21x5MWAAKjQcuYtyRz+P00M8=;
        b=WwrYi/s/G182/MCNlR5f9MlBVpVKoOGOuCiwq1PzDlwQ+p5C+zPi0SU+G/QEl9Z9lN
         4sCv4/yzQTya/I3z1HjUXK99OPKK1mMM5GsuOKHGA7ZPQ1gmWTewbmxmIenp+cp6iVg+
         EA/MSXtIysjLP/Txpoj+9XHvT2k1l+qUgwfN9xM3s+mwaT3dNIgmWUqvrTn3VQkQQKTF
         sLWLmgF4qvmAVdgV212bPTa+sIgw8r96nUcNIDj6jDunP9MnphSSIeyblDWlNCBTX01Y
         9U80s4eDLQ9bDJHPcZy6TF4Afu7YJtqv8mWllnEbMLAmdsGSDSnMstqad+63Gs0uHBDi
         uWCw==
X-Forwarded-Encrypted: i=1; AJvYcCWbfARPWoefhGtbnOywlLsP7FffQq2kbhBWQaQ9Blt6kCur3HWDQSIIjzTSMaszmb5BPFBCDGhsBwHQ2VzC4lPglcgZiHSxmNenzavw
X-Gm-Message-State: AOJu0YxnpOtOpe0uBbSNH8oAxjyA/d8c+vZCcGOfaivvNnvVuWxK6B/q
	QyE5prMdWIen3o8kvETDIJi1X6PyCMvxq4ked6UAPd1ciX5OXslmqqGv35y/RuRnC/qi+oA0/gd
	MAp4q3mPjDiKTU/AnNyAlJXu2SNF/2Zfs
X-Google-Smtp-Source: AGHT+IH3hDWTFWuiGjNr9Nec1hOqCUbbSiF4UxAqi5g5KF22YdT+eKSORCx6kukXCer2KiZwZCakZwBpc0yVlV1LxsU=
X-Received: by 2002:a05:622a:1a2a:b0:43d:f946:faed with SMTP id
 d75a77b69052e-43df946fd44mr2033401cf.26.1715246541550; Thu, 09 May 2024
 02:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508172621.30069-1-ppbuk5246@gmail.com> <20240508192213.31050-1-ppbuk5246@gmail.com>
 <a407d12f-6845-4f51-a112-6bdc17641ff1@web.de> <CAM7-yPS6ecODhv-FQpYE5OE_LufmtKRg4htp9JH6MBUF03N4rA@mail.gmail.com>
 <5886464d-a867-471e-858e-b4ed732a1d76@web.de>
In-Reply-To: <5886464d-a867-471e-858e-b4ed732a1d76@web.de>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 9 May 2024 10:22:10 +0100
Message-ID: <CAM7-yPT7z6phHOUVOMxebRxiqw6un1N3hQK6O2AeRfmnJhK4kA@mail.gmail.com>
Subject: Re: [PATCH v3] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus.
.

> * Will any other data representation become more helpful for the circumst=
ances
>   according to calls of a function like =E2=80=9Ctick_nohz_idle_stop_tick=
=E2=80=9D?

Maybe not in this commit..?


> * How do you think about stress condition ordering concerns around
>   the system configuration =E2=80=9Cnohz_full=E2=80=9D?

Well.. regardless of the stress condition, it wants to fix the
inconsistent behavior
happening when enter "idle state"

Let's think about two cases:
     1. nohz_full cpu stop tick in tick_nohz_irq_exiit() while it runs
only 1 cfs task.
     2. nohz_full cpu which doesn't stop the tick and switches to idle task=
.

Without this commit, case (1) wouldn't participate in idle balance
when it switches to idle task while its tick is already stopped.

case (2) although nohz_full cpu participates in idle balcancing
because former clock isn't stopped yet.


> * How will related changelogs evolve further?
>

Thanks for the suggestion. But I'll add some more background commit
message then.

Thanks again :)

