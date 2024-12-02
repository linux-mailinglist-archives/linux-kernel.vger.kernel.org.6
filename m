Return-Path: <linux-kernel+bounces-428497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807539E0F53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A40B244AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D71DF72F;
	Mon,  2 Dec 2024 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7qIPVmN"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3842C18C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182239; cv=none; b=fnZwyIbbvIMYxFnbEcwKv3OPrW2KWwJbge3y1BUF+lG2oX8DuYO5opcUXmiqJgLOS5cV2qHC5tMd6KHS04lBk1fE1OJzgf6kSAgT02+cFXjVFZYOVx/Eabqe1vdbWrrjJjaneQfoLmtDw+Tfl2nP7HP3Bs+MQNMHGlDLAYKfDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182239; c=relaxed/simple;
	bh=aZj6e19WTy8Bk4KAU/F6qxF/ht0NzpmpuoO7lO7lgDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcGtyDAoSfa67t9tYv/N4tQQxd1GcJQMZFvFjB7U6RWWUkEUqqtwNeNyJlJjLCqf+2rzA/nTFKHn9YzT0pxWHWp7y+bcL7VzuYDI3zeiJkq1CZ/u/kQz63Q8YHwPi8nxtCKljkxG9Arbo4eG5VENuxsZr9mRWeHOqkjUINsx5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7qIPVmN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de84e4005so5617914e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 15:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733182236; x=1733787036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZj6e19WTy8Bk4KAU/F6qxF/ht0NzpmpuoO7lO7lgDk=;
        b=n7qIPVmNvaMcItRWuY3xO0WgLT8Qip9HZPzHzDe0vIpau2A7rqOZmXf5DNIkOOjj7x
         lgxGHt6ZP+c7WRnXu10cSwIs5B/CpRqhTVFB7ONkVET6KXpjsnI2U/2r8Tc5LAjic5e9
         7POBmT0AS//rNjqiQpgLxid6PGuO2OVAwJuWLYxuZ2v3CjKJVVpLODswmT/6zIzuIsqQ
         FwaEd8Jd1zTtk9oMvQo7cAwJn8bI/gNXePB7xDqfFCvFjSF2fxrcU8hpx6Fe/g2LzmeL
         XhZWQrAsLBX8gHZdE/XXVUeFd0M0Xyg/rtcmLDQuRj4BGRka9ZNGE0imGgooWpJZS6sw
         867Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733182236; x=1733787036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZj6e19WTy8Bk4KAU/F6qxF/ht0NzpmpuoO7lO7lgDk=;
        b=fkeGGDlc2b8SUS/VWfueurugOhZBv1KmrMmJ2vDbwQR1hy9son7Hib0jVF8HvlMP5i
         9McQqsWIOnpSpuf/VHbyaaDFDHowa8jKfvuvk8gjT7sDp6gVVV5O27KD92/ikmD+JHcy
         yf0oqz3Q1kZJON/cyh8jqRCV0Zxw/BiYXYAS9LiuzWegRI3P1M5a0zCvhOFh7O9RGE9p
         i4TUAus3LPf+rA85iwILXjKpkJavaSGqEAyMhx4FjWkBSBomEXK6eBPjmzq8Fz97wpAY
         PCiEPvt1ggG5SR2F0WvgAOVoP6APqIiJyBypawe0ozJrkqTwVZ5WxNr34rtM87yn5VSl
         +O2g==
X-Forwarded-Encrypted: i=1; AJvYcCUFMYMErMrE8n/nvsyIouamCZugkmHXbkU34xW4qto1l+PNSv0jxc/3mz5+NxKOKcY4VW1m26R4mXwLU3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfB+NS2bQambwKbIdSFC+gmXVHCXgrZ+LHT9y+fxb7+oBoITmA
	H933KyK9Mfa5S3veXoBZWr4sbp6nl0CVmL9wQJhmdYVLBAwJmYbbopm1r/SR5hd2OiXyf6nBw7j
	geDHBBd3D74sHyOWYoQtN7vouSNFRTZF+HAFk
X-Gm-Gg: ASbGncv2+7Z/7weIQtStnlgRohHOQP3CJCJrJPgsDwSDHDff7QAK98rdUA/gupJGVBp
	tLYhdTdKQzL/lruTUtTtjQPEYUdZBpw==
X-Google-Smtp-Source: AGHT+IGeJbPQB02VCdl/lirRxj9TkOBHXbSF/gBjwKzcTIzMXnwS+lzUWxuS0Lbq2jpjpdi8qp8ueNmRElqi68XG7kc=
X-Received: by 2002:a05:6512:3e1b:b0:53d:d136:c2dd with SMTP id
 2adb3069b0e04-53e12a22ff9mr215248e87.41.1733182236183; Mon, 02 Dec 2024
 15:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115230509.1793191-1-saravanak@google.com>
 <CAGETcx8B+MZm_ZOFkK=KUvV_9q+48Zvkw8C-oenvvAKX+0+e6Q@mail.gmail.com> <2382757db0ec7485700463b9ac7fcb11.sboyd@kernel.org>
In-Reply-To: <2382757db0ec7485700463b9ac7fcb11.sboyd@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 2 Dec 2024 15:29:59 -0800
Message-ID: <CAGETcx90jLpqEmHOGT4Lm4kDOn-=D6Rv13SMG-jVzF6OWZFKDw@mail.gmail.com>
Subject: Re: [PATCH v1] spmi: Set fwnode for spmi devices
To: Stephen Boyd <sboyd@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 3:27=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Saravana Kannan (2024-11-27 20:23:01)
> > On Fri, Nov 15, 2024 at 3:05=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > This allows fw_devlink to do proper dependency tracking for SPMI
> > > devices. So, better deferred probe handling, async probing, async
> > > suspend/resume, etc.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Stephen,
> >
> > Gentle nudge. Plan to take this in for 6.13?
> >
>
> It doesn't look like a fix and it was sent too late for 6.13 so I was
> going to send it over for the next cycle.

Sounds good. Can you let me know once you pick it up in one of your
git branches?

Thanks,
Saravana

