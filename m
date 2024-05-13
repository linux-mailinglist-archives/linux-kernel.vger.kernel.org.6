Return-Path: <linux-kernel+bounces-177848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A78C4547
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C919C287167
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32083199B0;
	Mon, 13 May 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U5ZClxxE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07411864C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618950; cv=none; b=IFbDFl7wUz+/ehVtEtnw0SSsKQbAOCpNScrmaujNDwsTRnAwL0aiJ1+emLzRQoOlyH4ZYpDQg0Q0ucm2/ELv9Wienx+u65O/0xncV5r1JQGwg3kfPTIG/NMQLAdgBV7lW9/WRtEgt8p9ZyISmQ+s2Jwi2ewR8mTpepehk+i+xcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618950; c=relaxed/simple;
	bh=7HJki1UM4r909Ntbce/v15mbZXUH12ohnP4FbyjkcBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8ihuh02p561WeKLPU5WYZJGd90IPnMEIPBOLM2Nk2y+FbUHYW6iZ0V66hHjZmlwWZ2xhgfhOixKMrF0Iixx28KdQe0mEzlb0Q6sHCCxr3rOLCD0HmnH0n3BJBTtEU1rSnKOI5gGRn5Cs4QopInk87kQu0jg+C6Ep7fLYBQ9B6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U5ZClxxE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso6272706e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715618947; x=1716223747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HwX85Cc4Z5UBCMlHC2NISB9r0JBio+whHTW3qGBLXLU=;
        b=U5ZClxxEWRAApdgDDB03NRWcqR2vhOdmj2/Bheul+BEF+V2d8aaW5VBxo32cRz+QGu
         6x2fu6dxwjUKooFQTuZYuOF6t0vkyKE4jdsNeAJVq6aUzUnYUzJuruIVF6luaecBZNQo
         o6wGHpTXkCp2BwuR7mfZT3aSslq3vG59LDXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618947; x=1716223747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwX85Cc4Z5UBCMlHC2NISB9r0JBio+whHTW3qGBLXLU=;
        b=mI+EtryP9VusITe9f0CNrhJlRp94NtYqNBylUonX0lXF5hegbfICH93j5KbVqvVYud
         3ryqcGhXVU04CERlS9KeeMyRK4wo6tONPiPwL3Ai9+jBoay6NnOfMHweHtt78Ne52FKo
         4pLBTZB8G/QFWu/GjotePIN7c7rrZPMyIrDQV/RWb2JNytA3GRGXpLS1KzNmNLTluIvi
         i9+Ftxexkb4j9CAzmpdQrUzJyx87+vLr7YhART3KUU4A2evwJiHkxPN0EfIcuTitguuG
         tu0czCxGUQmLwgYwPcxfSwtIREllINga5KdtHe4MAWMXl/9YOVpdNp9BsVN8GMG4sIfh
         +0JA==
X-Forwarded-Encrypted: i=1; AJvYcCXdivdOV6FOjLVe8bszWge3KaCztbGYjxxcN767WAPsIydGGOuqp3sWPsuvGcl3aoqh+Y7jEL/yWzHaCd9d0RLZnFmJ2jmIJ1QHb3qk
X-Gm-Message-State: AOJu0YzT6h7jHluBZYWk8/tH2eAJzZk1vs9lb2Jkxo/bXu/pR/+iWZQG
	AFYNqi/j4dU4ZcJj0rzCcMX15m1krSmJHvHt/eBPgIDKIOHGlFZ7rIEHEomhHhB/QLAGBvHWL5X
	d+HHISg==
X-Google-Smtp-Source: AGHT+IH04I5RpwSSuOduAsXzjfwvCz5Lbm+b/B8F1VirhsAIfnje/2Ij6SljAYtYuQZd05PnHMtHCQ==
X-Received: by 2002:ac2:454b:0:b0:51e:fa9d:a532 with SMTP id 2adb3069b0e04-5220fc6d526mr6411845e87.37.1715618944466;
        Mon, 13 May 2024 09:49:04 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32fcsm1813508e87.167.2024.05.13.09.49.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:49:03 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ef64d051bso5277348e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW84bJlWvy0h0zREPAXqwVtkll+xrpZM9dCC3XHMxkMQAm2Q0/Au6TOmQabOwP7F1bn06q1jp/AVgj+6N5N1Uux/9tXPvuNmVIwNygM
X-Received: by 2002:ac2:4253:0:b0:51d:55a7:668d with SMTP id
 2adb3069b0e04-5220fb72dbamr6347700e87.25.1715618943247; Mon, 13 May 2024
 09:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510183049.312477-1-urezki@gmail.com> <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
 <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>
In-Reply-To: <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:48:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>
Message-ID: <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>
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

On Mon, 13 May 2024 at 09:46, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Yes, this is intentional, nothing odd is going on, and Uladzislau's pull
> request is legitimate.

If this is more than a one-time thing, maybe Uladzislau should be in
the MAINTAINERS entry too?

              Linus

