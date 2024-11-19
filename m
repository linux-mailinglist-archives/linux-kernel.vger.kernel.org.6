Return-Path: <linux-kernel+bounces-414532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF79D29B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8125B2921E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD21CF2B2;
	Tue, 19 Nov 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYO7HdkE"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08042199240;
	Tue, 19 Nov 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029932; cv=none; b=K5BIdVRs97nd+7SkdXLsmIN6cKrCHsl84vHlrnImneDJ46TIFtpaCjCMOPyeMqgzo1rW0lL3w1vDylTGasiDM5NcH3BPoqA2YGuIE755gWPL9rIkIqNenslEcQzkHIM6mTJvKDcHfhLEKXEOJAzOHFKbe23QxpTeXgBpQ+rqrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029932; c=relaxed/simple;
	bh=VH6iOtx79DeGUGJ4jw8WfbN0aFWGMbAWjSxfxYMIkoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv/DMCHCVJ38raB5xuJ3MyLU9vD6ly4tMqhE/AeNtO54WCgYFALLugVz1Mfn8guucXyHbDFzsMUoCg5i57ONvhMfiSKAJAa6u9AdbQ8k/uhQxU0a2oKUsgexieoL1i81tzBxZx8MVARIaLwG2w09dRgtaJGKnzMXKNmxyW/d3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYO7HdkE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea6d689d22so1761562a91.1;
        Tue, 19 Nov 2024 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732029930; x=1732634730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlci+2BKdigoipxB8Vb8O10YHCpzCE4DRKacOckTZAU=;
        b=fYO7HdkEtyD2LGbIggkRRj6gR2iLb0HifCJkKC0VU7H+PgAgVz4MCUBl3E99WIeTly
         J5GoSc2+qz3Nfo49lqxCz4dQWG+4yuNjPp5G3XSmbIdyy3xmd+I0TPyeuWKLqq1Wtptx
         5dzn7P4Z2vvx6FtLfhb4YOX1B3wB8DWsE1+n/CQ54oHIuUsv6WBays2Mji0crIV43SND
         8nRBKLI/vZS4k3/XnKv8K0VZcZf0GRXNr4bPh6Nlx/qlCizHcbjM0ruwyUVex/ZMxFUF
         EBBpBDRNYfQ3AyjASXaDt/MyECq6u3eVdN5ukNRLILJ0jPyviG51b5a0TJYdCeI1dO7d
         s/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029930; x=1732634730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlci+2BKdigoipxB8Vb8O10YHCpzCE4DRKacOckTZAU=;
        b=TEBc1sOyymwJFMe5Hgb3uwhj27xy24nOpKVPrJ55XOpXW8maSyYrLku0jqq+sQ0pwX
         Kh0qPy5UZgRIUA8Gh2fKTe47JbhF6PYLid1hjLzJ6UTxNMalv1/CSkjEoXnWOPi1zl4Q
         4Ace7aA/n5jm/J9RZXIRN1JKbiUVBP3GUS0jEyGW1TVxa4j8ASrl3drRWcOGGQ4g8f2w
         4QCdQbrfdsjeNBfvtOrR7rRRKHrMkdXIZd7dNwHAKWi3FCbu6nIk4sDqQmb0kVZs0qtv
         SGgZLBDHTGq6woUEpZyhf9v4JroruvZffvghlpUZVsz3fBSW+CMePm9R1O19jmFCejyV
         7F0A==
X-Forwarded-Encrypted: i=1; AJvYcCUANejc0gbJuejQ7LN/+l+Joa+eJ1EeMGUWnB1+r1V8FN/OkmMUorXUJR0K8dHp8W2C/I902UIdiNywpLO+@vger.kernel.org, AJvYcCURWYpiXcX7/lBUhDzqP/Bicw6851TuRttYklPneeNFS0QyCGsZoTPkgg4hWPCkE9r1tp2ed69Uq1nt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7Thifd/mqlHl5CLESKfMyvzO3fiuzRINcrEiPGwckmRz1cXq
	xC4qAL9cfAuRUSvg05z642gNnuOxiT3noD21XXFEJt96S34MNMogRqerwDjCID7xw1dfjRk3YnF
	3s4x4Ce7dbp9zne1T2lQD0yR/lNU=
X-Google-Smtp-Source: AGHT+IE7/1v+nPPImVoZLSJAIkad+M/ZIXkCwHk4Aqn15nIJP6zl1vdILO2DJvmdjbejL4ELnTacW/VVIHzDh0f9LoI=
X-Received: by 2002:a17:90b:3ecb:b0:2ea:5823:c153 with SMTP id
 98e67ed59e1d1-2ea5823c73dmr11754596a91.19.1732029930342; Tue, 19 Nov 2024
 07:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119130726.2761726-1-daniel.baluta@nxp.com> <Zzyn+i4khAqWBSjS@lizhi-Precision-Tower-5810>
In-Reply-To: <Zzyn+i4khAqWBSjS@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 19 Nov 2024 17:26:35 +0200
Message-ID: <CAEnQRZAG4Piw6NfQC7Yyc5-d2ymfq3YeL=FpV5_hNt26AzRhjQ@mail.gmail.com>
Subject: Re: [RFC PATCH] soc: imx: Add AHB to IP Bridge configuration driver
To: Frank Li <Frank.li@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	robh@kernel.org, krzk+dt@kernel.org, kernel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, aisheng.dong@nxp.com, peng.fan@nxp.com, 
	iuliana.prodan@nxp.com, laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 5:00=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Nov 19, 2024 at 03:07:26PM +0200, Daniel Baluta wrote:
> > This is a RFC patch in order to allow AHB to IP Bridge (AIPSTZ)
> > configuration to be restored after a suspend/resume operation.
> >
> > This is particularly useful for aips5 bus where the aipstz
> > configuration is lost at suspend.
> >
> > In order to configure aipstz bridge we register a platform driver
> > that will set default configuration permission at probe.
> >
> > Because AIPS configuration is lost at suspend/resume time we register
> > a power notifier callback that will take care of re-initializing the
> > configuration at resume.
>
> why not use suspend/resume callback? what's happen if devices under AIPS
> suspend/resume before AIPS resume function.

We are attaching to AIPS power domain. So any device that will resume
will have first to power up the domain which in turn will configure the bri=
dge.

So with this it doesn't really matter the suspend/resume order
becasuse the notifier
that will configure the bridge is already register.

But I wonder if there could be a problem if a device goes
suspend/resume before the bridge
probe function gets a chance to be called.

> supposed
>         bridge@30df0000 {
>                 ...
>                 some child node {
>                 }
>
>                 so child node's devies suspend/resume will after bidged's
> suspend resume.
>
>         }

