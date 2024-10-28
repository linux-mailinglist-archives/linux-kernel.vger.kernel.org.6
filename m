Return-Path: <linux-kernel+bounces-386071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D89B3EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792B9283ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F71FB8B4;
	Mon, 28 Oct 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+xNnfzf"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A41F4272
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159862; cv=none; b=tlLNZs6ORJFHJAuSLvQCWGGVAbOdKJ+B0Zpw6jO0VEtRCCN9RJ/fT/4oRmWIaIl8xwOKqk/uStYgTWpAy+Ibq0vZKtSIjqQUKKkYir+xOweeXx92E0rE+ZfxXAy7ZeeJLwyyl13eHjSAxYkqIhrCuVyBsTw9LXBFaU3eTfBmw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159862; c=relaxed/simple;
	bh=6Aoxbp0kWpazqGFiXPzU6HehV04uEOAUZ0Pe1G18BRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7S7L1ASru3k6sqf2sU2NJV1kZLeMc4WJyf1xy7YnepxFZs8FUQQ+vg2I+z3Di364ygJlZnzw3EKxEKtKVAKuK+5PVtsuLHnvOrE9bdwavHa70ecLx3/6SJnhrArqBbVK5MncexfoBaRUcIUN6mxE+9sgl0KokuGKXB8fs6I6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+xNnfzf; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608dddaa35so79151cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730159859; x=1730764659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydE9Zx48AhjgMSLpCZz5nUZF4H+ev27/Zss2ccR8j5g=;
        b=M+xNnfzfOpMOoxvdWN4vElG7qISEMAvG6TFGMPDW9qgxaJzKIZhbavhe0erKp5SH/F
         TJHM0eNV7vGgh9N9qJNxNTiUPmwPJK1S4nKQuJIAusN3zordEfeXVF/j9ekNbAo3pim7
         YoUY/og46jjB4A8MKMB+O0dfOdV2mgOPq0diKl1Rr+RTGcw47gtWRIPsnZOzsHc3njIh
         aVyLDtS/fQwrNQVZruQ5r63ItPXpb/5vJiPTCfcDo5eaWrMRUBw9iop7ehmxGRFrEmP4
         eh20wbGl8Qi1Qggi+vSG73H5skzZuEUwgXRC5ZKtI9piD4nmAwwVWF9Dqok1mdnp+kZi
         mGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730159859; x=1730764659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydE9Zx48AhjgMSLpCZz5nUZF4H+ev27/Zss2ccR8j5g=;
        b=AWY5pShOFHLxVdAcsC7zblOtdTopDyQmanZAPmTXFpVOTkWNt8SC1X5fBhLXUvQbQk
         AMtReFf/Tnoe8qiUK5EJxctvhG9mG0KygVn3jfTmROLFiv193axhlZ1IcG3BfaDCSj5u
         B/MEe8NzAMDi5M5lrxH5kZO7q1uE5cWtPeAmt8Bx24iLUMRh98K3eMvQLY1w9HRPzBlj
         Y3GDP1QEvex4Yn1KA3oJSeGUO4bBQ/9NdNe1T4FMegGUllkO5K5177GwoO4Z7L/jJ8WV
         0ygQix+y23RDSKDXTF3duIHRJTr6q2ElAw0C5se/fb/KZARSJA2p8pKhYCodcQbQDpsS
         MXcw==
X-Forwarded-Encrypted: i=1; AJvYcCWPYwPR3Qh4w57Au9kfmE26xVaHh08V5u8D+15Q1CX1zcb/sDcW0n+O5QlSLshPxKJt8MX6l/JwSVS7nbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnOsatUp+5bEoIA557duFPA4bSvqlEyxqV3e5yhP7Q464rUqo
	AlsHSZFP99Vv/8snJiq/qPrlyfQrbf7zUb22jqiaSSD0wfi3zZ8pNRaNw5Oj1TNyYEOoPi5wrGz
	zqIYlmC0UYiY9p/uXhhPCjQpY6B8GKqiH01bT
X-Gm-Gg: ASbGncsk40wsqxBrsxFWOBTUPLEwnSWH2gpYAUfg4vDN/zLZ5o7/i+TsLdLBniDk/8M
	I4D2P8TCFJ2f5AYZ6kdBuuoqgYA63iIdogNiNZGfjj6CUDRO9dMp6KzGm+myF
X-Google-Smtp-Source: AGHT+IEPgv7Vt8d6wl8U8U8BGXQBUGrd/LAaapOLRCni+GXeXpNm8YpivIZUTmdppX3eVCcTRknbKICnmERI1hZbOfs=
X-Received: by 2002:a05:622a:47c4:b0:460:4734:c487 with SMTP id
 d75a77b69052e-46166e41539mr658121cf.29.1730159858954; Mon, 28 Oct 2024
 16:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016220944.370539-1-salomondush@google.com>
 <CAMGffEmEJp_oVAsbCVV9PKs7vOKWLrUhRGcBGoUSx7+t4ZtsQA@mail.gmail.com>
 <CAPE3x15ryZw4s=qA=7HSDyZZXf3FUz2Ms7cxXHjc_R+UbPZTwA@mail.gmail.com> <yq1frokf2ii.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1frokf2ii.fsf@ca-mkp.ca.oracle.com>
From: Salomon Dushimirimana <salomondush@google.com>
Date: Mon, 28 Oct 2024 16:57:28 -0700
Message-ID: <CAPE3x14n16PX=pkLVJ2x2T3VZYKfbLUk94wd5_5S9WDCSpmQ3Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: Use module param to set pcs event log severity
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>, Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bhavesh Jashnani <bjashnani@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

These are the log levels and their descriptions for the pm80xx controllers =
-
0 - Disable logging
1 - Critical error
2 - Warning
3 - Notice
4 - Information
5 - Debugging
6 - Reserved

Loglevel 3 helps capture messages of severity level 3 and above. It is
not expected to be verbose and helps avoid the log overflow problem.

For debugging, there may be a need to change the loglevel, hence
making it configurable.

Thanks,
Salomon Dushimirimana

Salomon Dushimirimana


On Fri, Oct 25, 2024 at 11:45=E2=80=AFAM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Salomon,
>
> > 3 works well for Google, but a different value might be better for
> > others. Having a module parameter would allow users to customize the
> > level of logging based on their specific needs. If that is not a
> > concern, I can change the default to just 3.
>
> How verbose will a value of 3 be during normal operation? I don't object
> to capturing more information during failure scenarios as long as we're
> not flooding the logs with noise when things are nominal.
>
> --
> Martin K. Petersen      Oracle Linux Engineering

