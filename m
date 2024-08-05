Return-Path: <linux-kernel+bounces-274540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FB9479A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B92B210D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF73155386;
	Mon,  5 Aug 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrg++o/6"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390AF155351
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853495; cv=none; b=Px2qcfaX0C7INb4yoMpnVUuTIixQT5zH5KVjicR90jMnkaoS8tOuUBKmocbTTXU6DB9Sp9f/EnwADx1sAO7skGbjDmVjlcX/I5sokJ8zYSfjohmxyl4sYKsjEHMWCRT6KKIesQwgDvYbgjxLETmO24dfaurF4aNaBlc2jjq4CUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853495; c=relaxed/simple;
	bh=YeAHMX5+IhLDjmLwI3p0PJz/VOZbN55u2UclsdTzDcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2WvOZkepIWMuS2hG4nlmJA5b8/ITFfkTTosEmqoXuKn5nDoDayVhHS2l6ljO4ytRlKVUCxIfQo51YpLSTpIPvcpdoYoAc78GhfxrdjzbgM/VOglkZlPuOHNo+jylfboAh6TR89o/xJQFOkptziEqhDmr9/z7uleR1laZPzlj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrg++o/6; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f8dbdbba98so175798e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722853493; x=1723458293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMkeG4izRg3Cy2r8N32ZDttVGuy8Xq+hXqAv8E7cHFU=;
        b=Zrg++o/6HGwNdkPZmi1oe2RhBo2Kve9rfxnklrGnlUMhyL/MyvJT4F8KBpbIpBUlTs
         cbtg+mNODhyfU/+mWzW52OZSTFNbH4GJXJXWmJP9s0VDvGKVUpPN4Q8tx0uv2wT/FNZi
         e6ISfi9+ar/DadRYAZj6UjDrZB8hDAmh1TL7KfvA20ObMGI1ctoXrtsN7uhifWzSbDUk
         ZxIu/Q5iUwNeOi61RufqJRrZEoQjLVyLWVhfMncDdpupdyI2yoZGl7lnAGrS+nOeQXrT
         QgFxzwM+mYeelbn+VztwbXNJA9M1pBafLvUuL0WS7wosUwHJbMuw5gljE7WRRGgYztUn
         ehvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722853493; x=1723458293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMkeG4izRg3Cy2r8N32ZDttVGuy8Xq+hXqAv8E7cHFU=;
        b=T0BG2tpDR4IRTuglbaM1RUnmydMDKe9oUEIXSR752VvvHDVh+CaDzqhhxXyAiFzwae
         W9MgKeLHVMv+2JqMuq4IhFBrnefkDtFmnkbbmQgCB93eK++V5xHB/Anibn7Jz1TntRTh
         uj4T1ndF8mbMGA6FXAgQF0lFqzJY7rpOeFHQ+4ySy3Ev8mo1MKDCFnpPD1mqMIqfpHo3
         x47zgtXssLlh1MR3DPaShyu9LNgyNASPXCHw0SpqH1vit3FMY0HnCzan0wDv70fYLdhT
         MZ5Rh/bUf6okpzpsYAO+EQ1vhfMQBHYJP9BruNLGXFGJo79W1eIdCza3LCulnVDQWMWY
         lRhw==
X-Forwarded-Encrypted: i=1; AJvYcCW25JlhdKIRaRfqzNR3mZx/n4MP3VkGnBqhA4/sm7MkbQy6GAfnEj0GPZ0exLDPy661GZzUvAR+fJ23XD0indAiArRX/5W3FfSDFVIR
X-Gm-Message-State: AOJu0YykQzvzNFmhHoxQmR+FcaALVl4s4HEBgfRxli/JqOyve5Y9LLon
	pht1k4mR4u1wnEdhQZWolTCLcsysfutiwqutAge6DGCUWMJezytdLha7XhlmNCcd+xxEjUOE3KM
	c41jy6o0/MAeoRnedJIZ3r8vksZY=
X-Google-Smtp-Source: AGHT+IFs5C6I/kpXxdQc0J8NsfQIiE+eZWbHqvAeaOrKb5oPCoEwogoGU56iYNVe57kTq4dPEHvevqYcnT0+GFxqbMI=
X-Received: by 2002:a05:6122:da0:b0:4f5:d98:5ec3 with SMTP id
 71dfb90a1353d-4f8a0ebf1damr6875199e0c.6.1722853492977; Mon, 05 Aug 2024
 03:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804212839.685795-1-pedro.falcato@gmail.com>
In-Reply-To: <20240804212839.685795-1-pedro.falcato@gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Mon, 5 Aug 2024 11:24:40 +0100
Message-ID: <CAKbZUD0hBFeMm=Rwb1LX6MYEpLK_qAnr8jfczLzY8V-DKEDn4w@mail.gmail.com>
Subject: Re: [PATCH] slab: Error out on duplicate cache names when DEBUG_VM=y
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 10:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> Duplicate slab cache names can create havoc for userspace tooling that
> expects slab cache names to be unique. This is a reasonable expectation.

For completeness, I just had a look at duplicate cache names around
the kernel using
git grep -Eoh "kmem_cache_create.*\"," | grep -Eo \".*\" | uniq -d
(which seems to be correct)

which results in the following patch (on top of torvalds/linux.git
master, so file_lock_cache hasn't been fixed yet)

This patch being so small is what leads me to believe that erroring
out here is safe. Of course, no one knows what the out-of-tree modules
do.

diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
index cc824dcfe7d..abc78320c66 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -873,7 +873,7 @@ snic_global_data_init(void)
       snic_glob->req_cache[SNIC_REQ_CACHE_MAX_SGL] =3D cachep;

       len =3D sizeof(struct snic_host_req);
-       cachep =3D kmem_cache_create("snic_req_maxsgl", len, SNIC_SG_DESC_A=
LIGN,
+       cachep =3D kmem_cache_create("snic_req_tm", len, SNIC_SG_DESC_ALIGN=
,
                                  SLAB_HWCACHE_ALIGN, NULL);
       if (!cachep) {
               SNIC_ERR("Failed to create snic tm req slab\n");
diff --git a/fs/locks.c b/fs/locks.c
index 9afb16e0683..e45cad40f8b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2984,7 +2984,7 @@ static int __init filelock_init(void)
       filelock_cache =3D kmem_cache_create("file_lock_cache",
                       sizeof(struct file_lock), 0, SLAB_PANIC, NULL);

-       filelease_cache =3D kmem_cache_create("file_lock_cache",
+       filelease_cache =3D kmem_cache_create("file_lease_cache",
                       sizeof(struct file_lease), 0, SLAB_PANIC, NULL);

       for_each_possible_cpu(i) {

