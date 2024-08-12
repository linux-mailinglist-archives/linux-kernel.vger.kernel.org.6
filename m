Return-Path: <linux-kernel+bounces-283388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC594F1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B07B20CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C2183CD7;
	Mon, 12 Aug 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYk0p+yU"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF2184523
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477101; cv=none; b=A2pmexCmsfKKzRn0MorQqB44945FMZ/L1f8DPVrsfXBjLXckkSu0P9d/WUG3jgLZ2PQIM0Ybf4FzwdNgxTK+Eq5tJKcFaAwHVO2CSfVC/C2mbobEsRxAlli8ogLIZuLjaE4EIa7n659BFjQdEfTJepN/VH+MSBGkqwXcmbPEi/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477101; c=relaxed/simple;
	bh=fovMrnD9gDJAqpq2rBZeirL5Ie5rNowYy/qO5wGZ5wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAGpRngdaYMWqlnHVGX3neFH6uPUrkLbhPxbSl1Xv0DuC/uqY6Y/a+/9QV3rZN1qglt039nVh4s0pTT+yE9O0gGEYSBVxgmvknIis2F3Qc4CfPmxL87WDAF6Lntu2RvYAvrT1QvpA2JcH6y2UMHiTlNWqw1KyY+F9dOGH6hwC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYk0p+yU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd7509397bso328365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723477099; x=1724081899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fovMrnD9gDJAqpq2rBZeirL5Ie5rNowYy/qO5wGZ5wQ=;
        b=TYk0p+yUL35MHa5EJPe+iKRiAsVVVeAIQP5C4YdSXtZwNrHksOaiiwIeLUWjJPrz47
         Zuirtoabb21W1owuBWsPJhrcpt5VfIqK3Smmn6i4knroYoYDOEpj3hteOrxPCABq9tya
         8ZlAh3aYK5Wuh8p5BZP2phsQqVuee+wXSHg0jhvq55lrt82y76dxq0rjZrEU7MyCb9YO
         oPnnZ+zf3kVYqKAnV+wbh1QRTAG9SA3huyUErxKbchTmfjZl/oKGlMSzzhKtDzenYhg4
         57PLxWTi+DaRYd4JhAyE0DDZ6l/vZ4UDjNl8pqvwyDMsGAsqSBjA+u2mQM/mGoxaYVwG
         o7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477099; x=1724081899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fovMrnD9gDJAqpq2rBZeirL5Ie5rNowYy/qO5wGZ5wQ=;
        b=r7Eot88S2KkmNNrXUcw0Hoh/HQFLkAUNb8bCohd2iIQPvvqvN/ochKJ7Kvgp53haZ2
         qe9vNpDVM9MCnkyUojk4hxK27d1iOgBaIexCiJ8CIqHh+FVgNeWCtZMdM1o8UgWCkguL
         pzzgWFM00R8ePK5byeFT45nitBuzW3bAgKrGzcBLa0MBuy3uiy7GTqIrFiH6TOyQeN2K
         3XglhMU+4tckUjqRa1q1jT8cqLM8WilOnJP8vghU+BrXuciQiEqcCNFT2c98KlhDXqyt
         KO3zSuPKEaqiFmm0id5cYWzA9qOJ4WfIpEEauA0Ib4EBgx5CD7lklxB7G/zuYUSDQuhJ
         O91A==
X-Forwarded-Encrypted: i=1; AJvYcCUOGW4JVEwo9TJk4IvkxjCkFrYIn1b5ukRwBvaDWREb7MUM7r1c85Y93acJcFueRLFVHi4LBVxpINPSeN80a02mLW4PkDbJfxVNj2yx
X-Gm-Message-State: AOJu0YwJ8olFvuMxL0/RNOtIGrFvKNpnkhK69ugNpphzCd3iw7F3GItI
	5JMDwdE77UqPwCRUKB94jJwuhd7b7SJpThkWSP3Y8tSzpeWxDh6OsbG+LjN5/U0reUq25HobWwu
	GE+iUhB8wwj+FYw6xKScjvOF/p2ZnG5dn32hN9a6cKkTpuK6BPFqV
X-Google-Smtp-Source: AGHT+IG97BRuEEX7J48w7ngQNipoppQKhKZdtlslt6rnfBm8NKOyyNVNUALmqitFj7qXIxa+CCCelcOZ+lqurZlacT4=
X-Received: by 2002:a17:902:ecc4:b0:1fa:cd15:985e with SMTP id
 d9443c01a7336-200bbb57eb7mr4865115ad.6.1723477098446; Mon, 12 Aug 2024
 08:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
 <CAP-5=fWr2Qna9ikzUCFavo3OTUDSP3ztr=i6E=R962CXCdHckg@mail.gmail.com>
 <ZrEpJxtm5zlp5rbo@x1> <CAP-5=fVTaHdiF8G2Dn=vnguvoapa_+ZKsQ7Wy3z51K9nDZQUtg@mail.gmail.com>
 <ZrIl8NCHkIVHQVt2@x1> <CAP-5=fUVcBw4GBT8tcOWS1MV1C6zbfbovon1pCqk7gmfMN=J_Q@mail.gmail.com>
In-Reply-To: <CAP-5=fUVcBw4GBT8tcOWS1MV1C6zbfbovon1pCqk7gmfMN=J_Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Aug 2024 08:38:06 -0700
Message-ID: <CAP-5=fXtDeddhfB8UQcjSAoWPSMo=ve1Xfr2-2K7L1LsMOQenQ@mail.gmail.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, weilin.wang@intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:35=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
> On Tue, Aug 6, 2024 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
> > For now I'm removing the whole series from perf-tools-next.
>
> Ugh.

Hi, what's the plan here? The topdown (aka TMA) metrics on recent
Intel CPUs (client and server) are dependent on timed PEBS. I think we
should land this series and move forward from there.

Thanks,
Ian

