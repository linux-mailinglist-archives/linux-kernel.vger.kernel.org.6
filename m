Return-Path: <linux-kernel+bounces-283736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5E94F85F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EDC2851D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017B1953BD;
	Mon, 12 Aug 2024 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQOMFmz8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3219413E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495453; cv=none; b=ly5eEKIA8Bv4aHSHUnVOzKpJMmFybzYcA9zsprut5FWAbhRrvETZ8QECK5JNkWMglZoSyp3HGkRLwghmGPkLtw8KT4427JR0itsYSeUaKxdl8UGnIqBZwR92Hp1kKrBHzv4QGnJz62qUyBJdZO1/a/MBGipqVu67s8cjNi6Srig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495453; c=relaxed/simple;
	bh=OKt4cWE0ZR9fy32NKqDd7AWgvE7+np3QM+thgHcpW2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxFNgubkDxyPirGi7kv9xWqRt01ahz80uHjnHANXvWF6P17K7wSg18dYyjudBHRyZIBORyVobwNkRuUaREXjwUUEKZx6stsm0IGF0+puUGkCrESjzK5bmyNNMaOwYeMmphDCSfl4WtZn/DyUAhUWXfDZCY9wlhPDWoHe8usSlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQOMFmz8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd7509397bso27315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495451; x=1724100251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKt4cWE0ZR9fy32NKqDd7AWgvE7+np3QM+thgHcpW2c=;
        b=WQOMFmz8cwW4tHY5eCcAdclqEdF7wQzoppIUtPONNXId1E9gErW1aBa9UIc02s+UDG
         ps5R97t2pToO8k9OGjSiMAj06zLFdfJCZxRaFuLpeEqL4dm2DRRk8uf/0OE/jzm5kzAU
         u42U4vWYFcORjWIrr6Wty3jlWkof8xW5oHY7woT3iDYF0IV6LfTmoCCDbaSajuBko+Lk
         BhjGxvFcmXWcXZWJ2SpGTPTBVwnF5hm3flLV3EXd4lYCl9/Pg/13BJCdb5qWeArGTGa6
         I5dzYaB1z3yi03h5OAGUjhKl51wQm5yQVatCvPCDemZ/XPke/puI21Pfk75n+7JUTiHV
         b3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495451; x=1724100251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKt4cWE0ZR9fy32NKqDd7AWgvE7+np3QM+thgHcpW2c=;
        b=u4FQ9bYNAQNIjOzoGL4BoGYCiU2y3u7yqcvy1TzRqrA+ZviZoc3DXXXy8TUJW7ZZPH
         LYOtW95KYygjP/PKNGBIv59KLtVNC627bvwo0Jlm6ZKRmcQYMEgkOChK+Q5bJl1HP0Tj
         F0AF6VL0XQnqxVvpVTGXbsMvqJjGfD+/dqSB6xGoiAJ/VsoBXFU30k57C9+S5d/9ps32
         FrIrBqxs2PGec4RQtZt5TADWLz6uGCkXYi1TS6oI50vf6dTbLxWuJb7esc6IdTDQKcMB
         LWTsL0paJMmfHvEA0lLC7963MKyyCoc2Ije0uizX/rn0oZ5kW3yDeJb8pr8pYUkRrhRm
         IOxw==
X-Forwarded-Encrypted: i=1; AJvYcCWIK8xg8Wantj8G+eySKNCpo2iSVVT1+/08uieDGXiGwH3vhKgCs+YYQGX/3MLSmEoP7au0IQqnodbCcr3Tl4VJ5v5J28h6hcMBqraG
X-Gm-Message-State: AOJu0YwVHdNiM+zgKPZJdqzosDi0AKi5VsHPuoDeVl9+luwP5ZDrmJZl
	aIQd6NeETfdzmBEN8AGgP661mkqcdd/FFcigm+J2faJ7fkX3H/GSTg7CAa+BZlXOSAAHISxVnJy
	D9T5VINhsbQzAtoDjFUAKy3MgrO0ypaa1OJEi
X-Google-Smtp-Source: AGHT+IGE5Tl+Gga3w/4KldporNOqhqhFglC+AC11EJZLS4naKh298Ze5RefiDxOY9/Atd5BoSplPlMUPy3fALcvgfUU=
X-Received: by 2002:a17:903:11cc:b0:1fd:67c2:f982 with SMTP id
 d9443c01a7336-201ccb368d3mr410965ad.2.1723495451258; Mon, 12 Aug 2024
 13:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801031249.176913-1-irogers@google.com> <Zq0kL-lyCqkM3P4G@google.com>
In-Reply-To: <Zq0kL-lyCqkM3P4G@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Aug 2024 13:43:59 -0700
Message-ID: <CAP-5=fUy6sx5ZMs6L1we2tpaq1iyUz4GW_ps7c7xE1zqjVzvgg@mail.gmail.com>
Subject: Re: [PATCH v1] perf inject: Inject build ids for entire call chain
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Jul 31, 2024 at 08:12:49PM -0700, Ian Rogers wrote:
> > The DSO build id is injected when the dso is first encountered but the
> > checking for first encountered only looks at the sample->ip not the
> > entire callchain. Use the callchain logic to ensure all build ids are
> > inserted.
> >
> > Add a for_each callback style API to callchain with
> > sample__for_each_callchain_node. Possibly in the future such an API
> > can avoid the overhead of constructing the call chain list.
> >
> > Fixes: 454c407ec17a ("perf: add perf-inject builtin")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Ping.

Thanks,
Ian

