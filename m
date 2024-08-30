Return-Path: <linux-kernel+bounces-308407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A4965C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496B5B2122F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3A170A00;
	Fri, 30 Aug 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cifechxc"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40516D317
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009587; cv=none; b=ZsojZQy9ZATVqrF4wuPBL20cv9cm/oKxuMYezUULvcdXHCGAjeaUwvq+A/uNWaWu/DkZy9EUi+30aneVLjD1WvNG2Xu/2sCH4pdVVm/bHlxxwaJm8tX7/hyjt5LH0MZqyoNEKIREzjM+lIaYYB+IMgl3dbGfzTfq7iwPGKfciRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009587; c=relaxed/simple;
	bh=PL85+RI8vh2WXnZG61chnGXtTjzaWWUYh9Gpky2rmY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfotOrd2Ikbg9XbOJt7MSzTG0mZ0+f3ZmKyRT16/XekD3XkG2nyaJ4sdwTMDgpNOsnA1Y233kGGBz2HBCJNOKXrawxzkvQGWRX7gioWvTa8cV8LRZaAK2IR9yequ3a341x+p1JjJ0CK4U3ODwzn55seqJqkkPjq5Rp8H88oVnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cifechxc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86859e2fc0so177916866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725009583; x=1725614383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PL85+RI8vh2WXnZG61chnGXtTjzaWWUYh9Gpky2rmY0=;
        b=cifechxc8m11Udi9kFH+m4UaxNxQk0ZlYKWX1LBrbQLjeKjZno9c9EYzN1o2IyXI9h
         d/A43sgACjVaL89P+MMA6/WOCHKvk20ZsfU1Nl13VkZHCp9jJLJKl0oO5WMGd5KcsuV1
         1w7Gu40mwhe2Z07Ni+Kb9LXbxZWQzNV9Tm9n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009583; x=1725614383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PL85+RI8vh2WXnZG61chnGXtTjzaWWUYh9Gpky2rmY0=;
        b=ERqzaKPuiG4P9rAOXgtHMVwpEJcmjhTuqXWlpVG1dAz5CBNvmO5Cl/XyG85W9I+p/2
         MEQC8gKzGKfg03M3QeE/lMfCXfC4PIAu9seKNy68UpKZkdEwBzgcaoAvQ4G4fnVIBDi2
         XqgMJAQM7rnMlpW7iJL0gINrpwor1yZmoxXqLHSkfyx8eNF4XYnQn2zXL78UyyjTDTyW
         Fu57L+N85UuVbPjdkgtr2DYStDV1PQE63+wU+eDgxSAQ8Kuju/PRHV09f4cu0xPg3N5q
         IqI2Qwtfe12ZaYzpt6hB3wGAwAju0Sz+k3JJ7BX1PwDq4s6LeSo666vfufF/SiVxf+fo
         NUIg==
X-Forwarded-Encrypted: i=1; AJvYcCW3rKdCJBxB9GK6/AhE8hcAFcZg5jTxpiCHT4t9/foa4H2+34D8UPWsYtNzX0o673hPBD9yfoFZ3VFGEFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8U//q/vtzfF0LJEKBJ2JGU5EAbr731IWYLwMIWo4YPIsvDfh
	agIEiNyWJxUj1OyQtgZeELO66ZuTHGUXd6psR8WRGJ3nnuhu3f9VY4ny+XYhJv9lZwg1uJCIuo7
	lRa1U8HV0xvoqWuT1ztyhMB4G7x5kdW6iz9tuzQ==
X-Google-Smtp-Source: AGHT+IESVdlaSA97LQ9pHjyEMyjV5aoj65F1KCwOqpL5cnFNtljUt9oHYPUt5dDJC3S3UBR82X6iQiQufvuRt+IDsE8=
X-Received: by 2002:a17:907:1c9e:b0:a7a:9ece:ea5f with SMTP id
 a640c23a62f3a-a897f956730mr407074166b.41.1725009582857; Fri, 30 Aug 2024
 02:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824092553.730338-1-yangyun50@huawei.com>
In-Reply-To: <20240824092553.730338-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Aug 2024 11:19:31 +0200
Message-ID: <CAJfpegvsO6EQkAQOt9XRN_HqG-M3rYAd3-4+BeCFLu85350vxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add no forget support
To: yangyun <yangyun50@huawei.com>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 11:26, yangyun <yangyun50@huawei.com> wrote:
>
> FUSE_FORGET requests are not used in some cases (e.g., juicefs) but have
> an impact on the system. So add no forget support.

Applied, thanks.

Miklos

