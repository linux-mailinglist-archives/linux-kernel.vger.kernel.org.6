Return-Path: <linux-kernel+bounces-339151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C49A9860CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4C828BC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C81B1D66;
	Wed, 25 Sep 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UG3FBgXS"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA11CF92
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270905; cv=none; b=GhzaGrV7Ven/WftJoCXler3910v26i+avSZ2oBtles8lLOGkq0koVX//ydt9+VpmiXKarjmTooQHC1ktfQH1CVNMCm640CCY3x3A6w+s/vOL2s6UGNurHv1oenU2SMuVgHkVGT/RJO0PcML4JAtE3skFlvlwRaQ1OQXRYogB9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270905; c=relaxed/simple;
	bh=HzuiD2eIhasTgVYZPiaCxg+X3qZWugULlka7ykB37ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyCC66Rn92RxEnyqMATIT1o1LLVyrbxHooFOuDOIgnWluJ00Mcj87NrAimeGTcG4xaVZItPUk/FMJJTfqYehstqZHB6H8lW9Fh2ezknXROa5LByjlkcQWR+zXXT3qApy7l+HBFQ/0CubrBaXSAKCR4nLqbFoBKiNl8nrpO1Clw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UG3FBgXS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so556228a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727270903; x=1727875703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b63aGhYvPyTN8zXlCICgHfx2PCRNJVpBTl5cHACah5k=;
        b=UG3FBgXSQ8iRuY46dbygY8trKQebVEvQ5jFjm+Vrkye4lqkuCyNeXcu4e1LGcB7NLq
         9vllwISNxccRtMHEph+VHimzOOIWQPdfhOSuI1m1ZrXLe4UUfr7kft/hZgEiaOvG192v
         CQejl77NAMrXLIHBu2m5hoGoL12hdOLH9Nf9CWBRT8OqdKwawcTMaKrs4IxrLlQKKhs+
         /4GZhp5yYiAar8chsWn5RB/TQHNpo0QDBBmAR4ig5iJ3/xw2MWHxE5bGs/xhx1FmXjfi
         tI4BWfGgRrR57KEDIn7ZykK2ujm9CrRNwnJmJkd/cdmhePlFmkqW6dM5Q6+nuGznV/DV
         68SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270903; x=1727875703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b63aGhYvPyTN8zXlCICgHfx2PCRNJVpBTl5cHACah5k=;
        b=sM7Nxt99sGTaArpCMSgIcun7V0mqjsNuKe58TDa8E6xVntZV1bKBypgc0Abo8pNhhh
         og7Pt7obaZx3htV05T1Q7txFkJLHuUvYvpbI7LMJaQrZeCBJN9AG88gxaco7bv1bJbY2
         BvRP53DHUNQ2buj2WDvv+BU+HQ3aAZfV/DuOt3dz99X8mGkggSirD1fW3eixRFFRDn9h
         DnIIDUf21bCDYP0SH41hghOcnaBVWn52785Gq7Hqnzura/83w2H2xREI9bnsarRcLu/L
         mSV7xHIAoOsesAmRHOI1uc1O0wWJ5dh8QHZwEv/3hCoe8fwMrM2shNRWlC3AF9Xh2js9
         PSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwYD5JzhQqsVoq10kPRxiIOlK1+gJB4bCS79CkXci4haRwqEOmHn6TwP3lExkvC9fe8QP1LzK+OQEIOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVgkfdVJnNsOyGm8Wswf46yxuRJYudCgFqE4aWFdWCNu4adYJ0
	rBclTuyrSo2u2BOyiP+CSsRFdpKpB9o1sRmVRm/gftvbPaLLTmsTAsuDHBdreHhLTu5Sfxa4SLu
	+Pd9Bd+NXYlJjuXvUJ8cVDOa4oQIOdsn+zzQ9+Q==
