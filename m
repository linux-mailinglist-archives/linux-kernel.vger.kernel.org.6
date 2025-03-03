Return-Path: <linux-kernel+bounces-541669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C264A4BFD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969D016BB44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303971F3B92;
	Mon,  3 Mar 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nU4LNlrO"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656620D516
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003621; cv=none; b=ETLkmiXSPmFZFe3U5BB9tfj20dAgMCEUKiVmZwpcUVs8sh8Y/t03SopILDU6hVySZcCTiRcNXhgSVBzfEB8uprW9HTq4uVXi8n/3zAcRE1gNVkxggfEHIFpn6k9VW9SARMGnoJ1g+AUOfsvQotZ8lThK2sbda9Y4/C0oKIoiqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003621; c=relaxed/simple;
	bh=O9DZsoG7K/toKcDvfTgr90tTBVWhN5v0i0S8g2m2A7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TH6iNU3UcuPNRf3SMdRcUT5CIEayfmNqAPHaESi2Tafvq671OdxlVA5anWvLPuGaM4OvUiGa5LPXRzLYdg4Tdhot7THkl8p6hl3cMabxQfB4jN7OKKVQPDK2t8OCo2gyyvwqSNBEcL5pRji41BMOBk4k/yhSvQePEXephx1hBzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nU4LNlrO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f47ed1f40dso32592167b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741003619; x=1741608419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B4ahxN8eq6WXL1rpKPL4dtpg5+dhmj045yIT8c+PiBc=;
        b=nU4LNlrObyeSUskO33GdSG+9Rmy0+G2g0FShkx69zevcsVhtz0KQGHiekCaAFEXIII
         Zp3nlmMu9t3O6yyX53JShdd4FIpGREoX3AxGIbpYqHIEj4Bq35Pi9B6evugqZ252WOxc
         SgchtVAywHM5/H5RecX1KAnCVwrGlZjQXIs7GMNuRugY3MPhik60hUTFTMlx4rndInWo
         tCVsv5TuL/er5luOpM0dF+1uPjoFcgHcDK9lXbDceOFc/nZaBSRvznIcxvSe/erewF28
         1HEYWTRzggZ0ubnM8qkhz1W74aQ36+ibdCbYlFjQ1sxS1nEOuR/u7wvNw8A0LdBHrSwc
         yKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741003619; x=1741608419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4ahxN8eq6WXL1rpKPL4dtpg5+dhmj045yIT8c+PiBc=;
        b=qLVci+RJA/BzjZFGpMehMeEhcFQV64oqJRixctX+TwxZ3YBb7pTcJ6z4GSOqvdmdjI
         zHDuz0Iozi3f2LRPR5dgVsYBWjUuRvNKQu83GCWwaJ1GLAEX1R3VzG8U2B4IaBV63XoB
         HqPNe4SWQloDOIGRIj3HmcczhEE3tf3urYYSeBCakKTWiF2l8YA2Jrt1fBGzlC4tItWv
         Ccr+BejyuNK8U9ru8SdhIciekJ7hA//zau/xfclnf13tDWDmOoXIDZbcosC8e3YMW416
         sTnlVECW4ftSbrHyU6Kfs3RdCsVaL3SV0Eskay6lFBu5Q8eqFzgTEepP5EyMkl5pgAkf
         lLeg==
X-Forwarded-Encrypted: i=1; AJvYcCV1wRLds9lRQfj1T9ZkDUixHDntokfdg8eg7XBfirpu31hwbDERfYkgE8b51Jjw7oSDD/0dY6ScKkE0TVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFr8kzQXeSI/qSW5aZPvjld9EA5RSjRJpg48oTinKMv0NBB22
	licjD7dw+LaZ818k4MLSh5/yK+Go4Sk/Wd/GmNpratysni1iti6hnkgEfkvsNaBYZARt4JpQOfP
	QWD7x8v8lSnFxJQkZkBoOwYaULq1E4+LYurQWfg==
X-Gm-Gg: ASbGncvPZG8EXNqyhJVPACmNmlfYtZmOUpFmKSPVPLZddT708Bptvh4ZYVHAcNjYThx
	dmZ6PX40hMzN7th3WVvga+lcUy2+5jZlRzAvCORDErj+4jxvJI9KE2klixN6MuEBNhBpXKIClK6
	QYn6FYNZZCG2Hm4HeVfYJ5T0mLXpY=
X-Google-Smtp-Source: AGHT+IGsfLIlro46n48+LBTnO/N8JCstZtmfa+6qqdaLZ/mIIXy/ByieG0J8/rLqrWxa1gKNjy+h/CO4aYpxCvigVSY=
X-Received: by 2002:a05:690c:7305:b0:6f9:7fe6:9d44 with SMTP id
 00721157ae682-6fd4a020593mr155311317b3.4.1741003618774; Mon, 03 Mar 2025
 04:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13709135.uLZWGnKmhe@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 13:06:23 +0100
X-Gm-Features: AQ5f1JrmlyWShQB4700csC-8hVyGyFUfHKFXi397g_iO-b7Ha4Ktk1dAB8l1pf0
Message-ID: <CAPDyKFoWeZNqODb5VdXfTEhxRJ0azSQPWhM3WCJ+iUeJ3rYQHw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 17:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> Initially, this was an attempt to address the problems described by
> Saravana related to spawning async work for any async device upfront
> in the resume path:
>
> https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@google.com/
>
> but then I realized that it could be extended to the suspend path and
> used for speeding it up, which it really does.
>
> Overall, the idea is that instead of starting an async work item for every
> async device upfront, which is not very efficient because the majority of
> those devices will not be able to make progress due to dependencies anyway,
> the async handling is only started upfront for the devices that are likely
> to be able to make progress.  That is, devices without parents in the resume
> path and leaf devices (ie. devices without children or consumers) in the
> suspend path (the underlying observation here is that devices without parents
> are likely to have no suppliers too whereas devices without children that
> have consumers are not unheard of).  This allows to reduce the amount of
> processing that needs to be done to start with.
>
> Then, after processing every device ("async" or "sync"), "async" processing
> is started for some devices that have been "unblocked" by it, which are its
> children in the resume path or its parent and its suppliers in the suspend
> path.  This allows asynchronous handling to start as soon as it makes sense
> without delaying the "async" devices unnecessarily.
>
> Fortunately, the additional plumbing needed to implement this is not
> particularly complicated.

Thanks for the detailed description! Overall, the approach makes
perfect sense to me too!

I am certainly interested to hear Saravana's thoughts around this too.

>
> The first two patches in the series are preparatory.

For these two, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

>
> Patch [3/5] deals with the resume path for all device resume phases.
>
> Patch [4/5] optimizes the "suspend" phase which has the most visible effect (on
> the systems in my office the speedup is in the 100 ms range which is around 20%
> of the total device resume time).
>
> Patch [5/5] extend this to the "suspend late" and "suspend noirq" phases.

I will try to have a closer look at patch 3->5 later in the week.

Kind regards
Uffe

