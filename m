Return-Path: <linux-kernel+bounces-253139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11531931D26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9C91F21DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF013D24C;
	Mon, 15 Jul 2024 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pn3j2b9z"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BAF61FFA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082319; cv=none; b=RhbIXcnjpxiaJ5z6Xlttlrqn4mkZaSHw5yQ3VOrNGSOabucDfqQmT1nVrCTHPupMxKw+J9LhyGa7WQ2GflnrbZvypOByMkFrn1LhzO1gZ1AwEtg/cLry7K6mNgXtAll5/OAngMRTq2wNO3GBD1fFE+l2YanGtEwnJ2owolQFfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082319; c=relaxed/simple;
	bh=VDosR8c7HVdHMUbSmYVlLvcmNQzOGgdXeW3Tav7KBzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjFl8zJbfnNrehUQdbS0eRgpLM3Z7cNCta7cyxM2Cnq/LHjgxu3Q7ZSNsqBn1mO0Z2S9IbwUJiqumDZeO42yU4ycm0uz5O/Rli3ue+deOjAl2noJWr9NToqHls/5Qo/WOUnk47WigzXMkUieHER99mZoIITEE3PQcNo6FHExBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pn3j2b9z; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447df43324fso62131cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721082317; x=1721687117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDosR8c7HVdHMUbSmYVlLvcmNQzOGgdXeW3Tav7KBzk=;
        b=pn3j2b9zi3XTrM02C7ReXE7sV/qPEgq4U+xAa8SxqmK+SATpL398jkwaBUUR1N00cR
         6A2rJAmqPZEpYkhtu+2rVG+uMtU2KuQdaA4xas+GJ9P2pe1iYOdooG+G/n3abRbEzXLM
         0LX4op730olIqcD+8Uy43xXTI9Iqq8bWc05tbPEA6R0O7Cl2mp/bmnXfFBVVBv0am7vG
         +CSHXgtxcos3mlf7udAeE4/dBj5GlcUsDoVSKAxKLD/J9v4IpEJZMCzkSniiM5puElCB
         Yy5iDJOSfZUF5JMYh3GjxiO5bOinUY0y65u2BL4ITYysQLLoA0j1RqrqSfD5QYB3s/xU
         NS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082317; x=1721687117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDosR8c7HVdHMUbSmYVlLvcmNQzOGgdXeW3Tav7KBzk=;
        b=IPGzBzaP6RvytFjuYlus3kBD9RkMbq4mdiXTvBzm8cB+IrX9erfHQ27UBMHCnc/ebc
         HRUiMwYC9Db2krp9heSc68wW+85mQr/D+yCzA7rlCbkKTbq4cxyyX31162n2jgpd6j++
         p8l3Qh3BVZQqI/nqk9m1GIC+OVA2tHg+G0mgog1czReahP0qvJi2iTehNqG0IoJ9lnjA
         2LMyWIcQZg6aHIZUhISc9RCLC1IUM+uppk+W79MwxwMOIVYF3iS5vgg+IqpPmDgihhXN
         hcf7F1P6u2YjuRAvUjSKS2sSs/gZzjVoWZ4xefxHOLW3k7nBuKnUB1GbsTEgBQthHPn5
         HdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG744ZZ2NQR+SYrWizKG1EZ7nXBoIspAryfH7ivdbqqOwwgl/QEVRIo6PMVvLJjLxLAL5Ua3JEC6aO6wSStnKhGl/vmUBiD0X/2viW
X-Gm-Message-State: AOJu0Yzm2thrpr8m+1tSfSpt7pIHwn5TYqTiQvTEjbhMJRZylhdv6MYQ
	FYpB/f5W/OHiYz7HY7DugiPB5pwYtQk5IZ+LRdi3BGyNOYJhlVXTmyir1Z5Gcv7iAy7g8LCD2qr
	He15ILe7bQCcp3MB6VfKu5PwxTWPa1wtpfeUX
X-Google-Smtp-Source: AGHT+IHYyLx5NZMwuMuZh1Z+E4Fk+g7KzT9Wi9MbqWX8yuGKTcGdIruyD9WKu8v1r6Koq/eGYelxM2+D839RrwOyfs4=
X-Received: by 2002:a05:622a:5907:b0:446:64ad:ee91 with SMTP id
 d75a77b69052e-44f7a7425c9mr1258371cf.20.1721082317051; Mon, 15 Jul 2024
 15:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522204254.1841420-1-weilin.wang@intel.com> <CAP-5=fUtp_vd=EeeesXPR=nsm0VOZoyXico=EVWobOEYsxq27g@mail.gmail.com>
In-Reply-To: <CAP-5=fUtp_vd=EeeesXPR=nsm0VOZoyXico=EVWobOEYsxq27g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 15:25:05 -0700
Message-ID: <CAP-5=fXOTmMyPx_tQPoCfCP35E1o6YSyZde58ojyU1PLJBt96A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] perf test: make metric validation test return
 early when there is no metric supported on the test system
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, weilin.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 6:26=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, May 22, 2024 at 1:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Add a check to return the metric validation test early when perf list m=
etric
> > does not output any metric. This would happen when NO_JEVENTS=3D1 is se=
t or in a
> > system that there is no metric supported.
> >
> >
> > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
>
> Tested-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

