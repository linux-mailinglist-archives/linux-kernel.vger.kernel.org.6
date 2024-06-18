Return-Path: <linux-kernel+bounces-219784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CA90D7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F73B1C2242B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582E4596F;
	Tue, 18 Jun 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7eoAXRa"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839D4C98
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725653; cv=none; b=C2iNA9aS0Wt51CYH6enJM/iVYpPhyBDjkfW5C9mTZfLGZU7zKTo8lbEzXZfzZok3zrkCcTxS2+xRxNw3Jv8+s8XEMN81M42N0X2DNXVE1hq1j5N4XXLu/sbVx2rQrTncO7qJ9nmLSSkrF4+eNTpnJLsWCznIczY5V8jPKXWin/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725653; c=relaxed/simple;
	bh=XCRMCtMXHLNjJphVTMnh6comGtEq0JkrfmVck3CYyJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU/EhchXemJ915iyP91/HtMd4eIjh491YG9IO5/FXGhYxp6drlQXAGpY5bhsqVnnH35ae/iKxoDsshcW9LREMXA2aFoyLLk38DCgD96mfUBUFu5onM2w3UJSaAivDNdCEsnBwrhDBGaUcjsLDaE3NDYbkMwd01+SVFsgyO7JNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7eoAXRa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so13750a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718725649; x=1719330449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIYSvCXFkVXQmYm1PIRRFm8B3H0HwGnr9/yZnHJpI1w=;
        b=f7eoAXRaj2mweg4xFgMg9IQ8gDIsaADlAFbyVrWtQhglzYr5GUkpB+L+Jn0zeAjLlo
         Hc2ZeQixyBBDTSr6z/zqpgnZ5XgCCR5ihY1TQg1do05kXPlDisn8zMtxvVDRVphleSG8
         bxdyqYenFCeryCL1C45fnHJg4Y0qQFusLE19b1J3engFCsI3SEpe17KXaZhopgK3O7Um
         xzYfBANnLoRbJgC65YFjVTQmqlIP8tCQg4HdesoVBH7Ch8cu502joVeNnhJGl+/HL/Hs
         EaxT98RVMrMSQqZTaGit1e8xUXKBErEhtyVzXAG75w97aO2+5ztfgrddYcN+Nw6Nfl6a
         zqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725649; x=1719330449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIYSvCXFkVXQmYm1PIRRFm8B3H0HwGnr9/yZnHJpI1w=;
        b=Gix4WDiDMOVnA6Ps9AMrQRD1JMZhvQleTGzWrNpPE1BqjMjcTrkcusSU7ahdo9SgGD
         ydZvdR1fyKO6T0w6A2TChZtk8GiVDyG8vgIB6StYpmQJK9E6apFbKTK/k5XeGO6GHiaN
         G0Q3RJKq3k8HCrRK3PF0MN8ctyar4TxjvnyVP4foWyxQpM7TWhxfMGhGk58siFN+qp32
         Gp/6o9icuI2pHCajzh0Jb4okBfKBURrITreqZ/f+aDemIvTi0KKkXsu9/L9PJFz+jg7U
         n2Hvg+3Tj/D0cL7ZRaGHPlZe6HKqWOXA/ri32ypPFFH8XqbxbFTSLMErP+tLRro/LEcK
         C8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgGn5luYYmr2pb+yrwN8QTLZKIZqnYgSoLkcVZtVDTEpjLKODLVDNd72hGlE5FEOOTFEgzd42Aza/J99UjZzwL9rXF3LmwoZxmXQ1U
X-Gm-Message-State: AOJu0YwZLEieyUL1vt/GCtuhqS8DQlbvc0Q5hIzRMrj6tOvbCaIJ4c8X
	5icNB1ixYHdGt+0aachHmAosOEYZYCBChClvk5Ij0dHb2AyKb+HQtne8ibJZjjLFSn2WRe4r6U+
	xmLSYL86tCfLwkQFN4Vb/bEfWed8AaChD4ndg
