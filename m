Return-Path: <linux-kernel+bounces-517073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A953A37BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7716188A5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F80190482;
	Mon, 17 Feb 2025 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eikXbpPl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646D18DB3A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775395; cv=none; b=XMwC3FZR3bOfZx+YIBdx4xR832jGWv+SWCgADyiVnfzpVCju9TGOy3vxmXd7iX89WiLo/mP3YRY3nBR6LZwe6oZK1tk300FogGPt7e5BsGdXLkmUbC61wnXtUYL4zPHfmVCYCe1eA+UI0jRtS8FKKmm6c93yLXwcexxDIp9EUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775395; c=relaxed/simple;
	bh=UAjwm8ZUmY9NHxBX1wqkn0W4bWD5dQPw7sKcOk9oW2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5I/iJ8VeMRuHxwOl1odehFHgQuZTfF9F7O9AYmdTo0f8NwEEKfqXPe2ZZZ+UcpV07G4xbVMJ8Njie0xyLkvxQcmX2pFPVHZQJlIC24SzMIJzdFLu9XoC/CNRXnsEQaeeyYRhGaHwnkyjCFOBwVgODEA7hDi/DzBGKkTOqhKPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eikXbpPl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739775392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UAjwm8ZUmY9NHxBX1wqkn0W4bWD5dQPw7sKcOk9oW2U=;
	b=eikXbpPlw9n+5RUSDPykvUdsCkdUQ6wKowVBdhSf6kqyvUMPVRMsZcb0Dy/7tm4QSITS4h
	fhLDt/xq6sUuOldxkYUq0q3DPjwztuzL7OQoxttRIc93m0PlmhjgfeAZDlAhtg8J3FE9+Q
	kQoBm95MgZOAChHHK4XWNIoxjcdlb1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-CymCEM2eO6S6QVGZ168q8A-1; Mon, 17 Feb 2025 01:56:28 -0500
X-MC-Unique: CymCEM2eO6S6QVGZ168q8A-1
X-Mimecast-MFC-AGG-ID: CymCEM2eO6S6QVGZ168q8A_1739775387
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43942e82719so33405675e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739775387; x=1740380187;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAjwm8ZUmY9NHxBX1wqkn0W4bWD5dQPw7sKcOk9oW2U=;
        b=wLIv/AJVimuEGJCDQIhAKix3t9J6toy8cBqs4fyCGVr0POZqfTZjJY8A/oYDdLf5qE
         hpyVNmF3dgcrHz/PVNr0PGO9PguHn7L8J00iu/Lod7V5oqSjkZGjDGhteEFOPMNh8C6m
         eVmNktTehSHRlEy9EJQOPS78w0xwlnaI4s2jwhM+zPrcP/Al+CHY+xrbgC9n09wwJA4W
         DCJ3hnW3QtwdS7/k6ZC3wP6uBGUn7PKYJUm5QbksbAIQ55qj9uzf/+gftYESsLPxQ8Fd
         UCjoSYc8xckpuGSLK4aRJLYgckL3IEKvhWFFqvN4yZGHHUPg36c0n3Z0DxhWlfnG28j+
         NgWA==
X-Forwarded-Encrypted: i=1; AJvYcCVwsa2sDTdGsCOQDRAg7dvficCHU6Fd0OShRtGADkYaAeN1KFx2aukVI253p6NasE6QQnCngMKViDYx7jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6w7HjlLGIuc/GsoKPRjwtgIUPDLLuMpEzlkbaD+Y5I9z11rz8
	xqTDSmsfYtvFrhp2bTQpvBXYuZSm2Ik48Ko+WXuiranHkYK4TAicHmyTdfYh6Rns2k40ED6GV5J
	PR9mCa8IBHr/wplh5jGi8ZEyrSTTt+NwH/iGvZDxZ52WsBjo+3NXD9oE7OgbgMQ==
X-Gm-Gg: ASbGnctQeRv4n7G50YAO4RyMp8zN3Gc6pmfDt731TvlXwvPzreEXjE3dhsfGz3vZdxA
	lQmrXL7EQuM2d33hnBWFYYNUnu2I+6mXSf/IVpuStZgbIksPLRT+QVvWIWslPf4Twmrv97GuIZ8
	lCqLSfgoqPE23xyRcP33BXGeVzsTdC/eQD82WRU/v/tDF1PT1/BY4w7Im4M7BbyBIsg8kgqjI3S
	Xw5LMCOsiwFmMSG2+mxdllk0aNX6W/1ucZTuTpLe9qAh9ocwNooQEVF6Z9/vmkQF2IZErbbI6R0
	sfOL4PLnbVYrhLA+Z+p19GB59HwwVqA=
