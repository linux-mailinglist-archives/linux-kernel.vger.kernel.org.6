Return-Path: <linux-kernel+bounces-524150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F617A3DFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BE61889067
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31029406;
	Thu, 20 Feb 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUPXFUC4"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DD1FECA3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067309; cv=none; b=pTzYbJTJvh2tpQ1uB4GSfaXHF8sjoK2c5KQ2vyy7rHASs2SsUZhM1jtSi9ZKgpGBPSC1tssVMv7F/OafYD8VDHGLRBewOpHQA4PJGyLHLlBcCW1SviudG2tAkx3O2Hv6iVRXIwqX0Sx1VG+NNm20o36v1wNbyG+/NyIvR/qkljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067309; c=relaxed/simple;
	bh=6f30t0FycP7wwwGERE0OSDlKv139yOSwMDMH3gonzjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3e0NnBVtgSxHE+mTbnzghRC3WiXs2+3u8aAVJc/Gk1gYdEwwaCXLM7iE1qF/Txs1H4QwW53WnoTwx3MO5SxoA/f0+TBINGez8dMmo3ETxOE5NK3L3skoDNmUlAxxD1H/XoJ4vx1BnXRXAfoBsWjZoGj2Neol3D0xziYRioJ2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUPXFUC4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-472098e6e75so303001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740067306; x=1740672106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6f30t0FycP7wwwGERE0OSDlKv139yOSwMDMH3gonzjQ=;
        b=zUPXFUC4wHo2dQWfUG4faR+kkQyC3GeVt7A3j6rH89SFFUdGExH3uiIVcbym9vCFjm
         QAda6HEEg8lnoSEuWuzNbN85S6TgRe5SYIV+aiXvuTylqK+bDiVn/VqxaP/Wwu+Jb9YB
         UzvdXo2jn57Q9/8t0M7WZne7d+vz1Cp/Ha5tB3JxKz48jA5EKhGGF+04jjMw9EmfgW3Y
         GvS7r3xOkYXNsyE5csE1TVxhwxY9S++ICLlo4oGwm2E+7QApdBDofwr9V4E+yWIopkks
         GLz3p/Vq34igQGOHFnWENFwrq+XsrJTSGx2Ti6ncI1T7J5kOI9Y8cKcb2ysYlPA2o73R
         Fsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067306; x=1740672106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6f30t0FycP7wwwGERE0OSDlKv139yOSwMDMH3gonzjQ=;
        b=It3z7Mh810Vh4ALhGtcmi44v5mCfG4atyzdwDoBAQRafgMUOjUHoKkyPZb4lLKq6Nj
         7sNvNzF/27CJgGTLUwS+p3/VR1j0j8Mh8VrVVDJi4nS0Oun7pprddNR79Ti8ueOt6QZQ
         aN+uGBk2CTgYNr2wl5NOnEjfvB/Kb/6XuiACXA06tVuXJt8H7ZFWt4f63R3/LJ8WN0CT
         srKI7tTS5o8P4qy3cm+2WV8jLDC4tqtvVVe0tgdRIMzktrGY8kkgLJAZpHGOumfxvTwZ
         4bPJqQ5TBouQTKvGo+hU7a45jeFrC9otsuVf/ZX2pfnTxqoC+EZNSPgbV6Sq2sRDq3+3
         +cow==
X-Forwarded-Encrypted: i=1; AJvYcCWMgP5OyQbUE5+GDTCPAJOrWIC4JZwYqTfOLm5ZUfZqu/GqZw0RRWMcAZZxU3O5nOvf+/VwJkTNgqNRCAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+d4MaxVEUdavq48sdQ1po9Dk9y/YcD3e7Cb5NXoIz98G339hj
	t20CbOPI/wFbygKCpFIaAAgGu2y33tuJoTHAP8VJk5gblcn/hGCrk6kDy+8G+yUZ2yEOSfEbsLH
	sAlTX88A6QrKqiSRtdFcExFN1ftnjCGFfpmh9
X-Gm-Gg: ASbGnctZH052C/ZQwLrSuuvYHQEBBcjAM+FLGYUZzsfci3MratIjbeIPFSnutZeOtxG
	aESCtcQKGSznEYUyN10cqw8IxPOIcTsmLtnkfeDp1zDQ93bSx5KA6tTpGYUP0ec3y/E/vLrQ+LY
	M/IdBcpKxTHYrBPVcdNzxu01J4YYw=
X-Google-Smtp-Source: AGHT+IHooJi+toMZzU34UpvZpQN12onTQrE7RJ6EGpciFt65M9cIektFHfEiQcxn19hTRXYVvPqlYBs3LU7ABqSCJiY=
X-Received: by 2002:ac8:7f0e:0:b0:471:9480:a14b with SMTP id
 d75a77b69052e-47215bec013mr4381041cf.12.1740067306032; Thu, 20 Feb 2025
 08:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-6-9bbf57d64463@google.com> <da1c3dcb-5296-47bd-b5ed-9cb8833377cf@arm.com>
 <CA+i-1C1VjdMb6YLEvORkZhiqVCE_G5BphJmAcr00U6KCfC7xtw@mail.gmail.com>
In-Reply-To: <CA+i-1C1VjdMb6YLEvORkZhiqVCE_G5BphJmAcr00U6KCfC7xtw@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 17:01:34 +0100
X-Gm-Features: AWEUYZn5jQYXZnAzrw-ROi-YfDD7dcdvcVZBy_GodR3_QHZfRC5arYIJp-Gr774
Message-ID: <CA+i-1C2_Ooi59HEmVma-=XF99eqHa-uZwd7DL21VtAvPg3S1EA@mail.gmail.com>
Subject: Re: [PATCH 6/6] selftests/mm: Don't fail uffd-stress if too many CPUs
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:55, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Thu, 20 Feb 2025 at 16:48, Dev Jain <dev.jain@arm.com> wrote:
> >
> >
> >
> > On 20/02/25 8:33 pm, Brendan Jackman wrote:
> > > This calculation divides a fixed parameter by an environment-dependent
> > > parameter i.e. the number of CPUs.
> > >
> > > The simple way to avoid machine-specific failures here is to just put a
> > > cap on the max value of the latter.
> >
> > I haven't read the test, but if nr_cpus is being computed, then this
> > value must be important to the test somehow? Would it potentially be
> > wrong to let the test run for nr_cpus != actual number of cpus?
>
> Based on my _extremely hasty_ reading, the variable is misnamed and
> it's actually a thread count not a CPU count. I can double check
> that's the case and rename it.

Oh yeah actually, it's only misnamed because I made it misnamed. So
this patch needs to rename it for sure, thanks for pointing it out.

(But yeah I upgraded my extremely hasty reading to an only hasty
reading and I still don't think this test cares about the actual CPU
topology).

