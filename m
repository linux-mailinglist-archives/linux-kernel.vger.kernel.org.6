Return-Path: <linux-kernel+bounces-429844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27759E2773
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9864028816A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB561F8ADC;
	Tue,  3 Dec 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti9pdhA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDD18BC1D;
	Tue,  3 Dec 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243399; cv=none; b=b4wxvovOrLD9UUAnDeBwavWhmsyGBQkyQQGRxPRBUJbpQgFN2udNEnftRRTOv8JYT03cEAnstzllJVGvq4+dx21BvLVhOnUKC/RuiZ/8DjVba50GpJmuifz1/kZAJE7GBXeEpI2BBQu5siPZy7v0Eba1cNAoiJUbQXvL6HikOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243399; c=relaxed/simple;
	bh=Tv0/FtCsUcuTGQ+jsoiF0iOjSni5uFgH74oUN7PTxcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A68j8vLS6YNpUK8lwnzmSlKKTtD6b/MDs0Ze8rnRn5UJBVyOicB1SBvrm/OANdVHtP530pAA3DRCZsKz2lTsiQ2jDGDWdU8j8TEV4eWR3iZhn9jbv8TvgwmI5FGXvLTptruyFiguaf/VmaHXm1mPzEvi5gp293qzXhk1+QicmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti9pdhA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D88C4CECF;
	Tue,  3 Dec 2024 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243399;
	bh=Tv0/FtCsUcuTGQ+jsoiF0iOjSni5uFgH74oUN7PTxcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ti9pdhA+K7R/MPEZB9ABHCXpptFb69ykzeorjO1rSowT+A1f1/5qsxBMP9aRP5y2O
	 OAKylJF/RCg0sYh48Rb9frTmiNMGek+mCyy6aDOUhouTxm5B2yG1fXBuoPKPM8lrR7
	 HK7c/XG29FNkOe7ozwcPw9kkTFCuArWHMOoL+m4OfYxK0iLKHbijYR+lJXpMxBk75B
	 UE+lUdwXMRCA1+DrAiC8nw6gZAyYSOH76Rb1FkqS7z/QTCjbEUtuVsDjr66tTk1fTI
	 zTGk5nGOSiP1es4Mz85xnsfYlRjCcqWseLp2wpCcno/hvOP34AzgraYIWEaYgUkh1m
	 qfInz0nP1ZKqA==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e388503c0d7so4183916276.0;
        Tue, 03 Dec 2024 08:29:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKhvZtTq6htWmh9ZkRpmfwp6HYpmljM97RC5eRN5YMgyVbjKxcXg8y4exdQdljVwQmRjGJH1ARho9Z@vger.kernel.org, AJvYcCXGPoZ0gBqpscnZ1mjhWlQhM+QuMVq8KmiEU2YxBag00QBDDgylkccUbJWXIa4c/H1kwKHzt20aVt4Grqrz@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDBLM7YpB6uRPB7FernF92Z74HyVCeHcp5TiboLq3UeLb1nji
	Kc2P4me/0Y3QFaodfWVPaxRsaP9MeAttHfGwY9STU4eGIUNq+rL2FtHmLV71DDN3oNtaxIG1Wmu
	FfNnpsscacGLVu9SRo7fahFsLCg==
X-Google-Smtp-Source: AGHT+IEjhzwVUw3GpUhAyfiDrfv9x9+EZvaLuj9fZM6qMK5uI75t59+f1FnfnDvhq+imIO6/SaFkHANqNEPhKwxddCU=
X-Received: by 2002:a05:6902:f89:b0:e30:e39b:9d72 with SMTP id
 3f1490d57ef6-e39d3a2a894mr3508084276.16.1733243398164; Tue, 03 Dec 2024
 08:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023185841.1183706-1-festevam@gmail.com> <20241024-pep-proud-d714705c9ddf@spud>
 <CAOMZO5BSZ4YAZ7Lqa3eGP9Wx=Ed7cgug==_UZqc7F57=XCJv3A@mail.gmail.com> <CAOMZO5AgQxd2_gkcPSdhfSDArEEkBVvo_yAW3hdHVXtHH5FyAg@mail.gmail.com>
In-Reply-To: <CAOMZO5AgQxd2_gkcPSdhfSDArEEkBVvo_yAW3hdHVXtHH5FyAg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Dec 2024 10:29:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKeAknYwaR_VRfrT7bHf9q6iNMyC9VV+dNBPd5VZNTLAg@mail.gmail.com>
Message-ID: <CAL_JsqKeAknYwaR_VRfrT7bHf9q6iNMyC9VV+dNBPd5VZNTLAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: fsl,imxgpt: Fix the fsl,imx7d-gpt fallback
To: Fabio Estevam <festevam@gmail.com>
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	Conor Dooley <conor@kernel.org>, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:57=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Rob,
>
> On Tue, Nov 5, 2024 at 7:48=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Can you apply this series via your tree?
>
> A gentle ping.

Daniel should apply this. That was my assumption and it was out of my
queue (which drops the chances of me ever reading this ping).

Rob