X-Google-Smtp-Source: AGHT+IF54z4CaFfG7l+EhZGW3J6xXLaPuuiN6eeBfGiUZQniAdf+eIQs4piHjnMjtJntvp9xKw/R+Y6vSxXdT7b7bYM=
X-Received: by 2002:a17:90b:392:b0:2da:8e1d:4769 with SMTP id
 98e67ed59e1d1-2e06aff5dc2mr2761589a91.38.1727270903132; Wed, 25 Sep 2024
 06:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
 <66583e86-e2a7-4e4f-bd45-40ea2d4a21df@arm.com>
In-Reply-To: <66583e86-e2a7-4e4f-bd45-40ea2d4a21df@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Sep 2024 15:28:12 +0200
Message-ID: <CAKfTPtAooR2Qqko6Cfe=hQiTqJEzHX0j5uydza-SxdGDTsoGYA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, qyousef@layalina.io, hongyan.xia2@arm.com, 
	mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 
	rafael.j.wysocki@intel.com, lukasz.luba@arm.com, vschneid@redhat.com, 
	mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Sept 2024 at 10:26, Pierre Gondois <pierre.gondois@arm.com> wrot=
e:
>
> Hello Vincent,
> I tried this patch on a Pixel 6 (8 CPUs, 4 little, 2 mid, 2 big)
> with patches 1-4/5 using these workloads:
> ---
> A.
> a. 8 tasks at 2%/5%/10% during 1s
> b. 1 task:
>     - sleeping during 0.3s
>     - at 100% during 0.3s
>     - sleeping during 0.3s
>
> b. is used to reach the overutilized state during a limited amount of tim=
e.
> EAS is then operating, then the load balancer does the task placement, th=
en EAS
> is operating again.
>
> B.
> a. 8 tasks at 2%/5%/10% during 1s
> b. 1 task:
>     - at 100% during 1s
>
> ---
> I'm seeing the energy consumption increase in some cases. This seems to b=
e
> due to feec() migrating tasks more often than what the load balancer does
> for this workload. This leads to utilization 'spikes' and then frequency
> 'spikes', increasing the overall energy consumption.
> This is not entirely related to this patch though,, as the task placement=
 seems
> correct. I.e. feec() effectively does an optimal placement given the EM a=
nd
> task utilization. The task placement is just a bit less stable than with
> the load balancer.

Would patch 5 help to keep things better placed ? in particular if
task b is misplaced at some point because of load balance ?

I agree that load balance might still contribute to migrate task in a
not energy efficient way

>
> ---
> Regarding hackbench, I've reproduced the test you've run on the same Pixe=
l6.
> I have CONFIG_SCHED_CLUSTER enabled, which allows having a sched domain f=
or
> each little/mid/big CPUs (without the config, these group would no exist)=
.

Why did you do this ? All cpus are expected to be in same sched domain
as they share their LLC

>
> I see an important regression in the result.
> I replaced the condition to run feec() through select_task_rq_fair() by:
>    if (get_rd_overloaded(cpu_rq(cpu)->rd) =3D=3D 0)) {

overloaded is enable when more than 1 task runs on a cpu whatever the
utilization

>      new_cpu =3D find_energy_efficient_cpu(p, prev_cpu);
>      ...
>    }
> and obtained better results.
>
> Indeed, for such intensive workload:
> - EAS would not have any energy benefit, so better prioritize performance
>    (as Christian mentioned)
> - EAS would not be able to find a fitting CPU, so running feec() should b=
e
>    avoided
> - as you mention in the commit message, shuffling tasks when one CPU beco=
mes
>    momentarily overutilized is inefficient energy-wise (even though I don=
't have
>    the numbers, it should make sense).
> So detecting when the system is overloaded should be a better compromise =
I
> assume. The condition in sched_balance_find_src_group() to let the load b=
alancer
> operate might also need to be updated.
>
> Note:
> - base: with patches 1-4/5
> - _ou: run feec() when not overutilized
> - _ol: run feec() when not overloaded
> - mean: hackbench execution time in s.
> - delta: negative is better. Value is in percentage.

