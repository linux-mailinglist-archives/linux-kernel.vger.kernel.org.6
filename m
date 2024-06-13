Return-Path: <linux-kernel+bounces-213623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F49077E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271AD285E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F9145B03;
	Thu, 13 Jun 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9HOqj8R"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A2A23;
	Thu, 13 Jun 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295006; cv=none; b=YZkYb1KkM+Q7r9Pb/+tkquWu6f4gQa8syCu/FOD5CjedJdSfb3Gjar/YaBOZznv5B5z3mX8q2SDMv/YIqo0+BweyBWTEafRK0KE+AnaONzVD9MB/49MC1JAT7qtqAj5rAIQU8wmsAX27ktL0L5pxU3mnNGANsOEyZqPz9SVDbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295006; c=relaxed/simple;
	bh=HzWixo5RmZhsbV2y5X28R62OYc7ao/16u7JRIiYCfE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCGTpfVvj9fSMo59f2PexIbztBCH1cKEc85iyu8FiiAztrzJktcikXzYmEuMKriKyAniP6LZar6SR1BV4K3ZMGDVzVXJybM+9vzCkXYvrdNSS7gCB7TOCXhjAOxD8V5Ohs/aYAo6/12eFKsnDtO+/+5RSzf5wwh59zKcle27plY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9HOqj8R; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9cc681ee0so554783b6e.0;
        Thu, 13 Jun 2024 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718295004; x=1718899804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzWixo5RmZhsbV2y5X28R62OYc7ao/16u7JRIiYCfE0=;
        b=R9HOqj8RQKoJ3euQ38WCNHBDU6NpmteaSZvqE1l9V0Q6pFkjJjFtvw0xI2hifni84+
         68tsO1fHAzZvE3D/bbvQrpTSx0w2faodbdcjQ6b1JrqBeEu7fI9TVn8JJ1CI9I3Sv3r3
         jG2pN6ASbr+lGq9v2hyz/QMn0UR+jKeEpg7PVaranR/QHdNyB/UVygEykQDV9muGnBCV
         BwK0GvYw4NHtqmHOfwQ25+l3jHIA43hf59Q7ffYcNh7iayt++x9XQqFIHS8SSuR3gT5F
         A5zQH24WW0nISwwWKLEKkob+PqZhCgkNFGMct5MHub63kCbcFpqiu1S4HEzIeyBnI5ww
         xnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295004; x=1718899804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzWixo5RmZhsbV2y5X28R62OYc7ao/16u7JRIiYCfE0=;
        b=GC61HIMuC6p3kDsHZWv76re5bDYSbhUPeqqiHRwnJXKR7jYv5UiJTO/OYdb9Y0/vx1
         TwRR1kNVHe5WUeivwgQocw3lPoSlKb+CnvqUjSaoxl8/in4M2gYK2p4WPfBE7DpclUAt
         erFgiOvs2Z8DnT6EeQXbtJzJjo+YBIZ2j8iBqiSUAiEeQS5NRiT3ajK6GW2OBuH7FngB
         uTicKRy09mrXafzjnfoNqB0VkEY8D+dlWrLHbg1C29xXYLtA3WnKfVIjbmsR4R2/KViV
         vr8b90m7P3kV5ahsvUWh/mXdR1q54udFUxhlqF5xxYiWgsCFyPbIKSrBETth7ZymnvfP
         o8+w==
X-Forwarded-Encrypted: i=1; AJvYcCVj6eNOQBSYs7815TmjL3ka52EAIZJ6ob2n5NldWQPe1ifa3yIY4WySofRWZkVQFT2yJ+XD/OcUZAalymNRt235/sd3on4BgGGXlb9FHHKVGeL0j27z8Fl0kz3qjlNcN/s+9i4LsNr6
X-Gm-Message-State: AOJu0Yw9leg3UZBWDn/G0X2ea0WeBRqOnu+Jp7GnowPopFgOVj1IRXJo
	MhL8bBi3VIu95vmzO/8G6CJnZehJEhh2v6+lc/JXDpE+J8n9LoPw8fzK69WaQNukqLemEyKZi9A
	woCjPpARzDL9AoBoJ8h9xird8EVs=
X-Google-Smtp-Source: AGHT+IH+Bi6NtcqxsKHAPZncuhjTLy486P0VaxPYnmqtM3swNG6QVuiL2cbPhnJUTmJHKYoMc4gmRe8XDaSOuEkp9z8=
X-Received: by 2002:a05:6358:7e86:b0:19f:3fc3:1f8a with SMTP id
 e5c5f4694b2df-19fb4e6497cmr22960555d.8.1718295004203; Thu, 13 Jun 2024
 09:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=MiMMCrQCq2j1DDOR_U6==6pwbqqCnsaoigQ4aEqhgaaw@mail.gmail.com>
In-Reply-To: <CAKEwX=MiMMCrQCq2j1DDOR_U6==6pwbqqCnsaoigQ4aEqhgaaw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 13 Jun 2024 09:09:52 -0700
Message-ID: <CAKEwX=MKbXw6=Qab_CR4c8pbSFyWERESFqhUUKXzeqJVMn8sCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:08=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> 5. At the end of the inner loop, the selected memcg is known to not
> have its cleaner started yet (since it is online with zswap_pools_lock
> held). Our selection will undo the cleaner and hold the memcg hostage
> forever.

/s/will undo/will not undo

My apologies - English is hard :)

