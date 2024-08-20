Return-Path: <linux-kernel+bounces-293175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C899B957BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062E31C23B06
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF141C6B4;
	Tue, 20 Aug 2024 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dqOkZljJ"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3C3F9C5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122330; cv=none; b=mSD6YHarYaNlEGBSaZuErwRjMH7aOqZoMhiUmJXY1FWKJtG4htPJwOLWKBHm6tIwamypzoFMK+hS7ib/Hs9Vgix8+xR200YnWYgWYuxTElOF7rZMXpVtGv70X77T1v4COkH/nDu2zRqn1LQXjPg4xvv1xxzMNuudoJJcJYUZsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122330; c=relaxed/simple;
	bh=ZDr5ZbxqvFQWLLGyxixOKscT+4fsLzUr364GEc8bx4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFcS0gjlFZfPtUBS0E23+I7Co+3Bn/StPpDay35L/bUVYXqfcfrjhIKgUFfqQhYuf+rnYoYDTNuG0KuxlZU9qeS/iXR+8wqWiq38Jxc+3x9kBm8jleXTI9OkPi2QJYnjfl/Y8vjMn6rqeEpORyku+AbVTZhdSg4PZNEo8iCPL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dqOkZljJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1633202008so1664355276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724122327; x=1724727127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMMqIhR8mNN7qbNLvHC3cSRq9saBfgJ6P2Pudx1fscs=;
        b=dqOkZljJ/4XbyB5lfn0o4WdQuoguaCyga7HO4AANEqA0oaRTt5aUuJ9QhtHuwDPRMw
         mEw+K0qCLjIAwbi7NtZAYAZtPJ8R382PbpPsZDVDDU6QbWjyW0oDHoS1d4yq/dWbihz5
         yLsyVA5ubIkQVO3Bk7JEFA12oWZq5h3sp0QPu1/eqqyq9x6s2h1sSpMgbintfGTI6vY3
         N3QYxaOGerWRC/yHj+uOu7/Mcnfu2rXGvRhWVxhuA4bBZkSdAzIzX+K4zJZy/wss9Xre
         a6qjc/CVIIQGFRXWSGf/XpVDLoDhRWY9PoltyLQ83+DFFx3kdYcAILRMwOYINusjg0jk
         ujng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724122327; x=1724727127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMMqIhR8mNN7qbNLvHC3cSRq9saBfgJ6P2Pudx1fscs=;
        b=tPUHOdSptVDDOJnK4Quk0S+OzatSmuvLqft6ubXyMDMEmzXSR6B2lyEzcSSfhwb0cx
         EIhkpG/M+3JlQnRA8u4P42i+X0MvCreJgowOIJG6pbzxYh/5tkJJHTpeTuz9rljKvTPg
         KoBhr1/YY2gA5FN9CxRHtFkO9z5f+C1a6Poe4NKMYJbBiYJpAJLuiQ54Nc7iEf2NPFxH
         eW2XStP8/LW6fNLXx2G7sNCUqzO9QFk5FDCmEkx7gK17o6IPUotGOUgwktVemiThst3I
         Utgr4TPBI6k3xEbXS23fsPa8PYay1F7slXhiSKluPQpOz9LkxYhlR44fpHS9/VPnRHOR
         jZhw==
X-Forwarded-Encrypted: i=1; AJvYcCUjDLBwwNnmAy0oc8dEuUZaiGw9W9LtEmDT2wlHKmclsA0viYKHfSrlB5h7I5mfg9TQ+q61hS4fkUDdLn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNC5uyneITQ5mgSG881azxcZpHu2nXjOd79eceZSl3isOapuqn
	6VqDeP6763YXU0Gp4Z1sb61xE0MXMBUPqFdmaYG0+wwoVmd2PBPeZHsTYgRj7bm1oJXrJhTJxZM
	Ne6W0fcx0S+n4XFj1uwYMtMQeXZGrS11DlFm0
X-Google-Smtp-Source: AGHT+IGx4BZUDH+LCtHEYeY3Jj6i77Krk/e4mCpEtrxZEdqLSGFNLBDOXv3VOnuXbn9YLa/m+2U6fa38CFBTVrK6h9g=
X-Received: by 2002:a25:d8ce:0:b0:e11:83ac:a024 with SMTP id
 3f1490d57ef6-e1183acaecemr11644146276.39.1724122327544; Mon, 19 Aug 2024
 19:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com> <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Aug 2024 22:51:56 -0400
Message-ID: <CAHC9VhR7CEBmzjnruFaHHpepYWSRu0bvPUxYk_jz7oXRS5yJUw@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com>=
 wrote:
> >
> > IPE is a Linux Security Module that takes a complementary approach to
> > access control. Unlike traditional access control mechanisms that rely =
on
> > labels and paths for decision-making, IPE focuses on the immutable secu=
rity
> > properties inherent to system components. These properties are fundamen=
tal
> > attributes or features of a system component that cannot be altered,
> > ensuring a consistent and reliable basis for security decisions.
> >
> > ...
>
> There was some minor merge fuzz, a handful of overly long lines in the
> comments, and some subject lines that needed some minor tweaking but
> overall I think this looks good.  I only see one thing holding me back
> from merging this into the LSM tree: an updated ACK from the
> device-mapper folks; if we can get that within the next week or two
> that would be great.

I've just merged IPE into the lsm/dev branch, it should go up to Linus
during the next merge window.  Thanks everyone!

--=20
paul-moore.com

