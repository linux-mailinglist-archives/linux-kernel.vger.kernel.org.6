Return-Path: <linux-kernel+bounces-425927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4812E9DECA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D4DB218DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C419E7D0;
	Fri, 29 Nov 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bZUxMsPI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85674158535
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732911693; cv=none; b=DMWqrJYVxHwwTnys9SUlYyPR6zgXbypVsHNy7p7THSfXggIkfGCN5Q/X+AUlf56JKox65/Qy84ZAgzfVlV36wxw1Hda4dfYmW/12VdhlDr3wRhvaCwm1mx7dsw1EvX1HKEUN8Tb3cB+OLey3sXG0adMIVGjJIXNp7C4RekNEtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732911693; c=relaxed/simple;
	bh=yEmYsRwLft3aYwk6eKDjJDCa1DibEBkbdrZdF/fvV04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr7BNU09avyyKPyGsKUm+bSa06H2OAfzz55JrQC64VeED2JqVTsK1qJD7QcwPUA6Fqsb/BxtrDZ/xM63bJha5kth+cyp2BwJdNZPSCPLaW8X4e3Lm5xrirWVFHB1K/8joBtGiMavIO9b6p/ICFi+m+eA9ar9h3k7gC3t/PzDufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bZUxMsPI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso21084025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732911689; x=1733516489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5JJjBiQ/tLvIuG1BLZXa235uEW6UBU3aZ0TPGwOzpw=;
        b=bZUxMsPI9R8TiYDqZ7Z2BMPLJ/Xq09qrfg5UsI/TfxaGR3vq39CGbznbfdsQj5lBXs
         cgYv3Kc+jiqFUwBKgQoEc03cfDI/RqAyC5ksGQnusQyGJw9yP/tPXVDKpX3TpPTEcWb2
         ZcoLvZ2mmd01Fcq08gioa71aCCize8g0ey54yf19tVQcRs3A3GsfBspLEm6BjihipsqY
         kgBGYCILr2YZzozw5dPzly17ks1SvFreEU48xqyjLJCR0xe99A4yjaWDv3BkBPhbUwsK
         fkOM+e/O6OT2Yzpy8GVHqFJRGj5vMhjsbl5H0gQRSd4cVidjWhnINtrdBrWbzqeKaIr3
         QN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732911689; x=1733516489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5JJjBiQ/tLvIuG1BLZXa235uEW6UBU3aZ0TPGwOzpw=;
        b=DDpD9RuEScM4vvX/FQY7CJDzCGXzXg/8/YS79AUOTxLg5YeQQZuq0na32GZnZA7nT8
         5S7CjryB063zdpZcppkULwwcKQoGMNjlEL+uTLFsMeSx5sqi5uwJsARTeMV5zf7VT7S6
         3D/QRKQ2KR9XUVtFGrSTrpGglNB4tNgFfqqkhV83oBmK0A1v9hhE3X9jU8tjMgHt+j1w
         n/D+Y4Zm2UbqZCQCPO+zyYnnNXuYa6flo/rGuBKCqWYe/XuRoGwDQMD+sHT/QoM/QLjG
         PHkjELzxJfCm/BXJazzHtKIvP7umwLytoHssjsGqfT/m237CzzCqm/py0BZdEUyh8OOg
         Kn7w==
X-Forwarded-Encrypted: i=1; AJvYcCXgt3+Kwl0382GzjZWQ1sjIIgMRA128mDwzAgJPDTIooqq1tPswqoU9fRnD/cHq+Si5vZtH9r2cA12S+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2E38iCauJ/pk7QnybmZKK3ioZOEKPuD3rj3EM6er3MxVY3wUP
	Eb8gYnHy5gGlfTzLil6P166uH3RtCe2go/+yjgge152OclHG8b/Nm8Q5kwBa66Q=
X-Gm-Gg: ASbGncsh255L+u1GLElTSTc7bxqno7MoLmSS9CRdweoiNgH/ve3175Y3+358WipNp2z
	TaH6WKuwGs2DhV9NE/eysMKiiwcagCKF2KE/l8sq0zhHWNCAesMqQFW3mBcf7gN5Vujna+BLurM
	nAloEvWznBx6Ca3YYlDY9CaTmwPpaEzgzgz93bP4jdmafdPcoViOmFKC4W+9qTqbPGRF0Dbbvs9
	ShdiKScO6va0VAhITCckjmxVz+HHiOR5CSUSTNexCjBbY+LHGGg
X-Google-Smtp-Source: AGHT+IH58hBxoQ81qfPePJNvv7KY1IP9Rmx52/c0sq8zmQbbB8oF9/gYg8J0g2YozW6ZOmsc363tfA==
X-Received: by 2002:a05:6000:1886:b0:385:e1a8:e28e with SMTP id ffacd0b85a97d-385e1a8e687mr1473236f8f.10.1732911688749;
        Fri, 29 Nov 2024 12:21:28 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd80435sm5208746f8f.100.2024.11.29.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 12:21:28 -0800 (PST)
