Return-Path: <linux-kernel+bounces-543467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F04A4D5FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7071B188F8ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071041F76B4;
	Tue,  4 Mar 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRSllnEQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D9189528
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076200; cv=none; b=naRWxYe5HqOLhjWBTqrdE8Yy+YMv0mApUTAxcXjXzkS6qfjUtikvbmAuoTB9Y5JDs5X7BK6MvUHX3/YzrN0+JuXhtKI1GOUkUjFvZRMpVeiD4+wOGpehcd1gF0YWphYtC4peHmYHnba6CnuRiyH1VYVWRm1Z9gp32GEpwmTEaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076200; c=relaxed/simple;
	bh=khm4EmiNLvGmRMgrSmpd/+IhomwQbvLQADR2d7d1yWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LI+H9OStlPLkgg/fO3fh/cQI3r3VFfr3d15BdFyopqV6oNGy0geWWKikYVFvJq7XOLLGGJQuucNeT0jqYq43zhChg2TMyu/QZoP6odJ0cDNQXpjVF329KCeIO3wyKb8dhCc3SsgfhE9KGPDSnEMgOBoYm11J/DMDd98YKdy3htU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRSllnEQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741076197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUgMRCAGZlkwZvHjUKYfD/4Ww4ioNcC9Etu6fPpviRs=;
	b=MRSllnEQ90+b2jgHommRUH1/wP+xAMxqyJ5sOGmE5Zt6tLe9XRR6E2xwdGlkqz5KG4LzU+
	fWHMsfT2h/wWAIwsVhWV5xCkSDZ9u0hZFh4ZZSdLnkXSV0Y8i/fGIVfEuVxr1w2U201JYx
	skrklTY4N2Gjl4WJlFB9LAr1n3epu+g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-1yBCRplWPnyLRSsqitghpg-1; Tue, 04 Mar 2025 03:16:24 -0500
X-MC-Unique: 1yBCRplWPnyLRSsqitghpg-1
X-Mimecast-MFC-AGG-ID: 1yBCRplWPnyLRSsqitghpg_1741076183
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abec83a498cso515766766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076183; x=1741680983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUgMRCAGZlkwZvHjUKYfD/4Ww4ioNcC9Etu6fPpviRs=;
        b=JDIVVXls5qA3M2waEXdTJeuXRZuRCPenR0jtw2ixcWu4wEdlCd6XYZ/GRwtdGOzoSP
         +VTmDsq0puhBfjOjel+yXmxofnx1NYCM/vYgkwpb+GwpdnQLfDp7krWUDJJ7O2zAASYN
         ScJFEiphJXs8k1h1VVO5tv/cAeAI7iFkqUPS0nW+ynsb73eNeVpEqqNWx0/l6cAiMk4b
         CEsHIq1rIAaDuHR9e0VjEO4EYNHv2Ny4+FX48OJW8TdDsWK9JVmu5RStE3V2D8eig8rA
         GYrqYsHFfjqa3LcV3lbtN9wNx0h6JcLwli1tH4LxAqUcAWVaVoOdeIkSKj9SOERFwz1/
         vi8w==
X-Forwarded-Encrypted: i=1; AJvYcCV/CHgSZwqpz4YZCwhc4bhmOWW9Rtk3+6wYzBL3pzmgISJyoGqIsLrmKnSMdxwaPj1ec1e3xoIEl5upstg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP7fP1douEm5sHb3xLHRwrUUN4BwvB+Iw7fldXVx+6P73hywNt
	OKEuSN8yu0Uj+qMdnul3nBnTdtbmgHTbw0ROstcmFXzETKbusAAWgi1/evrtvbs2qTIPDiV4YXo
	9P5dURY+s3mZmE/Ovv0wh5xgSEkA0qtQiuCbEzLhdaqCBIMecvR5Y+16siyJ30ZekAGHeHyXHvs
	jz/b2KESqKjyPE2uJ1113QUSdH6GI74i7bYJus
X-Gm-Gg: ASbGncs+WbtaBR1qZoNhMR8S204IskKES4eDqJFBpt9D9czJcPZKyiqoxhg2aQlE5rN
	r+GJYUvxD3d//MxoVzivbZd48uz6zaotrEd2n6vJKDjW56SJ4aR+5A81i6bSPbCRw2IYr4b32
X-Received: by 2002:a17:907:3e20:b0:ac1:ff43:82ae with SMTP id a640c23a62f3a-ac1ff43873amr34734266b.2.1741076182974;
        Tue, 04 Mar 2025 00:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjiPfIdcB3OCzKh+jh3HKi8FlpNQ6//YB5I9MwloiSuoOecfrDnAbXgaxiSFT6VO8pWV9ho14eLU+RwbcuDRQ=
X-Received: by 2002:a17:907:3e20:b0:ac1:ff43:82ae with SMTP id
 a640c23a62f3a-ac1ff43873amr34731666b.2.1741076182612; Tue, 04 Mar 2025
 00:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
 <20250303150351.28007ad1@gandalf.local.home> <CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
In-Reply-To: <CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Mar 2025 09:16:11 +0100
X-Gm-Features: AQ5f1JrVUoV-90UKowSRdIKpA9oMwx4TT4SouneOst-Pd5TOz4Zdk6JbARKYjBo
Message-ID: <CAP4=nvTCVLa5MzBbJVz=S_ZiDoJ2hY-8fM+uRnGgumi0sFivWA@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 4. 3. 2025 v 9:00 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com>=
 napsal:
>
> So we need to stop tracing here, before we save the trace, if we want
> to do that. Perhaps combining this with the cleanup patch [1] and
> doing the stopping in save_trace_to_file would make sense?
>

Also, the patch will also save the trace if running with -a and the
threshold was not violated, which is not what one usually wants, e.g.:

$ rtla osnoise top -c 0 -q -a 10000000 -d 5s
                                         Operating System Noise

duration:   0 00:00:05 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max
Single          HW          NMI          IRQ      Softirq       Threa
d
 0 #4           4000000        37712    99.05720       10998
555        7624            0         4011           34           2
4
 Saving trace to osnoise_trace.txt

I believe it would be better to add a new option, something like
--force-trace, that would be used to save the trace even if there is
no threshold violation. -t/--trace and -a could then be used with the
same semantics as before.

Tomas


