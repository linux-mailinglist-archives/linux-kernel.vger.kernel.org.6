Return-Path: <linux-kernel+bounces-348543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55598E8DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F4288A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EEA26ACD;
	Thu,  3 Oct 2024 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHJIV8kW"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D4208DA
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727926329; cv=none; b=bOzM52q1t15/LxmBAyvp9TuFHkaL0MqsGp6XaBy6qFT0RYogIhzZpQeQqVlmuMm601C86OpVXR4dsPheMvYLbaBleD/EwRLObgS24A5T1Tw2QbScGYq7NWTdWS7T4FJEUI3zPrCzL4bTONL/FO8XeJMpGvXh11zFb1rX3Rk7LQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727926329; c=relaxed/simple;
	bh=sPqYsxGw4UKWZVGhmn3EmQz2XgH0EJItdTfQ4iscmkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bb7ULWMcdQcNNE08iFemk9CjkM+aCuYB7yMiCkRKiTnoQygfoAXS/6wQm8+Jr7i4113XIk2F7epCNzrs+bX0KPHmdsAStSXuSTvQXG8mcgDi3IgS5lHK1aZ3qqeYkq7uq1l1cTOFBdylSiCx44sshyknPWs1pCS7GQv1VLtQsnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHJIV8kW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7193010d386so465639b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727926327; x=1728531127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGpCecy1PgHkxzgOvGnovEBjk6UmIsmI1Dv+w1TXrew=;
        b=gHJIV8kW8+H4vRNua6FgA4TS6yKt42fctgXFke4OFVXUbT0FVBmbEo4ewg9EzDGk8Z
         xda0MbBPKX780VXdWusuNhjYtip7L4HSeS9R8hUNwf1PYesjPqHO6P9sLtDzlBrIQfNe
         FudlDWUvq9MwDmHq3khjjH7lMwI5J4FkbY1J9Hg3UK+2oMxUmAxdVoCb4kHOqPMh3nPU
         Y1wO4QlmQl7wy5rpLiXkb9Ue+KJ7jJPAiJXoDv7ueWiPI7JLinvH/B3w1mQbj5PbafWV
         4BWteX6FRiqREdswAP8kUgH7iAwu0ndB4MZsWyr55zC7QIIYMSM9fRDpy4EXbkJY05Ai
         jRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727926327; x=1728531127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGpCecy1PgHkxzgOvGnovEBjk6UmIsmI1Dv+w1TXrew=;
        b=BAo2OFV8S2wFKA1etpyDnC7ECUZTttejC35WwkQanZArPCqoHJ93VvTWVulvyIgkgc
         kDSwu93pxsPz4i0xbXOUp8aTidXw19/TUlkjH5EZzZfN1CROdu13BdWcwAPKiS+Ms9pj
         FX9oGR+A5n9auqlc/LxJT6H4FTpkX4+Vksp7qBppoAqGcmUJetBWkn9f1P/YXewGiU5V
         4rFo1uAqWdI6hZxAx7yQERSZL4qQTouZjoTNbGL61MMWD26powjnS2Cr4QHfo1jAbR9B
         vdehLANBO7J9hcMLW8n7zJAoMwqq+5T6rI0ocirZYx5zfCCPGHjsfB7KnDcBfb1e++9c
         nMHA==
X-Forwarded-Encrypted: i=1; AJvYcCU0JIY3oyEZY5mDQC3yOCFXYt65EnGqKvprEW3R6i0WJEjKUqsDVwEpaDYvhMsr6Nd/nKKVWc1mZADvqag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojLGPxsttuwBPn45AGToYdtPrTR+gNbuuaxHgXjnGfs942qWn
	uQJtH2APNdre/9XR9NcRG2ih5GkV99SPIqw/AgQpZrQrAxOfWK6M4Frjud4DFDQxjuLPnGIyCWf
	DtY0MYL6aOlmYLhcxKDHP3RBfTTs=
X-Google-Smtp-Source: AGHT+IGxU23MVhIzmikqUZ1ChMRkDvxsLqd3I0IYnv2mo71SHn/bUXBPNSL0ZoDwXDXOZ0TQSVxxghjWoD2jNK+gVmI=
X-Received: by 2002:a05:6a00:cc2:b0:70d:2796:bce8 with SMTP id
 d2e1a72fcca58-71dc5d5bf5fmr6871110b3a.20.1727926326883; Wed, 02 Oct 2024
 20:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002132820.402583-1-sayyad.abid16@gmail.com> <06ffa5a2-f73d-198c-3e7b-178e4fcec1ed@linux-m68k.org>
In-Reply-To: <06ffa5a2-f73d-198c-3e7b-178e4fcec1ed@linux-m68k.org>
From: Sayyad Abid <sayyad.abid16@gmail.com>
Date: Thu, 3 Oct 2024 09:01:32 +0530
Message-ID: <CACVUEBnohcsyiPpCF3QNdQeXXaU6pvVOY-5X8CHmRSvEJxXoyA@mail.gmail.com>
Subject: Re: [PATCH 0/3] drivers: nubus: Fix coding style issues in nubus.c
To: Finn Thain <fthain@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:25=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> w=
rote:
>
>
> Hello sayyad.abid16@gmail.com
>
> Thanks for taking the trouble to send e-mail messages to so many people b=
y
> use of a free e-mail account.
>
> With regards to kernel patches, can I request that you --
>
> 1. Don't run checkpatch on existing code
> 2. Don't send patches that break the build
> 3. Don't claim to be improving code style by sending patches that violate
>    code style rules
> 4. Read the mailing lists and study the development process before trying
>    to contribute
>
> Thanks for your consideration.
>
> Regards
> Finn
>
> On Wed, 2 Oct 2024, Sayyad Abid wrote:
>
> > This patch series addresses coding style improvements in
> > the Nubus subsystem, specifically in `nubus.c`. These changes
> > aim to enhance readability and maintainability of the code.
> >
> > These coding style inconsistencies were found using checkpatch.pl
> >
> > Changes include:
> >  1. Improved comment block formatting by aligning `*` in
> >     multi-line comments.
> >  2. Fixing assignments inside conditional statements to improve clarity=
.
> >  3. Correcting the use of tabs for indentation in specific functions.
> >
> > Each commit focuses on a specific aspect, as detailed below.
> >
> >
> > Sayyad Abid (3):
> >   Fix use of tabs in nubus_get_vendorinfo and nubus_add_board
> >   Fix use of assignment in if condition in nubus_add_board()
> >   Fix use of * in comment block in nubus.c
> >
> >  drivers/nubus/nubus.c | 94 ++++++++++++++++++++++++-------------------
> >  1 file changed, 53 insertions(+), 41 deletions(-)
> >
> > --
> > 2.39.5
> >
> >
My sincere apologies for causing the trouble,
I overlooked a few things there,
I will keep a note of your points and make sure
that it is not repeated again.

Thank You!

--=20
Abid

