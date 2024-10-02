Return-Path: <linux-kernel+bounces-348074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CDF98E22D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306431C22D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D904212F08;
	Wed,  2 Oct 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd7R/dMm"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72366212F00
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893202; cv=none; b=dxytZb+LbOhGZQwWJfygkfVY9Y+uTqlU37V7+hjF6wp/aviIO/0f+knfYz/olh7EYxR59nXphXMUhnq29M/WwHd3M0xN9+MaL2L1yshztU5kjI5KaswbUEjAE+R2T2B/uLCwfQqgGttIECVR1j03iG4OqXa9rV71jT8cSVynkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893202; c=relaxed/simple;
	bh=HaQFLf+l9DMED+/wBcRUiF/euWvlKZd+rXN9RCC2BUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7nPV9egTMIR0ZiBv6ftX1FeoddV49urz1QeZIuxfPcYipW5r0vw0aV89/cGXUpwIkX6RBPThu+nxpqVVqOjMWNZAaJn6plbtwfaLd1GP4YpEUTpwSkrP/XTTm3u897ZruTbGYEr29w0X7VqvydHyGtg6E6D+MXQhWON+C+lpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd7R/dMm; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84e808f3c3cso36016241.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727893200; x=1728498000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMl2pdoVZ54UMB3JvErnE3Z/0jRwfJBMuQ45RPY2KCk=;
        b=hd7R/dMmwAR3svQncMvgxl11Y21EHxIbxJxPrnSSCdVyhWWR63pcN5PxE3TiKPJMJQ
         OYDX3N3qJhcM9jPK9MDgtP5hHxHUMcViILOFm/RGkh/EnUv4X/RrGLTYWtZo8VMOpP96
         cL+xFIVeiZmAWGd7LmPJdZZcqQT0otdFOsv11kVKoQMjOHkO+1ngjLg3g3Z40ZXikIlE
         YfrvQs7zfDrYQ6GReH/4DK4Kr9AnGg5FO2OE2pSb9cRe7CmSBgfmemqw8JWso7uHqkqT
         5wIX+mCbJRpRILeU6EdSn4CKyGLDWyp9RhIKC88d85PZ4yNQ97XSWtTDkMcEAJfr+q99
         Q5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893200; x=1728498000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMl2pdoVZ54UMB3JvErnE3Z/0jRwfJBMuQ45RPY2KCk=;
        b=JnFCn2S0PFV8kxvqF1q+FiANLRNF8PG/+9K3Eso4fr4vX9tRCEGvGmLEv/WpHrwF+N
         HPyAbJM6HT3Whlsgp3B6Xvu2v3x21vb8B918eOFwpd6CyIZVUcUZZNY3oL7NVCz481a/
         mbXJmF8ApFxZ4JoOIvKNfCyUSjumc5PVh8tKcHQaKF0FkEFMuqvU7x3THBLuBoEPpC0u
         8M9XRwa2P1lK9emA86szXoEVCE6/ZU7gysXD1pLLntsUqGeSk2HB5VzjEAMHrJCHmXk1
         soJb3LkDkz0rGnH3NnyRjEdWFdhh9I/JsiUrMTw2LH8OMfb8xGyXPb+Mf3axJ/YnhhZU
         gdSQ==
X-Gm-Message-State: AOJu0Yx5eVDCQzy3MhCqI0gz5Z68FDapy98ueCgBqxBoyuO8twUKTqv1
	5M9TW64UzaYLZPm2yZGNjKacqUHkCLoZd+TRg8yR3mMo0y0t6hNmuZHLFhq2dbNsxixM55w5Kei
	sYox0LK0FIAAEgySifCU3wRWu42Y=
X-Google-Smtp-Source: AGHT+IEuOYXkR3SC3ifP2kcZy97Y3ZZLCs6Nzzcveb7tkd2yhWPU0EPY2LypS6RCyZiy5freSXgU/mQIvPr7XEzmSQM=
X-Received: by 2002:a05:6102:4192:b0:494:560b:6c07 with SMTP id
 ada2fe7eead31-4a3e6870f1cmr2760435137.16.1727893200250; Wed, 02 Oct 2024
 11:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002173030.213536-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241002173030.213536-1-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 2 Oct 2024 11:19:49 -0700
Message-ID: <CAKEwX=P2SjOQJzC-MQGvi7CamGuCX1LCA0iYazoBTOQgZ0nD=Q@mail.gmail.com>
Subject: Re: [PATCH v1] mm: swap: Call count_mthp_stat() outside ifdef CONFIG_TRANSPARENT_HUGEPAGE.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:30=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This patch moves the call to count_mthp_stat() in count_swpout_vm_event()
> to be outside the "ifdef CONFIG_TRANSPARENT_HUGEPAGE" based on changes
> made in commit 246d3aa3e53151fa150f10257ddd8a4facd31a6a ("mm: cleanup
>  count_mthp_stat() definition").
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

