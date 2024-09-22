Return-Path: <linux-kernel+bounces-335174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B843D97E23B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD862812CF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23EDF44;
	Sun, 22 Sep 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2RWZ9A8"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CC28F4
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018035; cv=none; b=OV0oz3VQchXtjz5Ko7ByBE4G9WciZRAKUQ+yerabdBxz7+5HZ/NEa0zNix7GgiLKMHZUBDWGPcqzI8oLXBlFzCi5EkXEBhgE2/MPdirhxvXlIgYYBoEUVJzuagLdMvN+lZZHkjYr9wJ1WwTdRo42UvXPQWtLrGBEDFCEX/I9HbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018035; c=relaxed/simple;
	bh=DITuMDZ/je2j00C6gikU0EBY+BfjNP9apIvwpojVw7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk5ivRuP9tD8pIU54zJU4FjEwIaB9Uj5NFRML92S74epsP6HQ5scra2KRO2ZXVbZYXTPVY0DgkWfysF6P3npFrJrEGv6qIkwuer+81vLib00VZHYA6CPW4VEUtSKfssAPGcZCEL3VZHa4re9yWhgYXFR+akr+LgmruA13DHqzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2RWZ9A8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso4112354a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727018032; x=1727622832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DITuMDZ/je2j00C6gikU0EBY+BfjNP9apIvwpojVw7o=;
        b=i2RWZ9A8ksABZGI4ZrudJKP1ugMXTai8CHWWDdxWbFdPUI8WjaTxn4k60MXWIIszBv
         ef4lCNPYLCJCydJSdcFGmMSrEpyIy2eyBMMiDK2QuywJpJhRk7AYUnVf5Q6Pl65HkXkP
         pm6j8pQaQBdK3M3Cp+tQmIoLiI4e9WDH2+02OM+C8DJdyCSgRvJpwlkR2Jyld8Q/XsE9
         e9DDCRVe+TuGOeugtLJCOeXwNjkPGMUs3xGN/Ximl9Y8r4wae0rod6F/ouk66byhUvf/
         IvOUNLc3DPYmPbXiqHaf3Ih1I6BVEyjhPY300ZrE7SHqXWzllCzHiQQndDmK7NwnyXEO
         0A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727018032; x=1727622832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DITuMDZ/je2j00C6gikU0EBY+BfjNP9apIvwpojVw7o=;
        b=khLirpZ2eJKoB7xxCZ89cpsyzTCcSwPDt6iW5uxz5kVcmVUttv7IM48wnfar47OO/D
         U2AmeVPnHTfuGYVQysWjm3XF7P44ucC5rUFi6fj5USL4YE7NV/x8OKagjgk8iFx1vrSI
         vGisHiEzqU6dAayQPskTM5kc1Mm5Nd5pDy/Oq7OWvVzQq8d6SvoqSkE8Cd+QwV6V7UP2
         AI45JbCZHf0fBiLT/fHcm2hB9CAMX8rRTmHwrsn9DaYsWDjN+mB0MorJD9HP+1y3uUAo
         gn3pg1USr/Juqu8JdtCfjTG9EI8kAeCU86RsLVpD+3BMRFJkDotqw6Zw0toPWRI9pWHU
         bIAw==
X-Forwarded-Encrypted: i=1; AJvYcCV+lRcAGOUdJJEqSNhLDComrq7MuARKD016O1AXEfnBmLQyteMUuSoiqNqxVmhjfD//Ke54UUxT76xU1ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzChZn7rZMCQgLdbAgZ8F+6yiGKKgS8cydevdEnCHaLziweqcyk
	cCDPYOdKGn6GlWuTZtpZghe0cGxxxf6+iX6LSSI/oBipMDCsoDzQfJR/0Xx+stxNvVXqw8vpSFc
	XXsUrK3h7Bq5azbdNKdYR76tMsZo/+raIYi3udYc3CEzhfS/Zy7JR
X-Google-Smtp-Source: AGHT+IFO1Mw95Td1RElq1v3vq3/nV8brRo0pqFdb8Cva1USzZhkv5rOQbsNWpaRtP79wO8Eyt6TbthYA0/Kagg5IUOo=
X-Received: by 2002:a05:6402:27d1:b0:5c4:9e2:a21d with SMTP id
 4fb4d7f45d1cf-5c464a3e4eamr6433238a12.12.1727018032149; Sun, 22 Sep 2024
 08:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922150746.185408-1-wangtaowt166@163.com>
In-Reply-To: <20240922150746.185408-1-wangtaowt166@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 22 Sep 2024 17:13:39 +0200
Message-ID: <CANn89i+xbEwk4u3jzO42B-583uD1NiC39k+foteHr6pT5vtzMA@mail.gmail.com>
Subject: Re: [PATCH] netdev: support netdev_budget for napi thread poll
To: tao <wangtaowt166@163.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	bigeasy@linutronix.de, lorenzo@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 5:08=E2=80=AFPM tao <wangtaowt166@163.com> wrote:
>
> For napi thread poll, we expect the net.core.netdev_budget to be availabl=
e.
>
> In the loop, poll as many packets as possible to netdev_budget
>

We do not 'expect' net.core.netdev_budget to be available, we have
better cond_resched() calls.

Please provide reasoning, and keep in mind net-next is currently closed.

