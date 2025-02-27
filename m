Return-Path: <linux-kernel+bounces-536765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C40A48420
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED51E18966FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B31A9B29;
	Thu, 27 Feb 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaSW3QPb"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740A18DB35
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671676; cv=none; b=SGDI1iDR7ML1Dc9rParlHjBqHwkaCuxktEJEn+ptNiIUHUxzLjvT9+vAIlo2q3KdNRPAMpvLSRjCPht9dwYz8oR2nvHg2lTynd1V2Q4N3Xgp4HB9SOzoejlZa/sSP7DB4N2tf5E3UeRXIm3RsJ2Mbkbm0ztSzrQmHfvT2OHTzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671676; c=relaxed/simple;
	bh=7uhfBiSkZC0QvWBS1DwG+AGPCBDD40dNd7OL5uwcIS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObKJ2VVIZ/4ha8oBWTcxXJJbrMucdmzNAiRRx6h2DgFZg7L+6lsv7hzPK7zvS3DZ2OXqjokczTLdz5Wyqgtrtr4TPAeiy908lf7NqkWP+mq4fmb5blqt26esFkTLlUzC8zTrRcswZAS4cxA2oUp5V3pVsgxnZfHbtJRtSiKlK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaSW3QPb; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5dad00b2e6so919553276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671674; x=1741276474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9bPGz801kkJn9iCmpXJNDNqMZZQ/9mEdp7xfOKgRlg=;
        b=iaSW3QPbGUguXlDZ63O5gN+eF/xvOzvwOWoWRXRFtczY86abzVI7UpD9fwe9XPJGPx
         5UhixODvwxH6z9GKxH0NPmK12BysdlXc97582JfXmooHYTxQgtsyZm94mj/9eAingNUl
         KUKAsO9ujvB9wtIj9OahQmxHAGgwjnJTbQgXJrE2k3Zni2pNZsyztLFMBIhS7iuhhdOw
         /YLCy08vW1RyE2OWMonwnxRIx8Q/YkbKw6tARMDyxMFhyI04yuDQMzRYn8ZnOnRr3kyg
         kLYSL1JtfOLAlT2Lew2WlBQPJP+dK5LS+6vNAk2cQK3KX8LdFXV/hfhzG2otEzLukTzL
         Y3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671674; x=1741276474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9bPGz801kkJn9iCmpXJNDNqMZZQ/9mEdp7xfOKgRlg=;
        b=nb9uuFX0dp4I1ZsDD7l6OkzJ9FSucjp/ypIfb04YPw2rflWRnGb87eep1vW9T1aQf1
         fXFTnEd9XqpyOXSvJpeGTLpqYLfyxdB2/ujESDo0+wrm1JbqG0b/81kF+LiREsntDxlO
         kcCoB3NdTX9GSZL3s8bJYGGVUy84aIbH089Alp7Y/Jwg1CFB6TjNBfk4rTPbggC4LPsQ
         Ib1Ij5A+vp55BSaQPi7aNoZNj0SKwX4ZzcfKDqYbeltgHSUBRabIrJDlkSNLgq3dqwjD
         WEDl6RzJfglQmZIXDsIca2kNUVcM6m+59oQ0TvsN65Zx+nsObOH4ojoQ13lMcrWJC2L3
         K7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUg1gKnLTtI3+nNMrD3eDn5ONKBW0mbOq3lcTZi/gtxDoBIEvCG86xhz2oz0zY9dBPYgpWvoEGScAeL9CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxDJ4QV6mmkGTmuZ9DImTHShR3Xbtsx/E82+AvMi2ftCyGopt
	B3UwLPzDSqRGl/vLmjFJivRrmXZHLUnMT4XlU0gu15nlZoFrM4ZiDyYhRg==
X-Gm-Gg: ASbGncs4sBiDwSzwoxGNPW9dHL26tpxv4LQme/RsibIT1UuHTuyALgAYUvqT5FdwENF
	VMx2AH6gEoHcLLIwm/2mcl8s4emirr/depgvfe9F2huD4cqjPmRHpJWlCjcAtnrsgeblORCt6C3
	oo4KU/a09MCObfxx3grwk6IcomevB9jMhDup8b1ZcPye/OUbXbmqwWb/l0QYLecqHMb2Eb2WGQO
	Oo2pioCC0gEyRKwuiluZMoHSjM4ME2QJ4T+CRBdBLS0JiS92Fc82aHW9C53/zzu9BGIcXLb/Mcq
	5XeweiUPBvyP4GY8cJLVfxOV
X-Google-Smtp-Source: AGHT+IEyUGX+brDFTVPqVNnaqmRxpEeAEkMEQ5dJKaTLcNSBoGci/hww/51VAjvABsiCCcykiSU0+Q==
X-Received: by 2002:a05:6902:1086:b0:e5d:c0db:b3de with SMTP id 3f1490d57ef6-e5e2467a803mr21518743276.34.1740671673643;
        Thu, 27 Feb 2025 07:54:33 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3a41ab9sm520515276.27.2025.02.27.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:54:33 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: ying chen <yc1082463@gmail.com>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory swapping should be prohibited during the global reclaim process
Date: Thu, 27 Feb 2025 07:54:27 -0800
Message-ID: <20250227155431.2534325-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 22:34:51 +0800 ying chen <yc1082463@gmail.com> wrote:

Hi Ying,

I hope you are having a great day! I wanted to share a few thoughts:

Previously, when the system is under a lot of memory pressure and is
facing OOMs, global reclaim can create space for the system and prevent
going out of memory by swapping, even when swappiness is 0. If this patch
removes that check, it would mean that global reclaim can no longer
"bypass" the swappiness == 0 condition.

I am also CCing Johannes, who is the original author of this section [1],
who clarified in the patch that swappiness == 0 has different meanings for
global reclaim and memory cgroup reclaim.  

> When we use zram as swap disks, global reclaim may cause the memory in some
> cgroups with memory.swappiness set to 0 to be swapped into zram. This memory
> won't be swapped back immediately after the free memory increases. Instead,
> it will continue to occupy the zram space, which may result in no available
> zram space for the cgroups with swapping enabled. Therefore, I think that

IMHO, I think that even with zram, we would still want to allow the system
to reclaim memory & swap out, in case we are facing imminent OOMs. Even if
the memory isn't immediately swapped back in when we are able to manage the
memory spike and see free memory, I imagine that we might not even be able
to manage the spike if we prevent global reclaim from swapping.

These are just some thoughts that I had about the patch. However, my
understanding of zram and reclaim is limited; please feel free to
correct me if you see anything that I am not understanding correctly.

Thank you for your time, have a great day!
Joshua

[1] https://lore.kernel.org/linux-mm/1355767957-4913-4-git-send-email-hannes@cmpxchg.org/

> when the vm.swappiness is set to 0, global reclaim should also refrain
> from memory swapping, just like these cgroups.
> 
> Signed-off-by: yc1082463 <yc1082463@gmail.com>
> ---
>  mm/vmscan.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c767d71c43d7..bdbb0fc03412 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2426,14 +2426,7 @@ static void get_scan_count(struct lruvec
> *lruvec, struct scan_control *sc,
>                 goto out;
>         }
> 
> -       /*
> -        * Global reclaim will swap to prevent OOM even with no
> -        * swappiness, but memcg users want to use this knob to
> -        * disable swapping for individual groups completely when
> -        * using the memory controller's swap limit feature would be
> -        * too expensive.
> -        */
> -       if (cgroup_reclaim(sc) && !swappiness) {
> +       if (!swappiness) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> --
> 2.34.1

Sent using hkml (https://github.com/sjp38/hackermail)


