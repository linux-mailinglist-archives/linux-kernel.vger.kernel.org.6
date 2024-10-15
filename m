Return-Path: <linux-kernel+bounces-366395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CDA99F4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC79B22653
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772D206E74;
	Tue, 15 Oct 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Z0wZssuL"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6B20FAA9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015253; cv=none; b=szYfS+huX/HhcpjuW1dZCybbfPG4zDAWMOwQ5uoRzZ/FF81ef1vD3RpNxK4RaJOpcKAXCfmfeh5JNjhLLflr1pwo3pDOLLcecc+IPHTf+LMKoX1QVK0l/enDlN6ufrtpAmoBvEBAMaes8qL4ZENjySemsSToQZN/mugd4QGqVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015253; c=relaxed/simple;
	bh=5Sh7kJ87tPc/aZUgjzlccOuvyWIxgKzdoM+PZcxJTHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD/vst43ON6ewIe5UPlTC6idohmh7S+WxcpKhMHjSbrXQahjezSkGcDMqwxi/uEvhtxk4jTBgiXwqgYSzC0QeFs7aMzPKHUYF4EA8oA8Qak9oENs9yZ1oNdHeBF2lFC54InaKjvzEx/z7+8NMXsqTB2Sg61vCw02b5aEQPXR+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Z0wZssuL; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539eb97f26aso3341539e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1729015249; x=1729620049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PcYrNsbw6IHjYMTuNLxXkYIY5QAui2/Ey124pf7Vrs=;
        b=Z0wZssuL6XDbaR7zjRVOQiAV7WQPWBoHXOcQjdtRYcg9ch5f3M0SZCxCKDZFQIWD9+
         GGe/kKUBxK3WQNcO6kQ2c8mCSTfDBjYhJP5+jbnONugmRmehvD766VMOk55rJ7hTI46a
         5A/pLXCVHsYGJqypRlxWm0fnCrd+/5hc10HfDmIsySKgVmq/Ik81o8sRiN199so4Ey9L
         sL0KaQjmCkEODMldJh3S5xzZHt547Zjm5ySmTuOhwG66Z93yxh+7gbNny355dV7N2CSZ
         S7DbkzJ+RE3HDnpiXrpNOqnStOWsW479/arkYhH/uEqVgKfk7ccdwgrrQsrJwmfFDAp2
         W/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015249; x=1729620049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PcYrNsbw6IHjYMTuNLxXkYIY5QAui2/Ey124pf7Vrs=;
        b=NCyIkLKktmOVlQP+uIY9R3D/+3rLC+x3YXIgL6lEDaoGvWCpl+yTJnLes4EyCzTmXu
         A+T1d85fw6wzXV5f+ENAg3FKfMGN4Dfg5ykqfHylV7JWNJWSJvDFb9vGh65s89iYbzZn
         AskE5sn0EO6LO5r+jzyo+eTlw72nS3nYm37KArF0wNKPDJwzZXgpJEvwLSurxnkq+n0z
         fxHvSBFMcgXknj2Nld8BNH6ZgoZ0WLtAf7SOwK8jfU/NuxcvVgE1a3IXUPm8Daa0+ESf
         KVFu5Ov5BloXbGkLvOoPQFWjzU1LxcKGBo6L1OBxV8tztAFbNtkp9qRz94ube9ubzplZ
         dNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Xm6UG32nyRT46Ly4dOmLsLyEBbH9JONZLtHEzsvYxJBLD7Qxyks8F3CbpCRds+rC7piEqGdx1jkfdJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnPj/iaaEwBBZtB95q6xHocBrFbOlMSssyW20cZXEE/PxFHpv
	qE7fIn8p9NiKf+7HKUVQO6GG4qmBP1k+aXNvRoHgj0o1zeA1E4UydIKS06QChjg=
X-Google-Smtp-Source: AGHT+IFMXOsAcBZZWVStKfE7LLIYDhStyMbY8vO1MusS7LNjj6hRuLd7x4EWHUDsYOZy2yuZG6gRsw==
X-Received: by 2002:a05:6512:3d26:b0:539:e67e:7dbf with SMTP id 2adb3069b0e04-539e67e7e4dmr4997923e87.61.1729015249316;
        Tue, 15 Oct 2024 11:00:49 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55de95sm24449795e9.5.2024.10.15.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:00:48 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, andersson@kernel.org, upstream+rproc@sigma-star.at, ohad@wizery.com, s-anna@ti.com, t-kristo@ti.com
Subject: Re: [PATCH] rpmsg_ns: Work around TI non-standard message
Date: Tue, 15 Oct 2024 20:00:47 +0200
Message-ID: <3518312.cLl3JjQhRp@somecomputer>
In-Reply-To: <Zw6suCNC62Cn4fE0@p14s>
References: <20241011123922.23135-1-richard@nod.at> <3194112.zE8UqtGg2D@somecomputer> <Zw6suCNC62Cn4fE0@p14s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 15. Oktober 2024, 19:56:08 CEST schrieb Mathieu Poirier:
> > > In my opinion the real fix here is to get TI to use the standard mess=
age
> > > announcement structure.  The ->desc field doesn't seem to be that use=
ful since
> > > it gets discarted.
> >=20
> > This is for the future, the goal of my patch is helping people to
> > get existing DSP programs work with mainline.
> > Not everyone can or want to rebuild theirs DSP programs when moving to =
a mainline
> > kernel.
>=20
> That's an even better argument to adopt the standard structure as soon as
> possible.  Modifying the mainline kernel to adapt to vendors' quirks does=
n't
> scale. =20

Well, I can't speak for TI.
But I have little hope.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



