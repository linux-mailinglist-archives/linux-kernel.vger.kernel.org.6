Return-Path: <linux-kernel+bounces-529131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6FBA42012
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B9C1658D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53224886D;
	Mon, 24 Feb 2025 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWSlff4o"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BF248863
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402804; cv=none; b=rXyhtPTqHoxXgGTXxCorjMfu7K4xOMtDFXOnpdkQ0JwtdYN+isFXALPBKr3Hei8JF4xiQ4wLfPbh4LDgIGfHJ7IQG+oi8SZ5pRV+g3xAa/+qsCWCzgImqpvbK1IbRNzJfWwRxkQXV7IAvIfYP8kS9bBctCyA1+xA9goFOwVtmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402804; c=relaxed/simple;
	bh=PUpwrxeoaMKQQ/LgBbzTYj1OWgdKZoLF+N3SjHhwDr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/6Rx7/ddCElMpPNSvK6OTmN2JUsQD5xKUpbOdzE/9XjKKlZClgAKFj4x8VYfhC/Wfg54A+y164XWuhJOH/RVgneOXFlUY9LXutrpkbmJ/pEHlVNY5QbY9VYALcCF4/E4Wlngyi3ifIVrygdf3758FrA47kd9THd+Uz6jMELYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWSlff4o; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so33621551fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402801; x=1741007601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAHPL18k0SExROmDrW1jEqwYLSKWWweaQeig+wvqPEY=;
        b=AWSlff4oVrKEzBCTQRQs1c0vjItFg6XIVWUBc1HY3GMprok9NvubSGNS3M2b2bCPyv
         pNSyMLKhe+b04JEJlJZIrhIfbP90YKeknV7c+GqdgII0QJhTX9sKHXwl7FKKLsL4fdF0
         lkMOHphm6k7n7BI9HdYxaurVcwHNTtIIof/UJix5NbTO6GJlkIw/OsqKmXVp2qef8Nwd
         KGhz7V+1zMgcho7NjKIx5u7dvYU+bOpoTxy4eMgyaNLrBUMnq8KOXHWlzzK9spRgNCpl
         xdQDc0r1kAIe8ReQ6yEbd0O3vQanJV4I5VM/VLJFtG2Rkt3sSdeu6/Z2wMHUdjJ31NRh
         Glkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402801; x=1741007601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAHPL18k0SExROmDrW1jEqwYLSKWWweaQeig+wvqPEY=;
        b=Izoci9QnE53eMlAHwcp2HY1GgmS9WdPk+rL95TGw0Dg4hmkok5Uq+QqppgR9wUb2fU
         w/xBKJxPUj6lncLUwL3PRLJfybtmF5dr1sPhwERuxK8PlflypqE5Bj+S1rMFfHYroieo
         BHq96BA8vJ2WMSZsAInYGLHpH9HiS72vCSY0Bk1oR7rH7zX4c26qvL5bcDX36csPfWGi
         Puu3LwFankz4CJDZE0aKHtW08ZEh9NoQjHXdhm3Y5fVlZhutlQSIgfrBVNjPG3TGdj0H
         AMXMx6TG82oCHdvcLlg9x2/39jqaNcpZAmN22x1C6N1xP7l7YGqMG11LL61a2Y8FbaaQ
         zzpg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Zm4HRbQvOIsQr0n/LethIlMX8l+AiJFPoU5ccyE59WVRu+IBuK/mQQQpGhpJRUPak+mD9QNlrH8tcaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI84cK8no6N8Xu5XFtKAf/95XG+cxLbk+/8Zl5d5chQeS1kxVr
	2Ohk2G2iC/qskDSsRL9oiJmXG+++qkU4ckZylEFzMg5SQPWIT34uKQEYaaITCsxXd7S7rMPTzbe
	P9Y6+JRUYwKaL3hpw6XGQsJ++DYKx9HdAFJKB
X-Gm-Gg: ASbGnctlGldWec6YKXaSYV0GtVrtikB0sIKDLARuF7f7reNsNPJOTRJ8EEjCPUWxkjo
	u7Vzacb8EigFG5Cxu+l2VSzyBXEAiYwAqdrlrXijeZAiVJ4JafWgTu/HGeSKZ5c91TZFoQEKNmE
	Y94t7yR+Qsnk0ICeEd7Y5UzFDVrXCRkuq0otLu
X-Google-Smtp-Source: AGHT+IE2Qfv6gUOl1nLWU+9pSXrvtMj6PEzIxUkiRfH+sNqoUFYRr9Ull51dKikz5yg4QVbUPco5NQ/SdGi8wkjq3CI=
X-Received: by 2002:a2e:be0b:0:b0:300:4362:40 with SMTP id 38308e7fff4ca-30a5b21db20mr53847251fa.36.1740402800828;
 Mon, 24 Feb 2025 05:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739864467.git.dvyukov@google.com> <9f33eaaea6fed2948502eff27c4627921d1e1e78.1739864467.git.dvyukov@google.com>
 <Z7iJSyQYmtAl_z24@gmail.com>
In-Reply-To: <Z7iJSyQYmtAl_z24@gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 24 Feb 2025 14:13:08 +0100
X-Gm-Features: AWEUYZkv1lfF7HmK4Crv9GT6MZI19rxUg5YmWT6xvRtLvyXArZ2vi4fI6FOhbWY
Message-ID: <CACT4Y+bwm7JtipFaw=sq2QocdL-VVbERnRg2E__K1ZrWBy0hnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pkeys: add API to switch to permissive pkey register
To: Ingo Molnar <mingo@kernel.org>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 15:10, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > The API allows to switch to permissive pkey register that allows accesses
> > to all PKEYs. This functionality is already used in x86 signal delivery,
> > and will be needed for rseq.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
>
> So why did not add the Reviewed-by tag by Mathieu, while you
> incorporated his review feedback:
>
> > Changes in v2:
> >  - Fixed typo in commit description
>
> ?

Done in v3.

