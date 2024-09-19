Return-Path: <linux-kernel+bounces-333275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78F97C63A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802A01C2223B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97A1991D4;
	Thu, 19 Sep 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G8XM8bpa"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D551991D8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735845; cv=none; b=pnMCM5RivqVa1GCFqX8LkBNGtiEtCRCx5TdA7Qve6x9IrhhRJZ0NVue0aG1wW2MZ/7kovZbu6HdjU19iQGdVfUh+PyprDv4mVQiBEfn22ABLtY5OhqgFmVH5I+WDvjKOttjd+ybAiQf4Moh260ICDlKqB9+37JgdOhh4yfWjIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735845; c=relaxed/simple;
	bh=QmvEcvLwMdZ67Q+orO7a1EFbutgSspJs9seQ1l5q7bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQjeNPgsjaOw73a3YmR4hGrVHHzWHdKBYXsD75515pq0Y2+PGb7FssE6mAyzuGnDVAaPBpBteLKXTE1hEUrTJog1j3jV8qzZRpNak+YVockzx/Nzxik33YpgUNPgnpDdjauyUv5U+fyjYdJZXka2fbWSRSbg6CzxKZS+PfV3Nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G8XM8bpa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so71793666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726735842; x=1727340642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3bX8owsMFpeSMLK0J1ihsNP0TAugOLIv4seUNiUYOnI=;
        b=G8XM8bpaKTulB6Jo0zeswpnbkZM2JT/N6H8OtUN2xjRakzV8CCcwW2F2Sd3dkvI8EI
         z2P8/fQKVRaY5GhfuRd7R3M/WB1vGB/gtDIcEglmrMO2RmU+NVTv+reJHloG90EGn+u4
         iBMwkvjBgJxibwIb7IaOscpA9gb2IFXrIIUvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735842; x=1727340642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bX8owsMFpeSMLK0J1ihsNP0TAugOLIv4seUNiUYOnI=;
        b=qgwjNTw+5mRsqa3VT36pmwt5boTwAn5g3Rd2837BaN3OHu5KMLMWDNVKIbdPA6OQit
         fvYq2+X4rjm66+aAgMkSByDnbugri9bdhogKnQINHpDoiiUzTlAYYPBxTNd4v265dqjy
         4EsRU1CvEStYYxNkC63PeUTbUm/5K1DR0DIotD+0de1fTrms04jSznTHBm8M/+tWRavZ
         jxx7hEjPt35VpVG38MvWjojhkSazahthgagpcR942ctsxmdrZkUy5yAbKGOHT5pfF3uL
         sCJ02vCawe1bghphZyJ6wtfVHpP0M4oawSNvT258mnS0nQYk0PnvVr3GRqKEKQD/TsXh
         v/HQ==
X-Gm-Message-State: AOJu0YxuwVsUDEpJziGhKV9RrVTam5v0kkbodKsuoXrFenojgJyDZfVG
	6hIE1EVZd2kKHkwPuaQEBDAa3w0KPswWeqj9UVkpkP+Xxqlqmw0vIGYiADz5IaEkDbEZ0AhNyRg
	I68wmYg==
X-Google-Smtp-Source: AGHT+IHbo7eKmF5s5MoERyyphEYl9DMfhXBvBaSN7HnxG/PydV6LyxmCDqdarNGDILH923V7ALDQdw==
X-Received: by 2002:a17:907:97c6:b0:a8a:926a:cfff with SMTP id a640c23a62f3a-a9047d1a930mr2094160066b.27.1726735842251;
        Thu, 19 Sep 2024 01:50:42 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm690307866b.8.2024.09.19.01.50.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:50:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a843bef98so63388966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:50:40 -0700 (PDT)
X-Received: by 2002:a17:907:948f:b0:a8b:6ee7:ba17 with SMTP id
 a640c23a62f3a-a904814d805mr2274425266b.55.1726735840258; Thu, 19 Sep 2024
 01:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <CAADWXX-xNBRC8yAUmCdPxe3W==Dxa_Xi6P_ceYDAEAeKYiqC4Q@mail.gmail.com>
 <ZuvhwjNgDmpmReUl@gmail.com> <CAADWXX-Mu=h7hh1KmiWMPoDoVSTb=oQ5Huat+2=hsm59g4R6YA@mail.gmail.com>
 <ZuvlTLMflCigipCr@gmail.com>
In-Reply-To: <ZuvlTLMflCigipCr@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 10:50:23 +0200
X-Gmail-Original-Message-ID: <CAHk-=wj5VpYL8O8H+t8vwOKjnbkxA1KMu_5c495Za4BeCybS0Q@mail.gmail.com>
Message-ID: <CAHk-=wj5VpYL8O8H+t8vwOKjnbkxA1KMu_5c495Za4BeCybS0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
>
> I fixed my setup, tested that it's working fine:
>
>       Received: from nyc.source.kernel.org (nyc.source.kernel.org. [147.75.193.91])
>
> ... and then I sent you the email from a Mutt session I started yesterday. :-/
>
> This mail should be fine. I hope.

Heh. Yes. This looks A-Ok over here. Thanks,

              Linus

