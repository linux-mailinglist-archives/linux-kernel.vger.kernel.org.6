Return-Path: <linux-kernel+bounces-303109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25522960780
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA408281E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C419DF61;
	Tue, 27 Aug 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ww5ZNZD1"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF7364A9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754734; cv=none; b=YLL9b9KK0n7dkYVMzQQ/FbhDNaQUDPmN+GebAEtqh6GveT440xL91Rpd1MI43d87AslsqhjX4NbAfhxzKIsgmgbbcmawIt6isntj6+lrNmxqVISKTPB98+6x4qqh4FbjltBOuQwAJECUP3Z9Lwl4HSnWQvSnJZqMVdZRiuUsj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754734; c=relaxed/simple;
	bh=ycrqlgO0UTaac+TLC39GdKqmUunZOnZ9hoUmX+4T+CA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R+bj5ltrMZWmXVVvmuA+Jy/dVuqYKXKr/mw4ca+9SQIi0aGvZJahKm8GqtVeDtlVGdsgjz50FCysS2F9QqY3kcqRxk3XUF0F03GwONasUENsAhUxIbiscXgavNnYElP68nrH9ULeLgrgH9DqwgEwhjwIf732qj8D7dvgZwISaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ww5ZNZD1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a867a564911so631808066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724754730; x=1725359530; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DHuM/kQ41x/auDnPgxPJbUmKbon56f9GOtmDAVesmw=;
        b=Ww5ZNZD1wh8cHxWbYc2DxpxaVV8iDwTiTUzgWkoyEVdvQmSI1CXV8WxRyoCAmQ6QHo
         4qKlNGfTuZ48dnpmOHKZTpBa+7wojGZNzHaVYbpOdIofdjIP45eobB/EXZvkB0l2qdN1
         khRvWcXYNLJ8XqwjHTkPiu2/HZqHgSHPVGVacQxQDtRyazquJRwl0HZBsl9iCxdTKp85
         HvLwkIOQo1dut3zRkCiZadgvQxrJmtU0rf+b1vcnm88hOwwsnb8pjGBdgrzd1ZeD59sl
         /7+qrhJ1uehS8tv5j1c3rLTGN+rk1MfnS9iw3d4mc/QgkdF+mWuPvtJ/gfZvID6teJ9N
         tFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724754730; x=1725359530;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DHuM/kQ41x/auDnPgxPJbUmKbon56f9GOtmDAVesmw=;
        b=lWaKrs6FFJdC8YRiMjfPNt332zMwu30NmbUvlPAM9MUj4+IAmqt9Ig2LWPTccE5ig9
         NVlLj6Kut6R14nLqqqDY0GpUVCcm76pHJUtdm0jk0CYMRUfpI/fF/aey0xXfSov0IeXo
         qszWPcK0EK4QHm2vao38CJ+sZu9teyfU5jLjibm8udREKaB2C5AsAFgIvDg3WoIcAgmd
         UhCDnL4o6f8f+4hQ7Ye/7zqgSPL4U10NlaO3sbOcunOjgG0wqpD/+Q0S+1AYfPGE3ivz
         xv+t998gLhzF6+DEP11W+H/RCtaprIEdrJ3yjF5gZ2VZXMCAKHrdyrM3mo9pbMKroVpE
         q26w==
X-Gm-Message-State: AOJu0YwKOalYVtbbmO7VjdbAIUhEqdEKmmFbliAwsvcjix4zHeMZ3m6Z
	LDXg0Asm2MWqIbGWp/cSPzhTX/JE8OmJehED83TjGocR16F4gR5XGv4gc4axmQo=
X-Google-Smtp-Source: AGHT+IE6qWQu07aKfg9p33jCpIQAbmfOvhptok+ElZDeBxLPmDXF9+w33X0d3/Ez5qHSNqq4vjllpQ==
X-Received: by 2002:a17:907:3da0:b0:a86:817e:d27b with SMTP id a640c23a62f3a-a86a54b05f3mr915301866b.43.1724754730362;
        Tue, 27 Aug 2024 03:32:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e588adf2sm92890766b.173.2024.08.27.03.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:32:10 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:32:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching selftest fixup for 6.11-rc6
Message-ID: <Zs2rKFzj-EhYoHa3@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull a regression fix in livepatching selftests from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-6.11-rc6

===================================================

- Fix a regression in a livepatching selftest.

----------------------------------------------------------------
Ryan Sullivan (1):
      selftests/livepatch: wait for atomic replace to occur

 tools/testing/selftests/livepatch/test-livepatch.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

