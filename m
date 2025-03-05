Return-Path: <linux-kernel+bounces-547911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C1A50F38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D91884A54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5B208986;
	Wed,  5 Mar 2025 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mwn9avAp"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D17207651
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215319; cv=none; b=F0W9MqJP6l/m50KH9zMvcGqTbZh1rwjrvxPX9akFwpfGlihRDv7oLxkZhYUdSSaS7XFKN3vcoZbAMPviFWBA/fC13JSoY16vRdoSRcEdm9+4NKRQZC5CobzZNFMuxFQcDNFX0eOes07mZByV3IDJRg+diVx4X58mCFDMWim1vwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215319; c=relaxed/simple;
	bh=kWrvDL4aRWGD23hUjwJg1LKH+qid0nn+ZvcDoygedpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMNm76jqXnVkaW8fvx9mJfX2a+U4Xip8nWrE49BFT/6AbsPb8JvzaaBeo2WfBzXqeOQ77mo4p5FlM6RqqTwuaA3S7mxhYMSlxrbFQHqEarkmQLbx5vXiHIFOuQwAdHqAXTFEUZJTxU9PxjmLEg6nLt247Tr4Cn3ojokL/2xKZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mwn9avAp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223722270b7so22335ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 14:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741215317; x=1741820117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnH7dvyAx93zYKkVwx3xrUcTVEYaETXbwPAjKVXumlE=;
        b=Mwn9avApUgilzIIj8fw10IKw32uJrYNE5nBtJAksJ5V1vDwbBGLfry7noZqgGZgNny
         ZK8Ar0yFkEMHcipS8daD81Z+uKQ5nxXrthQUeZNwXFrNVHsWy983W5L5tbZP9Vz8e7/z
         FxfAqi4ALS4LuQhXpswt9XB2zRwwox03u6WzNwBa9q5koiYzU8zEgX+bzIci+83/n66W
         SnR95DNe3782MPbwb8juBvgz7KZ11IFBbR08CK77PIxvn8tarssATSKWFv+4Hv6pBQxg
         eCXZn1laTclwd3kjfNK65ve+0+eKlekoXpd977mYGZFHybA/VZ9CRd31Xrn5hHNnPZE1
         6slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215317; x=1741820117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnH7dvyAx93zYKkVwx3xrUcTVEYaETXbwPAjKVXumlE=;
        b=AVw0puxfdzluMhjjDda9/wPGJ3yPn+UH5HDsmXJ+LI3KoEskJ12ZVXl4rdzqX3nrR+
         l7iwt1xT3J9R9HfcqeCjDmheo6Jak3V+egMJGgOgSoLsWUHJiix3rUlBVf9q5oyRKRf/
         +GOoM1Xe+ch1rUY4+o1cmINJnr/ZP3JuweqOORlPPyrXX23BEfTwvae6Dj9obdl3WtGA
         p42OBWHQfriAVfhF9Das+Kc9HpI5otbbuLEN1FM+lmvhjy90LZykxfH8SpXBHMhpOjat
         FRvB4xc+A2L8pD8LqJcoq3hPq0AT0mjLOgKtuswa6BdfbJIZl6O5w3HpiHCnNjy6xMHL
         znDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNWbBZiXBqizZbXdZmxskY+A1/2pPMKsth+j7n9snOFFUPYHf8bL2Dl5OoGBGaOLrj9wBOGumKUwFUFG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwy20PMNHyMOxksnNkqcuoNfo3UtlKN4mL0rdA0HN+JOnp2Iu
	6DUHROKegk7X1MXHjHrPrdVTvVpP5k+il10pnLL5iNQEugBNViy9EC/y+rivKTzr98AI5Or4NG3
	pQcvuRpLBpKdmQCcmTCkS/6PDVFpATFlvVPhs
X-Gm-Gg: ASbGncsv7KvfxUd5alG+sujdxxnptIR+Q6qRAiYd7pOCt7V+pbTLZ7WSfrihrrEX+Ym
	/ETQJ4NDagyD3yqk7M0ElzSLdSEoWuxSle80Rl/X+kfG2yXNzBmDJZtN0Q/DHqERZgt90o4lLQN
	K9LzhMRA0CyGKiSGcD46l17204uf9p/0EgW+l9MYFH7iVfTd3z2RVHIeY=
X-Google-Smtp-Source: AGHT+IGhaXT718jzwjgBMJBkpqzrjXOd1Onruh+ugtQ6WiJEOFXIWmfCHdpuUXmTRtaTl8lVCaZ4y6WEQKkVv0wP4Go=
X-Received: by 2002:a17:902:f642:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-2240e4be146mr303445ad.25.1741215316478; Wed, 05 Mar 2025
 14:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228211734.33781-1-acme@kernel.org> <Z8JO5Jp2b4OyHImx@google.com>
 <Z8YU4egMWtSi_lPQ@google.com>
In-Reply-To: <Z8YU4egMWtSi_lPQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 14:55:05 -0800
X-Gm-Features: AQ5f1JqoYQIspeBgv6WEy_FqCOhkCYtiMlQ_kA8gYnT_CioYWqSJ7ZkMpD9erh8
Message-ID: <CAP-5=fURKnnZG6TUgBbE3uHFhsaLapj20dvf5OoBfzoL8ufcgQ@mail.gmail.com>
Subject: Re: [PATCH 0/6 v2] Fixups for kernel maps insertion
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 28, 2025 at 04:03:48PM -0800, Namhyung Kim wrote:
> > On Fri, Feb 28, 2025 at 06:17:28PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > Hi Namhyung,
> > >
> > >         Here are the patches from the recent session on fixing the bu=
ild
> > > when DEBUG=3D1 is used, please take a look.
> >
> > Looks good.  It's more fine-grained than I expected. :)
> >
> > >
> > >         I think that since there are no reported problems and ended u=
p
> > > being a sizeable series, we better apply it to perf-tools-next,
> >
> > Sure, will add there.
>
> Ian, are you ok with this now?

Yep, sorry for the delay.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
>

