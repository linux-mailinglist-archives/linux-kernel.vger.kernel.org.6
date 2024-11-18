Return-Path: <linux-kernel+bounces-412389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DA9D085C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B11F21F76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3D13BC35;
	Mon, 18 Nov 2024 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frlSFEKy"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E713B7B3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903267; cv=none; b=OcN9vwD4txFtKKEwgLbWihMfMW5G5Lqn4Y9MN314/L2LDeLtOCXXrd9WKI6JImT+FxgC2I54f78wg8KBY+2yYoSE97988S5qTALGZm203BgDYdflKdrG1aUUH/VRO6kMdeOUMl+LQt3qy2pMOBlivNbxuPMVLox+lsw5PPnKQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903267; c=relaxed/simple;
	bh=nsLPNefWmi0BmG+QCMhQkDkPhf3ZsZH9jvPvI3SQnLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeaDJ6ul/Urg0M4kI/nGP7+TMgqMNA/hywfeEfPWCPweEV4FdLhv11FtG9aPBe7koJrvair66v5/fuyF+QYYTAyrIh+rhSvYKjtOtlw9ic5+vfdPkFYByAcDUvuZQBPqIxi6tALNexG4dQrFBgOJxRe9PKTYp8V4LhyY3RQpzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frlSFEKy; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5139cd0032cso1087800e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 20:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731903265; x=1732508065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQd6JI85biFn4sbwYRSTbFK4J9rq3Xx1TpPMhTyPg5U=;
        b=frlSFEKyZ9Dv8AlLx//StREEVcIX/olMDXCCfygFC6sKN5UZP59j24M4nsMdEs/t36
         hxlSMpEjUsdghAPnoZptUuIVLZ9Cq4pVuKDaXYFYW/m9ctXgm78PiJbOQUI3zV/Id5ck
         jLidXnkdaSBSnpe6LOWDb21WbQf42G3BU3Z0LLTmqmqHtEpqIZvfkUP9luPvitn6T9Cb
         39l0KN/7NkrT/F9no+Evy8mZjNFDqgBAJYPCC4D2TJZZfqXM4nliDFO19HULZigoeR60
         QgjKNnTtGFbkYWSAvzM0MtoISIoaEqlTvB3ZBWwEy8c4NnE2fcODix2LBg2dJcf85s4t
         YBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731903265; x=1732508065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQd6JI85biFn4sbwYRSTbFK4J9rq3Xx1TpPMhTyPg5U=;
        b=xPbXb3AkNnquyI+dJmQGNV5uCX8ZfSIWb/W1q2QpxZ2OfZZaFR50yzRLFHjs/8QxQu
         5ftgg6dkL8MBXRNSK8VT9SO+8PPVKYOEb/yPIZY7px/8KVX5J0X3ak0mDcBNk1gCU33j
         wDeCup8MukYi10IBKfoMTd3y514aeuCHkKolSCR+/fl027Qt7SwjD+1YpfdK/ZMXbvtg
         w1grWo/66OLno+qfO8WWxCtNf20/9/1kGN0fPgyY5cQeN5BYcxDYSyWDHdPd0W9jj0pk
         lucUjebdlvUirn4zbmqttNBd7MRDPa4quMg/HLmrtp47HUgnPZVpGlMojUZoorLmr7lP
         IBTA==
X-Forwarded-Encrypted: i=1; AJvYcCX/1f/BpnVBQNUmeu6qzG13NTdEao+derX9a1HeiMrWXp7mV26cdDEXCHK9K8g4vCauulp3w7XCb1P6hlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTmF3saQMqML/drtXTL23fvy/30t3ViffEYUZAaTFEvUC8GIN
	ep5uwmurNFz2tbBo+G11rnJcrcxxqAqOyHnwo5eZUMFK2pMRG9tErQNPzRrTP/qz1yN3/GtTc+N
	wz+IOTOcBF6TMfQeka8fAt6u5e4o=
X-Google-Smtp-Source: AGHT+IFqn2Ag9Be1EYUtk0qbTon2Pz8J3bvBTLUBi2O1zIWfzTGRnArJmiRDqhI/HtuXrT/KxPYCGy0djt2J4gohTic=
X-Received: by 2002:a05:6122:789:b0:50d:85c8:af3e with SMTP id
 71dfb90a1353d-51477eeb37dmr9177343e0c.3.1731903264820; Sun, 17 Nov 2024
 20:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com> <Zzq8jsAQNYgDKSGN@casper.infradead.org>
In-Reply-To: <Zzq8jsAQNYgDKSGN@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Nov 2024 17:14:14 +1300
Message-ID: <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Matthew Wilcox <willy@infradead.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, yuzhao@google.com, 
	david@redhat.com, ryan.roberts@arm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com, 
	xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 5:03=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> > 2. In shrink_page_list function, if folioN is THP(2M), it may be splite=
d
> >    and added to swap cache folio by folio. After adding to swap cache,
> >    it will submit io to writeback folio to swap, which is asynchronous.
> >    When shrink_page_list is finished, the isolated folios list will be
> >    moved back to the head of inactive lru. The inactive lru may just lo=
ok
> >    like this, with 512 filioes have been move to the head of inactive l=
ru.
>
> I was hoping that we'd be able to stop splitting the folio when adding
> to the swap cache.  Ideally. we'd add the whole 2MB and write it back
> as a single unit.

This is already the case: adding to the swapcache doesn=E2=80=99t require s=
plitting
THPs, but failing to allocate 2MB of contiguous swap slots will.

>
> This is going to become much more important with memdescs.  We'd have to
> allocate 512 struct folios to do this, which would be about 10 4kB pages,
> and if we're trying to swap out memory, we're probably low on memory.
>
> So I don't like this solution you have at all because it doesn't help us
> get to the solution we're going to need in about a year's time.
>

Ridong might need to clarify why this splitting is occurring. If it=E2=80=
=99s due to the
failure to allocate swap slots, we still need a solution to address it.

Thanks
Barry

