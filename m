Return-Path: <linux-kernel+bounces-177863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A308C4577
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8527E1C20C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1A200B7;
	Mon, 13 May 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V4tbLN7Z"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4181CF9A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619535; cv=none; b=R8sijLJxxbzRtCWuEdKFxNWJFKNHSByNcyhdewFs7jP4FspS/cQfVBP9XrhEIB4S2RAkztQr72MAImA6exE2LwWnzif4HzgW/+92gTfEZMNAck0HNDP7BaUUQ9TKeTvC+/Kpyt8Yum/46OM40w39HkLkQv9JNia22w5W4x/BIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619535; c=relaxed/simple;
	bh=PlOzRXdyKOyYci4EvE5Oec3vI5kKVFNipMrg3GxS1yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaZFzDO3SJ9yHmTO9xVVlXwlo3u1Kd7LT0WPOrvEm6RGoT4XMts/SFlzxeZET1z1Dudt7Ea5BONJGIiot4usSNrAQ3kmzlgAjKLayjRkNt0ToFJjlOlPit0i5csbAQ5d+ljp/Vnbhwq94KxC2fXbz6+WLt1GF5e22oQV+wUXYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V4tbLN7Z; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6792ea67dso34728651fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715619532; x=1716224332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QIPkiYhi3hX3pVYh4/Y1KE+AEhpcFZd9Zg9lkKUtFLc=;
        b=V4tbLN7Z+qWK7EWkeP8GyhmF7q/klMgj5efkvIGi/vHa2mF52czRDwl5kQHMGSAN8e
         a8FyVOWpTirlIxTAIi+4jwqW4/l0JolGcYvxgGzw1WBOTnpx/qJkx8TvYXo5BOfQboqo
         R6Gu3MhopxUI3fAyl0r1g/t5y4wbTKRg2CDW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619532; x=1716224332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIPkiYhi3hX3pVYh4/Y1KE+AEhpcFZd9Zg9lkKUtFLc=;
        b=m0TaB5AOEwPoD66ZoyRZ4bEgGsb19SLdX3Ezaui2fgKZmXzXbtzPGhrUXqzfdIcDjt
         QaiEPw0Yhduoja7fGP/NSWJUyRmX/Gt9jXI8BufI+4sm1cxAnQvh6amxX9XFFNXUEBea
         Ew9zBekLlWL9wCsKCUEsPeeTV3RN6nnub7G/ftC5+KqoD0/9Pf3OgVMhYdo8dR82gq6B
         PINKN5mzcxQ1gI8EYGuD3jqO1APXp/ryQfoqrbUE3byNZ1iQt3q7O2TYXG1f9fIPZuf2
         pIkQRG4mJJrQdTGvNkgryW3JnUzrtVOKRKy9MRsFKFv0T3ByWQLKvvoxhx4Z8KyNrMa0
         5o+g==
X-Forwarded-Encrypted: i=1; AJvYcCULtPXwphXbNB+rm2Oq7dzvOLGdW7vhB6lMouUsvb9kdZfnsTaFFRP37LUbFMQvFrGNDAQuWUm8bRwilxrVT7FyBge+AhMae0dWCwLU
X-Gm-Message-State: AOJu0YxIlYEku/VO/NfkZ0jvXCmHJEtN66yplAZ62iQdKx2uFmyNqbwj
	AJh2pMJnLLrIV+7Bp4ZZQfXuAvOgayhRnlyCHTyPrfSnGXVCYsor++LVVbSLHgVrnye168V4TEQ
	PIhLuPA==
X-Google-Smtp-Source: AGHT+IGXZhgRsPWpRuAlA9rVYaH+j8xvVzOaJnQLw7py9mZza7VE0MAihP1EfKILrWU1AnKgYX419A==
X-Received: by 2002:a2e:9ac2:0:b0:2e0:298d:65ec with SMTP id 38308e7fff4ca-2e51fd45214mr90285721fa.17.1715619532010;
        Mon, 13 May 2024 09:58:52 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e505fde41asm13465731fa.60.2024.05.13.09.58.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:58:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51fdc9af005so7400033e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVs6yH7hBhzyKcDccwL+C70QzmM4WA4cqpKfc50zgctRhEG2ja3l935AAs8Rnus7z3qBWjFTGDIJQjyKT2eRzk1cTx3YH+5C4NTAA/t
X-Received: by 2002:a05:6512:3b84:b0:51d:8842:f0b8 with SMTP id
 2adb3069b0e04-5220fc7c5bdmr12023924e87.13.1715619530170; Mon, 13 May 2024
 09:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510183049.312477-1-urezki@gmail.com> <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
 <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop> <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>
 <925ad012-ba28-48dc-8498-1721954e902e@paulmck-laptop>
In-Reply-To: <925ad012-ba28-48dc-8498-1721954e902e@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:58:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuwC==XgEvcP_vrFrrAoKAOwJXKavr94Gk1tdShFh9eA@mail.gmail.com>
Message-ID: <CAHk-=wiuwC==XgEvcP_vrFrrAoKAOwJXKavr94Gk1tdShFh9eA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
To: paulmck@kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes.berg@intel.com>, 
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 09:56, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Unless you tell me you want it sooner, we will sending this into the
> v6.11 merge window.

No hurry, just as long as it gets done at some point. Uladzislau is in
my keychain now, so this no longer triggers big warning messages in my
scripts..

                 Linus

