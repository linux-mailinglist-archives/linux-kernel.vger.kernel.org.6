Return-Path: <linux-kernel+bounces-370592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F99A2F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390581C20AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACDC1EE00B;
	Thu, 17 Oct 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfTi4EgM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F211EE004
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199405; cv=none; b=VH2waD5L6xqWlsw3QPHZn2juWaMOmG1VBE1f5rYuRkrnBedO67Mm5URxNr+J0H52o1Uxd5e4WpwwNfaFzsuPHXfwhIGD2pEJgw24BpoHAQ2hcp53LDIpNKfrMiWbZfSmmxidUnpLZ8XERJxr7r5hIND+5IPIAqM3KMYKbG/+nSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199405; c=relaxed/simple;
	bh=ARAMcbBBVWPI4bLa3Hv8hPS+A7RGq10YHLJaFdSd7hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAtWyRuX3oob9s2x8zF3Bk/vP7+cZ+t8gLuh1sU4Mopaky1LgiG8pCbBbQum09XJXEBIsn/FcjltvrZnVsrwCm9/IDH3zw8qGarJfnFx45B8xD+lrlE7eoJW3DV9lORwL8f4y/T793Ey3XugDvy9ZCV4sd5kFk0fhW63/vyZFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qfTi4EgM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca03687fdso59995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729199403; x=1729804203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJoUgs76KW8iMEp7X0ayKSzwwzLf9U+J90WGoUiahvQ=;
        b=qfTi4EgM5B+SN3TF1Z/uiJgkwmRMNgQy/bxWR5Ystv56x9OuCZ3eH9osXW50nUBind
         Bz7ReF20nTS7y3R2mQtXtPop46rZS2EQ4gLM/obPXF2NHnjtojTinu/A60yZXyEADBZ2
         FRd2jonJ1cboiaOhFeWmVnS440ooY97Gbh0XP9I7LYiErWLnXDevvFLDzjcoQS7O5jJX
         vJNgFw+7u9JjGviCOm/MrPiiG5yJg8zZcazGynHvaGQG97L9ch6+B3gNUhHXgHXfEpyQ
         prJPm37jqLwPBZAYvGn2dY0MIrnL5OvCUf9ILyB3ymaNm0TOcw3JOrHKHo2T10EWr3Qs
         Yo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729199403; x=1729804203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJoUgs76KW8iMEp7X0ayKSzwwzLf9U+J90WGoUiahvQ=;
        b=TO2EGokBMTaL3iPSbxxObNtujFicAU7eaiO25Frp6c0xgxtQxhiihmslAAFvGTMZsv
         HncSge05dzgVXqOKEG8nq9QLXGKD7ql8oiErMWMW5MPhp9pMij+ZDX6LPO9CvA1TheU7
         plwKGtyi5FAI+lJyfAKMp9t8CC+53tVtWMwYbdqDgzu9gx7yjkaP9AgDplDOvSHHNzFx
         Y9luJ3EYgzyaXsB/vG6E9lE4GHKjP6J/zKirQCBIcVaeT1SBuJRVw3dXt+BFajqpCpGd
         oQYCXH+L+fFwuTgDlCi41FA8M5W8iE8QIZQiY3DuMfUDUEknUmdZaPWFGr3djf5VRrUg
         LgWA==
X-Forwarded-Encrypted: i=1; AJvYcCUMcPEOiU+6wsrEvuO7ai7ag8tguuvydGAuJoNlzhyT0rMM2K5VV+wCY+z/Xh8o7Ga+RuPrRZo9QebUiu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/rw/iyrQ0UGdeUUJQHO4sbCEa0WOIfotAJBSGJppl1fq0RLuG
	xyLL4Qj1nYj7j6fjesrDHumblV1HbgTjX7dXgo1DYgq9654g8Elr1HyicIyzSa+GRtVdCQIkGsP
	sqwBjn12DCXl1ZSUk6D4jBDZA2ETlmTMM6YoO
X-Google-Smtp-Source: AGHT+IGWsubV2/qf0wzewlmnr4QnLiQKPbnulmaHJECIGxuPD15ftHNK5oR18XqOzJA1/SfG+WsDQ/s1fPoDvKQ1egc=
X-Received: by 2002:a17:902:e852:b0:20b:b48d:6ae with SMTP id
 d9443c01a7336-20e5ba1e5d3mr168015ad.13.1729199402682; Thu, 17 Oct 2024
 14:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com> <CAFivqm+mJ3RTo4ArrkjPJLj8m3vh=czt=sAXZ0iPN7n6=F4z3w@mail.gmail.com>
In-Reply-To: <CAFivqm+mJ3RTo4ArrkjPJLj8m3vh=czt=sAXZ0iPN7n6=F4z3w@mail.gmail.com>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Thu, 17 Oct 2024 14:09:51 -0700
Message-ID: <CAL41Mv4=hbLdsc2cVm_Kwsp-vjC_tfXF5St7s7jZGkjr31wHjg@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Prashant Malani <pmalani@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:54=E2=80=AFPM Prashant Malani <pmalani@google.com=
> wrote:
>
> Hi Abhishek,
>
>
> On Wed, 16 Oct 2024 at 14:31, Abhishek Bapat <abhishekbapat@google.com> w=
rote:
> >
> > From: Abhishek <abhishekbapat@google.com>
>
> Here and in the S-o-b line: Please use your full legal name.
Acknowledged.

>
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index b68a9e5f1ea3..1af2b2cf1a6c 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -546,6 +546,17 @@ static ssize_t dctype_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(dctype);
> >
> > +static ssize_t max_hw_sectors_kb_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +       struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> > +       u32 max_hw_sectors_kb =3D ctrl->max_hw_sectors >> 1;
>
> In what unit is max_hw_sector stored? If it's "number of sectors", is thi=
s
> conversion to size correct, or should SECTOR_SHIFT be used?

The unit for max_hw_sectors is sectors. Left shifting with SECTOR_SHIFT
will change the unit to bytes, and then we will have to right shift by 10
to convert it into KiB. The net effect is right shifting by one as the valu=
e
of SECTOR_SHIFT is 9. This programming pattern is used within the
Block layer code as well.

