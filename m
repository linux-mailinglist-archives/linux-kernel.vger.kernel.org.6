Return-Path: <linux-kernel+bounces-290758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AD0955849
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DE31C20D4A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59815099D;
	Sat, 17 Aug 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="T2EXCyCd"
Received: from sonic316-11.consmr.mail.bf2.yahoo.com (sonic316-11.consmr.mail.bf2.yahoo.com [74.6.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB9433A9
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723903540; cv=none; b=Vx30bQvoiN2jHCZV+2a5UKnqYGpyUyvbHQgamYPFiJffP75m+aYkzXvA3YawJnLTX3ErWD5yM0JhuzSV/dc5pzXbdKgYXT/RR1qx0SXgvxO/1WmoR/FG2NuBTSxXWJt7UZJZj4H/yWXW/4KP+9amC82gS/GQ8TxLJyt2TcSUlyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723903540; c=relaxed/simple;
	bh=LMOfmlDdXpBY3qm8XJ0tub8Qleb/MCtijX8mOHycJlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCje7wsadP6MuovUXbP+o7cHjfwb+sGl6j7fglOBoE4I3YlWbnhdc2BLtv2VvlwkZmWs03aG43zw6BYQPVyjDbA+hSwbx9FPmxzHXgh0MNWSIEejR7Fm4IaZK9FnN5sETGGiD8TOItfM+LVaD7yszDXbdDnjqy/OUPKaG9dmtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=T2EXCyCd; arc=none smtp.client-ip=74.6.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1723903538; bh=vp1ZIKZj8k1K41caezVgW55kRks0QRPON9MRRH5jLto=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=T2EXCyCdVin6R4NdMotArbZXL/a0PUevCIasNqZPlZIyIa83sNXR0srD3DtImURXd2RaYhSmQ9wImvubVIAdPL5uUNbCtSnSIpeqiIfmZjxxoXzg4PlITLqgQuAofEr62NeVBC4N2rbRS9hcngosgUaVM2fkfYA9b21TLmxHWxeVx/xt0WzHRSHko5BVjnhXp5WU/KOm2/58eS2N9oZBIAcOzt2kSWSBgALnmt3SWGywL4+JHPTvoUnF69Q8RyE6jOAFpPi+z2bh0TEGZjf9yCGVey2pAcLX3RQyUiwMb+XNPVm4v1fRGbnYBs5IcYKq++/ZPRMrKV6+LFhM/S7gyQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723903538; bh=PLmF20U1FB5OC9M6aMFzN/8nhMVU0nExWfaQza9WzLv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YkxVAETtP+0eFjSzOfcYBQk/nDBuxQbNI5rQGfHVrPXfef6UJa+S0lr7TQEayhZcgMKPYyjV6XH8ph2gFcHopVUMwQdJVbf9uj2nwsJvfBbLgQSIoD1hc0Z5zJ37eUQxqR0D0VkKN/0vTtXMjBzOtLuYCxCS1KnrQIfXC354hTWAvaiRBZPMJoB9Wxle5dUuoYfFLflb0MIomW+2AOJwxrtF9EnfBUrrdzNgqYWJlCFAlYujvkr44rRXAz9Jv+UIbJoQZ86ZtJHQHMFT0NI0heQCGpOPXnyP/4STRaF/8J6wSqVg7Jg2Ovqk1HPqbM6fi6oWdNMSO4BqSz83iAK40w==
X-YMail-OSG: fGod_h8VM1nBhmyhLpaBQXflgGYNjJiP3oDUczVkdgXyqA8htvNpy6yfOwfh.3k
 TuRXz.B_.iGxMBfx7ghjMv79KokwhnrA4aEBFlKxNFy3iUmHxf2KFL7.GKcA7_QQJIIr90v.v._E
 _mREgBzmvR9cManPACqw.gvD2hCioyK9qtv9zTd18lgbKu_VnvuIvJgscI5CNkncbRhBlWAUAqmq
 9vjmGBuJggcbxOa__JOx2CQ6zILkP1qR9x62C5jt8Jfkv3Uo.iEJahSR_tkUSHlLiHAAR3CZ8bcF
 Xc1aYumYwQb15HmYHbgtyOZ.noWqmsy9mqvyxKlRJlJAUAVPCj2Jfzabc9O5x.hTN_M.KpCo2_2S
 NAkt12fuokb0Y62DYm_O6GDK8BRK8609a5qzFYftb0Qtu.RlStC6pir5IS0GPBdV3bQc0EjjXnOh
 yORu1EL.juH3L0rl60e.7AeSqYDifE9W8wElir_F1slPu8Un5Fi8PgYkjXT21g6a7gUQw6chs6Fi
 PiJIAYaTdUuzXOwxzQOVy7COnTSd1qR6aHTCQV1g4RhJYvqkDDrnBqQcfT3ynp2cDeUbcTscT717
 doEZnqt3aAkAxMp41fZKGCMMVBj23n4eHwJPnHawjRCGlePLY2dyz55dKTnehJONKznoT.4qerm7
 Rff0U3ejZ_sDRzNc4QaKhL0PMHS5Mo2w5sVzOg1ppxfZLlUmddy.qvyTig1Zg8c2Wyw1oZg6AAgQ
 cEIeOrgdykhISdkYmsqpNevMuwESgkoenNvsUH5XiHCS5TjB2lsseuVPFxdONMBQLig0DLk6n9HL
 mO3tpELyZD_jlBRzapM822CQrc57KxNBItAIlxVcFCSd0tQF._rDgz393rZWNxR6jwEvYvxfLAIa
 eh0Ziqk1WgeISI2FbulbXNxyn3Ww8WlVgOMjR1CX5SYbeYo7j..WRJQ2LAEB5EO6tc.BZMCeDM4a
 XfAEcEmvCKJjfpFK7ZWxH7ziD7ztc_ED3ye0KhuPsBv4Esn16OLVuN0B2y0YUQD24hXLQ4TWesBd
 _532ZaDCDMX4jsh7svqtKYoleWcdsBoiEK1PsX8m_F_PLBMxW9tAVdXMaG2cdruBIYj1ohpAMyyA
 Awg69Mgb7UptfzzMDp6UwAaGlqAn_8x6XYp7UIMw2WD9iLkQyJMKha99Bbjlyk..5Zf8dyV4qZjT
 Nsd.z8UgFlpv2OtMdqyLQR6ZscQmuFEat9wxChLk7Ubibecwu8wx43Ydl0PbEiY4UdXYrizOzt3M
 dCYEiV5VsunLe1LvKtPK3hshJ7utNVgjXtg1pxbSpTIQd9vTPK8jLm3ZkzETujoDblnThgq8FGNo
 eMVMfa6XNxPgIooiB1kVgFgHspWpRcd5CO_bjqeq.EpofB75_aDxUekSZbRU.hKhdwDjNp0aD6tX
 dBzc2CjyG2tFEK2f_9dwI45zJlp2G4TQu61HAktixbxIDZ8KfRGBERK0Ve.t2shePhYes3qHe5rI
 qjQyHZ_T81G5iqHgtR6BNPMzW4y6BX4KzJmHAP0MVQk5J43XDuF.mfzFwHgQmu71CdG0hfQW9lyf
 9vbNQhLWNEv7hjc6iQQLFbbwa.JOBqjYHJei8Yfgj4TpYuHQixKukkUKESR5RzgIAu7OdtSpwfNn
 3aI_AXLrYHO31TdEHAbeIqUBFGWeE0H9wqYD0g3VpBQ3naFW3t0kvr4rE7xW6Z2InN88ZeXvtFWn
 GtxOA6wbKIuTG1X0zRq_W6mu8wqINN3qMyzw1hqcA9wclOiujtwXI3ZvBgZWsoYJQJBuSLCApTNT
 ps5DTVvIujF2Q0vb7gUayhEIr4CQeKibT7C6iQ23A6yWGy2De8TITebGB3cp1nS4JXvuzLn9UY.n
 tibSjosM8yNMSNFhnmdL8yZcRaq56YwODl64xhrrdlhEgRoJToPyf5TApbqozNsf52e8E2kjDhap
 0O2ENSeFxj2PHBY2idgGkrPBAPEJeacqhqqzaTxho3wcAQ7DLwO_cNHZmGY6avzJlHOeXwGN.DO3
 nw61Td2n_PZyBbwQ2FaYMLtupG3nFRVrH1jppTpc7Y318Dau6CjZQMssXuUAeuGp8Y5hm8cpPkZh
 7WJ6FXXwLG3fDc0Mixh.7g726AcmP12v09lcLDjD4gwW_qNfnBGi4uennosPqn4RLmH8966JXIcp
 koCHZ7MnWEAFg1Bi1d9ihxYnqvdsObWRZ_DrBVHa3KNjnEhFY.88ICOORyg8ULl2X83ap6G4lOj7
 __q_JLHSCtNP4WFa8vupmUtMoIRMf0ecT3kpynt9ErjWPgkNsZHSN08f.KzP51F4y0C5dFD46Djz
 M2fiPqBM-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 8fd3c1d2-0703-4aff-8fd9-043a92bc5d9c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Sat, 17 Aug 2024 14:05:38 +0000
Received: by hermes--production-bf1-774ddfff8-xjgzc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8e4c07eb80e93175ad9bf94c00d9ce30;
          Sat, 17 Aug 2024 13:45:23 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] drm/log: Introduce a new boot logger to draw the kmsg
 on the screen
Date: Sat, 17 Aug 2024 09:45:22 -0400
Message-ID: <3578804.V25eIC5XRa@nerdopolis2>
In-Reply-To: <20240816125612.1003295-1-jfalempe@redhat.com>
References: <20240816125612.1003295-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Friday, August 16, 2024 8:52:32 AM EDT Jocelyn Falempe wrote:
> drm_log is a simple logger that uses the drm_client API to print the kmsg boot log on the screen.
> This is not a full replacement to fbcon, as it will only print the kmsg.
> It will never handle user input, or a terminal because this is better done in userspace.
> 
> If you're curious on how it looks like, I've put a small demo here:
> https://people.redhat.com/jfalempe/drm_log/drm_log_draft_boot_v2.mp4
> 
> Design decisions:
>   * It uses the drm_client API, so it should work on all drm drivers from the start.
>   * It doesn't scroll the message, that way it doesn't need to redraw the whole screen for each new message.
>     It also means it doesn't have to keep drawn messages in memory, to redraw them when scrolling.
>   * It uses a circular buffer so the console->write() callback is very quick, and will never stall.
>   * Drawing is done asynchronously using a workqueue.
>   * drm_log can only be built-in (and drm must be built-in too).
>     The reason is that, if you build it as a module, then a userspace application will be more appropriate than this module.
>   * When nbcon will be ready, I will use it. It should simplify this a lot, but I prefer not to depend on it yet.
>  
> The first patch is not for review/merge, it's a squash of my pending drm_panic series:
> https://patchwork.freedesktop.org/series/135944/
> 
> The second patch, moves the drawing function from drm_panic.c, to drm_draw.c, so they can be re-used by drm_log.
> The next patches are the actual drm_log implementation.
> 
> v2:
>  * Use vmap_local() api, with that change, I've tested it successfully on simpledrm, virtio-gpu, amdgpu, and nouveau.
>  * Stop drawing when the drm_master is taken. This avoid wasting CPU cycle if the buffer is not visible.
>  * Use deferred probe. Only do the probe the first time there is a log to draw. With this, if you boot with quiet, drm_log won't do any modeset.
>  * Add color support for the timestamp prefix, like what dmesg does.
>  * Add build dependency on  disabling the fbdev emulation, as they are both drm_client, and there is no way to choose which one gets the focus.
> 
> Thanks and best regards,
> 
> 
I tested it, and it seems pretty cool. And fast, it seems to keep up when I echo 100,000 lines to /dev/kmsg with seq




