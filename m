Return-Path: <linux-kernel+bounces-424866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C09DBA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A1D160F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D001BD4F1;
	Thu, 28 Nov 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXfCgYiM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1F1B6CE1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807563; cv=none; b=VNbIQuTh+WCNrohbKnGOk3H9TkP96wDrCJ7xLpfqJYUnfWAXCBHo9mZFSyZABPAIlhnV/+zMDk8NSbeiOivB1KMW1OwanoiBUYOhUHpYEM//fywT+xXT9BviVc9IscfINDQ5BXTncUo7mBO0UEdTAgyKOlx1VH0dx16EbQd8NFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807563; c=relaxed/simple;
	bh=MXd4l6+iQmQnfD3BLnMGFSdnuuNa/etFN+OYpi5oBN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwz5Q74rGO2xN21appkuu2PmPI+9RsqYwMfDLj/VugJqFqOdloQIQoAyR8GkdF81L64HMDE1ce/hLJIQf0IHlcPpnPZr6sK4UDZO7cCMjPRCjij2NWOCsYSJh2WMo0cz4y3+pjEKa1+WGNXO2tRrP2I7LfbSgK9slYOk3AC7toE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXfCgYiM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732807559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXd4l6+iQmQnfD3BLnMGFSdnuuNa/etFN+OYpi5oBN0=;
	b=bXfCgYiMLKRSXxyWkWvDRfx6gFnf5RYEjnrUVQSPdzyqle9HHaJjK9qz3JG3W+4fPqlUCp
	Mh5v1+UDISOJvgz6leK3QPx64x/sGqxKndR1SNRxvlUerpE72Gi2aifBfsvZrukXn+17UJ
	pw7sTe+abW0+CsVZgTZapf96P2IdOl4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-mG_pAbyhNdiqWOctp5gdFQ-1; Thu, 28 Nov 2024 10:25:57 -0500
X-MC-Unique: mG_pAbyhNdiqWOctp5gdFQ-1
X-Mimecast-MFC-AGG-ID: mG_pAbyhNdiqWOctp5gdFQ
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ffb0921706so7940511fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807556; x=1733412356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXd4l6+iQmQnfD3BLnMGFSdnuuNa/etFN+OYpi5oBN0=;
        b=lhBJ6DvgojLI5382WJJ6j/ZJeQSI2zYzvqt6jHXqXJCcSxonByEaDjsbcqrOa8dtd7
         avmiVbpTcu9RmtVXFj/B5wdmNHpg/5U2h1K0BoQA1E/WGw+KmCaLFyb7OZe0SgkBJaqS
         FVy0ICIWrBBLj6I6o77stHERMJiW9cslgTpI4dWZKtpfs2Cc0djFaxpHF8OCIEJmslWs
         dOyzqrXKCdybCW88I8Za8Rt6uLREz78YcVWGndi6u3Wee2smBZ9YLBt66l5OcBhZqSyM
         jhMVVlFojyXO3xYjct69A1+MTMWG9HmYm4Zyvcryx4AfzLwl+JYMSz4Vt0nXQxzAuG6t
         xm3w==
X-Forwarded-Encrypted: i=1; AJvYcCVMRUQgeKjs1hl2++cGK/+iqMrVW4wGFcZB8F0/EXQxML4i1raPbw+4T1lB2hA+jqY+KJfpd1QNRwX2WqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHEMnx0DhDlhmcC6Sx+uwouPQoa3knIAqaoQEyqoiD1tji2Hh
	nWG/7jLHXiF3wSzv7LXraw3/jqlId75MW7OKaRegfulQ6iaK480REYeFjCdybwep7g5kh89Rig9
	Men1C5JhipK+WuRKPZYtcn4Gz11HukejvclV392ypQcN4qsVhdz3OObQaK5AY8B3VFKm5cTmAcg
	W8R55+StM8RRkORASdyo6fBl4FXizo9IHFQMF6
X-Gm-Gg: ASbGnctPsAJ9oxnWwN7dTEasCaN5CYb12PQQCpXa285DaIyXvZy5FivrStzIffeiet6
	LeZycOpoe3Yo6Q17Ww/Epf13ZOlCiO6g=
X-Received: by 2002:a05:6512:32c9:b0:53d:eef7:a017 with SMTP id 2adb3069b0e04-53df00cf65emr5725104e87.15.1732807556117;
        Thu, 28 Nov 2024 07:25:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUDRgJvQYM+JdFcJ++bS15Z0GZU2YBr+5bjatsFWQinG+yirtbrqloo2N19HWJZBdciblzJX3Lg8Gg/26Guhk=
X-Received: by 2002:a05:6512:32c9:b0:53d:eef7:a017 with SMTP id
 2adb3069b0e04-53df00cf65emr5725087e87.15.1732807555727; Thu, 28 Nov 2024
 07:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org> <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org> <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
In-Reply-To: <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 28 Nov 2024 16:25:45 +0100
Message-ID: <CAP4=nvTjdZRfWtpvM+gThPv6SghW96i9YykA88vAFH5x39GZqw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 18. 11. 2024 v 11:13 odes=C3=ADlatel Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> napsal:
>
> I had to modify the source code a bit, as it does not compile with my
> uclibc toolchain:
> ...

glibc added a gettid() wrapper with version 2.30; earlier glibc and
uclibc do not have it. That can be fixed by conditionally including
the inline function if on glibc lower than 2.30 or another libc; for
reference on how to detect that, see how kernel self tests do it [1].

As of the FOPTS changes: are those necessary for rtla to build, or
were you just using them for easier debugging? AFAIK rtla shouldn't
depend on unwind tables or stack protection for functionality.

>
> But it is not enough, as executing rtla fails with a segfault.
> I can dump a core, but I could not manage to build gdb for my board so I
> can't debug it (I don't know how to debug a coredump without gdb !).
>
> JM
>

I have seen a similar libtraceevent-related rtla segfault recently on
ARM64, which was fixed by updating libtraceevent to a version that
includes the fix. Such issues are caused by the files for kernel
tracepoint tracefs having different contents on different
architectures, exposing bugs. I see Steven has already fixed one of
the issues on m68k [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/testing/selftests/nolibc/nolibc-test.c#n1008
[2] https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/commit/?=
id=3D45a9b0647c904b7bf1240da5a11fe3a1ffd1006d

Tomas


