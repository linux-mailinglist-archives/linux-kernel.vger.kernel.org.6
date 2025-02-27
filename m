Return-Path: <linux-kernel+bounces-536693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C7A48311
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0674164424
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FC2356AE;
	Thu, 27 Feb 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDUtWH9p"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805026AAB2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670515; cv=none; b=JFPbr1HuJVybvOsptAthIDS/AWsi+yhzYj2+KW4saA+WRiGIIyHToN8stboacagErfyo17Atqf7Rkb0UFBYbjO3MtRTrUoIdUF4R/W+3Gg2QS1kC4Mp+ehO7T9rUNYpPHOLpuBnsdGFGeLEq1LrU1ICP+hLg1rVHNVAMTVx6dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670515; c=relaxed/simple;
	bh=THOgoUCPQEdt7Oe3vGYp8azSrWCOlikK8ngknxVD1fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usspNUZtO4rFrapni5VMK1L3ww9U3TRnp6PvcSbJkRtTEGmOUh7/v4z6zkJDpmyunp6CLQFL7uy5SbfMUOqBdSb3Ub6a26bDfrcf/uvuJguGq9RZ5+ukKIP+W6yXjzF8gVVW4b85a7+mufvI1eJeFGCKubj8jVhaYvQPGVqhFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDUtWH9p; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-546210287c1so1037237e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740670512; x=1741275312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJAVQXLJF41TwKPGAbCYXhqrLx4dqXncJmXzY8Kudhs=;
        b=eDUtWH9ptRNs57nokhVDTCkaNR1Axib7A49Wzdlk50+OKtfZVguV5xDsTdDO3yiMQ6
         sc5HRdo2VTuBcJOWsbzYW5p48jURSWNd9inq/E5nf/IbgbtKess7kqQvnTEHFjIZcJTk
         08uAuu/dyDxQf294WYch5qfXYV22zrfRZcaT6/WZbSbFKWa0C8ZLKC/wStE5iVmuhTry
         MUMhig0lg6xSvVmfnnecuK6qi8CD9zR7cdtPi8TP3XbMMcLZ4hiixVb5dnrq7iXg2Lnp
         Z2Y5Q/fOxaDV2KixMwDzyLPPklN8RPRJ0uDxZ87kQh3YgqiPYzpHHsq02mJNsSeznk3H
         tB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670512; x=1741275312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJAVQXLJF41TwKPGAbCYXhqrLx4dqXncJmXzY8Kudhs=;
        b=vNGgwdECppUCfnFv1CsuxUOb9AZ/ZdRYabCycuQZcthOFYY/9qwaTSFZ8EU2tzut59
         yGHvdOWdhA3napILUGF8vI0E8XTUu+ugHTdzEM6m84ApMhtYEjpV871N6+DeZ2bxg17p
         Avme1yOASAS6j3q/gQDvtA8QOVwEsZFLtU0Qb5IQwwqCizIYyGNT/5ClmEyR1ZsjJXtM
         nDLYyZPKsvvVelwnFc/eNmI8Wt8C7vZ0gM3SjpHrtVNq2od9Sg2lMX9FpcuChKLIFZNy
         +cwU5mj+owAEwXCRElta7+kT4QnKCI++g4vXjoAPjP1JwnmgXFGE4T8wxZQiOGu/FeqM
         HgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/j3mCeE/Zgn5a2IofpEfa8nSH1jrCESHCmlv63ZeVwgrJ7QsJuXSPexcsdqKT1pcfcauREvY58DQe1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDLd+Lp7P6CwJ7Gwu/cuYubTN5e/bP2u6UPKYmXl7unMggAeI
	uuJoPUkTxAuk39wfjoyy9I+tih8uAMJdKZSP8RabmMxVM588CUDpDQiRuFYKwplSz38wvIx0uk3
	MsTXPrsxrOhUrpmrmUtCus+4oO4JobpJa
X-Gm-Gg: ASbGncufvsiL8wa6LCdJZk21YsF3pE+riW8jJ+qKYiLs5nQF8O6VwtZQuZHS4Oqet0M
	JKjS/4TBdDEcSwXL3JNTBr35KHN5jZoUVCwrHu3m0k9brzePZY6YrJLc97krCM/xgbnXZY3y0ZC
	OUFP/A7RM=
X-Google-Smtp-Source: AGHT+IHkioLSrJ+spmAVkzxsOQKumBkTuuyrkNOUQFzsV1KMTNbozWKdNRWZKXkA2/o4oBp7wYg8ktbccLWtdz/oMp8=
X-Received: by 2002:a05:6512:308a:b0:545:10bc:20ca with SMTP id
 2adb3069b0e04-54839147d25mr13703939e87.24.1740670511542; Thu, 27 Feb 2025
 07:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org>
 <20250226225605.2000-1-sj@kernel.org> <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
 <CAJGd784+kQ8NXSp1=9tZW+4wYvTh6SkW7ySaB0TVGcinjjcEdQ@mail.gmail.com>
In-Reply-To: <CAJGd784+kQ8NXSp1=9tZW+4wYvTh6SkW7ySaB0TVGcinjjcEdQ@mail.gmail.com>
From: bus710 <bus710@gmail.com>
Date: Thu, 27 Feb 2025 07:35:00 -0800
X-Gm-Features: AQ5f1JqUz4ttcsCrVT7lObPG6DvWRZ3OCO3KBiTMyelf27g9p6d60kOIKH2WNB0
Message-ID: <CAJGd785bhaXV4=R8dL-yNdQLN3YsJL+L+XQH3jwqYdYCCy5LNA@mail.gmail.com>
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was wondering how others live with the git send-email all the time,
so I searched for alternatives.
Then I found out that some people use terminal email clients like
Mutt, and learned that the inline patch is the right way, not
attached.
Let me do the inline patch if there are more chances in the future.

On Wed, Feb 26, 2025 at 11:03=E2=80=AFPM bus710 <bus710@gmail.com> wrote:
>
> On Wed, Feb 26, 2025 at 3:07=E2=80=AFPM bus710 <bus710@gmail.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 2:56=E2=80=AFPM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > On Wed, 26 Feb 2025 13:37:03 -0800 Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> > >
> > > > On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wr=
ote:
> > > >
> > > > > From: bus710 <bus710@gmail.com>
> > > >
> > > > Full names are preferred, please.  Actually I think it's "required"=
.
> > >
> > > Thank you for letting me clearly know this.  I'll request full names =
to DAMON
> > > patch authors from next time.
> > >
> > > bus710, we could still update the patch before it is merged into the =
mainline.
> > > If you could, please let us know your full name and if we can update =
the patch
> > > with that.
> > >
> > > >
> > > > I'll apply it anyway due to the patch's minor nature, thanks.
> > >
> > > I agree this is a simple enough patch that the name doesn't really ma=
tter.
> > > Thank you Andrew :)
> > >
> > >
> > > Thanks,
> > > SJ
> >
> > Oh, yes. I was a little worried if I added too much noise for such a
> > small work, but I shouldn't miss this opportunity to leave my name in
> > Linux history.
> > Let me prepare a new patch as soon as possible.
>
> Hi all,
>
> Please find the attached patch.
> Based on the latest one, from @Andrew Morton I just replaced my ID
> with my real name as well as updated the subject.
>
> Thank you,
> Seongjun Kim

