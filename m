Return-Path: <linux-kernel+bounces-184105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D18CA2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C1EB21C31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BDF1384B4;
	Mon, 20 May 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hQvWwXGL"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6D134CC
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232802; cv=none; b=oTHPLuJVJgMrYA2VCjPgXE2JzSuO9RADDcR9rZX+yYsw4dUWP/gX5DMISAUd5dH9i672acyqWYKyfMWjeBLF/5nZIM97sQrD+dbKyGgX2uzyQhyXJe3t2CB6TD2QSDrewHhyEHnyguHdB5NNMs/DYvbQuI/YM6JpRmRhp8/QDWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232802; c=relaxed/simple;
	bh=xY1qK0Yx5cJZ0/DOHZqEwDlK7UkPPBcazYLb2quM418=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zhrv+S0iKcQkI7ROy26zw1LkAX5hvkg0dhvRZHATElmz33xWJjhGZukRwDxz6Le/1jtH1Ean2bYcmH4BETJdTyv6jj7SyA7dhsWNwnE3woeT3/e59+SInNdJQol4cbehf8EWUAT6f3Pvdg1XpQ86nK6c4zrlP9W/ZAPSBhww870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hQvWwXGL; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e538a264e0so59428671fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716232799; x=1716837599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY1qK0Yx5cJZ0/DOHZqEwDlK7UkPPBcazYLb2quM418=;
        b=hQvWwXGLkdi1sgHhvrfZuqEz7gzenGgRdXqswpU66frg92RS4Hs2h4rNdjQULSF4eO
         D2y5AcFznv+xQ0j5f40uccd38dyMh+kLxyhw1My2lwRskDJWWO1V1VOrSzbhCd647K0x
         sqNQ6Wz0Ej8aMpkhH+f0Hgx7TPA9YqFdJecqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232799; x=1716837599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY1qK0Yx5cJZ0/DOHZqEwDlK7UkPPBcazYLb2quM418=;
        b=bAvsfxm0KgglHH/5oGzXCIz31HY1MQS/xa50o4YQOJkkrzUHgU19F7H1tbpbmu0loS
         kupYepHCMCqtu2DXDfqUpyoxsFcFHgVG4KuxjKEG50S79jmB+hibeqW5SQ+9q/Y1ZYYj
         l64xeusPB7FwT1vSrQyS/9MNzjju04SjR9VobU9WoCfdQ0yUEalUuiXXAmKuPV+Iy7pH
         pTA4CrZ1G5IclWmJ39bMkd/dW2eUWqe9O3GZWbLQZbmluSZo6u/uMTZDG2oAZ8btRUzW
         A80erch1AcBdOcGIZVZHfKb/01jFAjiMFdOgwOXrW2tUf5RJ9U9hdZjFDA/WxDpat8JW
         pYNw==
X-Forwarded-Encrypted: i=1; AJvYcCUSEsacjRc5fIBpwIa9orOFdsyBJeADfYHBWap1y6WXPKyZyo3yJUdKperPyH9SIK5rDM62uWsWbCvP80Hhi+5EYuwF+kVw9uHMQdjM
X-Gm-Message-State: AOJu0YzPN38uS1qXXKOU991imk4PAnZdoX8RvtkCUuKS6xQ1NN68708u
	hW9lbgOkBD6sWeli1rEi5m8CZrdBi1OZPQZBArkcKQAPABspMBFqVNjvlClZU59Aqtqlx2zHLPf
	oaX7XZCjpyVKg29jjdxidn4517YrGvAp012WXO9jzJCe0ZNP00wFlbQcCxAFpuy9RYnsavgj2+k
	SgFkYAQbZsnq4RG9/WaaZlY9hMzA==
X-Google-Smtp-Source: AGHT+IEJBva2Jcefe2Yh+TeHrjvit6WQ7OPmQcczNguOh+mzYdQEwNpQNHy3Ih4usmFhTJBLVYujsIWi1lV8Lrjhv2U=
X-Received: by 2002:a2e:9f4f:0:b0:2e6:f51e:ec1b with SMTP id
 38308e7fff4ca-2e6f51eedd3mr154968421fa.3.1716232799230; Mon, 20 May 2024
 12:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514182050.20931-1-ronak.doshi@broadcom.com>
 <20240514182050.20931-3-ronak.doshi@broadcom.com> <20240515104626.GE154012@kernel.org>
 <CAP1Q3XRYGySJQaWe8dvasUGmpZGcYy_g_Xgft2u=hg9R_eqEsQ@mail.gmail.com>
In-Reply-To: <CAP1Q3XRYGySJQaWe8dvasUGmpZGcYy_g_Xgft2u=hg9R_eqEsQ@mail.gmail.com>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Mon, 20 May 2024 12:19:43 -0700
Message-ID: <CAP1Q3XQKStM5Tn9HZjTdgki4_7RiF8EOf0ksZE9gzZYHNkAFbQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] vmxnet3: add latency measurement support in vmxnet3
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, May 15, 2024 at 3:46=E2=80=AFAM Simon Horman <horms@kernel.org> w=
rote:
> If not, I would suggest making this feature optional and only compiled
> for x86. That might mean factoring it out into a different file. I'm
> unsure.
I can move the rdpmc code under #if defined(__i386__) ||
defined(__x86_64__) so that it will be no-op for other architectures.
Will that be fine?

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

