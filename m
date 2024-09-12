Return-Path: <linux-kernel+bounces-326569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A786976A33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81B71F24246
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB351AB6CB;
	Thu, 12 Sep 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdwqLfYt"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC341A76C3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146851; cv=none; b=DZ1YWHbr/jMSVmQuK/6yWsMAW2+pmsbyuZXIkdw8E7D83TdXIIJmEaNaXj8ClnXPcEE4K/IdAEko8WW1LJY/cpB6yjKbb2fE42zgjJvvGp8jESY0hy+h2Wi9Bh4sDU7XKbh2EV9cDgy7Xlz58sPS63b8JWsZImXb7beXqs76GUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146851; c=relaxed/simple;
	bh=EahhHOZt8keeU4ar/K3KrCm52yfxkzfLyfHmsF6kR3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRRUT0uYt+yw6epxFr/buEOvsbTyPmAQUN8GWzXtTUL8l6q59EW9qMV3v4f6ydjeUeA3Oxn9zhmRlC9joHHxJfh9wjqb0Z98IYUcKnuG2vBiI7nfScDvoetRD7wASivbdrmlhxUZlXZ9vp7MMmgbBjD000ErEON/rdBE3lcnyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdwqLfYt; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6c3f1939d12so7374607b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726146849; x=1726751649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqZthTFDmLUBDICo0tY9ep01KRkPGioFv1nuqT38niQ=;
        b=BdwqLfYtVFWVw9pOzr80hvnMV1wkEhIp1+7W88IjrY1XrbTVFK9nz5aKEGDXGpAFF4
         UudSSMSkDE+pen8CFuJ0QE9n9rBr/gbFl+hg3Ge/KtLCqTGhaHqyUo6YeSZFE3jdFKId
         oh7O/CF4Xd7t4JFYj5vefMp2XqZOVjJYc+Gv3Qvm2UMmc1nmmqgesAqsV9G17cfmO/c8
         YkGCXJ7qaTzFiLXaRuI0G3J2P5ulHaEWi+WHZItoa074afJpVN2lAnm9Wu5g/5C6mcux
         IfgoDu6b/47Ffyq0Sr7jYGqEY+Su6uvMWuDtLj9uB32TGsxc8RSetTuidZ2Z/Ek5W+Tj
         gFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726146849; x=1726751649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqZthTFDmLUBDICo0tY9ep01KRkPGioFv1nuqT38niQ=;
        b=govPRGA7WH1I7J0qL8qDUvjHy+7Zd9K1tMpu80SmdXBXfGfsU4+4zI/kVsLnq2hcoM
         tIg1Xjt5wx0IYCTDOKBhOchMxjooGZYyuRkXJGqY/eYzJjQigcfwYtfQc2E/jk5QdBUO
         NittSoSFW2TjLeouUyZiGZLk6PP5LNxKziAEGlt1Nve2RWNmuH2X9quJSrejThf1z4MP
         xPlgBJ7VVvfUJR3MiAwAhiWL1s0+qe0rKrBrwBryav3qFtFPXj4Xgs837kyhFFgTH+hB
         sSWy7j6J4j1qV5fXSZDF+xcSp58Bj1jEyhexK4v+kHiI44mC1B6rjdknd1Lh9FJfKACC
         k8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUa9Af/mg2OvRPBrmVZKb6xhjthAqMalWKH4mq92cxH3LEMPJ/6IyTHPnJMREfzXWBpllXumur6ipVycp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGwMr9JhIP28MrSKFS1xYkSAFFfEzOBVd+aac1P2TlVl4pW6+
	cuqZkgAtFNY1Ge8yTEI3OXRDQGJaGtvCzU9GXoJybnhX9NwDhv74M6bsVonzhO/IOnFdOq+uAq0
	OZNGZ91DxbnxZXJi/ux9dNkk0tSIFEUAgLqry
X-Google-Smtp-Source: AGHT+IH1d8eCzkBWXAFxzhfG/a0ZEazgbphcGtDN1lb8mUPmfqNakNE04uuDzX1r3b0WC+e6GWV0vC/FOmDvoreDt3Q=
X-Received: by 2002:a05:690c:4442:b0:6af:8662:ff43 with SMTP id
 00721157ae682-6dbb6b9da3amr26148847b3.37.1726146848448; Thu, 12 Sep 2024
 06:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
In-Reply-To: <20240912063119.1277322-1-anders.roxell@linaro.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 12 Sep 2024 09:13:30 -0400
Message-ID: <CA+FuTSeFg5AcSxdp4AKi4iPROF8r2dy2BhaMKpCrFD8FM3G=Ug@mail.gmail.com>
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
To: Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Network Development <netdev@vger.kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:31=E2=80=AFAM Anders Roxell <anders.roxell@linaro=
.org> wrote:
>
> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

This target is automatically built for targets that depend on it.

See the commit that introduced it, b86761ff6374.

+++ b/tools/testing/selftests/Makefile
@@ -116,6 +116,13 @@ TARGETS +=3D zram
 TARGETS_HOTPLUG =3D cpu-hotplug
 TARGETS_HOTPLUG +=3D memory-hotplug

+# Networking tests want the net/lib target, include it automatically
+ifneq ($(filter net,$(TARGETS)),)
+ifeq ($(filter net/lib,$(TARGETS)),)
+       INSTALL_DEP_TARGETS :=3D net/lib
+endif
+endif

If you believe that it needs to be included directly, please expand
the commit message with the reasoning.

