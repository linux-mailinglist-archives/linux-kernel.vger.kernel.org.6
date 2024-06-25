Return-Path: <linux-kernel+bounces-229101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA999916AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2825C1C2332E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACCB16EC07;
	Tue, 25 Jun 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxMeH8Ee"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64416D31C;
	Tue, 25 Jun 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326893; cv=none; b=PANcA9wiH3LzfgiaSBDbqNs0p2SVUWYjsPzJYtPgwXkVX2CE+qUxmnhoJLjFijwqirmw0TXA+b2hTy2xuQYx3/qWWhdmzjZNMVck8xXWMdx2ncmWRXNB3t5uNUPUSxU3chZJD/S03ZtigDapjgY9MbwGYM4bFyPopC/DQm6pEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326893; c=relaxed/simple;
	bh=v3xu1DyFwNeeSa36sjEB5FbyVITtkfo92n3t1SkftD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blry0D/EJAccDFzaXI7KvaJmj+Uj627SX71lmltnQO60UFt/p6F9O0G6jFIOLmIqM58TqjRKphlTVvOoZJ5biu1xX40kM03i5oLZ+bptKsuGmNp0vfUL0UqpJyypGRQVhOyyUgoMQHznOVYrYRkbG6cZECQt15lZSj5syJvw4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxMeH8Ee; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c722e54db8so4336044a91.2;
        Tue, 25 Jun 2024 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326891; x=1719931691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOLeFvsL8kaSRtWwF8htq+fPtKSdafeifT9BbsLcc+c=;
        b=VxMeH8EeYd+dHwN4o9Wkepbum4pB2/xHr/Xd10552ow2zNAjd9EnIRllF5co3x7G1F
         Q1fLIobiIfftmHg+ICkFst+wVRBOPBWYFDKJsQt1Ja3mHwN0Tc4fGOoCSlLzAGqU3BuZ
         34leKiCgQHTHR5TTRnuO4d9F4bzpygjWm9j7Hi475vlSRBFkA8ziHlRJf5+f9Ctt/nrk
         8y1Nc+WCmlLecP1oKUw5drBpMEjvc2seok0Cfuu99CQ/vgosqV4G6JmCXx066nbhGkcQ
         iVaoC64/FubwKDQKgxqGMoCGldDPq1EHcHDQIz8HpzxWkStshQQPsaqn5NDcec9ku5wc
         3pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326891; x=1719931691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOLeFvsL8kaSRtWwF8htq+fPtKSdafeifT9BbsLcc+c=;
        b=fHCAGANh2O3GUG3jwWF18KCSx7y8AghRFqBxoBQzPvud6gRB9lWqxrjzK4XHRnbpMx
         WzmRFJzFmR2x68f1BIxh5aLgfaw5caj0/OFnXaGatIEz8FwsfSq+PV5gqFpW4qwu2AD1
         1R2+3jjcHaHIvmM4LgX/wHklZhsJqmBayWb6+sBKms4htqhNglR3l1ecWNq2UjFQFJYI
         8BqEcJPCygjLrpPjy/caIVyXswPJTO6pe5u1PIzCAkUuWeZvhk/a7eG3uJ0MdZDNYnEH
         CRcVMvIcO/wtsxP+htzHF31khAmOaA88Hen04r22+LMhBKDUm4wNrtQM0B0/UH1afuHO
         wtHA==
X-Forwarded-Encrypted: i=1; AJvYcCXTeUathw0p9qhAFwOUsDD+a/jfqx/1JVnIJKFKD2SpKQ8AL/2hk7saNIK3lIBYbW4a20ivKbYNd5IkaclkNXHgyGHse0OctWhtedlJ+cLOZCX2QfE28l3xViq7fiSvh3asxHCp6Dp4G/M=
X-Gm-Message-State: AOJu0Yx5mkzLHpLVE/qKaSFVVXRjO3pwoV9uDVDm3UaJzbIY0egE/C39
	h8+UyNtrDpA+UsZJ7sMrLloJsR2zBsfBAa3F/G2Lw+lpmBmuLg0Pa2+bKRZ9w/G1XvmjAzLIXze
	6SLKvUl1jbcaf0kj7LwDVOzwc20c=
X-Google-Smtp-Source: AGHT+IHax0feeXZDhhj1vgHv8F+uvxmxFaFY3EcB0Z+QwjASVPOeq3SNfifA3ETfuRKkRYInUfBM0vmfIqxQTzvpnUs=
X-Received: by 2002:a17:90a:df08:b0:2c8:431e:4105 with SMTP id
 98e67ed59e1d1-2c86140975dmr6924152a91.26.1719326891318; Tue, 25 Jun 2024
 07:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615125457.167844-1-rauty@altlinux.org> <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
 <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
 <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
 <c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu> <871q4lm9dp.wl-tiwai@suse.de>
 <CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
 <87tthhktdz.wl-tiwai@suse.de> <87sex1kt6t.wl-tiwai@suse.de>
 <CAGpJQTGR5WKuHUFGFUC286TUkOXYgcqigZRDb4K5deyE9uuz8w@mail.gmail.com> <87msn9ksj6.wl-tiwai@suse.de>
In-Reply-To: <87msn9ksj6.wl-tiwai@suse.de>
From: Rauty <rautyrauty@gmail.com>
Date: Tue, 25 Jun 2024 17:47:34 +0300
Message-ID: <CAGpJQTHajQnOr7Tr8cmMyjBqGw1sg_-SwSuAhnz-yFHZdPukGw@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
To: Takashi Iwai <tiwai@suse.de>
Cc: wzhd@ustc.edu, Gergo Koteles <soyer@irl.hu>, alsa-devel@alsa-project.org, 
	tiwai@suse.com, perex@perex.cz, kailang@realtek.com, 
	sbinding@opensource.cirrus.com, luke@ljones.dev, shenghao-ding@ti.com, 
	simont@opensource.cirrus.com, foss@athaariq.my.id, rf@opensource.cirrus.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 17:25, Takashi Iwai <tiwai@suse.de> wrote:
> Great.  Could you also give the one for IdeaPad 330?

http://alsa-project.org/db/?f=cb04b699a8aaa07e0bd992dfc92accb993dc0a97

