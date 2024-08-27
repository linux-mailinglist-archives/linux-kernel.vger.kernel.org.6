Return-Path: <linux-kernel+bounces-302536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4F95FFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D20CFB21BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8042E62C;
	Tue, 27 Aug 2024 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhtp9SLw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476632747D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730085; cv=none; b=kbUmKqyrudSrOXnlzjXM/h0YP2s6ST1SgLoh9xlp4xwWhu/tLrkNhATPAjRVAMsUhtthKZkMlLNqrw6bI0n42OZQ/nASWU1Z1BfBkvrgYiKnb7HFAsY4VoKuGaMq7899cSHoCMCY+3cvuDKQq70JS50OyZEsKW2wA+FO1EMlaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730085; c=relaxed/simple;
	bh=joD6tkAAQcTQgJl9qnoYjzr5IvpayiN5af3HTOl3TS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3z4eFkxdUNceniY2So0ZPhyjxz95Is4+aQxrqFlaGwI2oRu6suQiPByBCN7K3DxrtUOixlMrGShP5VdBUGOU8YKhdiZXuFP6tA4l3xtts6IQy0pZs44XnAujVyuhgLnjZtQvVedYWIm2HT3JfOLujRUTcUoq3MaCnYRX2yiPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhtp9SLw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a868d7f92feso635751666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724730082; x=1725334882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joD6tkAAQcTQgJl9qnoYjzr5IvpayiN5af3HTOl3TS0=;
        b=Qhtp9SLw1LEOPkiUxK8F6qCt1vnXW/t2jTIYDDHUwccyFPc5EG84pQOJ8wyQNZHonx
         SYw357MVzpS2eFmhG76Uh9SmVUULMSa5w1YGfPqFPSP/hSAq0Tz13pa9QUrUkNz+OAtK
         zowrLOlNNjoHIAi3mhZurTzZl2gQNBhF94yH+1HVHxHhJxlnn149uQtLUH/GzyctR5WE
         j/YkoEQgeAG76a69RzgXzsfBsH3K/FxGRXTdl96UfjI7UOvxNXW+VN9TbWRIqb+bF7xa
         RpitLn1AKF39o21E5iY7FU3w0AnYXPMUxZ5HyDDWeaUUUc0SkHDllHA7lz9pC1pwA7GA
         8i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724730082; x=1725334882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joD6tkAAQcTQgJl9qnoYjzr5IvpayiN5af3HTOl3TS0=;
        b=mkq9sJlLdNxOW6t+zY08KqxZ8CRPiLMe80GO0I5OSSZJcvr99V697XUAevXzra97Es
         XJQVMHZEbXE5owqhWj7FdkJ05mr2C0HUpMwdFs9uoX5QyPJZtrAGNtBsLS2f+a7Yk2h8
         pkOw0D2oPesMlWuCypV0hVlQizTE7nhVyKf81CcxQsr/GgJyxmqYqYq+CSFX8IvDQwGC
         DgHszHHP9/BD/oDpYRjLTjhxfh6F5N69AGOLBb8L4UgXN8RTQhcWnq8eC304/LvO62gh
         ETykPb4DNTEbLE2s0XijanKwSn5+fq7udJ/wRmZCUX2fux8vhhyYmsjqfxUYI5dtZKFl
         ayrA==
X-Forwarded-Encrypted: i=1; AJvYcCUpwCoz+HdLG1tnIo8TsZnZCwqzMBFmCXTPRznhjPe+Pa1Wc3DDSSHrA70LRXP9BtTTRbBvYPK/bcKYUYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmGndVbGMo2ldAY/8JJPdJ34zWLGQLfc+FWnQZ6HL/7ccXcmR
	45QsXHd09cdrQ9YMmjprIu6aLS8pGHP53rh63miY1vnyw9ZriSgF4hXAq1PnZUg1anZc+FE4rgm
	i8GFpC9ROX5zzz7P1zgc1WKHAyU4=
X-Google-Smtp-Source: AGHT+IGZZmpcl8iQ5yInakpvJVuHhxJT9XUAVmcfTef4cvFxIhLhrvd2v41MpEvIgHfkRMF3WMa5+Wy10x+DRzGCz6c=
X-Received: by 2002:a17:907:6e90:b0:a86:85eb:bde9 with SMTP id
 a640c23a62f3a-a86a54a95b5mr1024453866b.50.1724730082097; Mon, 26 Aug 2024
 20:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com>
 <20240815230612.77266-1-21cnbao@gmail.com> <CAMgjq7AeVkmOiVFa4-iP4nbyX3LHft_5wfvV_raj_N+twdzMKQ@mail.gmail.com>
 <20240816133458.375e19fc36f61c8fd5d64f28@linux-foundation.org>
In-Reply-To: <20240816133458.375e19fc36f61c8fd5d64f28@linux-foundation.org>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Tue, 27 Aug 2024 11:41:10 +0800
Message-ID: <CANzGp4KiQVnYDPO_FtfUFrAi5psqmbN7SY35OgtJWKxMmstNiA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like devices
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <ryncsn@gmail.com>, Barry Song <21cnbao@gmail.com>, wangkefeng.wang@huawei.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hch@infradead.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2024=E5=B9=B48=E6=9C=881=
7=E6=97=A5=E5=91=A8=E5=85=AD 04:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 17 Aug 2024 00:50:00 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > > --
> > > 2.34.1
> > >
> >
> > Hi Barry
> >
> > After the fix the spamming log is gone, thanks for the fix.
> >
>
> Thanks, I'll drop the v6 series.
Hi, Andrew

Can you please queue v7 for testing:
https://lore.kernel.org/linux-mm/20240821074541.516249-1-hanchuanhua@oppo.c=
om/

V7 has addressed all comments regarding the changelog, the subject and
order-0 charge from Christoph, Kairui and Willy.
>


--=20
Thanks,
Chuanhua

