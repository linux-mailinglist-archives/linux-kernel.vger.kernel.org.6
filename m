Return-Path: <linux-kernel+bounces-412637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B4D9D0BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12DA280C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1181741D2;
	Mon, 18 Nov 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsdxyVnQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8025760
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922324; cv=none; b=soHFtWHIni3hF8D1KJ6RzaYPu2SkNHFyvYOXIcwtajoEEe24jvh8mBrlhv1dylq4oSF5hmJQ3VQDtQetNfQBmtvH9vERAgTfLSJt7/4wRC9RfK1uJywcJm+YuZAvLlIwJY+pxn6eK7nK37HfDZDftSvSeFF9yzm5BQs4rYrHOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922324; c=relaxed/simple;
	bh=pYHA6n4L9docqTOeBE8w5dg+WCD0wXup4DJqnG0btvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qj5JLn6IGmJOFScxQPVQtimWub7SREDn/+foRgbJT6DHTc/Zmnlgzlkh1pNKLbv9Omb2OsE07+w4EE+H0QA+F68tfLAzgWkH73IprAkS1Nhb/xIRHFS1R3qc8poW6sITVRD24SG4cAids9SnVMIhEX0gqbmS732nZ+HkmMP3W78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsdxyVnQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a68480164so593042866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731922321; x=1732527121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy4ixObamn97nOsBXqbG75Py+IFWINDXq0gYVa7tddM=;
        b=IsdxyVnQx9bzDNJVl+K6u8+Unn2gAVRLD9Dq2Btb0v+aqAx/YBbqdvTE7UlVucNjtV
         uOEcCs/eFB8pxu4Mw0qyQs+sWT1wRN48JQCwYKCaVA22tmr1pkUD5LKZ6ZvdG9CfeG7E
         1GDiJl8fM1sXXtw+6W1soubLULU61GHfKiPgGfCr8Fvu75SgnVftypa5cupchy/7WXxf
         +iVtT7IoDI/CK+r0UbHFkXJv7dsb4FQu7B7NB30bD92F0Zz28HAX87usxnJm2qjQnwdZ
         9Dp/UMco9Z1GCxkqYjPR2OgobIa2IAWvpHFB2fhVTUiuON65U/P5dCp+owIF4zdeKwQE
         td8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922321; x=1732527121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy4ixObamn97nOsBXqbG75Py+IFWINDXq0gYVa7tddM=;
        b=Gb8uvTDZVvT8JgCv43Mq24+PfRG394PGfTq2ryyf81KDlswDUdloxUCjVtebdofA2E
         zIFLXGIgirCvDXx7ai4zUDTa39eW4IvuqW2xH56jY5cFqsQHh91Arw1MCv+f4TRONjOQ
         8TzRsoDJ3PE2zCEDA7NugFkxnhRikO+TUSkX8Oc7ua1JCVkWQKFuT8AwGXZY0FrsAmHR
         VFDiX0xynxl+u1zdeFHiK1QNVG4pK9jV3XuGs3VI5rehtYMNeYZ851qhNQY2f6XUpV22
         xzelMyQ3OSHXr269+mSvbDd0WIHGh+vRio/k6iBhVQiLKSdzGmHSDxPrjicc1yoUibUX
         w6/w==
X-Forwarded-Encrypted: i=1; AJvYcCWkFkUYLo9VY03gVfRcodjTGA/pDKt5VrlyQlVysirJ6oN+gWHGutz3kHYW8GskYWsavhxZc9fARTn/+7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIA/pVT8e+qKCSPQNekw27PKV46wVieqitydnO26NgKNqx8Uji
	hrpcTd0k1GP3qfDZA60OUQxeRv/KmiXtNSsqPIdYRYeoWjdosjxhn8FgzNgKY4aO2EeFshlJd7Z
	kxZIHIyqbaQHkWEfAPzJd1YHs2Xk=
X-Google-Smtp-Source: AGHT+IGC5RYyMKK90mJAubvXog6tv+abEEuNMCzFa4Ieqn/ccbsHboNCDwZDKJ1qvit9SakzhQM3ud23RXYyB7QJKe4=
X-Received: by 2002:a17:907:3f8f:b0:a99:ebcc:bfbe with SMTP id
 a640c23a62f3a-aa483485e4bmr1020829266b.27.1731922321256; Mon, 18 Nov 2024
 01:32:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115083727.30005-1-brookxu.cn@gmail.com> <20241115170411.GA23437@lst.de>
 <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com> <20241118062627.GA32372@lst.de>
In-Reply-To: <20241118062627.GA32372@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 18 Nov 2024 17:31:49 +0800
Message-ID: <CADtkEefQoDY5k5_V4QEGVD+DD2iTjMLWj8KXO+PnuVT+0wHsjA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=B8=80 14:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 16, 2024 at 08:49:12AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > Yes, now we have remove the old ns and log the change to dmesg,  but I =
am
> > confused why not auto add the ns with new UUID, we should treat it as a=
 new
> > ns? so that we can avoid an active controller with no ns, but actually =
it have
> > one.
>
> Because as far as the specification is concerned it is.  The whole point =
of
> these identifiers is that they are stable over the life time of the
> namespace.
Noted, Thanks very much~

