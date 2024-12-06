Return-Path: <linux-kernel+bounces-434588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E249E68B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F8D285EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0371DF755;
	Fri,  6 Dec 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KanrVJHi"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B01DE8AC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473513; cv=none; b=MunF8DqHTAzdVOxATs/D3OdNuxoiRXVH/IiA+bigc72H7Q3DcVQNIXDKQ0pFcmBI4cy9M5NrzQ1FOlj7vXBtAFBw02NJmMX4r5Au0kwzhu+zTGg3HNzWiDermiYfqp9OMgAqZO8rLdL0DBJHNxZJ+XJMT29veYhUqFJVFRnTyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473513; c=relaxed/simple;
	bh=hIdSX+hye/eYJzMpjEzn7gwhwkYZe+iiwo83FPJWY+o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X1nuukWMa+Uo+FfL+frGA8XIAk2th7dT4SXXHntfv1bJg2mhEWmgzTmQN7GLTDbtQftdxEkCNR8dgD8Lom66vxPD0ibi7CP2irx+T+0ZCu11q38Eg6fNJOEi/32x855BY0MevRDqr3WbH0TpK9Ds1Ve4cDy7tUsaKYILVdJh4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KanrVJHi; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eecc01b5ebso1559578a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733473509; x=1734078309; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4v2g8Z1ZmRn1Pa75MapYVMX2K8PJVeT8xzxL8G2PNo=;
        b=KanrVJHiwcL7N04nWB0nafX9V6l/EUCe4OGbSRRe8k6kB8Mq2FoYlw6ef210s07vZG
         l2J0L0V3qSsQo14oUba+YuUwaVOCn1PunB3orwcMFg1/UprV2qYqNY3hMHG3yzFFsNTD
         DQiK2/tHmI5YWAuIUsa2EEh6reKmFwxHkrJ29JW/Ze1W43JBwBuYRqRtbvPwxTAiA3Jp
         ohfsRxcK+F9c/8wN3BcqkHErZgOOr4YUyvmkiRCd5NgL4o5JlJxHCpn0Svsw8zf8j+8y
         u7X3A03cj3CS0s22v2hpTniXYMkT5OiTw2Ik2IS3p0LqINXiCsZgP2+J0Y6tJyOgwB45
         cc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733473509; x=1734078309;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4v2g8Z1ZmRn1Pa75MapYVMX2K8PJVeT8xzxL8G2PNo=;
        b=liheAotQ0c1mO/XyZLCKwRwjNaKmb2Lk+Mai7BhkFlF9JldcsStxdvPqwcNUMr+2gU
         wnDTXc9bE3sTdyo8rMwoiiHDxHmh4joVLBCXqkVbTxFWJxoKlX/TOUJ8ahu96DgX8gK2
         MJQ8jufAfDfzUCbrvLS5+CQMCAPBYpkTnVNOiAHQUw9OHkHlLLpWxxpONJaQvrAoflg1
         N2UnGNQARJibRwJHAV9fN7kMDk3hn6KcMp6XILVqRrdBl+i2WZuzCbZutl0N8IrEEnMC
         hZaUv79DTxHUVO0WqsfsF2cvNQfxBJ8hxMY/krvo2Vo6CsdaL41XznkhNbooTuN5igUQ
         ytoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwalSlB1nqCaplTduRGaRl6t00rWJGs6iHuxM8BDxNsYZSe7V8Sc6q/jDTEV5Lmbh/BZcYIYo/UMb527s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTtakwWKyH/rmhuhzSE5HXbqVUafT8pvaixoTruku2USb1ecf
	ABJ3Lbe3E5blfIbCDPQZqEpH7D5grKPMAGG0a9odyQBEZJ6Jl/czqKmqqIN2dg==
X-Gm-Gg: ASbGnctRvXIa1yvbBMyj59B/vNf0d0f52N433cTcx4/RqV80/o3HgSAmxmdzZ/l25M3
	FELbM1J3pg76A5go0yuDpeJEvk+otO0vGRjgGVHduZwXycaZSLD+IkXCG4JqNmxbMJv4s7KViUf
	pe22e3Cjxjn8OXfereGV1oz9jaD2/3OpRVlIOz/LCXrsGW9p6rbJYbRW5hwZ0SOC4XhuIhU5ZLl
	NSoutDiHl7x+hODpfyirxGEX2K/o+arCq81DPc67PpEJOgkYXE3VDBVRNzToRBfqgjSYEsTyOnK
	DXPZ6eQW3mcdVPnc2S8eGUdV34MjA5sqxA==
