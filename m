Return-Path: <linux-kernel+bounces-302124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF495FA33
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A931C21BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD18199FCE;
	Mon, 26 Aug 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drj0Ub2t"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4580034;
	Mon, 26 Aug 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702273; cv=none; b=T/E/cvtuecYjLF15adiG7aXMtb/DQO+HTs3eqjVKt8Ofv3weplSu5ZCOO0NrzBLZAIgci73xgtHRIrHCBeS+OqAEMSi3PVdlAB6vqe8MLljOQ+Lf7cbwHEsvD6ZawVRiAHxYuBlf4ZB3hqe8RJr0L/2d0444zvK2qVxZk6qEKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702273; c=relaxed/simple;
	bh=xMMGfoZu3zq3LAyMsb9O3Kt5EP+58+oDydS276i8Bg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkQCJwBd9a/CXaKySq8g/GrHMLFDVWjHMjMN4di9p73X3zW7LmfxsiQcoR2Y2H2Jh2LB/AhioiSNLkVsCfPdftbq3axXMuds91AKSribqAe0iTYgvsclWjpsatieAYFWQdQf3t+jBdjDdFV1sIj85aRQJBbdxDmjr5X4OycPAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drj0Ub2t; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d445c87788so908864a91.2;
        Mon, 26 Aug 2024 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724702272; x=1725307072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMMGfoZu3zq3LAyMsb9O3Kt5EP+58+oDydS276i8Bg0=;
        b=drj0Ub2t7fJ+vWZHImbqF6J5RX4Qr2cyc/lmHmecNWSsjiJkczGWVb19+/iRBsR7KN
         IPAFcnbInKX4bMBAPJU2AjtDRl2pBGhERgRhaGwcSIFDWAlGg/TNidv/VevSmCtZE3AG
         9PZLZtrvAWSI+3TQStPfDHynI+5QbqGCUmXTJTiuxS9JQfrkzLFLTt2CClwtAMjTWnXr
         +jbGdG1w7xPXNcExtDA4ue455KDOlPRxvS+GaPRhWcZKag4Xvl/rGUCW/J52T5qKgHy8
         JKSB9397nK/1NihD9P9YEszvqMfuuq74x13G9E6x4Zlwh6bWolHtWqWe57Fg3WN1jMpf
         SVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702272; x=1725307072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMMGfoZu3zq3LAyMsb9O3Kt5EP+58+oDydS276i8Bg0=;
        b=gbc0cEY12Db8rvmrj9uyG/EpQqv0OIAmiQ+6bsvRoNKGbzJ+/JePQ9H3k9IfW5RWfT
         IfUmDplm8ee/ao92HfbZ9x4sJprA7wx1whsBv8r/7dZO0MUfXb7iNThKiXT53+TRr7Se
         V7D1gAzmiHwFkyLtknjdDWxMyIb4tUOFJ9Pi5ejlTylZYhA6qyHwcgF9PneILGQVflni
         fNFZzVbgRcadnaHgusqNOgetJ17vuTnuA5JpLx62+cQjakGt33bpu+O+8fflPPOiG3j4
         usjwSM2GtrId0VgAddD3tKjv42a9RBdDJixpUc78+1tawYCQzXQFTLKKWIKEZH1/axsw
         aoeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvS5G4F+W2dhH5i7peY6ZuQfRVsOOROQi3bwmNsupjGt4efGoBveThX3Nq44TRtF+UASBpseIxp/blbRWEPeg=@vger.kernel.org, AJvYcCWYZR3GG6CXg976xNTgXWNjYxlRFkqm8d+AGGTG4RxoPJHReZlHw+pOC9RjCPTYJqcfzg+d+ABq958TjoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGLfu0pf2msXETid7rqqXEJ3iJA+ZC7WXC7QF3UvE1y12omD+
	u7Ti8g9yDnEhXNG48uR7XzyrYs1j9nlWFM+FxJFLD2ojTcXCQwAR0BtwSl1MsjT9NQ6UsaTEAlB
	Dj8oHp0tpGnEvpPNz6+jTecdJ7hoh5Oc8
X-Google-Smtp-Source: AGHT+IH0xHJvCXLQdyiwZcEdYykooutvvN5FAVtrGek53W+SuiddMjWmhOhp/bzM0hdf5FrlmmNbK5Hto4lYKIuk3QA=
X-Received: by 2002:a17:90b:4ac1:b0:2d3:c34b:a071 with SMTP id
 98e67ed59e1d1-2d646d3f560mr7681140a91.3.1724702271664; Mon, 26 Aug 2024
 12:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825221806.253575-1-simeddon@gmail.com> <f53fa069b9cc24a9552d54c7a004fe6d@perches.com>
In-Reply-To: <f53fa069b9cc24a9552d54c7a004fe6d@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Aug 2024 21:57:39 +0200
Message-ID: <CANiq72nDL65FDQ2xURPeNJKU61RjgidW43ZJQ6SBaV6PJh6trA@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: check for non-permalinks to Zulip
To: Joe Perches <joe@perches.com>
Cc: Siddharth Menon <simeddon@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	apw@canonical.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:33=E2=80=AFAM Joe Perches <joe@perches.com> wrot=
e:
>
> Why should these links be used in the kernel at all?

They should probably not be used in files, but we put them in commit
messages from time to time, e.g. for `Closes:` or `Link:` tags.

Cheers,
Miguel

