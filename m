Return-Path: <linux-kernel+bounces-546784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2379FA4FEB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773C13AF51B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92F245024;
	Wed,  5 Mar 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNlb4ckK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CF241697
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178102; cv=none; b=t83zo1arPTIWS/BkDzNAcn3wSLA/rymbCLQjfetOrN+oMxFZxJCEhuM+I23SvCR2NipyMnJoBIuKMnq8K+yZe8tFCQbrAWDDLauBwQnVzYIi1ayRYm/HNyywQQcoAKUKQ2lDhYIOL6hCwMkZ0Rbc7Kp0OCAZmMPnq3IrYS3qJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178102; c=relaxed/simple;
	bh=MzbvmMQv5RSDzTCeWNjXU61fajli7jqj0GtNNyX9JU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRh0wrytKZcu9V6PS5pzms67XY7E+tMzT0d2traxypRb1hz021NmK/KCFxR8eJifY2vAICveChMT5VjgPqsqdAsm/65Xp88AIYdcbmHro6zI986T2Damtfirld2ymr/ullE3wcH0dPP34yNclq65dH3hII25B+YmFg4xWKpUyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNlb4ckK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741178099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MzbvmMQv5RSDzTCeWNjXU61fajli7jqj0GtNNyX9JU4=;
	b=VNlb4ckKudzF1+uAZB40pCLqqp4II5ykzd9MLToKTZo/gY+5FHx66NSjDmLHuVP3mxftJ2
	M5NbjyhAJYUe3dsxkPm+yHX8m96nBI56sVykO22BpQyL20JQ2ai0oTjOb8JSPQAwf0p7CC
	mAwVPBhVaPiKeijFwc/jfiTxYPZaaWw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-xlmakPnaNU6bDrYA9_t0ZA-1; Wed, 05 Mar 2025 07:34:48 -0500
X-MC-Unique: xlmakPnaNU6bDrYA9_t0ZA-1
X-Mimecast-MFC-AGG-ID: xlmakPnaNU6bDrYA9_t0ZA_1741178087
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f000e962so2209943f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178087; x=1741782887;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzbvmMQv5RSDzTCeWNjXU61fajli7jqj0GtNNyX9JU4=;
        b=JhEzS/EXCq5rfo/Pki332NUZFQ4xP3bVzC8f5E4aBzcDQzgPes/w/KIUY3+vfYN94A
         zGnfFk/4/HTgaJCHdHwV+jX2WiE7AXe2Zp61/frBpYxT11AjKmGbGijaCzSBxadMK2v5
         x0sNh3tTnZAi4MLUQdjPm5zFJtlqH10nZ6q4PujdhDbZ/SR7XW5Cam5YhDcUfNyAMdw9
         ng3e9nQpRLt5MPVOoHjv+m2JN06FN1wyBtXjiefrLRpgDphMXgNYUp4zvju5RbnDCRZ2
         eKdVcSMgI2/GqY3nzgKg6baErvqKaHBxeQ7kZuW2Cp5E9zpKJzBSaQBwHf3Z1x8MmP4Z
         1BxQ==
X-Gm-Message-State: AOJu0YxBbryorWZemN/v1bsu0RCB0rTLRTOwpekHiSqDvE0Isyur2YmT
	Ec0K8PYyTUGVRuLR32EQbMxglkYCbiuCwAsdnpnkfZCW22rHydC2V61J6Q7LjMNzsgz8TODAZ7S
	obgjcNoUmxYN6qcU6y8F+VxO9Y+arSDSWH2tx1TP8cwAAWb/hnHof8oa4COPmiQ==
X-Gm-Gg: ASbGncvds90xrynBMieIIiOBgE2ifsVUhdRM0mXfE/OOXh1oC3mlRl99x497b5rSp3W
	LNeHs9puV803I2DtXJE+9PC3O3fgOCfx2Dc7ojKPPAFU1YL7d31T5Fg0x296hdWbHRQOT26iiDI
	a2yY0K3ysnizYsYyJy4jkQur9kJ9YJzFBxheJadoASZzKXnTOMvFjQzDMfb9B7CF5voUaWh4onS
	xtgSS6pZLcZcj4MPmIwpJe7utz8YonK98yDNB809URFxZP+ViE32fnGGHlxlHB/KhuekjmP1uFr
	aCk1rUU+pwIKMAAhQjPqcTT1EAMraobuMYpTz9j7UQ==
X-Received: by 2002:a5d:47c4:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3911f7c3b07mr2400868f8f.40.1741178087575;
        Wed, 05 Mar 2025 04:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqQWQA/n57DVltTxNtmrZ/6HkQkivRxHCLahBCPf9F/HOe2cN3ukO92Xnzt4J+DpQyRuP7Yg==
X-Received: by 2002:a5d:47c4:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3911f7c3b07mr2400844f8f.40.1741178087199;
        Wed, 05 Mar 2025 04:34:47 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e61csm21201667f8f.98.2025.03.05.04.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:34:46 -0800 (PST)
Message-ID: <1115798d35feb54f0cc714dec3bd7fc5a671adc8.camel@redhat.com>
Subject: Re: [PATCH v4 02/11] rv: Add license identifiers to monitor files
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Date: Wed, 05 Mar 2025 13:34:44 +0100
In-Reply-To: <20250304121828.34006e00@gandalf.local.home>
References: <20250218123121.253551-1-gmonaco@redhat.com>
		<20250218123121.253551-3-gmonaco@redhat.com>
	 <20250304121828.34006e00@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 12:18 -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2025 13:31:07 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > Some monitor files like the main header and the Kconfig are missing
> > the
> > license identifier.
> >=20
> > Add it to those and make sure the automatic generation script
> > includes
> > the line in newly created monitors.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0kernel/trace/rv/monitors/wip/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A0kernel/trace/rv/monitors/wip/wip.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0kernel/trace/rv/monitors/wwnr/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A0kernel/trace/rv/monitors/wwnr/wwnr.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0tools/verification/dot2/dot2k.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0tools/verification/dot2/dot2k_templates/Kconfig | 2 ++
> > =C2=A06 files changed, 9 insertions(+)
>=20
> While I'm waiting for Peter's answer on the scheduler tracepoints,
> I'll
> take these first two patches now, as they are agnostic to the rest of
> the
> changes.
>=20
> -- Steve
>=20

Great, thank you!

I just found a problem in 3/11: current_restore_rtlock_saved_state
doesn't pass the correct state to the new tracepoint.
I'm going to send a V5 and will leave the first 2 patches out.

Gabriele


