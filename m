Return-Path: <linux-kernel+bounces-530688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8EA436D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D843BA48F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C55215F45;
	Tue, 25 Feb 2025 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJju25S5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12F1624F5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470526; cv=none; b=VDTNARPDSNXXS3Ez9lITiwhYPYA0xSDC4H23mRaMW3UjZRqNQ12xw3ExNrpQKwhAGrpDHWZKEcaXTVcsPIomBjY85UoNd61L+lboSiLt/EC5IIbVTc49O8MRzzXmC3NwRb2OtPmDW214feL2aJuHVUnJeyl4WCO442FM0oEkk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470526; c=relaxed/simple;
	bh=YnEEavwYJZDtuHSBVJml1w92O0Db5z5AgLmB7SLsUUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1l1zYedrmguOWlG6mqYdjVc703pKmWXo1xXS6NTyKS3NM7ESiCBexFNx2LT49cDvll+RBP/K3ZhnsOnIMZl+ew602ejIZ05qJhK2yzuNh/1UJbRWwUOJwHPqu2+x5lK4xr93Mc12f3W8ctXChCQOIsOGpcvdpE2isRQQEcxeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJju25S5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740470523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XGo/Cz9/crDfpQp8ognzNaewpjAhfMb4mr7HM/IjQg=;
	b=gJju25S5yZ48wVzyaCY9orjAdBwUTd/hVS6cpHQK05i/VFVtGr7WzojJyT3k6fj8xlNuOU
	w1BPoV2Fumfw/VEY8Zp5xH+hImroe/9AJxOZdccwNnbjRx4BHBb/VoSlp7/0SthQ6N257M
	cOO+KIDu4iPtt0HuusaZ3t55pKjaV1s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-mZ7HamnXNre_n_9QzqW3WA-1; Tue, 25 Feb 2025 03:02:01 -0500
X-MC-Unique: mZ7HamnXNre_n_9QzqW3WA-1
X-Mimecast-MFC-AGG-ID: mZ7HamnXNre_n_9QzqW3WA_1740470520
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f2726c0faso5728943f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740470520; x=1741075320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XGo/Cz9/crDfpQp8ognzNaewpjAhfMb4mr7HM/IjQg=;
        b=tDIvwHaUJl2VbQEG7aQsYx/b6diU6rPh6GJBl5WViexrOCCFda+ziycID4wK9swFIY
         uqoWrEH4LsVlD+1CuZJkiojeXebUWuiqBlCsLzyrbgyNaBFEqqBPNnq9PGuh9FOP8IEu
         WXqgMTsG7Za3Le5ByZXGdk01FyBShOdDdGaXnvwkgskRVkf+sNvI0DqvJOMHH3aZaJ83
         HPs3cFKlDtjlndIY5tUteSKxh93EMqYsfTh5GzMiYMXJfjVPCrq0HFwapC+E75RmPsHm
         w1qLDeYMXwo1bBGBoRZzvKetCNXNX9Y4nbmLerzf6gc6AVtbMZSF6d+NOtxazD3pdxkE
         KYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuSFUtlyZQ8mHNGBC44lF1BCX5CBevcatHhGZGf5CxnZsqrrJrdhKoayzt/ymQnVqvJf4tEr/vHCssFXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNV6PobQVJVc7I9NrE3KYosAXqJf9kvjyKeH3vpkYgeMjXmSrs
	7F4RX1Q0cR53w88yTpYZDhOeDz2p/tBLYazF0bhXfN3ZXtEQESi3n7reoNjehdBzfg8wybelp49
	ZT8if+khNIVddDyLrOY1uFkeUlyRgXQSPmPFY8Sx0p8vL4pCULq3YRNypF5GSDq7tUPfQcFaqrG
	OVRYUgBDUxaPeR2wixK1uIJFL6y0LHoerKb6Qs
X-Gm-Gg: ASbGncsiW2cm7JKuQq3nU7cHmFsqmGqlDT78jKR1B5TVBiOSY63mZBSuM68+YFg/Sm8
	3iNuXtettmWhyIfbkB2H4Igh5HB1BRRri4rDkUKAZ9bB25iJH9867FmvLLcBnXuEytQa8oLpV
X-Received: by 2002:a5d:6486:0:b0:38f:31fe:6d12 with SMTP id ffacd0b85a97d-390cc6047c0mr1800962f8f.19.1740470520396;
        Tue, 25 Feb 2025 00:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAwnouvqQYwGzF53Gyq1y+LLEfT/I1L+DL0ZbRwqwq2iA8+bCBCuZkfO9y62AXgZlT9ODgJ3ipPnECL/jbi1s=
X-Received: by 2002:a5d:6486:0:b0:38f:31fe:6d12 with SMTP id
 ffacd0b85a97d-390cc6047c0mr1800915f8f.19.1740470519957; Tue, 25 Feb 2025
 00:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
 <20250224131049.3a4d8945@gandalf.local.home> <20250224194804.73c57307@gandalf.local.home>
In-Reply-To: <20250224194804.73c57307@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Feb 2025 09:01:49 +0100
X-Gm-Features: AQ5f1Jr5-UKzHEgkzPswb9BJrLhKytXXqINxw3_nKdoaORJeSRXCn3g760yLbz8
Message-ID: <CAP4=nvREzbs3r+Na9qF1gPBV0bRnKM5KM4qMo==daT4DuVhdGA@mail.gmail.com>
Subject: Re: [BUG] Crash on named histogram trigger with invalid onmax variable
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 2. 2025 v 1:52 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>         list_add_tail_rcu(&data->list, &file->triggers); <<<---- SKIPPED!=
!! (this is important!)

Ah, so the issue is that even though hist_register_trigger() has been
called, that is not where the trigger data is put into the list. In
other words, to be able to unregister a trigger properly with
hist_unregister_trigger(), you need to call hist_trigger_enable() in
addition to hist_register_trigger().

I (naively) assumed it is hist_register_trigger() that adds it to the
list, which led me to think that it is hist_trigger_match() that is
failing.

> So I moved the code around such that if event_trigger_register() succeeds=
,
> the next thing called is hist_trigger_enable() which adds it to the list.
> Probably should be port of event_hist_register() instead, but that could =
be
> part of a clean up.

I agree. One would expect that hist_register_trigger() and
hist_unregister_trigger() are paired with each other so that the
latter reverses the action of the former.

> Looks like a bunch of actions is supposed to be called if
> get_named_trigger_data() returns false. But that doesn't need to be calle=
d
> after event_trigger_register(), so moving that up shouldn't be an issue. =
At
> least I can't find one.

As those operate purely on the hist_data, I cannot imagine there being
a problem. The trigger isn't going to activate before being registered
anyway, it makes sense to first finish setting up whatever we don't
need the trigger data for and only then register it.

> Can you try this patch?

Yes, the patch you posted gets rid of the panic.

Tomas


