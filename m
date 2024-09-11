Return-Path: <linux-kernel+bounces-324562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F70974E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4D91C26A40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B6185B57;
	Wed, 11 Sep 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUQ3qsRZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676316DC33
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045961; cv=none; b=cqftYsEcO4k2YPlCgfyW3GEJedS1eDESnivXhEnTMn59vfHCTQ/lprg7QK8tJs70b9ai9V5O1v/TLq8KwkLRlOBU7p2rob3qwiLy4vSdtSAo4ziXrLxzf+l+Up9lsVH3G3eFyTqnR7Ub9M26gwPKIplLY7MKwCgivXFY/+OnhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045961; c=relaxed/simple;
	bh=vbUWD4st5YJACw89LRnLBpQGYy6V7Oeo/NpfG48VMs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ1+eP7xUqXZA4JY8WSJ61Phd3ieeXccwjN5HXsPMrEjQYQ59Ehf1KhClvPMpaj58KR3LRFxxWfppAHtMRLKP36tBm5Thj0dYz3ljwoz5mh0FpHXPLZEDpbK8kKVp7uhzmy5R5BVDWXBy8LvzTJciLoa3EduCIU+FPCPb2GIDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUQ3qsRZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa086b077so610616766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726045958; x=1726650758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbUWD4st5YJACw89LRnLBpQGYy6V7Oeo/NpfG48VMs0=;
        b=CUQ3qsRZq2UXVci/02H0PkTqQfuW9S00kAC46O6XaE+KLkv4JURf9/QQilXXatj1hW
         L5L5VIckgO43psOiY8OZAp30AS1pZfjSem/01p9E6R75y943cI81spjBUoIyDZvq+5fc
         G4eM+c50LYlZW6Vq9NPenREc6k1M0BNY8DrLNZE4s8zT83oZF5lc+ee0CZ18tZNLlqU7
         nJdRLI2jexlNvsOUeiGJII7C4cz9tq0nCQM1eOOv5tKwFh2llDFNqMcdk+4GsFxdhv+c
         FaP6gPIswwbc8DYf9+4NgCZjtivHfudHQeovHE1kmoRru8Xs3eomgymVz065z7OBFiSE
         ge7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045958; x=1726650758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbUWD4st5YJACw89LRnLBpQGYy6V7Oeo/NpfG48VMs0=;
        b=S2bAZBZ1CcjramWB//mgNApyM4hdqkkY9sx9eSy3FCkOnbx5bRffjhSiG/X1Zfv1WK
         T8Zpzn/8HBD0g4RFfLuW08pinJztUCv8SrKG3HxUnG3J7nj0mwtWGRaX3MJVJXOtgGDl
         mpUvj1xh1XWuSKMkePwsbZoZvOyCk9dj1sbxOI3DZnscIISOfFAxVcteVJjLPaa8w3s5
         T5nqUa3eaKjcXWjR+H2APp+HDFginICToy3RBbQ3AGktFftpVcyKdDza4WkE9BAynWj2
         9iAZM1nyOCvopNQj5sC01s/fgbMwdVA57LAZF6HOX+fjLkXNPkJQ2yhQz/jUDr2EmivZ
         IaLg==
X-Forwarded-Encrypted: i=1; AJvYcCX5hKBS3Nw3dcFKqXPJ3ii2/sKoGbpeBphayAnkTm+1PXOFDMTmgahBTq3A8E/7S0LSfhOmcU9MnDd3KO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbH+FYb9u54oD3TZsUDJ05deYHeUZ5k6OKHhBpDgL/KfCMDwJ
	NvwLxb6sf3SUBrpqH6MrGjoawOod7QJcpM4DRgz3XD1YUQ6Z7syYLMhwh1IQutjL0AI/f9qk+MR
	QFNB2baa/B31WFY7Az/XNBynomPf9PJByhDjk
X-Google-Smtp-Source: AGHT+IFTOe7wINzq4zhj3zcJRL3zZsKN9eN9L1F6J2ydGaat1CgRGk6c4e3IwLEldhlg+/NBYzt39to5OiJNJbJiSQE=
X-Received: by 2002:a17:907:d16:b0:a8d:510b:4f48 with SMTP id
 a640c23a62f3a-a8ffaadafc4mr362683966b.22.1726045957356; Wed, 11 Sep 2024
 02:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911050435.53156-1-qianqiang.liu@163.com> <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
In-Reply-To: <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 11:12:24 +0200
Message-ID: <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: xiyou.wangcong@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:23=E2=80=AFAM Qianqiang Liu <qianqiang.liu@163.c=
om> wrote:
>
> > I do not think it matters, because the copy is performed later, with
> > all the needed checks.
>
> No, there is no checks at all.
>

Please elaborate ?
Why should maintainers have to spend time to provide evidence to
support your claims ?
Have you thought about the (compat) case ?

There are plenty of checks. They were there before Stanislav commit.

Each getsockopt() handler must perform the same actions.

For instance, look at do_ipv6_getsockopt()

If you find one getsockopt() method failing to perform the checks,
please report to us.

