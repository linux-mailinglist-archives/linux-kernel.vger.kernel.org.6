Return-Path: <linux-kernel+bounces-437726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94A9E97B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C8D282042
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E51ACEB6;
	Mon,  9 Dec 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WADDzXtQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3B1ACEAD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751968; cv=none; b=La9mtdlB6PmCaRTGjKyjZncvt4Qf42VDHzrJ7DKoTVKBIzOFb+BfZDZh+9gn1qdKy0foudaSeCZr4Fw9gn/lSfrbON/AmgY2bYEsoz9HhS3QA3cJhAhVbhzuighqdy7P0m2gLvLVtXlMsuJhSIYdwPJuyBbSLKNwVlL66dtbYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751968; c=relaxed/simple;
	bh=UxiqV3TGm/7Oo6r80N5hopww+gDKBoPqmI5cftRmlZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TeZjjduVoMBlyQJKKxUxsYgMDx8Vr1uzIO5Nh51Gd58tREcQzpLD2OGht/2XhoWayNToDLUkSPzJ3Rklx1sVF/Sq+6rIIHuyW5KmI1tjvyjctUex1DiFiWKt3EYFqrG0Dnt8hiVrmkdiPvzetU0jMEiGXQ1ZbngmdQmyhK0NMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WADDzXtQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733751960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UxiqV3TGm/7Oo6r80N5hopww+gDKBoPqmI5cftRmlZ4=;
	b=WADDzXtQgYIGygIxgPYoxOecu+OZhU5kUlIQbisGD0ZTCt993Re+BIXIl8iDoH6xGhmWN8
	mt/0w8XD8hesoZbh1THm0zFLaYoeK/axD0vOhzr+3LbzxQJDz3xxUQ6+Aa26d9JsWPRI1b
	gLiI4XU4v/lht5njM1+3huzE9n9c80Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-qzbsw1dAPfiO_mUN92rppw-1; Mon, 09 Dec 2024 08:45:59 -0500
X-MC-Unique: qzbsw1dAPfiO_mUN92rppw-1
X-Mimecast-MFC-AGG-ID: qzbsw1dAPfiO_mUN92rppw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3862e986d17so812545f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751957; x=1734356757;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxiqV3TGm/7Oo6r80N5hopww+gDKBoPqmI5cftRmlZ4=;
        b=OJSLqJu1kMH7PDiFT6plHrHMyua38xK5V2ei0dNkFLDR4CG4/3Ln+Z4MDVulFjzN2q
         bOgl9mh3hnvlj3GePzF6mw0YukRaYM0B7Y6D2MVIpSuQnyaWGjuSy3a95VZwER6nJVS4
         nFwbeBcfxoC/DDopvm40r5j7DShYeFYcDEjzCCkRnID51LXNEGMVz4Txq5p8Ht9FVLCH
         sV8pLeKohWoAP0d0T3gK7/ZLyakD7pQtf5vrSXnDTlcKOe+S2knrW85iL9uzbxHlm3d0
         zE5FTYgeCamo3Pt5VdEUqotc6cbIim7XucQM10x2vQgTVtSqhKLbIcar3Cm8PkgP+W8r
         eu5w==
X-Forwarded-Encrypted: i=1; AJvYcCXr4XPAgDQQC9nI0CPu+wI4kU1OoktraDILUhdNk/6THw1Bhdfv2UDBdoAhNn+7+yiARtQv88oMXk2PnSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoXX2b0cPSmyQcQ24afwjrW2Fl0IayEWh+ZpQcwnkl30lm5mE
	xCKsYDGfAmyvZriyDdzaPYXJw8moT7Gm2jjucTHNmOD55U5qwNu+eNM61ZSqXa28mwD5mTC8uhS
	C2rhtsSzPp1c1SmKaDsDvxxbsVIxd/f7GQw7OUKZmM2qtdG59FlTeFr4nd/vyhw==
X-Gm-Gg: ASbGncu7CQJpYEuB1pUkitevSpfhOv/PO974M+yD2Wg4b9/d4cMBQwQcxhZco5hdUZb
	gsNCsgjj2QWtWeGFGbd6zn4wpDviUQM2BQ1P0dlD24fkbHMyqXAjERmzEmCNnKo67f9Q3FzPpgj
	gOKhRWZx3Q0OwB+NAUD+MR9Yuw8Gywfv7FpOeZGYKPlDh9aUAaPXovU9tBqDHXYSbu2r14CdaLx
	cN9xLiVwjReJX+nBGwbHq4Wbwb58zdCRy1dppHXS3BvC922x/hT5X9/lyczSssFyQaeV+f87WhZ
X-Received: by 2002:a05:6000:1f8b:b0:385:df4e:3691 with SMTP id ffacd0b85a97d-386453fe984mr339508f8f.42.1733751957166;
        Mon, 09 Dec 2024 05:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjZpdrpXkqoSuJr5hzkaW5n2FAf94Fy9xuPw2HP8AFNH4tZqxScH5GWr5mODsLz8h6mxtpTA==
X-Received: by 2002:a05:6000:1f8b:b0:385:df4e:3691 with SMTP id ffacd0b85a97d-386453fe984mr339488f8f.42.1733751956799;
        Mon, 09 Dec 2024 05:45:56 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909644sm13435166f8f.76.2024.12.09.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:56 -0800 (PST)
Message-ID: <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton	
 <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>
Date: Mon, 09 Dec 2024 14:45:54 +0100
In-Reply-To: <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
References: <20241205083110.180134-2-gmonaco@redhat.com>
	 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
	 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
	 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
	 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> Thinking back on this, you'll want a program that does the following
> on a system with N CPUs:
>=20
> - Phase 1: run one thread per cpu, pinned on each cpu. Print the
> =C2=A0=C2=A0 mm_cid from each thread with the cpu number every second or =
so.
>=20
> - Exit all threads except the main thread, join them from the main
> =C2=A0=C2=A0 thread,
>=20
> - Phase 2: the program is now single-threaded. We'd expect the
> =C2=A0=C2=A0 mm_cid value to converge towards 0 as the periodic task clea=
rs
> =C2=A0=C2=A0 unused CIDs.
>=20
> So I think in phase 2 we can have an actual automated test: If after
> an order of magnitude more time than the 100ms delay between periodic
> tasks we still observe mm_cid > 0 in phase 2, then something is
> wrong.

Been thinking about this and came up with a simple draft, I'll probably
send it as a separate patch.

Doing this can lead to false positives: the main thread may be assigned
the mm_cid 0 and keep it till the end, in this scenario the other
threads (CPUs) would get different mm_cids and exit, the main thread
will still have 0 and pass the test regardless.

I have an idea to make it a bit more robust: we can run threads as you
described in phase 1, stop all but one (let's say the one running on
the last core), make sure the main thread doesn't accidentally run on
the same core by pinning to core 0 and wait until we see the 2
remaining threads holding 0 and 1, in any order.
Besides a special case if we have only 1 available core, this should
work fine, sure we could get false positives but it seems to me much
less likely.

Does it make sense to you?

Gabriele


