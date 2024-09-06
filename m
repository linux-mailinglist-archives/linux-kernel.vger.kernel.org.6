Return-Path: <linux-kernel+bounces-318059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E796E7D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310DC1C22BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA3836130;
	Fri,  6 Sep 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQV/iT3l"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038727450
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725590522; cv=none; b=Hi1Bkykjpp05mnowLgG9xk8mnv9ssmoV+Bb4cUEkONe1xdcTejZj7v4juiILrVV9y9K5SB3oOf1otjqqZwmCGUVozKIDUR6W/q3J56fVg7sU8cYEbCvafMJcOsLFEPvRy2ohjnI18R6RBBIZa3RL5Q5bKVEyjzq0X0G4o5Fxe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725590522; c=relaxed/simple;
	bh=sdshN9UNlzuD27u6ROZbKQMULAXmm9YbEwRektccAXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShFaAuJ2yJVHFhtziEid0Xmo3E3VOG9iIHJqCkfb28KCcRpRYnx6m+kIy1OR0eVJ6VqwsD0zV8p5SiRezktKtc4fKysHYPKIxaBYfDUG+onqKaVODzo/AD6adTNkxv2GbQ3Dcdh5OQyQpFVwO/yni1g/BM1tFirwc21WVXxiY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQV/iT3l; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4567deb9f9dso92281cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 19:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725590520; x=1726195320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4UaR9rnfs3nkxsuzsZ+aLOeL91gfHZmS2quKBI2l2E=;
        b=pQV/iT3lEfUR4Ig5YZGeanpRsPBJ7twXlFmftE3nT+jzy/G0d7KEqYHVFX23r3ZZD8
         VDEJ/1aCvBbPX+gXeb43e0SMDmFAbyTNrjwMISuvV8w7vCZFvEjiFgkXOHy8TsYSN5ef
         VYDasx1l+48Z1XzK8jVpJfpA3SqoCVhIsmDDZLcLZ0qCGBys/1wGwaTWZOcH2xxXv+j+
         a9fvkr7bFF94Y+Wc0k+W35Oq4s8Tzi9CYtmkKSvfweCP+gKB2IC4FAgXOmwVk461apnt
         mLakc56PHFpLnm78Rihm/Tqfr+mgDI+6DghWz9Fza74vHQxnWPOs7uanPlcg3P1/vUqj
         Kvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725590520; x=1726195320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4UaR9rnfs3nkxsuzsZ+aLOeL91gfHZmS2quKBI2l2E=;
        b=RQfZTeaA5+N0xiK76d8PZ5EzRVawDlst4Hj0NyRTWJBbT1Vz+RVYKNkqRPzTbRk/ds
         mzU4jHoWCBbDEdbww9HVO1yYq7SCPLDaYdrOOjOhcHf8uuXwfP1lbJqiuvQWZa/8cmC6
         PmJqJMEWNJpd3kXBb1trHOYSjNy4VB5je0w0bjf0hYeBo1Iz15TEMlYu+jPRWm6n99iy
         XlTp60/1D3+cKljhyLurZkS45CzSM/s7ktMenwcj00/F+JbyKjJEmE47640mlVRIJuSZ
         ycsK9B8U6IhuxZp9F9BghNU2waFX1/lRU7Z1FfZEroD+wSYl1PE1jV+n23d3OBlEbDa0
         3F1g==
X-Forwarded-Encrypted: i=1; AJvYcCVGDYsbKbjIk8uiHInPgPVQfnz6fF0m7QHAoX+0xXH9CGEyXc63U83lmtYoycMiSjVaZt1HM8h6HIEFkYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZz2UAjbZd+zA2TWR4vZQlV2HyuQ4sc+jhEK9dS8WJDgro7nC
	NFThjjG5mmAFwxkgy4wrjGaZjLw3xzZtJSb2adrhKEA0zPVJTEuyKTVLZe8W4he3s8augyPZrBa
	JNDjtN4ROS0uQoEJqjzR9FaC3mNcdddEO9aav
X-Google-Smtp-Source: AGHT+IFOLdcChhDKTbdy4hWrZEWpjgccfXJgjnc236wYk8wUUmjOFryorytFFjekkPPnEJ5X3Roahp090JCOs/osYIs=
X-Received: by 2002:a05:622a:4b06:b0:447:d78d:773b with SMTP id
 d75a77b69052e-4580e514fcdmr758961cf.6.1725590519728; Thu, 05 Sep 2024
 19:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903213649.3566695-1-yuzhao@google.com>
In-Reply-To: <20240903213649.3566695-1-yuzhao@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Sep 2024 19:41:46 -0700
Message-ID: <CAJuCfpF2RoKcyjABk74X6WgcHCCH_xr966JR=O=+w8ptANMKug@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/3] mm/codetag: fix a typo
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:36=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allo=
cation profiling")
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/alloc_tag.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 8c61ccd161ba..896491d9ebe8 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -70,7 +70,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct =
codetag *ct)
>  /*
>   * When percpu variables are required to be defined as weak, static perc=
pu
>   * variables can't be used inside a function (see comments for DECLARE_P=
ER_CPU_SECTION).
> - * Instead we will accound all module allocations to a single counter.
> + * Instead we will account all module allocations to a single counter.
>   */
>  DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>
> --
> 2.46.0.469.g59c65b2a67-goog
>

