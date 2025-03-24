Return-Path: <linux-kernel+bounces-573292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04490A6D541
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F122A7A4732
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56604257ADB;
	Mon, 24 Mar 2025 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLKVB7p2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAE257AC7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801977; cv=none; b=Yjobv3caz3C2TPzopZHtJQ2zEJ8zWDhGyg9jdjr5ylQLm0p5YQOhYdcRtLNj65FykfSSRMJUSQognIWMkWTk0mzgcbicd8gJrdXdijiuo0PHpMxN5RcCwNjrVkEOIOOwLwf1flbf45/+NpPJqHZMvsQ8hvxfPKeEkGPLwj+mGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801977; c=relaxed/simple;
	bh=/E1+CdUd622YHSdavtWVNjJeqQ3x0Q9Uv74BQL9+Btc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8wtGGh6bvJmUM3mFToFM2XahJk3e/y5kB9/np4ckEFl77xjCD2xIOSegPOInqW6IHPLwPfKJHsGdqI/lncnNSiSYvK60xVx79tBFkdRFq/+X/K7Zl3pI+8kyEle7tepXOwDjL8XVM/kSBcKwilqSIIcv06rfEGh4tiOqmWzuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLKVB7p2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso58950375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742801975; x=1743406775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SxcFj9fapiNOLa4zKIqkX0qfsgj2Wcwr7I86fBYGV1c=;
        b=FLKVB7p2BAPSLHdcTWEku7Jr8bx28PABFcTQNHgT3LD2H7FnjPSqljbJlAw1wClIrW
         oJxmtGu2UQkD5foeSAHUjvqz60TPkhnf2wx2NYsTz3YmfYRNEKsN/nADD3Ze1Jb1Hmpk
         FGC/vjcseCeuT6fXeD6HrViyOfRqRy8r+sPanCOj5fAIquYygjY+nxZa8LrOUrne+gqJ
         pWP/tG/UNcNG6A29tkYNYfSiWuNI4Y5kym3lQhQsEUWlYeyqk/XZ6RGnbCNHqLW3J3Yx
         LlmTASDqWn2ba/Qu3lDaZqLocCKYfWfurrQ+npDAte7WGc9HpvNFv1IhX98k5tb+DH4p
         QfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742801975; x=1743406775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxcFj9fapiNOLa4zKIqkX0qfsgj2Wcwr7I86fBYGV1c=;
        b=IGU5T86daC9r4kKK5CI39cLayrQRNkEn1vXdIA8x1SSxbgLS4A7Ttxa9l/mlwmxVcp
         eXQXSK6+MxvLdDhICckeSh5TNSRc0ywMvewHwo6hQcQPLfS1Th+H0+EtABDqJJStEeQt
         68eTqZWD61uEjUqRk2j36F4bcPgTycjMHrZWZp+T6SVUNmGjlKL6rgB9lCCmV5mMmLLS
         MdkCv9xNbOwM6MjZsIyKv9PYC8j9KAq3kE9WzXQrfHkPzIA9FPnbD2EiCapb5h5Qbp2E
         3KyIksUgcGSFZ8cJBkr4BpMVh+1wJv5QFtYCUZKPfon1FQr7Ejv8gQwy2ZaZYNcYCAYa
         J3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkzzIuuZOFFVfRW7+4D0GlItbO+sSEm9SiPO1S5XtzSPxLmv3Yk6Z+9ZEK7MP+nvrJiTjSEGslW/VKVK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrtomwc223VnnJi1rqMdZvaUrjUFqiV8CFcwMC7xlYKei3Hry
	ppCafFBodpZ4d8eA+7XUcDg+lmdypjcEQcYZgRhew3J8z5PiwUfu07MEPThB6Q==
X-Gm-Gg: ASbGncsF0lq2NJAa4wHgCMUCR6iS7utqM4S+FFflIuK22ULVX9AqufKaMz3ylwfxjHa
	UvF8AvTQUN6zfRAMClxeHxy12NOjkoLlEPujikYZs7noW3FinOAtLzHL4PsKbXhVGJC5UF/m7oc
	8PHiYxT7EjurNDes2a3CIK2FQW9XD5PDVzGIk4iKPrGsiUL2nog7VrPrcm3VnwnZapCwxvVGAUz
	ltbr17kI/kdX9XothEjCbX+U4frMFKy0ayDWfMbNpEQ0kRQVfva0Gm+q23GAU69EQy3Rev7CMJc
	74QMaMzyYFrpIcvgWWc2huzYX8P5MICwdxXPaGH0UjygISsE4TOdn7e7
