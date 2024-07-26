Return-Path: <linux-kernel+bounces-262947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA3093CEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9E31C21A74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC6176AC6;
	Fri, 26 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWTow10D"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B945009
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979725; cv=none; b=dWsOfA/IKU9/s0T/jZ6AsNaZ3n3IwrbgBwU4J0iUGDGrh4I4lUu9KhnAB/h7DTDgjgiXuZzA/nRkJ6WeCnjGbKpgPWXyT6MxMqwK9xu+95GlJ2HOWn93sKiZANvHYL+i4VVwG1ROk1KP9W2F+z5t/TeFMwOTr9DsUHd1vjf6kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979725; c=relaxed/simple;
	bh=nHMnC/oHV63qHSPSA2oxdTfUb5muYGwzRVbmDjEX76g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHqWUzHVcI5t3pgSRcloIcsG3WPv0mY4uV9zRyhw7GH46VdkoQokixcWuGrRp9W+mUk80mOxwbFFYXbZZuviyxfDBG31MnMdDko68Vjt7H7hBCUyYPkyo+Sfrcq9B+Paqu5N6VXxYnbQza3pV2DQnnCgCFivFMBwym2CsY3Zd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWTow10D; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so6496a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721979722; x=1722584522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHMnC/oHV63qHSPSA2oxdTfUb5muYGwzRVbmDjEX76g=;
        b=WWTow10DR6SIJbq8HL3Ok4XNTqqtKc7txoP+pnRbBtZAeLQcXEmPisxuLIIDOMNBew
         oKcIpwqI9IoVEb6PrJjuRC1R5bjRzRLFJJcePPPu4ngquz8avtjbtvizY8beQXPaF35b
         fV2lUsq2CxKHMcX1UgRGI6ckri5pXQif6is7YrWnciNS1JbmRSWBAR7BhdSFEOqCL3Sc
         sOeemXsz/yYM6f8mKZF57d5f7uAJBWHMIwaA5q9IhOlNNwHwHZKqkS4xYLZZ+vyK8+ut
         7SKRFYLzvpbVsHvgKkvFARIJ1UPs7A24KW7Fb7pZVZzk22Uu6HHMi7d7eOPFYfAOkMIq
         Sb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721979722; x=1722584522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHMnC/oHV63qHSPSA2oxdTfUb5muYGwzRVbmDjEX76g=;
        b=ZpWp/IEXXeGAEko9xWwOe1upW19L5taiNR7mg3NWFzP+zCCh1p9N0oroY/Q1Yb7l3w
         2F4C5MeDpUc+aeFI0uAQu3wgJS8W1q3rpo9gP2EmYV6niGLEyXr5LmR6g+M3XOffahWE
         CA2jHG1yUybVOdo8Rz7xWYdsmZYmVaGqVugJSaNAKgogOwfhYr2ZpNQAKNtg82wR6bCy
         89b4vdgp1BacHcaBxlCKdcJHSiKZpCE/Ie/nFbRZSE3e9DT2w04mYLOPcTlPCQQ2Yzwa
         zOE71zUKpFZfXB0H0l5ylZci9mytbrVZRf6to1oLiHlJRXYCM4067aqTNhIAEIIDOMqJ
         bOkA==
X-Forwarded-Encrypted: i=1; AJvYcCV9DvNaHEBMxxerzEnLBHOHKE+q+vq/hNpna2Z+g5RMSsZJ6tpEE+y8Hc2zZOYMLB5Bh88r2qEsFqIBPvcDmlo4CgZiCincosiVIbav
X-Gm-Message-State: AOJu0YxBXlVbNb1EEilsHBi30mE7be0jP6Iqc+xJOHzYCRLXj+RY1m5e
	ryV2jf05DbduMJwctrafzcOzqeObAtkOoEeCkJ3ktH6g4zhmwgeFGWSwdEfGmf84Ik3ST0Ehx9d
	liJui2ljQc3zJlM8vR/naaYy4aBT9iTxCabwI
X-Google-Smtp-Source: AGHT+IGoQPZ0QMYNcCXbjqU30bTUmaZKQuSy39n0+FyRHD/OPmhVjFhf738bAp11QMIAWJNjtK8t0GWRD2CzbyWLWN0=
X-Received: by 2002:a05:6402:35c3:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5aed72f8708mr123178a12.2.1721979720698; Fri, 26 Jul 2024
 00:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-dev-andyc-net-fixes-v1-1-15a98b79afb4@sifive.com>
In-Reply-To: <20240726-dev-andyc-net-fixes-v1-1-15a98b79afb4@sifive.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Jul 2024 09:41:47 +0200
Message-ID: <CANn89iKNACSRA05bUM7xVc2vXAjh0jk6P7+b3TFM99mMW9CmFw@mail.gmail.com>
Subject: Re: [PATCH] net: axienet: start napi before enabling Rx/Tx
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:06=E2=80=AFAM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> softirq may get lost if an Rx interrupt comes before we call
> napi_enable. Move napi_enable in front of axienet_setoptions(), which
> turns on the device, to address the issue.
>
> Link: https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg06160.html
> Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

SGTM, although the axienet_setoptions name is a bit confusing...

Reviewed-by: Eric Dumazet <edumazet@google.com>

