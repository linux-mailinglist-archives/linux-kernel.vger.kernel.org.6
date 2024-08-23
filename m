Return-Path: <linux-kernel+bounces-299450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61C95D4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F21F23353
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF31917EC;
	Fri, 23 Aug 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3KW09pJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A519047C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435811; cv=none; b=HTQnFIz1aZ5ZAGosDNqucMy2meCw52Tiu4+hMlKJHIPh4X3wx0QAuyCMlwUAXsrAIvSXQvHVSf9ezXVXRyCSuzHBCUMl/Ea40TYltKq2FseE1DGgdCP5rj0D3FcU9011oHAINaGpIIhOv+Lc0HYlRKNze8bx1/knlyLQ+L5nLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435811; c=relaxed/simple;
	bh=5EAkUOO1eNEpKl7lKdwoXdo6q7cdLYxByZqnNvS2DqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjHMJbdMjblK7aelP2CHPSYrU5NAJiAeJWKXCptWeeObOogdexKbrx70O3tclNg652IqSSQXgYTNhwNGmRJg53KLxnVhCe82kZ+ouqiulZkRPDfv03JLo22K12UHqOYhKYdsMlyUPtnSKmA3yQwkg+YwpU1p0y+viJvkL7tNkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3KW09pJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so3014463a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724435807; x=1725040607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EAkUOO1eNEpKl7lKdwoXdo6q7cdLYxByZqnNvS2DqU=;
        b=w3KW09pJHwVoSx83XSoHMZVpqQ8WDKITgQEZZ992sW2HY01oc4hTZ2gzyuEkDkq/AU
         E0Ee7OisTrkFHlTzW41WlD8aOA2x0bQL7R59CHpmSGP17bDRVpXB9v2butLq+vMBLNZm
         EaLPJyLrN3apHRfS9mjDVTQEco+uED5XCHoviVFXTsinisYRqtPXY9tIP6KGD43Xoujb
         T4QqYAk7xiMjLz+mO3bPF4sgBjDVoWEpckdgSgahpNp2Hpet2p0rgDhIa6HMWEyKTRgQ
         O/Taj75+RxzQ50LunrA13gwoUY290UMkosxJFbB8D4PGygCrmod+ZiPMOwUPEilH82sp
         aSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724435807; x=1725040607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EAkUOO1eNEpKl7lKdwoXdo6q7cdLYxByZqnNvS2DqU=;
        b=s1cuds+U53nYZUSvADpu5IyAXJnB+qtiw8oAeg4yk7PsRgb158c/fPgTWJxAtwK+mg
         Tf3nbpi+8JoQYHMn7Psb6D7U7Kdq3wkqr92JGjBkGFpJGasrYzmSKn2FF00vqRuCjEb2
         4H2hxQHWR9An676q84rKJCegSEIZJp6BOyWiamsDHfLzfZgEtSKdSl8xCUUhxTvefn4g
         z9VxUynYuArHKPQBbZU0tbFQkR3CHR/QwFHohbyGmbsFoHUuyhjnpZras1IKeH4mizJw
         cc74BZG+V/uSwUUoZphBXW1DsDQBOVzWs2mYq6KGG79DK/AVc3CoNewqjaLcUjUfxq5F
         IVIw==
X-Forwarded-Encrypted: i=1; AJvYcCUREGqqI+Dr+3bQlxF1a5FkYC7JyXu8xwnaTiWspDo7bDJ08tjDQ+FHJx0YtDL+i+KrVf3ad74EQacpI4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyDwjBX2O2WGzLRtf8oXTI7/c4Uzl3/w8c7/iaFG/QYg4gq0/
	g3a1FLThobXAw02QMur8pRfxTLZaTBYh+++K9bGlL/fDuHw76ecCxdXfZso+CI2eXdBTq1MYr+c
	GcZoPYM2+fWRYb8y/TU7kKWHD4G1JDMAxluZh
X-Google-Smtp-Source: AGHT+IFwFUkQt4oN9JaPIbh+hQ2AzBqEeVIVAQ4tf/anTJHMyeMMgrfIltpAuTebGN8cKml67ilk6JUfiTdxWvuwcdI=
X-Received: by 2002:a17:907:1c20:b0:a7d:e84c:a9e7 with SMTP id
 a640c23a62f3a-a86a54d1acfmr234712566b.53.1724435806499; Fri, 23 Aug 2024
 10:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823173103.94978-1-jdamato@fastly.com> <20240823173103.94978-4-jdamato@fastly.com>
In-Reply-To: <20240823173103.94978-4-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 19:56:32 +0200
Message-ID: <CANn89iJmp2yviC=Z-n7-=suw8N=SJ7uoy0xy5LMQRKDhubNBZg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] net: Add control functions for irq suspension
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net, 
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org, 
	willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com, 
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:31=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> From: Martin Karsten <mkarsten@uwaterloo.ca>
>
> The napi_suspend_irqs routine bootstraps irq suspension by elongating
> the defer timeout to irq_suspend_timeout.
>
> The napi_resume_irqs routine effectly cancels irq suspension by forcing
> the napi to be scheduled immediately.
>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---

You have not CC me on all the patches in the series, making the review
harder then necessary.