X-Google-Smtp-Source: AGHT+IHRecfblK8vR1wTkg7Bdl2kn7F86Ux81QsmlBimFCn4K8XEWHWHnLXKyVSFhm78XAFAqD/w/w==
X-Received: by 2002:a05:6a00:23d5:b0:730:8a0a:9f09 with SMTP id d2e1a72fcca58-73905a02721mr19367881b3a.18.1742801975063;
        Mon, 24 Mar 2025 00:39:35 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618beafsm7199869b3a.161.2025.03.24.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:39:34 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:09:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: MANISH PANDEY <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com, quic_cang@quicinc.com, 
	quic_nguyenb@quicinc.com
Subject: Re: [PATCH V3 2/3] scsi: ufs-qcom: Add support for dumping MCQ
 registers
Message-ID: <awc2ql2x5amiahf7l47xqhgl7ugi4zpk5wz7qycgbqb52gh4yb@24za7q2rqqob>
References: <20250313051635.22073-1-quic_mapa@quicinc.com>
 <20250313051635.22073-3-quic_mapa@quicinc.com>
 <20250318064421.bvlv2xz7libxikk5@thinkpad>
 <12753be6-c69b-448d-a258-79221f4dbc7c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12753be6-c69b-448d-a258-79221f4dbc7c@quicinc.com>

On Wed, Mar 19, 2025 at 11:51:07AM +0530, MANISH PANDEY wrote:
> 
> 
> On 3/18/2025 12:14 PM, Manivannan Sadhasivam wrote:
> > On Thu, Mar 13, 2025 at 10:46:34AM +0530, Manish Pandey wrote:
> > > This patch adds functionality to dump MCQ registers.
> > > This will help in diagnosing issues related to MCQ
> > > operations by providing detailed register dumps.
> > > 
> > 
> > Same comment as previous patch. Also, make use of 75 column width.
> > 
> will Update in next patch set.>> Signed-off-by: Manish Pandey
> <quic_mapa@quicinc.com>
> > > ---
> > > 
> > > Changes in v3:
> > > - Addressed Bart's review comments by adding explanations for the
> > >    in_task() and usleep_range() calls.
> > > Changes in v2:
> > > - Rebased patchsets.
> > > - Link to v1: https://lore.kernel.org/linux-arm-msm/20241025055054.23170-1-quic_mapa@quicinc.com/
> > > ---
> > >   drivers/ufs/host/ufs-qcom.c | 60 +++++++++++++++++++++++++++++++++++++
> > >   drivers/ufs/host/ufs-qcom.h |  2 ++
> > >   2 files changed, 62 insertions(+)
> > > 
> > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > index f5181773c0e5..fb9da04c0d35 100644
> > > --- a/drivers/ufs/host/ufs-qcom.c
> > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > @@ -1566,6 +1566,54 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
> > >   	return 0;
> > >   }
> > > +static void ufs_qcom_dump_mcq_hci_regs(struct ufs_hba *hba)
> > > +{
> > > +	/* sleep intermittently to prevent CPU hog during data dumps. */
> > > +	/* RES_MCQ_1 */
> > > +	ufshcd_dump_regs(hba, 0x0, 256 * 4, "MCQ HCI 1da0000-1da03f0 ");
> > > +	usleep_range(1000, 1100);
> > 
> > If your motivation is just to not hog the CPU, use cond_resched().
> > 
> > - Mani
> > 
> The intention here is to introduce a specific delay between each dump.

What is the reason for that?

> Therefore, i would like to use usleep_range() instead of cond_resched().
> Please let me know if i am getting it wrong..
> 

Without knowing the reason, I cannot judge. Your comment said that you do not
want to hog the CPU during dump. But now you are saying that you wanted to have
a delay. Both are contradictions.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

