Return-Path: <linux-kernel+bounces-388648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26259B628D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFB1C21B94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598E1E1301;
	Wed, 30 Oct 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSSUQXSs"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400981E7C2D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289940; cv=none; b=fxyVukeOQy62SAPP0rv5DnuLGKrr4cVwq3pMvp8uX8jQeOe3Y93Mnymo/MhN8LbDONXVFYk25b//ftqVcY+ahwycsJoCL9F3/mGNsHOIk3ofQSxnxPgV3IfW7vt5nN2MdnDzVMaF2xxGsUo86NfpfvcFE0DlacpNKF9fK+1cOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289940; c=relaxed/simple;
	bh=i1lP8I2grHrCyE9c+t46FjNKQ7k/gGdFLb+BmlfKGdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXkldDxwMbFi/W4GZR5GFKXv2zOEh+OQcBmhxLsz91+5SLx2YryDs1bOI5mtbYQx+hCoVHVDzMsWFKkNAYm3PXv+JhbPVAdw1SOiUO5x6/5l1iqcRs44zPRuX2BcksmHoNOc3fBc1oamXj+LXAPQaQxcS3D7tI8X5Rqld0hTGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSSUQXSs; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7180bd5b79dso2635213a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730289936; x=1730894736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1lP8I2grHrCyE9c+t46FjNKQ7k/gGdFLb+BmlfKGdQ=;
        b=lSSUQXSsaSOgZU2f3Daew00I6NL2+efCPSGiItNwWeeRzKSK6U54gb3nn52IIHOm0E
         R3EW5AxP2G06TB5+Z/ZLJ1Pdk2HrWXvtMzDQUajg+cX3/OG0VpMr2xAyL2B+645X0kZi
         U8jort3N65efeTQM7zhvjI+QbYkgrk6MSaOHx/aCWxbJarVEfdFW9oZ99juJkCGOVPNu
         H5zdJIxuCmC1K43E+EsKeo0BzclI2HP/02K0Xz6hR7lrmABQ2UFytPvGZLKbqwxtLQ1v
         ijuqhe8ZG1OR2H8ARNspiNoYX/EmvYi/YrSQMBCHkZ2/OAO6XcFI/uL7HF78LmNQkudF
         mBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289936; x=1730894736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1lP8I2grHrCyE9c+t46FjNKQ7k/gGdFLb+BmlfKGdQ=;
        b=jNfNJpruamggdgN/m/qQL1o9XWmWaqttx9KSMuZ2/s4fTXfEAfbxO91eVgIzpdXjGJ
         5m2O4ZhhBDYziXOWMXp/R/ryKql+tEGPclZ3OG3GntXSaki3441ljLtPoEDmLfjynBv7
         C8N3hwJaqtWelw2dfz8JwrwHP6RxTg/2oxm/Y7RcVXbaCQX5OaIpZMyyILOmiULU08uq
         rrgHc//sBI2cijYe2eESdstuN7j0sRI9nC2n73+A8BA6hJy886q5xsUyk0P6cK+0+voa
         rKapR4KNHDHnduT9Ly3uQUNoh8MBQrezOL3XaSv/OXLkg5tfjaFN47znZm0YnQgmtO20
         oNwg==
X-Forwarded-Encrypted: i=1; AJvYcCUG6HK9zpjppGPQ/5guK74NY7GynjlF4E0tCUemI1a7jOC0AGy+tnwYFXyhyosx47YIzNOtA1vh2Fkadzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyza4c+DRyhYWvEe6synYMa0MOmLRJKB5DVCD+3amZkUb52HZF0
	3DiSMxhEIK9c3zPJFIiwH3CVkKpkD+VIO1/WUqXKK2yA7n+YX67vjugJpFgvzTgp7s5byZ+PW0o
	SFw5pN1OCYQzrbOK4Syc1vuC3JODwRYybclRXng==
X-Google-Smtp-Source: AGHT+IFn+twCzCSyeeaogqHqxJtlAhMOH/0ALCX8dQKWNuWWzUxem8EDdoP/Zy/JRJuXvAkQG9PBSSTzZU3c7V6LoE4=
X-Received: by 2002:a05:6830:3146:b0:718:531:c190 with SMTP id
 46e09a7af769-7186827b1abmr13608345a34.24.1730289936015; Wed, 30 Oct 2024
 05:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-2-peter.griffin@linaro.org> <74458ba4-af0f-4c41-92f5-c6c0cb79e930@linaro.org>
In-Reply-To: <74458ba4-af0f-4c41-92f5-c6c0cb79e930@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 30 Oct 2024 12:05:25 +0000
Message-ID: <CADrjBPozRnsf5a0fNchbuokUK6y00SNSqEGDJ-sHojSvFzdd2w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] scsi: ufs: exynos: Allow UFS Gear 4
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, avri.altman@wdc.com, bvanassche@acm.org, 
	krzk@kernel.org, andre.draszik@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ebiggers@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Wed, 30 Oct 2024 at 08:04, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 10/25/24 2:14 PM, Peter Griffin wrote:
> > UFS Gear 4 offers faster speeds, and better power usage so lets
> > enable it.
> >
> > Currently ufshcd_init_host_params() sets UFS_HS_G3 as a default,
> > so even if the device supports G4 we end up negotiating down to
> > G3.
> >
> > For SoCs like gs101 which have a UFS major controller version
> > of 3 or above advertise Gear 4. This then allows a Gear 4 link
> > on Pixel 6.
> >
> > For earlier controller versions keep the current default behaviour
> > of reporting G3.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>
> some nits/personal preferences below, no need to address them

As I'm re-spinning anyways I'll update it like you suggest.

Peter.

