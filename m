Return-Path: <linux-kernel+bounces-575660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72ECA70575
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2564F3A80B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D21FAC34;
	Tue, 25 Mar 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZcTFur1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455429408
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917535; cv=none; b=cW6IapT+gLUqdZNwjDT94mod6elCCL3oyj8Z2FMBqYK1A8JIql4fLyPvFVkplUO37xJwGn/w6LRcgPhcXWrn985cvj3FTShCFURM2AnA7THJlQ4VFPJyKUl/NYrswLc2bhekwTq6wD26pNqKOkyvOtffeBnyOpXQRnXoteIaHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917535; c=relaxed/simple;
	bh=JQEjr2on8+kv5vKVliFWTuZoI19mgZkdWVxtpyWLWw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buAKsuwDh86+3Ch+QiSR5MLnkVUKF3WTQbKqc+lxB1ptStSQhYNg/GD+YTN8woTKL1bH8tlvVUE0bVrT0fo6EvVQhY0jkR29Ez0FvxcLN3Af5aqXk88HPSJjgwh0ipYUEXR+Q8pDtPfZ2dGRmPQf7YD65FVMXtUp+DaBYqBkAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZcTFur1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQEjr2on8+kv5vKVliFWTuZoI19mgZkdWVxtpyWLWw0=;
	b=MZcTFur1uzFTGoVIcactFVCdfHEYe0O9SKs5YKHQYXum+dYoDWae2vKh3OxqktJPHAeiRb
	to/XA6yaCvJJHGXpDfkJaQsQkuojcD3OT67SKlV243iJnTVfTXbD1KbzNYlKjtuUeyY/uH
	xm8SdJ90lo1MiwFd7wMZS9tEjTBRFNc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-zWyJ2tDwMG62xBvQlWiY5Q-1; Tue, 25 Mar 2025 11:45:30 -0400
X-MC-Unique: zWyJ2tDwMG62xBvQlWiY5Q-1
X-Mimecast-MFC-AGG-ID: zWyJ2tDwMG62xBvQlWiY5Q_1742917530
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3c219371bso496957966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917530; x=1743522330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQEjr2on8+kv5vKVliFWTuZoI19mgZkdWVxtpyWLWw0=;
        b=X0Cs/y9g5svM2g6++lXRiaRhpF+xjhbR88iwHc66sfDBtCQc4gPCs8xlyr4OwxN1rY
         c5Y3zrxLVEcLy6SEnBqe7DK4O9VSpr2QJXk+ZzDksZ0URWzSX2SbzA3N26rVluOCDPZv
         rqF5k7imsgoqhG/0WXgeY4OXriELOMvaHRgtsGkhkL6W8US9hCG5ZLVYMCa2lOQZyDDC
         Ew5W+GZM8/W8kwmNT++y1scJTWqcPU0udA1eIY5uVjnInyUeoLNaZoj2JWL3nZQlvkgs
         VTisBYAmWzaQ8SepJE6n3Gypt5b1Xqe/bN+R4BZ8sFIzJ8eWqqVnezJwYiiueBNHQvhe
         /hfg==
X-Forwarded-Encrypted: i=1; AJvYcCVCE/tUq8w0foGH2lyjbEgWWl7VZXX3TU2De2UI1RN5tQVQIRNqAimHxYicLn2VBfbahKORGvqdFhW9Bfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhfkNt9RmGns4qgN9/WFpjjAsobdICo4pc38yavflfebcDB5H
	5mJAqSCm7Pi8g4IJhT0Or6MOT2GK6w0F38Tk3zhsVg/zvWNUqXkAcs57EsqozLpf3lzjRYGIwqi
	uutB0k0ap/3Jm85kwVshxHFEK3qCQ4vKnHjl4/maXbYEAY2o9hsaX/WDFif9vp5H5Ec+4Napu3E
	puW92VkZX9WF2JwpFvVHgIZZ5m9oV8w7tw2sDc
X-Gm-Gg: ASbGncuSkFFeROye/0+HZs5g3ijQ5eX2l9adAePWTHvgQp22OonZTQi8ycFGHrDE/Tq
	GImgvCmvDE5ce+nb2riyI4ku3Qeli0j4C6XMMRiSxtrHVj64ISxj/2ddnGto6S+MhUIj7wVXv+A
	==
X-Received: by 2002:a17:907:d7c8:b0:ac4:4c5:9f26 with SMTP id a640c23a62f3a-ac404c5a21cmr1536626866b.38.1742917529641;
        Tue, 25 Mar 2025 08:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeETmw4framl80aCDPCZ4HSMAoLbK1xiEJNCo4pPB8lZTQdmb6dcWKlzwYlP9rfQiUfuMemc5QS9iw9mUlDig=
X-Received: by 2002:a17:907:d7c8:b0:ac4:4c5:9f26 with SMTP id
 a640c23a62f3a-ac404c5a21cmr1536622666b.38.1742917529240; Tue, 25 Mar 2025
 08:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net> <Z+KXN0KjyHlQPLUj@linux.ibm.com>
 <15370998-6a91-464d-b680-931074889bc1@kernel.org> <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
 <CAP4=nvTUWvnZvcBhn0dcUQueZNuOFY1XqTeU5N3FEjNmj4yHDA@mail.gmail.com> <a5cccd3a-ff63-4adc-aec1-ad61a58a4b25@kernel.org>
In-Reply-To: <a5cccd3a-ff63-4adc-aec1-ad61a58a4b25@kernel.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 16:45:16 +0100
X-Gm-Features: AQ5f1Jqv6H0g9eUrhfuNsHW2oA4i9dAk4ttrUyj157jQhQy6qdUHoOKA23K7Rx0
Message-ID: <CAP4=nvTUcMfXgfLNai2OQmnEiy5wv9OHGZyA1agdA+pUi2cHYw@mail.gmail.com>
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on linux-next-20250324
To: Quentin Monnet <qmo@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com, 
	williams@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 3. 2025 v 16:27 odes=C3=ADlatel Quentin Monnet <qmo@kernel.org>=
 napsal:
> Sorry I don't understand the issue, why not simply rename the variable
> that you introduced in tools/build/feature/Makefile at the same time, as
> well? That should solve it, no? This way you don't have to export it
> from the rtla Makefiles. Or am I missing something?
>

If I set BPFTOOL in the rtla makefiles, then it won't propagate to the
feature check, unless exported. I observed feature testing of clang
works, because CLANG is set in tools/scripts/Makefile.include, and did
the same thing for BPFTOOL.

> I think this was the intent.

I see.

> The variable name needs to change either for rtla + probe, or for all
> BPF utilities relying on it, indeed. As far as I can see, this is the
> sched_ext and runqslower utilities as well as the selftests for bpf,
> sched_ext, and hid. I'd argue that the variable has been in use in the
> Makefiles for these tools and selftests for a while, and renaming it
> might produce errors for anyone already using it to pass a specfic
> version of bpftool to try.

That sounds much better than renaming the existing BPFTOOL variable,
thanks for the suggestion. I will send a patch tomorrow and give you a
Suggested-by.

> Note: Not that many dependencies, most of them are optional. For
> bootstrap bpftool we pass -lelf, -lz, sometimes -lzstd.

Noted. I must have been thinking of the entire long list of
dependencies in tools/perf/Makefile.config, completely unrelated to
this. Sorry for the confusion.

Tomas


