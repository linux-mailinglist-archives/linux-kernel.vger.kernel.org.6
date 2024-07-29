Return-Path: <linux-kernel+bounces-266325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E1393FE29
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72ADDB22E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6FE187337;
	Mon, 29 Jul 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRUeDcLR"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A315F319
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280728; cv=none; b=pAoZ1KOm1f64zDRVhk8v2gqBKOnUVqVS8O587nINIMyF6azBo2nmbRlrymJXwX/c08u6GidNfDRS18ZMtg6ZtwvmaTGT9EpxPFdz/20xkbhsmNKxtlXFRgLj3E19v67fqdLKKyW0yR9bazhM/oaKNJiPaOllHe60/gpiNe9LNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280728; c=relaxed/simple;
	bh=Ik8LN/99yvtz1AhNlUHcDqdWXMAbsA47mSR4vSlSuiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM7lYx1Wez/2rCrIy3hNUpQqVstpHkQV17diNsgHWADLciEBQ0QwHUMUM6fZPBb2btbld+fKtSu5z1mVrCmL1W/2kJSriMUYc1EBjLaTH9O7QZ0X66fbIm6y04tx7aJQjyqPsxCSVaNeRhCnu2jIbNd6WL0got7w/7WATyETZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRUeDcLR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe76fa0b8so68221cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722280726; x=1722885526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik8LN/99yvtz1AhNlUHcDqdWXMAbsA47mSR4vSlSuiw=;
        b=fRUeDcLRXHvuBF+uDVta4zM8eEsSEFlN31TAMXn0U6z3TukW9h5ZhQ97iz60JPcNLc
         IEhbV/6SEz1Fv77JiFUXEEPhqSOBWMSTK5gJIIEADxSa4vk87LiD2CWwUCRS2g5YtafV
         +nT5XPNBi6t7YL8ys2py6aL3LztoEfZMkiumaWTbLUlyjqcmKDUc3U540ni3xmS/UNRT
         ECmpjueunfF+NmUredDVnx77+TUQBcJY6aPHe7KoAOyRrpCQC7kND/4JzdXklzeaTtJy
         4XOgvL3odfm1b/DWhjVa4eRWbWi5FuwH2eW0tNYY9D3lUMv9vJIaRyU/iic9AoaKsLDI
         vyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722280726; x=1722885526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik8LN/99yvtz1AhNlUHcDqdWXMAbsA47mSR4vSlSuiw=;
        b=IdaSOlPTSVCvMCQyEqleQVnluKkBnW3np6t7r9seCDRgGJW1Z8w/KREM5QgjuCizt8
         3FURgWF4cR9YWUwkNk9BGmyy01hq6A58WDCRs1+c/QW8ioD4HWMru17kM4g+QoBeDSd0
         8szgAKJ2HqL5qgQ4W+gTkL5FNG+yTXJb+PLsdPi+Y1JgjMMG823ze6M/mSuIt4ptH8By
         bG6ah5wGxpEBpjDGoNHqsrVJohAA9xqFhyCoyMNhvXYjR6ysO5VeJ5JHQjHxwEEojPLT
         vMft5SSrXP2IGVDUdhBuKVBHao08vFOB4C2ZNw8V+urr3QKa4vIDJrsbXf+BKGdVqF3j
         O4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU5bof7luIrRWRJis2hzigS/0twQLP2bvBlmuU6Xk2aAaiP1YQp4GoN9rbKujDYzAhyy4mjCseYVMVoJ8awFRTalQrdGzxCSs/zuRBM
X-Gm-Message-State: AOJu0Yy+aBwV8tiJ5WezKSKBMJiaCLWnhxyEp2HaW19kI7hechb1CIca
	9n7+hu8U3YiQ/0I6TMNPLUvEmIRLQNMIDqK6vXxUEgQ6c3rLK/yNKBaQD0CP0Bzm5PiE9EO2ow/
	B52UHw1aVRqC5k9h4KJQBjADTZnuwqNHCLBfH5j7o9dZ9Xihh4m5j
X-Google-Smtp-Source: AGHT+IEcBazdiRrv8i8kLmhIG3D0dTm9OOIYhyEXUC0hGTlSBxhx8ppT8HrmovTQ5uc5vkkAGW/ZxlkflVCULH9288s=
X-Received: by 2002:a05:622a:44e:b0:447:dbac:facd with SMTP id
 d75a77b69052e-450329ac71fmr1233981cf.24.1722280726157; Mon, 29 Jul 2024
 12:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-2-irogers@google.com> <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
 <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020> <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
 <CAP-5=fV5Qdu5iH_DKeAXQfEmQN9SmxCViSgbOCvAmN529WoeOw@mail.gmail.com>
 <ZmphzTKiDDYkPPP+@xsang-OptiPlex-9020> <CAP-5=fUUnnL18x_mdQdaCePOSbk5VWP3jfAS44n7qahD7pja5Q@mail.gmail.com>
 <ZpXdUiNhFbqJvkZK@xsang-OptiPlex-9020>
In-Reply-To: <ZpXdUiNhFbqJvkZK@xsang-OptiPlex-9020>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 12:18:34 -0700
Message-ID: <CAP-5=fWS6F09aNgz9FVRrAK5ZRvSJ=8o4UAkTfsHdZVaoMi_-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:39=E2=80=AFPM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Ian,
>
> thanks a lot for detail analysis! we will check further.

Hi Oliver,

I'd like to see these patches land, is there any follow up? I think
the build breakage was patches applied incorrectly so I don't think
there is any reason not to take the series.

Thanks,
Ian

