Return-Path: <linux-kernel+bounces-395578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BE9BC009
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600DBB20AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9D1FCC6D;
	Mon,  4 Nov 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2+s1W+s"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB831FCC6B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755666; cv=none; b=E4p+ewG3qjKCvA+CVJ9RFdBmZ7Z5EzyIZgouoM1VAMz+aQo47Vh8DaaRoMbs63SfC73OJEJgRP998e1V9rzXNQ2wvk0+X+vtRilhBIt5pVy/KmrMpkkPF3+9uvC23HVVG+v3m1YnxNE1xGhaifJXoCjCC4TzkXqqp2d4hL1Cgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755666; c=relaxed/simple;
	bh=OTPmTDfD/LS3/LJwgXWQCeU9scm0B9BjWhRHcAzrkVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZCefwOqhfcOnptihRi5WJAUEP1eZrC+phDQI4yTYbD0NHiFNFmI00MZmVNNbRUcvMWa2Q9AAmewSoaDiTlYnW+ayCDNIrd56Mtq/fBMRyj26p2cvZGFApPfWm+UybABTZZvoZAkoY0wFrQMgi6RCm6QtMWDQKwQCMxxUYmQ/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2+s1W+s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9acafdb745so816112666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730755663; x=1731360463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTPmTDfD/LS3/LJwgXWQCeU9scm0B9BjWhRHcAzrkVA=;
        b=V2+s1W+sEg2ZOqv8yokRzzOVi2ztsGuk+bRNBkmgHRFX2aZdUWBfiBK9C3iREgEqp0
         GpyKjiRMrc4N+fcnGY1iZLfaDOns14w1h8u8+OPrFGqlXWaW3aKB6OKacKMXJEqtsmSV
         7XO6E9tVjTxleYktBuM4KN2ogOO29luJt/YLzhNj2Hq/LF06pk+w4crkd/RvUMaueQrK
         SMlWbZnPBuvGZIvPQ1tgbpzIaNdgmk5zKxzh6j5O6fs7Q9yinIjP0H6dLygiNDw8I+jX
         zVaQiShp3Kz+vmUG99jgrLTOvxj8xHtCpHjoguyzs8iRnNEC9PX0B8HeRmxNHY/SoqIF
         VXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755663; x=1731360463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTPmTDfD/LS3/LJwgXWQCeU9scm0B9BjWhRHcAzrkVA=;
        b=ZvH24R6UNx+qrDWPRB/XValyhPozwX8fdpE4WDbmm3lDtoFKGVX5wgH5VsmcP82+Xs
         KsaINIpa+y+L3hUz4oOEInWt5yJiw1hwIBJ9D6HReYvwULAmx32e4yT/1SE0LKzHwp/g
         BhUfAEG4AlZti7lwHEOALj5hIRo/k+CVDl/+BPaJzLsfkwz10F4P5ucP6VRbfXSRm0bM
         VhmiKkuAL1rGc9r43D2/W61xxQuB4WE/bfQIpq+I8KBRVgxdKsWnhhU3fU5564Hq1nhC
         lY3OYLyGIeeBB83U2KizxbeB/N/GWjM5Z5wnlZIDH8VqqcQDQywwkZ3o4AMFYCL3AtGg
         9SDA==
X-Gm-Message-State: AOJu0YyWqB5+ajyqHiHW+H3mdSUkwFTVlsNXTSWGB+9yLwYGc0B0XtIo
	cRUNnI298Z+zZlstW4xHgNf4FvfC+S142hCHGNbjm0aNm30DzBMFDf1A/Rwt6aCvUlSGtgaeIsJ
	sTiPvVjmHUbECN98m+SgR7lWlz/+2abAjyMho
X-Google-Smtp-Source: AGHT+IH6Tlp59MLzMnZ27hz+6+YmKqJ0W51BNUAsI9hKIHPFNI4RFLogDFRMR9fTfdbVlrh1GAS+OU9Ih7UE50SWPAo=
X-Received: by 2002:a17:907:7fa5:b0:a99:5587:2a1f with SMTP id
 a640c23a62f3a-a9e6533259cmr1328157466b.15.1730755662715; Mon, 04 Nov 2024
 13:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102000818.2512612-1-dionnaglaze@google.com>
 <20241102000818.2512612-4-dionnaglaze@google.com> <91984541-504a-f029-47ca-bde538e07436@amd.com>
 <CAAH4kHYqQAkUO8phdQaE=R0qHZjKBB1uXsKR3Nq5yJxeZS-o=A@mail.gmail.com> <b0a5d1a6-39ef-2637-ece0-387582b09fcc@amd.com>
In-Reply-To: <b0a5d1a6-39ef-2637-ece0-387582b09fcc@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 4 Nov 2024 13:27:30 -0800
Message-ID: <CAAH4kHbqE4X4zDFNLdY_xRhVCCWa_qaH_X2cyY4WbQfj-OkJGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] crypto: ccp: Add SNP firmware hotload support
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Ashish Kalra <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michael Roth <michael.roth@amd.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 12:45=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
>
> That would be best as a separate patch series. But doesn't the
> SEV_PLATFORM_STATUS or SNP_PLATFORM_STATUS ioctl() give you all the
> information you need?

It does, it's just that sysfs is the preferred method of getting this
kind of information. If it's seen as duplicative for the upstream
kernel, then I can drop it.

--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

