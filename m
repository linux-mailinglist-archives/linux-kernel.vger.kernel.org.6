Return-Path: <linux-kernel+bounces-449854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1259F56F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464F71882FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BF15E5D4;
	Tue, 17 Dec 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ETzIqN96"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4618A6DB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464301; cv=none; b=Tww/MMX5nAxfWbny4xHT5VFVIfjTPXJDFOCUby51hOIwdWJs3bpsc/N4KY6AjhuLsMYbNeYy1u6sPbF+5cmQiTyK6PZUuNNy9/MMyV5eTCXlCeZ4qgFxCGCF+eapMcRi3BnJUOqJDgD0F9PCm+GyU9QKxxiwu9yZ1wOGFp+6XKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464301; c=relaxed/simple;
	bh=BlX5PFVtVorWrjZZejf5sVJZU99ayY7KutQE4SAHvtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXIRX+7H1xgjmjY8poZPmsZGbCi2UDLfEamuDEMI1ZdOjLs69HFHQ1veyjCDZrGJ6loGPy0qmfbcrGhoj3EX3j7Z10jobpTeBvTKccnWfe0CI4t6MmqKrOKR0WlKJjL19H0+iJtRwqgwzeyWXyW1MvGQ4mzyPJ6CmARPtnBrv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ETzIqN96; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so58446a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734464298; x=1735069098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoM1B1YX2SDxMKP/fkuxJP48vkpnRndLUKOmCSwzkQ8=;
        b=ETzIqN96s1gLC1ysTJgvZg8WRBd2/5+DySlrtTUnbPEXn7kGZLo35MKpkqrjslT8F+
         PAvPx8Rs03AQRolhwU5/lfRXp1nntmcZbxK6qLnxCe+rDk8wRERx2y3NfFGIfrQx4yII
         +z+ghfZBjdmQ34sy7KI5w744ouTTtXCKbygVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464298; x=1735069098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoM1B1YX2SDxMKP/fkuxJP48vkpnRndLUKOmCSwzkQ8=;
        b=Xk+uFIIyPA8xCIabGqG4v4+DlOoGZM2LTAp5H8A0Z/mzUoEoCZV21hNXQSh0VRv8F/
         0q/WaQ3NghBukZEr4ALrkzADvANZ9SQTdQoxFKsfB5Tg2DzjREeq/durIhT6BJKVmzJ+
         2Syf2xfxiXZZQOHgLUfS428Z5QZEPBGNwFEcGZvnpUYpcCaSMO0e/Dq3LU7Uy2eyNV2X
         xu2Fe2bVH2FFtyMwAgr9zvaimADezpidWF7e/lj3+28IoisAQOADw91Uly9PqmGe7AtM
         o6+m8sOulZjNsf/MUeaHK7xhFaWiDSq50Cwqi1lxqfywu5iWTaxCSyck4kuNn8Tc9t7E
         RZ0Q==
X-Gm-Message-State: AOJu0YwnC5ygC79jLB+NHAiqRoXWz1DotxkLTCP3HAQI3Xg87v0s6/u9
	yAYBHg47sA2Ki8taFopq6N7Bfu8W4qv+uyxlRBEKQDnTd6iPDf/WxvHJbufpDxS7VCYTFUTOOg9
	lvSU=
X-Gm-Gg: ASbGncs0Bvm4vEy+CH5PzHFvNMszZXG2P3JL0ifUMjun06RPlR03sznxE8v9nRQJ4XQ
	RHaGqwNLg+SeKtVQQ2knoO0oRs93H7h144tmzAr0oW+IjFFzIPHKjR+eHyaI/p+1Ir7vajEXlBX
	34JQRGHGpzY1OqoDQbalxJZ8/+cM3HgaBYBmAjKuRPIHypzuxloYxPEritI9unSRKdzBb18aOla
	CdGCh+X0pr48byjmB5Bj3guYFEyFyW1lF9i4NSzpXM1CBv93Q1oUT1oG+y9rgTKK+Ky55BFkm2/
	t/j3/d/KAHwWvSJ7RY65nRhXxwcv3aY=
X-Google-Smtp-Source: AGHT+IE8YjYu3kbP5Gx9Idl1DvkSQve8Lh39Q6Uf9lpxrmcGb+LXaAr47pi8hiD+IYGCsRpclDEInQ==
X-Received: by 2002:a17:906:328d:b0:aa6:50ee:d44c with SMTP id a640c23a62f3a-aabf43b77b1mr2387766b.15.1734464298152;
        Tue, 17 Dec 2024 11:38:18 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b267dsm473772166b.179.2024.12.17.11.38.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:38:17 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa692211331so6793566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:38:16 -0800 (PST)
X-Received: by 2002:a17:907:608c:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aabdc8bd564mr467326366b.17.1734464296273; Tue, 17 Dec 2024
 11:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home>
In-Reply-To: <20241217140153.22ac28b0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 11:38:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
Message-ID: <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 11:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But instead, I'll replace the text/data_deltas with a kaslr offset (it will
> only be exported if the trace contains data from a previous kernel so not
> to export the current kaslr offset).

Right - never export the KASRL offset for the *current* kernel, but
the same interface that exports the "previous kernel trace data" can
certainly export the KASLR for that previous case.

> Then, on our production systems, we'll save the meta data of the events we
> enable (this can include module events as well as dynamic events) and after
> a crash, we'll extract the data along with the saved data stored on disk,
> and be able to recreate the entire trace.

Yes. And if you save the module names and load addresses, you can now
hopefully sort out things like %s (and %pS) from modules too.

Although maybe they don't happen that often?

            Linus

