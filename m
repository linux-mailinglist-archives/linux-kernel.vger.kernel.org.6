Return-Path: <linux-kernel+bounces-376603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801719AB3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4207128580B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68911B1D61;
	Tue, 22 Oct 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="CeS/wrvB"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734C1A01D4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613935; cv=none; b=j5owBTJffjxol/NxHWJBwGPnQzZdF60JmbhH8Oi0GgfBufqF/ahyWoYSMS+FtH6vFNf4Sj7v3nLh7fnOdcUe9vCUyJFOTkFaYVq6NlGVpKBTWHrbdsmKR2GPIN+1PEQMws99P6+fCLr0HMD0j98E0YWn4s2LYzhFz0IBonriDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613935; c=relaxed/simple;
	bh=oBId0kI6eEzRj3jTKyuBQgHhTLTvTJesdqczSyP4k4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMEZ27jO2uZHII2JSbDZzTAcabfpBkwlHGAbl6vHfu2fMTv9ch9RHdU0BS7TKqqrTlM1LSHFUsxN9bBGBKHf6yDbErBKAZAnM7xmUGQltNyylTyN0Pc2/ajiWkPua4QTW9DWEZGQ0YA7JCh95cuMs2wM8zpPRJkc23Cd+PlE1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=CeS/wrvB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so5508603276.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729613932; x=1730218732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r81rhV0o+emtYbyrljevH5DCZbwXNnbaI/GO5rjGZ2Q=;
        b=CeS/wrvBOodR3YC3MBtf2X+mLcwb+KwivDl3lI8mCS6qDS4UKCnISlRsu4E1NZUGqo
         xPZb9FXaWiMxqpnAeKtyfz/rFEXp0pYkT7YT+fdQS+7i+/ZgzURlnQZYd2s3aAI8EnIM
         JBxlLEbSgXMH942OHtPyfhp/8+Y2SrvhlGHM97FU4FxSsXdSniTPLH1b4eXtkIkiGmNM
         KukjD2PbP7xm3RVWbHQldlxX/M4YahuMoyPxrhnR/+wOsEs9E/H41AlnNTs4y9nVRcpg
         2jTVuW+gm6aad9LDKP3YxsqSQJoaUEWFpEXooJSLwtpSOoFATxEZoaXQ0mnpIBCGNR2n
         MhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613932; x=1730218732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r81rhV0o+emtYbyrljevH5DCZbwXNnbaI/GO5rjGZ2Q=;
        b=A1pDBt4auKrvJ0C91rjf7DtlVfZ9VR63y90FtvVUtal3dR2mdcu97YKWa2LfMC3UwE
         1EmggpSpMa63A1jOPl5e/zsRkvLwb8lvbHzsmxkPIZ+nTdEbPrqWLMC+laHhx3guJvZZ
         yCuENLX+WFnKqaG/JuIE7f5cHg34NPoXShZHO/jnNlAmAWvgFZTe+EpORSJpA1ZfwUy3
         fIohLIjGMghM8H1nOM5vTCTp97ShqHJ+MIUWCGWbWYuBt2/+lXxIEP+WeZcgEm1P5xiA
         9fH6YfqRGZfi7BS2gYmF7pNp/5OaAI3lh1hFdf+OP8COgWpyx16Bga8r55phMmftW88Y
         jimw==
X-Forwarded-Encrypted: i=1; AJvYcCXGfis5Eiws1rAgzvXIcF3ERuPyRSbdKmH/gX8IbBP30LHpoIJwNd78xM2RhGewGCr2Nuf1y1YXp5X2ojs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+aggyG5xyFD/pH4g6oDpL5n9BywnuPFoYKlZzsgPpj2TPwVV
	RPjDV3L9s0jf5HTQ1lpk8gu4mNKUi7K1gz0c30u8FAHo7iwIyQ+/cMw9uX0mAPXN/1C3VLiiU43
	YiVrKYYYbAKQynm0Lois+MiLDzCPM1EwACi1pUQ==
X-Google-Smtp-Source: AGHT+IH0UpfHIQhpnW5gYZvm6J/H5tiIErVcZHLNG/AaqKaTsThrGzBI/QVNP98Z178HLwL6pTc9ogjN74jcT5gby3I=
X-Received: by 2002:a05:6902:20c3:b0:e2b:a26c:b800 with SMTP id
 3f1490d57ef6-e2bb130aa1dmr13596162276.20.1729613932534; Tue, 22 Oct 2024
 09:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com> <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
 <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
 <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com> <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com>
In-Reply-To: <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 22 Oct 2024 18:18:41 +0200
Message-ID: <CALNFmy1P-K6j1q9dm92iJ87h9WnjnvnzwhC1a3jaugahFhv6ZQ@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
	linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,
On Tue, Oct 22, 2024 at 2:16=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Peter,
>
> On Mon, 21 Oct 2024 at 19:57, Peter Robinson <pbrobinson@gmail.com> wrote=
:
> >
> > > > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tabl=
es.
> > > > > >
> > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Changelog v9:
> > > > > > - default to BLOBLIST_ALLOC on arm
> > > > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > > > ---
> > > > > >  common/Kconfig |  2 ++
> > > > > >  lib/Kconfig    | 15 +++++++++------
> > > > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > > > >
> > > > >
> > > > > This is fine, but please disable it for snow since it needs the F=
IXED
> > > > > option for now.
> > > >
> > > > I cannot follow. What needs the FIXED option and what to disable?
> > > > I run this patch on the CI and test_py_sandbox tests are still work=
ing.
> > >
> > > I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED s=
o
> > > if you make ALLOC the default you need to change the default for snow=
.
> >
> > Simon by snow do you mean the device (configs/snow_defconfig) snow, I
> > think Patrick doesn't know you're referring to what I believe to be a
> > device config.
>
> Oh OK, yes that is what I mean. If it is too confusing I can send a
> fix-up patch after this series is applied.
>
Oh OK, got it.
I wasn't aware that BLOBLIST is already used on some ARM devices.
I'll send an updated version.
Is it possible to migrate those to BLOBLIST_ALLOC? Any reason they
would use a fixed address?

> Regards,
> SImon

