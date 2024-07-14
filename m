Return-Path: <linux-kernel+bounces-251860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E47930AC2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC706281205
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D013B58A;
	Sun, 14 Jul 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZtjnDX1W"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2313A3F0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974209; cv=none; b=VeaeHQhk97bBaCuouauZbILl0Law4skZeVivR8xc1PpNS32X6x5hG0lNf5njJ4SWG7FqhitQXetpAtvJ8+kNkfpKCrWpQBwR7Mc2BK+bfO3Wfc+dSRjhr0+cRH6UPvrXOK4nkVG6qONLCJwNcA/iKA2E2kdSb902JIDTiZSorF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974209; c=relaxed/simple;
	bh=2oc17bxN5yneFOqoMD5SfbFq6+mOSKm3ebyqyV12JkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMohgPB+cHgzJcYxp7DDhT2p5AuaSlS0ATA+1ugouD4x59xtEH3Ox9l28q8810KNyBHX/L2qwUXJfiCy1mvwjyPnOzdsXcE8L5VpNvWVOqkG4Zk1hcOGEKuET2CUAYNVgQvxBXFWjLjKIQj6CXwdkPnoz7FlW2oAmv99A+oucLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZtjnDX1W; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso4811175e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720974206; x=1721579006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFB/7l3RP1NdCHl9DVGleC+3i6+uY6B4g+LS+1Kxs4w=;
        b=ZtjnDX1Wzf3YfmiGS6rzZxu3drWq/f0gWpW3TTu/54v7YoOt+qB7VNjEmfLRFOfT5x
         uCST6VAq5AopL7bsgyNJR9uXr5nQAuA12nMg/WjQgKGY8Yv2ovF7EUZrcsXtIwraIgDa
         o6nuRFUK5q/NjBdnOBlGfA3QqxRXLAX9ewZWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720974206; x=1721579006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFB/7l3RP1NdCHl9DVGleC+3i6+uY6B4g+LS+1Kxs4w=;
        b=HV5/h6uzrKQt+TFwxcFpFj4fE0KIUZo82d1EWUVtZVMGSAs7F4oSk/vk9cfygobznk
         pKM7s6lw9gTIKAHxAn/SJfBSS3SRLoHgdUd+v5p9mpYrItXBmsnHTLqZjVKI/61hEO88
         EdAdFK2xaUivwzu18X/J0yinEcpNl4fM344DScaj+FRpeBuMH1ACmO+D8vYNNZx8SrcE
         CMfoTDkv7MNaFy5utXmfNPLW2gEEpBhlHh8pv1b9SGbqJD31aOCEpP88xwuU8rdQg7pc
         utfTV8QoYDqUKwzvGatxGUF5hIcFXV5U4AKLuEOwU96iEBoiKmFuriXwcS8Ps1B4FqXO
         9w+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMptIMDkrgQ8Gv5F1thrFpPHBBSNYqtGDllbVtmd0YzsVCcI3Qvy2kPQm8UM6Au9IB3KnGNrdWvAjwJRJj2vZFRJBTy0Pw6KKUQ8ES
X-Gm-Message-State: AOJu0YwLN+aeR6Mj6PkNjm25pXJOPFTikH0AiO3135aZ8ug1R9UlAmkH
	Zhd5AmJltoM3US1Y/yukc1Ky8tILfcJEkUVWXCwXtbiXqlwcqi7xsxt9MO2WLOdjhKiYGczcIIZ
	qcEyw6k/Z25eC4cms52iuKyzqqDcb7tzCytNH
X-Google-Smtp-Source: AGHT+IGGDxdQpMZ3cXJMhqls7l9eRHoLz1SqwrfxhfrJi2Y20XlRfUb3+vsWUPNkvnrnaEgNTKFmsTZfQl6EAlnDcLk=
X-Received: by 2002:a05:6512:1110:b0:52c:d2ab:693a with SMTP id
 2adb3069b0e04-52eb99d28c5mr15290317e87.54.1720974206121; Sun, 14 Jul 2024
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
 <1720700179-22839-2-git-send-email-ajay.kaher@broadcom.com> <20240711214936.GH27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240711214936.GH27299@noisy.programming.kicks-ass.net>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Sun, 14 Jul 2024 21:53:10 +0530
Message-ID: <CAD2QZ9YQ6n_6J+bq+wNxS5bGuAOsLkSiicigan84qaD+xrjS3Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] perf/core: add logic to collect off-cpu sample
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, rostedt@goodmis.org, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, yangjihong1@huawei.com, zegao2021@gmail.com, 
	leo.yan@linux.dev, asmadeus@codewreck.org, siyanteng@loongson.cn, 
	sunhaiyong@loongson.cn, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, 
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>, nadav.amit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 3:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jul 11, 2024 at 05:46:17PM +0530, Ajay Kaher wrote:
> > following logics has been added to collect the off-cpu sample:
> >
> > - 'task_pt_regs(current)' has been used to capture registers
> >   status off-cpu sample.
> >
> > - off-cpu time represent the time period for which the target
> >   process not occupying the cpu cycles. And calculate as:
> >
> >   off-cpu time =3D swap-in time - swap-out time
> >
>
> I have absolutely no idea what you're trying to do :/ The above does not
> constitute a comprehensible Changelog.

Sorry Peter, it=E2=80=99s sched-in/out (not swap-in/out).

'Perf record' captures on-cpu samples at frequency which is specified by
the user ( i.e. time period to collect sample is NSEC_PER_SEC / freq).

This patch is to collect the off_cpu sample and time period of off_cpu
sample is calculated based upon the time when target task was sched_out
to sched_in, as:

 off-cpu time period =3D sched_in time - sched-out time

-Ajay

