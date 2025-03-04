Return-Path: <linux-kernel+bounces-544041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E6A4DCBE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0BC188B934
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FC200106;
	Tue,  4 Mar 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yt11mg9J"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA911FECB1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088290; cv=none; b=EQLvI6IliekIDNnSP0K8MPvPXsLoSkNY/su4APdDmSkFvl+VLKr4E3nVsHqubljespNLARBFco3pQq5yyvn1k3JMXHU4xeVTqFfigAe+KNvvINhUal/QA4AYbkAC/H4MkIeiqxASLdfjBj8k0RHY1VOsLvLjI6I5/DV7rk9yZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088290; c=relaxed/simple;
	bh=oC5qjHB1PX1QOUkEpX5gtofRWcRiWb2GfBc+5/XWrCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlnLjiHKxb6IblV/p+CNNczUCIADU1mpZT3/OnHNBYwQT0xPLbYdI06mnMqNkFGX6lSgeZe7rXryFFVcxEHkKoBEGv6XJWqX2FI6z7lvizd00BT2wZ6mU860PyZpdzUntaUng5tHWtJds0Iod9bnYI999Jnw7r+osxjp+RVVIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yt11mg9J; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72a0a3ad672so511115a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741088287; x=1741693087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oC5qjHB1PX1QOUkEpX5gtofRWcRiWb2GfBc+5/XWrCM=;
        b=Yt11mg9JVivfAiIYXPDkVigOhyxzDTG92BcJtdMuLOVovRLnRc1gdrxmXQjNHFGHg8
         0S9Fr1SCPNeJXomWm02Rr4So4pMlUk7v/N2X6ta6EfVRpzebPIMhyWfpZ15ZCOewR6tS
         Dec0wUrxTKrjgJNsMBJJ2wzv2Maj7DSps0d9UVaGmQoVTcyIOksEWe+1BMN+yHgvECbQ
         D2Xivg0U/Z4PqC+b+KfP2AYW/2VG8c15qgQ3U5MV3vtysjQsrv87/araLtOD4+HaGQE4
         ATJ8is+OAXeLLTEhasi4M+NVn0ti4Je6q7w1abzdgYAA6d6kLWVV3LcRvpnrcOCdF4Gv
         51tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088287; x=1741693087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oC5qjHB1PX1QOUkEpX5gtofRWcRiWb2GfBc+5/XWrCM=;
        b=ehzC8WSSziPFhTVtHgl+ohxW9cB+V9fQl6ZCQBnkSa1c0zC2/K6NB8fkVWfT5IRUAK
         T0NgJVNKIHbR0g7O44SoO5dde1zOA45qNtRwDDTgfMTP+czmlmc+66SZaEQyNUIQslOx
         73orcZaXVge0acWaLMkN69oux7Sim7RTt4+51w22kc5Ulfpg6hj95T8/v5pQ1OKWklfx
         BDsoHZb606mLLOpJiVu9+pJ70maSWJcX+EFIWpCmG9AFtQBxyWrkwzbAPcmft4MBj39a
         dHni75+1v/eSey0UAeJnh/gDBFjsLJYnCYn/pLaKjC3+CzWE2h5HrrkP9/6W6C1Fx/xo
         0NJA==
X-Forwarded-Encrypted: i=1; AJvYcCVD7AId+A316vuL6rXJIG9ilXGdL5vj/ItO24Ph0HXx8hR7M/0Ysnt0cDsAMU6DyyzCICoxxK95ke2SMl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmuTCz5UPouNuTWVBLqo7LEPA2NU/SHG+aZtQiyvhq1ZKtQHMI
	ZC/cMlOXZPFvtu65++6+C6EeccYhN3AvSTnX/S/+5Hk+kc7rce+ASbhFJWx74mqmk5i9SbdT9bG
	sYf0h2FtpUyTmT/BdunbJFdji/SZkJN0q/VzJ4w==
X-Gm-Gg: ASbGncspe2agBgV0zfhfcEcDgnpPCe4kbMoTSI3UUD1XO3rvqMDDzkSJfw7h9hpif55
	WCLFwIuwC1Y7FhXCJq7Id7C7xYvwI09BE/QVIwR9QGKBq8v05utAHuoefN1gVOBlNcPtDRIy6D6
	+Rj02xwhwbSj/icU9Rd2aeWWa1Aus=
X-Google-Smtp-Source: AGHT+IEl29p/uRr2dkieWp0OTEK1kdeHqqHxSZa3QXSfzg/07iBAOnkwXHFw1v1HZhu1dFp6njIHzwHLg7pvbXeNaRU=
X-Received: by 2002:a05:6830:929:b0:727:f8f:b25 with SMTP id
 46e09a7af769-728b82f3176mr9942270a34.20.1741088287678; Tue, 04 Mar 2025
 03:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226220414.343659-1-peter.griffin@linaro.org>
 <20250226220414.343659-7-peter.griffin@linaro.org> <015ce85d-c62b-472c-8527-33217ad815eb@acm.org>
In-Reply-To: <015ce85d-c62b-472c-8527-33217ad815eb@acm.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 4 Mar 2025 11:37:56 +0000
X-Gm-Features: AQ5f1JoxKZtvBwSf5o93rOZKsNyWnyc_-Mlje4_RgWAiq42ic3vdnFhmRmm7aMA
Message-ID: <CADrjBPrOTMPh2BfROdMnCrPWBaKw+uQ=jH3yYNZ-HEKEjNahSA@mail.gmail.com>
Subject: Re: [PATCH 6/6] scsi: ufs: exynos: put ufs device in reset on .exit()
 and .suspend()
To: Bart Van Assche <bvanassche@acm.org>
Cc: alim.akhtar@samsung.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, krzk@kernel.org, linux-scsi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, willmcvicker@google.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, ebiggers@kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Bart,

Thanks for the review feedback.

On Fri, 28 Feb 2025 at 19:21, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/26/25 2:04 PM, Peter Griffin wrote:
> > GPIO_OUT[0] is connected to the reset pin of embedded UFS device.
> > Before powering off the phy assert the reset signal.
> Does the above apply to the GS implementation only or does it apply to
> all SoC's with an Exynos UFS host controller?

The reason I went with a generic approach (rather than adding another
SoC specific hook) was that exynos_ufs_dev_hw_reset() is already
called by all users of this driver. From that I concluded it is a
common register shared by all exynos implementations.

It is hard to be 100% sure though as I don't personally have any of
the other Exynos platforms supported by this driver to test on.
Another approach would be to add some more gs101 SoC specific hooks
for suspend() and exit() to exynos_ufs_drv_data() or another
EXYNOS_UFS_OPT_.

Thanks,

Peter

