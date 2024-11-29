Return-Path: <linux-kernel+bounces-425943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F289DECCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D339B216FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB61A0BFF;
	Fri, 29 Nov 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FZXadmU3"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D95189BAD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732914406; cv=none; b=L8W+fGrSgV+TfyjM3Mc1wDeasZE4iImuQ2rDZbbDYKPmKBAvrMKkk21T5aL392hNzNp/euHAxuGpviVT+P+EiJv9Bm2JBh49O2IlUCTzxnIWGw2rTVDP2ssiAi22qJ3so8JGRTjGCagRBzElSw/s6X1+extkvPI5OghtQBCzsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732914406; c=relaxed/simple;
	bh=lzNRaVJaJp2dzBZ6WM1499zCj89Aa4u1k1tcAs2WbIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUJm5qjScE5Y1FCiGDGqoVCLHPKZw/365Ax10aH6k3TxoXiTzwQchd+44VOrtheqM4/KsUmA0QKPJ35G6KMM7EpXSYovpcRuXp2aZmQIRuHP6G4BW2LkwzKQS68CAmarW8vxBxj1L0lQtDiAAFQy1vxVm8X0hTH73eDExbR3O2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FZXadmU3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa5366d3b47so329903166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732914403; x=1733519203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZSitS3zyNpA94USiEVzv1WV1TBBjL6Dz4RMgR2XZp8=;
        b=FZXadmU3N40Y82gMt1Fpsw79YyeGb9i3okfQTCzZaJtfQb206boSjDMq0l9WMBQati
         adC7avzFt2hpz4oW/HYt+UFXRNCJDyt0lMhNGBcv8+IiH/RP+jKMKisiIdZSL6zxPaev
         6r3HAKJGBHReLSi7c2C0w9WPOfCYV9TTvslort1oIVXeV+vZ1x3NyCTlO52iL9/6qHwP
         cmpGzxqVs1sQOkX+GysBceGzhmWC9FSbOpXnMjLpWQ2H2WYTeQi9HgBBykJ6/zV57hxn
         QJAzJ5YK5lmFDrCh1yWK48lZbxuP9YJJmP9HS7YdkE9DBhugl9ezbX7tAwoGjNjD74Iq
         5RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732914403; x=1733519203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZSitS3zyNpA94USiEVzv1WV1TBBjL6Dz4RMgR2XZp8=;
        b=BJNE4Qc129ThkP2niEC+ONtIw+8HzwlVW/joPwixRODOsYLDlBHNe3rJdKSNNVJbNn
         aVU/hW5EdvbSX6yPirwj/l4QU/AxQ28NSzeiXXHg2X1WDto4cJmKdlewVXm3RmxWz6Cf
         4tEv9TfqUVrWnE5ixh+A8K9z8EEwvyxWepYNHRMFAf3WnVzrrCCbIJA/vSd8E/N2i3C+
         eQ4aftxxQZgvIdkuZTPar+p7ulVmFOITOBUDShIneB+4Bh+UhXnRYwspgyRww2hRarbp
         waxH06NM0UxkQxb1zEuEHINuRp/UOkow42Ps3mPzYwUXscoPaJpvX2TEHYONcL74tNkr
         aj6w==
X-Forwarded-Encrypted: i=1; AJvYcCU9z9u5iMZHQmLO0JY0gHvByYjOLFBo3bxfD5QbQMx43+kXkCoDXNXI9tpXX1oinoO8rKZeW1GPha0XwNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGv3WaSVNv+RB8+XIabXfczbl2e8OsyXi/3DOtybGpJFBhlhDp
	TGD3w2OBhAPVRIMKEnDsi8qWkkV9Rwrrstle/wcNnKsxNho7rIEYrdWiL7kO6DoOJSOuDOtuqWI
	D+3iPQw+Su3CQ8266zeLYqr71coIC+QTkHlt86A==
X-Gm-Gg: ASbGnctZkUpGr1Cfdw4FDu73bqVQvw9+k4mww09xns/CMZVMMHUUq5vzXZDeMJvgpim
	eaz0QV8OfzEnID8YOXPShp3kNNM6WYTmLTbd8dN16czzEiUdd7bNGO/TRxAHf
X-Google-Smtp-Source: AGHT+IFFQ1ppSleB+5O9jB2zUGGpHTd8sboY4WGdSMJOjNUHLd8vEIxJUbqGBGpA5TJKSfoSypAwnC12VceTC1y4Xjs=
X-Received: by 2002:a17:906:18a1:b0:aa5:48b1:d282 with SMTP id
 a640c23a62f3a-aa58103dde1mr877608766b.37.1732914402947; Fri, 29 Nov 2024
 13:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk>
In-Reply-To: <3990750.1732884087@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 22:06:31 +0100
Message-ID: <CAKPOu+8dBuoCLBAbge+TFCOz4Rtyo2Vx_PbXai+BO19HX-9S+A@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:41=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Could you try:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-writeback
>
> I think the patches there should fix it.

Confirmed. I have merged this branch on top of 6.12.1, and the problem
no longer occurs. Thanks!

