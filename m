Return-Path: <linux-kernel+bounces-511832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4FA3304C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBE33AA1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9305B200118;
	Wed, 12 Feb 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR+uY2im"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E441FF601
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390457; cv=none; b=W5sdcxf5jT206XDwGBBlQOdbzAsnD0G8S+koYVwef8amXX7WYM9BJQOZTd8xOK7rwbmJZUow2nqHdjl3WNbTiF8uzOzo84LdK7BFmHYLequkMx0+gKEcLrVY3z53lgrco/ntqO7yqRetitFcD5eAQCDDqLrTC682MIlSTJiaHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390457; c=relaxed/simple;
	bh=0pG+JRaVXBqhNYTI0BMGYl5wF4aFO16HNm2CNHXCsRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA0NK9s2ChHH6W2ifwxhZi+A0ewfp1b/rSK7pNKfwr+Nm4/7n40alTbK9gmt8Ny7+RmaI4sRwiOcfukhc+XZeZcJ5eIcJ7g56anNCNitDfx6bUbkF4nuiV9BN1WL6Ke1qhwq10WU+Cjzp2eN0gEwYWZ2pZMS3AdUslX/1hgCmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kR+uY2im; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so33195ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739390454; x=1739995254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pG+JRaVXBqhNYTI0BMGYl5wF4aFO16HNm2CNHXCsRE=;
        b=kR+uY2im3vikgcdH6pNtrgT5uXPdBLXooyXAIYizJeZg9n92y4SdW9NeOiHeorD06C
         uWsc/9eWaHlPI+j3FzhnKB5fnUL1TJKTmm3La+0XXAMt4KG9MWUn3ZL4Dquu0xLFE2fM
         LOw0z07EV3HI2Brd0hS5qO1+qhLKrJK4FCpHHv/8wtiRK/UdTuLPwey6K85qDDM4m4J/
         0uSSDQSM2knyrXxAzXIbkv+9M2FxI0TUecNLZ5pvQQbwuOr16GxrxqIYoPdaNhz+4w3c
         xwlwugo41Sw2UxYJyZaQtsuHBxjY1mDXfqrEqLGJfcStdSMwgoAqAbCFyy+OVIHoCtNQ
         xBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739390454; x=1739995254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pG+JRaVXBqhNYTI0BMGYl5wF4aFO16HNm2CNHXCsRE=;
        b=Z4zoPFQiY4EU5hglaGcoQb4PMYOGKcqPn6MCAK2XtLp5wk37aZaR4g5BpJmJO7jYDo
         nI4PwtIncbwXSfdAtKx03tg1FoSWnl6evL29v1M05N5oqA4AbyXdQON3jHoiR73lvWim
         mKSq2zXm30IyWZ8a4Ll6t99PkDleAHLGJm/bVcMN61b9WQrHBt9p36OXpsU6W9nVtfOE
         opJgCHRG4WNU23y3Xfd4KqjfkkvbdAA3JlGGyNKzzRk07hxCHXgYpEtFuAdsAABkdK9T
         cmcuW0NOOeRNJuupIVlqxd688tVSNUfHnNIk8h3bvjMWXc9PUNA0wZWsEr23HcLR9gEM
         BmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Z6CJM9DpFo58fUWy8/OBjQ0lktNwpLn3xh1KYBAxMS+Hc3mPIobmBjMz30LvMVFcJtGsdBAex3GV1CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDKV3mCorsZWDl6yHc+fpOY+iOkxWgYlPnzyfHwaMWwimyB8G
	S3n/R9Jfov57WACijPXG0hO7pCwbyJOPI/6WoQgNWymXxSM2+/7R4d87HkXS0TyL8TLDuoRZS54
	L7DOBu5WMOAYyOXs+Rw87bXpZkP/yQ3xrA+nb
X-Gm-Gg: ASbGncsD6p779VjDzEIUyzW9uvXpzsC46gQk8Sjq50kMN9JGNlnKowz0s93BkK7E+xB
	ddie54rfwS3P4t2rGf1LrTyb2ZyNqaVMP1C/sWXGE4mIpxCH5EblZQwwXsOv5PhwOwVRHgxE5JH
	dwqiX+VhUv4BJf3/2Gbw0zips3
X-Google-Smtp-Source: AGHT+IEB2+AmkIaAIOFeTQ3Nx+SbWIWSCka7nrurGRcxVhzIsTGvQ9larnnNye37zvZb1s5tc7xUC5PpYKHHlDl1Gic=
X-Received: by 2002:a05:6e02:1d06:b0:3a7:a468:69e0 with SMTP id
 e9e14a558f8ab-3d18cd73592mr371945ab.1.1739390454354; Wed, 12 Feb 2025
 12:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com> <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com> <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com> <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com> <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com>
In-Reply-To: <Z6zslLa8XM1ubwXj@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 12:00:42 -0800
X-Gm-Features: AWEUYZkPHlCKO0ya0iQ7pvFOSdQsLxZFLpDtuZpM2UOOjOUU8vOMF1oHXBvfyp8
Message-ID: <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> It's not completely broken and works sometimes.

No this is the definition of completely broken. If it only works
sometimes then you can't use it, we can't put a test on it, there is
no point in it. Even when it doesn't fail on perf_event_open, does it
work for processes that start after /proc is scanned? No, it is
completely broken.

Thanks,
Ian

