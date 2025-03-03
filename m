Return-Path: <linux-kernel+bounces-542077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927BA4C541
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CB518980AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494B1A08AF;
	Mon,  3 Mar 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q86B+k2h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5023F36F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016089; cv=none; b=ZuFT9ejAmobI91QeGbSlIbUKa1kfRq0/JAbdboNmiU779hxE13O/+vG3IcZdOSfW5tFsyndnrCiwvLy+2pHMPi7271Rf1jxuhT8nTbO15xYxp8d4iBDb3Od3b7o1+nBvd/hJXX0vJWO7iK/RHXBHQG4ywpTmqwfcaVvt7w+nOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016089; c=relaxed/simple;
	bh=Ca2qBuXoBttJq4mL06NxtHHTUr9UHSwapOZGMTJpNFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g81NSHWLRmmd/0kJiOeMhZSzJdLMlN83lNPzuyjVVMzGhUKy9P25XB0iXshJmM/V3xr29gKn0R/gl4rnpZ4YC/Td4YzFvCFM1iftSFJTvInT4v0yU2+W6gLvA/1WjAdDU14vX0Hni98g4wWcLGhN86XwEFQqKcZnpvGmku0cj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q86B+k2h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741016087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ca2qBuXoBttJq4mL06NxtHHTUr9UHSwapOZGMTJpNFs=;
	b=Q86B+k2heFoIOZpIEe2znaKwE55k95oOo25oUNM5fF0NIygi28a634Jh7Dl7Fua7jD2wgO
	YMIASB8q0/lwQijJpR1h65tQ3Wa7I9cCmLjMVdGDHMkMt/qHXLCU8P7Kw7v4bxVzFnqcSX
	RcluL3jnOSTl07dv/JkCqjyiLfS37tA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-RjW3lqfpMb6kHEJhxn916Q-1; Mon, 03 Mar 2025 10:34:33 -0500
X-MC-Unique: RjW3lqfpMb6kHEJhxn916Q-1
X-Mimecast-MFC-AGG-ID: RjW3lqfpMb6kHEJhxn916Q_1741016073
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab7f6f6cd96so549887066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016072; x=1741620872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca2qBuXoBttJq4mL06NxtHHTUr9UHSwapOZGMTJpNFs=;
        b=sFantwM7xEqapxjyQb4YtxAAgOVtFfdYyAj/zaDceE0LJYdMbsi2Z7nDmHeg3+RGxX
         6lAVfGTkTfunmB9q0ngdnoC57UNHMkRh9DV0ZhTan+16HjWFOYGug2pBaQ1HUYsAnrsM
         xV7Houe+7g5cak0IwdZ8jP9kTvY5GDKXc97D9SjObbz0eHCkVLfDEHWkdnUrgiCuEc83
         radSOFhNPTN8pjPAszdOQHoguONomp3Jr1KUrNzyASmrQmUixEwogt8wqKHSfSvnDvv3
         aXO1auwjkNVC6jrKQHVq0RZVjlPtcfiNfTGFB0OP1w7QWILGA2QtGk8ba1DsbtuZEJD1
         9gmw==
X-Forwarded-Encrypted: i=1; AJvYcCU8lqT+jyEfPHXNa3UgtT3r0FBFVm5CxgsO+4DlyjpyUcBm+ivpJYQmtIegbE0yfjkSNApnIjuMHn0G+iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstpRdn6YaZGW27XxtTaOl95iDilEY6IG6sgoWlBK5+SCYoG0T
	wmcbXhn/To2ebll3uskTws4zHCXqwSk0BK73ATfkw7wbt8YChN4XMeWzfYEj4ggZTj+J6HE1/2n
	h61XSa0pT/J9jldEzXdNN8Zbdzow0xpH/1IYAZ2xQrisprtezuZTJximdijsVl1Ojg2VZGe0FcQ
	mqHqzSG2XjI5vN6aEKRoG8YWxRZZ222VmkrkBS
X-Gm-Gg: ASbGncthOgdg5D3C4wUSnVQ9/T9pVS5W5QM8ea4iQaM+BP8yV8ybXoixzkXhfE9hV07
	S5r2Pa/77eTTBO7Vjm/4iAGlWGn7h884zTuFsmN9LEWxQt6cLrqbRqz1A0U7kELNJC5oxtrvKi5
	3DlQr/bhzJO4cw8c9lsUijcNSZ9iY=
X-Received: by 2002:a17:907:9815:b0:abf:529f:eedc with SMTP id a640c23a62f3a-abf52a13846mr1007386266b.17.1741016072667;
        Mon, 03 Mar 2025 07:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAPhCygFos26ctd560TT1gMWRr3/Uab+HZgsRTIPBxptaGMGDWgtA55byUAFQxa/MLgbkRkUa6mNfpUo1buDo=
X-Received: by 2002:a17:907:9815:b0:abf:529f:eedc with SMTP id
 a640c23a62f3a-abf52a13846mr1007384166b.17.1741016072362; Mon, 03 Mar 2025
 07:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com> <20250227200623.60f20571@gandalf.local.home>
In-Reply-To: <20250227200623.60f20571@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 3 Mar 2025 16:34:21 +0100
X-Gm-Features: AQ5f1JokxHLLpaJHRnPBCkMVVdRSxJZSq3sfwROW0wf1tH0Av2oob8BpykFjucM
Message-ID: <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 28. 2. 2025 v 2:05 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> Without tracing being off, this can run forever if the events come in
> faster than it can be recorded. And save trace uses the "trace" file, whi=
ch
> is slow to read.
>
> Are you sure you want that?
>

Isn't that a different problem though? As far as I'm aware, it
shouldn't matter at all whether tracing is stopped on the main
instance for collecting the trace from the record instance.

If the record instance generates a lot of samples, this can already
run forever, regardless of whether tracing is stopped on the main
instance or not. This should be a separate fix.

Tomas


