Return-Path: <linux-kernel+bounces-410884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949169CEFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F841F23161
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E91C07C3;
	Fri, 15 Nov 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jxekDYFj"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F92136E23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684301; cv=none; b=CxoiByDO7HB9v8PJZggi825mVHnWk//OZePo8uCqBQRhPgXgspfJ1ekNhb/Tq7Be2u4BdLiCKcCBn2HbcRtRBqRNfaH527+xA28XTvMcIHYFuHau1Bxk/rahbQ5kP8OhoRhaLjRFJeot2v6jFoQKQwJcL0yw1r25iTGxUjy/E6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684301; c=relaxed/simple;
	bh=TIZ7Z0awf5cXcxUiF+IISaAkoCwhIcEsKazphLnlfYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUlupuoWpOWmY2RqustItfvg+A/MXlow+KURvnLigrniwX8eabsUKmuDso8Ghiyo116q/qUawVGQFi8IdgbPkViE2jDVYeVXz+rLAzTXj+SFw3HHFLMeRwVLx2WAB0pcnQ1UjAXSvRyD2U3R2ou7o8TEKB7NVp8GEBy0DEog2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jxekDYFj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46101120e70so13602291cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731684298; x=1732289098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhWRL4SgdQsRHwF3zYRHfFkkTS6N6p8eTQwmpFKTViw=;
        b=jxekDYFjEkjClmziv8L24VOvwcy7vFsFvvQhTkzdnJsT047qyJiOOTvuZBv7yGEA7S
         DhX3a5weIkiUfjNIlUPju0A8+WZg14h2iRJoqsiL/N2Xf/DtyI0FLX3t3IBYDHb76CEx
         LtVLvWE+qWf4HjMVJnu30IX6RJBR0XF9NV7ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684298; x=1732289098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhWRL4SgdQsRHwF3zYRHfFkkTS6N6p8eTQwmpFKTViw=;
        b=IUXgBM58hKgHYvpKzbByJnT+GDuDP1WpH+Q/Fk/IhVgD59oWHxwsthO05Csn2xWkqA
         Y2l1zeCo1gyfyfy1Dy4ibbHB+MF40yIY8SUjjzZF5evlTThvL9V2jwdY9UKQkTCB/Ku2
         2rXwNrfUNLPS9KgMobDa1u6682fofPPphpQfm1QBdDlCrW9g87JSkoYmpWRzhBqeOBwR
         JQcmK5kC+97Ree/xRISF5oWEQfPLkxm/oUPMPvguUIfaYUTC+wTS3aPb89JJoM6yb8ie
         5G6G1YNGDFQFLrqreWoVY58sQYqdPnI8XETzcpM3O2LxQ0bsoDyPxkqt5CgAffNciSEd
         KHhQ==
X-Gm-Message-State: AOJu0YwGMTTHYIbhwP31JUVGKJFFTH9Y1qlsXcLXTHoy7kjLZGPRyiz/
	rQiw3m35OrRn2D6l0DfqKJ1jDP35ZtDl8ye4qYk41ZNTacC+Pzjx//wCU8uFVQi0RYHDUpHV+HD
	55o48vB/sMZbuDhsti+CAwhM3WJqkqQrLAx3/7w==
X-Google-Smtp-Source: AGHT+IEo2rr0odYMw2XFght516xGACmkLA4n6BjOW0bN/+TMAiU5Xyo127jU/d8oAwXbYktURA2Q6cq1rbAEop0XL8I=
X-Received: by 2002:a05:622a:5c8d:b0:460:a9da:42b8 with SMTP id
 d75a77b69052e-46363e11f32mr36945911cf.22.1731684298435; Fri, 15 Nov 2024
 07:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024164726.77485-1-hreitz@redhat.com> <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
 <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com> <CAJfpegvfYhL4-U-4=sSkcne3MSNZk3P3jqBAPYWp5b5o4Ryk6w@mail.gmail.com>
 <ece87ac3-71e2-4c43-a144-659d19b1e75d@redhat.com> <CAJfpegtuVxtf9xoyJPveqA=uXb-wnzPcqD_rXNOV4LMahWqxEQ@mail.gmail.com>
 <2fe45430-a07d-45bb-89b7-1e4a08d1818f@redhat.com>
In-Reply-To: <2fe45430-a07d-45bb-89b7-1e4a08d1818f@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 15 Nov 2024 16:24:47 +0100
Message-ID: <CAJfpegtQhcGNaH8k1XKTSV_9=T4Ayx8oDLUK-0X8CRg6Rhb1vg@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Nov 2024 at 15:51, Hanna Czenczek <hreitz@redhat.com> wrote:

> Now that I look at it once again (because I was wondering why to check fm=
, and not fm->fc), do we even need to check fm or fm->fc?  fuse_mount_destr=
oy() assumes both are non-NULL, so I assume sb->s_root || fm->fc->initializ=
ed should be OK, too=E2=80=A6

You're right, fm can't be NULL.  Not sure why I thought it can.

Thanks,
Miklos

