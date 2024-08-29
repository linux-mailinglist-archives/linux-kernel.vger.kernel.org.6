Return-Path: <linux-kernel+bounces-305994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EE9637C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52DF284A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76B1C6A1;
	Thu, 29 Aug 2024 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7CW4jcp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8E15AC4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895192; cv=none; b=A1fJZYibJcKlsn52qJqy67IjB1+WcbGpsPM9ynAPFEuuhkc/t7bHG19rVwSgoZF39itG1iLZb8q4JB9Z4f/Nj6cSS74t0ibKwUnM1faudA+og75j6nIIduUsUpTVw0/xaDc9eNuTr8p+xfmq4VZwQ5RyQ2SbHMWNigWn7NAIDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895192; c=relaxed/simple;
	bh=vcV/EtgfSEZkTi7fPPscq2YKKTTxngZO+ZAgKKqLiA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCZPtWmhMD1asnbMPlJvI9cZTq3pfRIjnx4XBEvCFuZbys9gjsJgLaNFi+iHPW2C8wB2afJ0APbgG9xTLCnGzt09wzy30M3AarIs5wWa1JHPVw6SkrYq/EeKreiq5h611+n+WeUfBJUenbpgSBxmTCSlpwusU6lrbjMm/pwumpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7CW4jcp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724895188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guVZQ+4Ujpsmei6SykN5ABhiPcX8ndAIleDb2wTj8Os=;
	b=G7CW4jcpvvwlPg4CzN4qOF1ZfRwr6x7VQDjc3od/qv40E/2UwZ8wiXEwjemGATupU1ikBd
	aJdaf7OrFm9zcMX9ggCsVzUFHkZ/G5oDJnXvclPRGB2rcd4yXX0hAZbr21VsBXXaS8wGXB
	QSV0iUkDGatHgMd4u9VGXXproAsWP6g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-J_l68mQiPJ23mGCx6FzmYA-1; Wed, 28 Aug 2024 21:33:05 -0400
X-MC-Unique: J_l68mQiPJ23mGCx6FzmYA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a868b6d6882so19000766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724895184; x=1725499984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guVZQ+4Ujpsmei6SykN5ABhiPcX8ndAIleDb2wTj8Os=;
        b=UX1g+ZbKwhcrSSDQWNH0u4+rVDsbU52UNTTZ/nbdLAnTkoEGerqn1VEVJBP5a1T/Z3
         SNP0BLT0JMKbO5PykfEJ/cat3zlLEGq8vLesMUSfGyxm5AwmUQRcNDZVLiK+w2dE6myr
         a4zBAkBOkuadoQRTyAOf4FZ3nWovnCPsYYo9ib77v3POOXDTGvHN1+TmJI8nOnLdRR67
         UfHicvD1UIdFw1gjrJ06dFu7d8qxxDPW6r0w/sc4fbfC0BTncQcj5/Bzw13EEWzhrKNV
         jTgdBBOrKeKzcEwxRbrUk2mH6Jye16wF+Alg/3tiTuUX+ZodEkCUms73Dm9QfCsjUBYY
         hmDw==
X-Forwarded-Encrypted: i=1; AJvYcCUuRIKEem/oLg+ypHPGY6VxpXRAmyCYsiwuzVh4MGQPh+Bwy1q50uBEIFZKEw166JOKRBwaL4FRYgcBI0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDZiNLFiWAJjSCj9+belMT6FMcVifH8K5dpYlQyAHzH8L5cd8
	5DcjxrV44okcYhA530u4nj1u6NbT7Pu4qGrrXUfkCsp56OM0q7s2Y4K5fkWkpCKV7n5h604AAH2
	KFrK+oB/IjQHWDPIa7iL6FL9xVoEWSt9ZqYTS8v+m0n24+CTtSN5xgEM3mIGEIhCGZvufJ2WtKr
	5xll5Ru72fstzTLoqrESFKaijqUWGehkGiJXgc
X-Received: by 2002:a17:907:2d88:b0:a86:9e85:2619 with SMTP id a640c23a62f3a-a89827a3c54mr90996966b.25.1724895184579;
        Wed, 28 Aug 2024 18:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVuaa8PpTIB/qvdANkSSPCnKMBiHO0nIuN3ZJLxTk/dFv47bs73X+AN3Ug+YDJbxCeUQQYDVI5CGCDy1eBC10=
X-Received: by 2002:a17:907:2d88:b0:a86:9e85:2619 with SMTP id
 a640c23a62f3a-a89827a3c54mr90994666b.25.1724895184141; Wed, 28 Aug 2024
 18:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829012005.382715-1-bmasney@redhat.com>
In-Reply-To: <20240829012005.382715-1-bmasney@redhat.com>
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 28 Aug 2024 21:32:53 -0400
Message-ID: <CABx5tqKrsVYQ1yHw3Lkt8sT957xLv-jKwpa7VxUSJ9QRXRGbiA@mail.gmail.com>
Subject: Re: [PATCH 0/2] crypto: qcom-rng: fix support for ACPI-based systems
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, quic_omprsing@quicinc.com, neil.armstrong@linaro.org, 
	quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:21=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> The qcom-rng driver supports both ACPI and device tree based systems.
> ACPI support was broken when the hw_random interface support was added.
> This small series gets that working again.
>
> This fix was boot tested on a Qualcomm Amberwing server.
>
> Brian Masney (2):
>   crypto: qcom-rng: rename *_of_data to *_match_data
>   crypto: qcom-rng: fix support for ACPI-based systems
>
>  drivers/crypto/qcom-rng.c | 50 +++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)

Ohh I forgot to add this tag to the series:

Reported-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com>


