Return-Path: <linux-kernel+bounces-205021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035E8FF656
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B249C1F244BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E67B7345B;
	Thu,  6 Jun 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6bCpPYL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052471BDEF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707858; cv=none; b=L1cD+H2Lres4aHET4ci7bV1IO+HJqYjMQK/8fsmDNf9dE1DmaEyXHi0ZHwm3FMXk9ConVelAkXPkWTVYGTXnhj+n4ycgcqeUxft3VZ8Od8U8MyenCiW2e04jJPhlzBaeMEVSa/Hm1eJiGLmFPCnWZBwU/NCCTCj1VErw1kqrhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707858; c=relaxed/simple;
	bh=keqHyOdOZOwQlgrReYoPFxFzA/8w5CidNqJNBoo8zhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnJpNz/v8tX1R81i0rADi7p9B6S2DM/P7dY+IUM8Th3duUnBoazO0GmtV2/8BCR8f4N4joJEBh2SxegkIPXIuOZ57KjWY+L3w4A+nyWr39nxY9bgWb9AZy7H8cXRNhIqwHo0ifXtlbKZ0D0u6Q/KDB1fek09OifE84gYUhdyWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F6bCpPYL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so1558580a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717707855; x=1718312655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=keqHyOdOZOwQlgrReYoPFxFzA/8w5CidNqJNBoo8zhU=;
        b=F6bCpPYLjeUYOrspMZF8Ed39T5S9tSM1X1FGz7lTm9YrcbfWnNw8k+oa9Fv7PTVHvv
         jyMxu/+8QMkHsySIt+Mu0XX1Xn658E9cLATYXqsMPMuNf/KSdAJBq9W5MH5U8tuCs7qe
         sByfEhqBwdmEDIymilLmhP3fyv4sB+HoHKxMQHUsWRUZtw3yn22MeH7YL+8rb37ypfq/
         RMfwDMpbt8+QjGgIYgJBC78O7y9tI86TgmeYg+WQ0MPO6t3KCjMSZMkLJMIyvNc2Db4S
         AIw3at95vRuksLaqJIXtNz8/xopWaVT9dulDPxZinAw0fFVhKyuQWn4yDWA0xWwSkMtE
         5WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717707855; x=1718312655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keqHyOdOZOwQlgrReYoPFxFzA/8w5CidNqJNBoo8zhU=;
        b=imOdtmOyIqJ/v4FACoeLytnIbatsOi/IT39xzbESbSY4YoiPVuYWG9a8aIqC6heCix
         RjUDkzFjlXvsN1i+jmzGQx3xBbilbn+4Lkn0uvwTbDK3IEizLPvEpfe7PfuwxC0xjfk+
         Rt+iPKuPN2zG5i36FV2Hyruvonrq3JwDZVOWR+FL8z7bdoQbq42AFOfUQr3FTMC2q+tQ
         0BFHQHzycMizpJyV2A4FYRa8EpHZrLwTCI0yGpeB0Cvl0Z4SsbZaONoPzXnpPX0boPew
         8mMd6NHljisy3LV20Bvtzm3Dn6Fb1n02mFVIFZZq8vqrByMYDLaFTTh53SLd1dr/+M2b
         sh8w==
X-Forwarded-Encrypted: i=1; AJvYcCW1v1gKxqf7InSfMon0VXzQMfPBuiIzZVCFe4tfjzq1uQC9bp5TXRqhoXIkwQRj3NYnxCqVZOgVE+iYAru+9SVvnkYSy8bgmxsJHdR+
X-Gm-Message-State: AOJu0YwLliHKMQF2oGI5KhGEBztGv8cI6tWZI337s4VPmSyKEOa2MG0D
	AevhuLNrX4iNVH1Fdh2LJDg9hgu/6n7c3jDo7vr8PrB/PbK+dF3vdSODIN1IKfmx6iVZVxexYnZ
	OosYFfNkJNZUId8UlNyjxKLJQCmX5C7zjpljDrBtW9aR2Adkp
X-Google-Smtp-Source: AGHT+IG2Dcfh1F6YQ6OimrrH2CnVwHu7YNWHrj7TTURR7AB/btLmExEwVjIwWGrAUhwqk8yw9zkUfG5ST1NPvx1G1f0=
X-Received: by 2002:a50:931e:0:b0:57a:4ee0:8144 with SMTP id
 4fb4d7f45d1cf-57c50827346mr239799a12.4.1717707855180; Thu, 06 Jun 2024
 14:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603203437.973009-1-tanmay.shah@amd.com> <chqsvuwi7gukbw3l2y6xoxmd3lh6vlqhs2wjd4lylbhsg5m2hc@vnmesij3xoiu>
 <4b401ee7-73b8-4974-848c-5a181c0bdb81@amd.com>
In-Reply-To: <4b401ee7-73b8-4974-848c-5a181c0bdb81@amd.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 6 Jun 2024 15:04:03 -0600
Message-ID: <CANLsYky3f9cw-nY2Q--uniB4k1QfHkCy8JLi+XcaxYZKHw8jnw@mail.gmail.com>
Subject: Re: [PATCH v4] drivers: remoteproc: xlnx: add attach detach support
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 11:47, Tanmay Shah <tanmay.shah@amd.com> wrote:
>
>
>
> On 6/4/24 3:23 PM, Bjorn Andersson wrote:
> > On Mon, Jun 03, 2024 at 01:34:38PM -0700, Tanmay Shah wrote:
> >> It is possible that remote processor is already running before
> >> linux boot or remoteproc platform driver probe. Implement required
> >> remoteproc framework ops to provide resource table address and
> >> connect or disconnect with remote processor in such case.
> >>
> >
> > I know if changes the current style for this driver, but could we drop
> > "drivers: " from the subject prefix, to align changes to this driver
> > with others?
> >
>
> Ack. Will be fixed. Is it convention not to have "drivers" ?

"drivers" is not needed.

> If so, from now on, I will format subject prefix: <subsystem>/<platform>:
>

That will be just fine.

> > Regards,
> > Bjorn
>

