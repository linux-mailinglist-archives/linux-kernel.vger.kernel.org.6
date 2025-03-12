Return-Path: <linux-kernel+bounces-557214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F0A5D529
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFF51774DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3E31DB377;
	Wed, 12 Mar 2025 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzTHzkJ0"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B71AD3E1;
	Wed, 12 Mar 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755373; cv=none; b=gjSGTxXrlinM0coDsWVtLSqf1crXImd5uqz+AFLFjCs00mePGisvUCPkFMUIJqS9Mx/jvjx4EJeCHh/FH+7ubZrQ8zAsq4BWrM7MSAzT0gGUgEjymtLq6TfLIRVbiLgrRxhLBKIVsCev7hiif/oKGCbhks54GmjHXV2ciSneVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755373; c=relaxed/simple;
	bh=UdktUbvRdQs29uEXaEIVc9r1gnuWGS/ME8nNW6XPENo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AW9gXDoI84RuLdZjoPjx7uKEuHO7rkrSkdVavcCSIDCpSnG1r1jIFsrLph9HV/YNRoNDPMOmvj6v75EuvYYHrStNFoCfORrzFJC3kc6UG2FrYTHm7yF1roGVRwp/eliZbz8RQWjwwE3uFWD4JPsTjgeURgooRLm6umPdv5kkYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzTHzkJ0; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86b9d9b02cbso2451005241.1;
        Tue, 11 Mar 2025 21:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741755371; x=1742360171; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdktUbvRdQs29uEXaEIVc9r1gnuWGS/ME8nNW6XPENo=;
        b=UzTHzkJ0utN7yTgVo1Cssl220CqU0eOb6xDCiNuRaFKJkOeWfslMDS9BgI/Fjf/Toq
         3UopSRpfLaNuYRLkJ+gcNX6i5S9Sr1IXTEFcCngZLyHN+nfXluGMguTQ0+1IMJrNgT+y
         x4eD47ALcW6CeC8x4iSsVqzbeuHxqYdtIPWzHVFw+t7ZBPBe3RjNeAuuT7W3Gz547Xza
         c6/5z5Z4fD1I5Up28RyPfpgO/ilr8qi3+0ukQbJXJyqGGaKiKt7kJSSKJDgTpHYVCvk9
         Y9qsW9JYE4L9N3CX28PwSfVaDVPzO2UNU80np/QrwdU8wMNOQ0s6cQh1NpvLZG7T+5S1
         /Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741755371; x=1742360171;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UdktUbvRdQs29uEXaEIVc9r1gnuWGS/ME8nNW6XPENo=;
        b=kdoo6vfKzwIVzL3FkFYcAV9o4XKCnTtJHTXuwCC/EJsyyvbIttHQS6pBXAEIPTSwno
         qDO4+XVcXSVahUWQvi2DBo43OtBrEo1ne+wnlJV2fsvcsozSP8b7BRmbHcR/Ak/09eKi
         M0IwKWvhMRxYarveLaDWtFLthUyJLd1KMR5PKz6pJXdI7kdZ3SI+/OFdFX/Gzg0vj6RY
         HMduQUPpplxbR1Fz29FujVgscnbgWJQSf397qH+m7BQXeLstASU9YTqGc/lGuoyULM03
         N66JpI3E7NG+kpelZxC+TB0EMIoTObu2gy4T5LO+1Z6Ep1plv5CaGsYPMKmbpiPAULsp
         aUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWyko+1PAa2JRa8WpBylUveDDVOILUovpMBMQUHBAsGi3u+KLPP5eRdlpCySj96RjgsZwoQoyW5f8UNzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWB/bAi+R32XiKzhL/MBhcsrrWxH+gwB0ANKN/XSklddsz5H4
	OEoIOICOFQVZFAIMsQLGzRS0qRoU/Q2EXHTrcudry9RFoolI1aXSOJS3IrTr
X-Gm-Gg: ASbGncvTv1u2Vj5EWsncjPuHhAzwcddrPM0gdiuJspeQWx3oL2lxO9DK7qFyVF16BVB
	vwWMcnKvAVF/I9VhWJ8zXSOQqsXSSgnwJFdsAPixgrgI/YsQuK+AYwl7YMMtON5+bP7cKrH3WnG
	RCjdoBF3+5vxZVh0novVMCug183iZeWFeRIFdqSVhKdXOUO1axyRw0LOylYgz8GlHi4FI5F120a
	yu1coiojCtkDHTovsikUt8ZwEyiI95aFpW8J74fWAIKEe6iOiml4Ou3Hy0Ea1FrW1wEnDf7dNFz
	00uhizHi6los/2mitBUYwwof+3gvuGFCgkJJ
X-Google-Smtp-Source: AGHT+IHsmuhw6E4jVWAIFDyx8ZIakSvJAAN5jXQx6tVZbeWvMo2pkJ4ZEbKa5EeRj8M8onhQJTtC3g==
X-Received: by 2002:a05:6102:808f:b0:4bb:e511:15a3 with SMTP id ada2fe7eead31-4c30a5a72fbmr15652446137.8.1741755370583;
        Tue, 11 Mar 2025 21:56:10 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bdf83asm2587347241.8.2025.03.11.21.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 21:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 23:56:07 -0500
Message-Id: <D8E0QXRHRR61.2WEESGHZM0RM7@gmail.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel parser for the BMOF format used by WMI-ACPI
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, "linux@weissschuh.net" <linux@weissschuh.net>,
 <akpm@linux-foundation.org>, <mcgrof@kernel.org>, <russ.weight@linux.dev>,
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <a18f2f93-c8ee-47af-9446-97e3714fc275@gmx.de>
In-Reply-To: <a18f2f93-c8ee-47af-9446-97e3714fc275@gmx.de>

On Tue Mar 11, 2025 at 3:06 PM -05, Armin Wolf wrote:
> Hello,
>
> since around 2017 we are able to partially decode the Binary MOF (BMOF) d=
ata used to describe the interfaces of WMI-ACPI
> devices found inside modern devices. This initial reverse-engineering was=
 done by Pali Roh=C3=A1r and implementing a BMOF parser
> inside the kernel was originally also proposed by him (see https://lore.k=
ernel.org/lkml/201706041809.21573@pali/T/).
>
> As part of my bachelor thesis i finished the reverse-engineering and crea=
ted yet another utility for parsing BMOF data.
> This utility can be found at github (https://github.com/Wer-Wolf/tarkin) =
and i now intend to use it to finally implement
> a BMOF parser inside the kernel.

It most be a very cool thesis project, I'll look into tarkin.

>
> There exists a growing list of WMI drivers using quirk tables for detecti=
ng the presence of specific WMI methods on a given
> device. This approach is maintenance-intensive and not exactly user frien=
dly (end users rarely send kernel patches). Because
> of this we need this BMOF parser so that we can check which WMI methods a=
re available.

A BMOF parser in-kernel is definetly a game changer for a lot of
drivers. Can't wait to implement this in alienware-wmi! Please, keep me
updated.

I wish you the best for your thesis :)

--=20
 ~ Kurt


