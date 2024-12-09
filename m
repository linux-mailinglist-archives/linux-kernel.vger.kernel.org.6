Return-Path: <linux-kernel+bounces-437996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20C9E9B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D796F281D6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E313C695;
	Mon,  9 Dec 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DcfAbsvn"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A417F48C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761200; cv=none; b=UpfyxYjTwp0mBDqA1YNOLT2MmjPuoV2EfvBbZITS8alNcydC/qIGZ9MpLCdDvVJgbGE2o5QU8Cnpe6VdF+a/R6uRZ7ZZ4EaDWizLTAM06TUSjyz+hcuRpIGdzrQ1G/HwCgWNv5mKfON/kJAIE0wC88jU8YbaLTegc2fLSQL2OYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761200; c=relaxed/simple;
	bh=KQ4uitC/F9jnPBUb+btoMbbSFr1U885G91dElwBDeoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdU8oLT16OkZUYSK+eJzsBZJjttscVwhRrVuuFIBmsfAd6se+NMZ18Bmn8Tyfjp/33VfIhrOQoVsOH0xyvRSn2fJN2FCvhywnLfV53DbHkqn0fepMquN0Q4/GsEH5Dlhs4j5Ul3JYgV2X44timx7jibu3asidQGFl7/LIdq6MwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DcfAbsvn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa560a65fd6so823576166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733761197; x=1734365997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ4uitC/F9jnPBUb+btoMbbSFr1U885G91dElwBDeoo=;
        b=DcfAbsvnyWgBNEHIsS0ivbzsVJbjQ/bpSA27iEVjtM2LRxyRCO07es2A0VEg1DiLr2
         EOvFfTVr/Ydj5LomQTLJmCRJ1TSpFXRtABnLSTgbmvNPB2H8QmZUspvNMByik4MyMBu7
         uOooN7odh+djSsnIGY3wstdHaUcPYAimxCGtN2GL6sbHCYwANzscGCcVcsdOAZk7bs7p
         xL55MZogHUP/DLd/oV8U40nZzXsdob/lBTurLB8KqQlA+PHRhwpWMiTpAxhLoiN5+uHk
         xUkk9xllogbs8z5lk6NogDIRdmzrbQ8p87eus5v9Mq/eDhJzZJhPuNZQkh1gz+3LlpnS
         UXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761197; x=1734365997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ4uitC/F9jnPBUb+btoMbbSFr1U885G91dElwBDeoo=;
        b=gaNQFEYuLzBdu6WlN7dbYq091/ka6511/Ng3zKZU+6ZX/bQgoHJyp/nGRu3Dc/dhkl
         HP1fVNaVb/Ja+82TTwZBjTK9tWv58BGc8o3+jEq57M9MPBCn1rufiqkz/XxrZCG7+sIm
         i6TmWWMcCJLnsC2XvHadaMKyC7BRIlUh3h9eRlS1UGDedKO/xW7PKyyxWvxHFX+cQ12x
         Cu6Pm7w+Q72O800iAGN87UEcg+X4BNDyWEPhWb7IEyrL31DIv4dLc6tDSlWxxbo2gtDe
         fmnQjo96kJNVuRcF2zpR14JcVnnciPB2XJaNyFO84ofdB/by/C0Xxh69ZxmMnpzGG2aR
         eMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIDVrilxJjTWUTNoUYaHErwq14WV5cEJzHuMHYW65+9NipXpR6vfWp1Szk1zcFYUjYMiEp/cO4RG7Xiws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0Pz6RvvNNeuapFMGJ9KUnDcPXpuJ8kXfETLTdNCT3M0aRL+j
	6CvCjZosLX8Mu04fPP/jBzFOqNU145hD1hBRVqZDgdYHTXh2v+14MZkMWszYh7eDbkY8xK4c5xb
	/Oi5jDYGdzxc+wiQFUHnasCiQcvz+sshRvvRJ+7HgEPhQvs6UFDMfwQ==
X-Gm-Gg: ASbGncv486gsn2FfBy6/0z4JW06DxV5F92QpdcUykXHJqWfrczaa/a6MUUbXYuvW06+
	tiRWyX1LHQveNAHWeakTFrVd/MBlMmjyHmMJxdj+MuOGJX0lqSjh3nILKv3Ny
X-Google-Smtp-Source: AGHT+IG5j6CX7ksLi+fnLfDIMXcwXWB37sJyHak7p6g542WsOHweAQ9hXBgNTypD4LpJ/oR36IJikj8gKuElWQfQyrE=
X-Received: by 2002:a17:907:90d5:b0:aa6:832b:8d70 with SMTP id
 a640c23a62f3a-aa6832b97camr524912366b.3.1733761196967; Mon, 09 Dec 2024
 08:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209141554.638708-1-max.kellermann@ionos.com> <2133497.1733760235@warthog.procyon.org.uk>
In-Reply-To: <2133497.1733760235@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 17:19:46 +0100
Message-ID: <CAKPOu+8Q0tt+wto7Ey7HoG3TKKUNOxX6H49=iuCPqhscZiE3pg@mail.gmail.com>
Subject: Re: [PATCH] fs/cachefiles/daemon: parse the "secctx" immediately
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 5:04=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> You don't need a comment there.

It's a question of personal taste. The Linux kernel contains 500 such
comments (git grep '#include.* for '|wc -l); apparently, many others
share my taste. Of course, it's the least important aspect of this
patch. If you object to merging more of this kind of coding style,
I'll resubmit v2 without this comment.

