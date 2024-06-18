Return-Path: <linux-kernel+bounces-219762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BE90D779
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AFE1F2416A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E04120B;
	Tue, 18 Jun 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN/06F1Z"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F54A35
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725004; cv=none; b=OSjO11N1RWAoI2HXwoiPG08bmZJCxBpdPP8jXG5IEpS+bZg52hk0ZiF+KgYK8VR6joD7ZbQd6aTyE0ENFAEZ3m5QxzT1CaHMlbBh1wuoXlHDx9DxLjQFc+yQ6926qjPCDZHZZmKVQLUA7e9WtNEW+4zl9OVb/lwJ2RKY1Y/oRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725004; c=relaxed/simple;
	bh=MEWdl0tqnkjxn0t/wprGhWa8mDGC5ARyeWTuu4/vhE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmwfGxa4ZAYpaTkgImRi2omVCxF60i9D+BT1LRUXCRiJ7C+S/l/bIpUQsXlp2bcGTDegW0sqSAdaON7UjUFCtCsjBQ29znpqbBHVI722yHxsnKJ67vwscY5NT5B2sSS4B//JLhLtSFyB5wOgsx2mk1+S17Cux8AuHcHvf7eCCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DN/06F1Z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-795fb13b256so506676685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718725002; x=1719329802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEWdl0tqnkjxn0t/wprGhWa8mDGC5ARyeWTuu4/vhE4=;
        b=DN/06F1ZRQ1bHhrwwIStI+m2IKnS/Vzz4wwIfvP5vEwZYcFfG6tCQ3HPk5DitK1BA3
         8CuFHMJoVg/0etfum5FpZB1ayOCHbVFsyxO5nYd/gSxejmLESAoozZdRoSMIcTUXvFfs
         PY3QgWSS/20cISybItLx7qBlHfkmOk+kLCjPX4RuFzw4lTy/+rVN2JQgtNEdsp1gt+/T
         gnrrgLQ8TZ/xyJdgLkcoTp74tZ+6snIaZrBLh+hkGR87tOjQpfICtrJ96g+4vp4Q2Ijq
         WczIhBw2Isi2kbwk/RL7HeF3l8MF5QOQRU2v2gJT3CtVkVVsPnsVJHhBgDWrOE299OV/
         YKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725002; x=1719329802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEWdl0tqnkjxn0t/wprGhWa8mDGC5ARyeWTuu4/vhE4=;
        b=MQPMMfsFHXkGfiUK/XE1bOlWYSI9XCGM/b8O3DD/lfbos3SVYgQxqq/vBAiwgj1vpv
         cBhiWanw4a+yL0svffQw1qcfbAhdTVOau/1MoMVp6Mg05wKfSWJVAZ+MOmXS4iRpALeg
         lJaFlWpcr4iRul3SukbSiXBza3M5h3LjvFFRyB9lE9bDuz/jo2aIBOe1stolFeE6590P
         rbrz5aG5yqN426ijQZcnRx7jSf3DAvvr58gFsW8WK9+NmyXD3Ynmz9pcc+3xJHHl5kTx
         nG0Vuc6K03hSZm+imGiOpeJ/onIOpFERYAgBVUl2cUm9TKkCWT15J792x5fMYunk3Gmp
         0ZNg==
X-Forwarded-Encrypted: i=1; AJvYcCVhb793GyUCqwTzuiVkWpgjIi5zmlAZKvq3dvd7apm32EHHpZzDjNAH73K6tRppfIw668No9+owWfRqy9BAENl5MfGIh+FA7hbsE5zk
X-Gm-Message-State: AOJu0Yyjt71leBu/NnDelumN6xu4q9aNHEuK20TxpJdgf1TwXE/OFlmN
	f1fD9rLVNHh3SmQ16lzh1bEXWCCQ+TscsqEbxm1UlifMMlQmCzgaeNfTqg5EvdXSKB+waqGVzCd
	H0UmhTpewk0/1opWw8aH7X+oyvuqLXqE9vMVG
X-Google-Smtp-Source: AGHT+IGgUZAgVNuWZRwjPfHOMbbpIpqWWli3o1vJH/R23c/Tl3JFwmx2EG7BwUQGM8yvFqzdXJsnNlvcCKVIpai5js0=
X-Received: by 2002:a05:6214:e66:b0:6b0:7d88:c307 with SMTP id
 6a1803df08f44-6b2e249503cmr44454876d6.29.1718725001515; Tue, 18 Jun 2024
 08:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-36-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-36-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 17:36:05 +0200
Message-ID: <CAG_fn=XczonMkhozFo9YT0pJhPPzfjiAMKmHvVBb9QJ6_mcspg@mail.gmail.com>
Subject: Re: [PATCH v4 35/35] kmsan: Enable on s390
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:40=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Now that everything else is in place, enable KMSAN in Kconfig.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

