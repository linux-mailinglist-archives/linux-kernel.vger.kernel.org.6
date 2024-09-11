Return-Path: <linux-kernel+bounces-325206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0177E97561C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80328A451
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295061A304E;
	Wed, 11 Sep 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDAM7RJI"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825D15C13F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066555; cv=none; b=NM+S+iVCe5rnK2MbJOuqZzzeAqp5TZ9U/t5sldUVfKYBzgr2GBDWK+eH7UefTjqyicQ9MY2AMNBjhaqim/5Z6rKNcHMR9j9cMtRtnGacN0TNh7dD0Rh6g9dzM13v4b864rgViDbEd+p5ZmdL9GkXlfmXm+PdybMhiGqQP+auYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066555; c=relaxed/simple;
	bh=gmqJO4vSGwyIvIHlbU9meDBRQSWmv8EFougT1GMDwII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnnIVPkSLTziSAgo6hVf1x9yc8owEnHTrXkgMEaifn5Rj8wtkmz3W+rn/3WubP46o8MzFNp2nRFF1d6SQ1SNEQZ6GbnvMJgNq4Ic5o8reT+OuIsFh/wRsxvgLMilFgzbFNnoRrTKhVQf0bgMFU8TN1zDazC59YxBvMHWdT2qeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDAM7RJI; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-502b405aa76so527032e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066553; x=1726671353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmqJO4vSGwyIvIHlbU9meDBRQSWmv8EFougT1GMDwII=;
        b=dDAM7RJIhIF+mmk9ySjVF0t5tkvv/FTlomr1sWwnVih1auZC+6zvhPNoqUaA0545uS
         TfLLr1K8Pekm37P6cUE0ye4tfWDPqx3LUWrfBgckiMiKWGC2QQtSRQjZ2bcVvAv74pQp
         l3RIvNYmAdGiR8b47bRQ4m7qIbP2sWW8ogIFcF4nYastuak0aHHkcpkYWWcbLJTAKTxr
         /vGzez+yd8ndcdWIqI9DcY7do/WF5380pBf/NgLdRYU3TDNoCOe/L07zAirud56pIbYM
         03HQAt9lbbPW7h6RgqqsCk3aGFRL2w1zK7lLUjfMXXBfW0JuQ+B3ukBahVqVzb8Ugw01
         h+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066553; x=1726671353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmqJO4vSGwyIvIHlbU9meDBRQSWmv8EFougT1GMDwII=;
        b=EwKzT8CHPtjHE3VJYPvvLcRwAem/0bVPbkbX45t2nXJeX5a5qcEPpsolcmSB1tLmkI
         BeZScrQoEecsX2V+XKyvr6oEAF/tj69MtDp2J6TrI1s01wrGo3IiWqelUL9wjC5cnExJ
         6jyRbI2+bJYDdl7g9XaQgJgB5RRzhn83Ag5kQQnJK0HDMqwbwAkXOBdTTDpFpVODbR5X
         Fz1zewHLQkRA3BarsnXVS4id/CzBgjGrurDpP2dWZkliqndlEj6wcWhSr8cFmQoff+Os
         L3gQkjMJ8raKV0wXtojFVNF6+ISXdDaoLjvNZjJnBQGiLQIUZLYZmjm4meyBsO2PqB+3
         VBcg==
X-Gm-Message-State: AOJu0YynxkRlZhk9brWSb39QzsupYicO2Ca9H8K35HfquhIyC1Y+T1CO
	HgWiUB+J7HnwEtDYihCeuh22Z/tZX2DEgxTsFkvktJtBklcKGkIuuPA/6VL5gslpb4NJr+znUIK
	erur9t9j3VgSdr3XHWm2iIJYZ9Bg=
X-Google-Smtp-Source: AGHT+IFod2Home+5dVI1fJDal5UYbnIHTMR/YCg0SWQI6bRbBjB8pp2ETC8YsrVQct7getXIj/F7HVVBVVG6mWo33A8=
X-Received: by 2002:a05:6122:35c9:b0:502:bcda:f3fb with SMTP id
 71dfb90a1353d-50310f2d62amr2244481e0c.6.1726066553016; Wed, 11 Sep 2024
 07:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909221946.2004046-1-daeho43@gmail.com> <b98143c0-fec4-4d58-a230-05317dab577e@kernel.org>
In-Reply-To: <b98143c0-fec4-4d58-a230-05317dab577e@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 11 Sep 2024 07:55:41 -0700
Message-ID: <CACOAw_yQzEWTysEsUpv8THq3xPsq2deto4Oih2USz_QX4PG8dw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/7] f2fs: make BG GC more aggressive for
 zoned devices
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 7:03=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/9/10 6:19, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Since we don't have any GC on device side for zoned devices, need more
> > aggressive BG GC. So, tune the parameters for that.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
>
> Daeho,
>
> What about collecting all last reviewed-by tags for each patch of this
> patchset? if there is no change when version updates.

Oh, got it. Thanks~!

>
> Reviewed-by: Chao Yu <chao@kernel.org>
>
> Thanks,

