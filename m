Return-Path: <linux-kernel+bounces-435702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229319E7B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD96628155B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105B204582;
	Fri,  6 Dec 2024 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IHSUo3Eb"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DA1BC07E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522266; cv=none; b=KTTDjcicvO5gwrzv9B1T40lEq8fSOJkIpBGANzzibsjZIBqSQWIR1lc1F5ekPcZUHikJ+lHnadTyGsf5DdVyzbViii5nD3SDLsy1s39ZA0sibKBST+zk/AENI6M+4/KaVMwTAvU1oABU05bIMcubKz/ejo4tLb+SZfjbIAb6O9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522266; c=relaxed/simple;
	bh=fX6V7YcC4DGlHtveiE1oAkpMt35/kHW3T2O8DYy6vuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1CneQbj/9aUnNqiE3b86D5BcWv5vD1Qdwn9EHXkqJyLHyXR2qLi51ZNQLX3npvf1GnrZU66ubXmoxZkzyb6gk1xeP5tCG0UqMWXGvoFcdkephhgD0xWfJelPHPQbTVcRIs7kiAXkyX0icqUfTDyNBW6J8kmj/z8awcaYCgCtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IHSUo3Eb; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3a189af49fso845870276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733522263; x=1734127063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myy2577WzvIjXbqWY3UvLVUFiDUwuOLmiP7e5JBdXu4=;
        b=IHSUo3Ebm8/FhsXu6fAY2yCJzyQbhJtoDWX8USVYk7pdRgic5Gl+xBl21ugPBBVi+X
         rU04K5ZUZ9PFd7dk9/ZvGFeYlv359GDfPNzwvFi83VdmOt2hAxiw3lmqhqSvAuqdwgEm
         r3O0TN7F87oWo8Rdq/GVfvpQyu8cjtTM3T7zzJ5xtc3dj6yMKlw2CxJs9udLwRktc2Ys
         8p4ZRG3EwMI/52wREluS+a8EqkC8QMel1Y1UTwLuSfh/r8kBoFIW8lv2/mFwM7LxyidD
         eKsyZqyoe+YAb7QvPlik376TZJsUszGMmT5+Cc+yFLOwDBgdE4U7LLEe9YUSufs5secW
         iDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733522263; x=1734127063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Myy2577WzvIjXbqWY3UvLVUFiDUwuOLmiP7e5JBdXu4=;
        b=pVtWC2kgEoIN4gl7F2+6rDqqp0H8VlFxe72PtWqgR8B2OHXzVDsZrFftHbASQT25Es
         68Zof6GZEqqQZ/V2c1auVmwoxTayBcWJywWnfxiTxkVeAGPcgZGCBMHNRz4vOJ92VsBZ
         /fGahfu7RX0DIHI0ez4Es6Nn8iP6TZ8DiL12KGEmRyBIOTXr+3IszUe92GivuNLPxCGq
         m8HFDSgR6Xq9rikMbnxpBMZHI6FTuZ3dxbAaH3H4C+qVMYI9b4YluxtkVxFoLkCoeViR
         EfB4NVLqfsMY2aAHtRlqcCmYSEhRd2l5k63zzObWQvuKZk1364yEpNgNQMYm+WIgJPxD
         zC7w==
X-Forwarded-Encrypted: i=1; AJvYcCX23N35LKrxjX4bV55VJ99H24CEA0vJgf1yUIHy6moXVDlf+Qb36KjOzuo5+iz5m7OO9vsiZ7JUq5vzs4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWyYyZwq+7agnDOXxTdXlWdZfftmBXbQphT2ocz7GbxOJi2oE
	1FMHdq3fzmkceLiTGIMoecpAY0CSLeqro9opJQKrJse0fgvy+VxWqHn++/kI3Lr2kWrA3nHY8W4
	LElW1DupgOwlSV8/PFfUl4xhedj1ivntq3Fp5
X-Gm-Gg: ASbGncumN4kX/tTzDfgCH+oR45FeGz4jgAyfC2b1DEZTebs3LPQwD+MG+T6teB/ynq0
	uEdUEHpaGzj/ckXUu1/a9zWZu5Dhfsw==
X-Google-Smtp-Source: AGHT+IH1bkPiMhbpYOgfFpgF14PJ5KgwTBqjCT1+BQVJyrzOfzWMCCbtCS5brQO1dAN8AGvH56eHjZuJNB8658aGmRU=
X-Received: by 2002:a05:6902:250e:b0:e39:b0de:fed8 with SMTP id
 3f1490d57ef6-e3a0b0ca18amr5230100276.17.1733522263237; Fri, 06 Dec 2024
 13:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122121843.641573-1-rrobaina@redhat.com> <d3391fbff2c69be230d368c68d215be4@paul-moore.com>
 <CAABTaaBQ0+tSx++xYB2NJ=3Qkein9Y5=eY0uU-V9Qb6mR28GvQ@mail.gmail.com> <Z1MVodP9Xien/Dv8@madcap2.tricolour.ca>
In-Reply-To: <Z1MVodP9Xien/Dv8@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Dec 2024 16:57:32 -0500
Message-ID: <CAHC9VhQpv4fOQT0RQArsofFLdwvVveT0KHiA6UGj8UuxQDCtLQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix suffixed '/' filename matching in __audit_inode_child()
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:18=E2=80=AFAM Richard Guy Briggs <rgb@redhat.com>=
 wrote:
> On 2024-12-06 10:00, Ricardo Robaina wrote:
> > On Thu, Dec 5, 2024 at 9:22=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > Yes, Richard did provide a reviewed-by tag on the v1 patch, but v2 ha=
s
> > > enough changes that I don't think we can reasonably carry that forwar=
d;
> > > of course Richard re-review this iteration and provide a new tag.  I'=
m
> > > going to remove it for now.

...

> Please re-add my reviewed-by tag.

Done, it will be pushed back up shortly.

--=20
paul-moore.com

