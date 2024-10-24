Return-Path: <linux-kernel+bounces-379239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5D9ADBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B591F21E84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE3178362;
	Thu, 24 Oct 2024 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTLRdbQY"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D01662E8;
	Thu, 24 Oct 2024 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750593; cv=none; b=oRQmRdGLpyfSeLEZhkXj7kr7W5SfKmHFpiXlsjhf4PJuilCiI3qFFN0haN8glTiTzq9IEYy7H98/edjJleU1gIrgi1DEapASuL3X6cEgLVrso6lcTYX02Jad0hwDjD96/YFdrUCh1nYY41J32HutAUstaCHYTrcm937MEXCyBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750593; c=relaxed/simple;
	bh=e4s/0aVmLKHKsb6eRnB189r9RTuimLFClX/WPz4X650=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2csCJhu3C3mewwopqXXREwohSOSSMAgpAh3HUYy+qLqP2QQJLW3Y8ZXGpJKN/uvK3j0CpifS9B1a85ihoeQu5YUdLMWg7O4QwDSwpcOQc1tyz4uBZ+9fHcOdInxAYQMh7ayZK+a7irOhNar5RsrSXVV5C6V7zUOS4P68UofvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTLRdbQY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2e2e50a796so106197276.0;
        Wed, 23 Oct 2024 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750591; x=1730355391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4s/0aVmLKHKsb6eRnB189r9RTuimLFClX/WPz4X650=;
        b=XTLRdbQYUGR/pZu5yWmlrvJbq40yGSNmBG1Pp/YmYKRpVOuyR1YQzD+3vYuYTZCVI0
         llF43DH+jrkW621G+z2vIBo9FDi4Kyj8Mg4j6MlacVhSA7n8le+guB9YulIxOAhZADEa
         a9F/a8rAJoBTB2gz/hz81JXYZhXPO6O7oteq29V7PbxGO6f8j3sTBq33SMjHtjOfsJzA
         WLxIXDtW6RK7DKIvPv+JEDUZDr8wptBmcI1nWYd1LPsIMu3eQQtgvovkHYIidoqobLyX
         e+nqk7irycbuqKthEOckH97aKmyMabqSm9w1PuBBZlSdUTgeuR23+gipzph+BjLYKvgM
         hujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750591; x=1730355391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4s/0aVmLKHKsb6eRnB189r9RTuimLFClX/WPz4X650=;
        b=jJmRVYBHxTDt8Q5wkqGIQRHQr++oELPy+p2r4o0TaBj3ioEKLYMdtfI3y/lSfS+LBO
         8dhUdKluwjuqlUD0ieWi64uZ0t6TUcJ5fkaKNSP3gl+pPMCgAWuaBtMv2mbxQmWA6O9o
         JWcvjG6AeJeG1Sch47dvavpvMwTxsiTnPMgM3w9R3mSVjyPzR/ZuNgL5WXkXOQ+2nQYq
         Tx70J2jjb07xKBeVOhuLYIsD9eXaCp+3FqEY+k8ND4ccSrAO+DkWWJn8s+u8nnI/gZxu
         XW69++t+9Z5zgXp7j8JD92CKUx8r/c63XiKydX9/Z+ADtnkqUyz7yWOYnIlyfWukAW6w
         +kWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUga36PPRivC2jsgvlzh9yqZqo+zV7A7mZbMp0Tl3BHrHbdWKX2gZiY5U/BCxbU+sO/PLvgXOjE5z/c@vger.kernel.org, AJvYcCX2MEzNgatVELwSLbTjS9aD+XDqlOD56DXGaLVoAKb1017Kr/w0JElgoa6AmS+IRMTIdN0WPW4v2N2gRvoi@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQoNiyyKjZU0UdwiWA/4DcDxuR9+H3LdPotjp60pBr8GzYOPG
	Z++1oLHEpZG8mKwSWU8WNV1LyF/m7qEMsAZhY0WN8Z8+4Nn5IdRp/4ZBl8XGR/Y3fHOiBnViyvt
	3pjJFJhFYoMhz6YNNVofAvfQdGX4=
X-Google-Smtp-Source: AGHT+IEiktjsXRRJZ9s03L8bbRvEpzeTPvd7flMzXuA99X+WplcS4fyaQyYm9BD8NNA6g2t0eG73Nz3mIqVe9kvDqp8=
X-Received: by 2002:a05:690c:39d:b0:6e2:b263:1050 with SMTP id
 00721157ae682-6e7f0fa358dmr21523897b3.7.1729750590726; Wed, 23 Oct 2024
 23:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020194028.2272371-1-l.rubusch@gmail.com> <20241020194028.2272371-14-l.rubusch@gmail.com>
 <b6a6b9d8-ec2d-4360-9747-4b44d24e0b06@pengutronix.de>
In-Reply-To: <b6a6b9d8-ec2d-4360-9747-4b44d24e0b06@pengutronix.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 24 Oct 2024 08:15:54 +0200
Message-ID: <CAFXKEHbefgGSa2LQsFR887N9y-OJnw8M1qT0vzA7kEwdkRDXOw@mail.gmail.com>
Subject: Re: [PATCHv2 13/23] ARM: dts: socfpga: add Enclustra boot-mode dtsi
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 7:20=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:
>
> Hello Lothar,
>
> On 20.10.24 21:40, Lothar Rubusch wrote:
> > Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
> > Some Enclustra carrier boards need hardware adjustments specific to the
> > selected boot-mode.
>
> Can you elaborate more on these hardware adjustments?
>
> Do the different boot media e.g. share pins and can't be active at the sa=
me
> time?

Exactly. Example, for booting from emmc, qspi needs to be turned off.
For reaching SD card or eMMC the boot mode pins need to be mux'd
accordingly. That's also why for e.g. flashing QSPI from off u-boot
Enclustra implemented a GPIO based boot mode switch. Same for
switching the MMCs.

