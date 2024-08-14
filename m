Return-Path: <linux-kernel+bounces-286815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE20951F53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F06C1C21647
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD0F1B8E99;
	Wed, 14 Aug 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHkyKq6n"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB391B8E92
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651360; cv=none; b=BPR4m1REYNp0upDy0tpurAz5+V4YarTGKW1xpENhJl0n+KuFRhdNl8VVSQIgyJDyLweVqvckzSj4tVbw4hzCVmGVK01TD9HtfcwHvDRBYVLfDZthXI5nhWBuRu2/r9zP4cY6bV9vVSA4IDGPjUivgFhrmEXWq8Ks5bZO921CY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651360; c=relaxed/simple;
	bh=SgzYHcEtxjrOMTvu04mnfVZFW3OCHaTTPgcQVwqBV+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLmSgUAyj7tPkuXJeIx+DkRUMAFg8KSjPvCVtv5c2F/oUsrPR4YYGPVOBRNoWwj2XJOw3gscGp9bmvBuy49PdQx4Ca1Gv7/SygNDSHb5+LfpuWH0dorojO29immTTrQkZqDT9xPejLjqr0j/DUUjc+lTpbr1O3PH/Ys3SBBdHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHkyKq6n; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d59e491fefso21829eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723651358; x=1724256158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgzYHcEtxjrOMTvu04mnfVZFW3OCHaTTPgcQVwqBV+I=;
        b=RHkyKq6nC2Pjz3HyRMwiFRzK3b6NCXn73ANyepTs+HndooUc+6wfJJM2q9LtOM2yn7
         2/o57Q6fnhC73YHOa1o0sDFtIp2PIYx0poDbUZY719Gw43kHJm8HtZmIvhcZa1v32x6q
         8s8Do8zuWK386qs21he3/Sj0shfRxOQN2yCeGSRDD192QIK3RLVgVidfPoKZSvdfCtMd
         HjBc4NgZNF+x/1PFq18Qxc566wM8v3fG+1ocs4CSu5PbZ9qLEBp0HnZlifhZPMGULcfa
         XzRO3imLNeFLaa/B+fX1+5UZJLWi9MUthAUHgrIBVuSEy2ZrtNO95JdwHxxyM0r7Y7Qv
         ibzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651358; x=1724256158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgzYHcEtxjrOMTvu04mnfVZFW3OCHaTTPgcQVwqBV+I=;
        b=u4vRFIb12PGSd3f6Z841yP8eGc+2unY8CnNx1SUdI9HqdH0lCs++mAkSrk6decuMs1
         JDYy50Ft9ZWZ1xR7e1dr6+YUi5g36afvpiZDingZLCU/XKa2VXf+GKh1zK3LoP+N1ihJ
         mQX9nLoyyb2o6iVqKTS/wzTAQsvOGhDbD7qAPxEJ022/KsxsOSjb7jHnjRJeJbKizKa0
         udp1XEia9jSSfqqHFOyCo+fyUV4eHw2M8GtEkUYufZvPQKCmrNxktil9HoWsB885vLqx
         yXZjQGJpPNtS6bRMmvfEkv6RWid7L0gWT5fyjC5jRSv7YH3hPshks/xoNa7mjFcHOVxY
         c9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7r7ARvgF9u9qs2ThKm8viIeweje7wykn/yXyVkdn7HdpASe1HB9qwuWQB5bc45vjFLxEU2AOgQo+Wyy1NK5jKSHgpeaw4yimVDrhx
X-Gm-Message-State: AOJu0Yx9Hib60/Wq6lEfjlQrWfr4GTxURs5637P7rMpBCNTSP/OPSwh+
	V7hLmYv4bBpUNU6Sg/FTboYELNrZEvuX1zUeP5dOvj89CZzaTMVyMc/HzsDfXAbSReO5rDNHz9V
	zCPFWM3/rJDC4m+/gIjkEmCbazOrJzk7StGSx
X-Google-Smtp-Source: AGHT+IE77wuNaF2Yi93agRWiWP0Umbs+WfXW5TZvz68ihKfYPVvsZAD2QSgCRBhsAd06Bji4Za1CvxRJk+4klqXNZjk=
X-Received: by 2002:a05:6358:2496:b0:1b1:a8cd:6d0f with SMTP id
 e5c5f4694b2df-1b1aab56dddmr304251855d.12.1723651357172; Wed, 14 Aug 2024
 09:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814142647.3668269-1-usamaarif642@gmail.com>
In-Reply-To: <20240814142647.3668269-1-usamaarif642@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 14 Aug 2024 10:01:58 -0600
Message-ID: <CAOUHufasQ5019b4L6R69-G=k-dCa1WuC5g6yGfYvzNOk4Au_iA@mail.gmail.com>
Subject: Re: [PATCH] mm: drop lruvec->lru_lock if contended when skipping folio
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, leitao@debian.org, 
	huangzhaoyang@gmail.com, bharata@amd.com, willy@infradead.org, vbabka@suse.cz, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:26=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> From: Yu Zhao <yuzhao@google.com>

I think in case the patch should be "From" you, "Suggested-by" me, and
"Reported-by" and "Tested-by" Bharata.