X-Received: by 2002:a05:600c:4ec9:b0:439:5506:7183 with SMTP id 5b1f17b1804b1-4396e6a6e31mr75901455e9.7.1739775386962;
        Sun, 16 Feb 2025 22:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk3NBZALdJoBEHy/OW1hnkv7UynhyXmZFDFCyRcaZfKjwzBNYuS2O/oEr1D7pZAVFTavR1tg==
X-Received: by 2002:a05:600c:4ec9:b0:439:5506:7183 with SMTP id 5b1f17b1804b1-4396e6a6e31mr75901285e9.7.1739775386528;
        Sun, 16 Feb 2025 22:56:26 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395cf084d5sm98968555e9.1.2025.02.16.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:56:26 -0800 (PST)
Message-ID: <c5fe1f637a84087afb94ed3f9255810ef3975724.camel@redhat.com>
Subject: Re: [PATCH v2 04/11] rv: Add option for nested monitors and include
 sched
From: Gabriele Monaco <gmonaco@redhat.com>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli	 <juri.lelli@redhat.com>
Date: Mon, 17 Feb 2025 07:56:23 +0100
In-Reply-To: <202502170630.xSYE4cUk-lkp@intel.com>
References: <20250213090819.419470-5-gmonaco@redhat.com>
	 <202502170630.xSYE4cUk-lkp@intel.com>
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

On Mon, 2025-02-17 at 06:39 +0800, kernel test robot wrote:
> Hi Gabriele,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 4dc1d1bec89864d8076e5ab314f86f46442bfb02]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/tracing-Fi=
x-DECLARE_TRACE_CONDITION/20250213-171642
> base:=C2=A0=C2=A0 4dc1d1bec89864d8076e5ab314f86f46442bfb02
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20250213090819.419470-5-gmonaco%40redhat.com
> patch subject: [PATCH v2 04/11] rv: Add option for nested monitors
> and include sched
> config: parisc-randconfig-r112-20250217
> (https://download.01.org/0day-ci/archive/20250217/202502170630.xSYE4c
> Uk-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.2.0
> reproduce:
> (https://download.01.org/0day-ci/archive/20250217/202502170630.xSYE4c
> Uk-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202502170630.xSYE4cUk-lkp@intel.c=
om/
>=20
> All warnings (new ones prefixed by >>):
>=20
> =C2=A0=C2=A0 In file included from include/trace/define_trace.h:119,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from kernel/trace/rv/rv_trace.h:=
130,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from kernel/trace/rv/rv.c:148:
> > > include/trace/trace_events.h:477:13: warning:
> > > 'print_fmt_error_da_monitor' defined but not used [-Wunused-
> > > variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 477 | static char print_fmt_##call[] =3D
> print;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:39:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39 | DECLARE_EVENT_CLASS(error_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
> > > include/trace/trace_events.h:477:13: warning:
> > > 'print_fmt_event_da_monitor' defined but not used [-Wunused-
> > > variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 477 | static char print_fmt_##call[] =3D
> print;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:12:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12 | DECLARE_EVENT_CLASS(event_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
> > > include/trace/trace_events.h:223:37: warning:
> > > 'trace_event_type_funcs_error_da_monitor' defined but not used [-
> > > Wunused-variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 223 | static struct trace_event_functions
> trace_event_type_funcs_##call =3D {=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:39:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39 | DECLARE_EVENT_CLASS(error_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
> > > include/trace/trace_events.h:223:37: warning:
> > > 'trace_event_type_funcs_event_da_monitor' defined but not used [-
> > > Wunused-variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 223 | static struct trace_event_functions
> trace_event_type_funcs_##call =3D {=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:12:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12 | DECLARE_EVENT_CLASS(event_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
>=20

This is something hard to trigger, but I didn't remove the select
DA_MON_EVENTS_IMPLICIT in RV_MON_SCHED . As a result if the user
enables the sched monitor without any nested monitor (which is already
a broken configuration but happens if you apply this commit without the
following ones) trace event classes would be created with no event
using them.

I will send a V2 with the fix.


