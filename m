Return-Path: <linux-kernel+bounces-239152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27C925735
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762761F237FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB514037D;
	Wed,  3 Jul 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdnI0sIw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C0139590
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000134; cv=none; b=QQrv33xHPizrzGFJCRce7Eu2DPSXfUBUNF/f0I4iKhcXevY+vORcda/OR8Umc8Dh/pvTqaxSwARd0bE+44nGeQPwMa+vdVoJruFFfO25iXTI63V+0NFgO8utKmJ14EtWq3OfBtzngbsT/RHgodVVNlUXwlIvgn5r3GTwn8M4daA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000134; c=relaxed/simple;
	bh=9Bb/NG3smGGfl51LXhMHloElDKOdrvDMHT4oKg8wS64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2+Uhwn4Mt5lhWmaUJnYarbDih+f2iTw3wzXMGvREE6uks86JeEO5eLYzURLMMy+jN0dsqnTF6BJ/kHZoJtD4gl1te0xUH5uecOopE7jkB4K2xlXHQvdd0rrSlWsROmD6wQxI6nmJEwm0lp3M7KYP5vEls0WGHVGsp31JZ6Y9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdnI0sIw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424a30255d3so32525e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720000131; x=1720604931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bb/NG3smGGfl51LXhMHloElDKOdrvDMHT4oKg8wS64=;
        b=LdnI0sIwKagPlegEJUH4AgOUM00tFRIhQHP7qK4BY69BXHfz9vUv1a9QlfVjKyWBpH
         WgZAmUppD1RjYsUrcjglUxlCCy2EBOYIJuU9wfgIEETECKnE2qaQayfyrGSLk8nmDris
         zpOIwqYaroa7oJfeYVQ/nnGSzFZLSJY9XUaiLGaPzCrCzx2nPBbd38QDYYHI2KI64T6Y
         93tHuGISvjAioQKQHtfuq8PlaBXWi2K3LbJ7Hdck+RwMpMOTsVYKT/NVoo8uxXkK+5Mo
         tlojQ9tLOH20+IuFky+67D6kL38Hda4LrXUWEDJ5SFR+rvqSVKXtD2OrHB9p7+6FzCly
         HRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000131; x=1720604931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bb/NG3smGGfl51LXhMHloElDKOdrvDMHT4oKg8wS64=;
        b=RmAH141tBn5eUbOZdqsW21qz7Un6jEgHYtdhTCHzZHDPnxEh/CrLv1SjV6p5EYxUYQ
         E2fyyaVNxwP5PsbzXvyKExRXL/6lvNCZGNEGaUviLbaOFWfan2izTAQiHxlI160KCg9K
         j2zDDNg0ZVvDWOrOkwoDks5fl7RCSw1U51GQ6tV9dENWWEXs0PmgPyBmrCa65XB54nPq
         gGNNq5VkzCCQeEzHwvrbebhGARHxdiF1g4+qEx/SDQav6dGiSzkoYv+BFH7UhN7OySOo
         JblNKgPX2I8Ao7AIE5pW5KWPJ/zv/J2IBeQ3cWCHWhWe344Gg+oIZZpPB8cbQUjmJEdA
         /5og==
X-Forwarded-Encrypted: i=1; AJvYcCW+Cd389IG5xn7Pk/XQm8tmBtcVw+gRpJNHTjrR/4L5nXazZxKHs7ugFl99mjsom3+F5vhCn0Ji2/UXX9jqfunQjFSwpmttvxZprHTU
X-Gm-Message-State: AOJu0YwpzU2kUchM1ie2qs1GL+8gCjpk0c4tgynI655cd1QYar7L4cOH
	Rje4kxEQpITVSsNkW8vUem4JFBABu8aGT42kMVMClVNN5pmBwM3JYAep3WJqrymK/wOdm0AcYJb
	XNJ5H1+YzAPi00UxDyfC2EoyAdFVL2jeVKW2GOYQKYLMjplUfLw==
X-Google-Smtp-Source: AGHT+IGC917Ef7NHa4Xa4S9uRSjyc3XSEB0vBW2CBOjBoWNGHAYl4t3gXiObSqoyxW/dl36MJF/FOdJM6zwKGkccvGU=
X-Received: by 2002:a05:600c:5127:b0:422:ffac:f8c0 with SMTP id
 5b1f17b1804b1-4263f7efa11mr931815e9.7.1720000130929; Wed, 03 Jul 2024
 02:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703091649.111773-1-syoshida@redhat.com>
In-Reply-To: <20240703091649.111773-1-syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jul 2024 11:48:36 +0200
Message-ID: <CANn89iJaCc71gqmphNKqyFDrEFC3gALESsLpuNheMTzhzA2LpQ@mail.gmail.com>
Subject: Re: [PATCH net] inet_diag: Initialize pad field in struct inet_diag_req_v2
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:17=E2=80=AFAM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> KMSAN reported uninit-value access in raw_lookup() [1]. Diag for raw
> sockets uses the pad field in struct inet_diag_req_v2 for the
> underlying protocol. This field corresponds to the sdiag_raw_protocol
> field in struct inet_diag_req_raw.
>
> inet_diag_get_exact_compat() converts inet_diag_req to
> inet_diag_req_v2, but leaves the pad field uninitialized. So the issue
> occurs when raw_lookup() accesses the sdiag_raw_protocol field.
>
> Fix this by initializing the pad field in
> inet_diag_get_exact_compat(). Also, do the same fix in
> inet_diag_dump_compat() to avoid the similar issue in the future.
>
> Fixes: 432490f9d455 ("net: ip, diag -- Add diag interface for raw sockets=
")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

