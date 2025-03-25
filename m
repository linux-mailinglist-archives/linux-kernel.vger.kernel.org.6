Return-Path: <linux-kernel+bounces-576297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F60A70D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A979E17859B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D213269D1D;
	Tue, 25 Mar 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSvCqObg"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422921B4234;
	Tue, 25 Mar 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944981; cv=none; b=kwzyDF/pI+CiL4jzPqJJt1LidMNOiDaAyCyDU+rc60SxGZ6m2Ztx4KeEOpZSOik+0bqAN3dGyxpT2vUrimnxiy5cxiVG565T/HBMIDCMv5ebDqvVwg6iWzZ11qdF52b6mNbTT3UC6m0N+iIMhHtkhChsYIwBE7KvnjN7AOll+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944981; c=relaxed/simple;
	bh=sBLI5MNBssAhJFkkXjW+KAAwVF91J24eSIGyy/AEm2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbaqR+R7bF+l27HndByuqYm9laR/7U9HoDN4NfqFaGcdcwxfRejGJjaFvcRtBTQrXSCP5fNw6YzPPIKOuRhmCxxj8DRAAzvYiuMpsPNaVkm2+DqBPziUzVonD/tFNZ7YwuCx/VPyahgZOEnO6hyhrK0b5tddwUHDtFqoHPi03oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSvCqObg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff5f2c5924so1530821a91.2;
        Tue, 25 Mar 2025 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742944979; x=1743549779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBLI5MNBssAhJFkkXjW+KAAwVF91J24eSIGyy/AEm2Y=;
        b=YSvCqObgTxiUZ3vOSMJPFtcPCqNo3nrSrw4K2Dzq0E9xkIjoRS56yxEAJxEz1/cx38
         Be0Pi+T9bg3cCSw2rY0VRi/ZDpOAb1trNNi/IfS+c39Rr/kGogxhIDmaDxTkQEoQXuTl
         Kkt85jlI3D25TP9/WELDOzehD6cD5KtRDJXfbp1z/7NcGvYrVbUVNAU3drDeYfJUocKL
         N72k9bOMDdkp01kwv8dLShFrP39nVraR2HXoZ4btBZThYIeBuxJ/bCzIc2MjxTpbpafv
         J5JaLqtK3ZM5/yW/UGyiAtNXRrqZzMO8eW/oNjGSq816sWjYOqXpWkdYqLrc+9HetdMh
         9Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944979; x=1743549779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBLI5MNBssAhJFkkXjW+KAAwVF91J24eSIGyy/AEm2Y=;
        b=Igrf8NaNPjf5nfOJJu2la9LEgA5bnj5upNkoh/lNKtqeDQSblnwTaN+GFpJeyLYW6S
         9uk2VS4hsvN9NASEFyTQhL77w8l0V/3gTm2qKWwU4UlIkQpOTfkmpSiGVIzbMl7y8DWE
         /9FhT01b69kQa9+S/vMHmEA6KfZRNOHlXFCxdnjxz/sM612g/9rsR15+5jioJTWwJtLA
         SdEzucrufUkz0GhYV7pTDGrKINbs9dBQXXwIrX8MwRWcQbeP9PptPFE+Mq0ufS2CpObE
         aotCwLqug3qHKqPGVR6Z7nUCV2+aJPJuI3/ywrw34Ahbh+fVoPcaxP1KGTGDw5BU35oP
         KKLg==
X-Forwarded-Encrypted: i=1; AJvYcCUJzxnb1/GkOLIiOOpqPZlnVczf5lJxYqs1EQ5VqB21P0bA4Y/WqJ+iap0JoXbjJ0Qp67d84/SXS60ayAw=@vger.kernel.org, AJvYcCVzrHzXMOpnPc4pvNnbryGpKlJPHpdri4k5pGJz7dBwhk2X77wHB0t1PPz3SViNBOxxwfFvDHZPR1Qselvs4TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlM+BGbavpEBks0mXKyDeAdaHvuc4lluAuUl6lgZ5gR8DFZoy
	UQYuKDlwvWLZi8bxGatjpvx7tO5PeecfQcecZ+f0B7TUHmUlPUUoErqOGTpZQxC6nYjqNgOqJpm
	AcHDXXg7qvoy/mXtTcY6zf613NSm62RTp
X-Gm-Gg: ASbGncuid79dYlC55M6/7Rk9X4pzVDfs8Y6VgnDFXioXu4J8InPXXKykbY3OH9qmY74
	RwTx3fnpbGa/VnaKw1Q88qpUz1y1bq9Sg7KfJf5JLzc1PNNSkhcR9hFS04LBfXdE4TGaH1/S4QQ
	ZMRDWFpHaV3nJI3qhId630+2SeiA==
X-Google-Smtp-Source: AGHT+IFMYm1RwfCprvlYlhM+bUwGOOkBk4MKIbzNGWN+1VeyZD8NARRKPVcf/sDEllSnFwc6lrQrPgs5GfxNXkOAZvE=
X-Received: by 2002:a17:90b:3b51:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-3030ff15738mr11189805a91.7.1742944979332; Tue, 25 Mar 2025
 16:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87pliljcvy.fsf@kernel.org> <87tt7md1s6.fsf@kernel.org> <87r02pb9jq.fsf@kernel.org>
In-Reply-To: <87r02pb9jq.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 00:22:46 +0100
X-Gm-Features: AQ5f1JoZhCLVmldE3KWbOCN13IuZHpERQrQgRYl5bzdQcoR3yUY7aWYwHJ8Xy4E
Message-ID: <CANiq72kY7oVOd+cWCQHrF=FXbgzLFyc40phMzzNZ_sJr+jYwnA@mail.gmail.com>
Subject: Re: [GIT PULL] Rust `hrtimer` support for v6.15
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 12:16=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> I'm sorry, but I have to do another update. My usual workflow missed a
> clippy warning because it depends on clippy warnings being treated as
> errors when building with `W=3De`. I forgot that is not upstream yet.

No worries at all :)

All seems fine in the latest -next, which is also free from other
issues we had in the past few days.

I don't think you need to sign the message itself -- it is rare, but
it does not hurt.

Congratulations on your first PR!

Cheers,
Miguel