X-Google-Smtp-Source: AGHT+IGfuDoMA+ic7c2YA4o3KutLmUvASmQxBSlR3RtUYS4iqh4ijSRMHAtX1YilNE8UVVSIEYNMLL2QquCsQRyU8I0=
X-Received: by 2002:a05:6402:5247:b0:57c:b80b:b2f4 with SMTP id
 4fb4d7f45d1cf-57cf91338c0mr252013a12.6.1718725648780; Tue, 18 Jun 2024
 08:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604150136.493962-1-robdclark@gmail.com> <6f97a4b4-cdbe-466c-80d4-adc8da305f75@arm.com>
 <CAF6AEGv+Ge2SD4=j1QhXfG+KkOzvFM+LieCqKuM20YL8gp5PRQ@mail.gmail.com>
 <80fc63e5-0e79-47b3-91ae-90d7c7bc3f66@arm.com> <CAF6AEGuDq=YcyKuTfr1xZtff+VGyeeVWe40E4KEy--umwepcEQ@mail.gmail.com>
In-Reply-To: <CAF6AEGuDq=YcyKuTfr1xZtff+VGyeeVWe40E4KEy--umwepcEQ@mail.gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 18 Jun 2024 21:17:16 +0530
Message-ID: <CAN6iL-QqZXsFDB=3yCfqQeF0H5QaS_Trm62FxvDF-+qPoQ-VNA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Pretty-print context fault related regs
To: Rob Clark <robdclark@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:28=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Mon, Jun 17, 2024 at 10:33=E2=80=AFAM Robin Murphy <robin.murphy@arm.c=
om> wrote:
> >
> > On 2024-06-17 5:18 pm, Rob Clark wrote:
> > > On Mon, Jun 17, 2024 at 6:07=E2=80=AFAM Robin Murphy <robin.murphy@ar=
m.com> wrote:
> > >>
> > >> On 04/06/2024 4:01 pm, Rob Clark wrote:
> > >>> From: Rob Clark <robdclark@chromium.org>
> > >>>
> > >>> Parse out the bitfields for easier-to-read fault messages.
> > >>>
> > >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > >>> ---
> > >>> Stephen was wanting easier to read fault messages.. so I typed this=
 up.
> > >>>
> > >>> Resend with the new iommu list address
> > >>>
> > >>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 53 +++++++++++++++++++++=
++++--
> > >>>    drivers/iommu/arm/arm-smmu/arm-smmu.h |  5 +++
> > >>>    2 files changed, 54 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/=
arm/arm-smmu/arm-smmu.c
> > >>> index c572d877b0e1..06712d73519c 100644
> > >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >>> @@ -411,6 +411,8 @@ static irqreturn_t arm_smmu_context_fault(int i=
rq, void *dev)
> > >>>        unsigned long iova;
> > >>>        struct arm_smmu_domain *smmu_domain =3D dev;
> > >>>        struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > >>> +     static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > >>> +                                   DEFAULT_RATELIMIT_BURST);
> > >>>        int idx =3D smmu_domain->cfg.cbndx;
> > >>>        int ret;
> > >>>
> > >>> @@ -425,10 +427,53 @@ static irqreturn_t arm_smmu_context_fault(int=
 irq, void *dev)