Could you share your command line ? As explained in the cover letter I
have seen some perf regressions but not in the range that you have
below

What is your base ? tip/sched/core ?

> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
> =E2=94=82 id  =E2=94=86 mean_base =E2=94=86 std_base =E2=94=86 mean_ou =
=E2=94=86 std_ou   =E2=94=86 mean_ol =E2=94=86 std_ol   =E2=94=86 delta_ou =
=E2=94=86 delta_ol =E2=94=82
> =E2=95=9E=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=A1
> =E2=94=82 1   =E2=94=86 1.9786    =E2=94=86 0.04719  =E2=94=86 3.0856  =
=E2=94=86 0.122209 =E2=94=86 2.1734  =E2=94=86 0.045203 =E2=94=86 55.95    =
=E2=94=86 9.85     =E2=94=82
> =E2=94=82 2   =E2=94=86 1.8991    =E2=94=86 0.019768 =E2=94=86 2.6672  =
=E2=94=86 0.135266 =E2=94=86 1.98875 =E2=94=86 0.055132 =E2=94=86 40.45    =
=E2=94=86 4.72     =E2=94=82
> =E2=94=82 3   =E2=94=86 1.9053    =E2=94=86 0.014795 =E2=94=86 2.5761  =
=E2=94=86 0.141693 =E2=94=86 2.06425 =E2=94=86 0.045901 =E2=94=86 35.21    =
=E2=94=86 8.34     =E2=94=82
> =E2=94=82 4   =E2=94=86 1.9586    =E2=94=86 0.023439 =E2=94=86 2.5823  =
=E2=94=86 0.110399 =E2=94=86 2.0955  =E2=94=86 0.053818 =E2=94=86 31.84    =
=E2=94=86 6.99     =E2=94=82
> =E2=94=82 5   =E2=94=86 1.746     =E2=94=86 0.055676 =E2=94=86 3.3437  =
=E2=94=86 0.279107 =E2=94=86 1.88    =E2=94=86 0.038184 =E2=94=86 91.51    =
=E2=94=86 7.67     =E2=94=82
> =E2=94=82 6   =E2=94=86 1.5476    =E2=94=86 0.050131 =E2=94=86 2.6835  =
=E2=94=86 0.140497 =E2=94=86 1.5645  =E2=94=86 0.081644 =E2=94=86 73.4     =
=E2=94=86 1.09     =E2=94=82
> =E2=94=82 7   =E2=94=86 1.4562    =E2=94=86 0.062457 =E2=94=86 2.3568  =
=E2=94=86 0.119213 =E2=94=86 1.48425 =E2=94=86 0.06212  =E2=94=86 61.85    =
=E2=94=86 1.93     =E2=94=82
> =E2=94=82 8   =E2=94=86 1.3554    =E2=94=86 0.031757 =E2=94=86 2.0609  =
=E2=94=86 0.112869 =E2=94=86 1.4085  =E2=94=86 0.036601 =E2=94=86 52.05    =
=E2=94=86 3.92     =E2=94=82
> =E2=94=82 9   =E2=94=86 2.0391    =E2=94=86 0.035732 =E2=94=86 3.4045  =
=E2=94=86 0.277307 =E2=94=86 2.2155  =E2=94=86 0.019053 =E2=94=86 66.96    =
=E2=94=86 8.65     =E2=94=82
> =E2=94=82 10  =E2=94=86 1.9247    =E2=94=86 0.056472 =E2=94=86 2.6605  =
=E2=94=86 0.119417 =E2=94=86 2.02775 =E2=94=86 0.05795  =E2=94=86 38.23    =
=E2=94=86 5.35     =E2=94=82
> =E2=94=82 11  =E2=94=86 1.8923    =E2=94=86 0.038222 =E2=94=86 2.8113  =
=E2=94=86 0.120623 =E2=94=86 2.089   =E2=94=86 0.025259 =E2=94=86 48.57    =
=E2=94=86 10.39    =E2=94=82
> =E2=94=82 12  =E2=94=86 1.9444    =E2=94=86 0.034856 =E2=94=86 2.6675  =
=E2=94=86 0.219585 =E2=94=86 2.1035  =E2=94=86 0.076514 =E2=94=86 37.19    =
=E2=94=86 8.18     =E2=94=82
> =E2=94=82 13  =E2=94=86 1.7107    =E2=94=86 0.04874  =E2=94=86 3.4443  =
=E2=94=86 0.154481 =E2=94=86 1.8275  =E2=94=86 0.036665 =E2=94=86 101.34   =
=E2=94=86 6.83     =E2=94=82
> =E2=94=82 14  =E2=94=86 1.5565    =E2=94=86 0.056595 =E2=94=86 2.8241  =
=E2=94=86 0.158643 =E2=94=86 1.5515  =E2=94=86 0.040813 =E2=94=86 81.44    =
=E2=94=86 -0.32    =E2=94=82
> =E2=94=82 15  =E2=94=86 1.4932    =E2=94=86 0.085256 =E2=94=86 2.6841  =
=E2=94=86 0.135623 =E2=94=86 1.50475 =E2=94=86 0.028336 =E2=94=86 79.75    =
=E2=94=86 0.77     =E2=94=82
> =E2=94=82 16  =E2=94=86 1.4263    =E2=94=86 0.067666 =E2=94=86 2.3971  =
=E2=94=86 0.145928 =E2=94=86 1.414   =E2=94=86 0.061422 =E2=94=86 68.06    =
=E2=94=86 -0.86    =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98
>
> On 9/17/24 22:24, Christian Loehle wrote:
> > On 8/30/24 14:03, Vincent Guittot wrote:
> >> Keep looking for an energy efficient CPU even when the system is
> >> overutilized and use the CPU returned by feec() if it has been able to=
 find
