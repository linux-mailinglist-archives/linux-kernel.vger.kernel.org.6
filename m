Return-Path: <linux-kernel+bounces-398963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AA9BF889
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36681F22D44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF6120CCEB;
	Wed,  6 Nov 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5qIyFoT"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908420CCC8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928783; cv=none; b=p3/hM6E6oN3wZJYBKxcj2fXCM0MIFZE56t1FzsAIq+msBQbiVwQ/wumGe7rFMUfBZudZxkEb2iH89qPIMeybrbrNMP/TImV7wDwuz+Bn3/JupYItO6oDigY1sMGGnog5kDRVIj1ik/hr8Grz2nUFlDSCotC6tz7zx6IdPDptvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928783; c=relaxed/simple;
	bh=sHLct7j6CeCwe1r7QelhGL46u3GboGFISDKnimBW0T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nD0PKgxZ5922u/vCHxfXaI8PkkRxMwh95ojYJRAMU3Pm44omxkwO1GAyjw6ixQQ1IpCwBSVOF1sHNHcXjta1AFVe0Z202xsVxwI6ri0CWpj9cq/7f+ZUKuYyskgtx/SI/OAtzHvecRbDCW0FTvjdtkRoHpGM4y8a1I8nfcfjlpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k5qIyFoT; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e690479cso162356e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730928778; x=1731533578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAX/n0sDS3g6Rc7uGT4QR/sB6fFBeeTqhNmT/weL2kc=;
        b=k5qIyFoTzbwhGq89M85i0fiyfY1VFuyTAlVReeZ3WVTJX4t/Bo9HvqPJ+afNnTkPNk
         39TDh5vrWYHQB5vfJBolkw01Jch7fVmRvKnaxDW7vCyE5JLbhEC6YVaoJaSL7hdOrlNn
         qIHZdYTrv5DUd3Wf1aAx1rRF/MaYzT/d41Wcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730928778; x=1731533578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAX/n0sDS3g6Rc7uGT4QR/sB6fFBeeTqhNmT/weL2kc=;
        b=CGkyJH//gxCEXFGO+LKFEp5KsChr0pePt7/gV81ytfKSMALIc1NF/hOlclfqfwDVTp
         5Ng+dSEbo4GVcMEISMD7dAMUkyFznyyWJvm/d9FcsB8/3JO5O59sPji2sKvwhrkboAkx
         0ju2sc943KinpTQmStedEHG69DSiFqB7LLu1ZRqu70PTAgDXPqqyAeti0GjzDJeN5SCc
         S+IgpQPNkn2dm1m7Rt/gDMWhCjZPsZZmW5uYhy5sB3hLtSPSRXB8r1OluzaDCfLpWwGL
         DaZD43HuqORjKIcwxHsLLRfMbFxXro1VRi0wDyUyEeNwnahjZoeVvwdSzMDu5k3Nptbx
         rSog==
X-Forwarded-Encrypted: i=1; AJvYcCWwMchum76PO1t677qUYNUOAbq0eFP7eBVi/zgxLONDc2cLhFCPo2UU1dGFVlyVXKu0vRNFG7X8nE5EmBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVP4IB1F1nMVNjMtVZlD8YynXL7lD5bugYvzAamI6ix7tp77DV
	FGBtst8qG9CDqlWBgVjhsHE1ZrkYb/80YOVzHqKXCRo016MTfg89SvPbFiYOQ4i10i8qW8HYCXq
	TjA==
X-Google-Smtp-Source: AGHT+IEy0qV8mc5gU9vL/4mw5f1auY/b0m/1tExfFC+v0myihTmx2WPoQUgj3jmF4cC+hlEAxLbijQ==
X-Received: by 2002:ac2:4e12:0:b0:532:c197:393e with SMTP id 2adb3069b0e04-53d65dd1d6emr10672059e87.11.1730928778162;
        Wed, 06 Nov 2024 13:32:58 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9bf71sm2612347e87.93.2024.11.06.13.32.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 13:32:57 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e690479cso162313e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:32:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQRIWTtWf2b7v5pcn9xyVJvTcdLPCACK9ifig0eaZZlAqzgIhcSBPXBSJJYpi9CJFPdhOuog8Z1tyqLiI=@vger.kernel.org
X-Received: by 2002:a05:6512:e88:b0:53b:2114:9283 with SMTP id
 2adb3069b0e04-53d65e1729dmr10807604e87.51.1730928776381; Wed, 06 Nov 2024
 13:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org> <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
In-Reply-To: <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Nov 2024 13:32:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com>
Message-ID: <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops breather
 and eject BPF scheduler on softlockup
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	sched-ext@meta.com, Andrea Righi <arighi@nvidia.com>, Changwoo Min <multics69@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 5, 2024 at 1:49=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On 2 x Intel Sapphire Rapids machines with 224 logical CPUs, a poorly
> behaving BPF scheduler can live-lock the system by making multiple CPUs b=
ang
> on the same DSQ to the point where soft-lockup detection triggers before
> SCX's own watchdog can take action. It also seems possible that the machi=
ne
> can be live-locked enough to prevent scx_ops_helper, which is an RT task,
> from running in a timely manner.
>
> Implement scx_softlockup() which is called when three quarters of
> soft-lockup threshold has passed. The function immediately enables the op=
s
> breather and triggers an ops error to initiate ejection of the BPF
> scheduler.
>
> The previous and this patch combined enable the kernel to reliably recove=
r
> the system from live-lock conditions that can be triggered by a poorly
> behaving BPF scheduler on Intel dual socket systems.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/sched/ext.h         |    2 +
>  kernel/sched/ext.c                |   45 +++++++++++++++++++++++++++++++=
+++++++
>  kernel/watchdog.c                 |    8 ++++++
>  tools/sched_ext/scx_show_state.py |    2 +
>  4 files changed, 57 insertions(+)

If someone more senior wants to override me then that's fine, but to
me this feels a bit too ugly/hacky to land. Specifically:

1. It doesn't feel right to add knowledge of "sched-ext" to the
softlockup detector. You're calling from a generic part of the kernel
to a specific part and it just feels unexpected, like there should be
some better boundaries between the two.

2. You're relying on a debug feature to enforce correctness. The
softlockup detector isn't designed to _fix_ softlockups. It's designed
to detect and report softlockups and then possibly reboot the machine.
Someone would not expect that turning on this debug feature would
cause the system to take the action of kicking out a BPF scheduler.


It feels like sched-ext should fix its own watchdog so it detects and
fixes the problem before the softlockup detector does.

-Doug