X-Google-Smtp-Source: AGHT+IGhGKVKP+RqpwLFGFm+XoVmhnZoxHjiIFhVXy65aA/p14u7x09DD7eDaKoDthtQmSQ0FoxSeg==
X-Received: by 2002:a17:90b:4fcd:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2ef69e154e1mr4116058a91.15.1733473507934;
        Fri, 06 Dec 2024 00:25:07 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700bc8dsm4523017a91.20.2024.12.06.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:25:06 -0800 (PST)
Date: Fri, 6 Dec 2024 00:24:54 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
cc: Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>, 
    akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
    yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
    muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
    chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size
 function
In-Reply-To: <897b04c9-dba3-44ae-8113-145ca3457cb3@huaweicloud.com>
Message-ID: <edab8d46-7c03-4bf5-fe1c-0150cdf4d96a@google.com>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com> <20241206013512.2883617-4-chenridong@huaweicloud.com> <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com> <897b04c9-dba3-44ae-8113-145ca3457cb3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1417733807-1733473506=:9237"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1417733807-1733473506=:9237
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Dec 2024, Chen Ridong wrote:
> On 2024/12/6 13:33, Yu Zhao wrote:
> > On Thu, Dec 5, 2024 at 6:45=E2=80=AFPM Chen Ridong <chenridong@huaweicl=
oud.com> wrote:
> >> From: Chen Ridong <chenridong@huawei.com>
> >>
> >> In the `mem_cgroup_update_lru_size` function, the `lru_size` should be
> >> updated by adding `nr_pages` regardless of whether `nr_pages` is great=
er
> >> than 0 or less than 0. To simplify this function, add a check for
> >> `nr_pages` =3D=3D 0. When `nr_pages` is not equal to 0, perform the sa=
me
> >> actions.
> >>
> >> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >=20
> > NAK.
> >=20
> > The commit that added that clearly explains why it was done that way.

Thanks Yu: I did spot this going by, but was indeed hoping that someone
else would NAK it, with more politeness than I could muster at the time!

>=20
> Thank you for your reply.
>=20
> I have read the commit message for ca707239e8a7 ("mm: update_lru_size
> warn and reset bad lru_size") before sending my patch. However, I did
> not quite understand why we need to deal with the difference between
> 'nr_pages > 0' and 'nr_pages < 0'.
>=20
>=20
> The 'lru_zone_size' can only be modified in the
> 'mem_cgroup_update_lru_size' function. Only subtracting 'nr_pages' or
> adding 'nr_pages' in a way that causes an overflow can make the size < 0.
>=20
> For case 1, subtracting 'nr_pages', we should issue a warning if the
> size goes below 0. For case 2, when adding 'nr_pages' results in an
> overflow, there will be no warning and the size won't be reset to 0 the
> first time it occurs . It might be that a warning will be issued the
> next time 'mem_cgroup_update_lru_size' is called to modify the
> 'lru_zone_size'. However, as the commit message said, "the first
> occurrence is the most informative," and it seems we have missed that
> first occurrence.
>=20
> As the commit message said: "and then the vast unsigned long size draws
> page reclaim into a loop of repeatedly", I think that a warning should
> be issued and 'lru_zone_size' should be reset whenever 'size < 0' occurs
> for the first time, whether from subtracting or adding 'nr_pages'.

One thing, not obvious, but important to understand, is that WARN_ONCE()
only issues a warning the first time its condition is found true, but
it returns the true or false of the condition every time.  So lru_size
is forced to 0 each time an inconsistency is detected.

(But IIRC VM_WARN_ON_ONCE() does not behave in that useful way; or maybe
I've got that macro name wrong - we have so many slightly differing.)

Perhaps understanding that will help you to make better sense of the
order of events in this function.

Another thing to understand: it's called before adding folio to list,
but after removing folio from list: when it can usefully compare whether
the emptiness of the list correctly matches lru_size 0.  It cannot do so
when adding if you "simplify" it in the way that you did.

You might be focusing too much on the "size < 0" aspect of it, or you
might be worrying more than I did about size growing larger and larger
until it wraps to negative (not likely on 64-bit, unless corrupted).

I hope these remarks help, but you need to think through it again
for yourself.

Hugh

>=20
> I am be grateful if you can explain more details, it has confused me for
> a while. Thank you very much.
>=20
> Best regards,
> Ridong
---1463770367-1417733807-1733473506=:9237--