> >> one. Otherwise fallback to the default performance and spread mode of =
the
> >> scheduler.
> >> A system can become overutilized for a short time when workers of a
> >> workqueue wake up for a short background work like vmstat update.
> >> Continuing to look for a energy efficient CPU will prevent to break th=
e
> >> power packing of tasks.
> >>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> ---
> >>   kernel/sched/fair.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 2273eecf6086..e46af2416159 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int p=
rev_cpu, int wake_flags)
> >>                  cpumask_test_cpu(cpu, p->cpus_ptr))
> >>                      return cpu;
> >>
> >> -            if (!is_rd_overutilized(this_rq()->rd)) {
> >> +            if (sched_energy_enabled()) {
> >>                      new_cpu =3D find_energy_efficient_cpu(p, prev_cpu=
);
> >>                      if (new_cpu >=3D 0)
> >>                              return new_cpu;
> >
> > Super quick testing on pixel6:
> > for i in $(seq 0 6); do /data/local/tmp/hackbench -l 500 -g 100 | grep =
Time; sleep 60; done
> > with patch 5/5 only:
> > Time: 19.433
> > Time: 19.657
> > Time: 19.851
> > Time: 19.789
> > Time: 19.857
> > Time: 20.092
> > Time: 19.973
> >
> > mainline:
> > Time: 18.836
> > Time: 18.718
> > Time: 18.781
> > Time: 19.015
> > Time: 19.061
> > Time: 18.950
> > Time: 19.166
> >
> >
> > The reason we didn't always have this enabled is the belief that
> > this costs us too much performance in scenarios we most need it
> > while at best making subpar EAS decisions anyway (in an
> > overutilized state).
> > I'd be open for questioning that, but why the change of mind?
> > And why is this necessary in your series if the EAS selection
> > isn't 'final' (until the next sleep) anymore (Patch 5/5)?
> >