> > >>>        ret =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
> > >>>                fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IO=
MMU_FAULT_READ);
> > >>>
> > >>> -     if (ret =3D=3D -ENOSYS)
> > >>> -             dev_err_ratelimited(smmu->dev,
> > >>> -             "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx,=
 fsynr=3D0x%x, cbfrsynra=3D0x%x, cb=3D%d\n",
> > >>> -                         fsr, iova, fsynr, cbfrsynra, idx);
> > >>> +     if (ret =3D=3D -ENOSYS && __ratelimit(&rs)) {
> > >>> +             static const struct {
> > >>> +                     u32 mask; const char *name;
> > >>> +             } fsr_bits[] =3D {
> > >>> +                     { ARM_SMMU_FSR_MULTI,  "MULTI" },
> > >>> +                     { ARM_SMMU_FSR_SS,     "SS"    },
> > >>> +                     { ARM_SMMU_FSR_UUT,    "UUT"   },
> > >>> +                     { ARM_SMMU_FSR_ASF,    "ASF"   },
> > >>> +                     { ARM_SMMU_FSR_TLBLKF, "TLBLKF" },
> > >>> +                     { ARM_SMMU_FSR_TLBMCF, "TLBMCF" },
> > >>> +                     { ARM_SMMU_FSR_EF,     "EF"     },
> > >>> +                     { ARM_SMMU_FSR_PF,     "PF"     },
> > >>> +                     { ARM_SMMU_FSR_AFF,    "AFF"    },
> > >>> +                     { ARM_SMMU_FSR_TF,     "TF"     },
> > >>> +             }, fsynr0_bits[] =3D {
> > >>> +                     { ARM_SMMU_FSYNR0_WNR,    "WNR"    },
> > >>> +                     { ARM_SMMU_FSYNR0_PNU,    "PNU"    },
> > >>> +                     { ARM_SMMU_FSYNR0_IND,    "IND"    },
> > >>> +                     { ARM_SMMU_FSYNR0_NSATTR, "NSATTR" },
> > >>> +                     { ARM_SMMU_FSYNR0_PTWF,   "PTWF"   },
> > >>> +                     { ARM_SMMU_FSYNR0_AFR,    "AFR"    },
> > >>> +             };
> > >>> +
> > >>> +             pr_err("%s %s: Unhandled context fault: fsr=3D0x%x ("=
,
> > >>> +                    dev_driver_string(smmu->dev), dev_name(smmu->d=
ev), fsr);
> > >>> +
> > >>> +             for (int i =3D 0, n =3D 0; i < ARRAY_SIZE(fsr_bits); =
i++) {
> > >>> +                     if (fsr & fsr_bits[i].mask) {
> > >>> +                             pr_cont("%s%s", (n > 0) ? "|" : "", f=
sr_bits[i].name);
> > >>
> > >> Given that SMMU faults have a high likelihood of correlating with ot=
her
> > >> errors, e.g. the initiating device also reporting that it got an abo=
rt
> > >> back, this much pr_cont is a recipe for an unreadable mess. Furtherm=
ore,
> > >> just imagine how "helpful" this would be when faults in two contexts=
 are
> > >> reported by two different CPUs at the same time ;)
> > >
> > > It looks like arm_smmu_context_fault() is only used with non-threaded
> > > irq's.  And this fallback is only used if driver doesn't register it'=
s
> > > own fault handler.  So I don't think this will be a problem.
> >
> > You don't think two different IRQs can fire on two different CPUs at th=
e
> > same time (or close to)? It's already bad enough when multiple CPUs
> > panic and one has to pick apart line-by-line interleaving of the
> > registers/stacktraces - imagine how much more utterly unusable that
> > would be with bits of different dumps randomly pr_cont'ed together onto
> > the same line(s)...
>
> _different_ irq's, yes
>
> Anyways, the reason for pr_cont() was that there wasn't another
> reasonable way to decide where separator chars were needed with a
> single pr_err().  I could instead construct a string on stack and
> print that in a single call, but pr_cont() seemed like the more
> reasonable alternative.
>
> BR,
> -R

The string approach sounds good to me, if possible, let's break this
out into a helper function, something like `arm_smmu_log_ctx_fault`
and put it under a module parameter, I guess? Not sure if this
requires a new Kconfig option, would like Robin's opinion on this.

Thanks,
Pranjal

>
> > Even when unrelated stuff gets interleaved because other CPUs just
> > happen to be calling printk() at the same time for unrelated reasons
> > it's still annoying, and pr_cont makes a bigger mess than not.
> > >> I'd prefer to retain the original message as-is, so there is at leas=
t
> > >> still an unambiguous "atomic" view of a fault's entire state, then
> > >> follow it with a decode more in the style of arm64's ESR logging. TB=
H I
> > >> also wouldn't disapprove of hiding the additional decode behind a
> > >> command-line/runtime parameter, since a fault storm can cripple a sy=
stem
> > >> enough as it is, without making the interrupt handler spend even lon=
ger
> > >> printing to a potentially slow console.
> > >
> > > It _is_ ratelimited.  But we could perhaps use a higher loglevel (pr_=
debug?)
> >
> > Yeah, I'd have no complaint with pr_debug/dev_dbg either, if that suits
> > your use case. True that the ratelimit may typically mitigate the
> > overall impact, but still in the worst case with a sufficiently slow
> > console and/or a sufficiently large amount to print per __ratelimit()
> > call, it can end up being slow enough to stay below the threshold. Don'=
t
> > ask me how I know that :)
> >
> > Thanks,
> > Robin.

