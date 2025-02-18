Return-Path: <linux-kernel+bounces-519479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D13DA39D56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1AC174818
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B82690E7;
	Tue, 18 Feb 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPbVYq27"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA34268C74
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884895; cv=none; b=tjlShzbnPzw59XL3+CWguZcOjIXMpL/GhDoiLkRhOshsNvVlZ6GRoNC07TntFFI9SKVwHnafRvmhKzn5+FD3qUB3Nj1PRTRFTBtyjBSrUeTFg+ln2sFkBbU926EQcuFpb4+sgguFyu31JDhBPpxOwc1dwIWQg+HI1Al7FVQI5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884895; c=relaxed/simple;
	bh=vNJSYCuYen7yBiUlt8/F/NhDj/0DDvBzBZsO/cYBZN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHdkTREpqFWkSSn95rwWDeudt93mdbDk8fzTmht4YN/OLmE3k1dneG3EGPr+kMoUvggpTndfSiys2q5XG3gB4FgNIkAsoIK3NykVSOdPi0xFG1xeAGU4Z4XM+Ke8LQhbWBCIGdwFWD7kE0s5gIu4+DDF5X09MBiYyvmbyca3EF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPbVYq27; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb705e7662so568760066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739884891; x=1740489691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VRsn+AEynXrzDApi3GOCSB7kda1CeXhMpv+TvTGpE8=;
        b=nPbVYq27ZawqQJs54gG+N7vhAULaE74Dqem+QI0sRYaGaOIjWBLt2QoG5tcUwc3LMp
         djms69G1IJbBIk1ct6zk7pVYqfjOSgeYAf1iWCENh67LoeMVSEmtydzKgGJj8Tc9l76C
         WuuqeQDDCyIOEkOllnD6jyoXevFsQcasuZukogKipx1PWdsMNubuA/XAumbQ6PQB0tCr
         LDq4O7XA4VwzBc0u7AbTzZgXWfg3RuYBBH7nZtFulbaQoQ33NLbqRW0+sYsNyXBfmtlh
         B7bTNzWWkIdw/MSwZRTtOdCcvSY0gklRCtR63UEM1Bl4QUWvq/a9E0hNY2sAlnXk0UBj
         MlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884891; x=1740489691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VRsn+AEynXrzDApi3GOCSB7kda1CeXhMpv+TvTGpE8=;
        b=ZZbFlz3lmtWp7BYH3XcLGeufrHqaFMNv3hlW1CLO4WWXNyBe3/UXO9jGgD07NJonQZ
         rrUyQ4/9b3K7bro6UPrqS74X1+caTO4I8P+D33kby7t2qhyhbx9m3a1quzTErOfH2eij
         yWU2VBBgSl1WDSu/6msbqGsjhKFa/afUxd566uqgOg40aF4y8TlqoKe1F0L4mfIfGIMT
         rhBQXlBewTKxhSZ2M0YlZjSG7N9VghCGulHREqZ8PzKIW/KRXguryndV+w7QXEOURtXK
         FQogCs75jRTnqmqF+hgzlSIEK8K8evHQiC9fhF7etGr7cwHiO5HWZ/S2R4mFU39pDZgY
         X6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhfRV6m3riNygJ+adCuyQGfm97DXiL/dGJcE2TtRe+JhRj2UEItFjFxKhb9nxioY6OxkX5Q+1HjKP1ubA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKs//Fi4Tqn1N12xKBTR5MqozXeB6/uXbVi17wd2ncpUMqAvv
	Z4pvr+dAYbbsvGd3xIVIplxN66BjVH81CV4ySfTIv8BMCaW3Cev2aXKwPCyRmr6aE0kqz/PhKSk
	xU+uxhP+5stsv+W86PzINM+lO/tsdO5NmeGfe
X-Gm-Gg: ASbGnctnj6f06Ue9YY+mdtAOrguf/dG9U3B261zKJwhPTXvo2Hy+yLJN/HL2eqJGar9
	6UY31heNhcRUfoBxDNgiOFUewzlnj/qZzirbt7farmlPSgI0xY24glh9KlJV80v3rWYVWsjMu
X-Google-Smtp-Source: AGHT+IHENWMLQyMCFNyQoxq+tfzbXqrmhbnicTEoipxWjXHMkPQJj0dvAxcA8gbOg9IcuPizgSbv9RYX5Ub2iiHYQEw=
X-Received: by 2002:a17:907:1903:b0:abb:c457:af69 with SMTP id
 a640c23a62f3a-abbc457b75emr101178366b.0.1739884891353; Tue, 18 Feb 2025
 05:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
In-Reply-To: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 14:21:19 +0100
X-Gm-Features: AWEUYZn0nWNA0Mz8GXU5V1iIM17iCX9C2BuP0-zp0BUC-CYDsMjMQia2EAIfB_0
Message-ID: <CANn89iKyKTD+vQwG-h=oczX=tfBJeY9SVmXFX4a7yMXJCvuJ7w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
>
> Meta has been using BPF programs to monitor this function for years.
> Adding a proper tracepoint provides a stable API for all users who need
> to monitor TCP congestion window behavior.
>
> Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> infrastructure and exporting to tracefs, keeping the implementation
> minimal. (Thanks Steven Rostedt)
>
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
>
>         rawtracepoint:tcp_cwnd_reduction_tp {
>                 ....
>         }
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

