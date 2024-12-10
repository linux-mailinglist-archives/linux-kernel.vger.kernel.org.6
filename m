Return-Path: <linux-kernel+bounces-438631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529429EA3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2721282D94
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C76111A8;
	Tue, 10 Dec 2024 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itClVhmQ"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C87380
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791480; cv=none; b=EQSNd2xs1Sfvuwm9p4Kd5FEcOPsFcfygGhS8ASf8lV+yuLdVO+yFeapYbVmE37J/XWdGFT0nmItHBzp1sdFifPMxX0YS3tlwQDSkeQbZ6X2hBNP0DMaKTajEyPf259tgjnntZNhtLb7qq1Bp3dY3MG1gDxnAzqoTxZEpaPotJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791480; c=relaxed/simple;
	bh=jfoCP+lKA7/nH2cjRMScVyFc3X8ctsjwy6ijJAI3MyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sTRpapXs+wr4m5KgAOCyH+hufbjtWWscxcgqeQaRtrq5PK6OocKmZ7OB1zpuQmGL1uHPE/ebRDe7SLPAXUe300Qqxce7pWPwKLGys3fS9pz/PNjxLHCv3uZ1aMfklXDOPwqa1m/WmRhWPNpAE1Gp1LzFPOBuslQELSXnX6C9qeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itClVhmQ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so17405ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733791478; x=1734396278; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfoCP+lKA7/nH2cjRMScVyFc3X8ctsjwy6ijJAI3MyI=;
        b=itClVhmQ+PEvFDMQHp+EhfZVd0oet6D8A7YhOqlgGtlKE5wxCZ1ZlOme1Cy/r5xqRp
         ATPcA4jxhuqROJcBeFIWcx6RvbS++nigv1tA4wv7PosPNF9Fnq3OacOO4jBcKT2N3tSz
         aSuXv+1+V9/sHrjjtSmPe4M2f7aPfhQNzkooj7qH/SPrePqAKbe0rGKwDQlDC2iAYKE6
         Q1iy3MVXfZL2y/ZRFszPS+gycscHZKL9FaKVhw+2dV/388FgVi7XDSP8xebLGsb0nnUu
         +DkJWVL6G2rpQofXgeVvCkfsF2WPRdbktw7+eicglHOQ05UijPfVq3OlcLc44xhjGFvr
         XqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733791478; x=1734396278;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfoCP+lKA7/nH2cjRMScVyFc3X8ctsjwy6ijJAI3MyI=;
        b=fxyqZu7Hyl2rmQhuRD+B+ZJB/p7UFXT+VNT8D6UXR29yBYQRD20crROp9Bd5/FAE2e
         1Yns/k3A0jzkBTThBV8tMfCFLwe8b0VaGIxFcK1wNMfUahAMFgQAPQQbsAxhmasUuANB
         zDX8mvMAs02znaTCkDWTSJ0WWWhflkpwCngoxqZQhcuxd6d6k01wjyr3/BdzMjW35nfH
         SqxBIjyV05VccgGunqw1wL13ti190FKcoglhjwAIhmYjIfbrn+EylYxWtdJcztWzQT6Q
         8RRFBr+sX8CPEsIo/92KoSLhBun1ki5eezMhy9oGaKt9dZDBD3nd/hIYzaJEKvl1JE5o
         wbig==
X-Forwarded-Encrypted: i=1; AJvYcCW/JKSLsVk27bb51CgugufILRELHzjWl9YyxQSvpTStB5f7MMbAv3siK6nADezNdkLAsP9pXuxoHoppvhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5RrtI4ENlI6SOZ1IaYtjmkVGilqgBF8BBWAEdtbdcKxO0ftM
	J9MZ1LCjAA5WDLNlkgPuKaM/uHqCRe2zZKZEaxXrkSnB9WeoZxDLLYSQFcfElR8eaxycw8ZVKKF
	ioLp63sbuU0xAgnP6HI4pZRkCiUt2JaK3s3Bc
X-Gm-Gg: ASbGncvc4LJpuQJsmJ/8lyPHwjtVWvy7CzYaNXq28CNn5gThRaFGmuzNdT3dIZYY6GV
	KKPjIJfClcgjB2/9ZsHaX3U02eFICeGKpr8Yd
X-Google-Smtp-Source: AGHT+IE2Xkc1hPXyJknk7xY7BGD8MVbw+vhzTYqxuNI6B/vaoF5FvcQ8x9b0qQSSP2aG/sz4GIL5vyk9tvjr98ciN+I=
X-Received: by 2002:a05:6e02:34a1:b0:3a7:d85a:b1bd with SMTP id
 e9e14a558f8ab-3a9dda2dae3mr1205935ab.4.1733791478503; Mon, 09 Dec 2024
 16:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com>
In-Reply-To: <20241209222800.296000-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 16:44:27 -0800
Message-ID: <CAP-5=fWr9R74-NbKbW96otG6KitQYaQng4D40Bv4z9ov9yvNJA@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] Intel vendor events and TMA 5.01 metrics
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:28=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Update the Intel vendor events to the latest.
> Update the metrics to TMA 5.01.
> Add Arrowlake support.
> Add metrics for LNL and GNR.
> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
>
> The perf json was generated using the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> with the generated json being in:
> https://github.com/intel/perfmon/tree/main/scripts/perf
>
> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
> Weilin Wang <weilin.wang@intel.com> for helping get this patch series
> together.

I should have also said, this series requires:
https://lore.kernel.org/all/20241113165558.628856-1-irogers@google.com/

Thanks,
Ian

