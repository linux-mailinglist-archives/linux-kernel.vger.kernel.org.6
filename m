Return-Path: <linux-kernel+bounces-339457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC0C986554
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027F41F24E88
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0FB34CC4;
	Wed, 25 Sep 2024 17:10:03 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F542067
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284202; cv=none; b=Wdw/t4/rABvD5rJlaHbZnh8UEUW9eLiU3b57KH+cia6OL+LJOvncSZSeOIg31zb6qqBZ7P2AEfwjQXbs7ncdYtSYm8dIePuW2W+uGgEseXIFKinl8I0vrzbcsOoTJI+VijTKjh5iPNPoAUsyLB63EENUCg3zWJFhOFUgtR/0u3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284202; c=relaxed/simple;
	bh=dVfDOPAUWKopfjcK6mbg81OFsQ0vEB/NnHfWeZb5iPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM3VOePQz/JCacsPDBB6ifFQsiDHBT0rUUf952Vgzw2hhIEmFhZ2pEjMbN/7nxAlcq6KmkQoYEvifj4Oh6w/Rtqp1xxYhTWzVxrq3D0/uhXdasPjk7G/bC/I6f/ZtGS6l6nIFWsycKD8gA6ICtBZb5Gqbu3G4xnZle9b51RphtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82a626d73efso2400839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727284200; x=1727889000;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVfDOPAUWKopfjcK6mbg81OFsQ0vEB/NnHfWeZb5iPA=;
        b=nyiK1shnrWoN3iSIHuQw1vN6oBYk8R0Wbu3BTK/ihc6l1PeClv4UUCj/RjUygzuNWW
         1ZnQ0QUr4FtvSVKL8DjtyiUC7xBzcUFryhNYTawLOp3c6m0A4aBIgnCuQZdGdQHiw7dw
         nERX721+usqlre7+WAiA9tLll+2aNt0LAYBGdzM6XeGhMXjh7AnRR5yFzTajP7W5jvMR
         toXzSBY4gg6ZPtZjI8hfo3hPzfnYCk+DTr/ZfgOTSc6YgTIYed8STAUR0sR4YQ47ZNbe
         rrw8S31imaK6hxIMZX1/u2BOjMvFZgBoiJVALW7Z5EGRsOWlI++J8tyfRAzckHqKmmDo
         DVLw==
X-Forwarded-Encrypted: i=1; AJvYcCW/iMQFX+Ad2yuwOPlBTAWBnPgEFjWPm1TeGaIgEXh75L1aq02s5i+lCKhRnc8AXoxeTf6hwYl9fsvlnPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys0ENqNUykIjzsHQRr80cuhL0y4mVGLCAmK7UhtDJsg9Azu6dc
	2kch2Rh8kj8O40kJ3P/D9A0wso8YPZ1oIwlGPdAiuUZTcBcXw8sb
X-Google-Smtp-Source: AGHT+IG+cqBmv4mixYRblbHFRMFXJlw3s2aimTw4OARVVHFCPyZeyTpsoJgc1OpY2Hv5pLWGroy6SA==
X-Received: by 2002:a05:6602:1691:b0:82a:a8af:626f with SMTP id ca18e2360f4ac-83247cfb73fmr408828539f.2.1727284199891;
        Wed, 25 Sep 2024 10:09:59 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f1bbb09sm1174624173.105.2024.09.25.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:09:58 -0700 (PDT)
Date: Wed, 25 Sep 2024 12:09:56 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/5] sched_ext: Allow only user DSQs for
 scx_bpf_consume(), scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()
Message-ID: <20240925170956.GC26346@maniforge>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EGART9XIPc7IMxU+"
Content-Disposition: inline
In-Reply-To: <20240925000622.1972325-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--EGART9XIPc7IMxU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2024 at 02:06:04PM -1000, Tejun Heo wrote:

Hi Tejun,

> SCX_DSQ_GLOBAL is special in that it can't be used as a priority queue and
> is consumed implicitly, but all BPF DSQ related kfuncs could be used on it.
> SCX_DSQ_GLOBAL will be split per-node for scalability and those operations
> won't make sense anymore. Disallow SCX_DSQ_GLOBAL on scx_bpf_consume(),
> scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new(). This means that
> SCX_DSQ_GLOBAL can only be used as a dispatch target from BPF schedulers.

This API impedance where you can dispatch but not consume feels unnatural, and
a bit leaky. I understand why we don't want to allow BPF to consume it -- we're
already doing it for the user as part of (and before) the dispatch loop. That's
also one-off logic that's separate from the normal interface for DSQs though,
and because of that, SCX_DSQ_GLOBAL imposes a cognitive overhead that IMO
arguably outweighs the convenience it provides.

I'm still of the opinion that we should just hide SCX_DSQ_GLOBAL from the user
altogether. It makes sense why we'd need it as a backup DSQ for when we're e.g.
unloading the scheduler, but as a building block that's provided by the kernel
to the user, I'm not sure. In a realistic production scenario where you're
doing something like running a scheduler that's latency sensitive and cares
about deadlines, I'm not sure it would be viable or ever the optimal decision
to throw the task in a global DSQ and tolerate it being consumed before other
higher-priority tasks that were enqueued in normal DSQs. Or at the very least,
I could see users being surprised by the semantics, and having instead expected
it to function as just a built-in / pre-created DSQ that functions normally
otherwise.

Thanks,
David

--EGART9XIPc7IMxU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvRD5AAKCRBZ5LhpZcTz
ZF4wAP4lBF49R6R4otL4+6fzp8HMNMrAr0JDNS6EDDrm4tovBQD/TI1GSwhQtFqI
/Zdxqh0WgOM2zJxCwpnqHJxw3tnCBgc=
=w+y+
-----END PGP SIGNATURE-----

--EGART9XIPc7IMxU+--

