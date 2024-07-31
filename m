Return-Path: <linux-kernel+bounces-269968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCAC94396A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986A2282C12
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532216D4E5;
	Wed, 31 Jul 2024 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3e6jSsH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17821BC4E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468771; cv=none; b=f1eUAdc5JR5tffv6TYi90tTSiQozThG91qRvJ7s2vLz9A1AUuryZvw5v/vfUAbT58iMlAaxy7s6Snb0CBDBKl/IpEESZZYAXm62Op0hb7AApoOaffjLrgkn9yytybgEeideb/wFJ49sTuwr26ZBoC8QUmjffuIr/sO3FRejevPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468771; c=relaxed/simple;
	bh=E9q8OYxw+rO+xxd2AkVtRnqTYU4r6hlWw/Rnb8cryi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrTCsNv3T5flLR+++cANETCWy1oPKhxZ9OcM4nYCoKiMW1WzuTd/OlUvxCNhUf8Jeb55zfo0uErz8nA/fS081ZUqWjtRroFTGPNXuHLPbc9adtyNKMKQf9HZaDL3WiLNcCkjiZ+I2yuZtB8u5C6GSM10ZtwNwe3C3a5coGigRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3e6jSsH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso30343a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722468766; x=1723073566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9q8OYxw+rO+xxd2AkVtRnqTYU4r6hlWw/Rnb8cryi4=;
        b=k3e6jSsHjpOkC7idM0E/C5KZw9JBq6JL22yEa1rzMJLJaauIv3m12K3dCnFX2Q5u9l
         gf38bNLHbOdrkmkQRBdkQQ26rySH7MXVxTuvfw7e3pHJVmHYfZFZ6NUVuJnTb+yy4aeC
         PRRyUkzFs1fV5cjf5QLxqNLig66oASoOP6lvwI0ol3LH3ZAi/b/b2Vi7hO6vJfvSUeiC
         5lIZwzlmXK3B4kkmVB0e/Vo3W8TsHaZpEeuNcDk2FVne3nyPR2fq762FbA/6TiNj3lJd
         /ZfUWngA7Oo3JE1UPmaOkb88vS5401om5gG466SmQEX96p0+HuQmMIX9zRspcXYGCix7
         toMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722468766; x=1723073566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9q8OYxw+rO+xxd2AkVtRnqTYU4r6hlWw/Rnb8cryi4=;
        b=DvUIjDRAkoMCGNbmLxogsE8sWvhkIUha1+PnlRZp86TQj3GePVADZ0McP/S8Su4nRW
         dIJnezeQHTCrsqpizJLOTb5lqorPC1kkX6Rt4ZBEpcqv1/7/t5kfjo6Z6Du6ud5Z9aRh
         mNlFHy3zlYN76JtavjIQ/Y5gyYsv8BKHuaxFQoYpf+0iQI7gdEphsMxOnA+DJcFbQcJm
         6dBKiVteHq2bv8HOLgFTt10w5YfIYTGgWkBPFqzhu6ogLbLu69Hylh/7+/35jebIheID
         bgwTiSo+wYXmRW6V+igBwpyrytkbaOZmCoQMuXb+28M6YO/hp0k821ZQ2QpLXuV7wyMh
         rnOA==
X-Forwarded-Encrypted: i=1; AJvYcCUtoDY4HGMSLlngbhIf5z1iVtsR+C0c4yIedbFTPfvH/o+8qjGPSWn+i0tG3PJKjxsrIUcocv6xrS6Ptb4I4CJNV0IMOr28myc1y95M
X-Gm-Message-State: AOJu0YypoyDSODMJiZUwV+YeYT5HiKHidtIJuH6uwnemycHmRziEYCYJ
	8/3J8RlDBv9rhPSJRJ69W25y+6yYx6OmZ0b69gfSI2u0YlHkrwF+AMPP87DHiNDGpOE27ymCK7G
	kFQtTYKQ4g+oDUtYCWuVfivgLFIUv8kJ7VmY=
X-Google-Smtp-Source: AGHT+IH9CTCvpYpRo9RoJMFZn7j5YVM6Z6UL3d1e37/Zqy1tJ16ZnwX3OSlC7mDD3z/o8OzklC4/ZVHigtTOgiYBsAg=
X-Received: by 2002:a05:6402:2682:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5b71e7adddfmr39071a12.3.1722468765836; Wed, 31 Jul 2024
 16:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com> <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net> <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
 <Zqn_0XIcxTpHxswZ@jlelli-thinkpadt14gen4.remote.csb> <20240731113720.GB33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240731113720.GB33588@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Wed, 31 Jul 2024 16:32:33 -0700
Message-ID: <CANDhNCoy+eYJwBcCq+YGaO2OqGav_KyLEEbQ-tMkrQY6UDGSDg@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Metin Kaya <Metin.Kaya@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:37=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Sorry for the delay, I need the earth to stop spinning so goddamn fast
> :-) 36 hours days ftw or so... Oh wait, that'd mean other people also
> increase the amount of crap they send my way, don't it?
>
> Damn..

Yeah. My sympathies! I do really appreciate your taking time to
provide feedback here (amongst all the other eevdf patches and
sched_ext stuff you're reviewing).

> Would 'donor' work in this case?
>
> Then the donor gets all the accounting done on it, while we execute
> curr.

'Donor' is great, I'll switch to that.

Thanks again for getting back to me here!
-john

