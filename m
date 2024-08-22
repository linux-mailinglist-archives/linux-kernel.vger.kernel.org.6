Return-Path: <linux-kernel+bounces-297374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6E95B709
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB22285432
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9F1CB326;
	Thu, 22 Aug 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CDCN+hzM"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6C1CB30A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334160; cv=none; b=Kp9g0WLp9aWmaeKhtuqXxfqfGmlR27hQUPunHw2JjZBVtbOri4rkLqDnfz3g6oGr7GS1LXYbaHRsQO1K2sBUxDSDJ7i6QJr0yZz25U3ynYcoEMbwqD8wk9tzLvug8+UAqwMxy0MxneMRQmf6/u66AJ+i8BZ5GUGHCyJHvAeJbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334160; c=relaxed/simple;
	bh=fy3fBkI98PvIF81Q8hoCh4DrGScuJF0lCWVTmmGhfuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSYfLFXLHswHm5vUJZn/18n+GvF6dQFSajZ46p8+LWWdFUjETZxfbpLjFsqx0DYFN8Ro4VwxC4DILTZHdLfTq4GF5FEEq+gavmlJDuMnjRVIEp4lj9txpl6T+83FYri/Q650zIIveuK2nhcobFVp11uf9hnrC26ua0OuW16z9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CDCN+hzM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so1201437a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724334157; x=1724938957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fy3fBkI98PvIF81Q8hoCh4DrGScuJF0lCWVTmmGhfuk=;
        b=CDCN+hzMx/ZNM0DdCMYAXdSMTIl5SStdTtJednxDh91a61bs+qdEUPiKukuMkS4HK3
         lyXUOigmXth/GnhXqIaRDNF4FaiI9Z8mzG/mLjPT+gUN+Ifi+HqCQPMdtyTtBxYUonl8
         5ddPKwPOL3S4RkthPqHDzjFJzs44QTNRMaJkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334157; x=1724938957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fy3fBkI98PvIF81Q8hoCh4DrGScuJF0lCWVTmmGhfuk=;
        b=iRSGGWV5IlXS6YK+lDcgQLpag/jE9GfCD2310+bFgrgvEsBYUI/+lZEEOHQW+3bNpF
         kt3+DqJtYR7YFXqNLzZbF5ylbKIZMr8etu94XExcNGUL85Jq3BU+x0iYhIOgCO0NpkJs
         s49e4rQkivUeT5jWNwqljVFbUBPHlGPyhF4nn1bnsHEDG+iE7XeRyc+LRTXSu9NaS7oz
         1x3CZkyV+ObuPUQB/OJOT2ZZNCtuJ7a0bqyHeA4mBvVKZD2CwA8zR0VJyXJhNBQW8nJV
         CiWA7pARDVHaqUAHHtOF+2hTMyWp44y8wALt6D8gG3n9geujUMacuBlYBCgFq7GdkUIM
         p6xw==
X-Forwarded-Encrypted: i=1; AJvYcCUMrGATOxwvoF+yMPf3D8lmSd/jdbjwuwKq8p42DS7C3akRzFup4A+Dei5yhiT53SqmPVguh1nnRkj44F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpChSzBZ3v7FeBZsupZNnpBHq0KBeuc0ACAFLoNXoSuWBkkba
	/dz/dY3qpAUIHKsGEstJFATI8LC+3sbEq1S3B9ZhGYj5ybkKYGo1q0gfCRWJIhsFbMdXycfmT6i
	InQyu1RFO5voYQHGpD8qRjbObwv+Ju2ZjlnDxFg==
X-Google-Smtp-Source: AGHT+IFi25nFSvIfpvtaevg4zbKt6hkTtNG3GW+4IDNykxi85LBM2FKY9Fn6oGOPHnZw+DYTm+Kj/nbNL9oG8g6HHz8=
X-Received: by 2002:a17:907:97ce:b0:a86:7924:11c0 with SMTP id
 a640c23a62f3a-a867924134amr459967266b.55.1724334156821; Thu, 22 Aug 2024
 06:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814093600.216757-1-yangyun50@huawei.com>
In-Reply-To: <20240814093600.216757-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 15:42:24 +0200
Message-ID: <CAJfpegvpHb1s4eByjwKT6tEy+E8ToNXyke12=5zz3WdV_PDcrQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fast path for fuse_range_is_writeback
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 11:36, yangyun <yangyun50@huawei.com> wrote:
>
> In some cases, the fi->writepages may be empty. And there is no need
> to check fi->writepages with spin_lock, which may have an impact on
> performance due to lock contention. For example, in scenarios where
> multiple readers read the same file without any writers, or where
> the page cache is not enabled.
>
> Also remove the outdated comment since commit 6b2fb79963fb ("fuse:
> optimize writepages search") has optimize the situation by replacing
> list with rb-tree.

Thanks, applied.

Miklos

