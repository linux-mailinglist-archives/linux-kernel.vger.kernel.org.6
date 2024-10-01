Return-Path: <linux-kernel+bounces-346250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98F98C1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE3C1C2430F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CD1C6F51;
	Tue,  1 Oct 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dycfTEnT"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF71C9EA8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797053; cv=none; b=ReFuyjXlJQjj3Pt5acSDnKuPE0V2jPrxxIApKQNsZNLcZUJPW0o3lUKMkd3q7GDmHlaiWLYPkXghOTRnimqvuuln9ZgRdDn0dSZ6RkFfvRQ3qgafFnKmOD2C+xttvNwyMxZjt61dYl8PlWt2tZ49a2DNjDkr0OQ4MU77/E5WdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797053; c=relaxed/simple;
	bh=LjHglGMY706Tr5dbLNasgjlLB4kreypJeeDife+hHzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afF3fzN8oYjismUpga+cnvoLe+O9pj0WR/fxZaCZySfWYPtsI2kZ52SMrpzNo9AeKvB+B6TdYUjqJNvXh2GRGQseGVCWGcACZvcPw++vwZLPtnTc7iuvirAGjsqeowF/RVWFLD/EeU2q6eFHv/ZBikYZ7Uadlxk+cWJTXplGgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dycfTEnT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398a26b64fso4089045e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727797050; x=1728401850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmEtXA1FAMbbnHD+9X5NPyPzlPyCs6lfwZoyUF1ba+s=;
        b=dycfTEnTbOdhm5YdVp9JdgPj/twrUIgGzL4a2MGA+1U48sYmGLO85gXLXHCEpDlb9j
         KG9+3JiDQHCqTvOnaRXeec9robbq3REPo3Xv03Y7XF8QGVxOtZw4lipkIlBeYout7707
         aMHsuavuIo7ymkcE4rwRBiMoRvw1k1j0b/NPmUuiJJMVOO+kZUOObfUz9dZXjTL3Z5Gy
         E9L70HtyE9a3+iEBPPkkVdaTwPRFs3wAr/6vVQtvm2ItxAefsov/O0qhEGJqrijggIkv
         YL9S80V7cWEPrPRDsl/6Lhe4ZNUu3dFi2fUwnRCEMHLxScqDr0zA7V0ttMl8QPB57g/G
         B56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797050; x=1728401850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmEtXA1FAMbbnHD+9X5NPyPzlPyCs6lfwZoyUF1ba+s=;
        b=K9WBxcYEZ6kgQkOpYJ57pwEFkWGzT1VmhUp4JBnM7ZrCCZDZa/gRKUA2/x+ulbBSGb
         Emel/PhBG7cfwlR5sl0rHQKnYp/FFsVmuDFcqQn/2NF0UxVFsxoXjTzEoQJAa09D/JRa
         Elhyj8/QMf0k6FHOpVU3Ez+ZJ9QnZIobvVZwJfCn45paXHUyHbdVcQwN4tLq+Dl/gGwv
         lKNx4kX2iFUgnVuacq9Bc1aC01xsu0C9tY3dhdY1xJZC5PlkxNxt+133cG7Q5MRVZ1Pj
         rsoffK2XRPKPYvPTgGTds6lxFFnFCl1icm9Z8Csp9E2t7Zn4ZKyf8tC/rUlNARwV7Vxm
         fg4g==
X-Forwarded-Encrypted: i=1; AJvYcCWTlgXpEYoO7Syle1gCbD2PanVAU4MQtjHXvgzKupWbn71f/aEUSTmfdjVxEGWtn4TKD0qZj7xUjvI0TUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9WFGl35JCG0Ed87cG34OcLB0IjtM/HSla/Na+7ZomW3vZ4WRr
	JSaXJAbdVK0u+RKxYw2TjLr1ryzoP3X1Vj6lupu9lrs+obAkrZ10Jo4CM72HcLDSafKBek/xYul
	OQF+kN7OZYFKsdfHHVm6wjwD0g87xGSYZJiAi
X-Google-Smtp-Source: AGHT+IH3cuoy22x4HBhXQm7whNFat+U7kzsexIE2837l375FU7s1xw+osKYMrcPSEGeU/x97nEBl8SdtN4u+SNnBavE=
X-Received: by 2002:a05:6512:b81:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-5389fc468f0mr8690427e87.25.1727797050178; Tue, 01 Oct 2024
 08:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930210731.1629-1-jdamato@fastly.com> <20240930210731.1629-3-jdamato@fastly.com>
In-Reply-To: <20240930210731.1629-3-jdamato@fastly.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Tue, 1 Oct 2024 08:37:18 -0700
Message-ID: <CA+f9V1NWHDnX0Y7EzAkKnwZL3VLxnvTBfWyQwtrYdA0hp7Z88A@mail.gmail.com>
Subject: Re: [net-next v2 2/2] gve: Map NAPI instances to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:08=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use the netdev-genl interface to map NAPI instances to queues so that
> this information is accessible to user programs via netlink.
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
>
> [{'id': 0, 'ifindex': 2, 'napi-id': 8313, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8314, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8315, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8316, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8317, 'type': 'rx'},
> [...]
>  {'id': 0, 'ifindex': 2, 'napi-id': 8297, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8298, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8299, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8300, 'type': 'tx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8301, 'type': 'tx'},
> [...]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>

