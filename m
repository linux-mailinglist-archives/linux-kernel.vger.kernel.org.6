Return-Path: <linux-kernel+bounces-297511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8BA95B9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BA71F21207
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53D1C9ECE;
	Thu, 22 Aug 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V/QAxIym"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531D3BBFB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339885; cv=none; b=pYZvp0fm/fNyaMytrqbGgjfmuJHrvmiUZRQTMRjkRugDwW0jooGWss44zZGD0S3vS/GxS0HA0VDNKy8Hni0aSlMBcR5vumj5XYM9NKnTPriKjJPtpTt3NEcxkS9Wx4ZWQIwLaYhkGOUsKlW+SItEq7Ml9N1+zaSIhlNh95SQgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339885; c=relaxed/simple;
	bh=Fl1xClMzidzVLaAGhQIy4FMjfSjkpp459jOzZzWS8YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+m31qoVfPggrdBzg931owLfuX288c+VAgkaOOL4Zt5V8a8XOChNCdFMjvCZUBgi6fniAitLR2gZIMackEJYrRNTyFVb5QgyWgAaptvHO3UwOUSCPqSDpM85PBe5ZC1/WyZ5Mq2V7k4c+9HIqsS0Cmmja93hmGXHtv29tYIrb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V/QAxIym; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83597ce5beso148267566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724339881; x=1724944681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl1xClMzidzVLaAGhQIy4FMjfSjkpp459jOzZzWS8YE=;
        b=V/QAxIymVYh4HxgWZGdI9KaIyh9unWJyHte6KuzCTX53e0qnQD4Wta8WV9eqrl7b1j
         dOj15Xd/mUEcyL4MCh7lVteU+VcGtLzR6iCuS3vtVZGMgWaR/Mb+rtLwoPjs3eBml8QQ
         PofK7IIIxpL4uYA/jL0w0kY2C9hKIDsFrvzNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724339881; x=1724944681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fl1xClMzidzVLaAGhQIy4FMjfSjkpp459jOzZzWS8YE=;
        b=o0/6KjKexIPpafftXk+50wF+kAUqIJ2rRe7JPqeVtBqmDAAEferR2FL2lD5ax424AN
         v86sAnl6ealFMapudQU7/vPvW9CyxuyZ6iVJIL42TzJ8ddzNDuzIWXGXk06Js4xgKMwB
         FjIGEvauVhWtNkrSN5Pg2T3D2zaAnyhpIAtQdWReudxLMO//dCREPcNS4hdZ7cMY6Dnj
         oILC15Oew0sHES1I8a7uekVkHhvukmtvcxuxZe/lQ5SSjCCd0gENAedYGo96uUYB6u1/
         ZmxWiLohlHHL7vegUY2MHH/r9/ZpyujjvW2xrKo8qrERFRKVY5GIJ2u/OPFF3uQPnNeU
         beEw==
X-Forwarded-Encrypted: i=1; AJvYcCUrl0VvFwVhMDUOVoeRwi2qJrVzP1bN4tKGhlJEUO3srb3AnmNvL2CpNIC0MMlqpnqoChhqZzI+yuXl2KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHAkMxTrF83MLjymlp+r/klSXNJi/tXQtJT8L/9pOPHfar4fu
	mkkBmTiTmWlJqS9iZMtlpctVYKnFtDZCdfFQpwMz+mxR7IQRAdSTf/ImM/6JpotZdOtqbzxXF7Z
	cUjl5laPw3OR7chpLKFbNOQxQiMa4oCSZ7ZNVrw==
X-Google-Smtp-Source: AGHT+IGOx2S8RYrrO2KmV5F8eBX2ZNmhKR2OsBP7+OLhFCzIcQYvq7+iqWL3yTCj0laN2dze78uRVHH1qdmvhG/fKm8=
X-Received: by 2002:a17:907:3f99:b0:a86:9e85:2619 with SMTP id
 a640c23a62f3a-a869e8528b0mr24515266b.25.1724339881256; Thu, 22 Aug 2024
 08:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810034209.552795-1-yangyun50@huawei.com>
In-Reply-To: <20240810034209.552795-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 17:17:49 +0200
Message-ID: <CAJfpegtgp1brE3kY+juseZ+P_hfzbgYwG52eGc1BvR0XsBq2Bw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix race conditions on fi->nlookup
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Aug 2024 at 05:42, yangyun <yangyun50@huawei.com> wrote:
>
> Lock on fi->nlookup is missed in fuse_fill_super_submount(). Add lock
> on it to prevent race conditions.

It's okay to do this without lockinghere, because this is a brand new
superblock and and a brand new root inode for that superblock, so
there's no possible access from outside this function.

So just a comment should suffice.

Thanks,
Miklos

