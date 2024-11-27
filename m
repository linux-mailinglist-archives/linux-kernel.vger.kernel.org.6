Return-Path: <linux-kernel+bounces-423945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226C59DAE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87A0B21023
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41FE202F9A;
	Wed, 27 Nov 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QGatPruK"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D780202F7F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740232; cv=none; b=n7RAS0awE5aISrPMbv+37kfPJE8IYh1lwzoz4R51HVGHF8wGF7janxA+CxHe72dQdkjjQON8czphgRq9zahSLswhfmeLcsv3odrJvviZ9pwwDgJ4FMEyc9oaptcgPTWoH+LW8aS2C5WHFGSRwqFmOS6BuqqO+orFQ1fjQaF/z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740232; c=relaxed/simple;
	bh=gvDzDWwoLjKYOe+3nXVcN9rkQhMxMxJQfxXW9CEi4Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WX9K2rSHeYK6A1m+VQHANUNwWOfGUQSN1qBA4Ysz4xtQWnEhtpADliEoDA6fFEOIALP4kDv0VtcC1DBd56DTu0N0F5euzrFXzats9mzHqL2tlDuVd/Vh26Lv7zzLv9s25tuAWhKXkE2VRE5JJRDpzeg0q13skOz55f6p+/29/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QGatPruK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso10347466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732740228; x=1733345028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvDzDWwoLjKYOe+3nXVcN9rkQhMxMxJQfxXW9CEi4Dg=;
        b=QGatPruKJ0YuN3QBs5Ll+NULSbLjvWu4kk5uuH/JndLbuKRCtdci95iD1HeWCKadV5
         nQ8VQhTsflYu6WvGyxcjPy0jPSMw32br+9w/4gf2i26VimRYdnTwSBGdTi/+NS9lvsiR
         CksfO54/ZFotjYTcYpg/NOgCEJSuyIGWXaEWBPPZewkoObKFmzrVmMMupVizbXhWO/F/
         YK6rJwxtszNmDFhMaDyXLUZY3byOsnV9q2xsI//lwzRYTszideqQLPowQMsNb0jh6Ijy
         bZzur4wPUUKoedrIx3gtOSamPf/UWUwzb1fXGoAjmoLCcg+S5ecrPpvAAuZF9zQJuo8m
         TULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732740228; x=1733345028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvDzDWwoLjKYOe+3nXVcN9rkQhMxMxJQfxXW9CEi4Dg=;
        b=O1VDkxk4OBBJbj8EWq6O0BPTsiZdMPy+NQVPZQwHYvuTJeRMeoFYTWY0I80QsmQPYc
         YXkW/1IRxGgDnLjcLyq8gkMvLhhAmHH2rlzMfKsXmPsnLbOI7utesUzoxEzE34IeB1iR
         ihVg65oOy7tPK97KOanhcXqYSIwF/bfPML/mxk6Y92JPk/Uqv2G2tgd9cmJkcFUiOMBa
         xxowNZHBtm00eygffD8lXxiOZg01jy5qpOtaiFsc0xX0KgKglDa9m0LhSmuQSAsjzXHP
         G8eag2acIM4rN+eHBJ8lujY5dH6rBfA7Po/ZXPt56IteFZ3gEMR+cDtkGxFUsTpQg9Cl
         sU6w==
X-Forwarded-Encrypted: i=1; AJvYcCVitruDqtR9/8sTH8dCA+E/OBFijRgQqOOj5Gd+CGsZiGMxnpejMbGWl1MMuQNNX7fRa3aeeMGK22JoK3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPg2HLGZbhn0LlPmnP68WXvcRq2VI/O3MmgSqy7nnlDSapy63Z
	+xfiSJu95Z0YBKnF4YF4uXKC8Y8vzJJEG782sHIR/Ujmrg2LI+g28VUx6W9VKLCdrXYfEx6l2bj
	TSAlWItHW/GcLkAvcaOOQPzi380G5E6rIUpwqDZW+kJxqjMJYLH+H6w==
X-Gm-Gg: ASbGncvF6dgH9qT3XZd0KpPGIMoYs/Vhu2UskWl9JwqtlnvVpQMKdkAGhBr19A7DjGk
	VsCAPgh1UXxd5V9BKUH1HPqWEh5Xcmyvgni8Em8xa9snLuWJVLQtZYbT6+OvF
X-Google-Smtp-Source: AGHT+IGpuWxQT+so7sHdDoKBZ/oNoLvCwstGLiSwb/LCehEnCsg8aSBbm4XVUTGKv2uvrB9jiH5IFMmZ4Z1lGRP/a74=
X-Received: by 2002:a17:907:7622:b0:a9e:d4a9:2c28 with SMTP id
 a640c23a62f3a-aa581061ab2mr300001566b.53.1732740228683; Wed, 27 Nov 2024
 12:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165405.2676516-1-max.kellermann@ionos.com> <CAO8a2Sg35LyjnaQ56WjLXeJ39CHdh+OTTuTthKYONa3Qzej3dw@mail.gmail.com>
In-Reply-To: <CAO8a2Sg35LyjnaQ56WjLXeJ39CHdh+OTTuTthKYONa3Qzej3dw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Nov 2024 21:43:37 +0100
Message-ID: <CAKPOu+8NWBpNnUOc9WFxokMRmQYcjPpr+SXfq7br2d7sUSMyUA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/file: fix buffer overflow in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 9:40=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> There is a fix for this proposed by Luis.

On the private security mailing list, I wrote about it:
"This patch is incomplete because it only checks for i_size=3D=3D0.
Truncation to zero is the most common case, but any situation where
offset is suddenly larger than the new size triggers this bug."

I think my patch is better.

