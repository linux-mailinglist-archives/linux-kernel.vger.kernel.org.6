Return-Path: <linux-kernel+bounces-279955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680AA94C3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993911C2231B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1314191F65;
	Thu,  8 Aug 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="oIxak6Lm"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB318756D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138703; cv=none; b=pcrphGFZXAOzR9tQ2ObaW/mb5LF82O2B0AC64StTNZBHJ8GZMVaZFfK0UDFlxOrJC8yS6iw9kpXcOtRht8pX6NmMHOLXT4EyvMctJMufdNH3W69vRavFJ2d4N5/4/vpX+iztBg9T7zBUNKvgOPVSyHgmqBg7xF23ToclRUfgaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138703; c=relaxed/simple;
	bh=ocAJDrTQkqPtVrAouvpO6jBQST6L6jBb7w2tfCG05PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aer2kzu0fS8xrmiOE62pV/Qja4EL1lfXduLUv2yNB575pDvcSdJLovFdabnlEjKe+Q5bLziGxa2kN+qgnMkK2tDNS3ucEp+zO7CXCkuy90TsrKhhJBvku9rCEHflYhjm62ohWjegrUu3cIQenSEwGsNEudAuPEhVBxGkn42EpRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=oIxak6Lm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fe6672297so7117171cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723138701; x=1723743501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocAJDrTQkqPtVrAouvpO6jBQST6L6jBb7w2tfCG05PE=;
        b=oIxak6LmaW+ul2TX4KeGUUm6OxxMbx4lz71UosjntRsf+GPlspIb9QMRQ7FhJxgR8e
         tk7l3C8aKNJl4Fan9fmNB/gpPNGK9GMxccBt46r1kFf9i91HRB4bqUMFwpkr3aG0JNpv
         IqwdCWh+mEL3M2PnhrAnlkaLeqgZsmYPGFb5lggkINlLrNLituTTHf8VUiNTt5YMYWFI
         Gt1smUAdvv/OEo0SqXKyXcg0djrjCKJj8XH8ygjZv161G+/AqY3e2AkgH1U70Gz1jZ6N
         n+Y0Ba3e+dgQXVunJ2x67MJf3yquZI4AZI9uput4JOqU9oPHnBMb+1/WhO32nq5+o6AV
         Il0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138701; x=1723743501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocAJDrTQkqPtVrAouvpO6jBQST6L6jBb7w2tfCG05PE=;
        b=uMrWnKOTRzXMcQKUYfMR1eVrZGrgqcewn2csJPvkbGealdH9pvE/5bQ57s1gddFeEa
         Q5z9Mhb+yWe8Kc0tTDwLgEBr92ZyR9Oa5K49fTaiqdVVZvHS7CMEBulAIM8c/eeFYg9C
         7x3t7C+YdJL2Q/17CY9+Og+LDLxQspU1rNtHjLtCT0aZG2aN80RXO3MOAAL8cVtLFNOZ
         8e3O/TkFyr9L8F46syIkraDkA2Vx1r1Ru0CK6KFc9thcfOZXCvK2LqFDkg7RcrdoJiDr
         wUgoJRkrnna+hxHpTpZEeOZb7+YNLcUQqfLpr2gyn5DIlyEW2JBAerx8VuLJIHkjn8gt
         20dw==
X-Forwarded-Encrypted: i=1; AJvYcCVa6ANT0ifry/mA+5OEm6wxZxFckmd+VjWnL0rUoYCDW5OGTblH/J5/Pj8Lmx/LPXOGn8fKkhWwAwWVU0pHu7gwmRMHCu1Tm6yYlf0r
X-Gm-Message-State: AOJu0YzmxKQU+2IYDiluFcGLQ/W9dZgkg0OvbB5YSat/kPNC0WpkfIor
	QQBFp0nO5yG064Wi5P9PDUqQFlHxA0BjKhStW8I0el6uIuCoCXvORTr5vHtbNOutq6G0IFrqDm/
	2XOUvz6v8Xfbbox5VWS+oiPqyN1ClDVpfU/ycmg==
X-Google-Smtp-Source: AGHT+IE6o0qf7cNLixVlu3yVupxhxh/ptXeCvvwc+dwwETtd7M4Sg8SqgxhhW/X7CIyOeHv/Ao1yGWqyQOb5skvlEoQ=
X-Received: by 2002:a05:622a:5509:b0:447:ebc3:bdaa with SMTP id
 d75a77b69052e-451d41fc177mr34125541cf.9.1723138701270; Thu, 08 Aug 2024
 10:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-2-pasha.tatashin@soleen.com> <CAJD7tkazuUKaSv_S+wQ_PGSJML=0-kw1VKFmnqsDjVenBoO--g@mail.gmail.com>
 <CAJD7tkZarKQ5kN26r3hUQUvj-mWZ0fDMw+yPuSdrUU+XtTxAWw@mail.gmail.com>
In-Reply-To: <CAJD7tkZarKQ5kN26r3hUQUvj-mWZ0fDMw+yPuSdrUU+XtTxAWw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 13:37:44 -0400
Message-ID: <CA+CK2bAL7eEFh_CfYbYmc3oR-iPgGq9zx6-ghAqf62DiU79A8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: update the memmap stat before page is freed
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Aug 8, 2024 at 10:17=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Aug 8, 2024 at 8:42=E2=80=AFAM Pasha Tatashin <pasha.tatashin@s=
oleen.com> wrote:
> > >
> > > It is more logical to update the stat before the page is freed, to av=
oid
> > > use after free scenarios.
> > >
> > > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> >
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
> Actually although I think this patch is correct, it shouldn't be
> needed after patch 4 because we no longer use the page or pgdat to
> update the stats.

Good point, also there is a warning that pgdat is not used anymore.

I will remove this patch from the series, and clean-up free_page_ext()
by removing pgdat, once patches 3/4 and 4/4 are reviewed.

Pasha

Pasha

