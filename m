Return-Path: <linux-kernel+bounces-203438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B018A8FDB10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4472882B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F7168C16;
	Wed,  5 Jun 2024 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtTDplp8"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A28A15FA6E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631934; cv=none; b=t4Rbe5buF2iLI9uhOhxgLNwrbYjDW8AhUxXj7S8FCKMJaC0rVll6dcFe6OgodQ8rECd10UVoaNLhyO9//oJjPuIIUgAXLfwsmN/BbsyNmz50jLpk3g0SuALpspk2/Np7eUVmUhhA8FaYR3M+d4vwYVnEn8o4MtmMAndDG2+IzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631934; c=relaxed/simple;
	bh=QPBgqVspIBUwRl4IGY0o6ZY+Mv81DcBFciWQfumKt0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKi8ukdzRURQamEqULi/LqgTRASHsBeQWOAOAYXrYgiPj3tmiX1iV3+6C3hUo2FwD4uNPp+1LUf8aWm4K4zE4g+knUvu+BpYpnesXQY+QlNZh4MCoNEy4ZtBqj/6aaGmZI1JdTntkr63TiB22LIWkACtDZ9Z++j95hfkQ06pFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EtTDplp8; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48bcd69919eso172072137.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717631932; x=1718236732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf16gINAoan45PEw6aWCMW995aicLFXyStP7EDjqDE8=;
        b=EtTDplp8mzgL79C36CvvEfB5wa8dEbOqPoQafkzKHrQQFIrSTiolZpvsO73ehpYTa6
         BZJ0gYnS46yKGS0zWg3t4NBpETNjo0Dm0sbaQMhzrviMGQhRWdjtFjnwcxioC6I2IBo6
         b7iUraD7p0JK3Uw+vSqhkZZqAjvzzQiQradF84ZyDHGWlw9MZA2oEv1Ce3MGe73gI9XM
         sLJrTRJFC2+bc+9UiNqOYDfNMNSrGxI49igViXuzF2Y2Lc65jTenZU0XqMoJBhhgZ7UE
         Ejs76l6xOUs2VIZriNDwU9Lku/Lhl4bOMwN6v16Ofw0JaGINi25cpX41UABUbf1sE9NE
         y4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717631932; x=1718236732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sf16gINAoan45PEw6aWCMW995aicLFXyStP7EDjqDE8=;
        b=hON39YgJlrGm/9u/EVYSk8LG78AEaMVG29hp/J/hKUh/iSTcj/EBVkZZFdUZ5UyhjY
         YHNpdmZgZ3WhEdIY9ryog24W5koL3mzJf58sqt6yeOYWia/76wLbbgEXj7SabEfWUGFd
         BPgOrV46IUtUNrcdEjejRV3wmZY8xCQMvncHJ4kGgK54oGTqZ9e2NLs9pwR+kVjFVCIK
         tx65hLEWLsFmiUsJsLdj4EoTrsRvLejZrHCWAweeGhhZC9ubQJvcaNIrJna/PQe8Byh2
         DJza5C8W9z8NbzZuh/EWHaxoq85KR8GOVA2P1TDojdo/vgQq6Bm8z/igXjExtd9ezFKr
         FyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0T2HasWLhAKg9uAo58maQcqJh9PKxEp86tNbLw7NS4MgbpTx8aSGmE3xKO34jkzJAqSxXKpNu7P/lL6ks/nuPV72F1OKuk3Kvv9qA
X-Gm-Message-State: AOJu0YyVM6cli/vBT5WIwMndVyCmmTVUC/8eZYDJwuU17eHMovoOGtsc
	HtLcYMfpud93x8qTsfHeZ2296EynvNqtrgR/WVsfvRjs7itcnVyh77qbCjDLpY2rvBaZKxP4eMA
	PTXIRQ1OvQhkvXINH4eYrG08WR/UB5BIMkqDj
X-Google-Smtp-Source: AGHT+IHbHA0St5dI25tg2hHcg4EX0Nf8s65cWyX/QQ7AUSGrQyjJfHgyXWxF02+/PyYjZhft5J0qpp3TmAYsLBAeBIM=
X-Received: by 2002:a67:f58e:0:b0:47b:fe0b:a92e with SMTP id
 ada2fe7eead31-48c04924d62mr4753406137.16.1717631931930; Wed, 05 Jun 2024
 16:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <CAOUHufZ8BTTx1LoXHjHGnzJE9dzyv8EnvhpXMUm0NOt=P5KHVg@mail.gmail.com>
In-Reply-To: <CAOUHufZ8BTTx1LoXHjHGnzJE9dzyv8EnvhpXMUm0NOt=P5KHVg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 5 Jun 2024 16:58:11 -0700
Message-ID: <CAJD7tkai+e39hFDJkQRZ_Zg_Yp8OWx2uQfawT28ZZTD=Jvh9EQ@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yu Zhao <yuzhao@google.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000029497e061a2d592e"

