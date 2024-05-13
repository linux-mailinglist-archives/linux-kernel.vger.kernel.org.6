Return-Path: <linux-kernel+bounces-177883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C228C45CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C62822F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BF22612;
	Mon, 13 May 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VNWfQFD"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA51CFB9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620394; cv=none; b=ibvN8aAbhww5vyeiwDW0VXBYJ0vh5aQwbm3tnA9lu7/G0xcOv0mP2P7cR15LzkNpI6BH3WO5eaxT7egwnx5dHSmHKZA00LuxsX09UABblM2VLVQVtJToBBmpteVoXDNZbZxRqrpRsYQEg2u7FJ2RMJX9FpYHKlwjNkXfRT4TjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620394; c=relaxed/simple;
	bh=lnR1APljmIH03rmMQHJl0kK8AphsBZFL2sGEtcS0pIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyekfpvcLFXjC7OfDczlTYyVOKhTnlatlzel4n4iRDxZiwLph+njlU9MmcDtwRpJTzNRA5+0DKM57FwnxeubuSLSTrgj04prrzQhOVqUeDtWmsQIGrKmAv3am2G+s5HTUYewtZZWPIiCDyJsKBFlF4z5UVkVEYiR784gFMW+4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VNWfQFD; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dfe020675so860361cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715620392; x=1716225192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TITLmmYxLbFcBdgKs9jfudTIyaXBl3JLzkEtZcPj6iM=;
        b=3VNWfQFDww5D++cnMYUTAJEnp8H19Shi6nBrxXoKNonRjjREGtDCb8QWJPf6D/EZ1+
         h4d0JE+1iYy/Xrc4LtzaBvCI9RCanktuC+WJ3KXP0YWyqTsvPIaL2Zl3Dfnhi9Sgn2Xo
         Ly+I8dV4zV4XC9A6ZwUBmjmmD1BNy0oAQ3JwF+7mQ+L0q4K9FoiK1RO//RHJSky6NNPi
         ioNVKw9KXZtJqmNjvzO5MRtML1RN2CAsOSr7LcJBEEsNRox13GN5AIMo2bivPXkgY7po
         odNXAynYhBg7Mjpnv3aibD6V4Mxm7inm/Ne51Vg3OLEgUnRNI6XxKcdd/VZisCMT8MYW
         GzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620392; x=1716225192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TITLmmYxLbFcBdgKs9jfudTIyaXBl3JLzkEtZcPj6iM=;
        b=hEHOQymUtmfZTL03zqB+woD7P9Gnx9ZSIK8wrZVHRMdcZn6Pds4tz4dia4v8H3KWfF
         m+emtjPVP+w482h+UMbXNAQTGQzv+i2Vukux5LQL51ye8PRxNg+JoesjS264iHL5JlXR
         2dci9zDaAmF3x/Gd9nv2nsYaD6uVShz5jw40eJFevrNQQnAjUr2mDd8aauGPjYZ3BjQ8
         TGoxOrjL2B8x2wMrWIaXht53H0LWyk2i86lutgMY049YF6spn5g1GXW7eAvHnj8RJAjZ
         9I6JvNBtoDrvEmRXDcIwlMFwlDN+991LNilxukv5rbLFXAzdRs2VvKSkN8kqwiu1ui4S
         DMhw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1CzMKPwYVWkuMn7fryLr8RN1HDtQFPQ4xSKMcW1vgGps2Af0BteIBP2LjL283GvqavInh9NIz58I1vyT7PIpDHDU1unkaTTcjnBE
X-Gm-Message-State: AOJu0Yym29hzxgRDrZVrPUpnP5qqF3TShQVl5Vo0zaq+Dkp49GeynNlg
	8Tsyxq62Qfzrjk0ppAXnwxLSIFQAuLYSgCEiY+OyJIS6kOTygXOieHOxb/H+XTSt0LgI7u7yu0z
	eWGuJCb7l94gsEXMpn/7Q1FRIBc4AanbK/tXDAQ0qjKR0J9Irqg==
X-Google-Smtp-Source: AGHT+IEAb7Fu5kKXgnCg0HYiSTA3/+R79Po1+IwMmEjCt9aXoksBEl8u8nhvj+mp18aBdE+jvaZmZMXcFsJzaoRrzgA=
X-Received: by 2002:a05:622a:4184:b0:43d:e294:3075 with SMTP id
 d75a77b69052e-43e0a21da9cmr4872671cf.7.1715620392377; Mon, 13 May 2024
 10:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508133518.3204221-1-leitao@debian.org> <Zj-WE1aG7ihtevG3@x1>
 <CAP-5=fXXYVgb4rnftaiTZTEniGOr5NnpfXJFNqX96GXP6=oTiA@mail.gmail.com>
 <Zj-qIbUN2XFBnvP8@x1> <ZkJI6Q6KVKlzDgSQ@gmail.com>
In-Reply-To: <ZkJI6Q6KVKlzDgSQ@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:13:01 -0700
Message-ID: <CAP-5=fU=tG9Gk+OfO3TVfBONTc35oksNqi3xm6Y_hjc0oOK=dw@mail.gmail.com>
Subject: Re: [PATCH] perf list: Fix the --no-desc option
To: Breno Leitao <leitao@debian.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:08=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> On Sat, May 11, 2024 at 02:25:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > With Breno's patch the default doesn't change, --no-desc gets fixed but
> > --long-desc is broken:
> >
> > perf list --long-desc
> > <SNIP>
> > cache:
> >   longest_lat_cache.miss
> >        [Counts the number of cacheable memory requests that miss in the=
 LLC. Counts on a per core basis. Unit: cpu_atom]
> >        [Counts the number of cacheable memory requests that miss in the=
 Last Level Cache (LLC). Requests include demand loads,reads for ownership =
(RFO),instruction fetches and L1 HW
> >         prefetches. If the platform has an L3 cache,the LLC is the L3 c=
ache,otherwise it is the L2 cache. Counts on a per core basis]
> > <SNIP>
>
> Oh, both descriptions (long and "short") are being displayed.
>
> > Thanks for asking the question, I'm dropping the patch, Breno, can you
> > try again?
>
> Sure, let me think about it and send a v2.

Thanks Breno! My bug, thanks for digging into this.

Ian

> Thanks!

