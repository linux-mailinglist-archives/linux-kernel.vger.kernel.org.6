Return-Path: <linux-kernel+bounces-349649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C7D98F998
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A91C21A51
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D871CB327;
	Thu,  3 Oct 2024 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WchwMOl3"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EF1C9DC2
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993402; cv=none; b=HamFzrmNPGsblP/FA9nqc+rNgvq5czHuK6xY7iQbJgun4ySurq26CHV1eh7/aQBoXHtuMmbd1Xlm4ZZYyvXIIR2AM0J5+k0QvKE0Sg1sNR1ro+qYzY9Hbrrs4Aoax9vYOcxq4neo40AoMSR5l5eBxL2/P/jCgYB3v6kdwVVQMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993402; c=relaxed/simple;
	bh=RIEY/VvBXBpbOFws0YW9ZSyNHIhNNXGVpnHlXG+8ISU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFcv3HcvKcvw3+c6VUasr3tHpMqGFyjrRvX2uytb4ogTEe+IkuZOC5Mw/sRbOLR/gRZKkML56Pix846pgp1Sa3XHkkBOgR3npgxDpTPsvBmblK+3aDfEKGDR6pn1kUmU5K+kNBOPNjc/KlIMev6IKqtWQRm4dDSZRJZdeqWIjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=WchwMOl3; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e252d1c5b25so1279619276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1727993400; x=1728598200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIEY/VvBXBpbOFws0YW9ZSyNHIhNNXGVpnHlXG+8ISU=;
        b=WchwMOl30te9L8PjAbs2ejtyRADtSvVFtZkunYWEcQ9dYk1iMbJ6xloJg4vEOu+4VM
         YkFYBFYs15Fqo73JHPl00vOnH1rqJIMZQOtT3WA6qRWYWk7YmVXqn4DeWvM1xbFb69/I
         +aAt/ytU+RKvMeEFhe2wXjwb6soevV+5+A2Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993400; x=1728598200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIEY/VvBXBpbOFws0YW9ZSyNHIhNNXGVpnHlXG+8ISU=;
        b=T6fYivO1XO2QVwHkwTemyENxCfn93pgJ59VF7DZ567L3R6lOiDWgpAMCmDx3x9YZ5N
         kjU+gt1BBwrAFS88K90NfmCLgCp6J7ClRPC2wKZ0Y24Ym2rkT56hrKbvDrDUQVmCZwO0
         irTpdQDC54fjGsfaJ37ZzcFQsVCuDlviYLbVFG6DgnPlBbp86eeUqZLtStPcEBwdIilD
         zDNyXPs4XSXLMs6UUXiwUS98LM3VjcuoJLaAnlqusL+KiaFFoD2ZxbeXe3D8gbJksuua
         qwvhGk+b/q/gZvDGu6ayLguPitU7JGsSY7ZnMMN+45oKjGRTD2pgow4hi0BqAa1VwtN8
         3dUw==
X-Forwarded-Encrypted: i=1; AJvYcCXwvEK8zdqpJlW0EzFtZ9zc58/V4g09lw6yUadRq0wd19JKZ5LMON0hSpwu79ISui6AeMjmyMyjA9oRflg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQW4EPRinsqL9+enVUpYBpaYaPAw543yca2fsiCzg3A7T1GxK
	oPmSaq+VQ+AdVp5tONEc22+16AlZ16TSTzZhxbqrNZHESKt19kbO90tk93oYpanKnIRPT9icD+/
	nx9wTv6JH0eR2dtyjeqt6Da5O3lh/6+Cou1trbnVTeDT/txKm9ZM=
X-Google-Smtp-Source: AGHT+IGHUNzUYhVLVAPDGU9H/0WV5ShOsg0ptxWufYbLbDAiDNM07Pwk/MoJ8LvG3kzNc/NTlu+JDUt/1ryUfofqvJ8=
X-Received: by 2002:a05:6902:2b8e:b0:e26:11ae:6de9 with SMTP id
 3f1490d57ef6-e28939561eemr459827276.52.1727993399239; Thu, 03 Oct 2024
 15:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <20241002010205.1341915-2-mathieu.desnoyers@efficios.com> <20241003000843.GA192403@google.com>
 <7cc83ffc-c9cc-4e87-a3ee-bb62588a594c@efficios.com>
In-Reply-To: <7cc83ffc-c9cc-4e87-a3ee-bb62588a594c@efficios.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 3 Oct 2024 18:09:48 -0400
Message-ID: <CAEXW_YTO3AhHAqrA4E_goVbsNB26AdfdShynr-nNMR97AYy6ag@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Mateusz Guzik <mjguzik@gmail.com>, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, 
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, 
	Gary Guo <gary@garyguo.net>, Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:21=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Please double-check with -O2, and let me know if you still agree with
> the patch :)
>

You are quite right, with -O2 I can indeed see that the optimize hide
var fixes it.

FWIW:
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!

 - Joel