Date: Fri, 29 Nov 2024 21:21:26 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Luca Abeni <luca.abeni@santannapisa.it>, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, 
	Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Phil Auld <pauld@redhat.com>, Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH V7 9/9] sched/rt: Remove default bandwidth control
Message-ID: <2aqeakf4rbed2hnt46yvdospzntpvp7ndrk4xnv6rrh7ctijes@d3nzwnguheju>
References: <cover.1716811043.git.bristot@kernel.org>
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
 <d3bllrfwji74t3ix3jcdlvdt6jdorw75wjol6kmadpeuuqal2t@io7ghgf7zkbs>
 <Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb>
 <tjsas6vkv3xegcgmranxmnkrt46xuitp553caz6vvtgpfrbwl3@252nbydvxaqt>
 <Z0nTZXHDggHD8raj@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="abb4dc3oxztapxcd"
Content-Disposition: inline
In-Reply-To: <Z0nTZXHDggHD8raj@jlelli-thinkpadt14gen4.remote.csb>


--abb4dc3oxztapxcd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 03:44:53PM GMT, Juri Lelli <juri.lelli@redhat.com> =
wrote:
> You can disable admission control by echoing -1 in sched_rt_runtime_us,
> but still have the dl_server working for SCHED_NORMAL tasks. By
> disabling admission control SCHED_DEADLINE can indeed monopolize CPU
> (over subscription).

| I'm wondering if different values of =CE=94 mean anything or how they can
| be used.

Aha, the knob therefore remains relevant for the DL admission control.

So if I put it together, I will write it down like this:

-- 8< --
Subject: [PATCH] sched/RT: Update paragraphs about RT bandwidth control

This has slightly changed with the introductions of fair_server.
Update the most relevant parts.

Link: https://lore.kernel.org/r/Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.rem=
ote.csb/
Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
---
 Documentation/scheduler/sched-deadline.rst | 13 +++++++------
 Documentation/scheduler/sched-rt-group.rst |  8 ++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/sch=
eduler/sched-deadline.rst
index 22838ed8e13aa..a727827b8dd52 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -591,12 +591,13 @@ Deadline Task Scheduling
=20
  The system wide settings are configured under the /proc virtual file syst=
em.
=20
- For now the -rt knobs are used for -deadline admission control and the
- -deadline runtime is accounted against the -rt runtime. We realize that t=
his
- isn't entirely desirable; however, it is better to have a small interface=
 for
- now, and be able to change it easily later. The ideal situation (see 5.) =
is to
- run -rt tasks from a -deadline server; in which case the -rt bandwidth is=
 a
- direct subset of dl_bw.
+ For now the -rt knobs are used for -deadline admission control and with
+ CONFIG_RT_GROUP_SCHED the -deadline runtime is accounted against the (roo=
t)
+ -rt runtime. With !CONFIG_RT_GROUP_SCHED the knob only serves for the -dl
+ admission control. We realize that this isn't entirely desirable; however=
, it
+ is better to have a small interface for now, and be able to change it eas=
ily
+ later. The ideal situation (see 5.) is to run -rt tasks from a -deadline
+ server; in which case the -rt bandwidth is a direct subset of dl_bw.
=20
  This means that, for a root_domain comprising M CPUs, -deadline tasks
  can be created while the sum of their bandwidths stays below:
diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/sch=
eduler/sched-rt-group.rst
index d685609ed3d7a..80b05a3009ea2 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -92,10 +92,10 @@ The system wide settings are configured under the /proc=
 virtual file system:
 /proc/sys/kernel/sched_rt_runtime_us:
   A global limit on how much time real-time scheduling may use. This is al=
ways
   less or equal to the period_us, as it denotes the time allocated from the
-  period_us for the real-time tasks. Even without CONFIG_RT_GROUP_SCHED en=
abled,
-  this will limit time reserved to real-time processes. With
-  CONFIG_RT_GROUP_SCHED=3Dy it signifies the total bandwidth available to =
all
-  real-time groups.
+  period_us for the real-time tasks. Without CONFIG_RT_GROUP_SCHED enabled,
+  this only serves for admission control of deadline tasks. With
+  CONFIG_RT_GROUP_SCHED=3Dy it also signifies the total bandwidth availabl=
e to
+  all real-time groups.
=20
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
--=20
2.47.0

--abb4dc3oxztapxcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ0oiQwAKCRAt3Wney77B
SQV2AP9ZRGrG5D0KSjV75h1W8cuMswXJ1WAFgfixK5wrog2qQwEAu7zou1R90XAE
SZVaRbtDhfDOUzeynuCB3fpxClxjRQ8=
=39jx
-----END PGP SIGNATURE-----

--abb4dc3oxztapxcd--

