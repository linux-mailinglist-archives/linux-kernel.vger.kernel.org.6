Return-Path: <linux-kernel+bounces-293051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275F9578BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0E1F238FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218A15A865;
	Mon, 19 Aug 2024 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ThB3gtsx"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF5159565
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110826; cv=none; b=jK9BmTT5f3ciXsoOL2AjjpEiv3sxoIFovoSRaCpzqxYYyiWT1bgtp+P4gvMzVltuW9RFcbmisUIBmjSE+RnLTIFC1e/bvjmUvSo3wSp9bUylhwfgyOQrsOJKqMJSnliM+pZTWbH5EcL/sWve2NecVNXkBmGYDec8GnR47dzlPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110826; c=relaxed/simple;
	bh=YPvzOFnH4gwgca48Ur3A8Ax1NuMLReALK95xcXHVHYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt1VwD46PlGmTcj/Zpqfl4KWv44ZEPIETesor5zH+HrlnIhxwrYG6pKMJflOAVwyZjYE23mlJY+/cakpPWXqafH2LzB3PP2YAZ7pR7Co0VWuD+mEY9lG7atSaffr3oeDKvrMHI0qM7O8jJYEfMImTU9A0OJRl/hKe/z/tz5UB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ThB3gtsx; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27022a3536dso2074041fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724110823; x=1724715623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKnu/Iez1+mbjTx9dSE6EvXmZdzm/o7bv0RI9fycVok=;
        b=ThB3gtsxYPH9cvOUxdIm2gXbkLF6iq5SzmKGFFt6Xl9isS8SvtHQgsCLnDkWAxvL6h
         iLaZLobYyG1+Bml2iZF6Loqlp4pX5RhvcakbP9jaSKSQ0qguN3ghzGjY/Zm/5sFTTTOH
         FPctM7vX1lOVRnJ7TUU2inBpHIqGTSSIFjV3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724110823; x=1724715623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKnu/Iez1+mbjTx9dSE6EvXmZdzm/o7bv0RI9fycVok=;
        b=oH2cjwhnDtKZm0Ccpp1pRZKB2BfcYYloQ+Tl0MPYUq/CDKcUt0xCXbJ1Scl2jKSiEf
         mdCWlrcA8ZNHfJbwpJ6ge8/JpCZxyeq00z5RSWzpKVvfuKe4ZAJ4v63TbfUIjd0pjkSj
         JAW3NAcITgYk9I6n99OmxE0juC1uqmOs5S3E2gKVc0faccKhyCl+IEbWoFmR3byWKx5Q
         Ahaab/tTsuZ0/HRQO6Gz57klnbG6Jh8wDId8I9IHEcyAnbfj9mhji2W2yYO0+FaX4n/B
         o1lKZKH1qcind0EU/WhvDAPm34WRL/2oJzD3pvfMxwbJpIGPgafcJYTBuy4HeY5fO7vv
         43RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYrnXhreEgmpCdSbn8VaBqtpGKJSmPuiSbgJmo3lGTpTje7pkV8BklzLl/1A+yk1fJ0TVS1YrS++mmtzmxBLRvImXaE6r0T4X2GzjT
X-Gm-Message-State: AOJu0YxOxWnnUS93uvJknE+/89iFNfQzUI3Axmqr7Y0f5uzZyRJ8WKxm
	nWMRMWZMjgx4p4nV6kB4bGzW0wHbz3UF+eXhSHg+wmxK4Mca3J7qrybt68IGZOZxxzUtoLvEx65
	5htNm
X-Google-Smtp-Source: AGHT+IHj7jOAavBGsvWnPitfr3CXwRNl5SbyB/kpz39mXYb0tT1LQzPwWdRyYngcCGs9SKP8BqzIpQ==
X-Received: by 2002:a05:6870:7b46:b0:268:be91:23a4 with SMTP id 586e51a60fabf-2701c41d74dmr15026733fac.30.1724110823425;
        Mon, 19 Aug 2024 16:40:23 -0700 (PDT)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-270049bb377sm3274412fac.45.2024.08.19.16.40.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 16:40:22 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5b850d969so3073471eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:40:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXm5EGEwRDiwPjY+BhJy8jdwjTd4x3XDPXIKGtHSjH+3SM3iElmT9X6+4OsaKyIwmVvhb4vTLnkmYBCT0BN5W8zF84EBcn1B+i8ynyF
X-Received: by 2002:a05:6358:2923:b0:19f:4967:4e8f with SMTP id
 e5c5f4694b2df-1b39329f298mr1693684755d.22.1724110821953; Mon, 19 Aug 2024
 16:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819073020.3291287-1-quic_sibis@quicinc.com>
In-Reply-To: <20240819073020.3291287-1-quic_sibis@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 19 Aug 2024 16:40:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VnQCO+y_wy=KQhK3wGwHGfO0+MQntgoPh78ZygcgNiig@mail.gmail.com>
Message-ID: <CAD=FV=VnQCO+y_wy=KQhK3wGwHGfO0+MQntgoPh78ZygcgNiig@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Re-order writes to the IMEM region
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 19, 2024 at 12:30=E2=80=AFAM Sibi Sankar <quic_sibis@quicinc.co=
m> wrote:
>
> Any write access to the IMEM region when the Q6 is setting up XPU
> protection on it will result in a XPU violation. Fix this by ensuring
> IMEM writes related to the MBA post-mortem logs happen before the Q6
> is brought out of reset.
>
> Fixes: 318130cc9362 ("remoteproc: qcom_q6v5_mss: Add MBA log extraction s=
upport")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

As discussed offlist, this isn't a perfect fix since writes to this
IMEM could happen by other drivers and those could still cause things
to go boom if they run in parallel with this driver. That being said:
* It seems like a more proper fix needs a coordinated effort between a
device's built-in firmware and the modem firmware. This is difficult /
near impossible to get done properly.
* Even if we do a more proper fix, making this change won't hurt.
* This change will immediately improve things by avoiding the XPU
violation in the most common case.

I've confirmed that the test case I had where things were going boom
is fixed. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