--00000000000029497e061a2d592e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:53=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jun 5, 2024 at 5:42=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Wed, Jun 5, 2024 at 4:04=E2=80=AFPM Erhard Furtner <erhard_f@mailbox=
.org> wrote:
> > >
> > > On Tue, 4 Jun 2024 20:03:27 -0700
> > > Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > > Could you check if the attached patch helps? It basically changes t=
he
> > > > number of zpools from 32 to min(32, nr_cpus).
> > >
> > > Thanks! The patch does not fix the issue but it helps.
> > >
> > > Means I still get to see the 'kswapd0: page allocation failure' in th=
e dmesg, a 'stress-ng-vm: page allocation failure' later on, another kswapd=
0 error later on, etc. _but_ the machine keeps running the workload, stays =
usable via VNC and I get no hard crash any longer.
> > >
> > > Without patch kswapd0 error and hard crash (need to power-cycle) <3mi=
n. With patch several kswapd0 errors but running for 2 hrs now. I double ch=
ecked this to be sure.
> >
> > Thanks for trying this out. This is interesting, so even two zpools is
> > too much fragmentation for your use case.
>
> Now I'm a little bit skeptical that the problem is due to fragmentation.
>
> > I think there are multiple ways to go forward here:
> > (a) Make the number of zpools a config option, leave the default as
> > 32, but allow special use cases to set it to 1 or similar. This is
> > probably not preferable because it is not clear to users how to set
> > it, but the idea is that no one will have to set it except special use
> > cases such as Erhard's (who will want to set it to 1 in this case).
> >
> > (b) Make the number of zpools scale linearly with the number of CPUs.
> > Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> > approach is that with a large number of CPUs, too many zpools will
> > start having diminishing returns. Fragmentation will keep increasing,
> > while the scalability/concurrency gains will diminish.
> >
> > (c) Make the number of zpools scale logarithmically with the number of
> > CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
> > of zpools from increasing too much and close to the status quo. The
> > problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> > will actually give a nr_zpools > nr_cpus. So we will need to come up
> > with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
> >
> > (d) Make the number of zpools scale linearly with memory. This makes
> > more sense than scaling with CPUs because increasing the number of
> > zpools increases fragmentation, so it makes sense to limit it by the
> > available memory. This is also more consistent with other magic
> > numbers we have (e.g. SWAP_ADDRESS_SPACE_SHIFT).
> >
> > The problem is that unlike zswap trees, the zswap pool is not
> > connected to the swapfile size, so we don't have an indication for how
> > much memory will be in the zswap pool. We can scale the number of
> > zpools with the entire memory on the machine during boot, but this
> > seems like it would be difficult to figure out, and will not take into
> > consideration memory hotplugging and the zswap global limit changing.
> >
> > (e) A creative mix of the above.
> >
> > (f) Something else (probably simpler).
> >
> > I am personally leaning toward (c), but I want to hear the opinions of
> > other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?
>
> I double checked that commit and didn't find anything wrong. If we are
> all in the mood of getting to the bottom, can we try using only 1
> zpool while there are 2 available? I.e.,

Erhard, do you mind checking if Yu's diff below to use a single zpool
fixes the problem completely? There is also an attached patch that
does the same thing if this is easier to apply for you.

>
> static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> {
>  - return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS))];
>  + return entry->pool->zpools[0];
> }
>
> > In the long-term, I think we may want to address the lock contention
> > in zsmalloc itself instead of zswap spawning multiple zpools.
> >
> > >
> > > The patch did not apply cleanly on v6.9.3 so I applied it on v6.10-rc=
2. dmesg of the current v6.10-rc2 run attached.
> > >
> > > Regards,
> > > Erhard

--00000000000029497e061a2d592e
Content-Type: application/octet-stream; 
	name="0001-mm-zswap-set-ZSWAP_NR_ZPOOLS-to-1.patch"
Content-Disposition: attachment; 
	filename="0001-mm-zswap-set-ZSWAP_NR_ZPOOLS-to-1.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx2ho9sj0>
X-Attachment-Id: f_lx2ho9sj0

RnJvbSBjNmM0NzdkYWU5Y2I4YmNkZWZhZjFjMWEwZTg4NjllZmE4YmZlM2Y5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPgpE
YXRlOiBXZWQsIDUgSnVuIDIwMjQgMjM6NTY6MTUgKzAwMDAKU3ViamVjdDogW1BBVENIXSBtbTog
enN3YXA6IHNldCBaU1dBUF9OUl9aUE9PTFMgdG8gMQoKU2lnbmVkLW9mZi1ieTogWW9zcnkgQWht
ZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4KLS0tCiBtbS96c3dhcC5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbW0v
enN3YXAuYyBiL21tL3pzd2FwLmMKaW5kZXggYTUwZTI5ODZjZDJmYS4uMmJmYTkxNTE4ZDQwNSAx
MDA2NDQKLS0tIGEvbW0venN3YXAuYworKysgYi9tbS96c3dhcC5jCkBAIC0xMjQsNyArMTI0LDcg
QEAgbW9kdWxlX3BhcmFtX25hbWVkKGFjY2VwdF90aHJlc2hvbGRfcGVyY2VudCwgenN3YXBfYWNj
ZXB0X3Rocl9wZXJjZW50LAogCQkgICB1aW50LCAwNjQ0KTsKIAogLyogTnVtYmVyIG9mIHpwb29s
cyBpbiB6c3dhcF9wb29sIChlbXBpcmljYWxseSBkZXRlcm1pbmVkIGZvciBzY2FsYWJpbGl0eSkg
Ki8KLSNkZWZpbmUgWlNXQVBfTlJfWlBPT0xTIDMyCisjZGVmaW5lIFpTV0FQX05SX1pQT09MUyAx
CiAKIC8qIEVuYWJsZS9kaXNhYmxlIG1lbW9yeSBwcmVzc3VyZS1iYXNlZCBzaHJpbmtlci4gKi8K
IHN0YXRpYyBib29sIHpzd2FwX3Nocmlua2VyX2VuYWJsZWQgPSBJU19FTkFCTEVEKAotLSAKMi40
NS4xLjQ2Ny5nYmFiMTU4OWZjMC1nb29nCgo=
--00000000000029497e061a2d592e--

