Return-Path: <linux-kernel+bounces-543968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3817A4DC10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E283B3011
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86981FF1DD;
	Tue,  4 Mar 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uu6G7HoH"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C11FCFC9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086620; cv=none; b=joBPY626GwiDg1vHwP0uGuWZnfumgNcKQM7HpXwZ/lm9ztT29v08eebKSJF3Xlnq8O6Ux4fpnULeMgH2WME0HJOiGUhsdTKyapxovzffTwGkg2kHULNBWQo2P8YvehJ9TsVrnOjVh97Gd+GXVeBsaPHZ8c/JS+9n0nOzC3xuU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086620; c=relaxed/simple;
	bh=orq1R91M8c7dbpXtuEOgzh42cNSPrB9DSV2M6evhgEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV8PIk/TiMcaeNqwv+PDE+sLxyWC2/1nVBSsQNUOHSfbseCTgW4T3EWUcdTVzlbB8nKHPUo3c4HFEj2kG8OW//sLbSnSlWugy9Wiz0xScU/ddupbm3xloiobJ89SavnxSs1hzgdJ5h9TE+XVmCLekmsCm1E838RWoZ664VrAY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uu6G7HoH; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fd19b469b0so1512934eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741086617; x=1741691417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQbFhcoDrZBPCIQTDm/+1b8V56ThPOVb0NP4CFpNh3Q=;
        b=uu6G7HoHasu8+ttQ9ueKU8i7O5rmNcpOYtwegexQ3L64JgPnqq9YXgC8cgsz8+7XyN
         y3WfH3fX6SsQ/C9OhgLpINNvNNypB1ALO6K8lMyDAvXrcMCiArDJ9OCHZV95GQlNdbNV
         MxPfHKNVWxPmkoNDvZ/jDXPCUIGVbwZ5XfR4buQUu6HasdRFYOQgiCej68SaRYjLThly
         5FOQtyqxOkyWTmCc2Y685E2NccJ+QzdgrHGQcRdg8qnaQQVQ2lz06MtfybjwRePnVxwV
         xp1CRzY3j3WypR/vNzyJPWxOjJAu+RoGFpJKCK6Csj9lnBld4FJiC8oDi5Ep7SR6re5o
         ZxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086617; x=1741691417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQbFhcoDrZBPCIQTDm/+1b8V56ThPOVb0NP4CFpNh3Q=;
        b=LMNcAupStHMrQMsBUx3Hh3zcnOkJxap2Y9KVNo8aqlYiEvkAnjiXWugvzteqPe4Y5l
         O2y70hbREKQWcH6EAHMvHTZBKs6oXTv6ct05/Q0I3WbPPjqQYhsAS0FgzzoUZtTLS+q5
         gloPuSa4QcpEJr7vC2nlzwBa+K96eX6JU4lzXmKnAj3YfBowJVhJ+mta8HXima2BvoWt
         9yewqHlglr42aJ9Igz+kio4vQIR/2Ew0vNXWjklgVI9uoIV3maxJq6jUSMDMsAPWyKLZ
         7iczYaDAnDXDljet4qI2wwjRPwyASz+HI2ZfHRBTUiR0srsmdEnTCrXn5tT7oBt3LOKs
         DnHw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVLhzb+XK6m2304AamUMEFVmRsN5zBrfQbbifeHTlTZ0x0ZtttI8fB6mcmCE9NdUG+sflehWjMWnn54E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxakrdaO+weXWI31uhQhHW2ExPpjZZ5ENdPoWRclXUU3DULNWiU
	Q0GD/ZJQiy2x3ComzGZg+uCQRYXlnolk3Z37WZnkFNsuYlinMS+f8xpGSI1scDnMX1thnTnLbUh
	wQpB8sSTw21PNSgdV344ePPBazJnFLJnLRvrWEA==
X-Gm-Gg: ASbGncsfyhg/07zig6i5np9KCAVAIxs0RDFaxU9WHEUuWFtuzTGKHSIvBfodUgs4ng0
	2x/yR7aDC8XRFndDLdmA7sAGVlI7fbBpl0ZiuVCzdN2cvdhx72ebXyqkUiKTBZwXt3hOf+PhlA6
	35xR7wpBkdM9bRmNX540CixUhsudk=
X-Google-Smtp-Source: AGHT+IEINRiNLM5nuBLFCz1du/UfXjBpJa2EipBY+f1wkfnUA0YwZBo+sl10akF+u4qE0h1ovmH6xsuQeboW1BoOyFs=
X-Received: by 2002:a05:6820:260d:b0:5fd:c5f:3937 with SMTP id
 006d021491bc7-5feb34b8657mr9224249eaf.1.1741086617654; Tue, 04 Mar 2025
 03:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226220414.343659-1-peter.griffin@linaro.org>
 <20250226220414.343659-6-peter.griffin@linaro.org> <51ec6f40-c62a-418b-a538-082e3ad887cb@acm.org>
In-Reply-To: <51ec6f40-c62a-418b-a538-082e3ad887cb@acm.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 4 Mar 2025 11:10:06 +0000
X-Gm-Features: AQ5f1Jqwsn9oJaTqNHIYgxQUuylO7zocGAli9flyfTI1wTMKlEft2huZY8mFVSM
Message-ID: <CADrjBPqw-kt+4fLfJCziAJrtcV4gVM9Gubtq=7Xb8sgxq-i8uQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] scsi: ufs: exynos: Move phy calls to .exit() callback
To: Bart Van Assche <bvanassche@acm.org>
Cc: alim.akhtar@samsung.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, krzk@kernel.org, linux-scsi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, willmcvicker@google.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, ebiggers@kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Bart,

Thanks for your review feedback!

On Fri, 28 Feb 2025 at 19:20, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/26/25 2:04 PM, Peter Griffin wrote:
> > +static void exynos_ufs_exit(struct ufs_hba *hba)
> > +{
> > +     struct exynos_ufs *ufs = ufshcd_get_variant(hba);
> > +
> > +     phy_power_off(ufs->phy);
> > +     phy_exit(ufs->phy);
> > +}
> > +
> > +
>
> For future patches, please follow the convention that is used elsewhere
> in the kernel and separate functions with a single blank line instead of
> two.

That was an oversight on my part, will fix.

Thanks,

Peter

