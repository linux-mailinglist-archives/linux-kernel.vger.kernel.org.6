Return-Path: <linux-kernel+bounces-435155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B939E7278
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB9F188801B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CB207A07;
	Fri,  6 Dec 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VYE288Ll"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD97153836
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497745; cv=none; b=qF4MJhYtP8LdhsaEOXqmQ5Mx65iYUCIlt1lzQhS0+mqJQyget1GHdyD3U6BKuIAiUhiGtFA319xNdIsyHU+nCh57qGgX3CHTgrXcSzJS+esqq4egB9NoCw/kV0BjtLnpx3S6aTkVhn9Sz87HoRbhuFnPlEA9O7izyb/sxXDo0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497745; c=relaxed/simple;
	bh=6vi2w3ULnui1L5jZFYYCFPz35j6gLiS6YYBj4J3Ca2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTQ7P4RcJMHPItKtyKKAHy5L44ut37FUd56L7pyB3prkGbG0ZVC9i3LWvxvUqrO+cP66putW8b8Jwod0rGdZ4CYQ0Ly2UGQRSKaE9LLwAPecTLfg7EDLjPJgsDOLj1aopqpQ/flY6EUnRL3+6hbD3c4KCT+cc0yNfDNzUbBVdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VYE288Ll; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa5325af6a0so340664766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733497742; x=1734102542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vi2w3ULnui1L5jZFYYCFPz35j6gLiS6YYBj4J3Ca2M=;
        b=VYE288LlqDUZ/3W4gzapE0a3gRk+RwS8CSdzlNOk9t0+BbVnjhBC+4mpgc1kqTkI38
         RtjVcMRl93xXP+vs7V+T3eLP969agq8/JHaNfJdRCxYzy2FW5BRtchYX9JhAnTKhK9f2
         wW0MOStfbuCW/vjFTBdyb5SaiHDKadN9HXijxSaBDePCkIYx+OTdMxi6iPh4f5ruaAD4
         Ium+Hl7q+wyAZuYRtFEdedZUETHaA1osRmciBOdpyWaQo5bMeUKHPr3vzi6JNpiQk1av
         MgLPxBZ5OllX7TG2twBbFA60ZOatPPGSvfLNKG6hbVbYfcpwi4wvTUp00+vBlnN2HjmB
         YQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497742; x=1734102542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vi2w3ULnui1L5jZFYYCFPz35j6gLiS6YYBj4J3Ca2M=;
        b=dJDY2f6JyzOCj0odSc5OziyNPnMpmSMRQA7xeXb0kp8LAms/c8UT+9Yf9HKY0oOt8Q
         9xGvyfKLp1I/sslOespWiWRsFQkDWxjgm/B4wbTGTQoY1xQjw8xLwqBi94sBVnGJgaAC
         P5rVmQ/W3bFYfyKjpMC22krVFxMdEn/QmD4eAYKyycfKrn/3uoa2u6Q1bPf6i2oClNLk
         f4F0iVBT8il9iHMhWN7bNRPj7D8EP7hZ2x3/UWCjU1nOyR44oP7psYjnmzOzfZEHKylI
         HZPZg3XMIXsK4oVCsCIASKh4bbM++P2R6PY8dimnXO/DXTgCLZ/ri5NzkcyhlABPT+6t
         u4fw==
X-Forwarded-Encrypted: i=1; AJvYcCWDVipbTLxQMXKy81RHRuazoA+4fmrnn52lltio5SurMsL+/hBXHIfGCCDCvNH5kDX11Lkj7+5+P7qq99M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrcx95PhQFIUlDll953TGEDE9jR5rwLThrSbUY7QhDR0W5ZK7H
	4vfZZrx1phJaCmj4dmwW6F/X231G6mSKVZRQ66LjrPkH/wveVQw0Lgob6rN7iuCpAebPovwbAyx
	35CrzaNkLiJldtnO0+z0Qwu4xi5UO1CGOnW8MRg==
X-Gm-Gg: ASbGnctQttkQWlYS9/9qDg5ih/IUCdyWQWDdJv/axbZJjhY+QrLGpFzi/N1BrvsanX0
	xqomHKIDACaVVdtB/xQ1160EhnHPhDpQXdDFWPMLRoeBf3jpt05j5x7v7Eeg14I8H
X-Google-Smtp-Source: AGHT+IEIrl5IoxFJj2C4V6I0kQ3wpU36uB7bQ3fap7ePoneT9UiORfQqEfdtxBsh8Xe1mm/efADKuAobWRxnptVApy4=
X-Received: by 2002:a17:906:9c1:b0:aa6:21ce:cde0 with SMTP id
 a640c23a62f3a-aa639fb2f18mr280779766b.12.1733497741857; Fri, 06 Dec 2024
 07:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
In-Reply-To: <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 16:08:50 +0100
Message-ID: <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:29=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
> I have encountered multiple hangs with that branch; for example:

Similar hangs wth 6.12.2 (vanilla without your "netfs-writeback" branch):

[<0>] folio_wait_bit_common+0x23a/0x4f0
[<0>] folio_wait_private_2+0x37/0x70
[<0>] netfs_invalidate_folio+0x168/0x520
[<0>] truncate_cleanup_folio+0x281/0x340
[<0>] truncate_inode_pages_range+0x1bb/0x780
[<0>] ceph_evict_inode+0x17e/0x6b0
[<0>] evict+0x331/0x780
[<0>] __dentry_kill+0x17b/0x4f0
[<0>] dput+0x2a6/0x4a0
[<0>] __fput+0x36d/0x910
[<0>] __x64_sys_close+0x78/0xd0
[<0>] do_syscall_64+0x64/0x100
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

netfs in 6.12 remains pretty broken, both with and without your fixes.

The sad thing is that 6.11 has just been EOLed. Linux 6.6 is the only
sane kernel.

