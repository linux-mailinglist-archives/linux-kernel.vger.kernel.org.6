Return-Path: <linux-kernel+bounces-193130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912228D2739
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAF1288721
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CED517BB2A;
	Tue, 28 May 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fUFgJrTO"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADA17BB03
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932592; cv=none; b=F/DC4PgXp0K+BmT0UbZuBGRWg3gcF4VmK83j3b3jsa+6y0UFDhmo5srPmICFr6GGRnqeShXtEDaKUFz4PcaKcz0sId1AuYT22N8GlrxKhOXII8JHxxCKtUvUDnTHhea8fabnZpK5rkCeM7s62Bn6ZhB7pp4pYIsM9It24aa+Rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932592; c=relaxed/simple;
	bh=4Euc2CMnctDapCdPMHYZOgRdPCcqUQ94iWFsu7+cNrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuL1A+3Z4TOGpQn/XJBze8pZEQRvwqPbWaHS1AtemoP1+BQOeszZz7GgHzrUhqq+yBxPd+GJOu1PlHaF0fo1kTW9TPkj4KxOJeOLwb6f3Wdkn68Wqk9C4Mv2ga3BJqgSOpitkppPVl4GMnp+JS7lL2jqZTBz3SecibVAxuZ2zYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fUFgJrTO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so1414367a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716932589; x=1717537389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghaFBcZ2YNH3u+EoV6MQ3l9SwN9z5dJUxFXXhJnhIsc=;
        b=fUFgJrTOfTPlsS7BbVRIUbVISRZ8SNaJa5aSEBGgJESt4h4rlPZgUQCuTXhU4WW+Kg
         /vomPwrMzWOTUaxF/LvRKRWQHQd5ylFtyfA4xxGdhuJpUiA4tk56+yVCs+HQ3WVodfh0
         bup3C5YBMRsRbfhHgpDHQGX+GJLdeNtjfFQQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716932589; x=1717537389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghaFBcZ2YNH3u+EoV6MQ3l9SwN9z5dJUxFXXhJnhIsc=;
        b=d5bN7LzLAoAP+XePX+tyapZZpwjJVLqnIA5k4krRjYe0torBiVs4xtKLdkAMqoyAdQ
         NuQHAQGsvmp9aedYTd4ycduRpdKiUFSpvVx+niEZH2d5qoQ3bfURnFKwgdXocrN5FGAd
         ++Qy97zTd14To2QdRTETz/JMaLVXsY1guNpLGDDBi5xFblyxswbps72vufyYi9SJYrq0
         2PLnTQFcBBc7SYzS3P8oBxtiH5GtD/K5tv7ek+j80mIVrya2ylVqjzSjaANuhgZlgdnS
         2xPLXsnbphjLoAZxgtNjjUNZRP13mD7lMUDzj/XGW30L8I7jlw3/Sgtv0gqgfdTYbM+S
         /V8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsDG418N1XJ9GNP+83zSED5shTg3omVOFXv5ZtvXtIlYapvflvnsUFcjYrt8ocVc59LzSfR3UHc3XV+/cJKvzaLQLvj4VLPEgYSNtl
X-Gm-Message-State: AOJu0YxomflW9NzmLwmu2MsZHnnXS1MdprjY+Ng6MF+Rx1FUDRZs6sYM
	CM9L3/mWPSgUdC4kkwsLxAFXdqFtxGvQmDzyYiZqc+BkhzePfqpMkrn3ohuFomDLbSJa8KMV0NW
	+JFb1Mg==
X-Google-Smtp-Source: AGHT+IG2dUXXplljMCMUYrKhAZfntEaZvoRcsYSMNK1kkvCOUBq+E0zbJNrbXZhKLHPxzo9sAyu61Q==
X-Received: by 2002:a17:906:f592:b0:a62:ddc2:8493 with SMTP id a640c23a62f3a-a62ddc28a25mr1097144266b.20.1716932588808;
        Tue, 28 May 2024 14:43:08 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817b0asm654046266b.3.2024.05.28.14.43.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:43:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5d67064885so204439466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:43:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkMolm7foHxt7ZPvKOza/xVZpC7XA8QvGNZ9Kny1rWrlTEPVZ2vcE3Y0GVnLnI0jjo1RZ3/iKcmcRcJhV7jcGC0WwXuynFeZyP5lsM
X-Received: by 2002:a17:907:7ea1:b0:a62:fcf7:8927 with SMTP id
 a640c23a62f3a-a62fcf78a7cmr906858766b.56.1716932588191; Tue, 28 May 2024
 14:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
 <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
 <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
 <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
 <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
 <CAP-5=fUwcgsB-AruAmGhw6WVNViMaiJ_iHWuZ8=ksrN7Y3V9QQ@mail.gmail.com>
 <CAHk-=wgtb7y-bEh7tPDvDWru7ZKQ8-KMjZ53Tsk37zsPPdwXbA@mail.gmail.com> <CAP-5=fUQLxt1X6QASNf0Bop+vjam28HsD9ua9ODEd2xnAst5Wg@mail.gmail.com>
In-Reply-To: <CAP-5=fUQLxt1X6QASNf0Bop+vjam28HsD9ua9ODEd2xnAst5Wg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 14:42:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_-MyVH0CJv16PqGkuzYMTRAT=a95HFEnzk4=WnpwM-w@mail.gmail.com>
Message-ID: <CAHk-=wg_-MyVH0CJv16PqGkuzYMTRAT=a95HFEnzk4=WnpwM-w@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 14:37, Ian Rogers <irogers@google.com> wrote:
>
> I think stability in the context of this problem is an abstract term
> especially given the low amount of ARM support for PMUs.

Just stop arguing.

The 'cycles' thing is documented. It's CP:U cycles. This is just a *fact*.

I have now blocked you. You will get no more replies from me, because
it's not worth my time.

I simply have better things to do that deal with people who cannot
accept documented and existing behavior, and spend days arguing that
their broken fix was a "fix".

Just go play in any of the other open source projects that (sadly)
don't have regression rules.

               Linus

