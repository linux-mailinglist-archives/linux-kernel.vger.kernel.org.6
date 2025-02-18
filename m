Return-Path: <linux-kernel+bounces-518714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE8A393AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779423AC108
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C41B0406;
	Tue, 18 Feb 2025 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKekFb1V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13033E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739862412; cv=none; b=LMr7suTQhDUyG9KnxPLmk9bl/nYe6EJdh7ZL0vZnMxyjwtJfLvzVxhHtyxvhyHlqa/adJwutQrblmEfL+J/KVvPogTAg15j6EKLsVfCaTywaNdp/+mgnBSYTHGRwGh381/CvkM1j6iJIkdInU24uvB9MY+e4ueJXVS6eSzun/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739862412; c=relaxed/simple;
	bh=nLVhocii7It84oP8E7zPtfLE2O6O72hT3XqDMzeA2Ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D21nC9Fot0n1zxNAgTH9UB67KvU3VKTLU7pZmd/XH2n14C19Sjx0qeApffmKi7PwrI5twGyBNEB3wyg7HlMnzKiygv4oJT2slVPXLs8V1h8NRO6MQCumBcdcGFdPZFvOGoopIW+IrOQawbZLr39Mi4/shnUf7ygkn2vInuTpaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKekFb1V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739862409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HXAuPVdEAvFPuxLiXceyoEIdgydrp1/DHy6puhvJS8Q=;
	b=SKekFb1VtPCsUgjbHuVwFx0lhYrD/bDe5+cdc0xrp3sQrPv3rFIDHlpx4wQ+2shiIZz7gV
	lANpxyz7Wgwfsnd5dx2sxNcvYBxI1tzRyanu8o3sN2Af9o3siMLdaZcRjVKb9EsXN53VIx
	R4Um93WKmSkRT/NxQ8YaX3oxSVYojBo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-WEL_EYIRMjezb_VuOA67LA-1; Tue, 18 Feb 2025 02:06:47 -0500
X-MC-Unique: WEL_EYIRMjezb_VuOA67LA-1
X-Mimecast-MFC-AGG-ID: WEL_EYIRMjezb_VuOA67LA_1739862407
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f29b4d4adso2308834f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739862407; x=1740467207;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXAuPVdEAvFPuxLiXceyoEIdgydrp1/DHy6puhvJS8Q=;
        b=c/Gq4IgV33BhGRn3tQ9NfeoA8rlBC+tpaHumHz6y73qRvglTmbiwg+QMUCEP8NEL71
         ERJ0b+W3qPSwEdy1AqqtLZO+tgsW9vaZJEjwb44NkVSbRwvXT8jtBsPfYggOT8va9jeY
         tOMgEgDW0+1C15wATrxxqIvwgfRbllsDuK7BK+MyYJ47K1i0n+9DC9xGFFXPNQuP6Qkg
         HF6U0T19kdWBIxoFDY6BTsPgXzyPeT4GiE6FSovUjzXgtxFW1/7e5wwaclTinia3EF3j
         B9qbdYR8Uksq4vvL20sFks5sGNz48P9VTAevqcVk+sX0p+ZNv1TcfMQ7F3kzgzTRCpWh
         P/EA==
X-Gm-Message-State: AOJu0Yx3eGIVx60mjzrk2Ribu/ibWNYC7+QghKoNGXIlg72T8pfBGSgI
	FV8nDlMv+4PbuKXwNTfOm3VlMGCqzCaUg2BHfZwfBPblJRV8DMMRVXszLG/8082igqGMMBFYucY
	7wC5APeNsJp6uvFZqWd+M6zUOM0kHk4/mZyHEf4HHVooT+RL6e1avLsoLzXSFHQ==
X-Gm-Gg: ASbGncv3KW7M+y1fkroe4srfKPYthwo1tLqx1s1Tl26WTcKtYpwdDP1Ban5go5a1t+T
	h2PVtV8h49+Nv/YWu1ZBtRKxJ1SduZKcBIJrCbxQTfE1iycoSV5Jnyq00Ai0bqOT0MZnFDiHGK6
	2E4nY+OkgqrDAUCiOmrJwHxV+PBgPavPnWvcFolU9Nrre3zaIsPt56BLoeOm8m0bd16HPy9AHVJ
	k5VYVuICsEH1ak9EsoxLYZf7RTv+m7S8btHhXFwPtpJq6QGgCjL4LZYosg9orR6IUTaIhlSdXDR
	baMLawr0C7561KXRaMZp4vPfihW07D4=
X-Received: by 2002:a5d:518b:0:b0:38f:2f88:b034 with SMTP id ffacd0b85a97d-38f33f4e284mr9078448f8f.42.1739862406712;
        Mon, 17 Feb 2025 23:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDVOrLB4SIRjherMTEcmhlgcnodEoU6RQbfFJA+eEr9lfODG7fwZ2FnVVkhdYR/PU3kKvwEg==
X-Received: by 2002:a5d:518b:0:b0:38f:2f88:b034 with SMTP id ffacd0b85a97d-38f33f4e284mr9078420f8f.42.1739862406348;
        Mon, 17 Feb 2025 23:06:46 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm14150414f8f.26.2025.02.17.23.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 23:06:45 -0800 (PST)
Message-ID: <98ff750749a78c50d882f24e89fdc10ab145fa5d.camel@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, Juri
 Lelli <juri.lelli@redhat.com>
Date: Tue, 18 Feb 2025 08:06:43 +0100
In-Reply-To: <20250217121647.0b9ead66@gandalf.local.home>
References: <20250213090819.419470-1-gmonaco@redhat.com>
		<20250213090819.419470-4-gmonaco@redhat.com>
		<20250217113844.5ad7893c@gandalf.local.home>
		<20250217164917.GB40464@noisy.programming.kicks-ass.net>
	 <20250217121647.0b9ead66@gandalf.local.home>
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



On Mon, 2025-02-17 at 12:16 -0500, Steven Rostedt wrote:
> On Mon, 17 Feb 2025 17:49:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Mon, Feb 17, 2025 at 11:38:44AM -0500, Steven Rostedt wrote:
> >=20
> > > > +void __do_trace_set_current_state(int state_value)
> > > > +{
> > > > +	__do_trace_sched_set_state_tp(current, current-
> > > > >__state, state_value);=C2=A0=20
> > >=20
> > > And this should not be using the internal macros of a trace
> > > point. It should be:
> > >=20
> > > 	trace_sched_set_state_tp(current, state_value);
> > >=20
> > > (I removed the current->__state as mentioned above).=C2=A0=20
> >=20
> > But the static branch is already in the caller, no point
> > duplicating
> > that.
>=20
> Regardless, you should not be using internals of the tracepoints.
> That can
> change at any time and is not reliable (as the kernel test robot
> pointed out).
>=20
> It's a static branch, who cares if it's added twice? One is used to
> jump to
> the function, the other is for the tracepoint logic itself.
>=20
> There's several places that do this.
>=20
> Perhaps, in the future we could create a normal API that will always
> call
> the tracepoint, but until then, let's not use code that wasn't meant
> for
> that purpose.
>=20
> -- Steve
>=20

Mmh I get your point.=C2=A0We definitely don't want this piece of code to
break whenever something changes in the tracepoint API..

I will revert the change and prepare a V3

Thanks,
Gabriele


