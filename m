Return-Path: <linux-kernel+bounces-333260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3016E97C614
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E49281D40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12149198A30;
	Thu, 19 Sep 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WBvv6hDY"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297519408B
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735364; cv=none; b=JY8dzCGcqCY3TtDu1b1kv2xIi3OGG54yf/rzmksOOvq9wPDjbb5Bg07Uh6pGyrsCGSDS8O9SwkCddGQ3X/81N7xp27WszuAHfRaS0MAwuHDMKOOHcot1PoionaAeFcNXLbqVJq4bwoAJ9W2Y35DCzSRQmhVMx9rCXAZtIAobkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735364; c=relaxed/simple;
	bh=AjvG9wYB2Zlm9ATKMGYH7jIuHXZ4cewAANEtE/mytYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmu4CpOmcTHtI/u3dbo0Inwu1FbYVHgwxlPJSgJ8gn0QSzpIq5QIn9qm6hVw61lbiyHZNjjnhc2KwygRE5nFW4rs5TQEau7xhv1Ken/m7Z3DmTkGHclZzmTdQcCGqFIBj45ueagI55pJpG976XVrkeFTfUVLOAPH4ceZutH3T/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WBvv6hDY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dde476d3dfso4551597b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726735362; x=1727340162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slAQXs/8gsxb/7jYrM0cb/6jV3C3g1UiOusXI9+lqus=;
        b=WBvv6hDYqWJzsd7do6x8DUYv/xVgPBysvzncZ1sDFstwYZ9Pih6qzyjGAg/7r/G1Gz
         hSROK9dspICy+8Gfh9de0A/7TlCW6vKI5dEQJOhi/sv3kYYRBIVFLBIrh45NAcCKO+r0
         l0fGUXhyj+Zl7f4ODoojE5YRyUm+jH1b6hVzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735362; x=1727340162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slAQXs/8gsxb/7jYrM0cb/6jV3C3g1UiOusXI9+lqus=;
        b=nNhO6EAGIm9VhLRDI5sWeq5wlt3nNo/c4/DpH1JRQwvOTfmy1qd/lbqRGbiM3TaXvH
         ydHw5JdscynxKR+zhtwhDCKefZE0oqLszz9fynOjR/CEiLEZDfGs9K1zKPuZzoRR29+X
         bZ5lW8cVYxAhIaz1oG5BkZ3yAM7ZZrIc7mkoD3b1u9/dPSxM4KNWnkaF0Eybovda8/Wy
         NwVtCaMFPUDWVQGAOdlA7nIA2Ledt6xxNsBz+3achy+D+gqBiOysoyhe92rIcciMj51+
         ZGWj3lnwM2HLyb1ZrbiHUGOeqsD7pEluUqbqlOjTzY6UaK8a54+2V3YnjKbEUjX0NVPw
         LicQ==
X-Gm-Message-State: AOJu0YzOTe1o33L8FsqPyJHzbyogQZwtTNFbwi2A7osCZ0NFpedA8fC9
	kgT+yrah9CRmmxRbOb5AT7TfmvK3P9SZ4Hx0+nTn9vtH+nCkLXHf/7AjJLDmufqQqjFJRp6ovjV
	BOMlNjtikvhkLYRzUiJu4gOa1/y6brNKyOD3vxA==
X-Google-Smtp-Source: AGHT+IFj00vfKV9ATD41y4iUwq9opmPQ0T3gBgBVz2kUsBxnSrNihAw+UT8XYIkJ82CMWHwArjry9OIZKMme+UHm1KI=
X-Received: by 2002:a05:690c:fd6:b0:6dd:bace:4a5 with SMTP id
 00721157ae682-6ddbace0647mr150035247b3.9.1726735361777; Thu, 19 Sep 2024
 01:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <CAADWXX-xNBRC8yAUmCdPxe3W==Dxa_Xi6P_ceYDAEAeKYiqC4Q@mail.gmail.com>
 <ZuvhwjNgDmpmReUl@gmail.com>
In-Reply-To: <ZuvhwjNgDmpmReUl@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 10:42:30 +0200
Message-ID: <CAADWXX-Mu=h7hh1KmiWMPoDoVSTb=oQ5Huat+2=hsm59g4R6YA@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 10:33=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
> Thanks a lot - I fixed up my SMTP sending path, so starting with this mai=
l
> it shouldn't go to your spam folder anymore.

Well, that didn't work at all. It's still marked as spam, and the
headers of your email still say you go through gmail:

  Received: from gmail.com (1F2EF419.nat.pool.telekom.hu. [31.46.244.25])
        by smtp.gmail.com with ESMTPSA id
ffacd0b85a97d-378e73e80basm14420731f8f.26.2024.09.19.01.33.08
        (version=3DTLS1_3 cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256);
        Thu, 19 Sep 2024 01:33:09 -0700 (PDT)
  Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
  Date: Thu, 19 Sep 2024 10:33:06 +0200
  From: Ingo Molnar <mingo@kernel.org>

with no sign of it having gone through mail.kernel.org (which is the
only way to get the right DKIM). So it still ends up with that

     dmarc=3Dfail (p=3DQUARANTINE sp=3DQUARANTINE dis=3DQUARANTINE)
header.from=3Dkernel.org;

thing.

            Linus

