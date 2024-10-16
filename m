Return-Path: <linux-kernel+bounces-368773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B345C9A14CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F0D283F15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB71D26F1;
	Wed, 16 Oct 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klo2E0Jk"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580C1865E2;
	Wed, 16 Oct 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114293; cv=none; b=nZf5/CS25xPP+RVdxkkuNsR+45edD+TMwjyCIBM6/4xNoY9PHbXLpGKNHtwpN3rlKxEdj6Tw72Itep2cQhMqyLSI8+juO1tbm81Vw3+6ViBFxUX2ove1RCoDTnxESKyQCdE3Pnrn4Ld1lMH91KKN53nrmWEEF1rqiUwKbMPvItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114293; c=relaxed/simple;
	bh=fkeZFG3S7clNAzfjnP5uCN7K9MmrUIIlVuyPFJ8tDS8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O2PaXY6yiEMKeEJ1qRN3Hckp5DSAcEdFZ/jgUwQ1KjOiQ7LADmgLu7ywY1Ph5AWvv1beG8E7dgJ2mOdmAztY0vHP3bXa3hBXeSOkwYmCucrHdR/M3mnbADMJoLv6tjjmE9szGZwqd/Yy22MLRap6s9/vXXQeIRJL2G46YSxbGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klo2E0Jk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1363c7977so28578885a.1;
        Wed, 16 Oct 2024 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729114291; x=1729719091; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYaszjjj9h0NH01P3GQj0Wj8LMIg0FFBa7EO3JbktQk=;
        b=Klo2E0JkmtVtrIDbAo3+oDmvq0w9/L7il6mnom/Td+fCWdcnKrUpYK/8f4bLmvdVqi
         JlsQfjFw05zSv6QyC/b5oHKKfufSsu0iQRR6H7C8RbAbLdz5tMNVuuXghlB8YDFv+cuJ
         wkNDmSyJ1WbAdGCbA8Uh12XOzW97/CVVDpbxlNls+ZZOLnB2tcMdNYph/qCVuRRRMO88
         Rn6ossTOgF8c13wG9j55MHEj9aTqgM52sBaUWURUzWYxna+ToaK9uoIXItMgwfSMJ/tS
         WNuNW3L9lf8IaJg1UfAQDyyLqS5lnohySfrzNoW3rQd7loaZYArT33yoi2qsiLLKd3+l
         wcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114291; x=1729719091;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SYaszjjj9h0NH01P3GQj0Wj8LMIg0FFBa7EO3JbktQk=;
        b=FU1+WZBUG/gqSort4DRvI+CP7v5+QKtnuznI6navjlZIJ/NMl8Ul5F8JvBxCJ5Yauy
         xJsd6YAncOmkBmUV1Syqdenf8Fc6drgbcNli2JzKw6i20gxQ1QoWQ6LHeghEwIOHrQUD
         sSxq+X4NvvP+W7JdoT9vpxH4rNHQq2rLJtpii4h4SCgmmOgyWcUHsd60kyt9o7F/Jc34
         yuBCHBZobEcEdortBlIAD63RxdKi89sjXz6bKp4IzFVJKN93eHTdnQcU1mmOtugYdKbl
         Y97zbo/iyyB1DGizVXN5gBUcZIBBojp1nO8DBR9dXw7xYK518qEBiK0qNBSsYvqDsTFX
         u+YA==
X-Forwarded-Encrypted: i=1; AJvYcCWgTPtMxVGNKTS5fuTr1oCjtnBIzespnperMPJWSh5wQro5BXZE+OXl3VaZ6e4tuWpzxoP6/zTMzeyXSJmM+O8=@vger.kernel.org, AJvYcCXBPsak8WXQxBxKeMkxy1xU1X7XjwEN09aU79Zozhje8Q8jSFsLh4unW0TAVOMxLZt9QucvcG5cygAyMbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbAw+6k9P/NmODtlIpRgZoa6opzXQbv1HEAE695as/sEzonIx
	kIqonjIpz3S9B3eI7/P/s5+TPlYcCWGmvR6RLeRx3Q/ZBbwfA/p/
X-Google-Smtp-Source: AGHT+IEdd/ibUex+vNedzcsUI+s5WvTFEQz9a3xGcP1a4mHN/lgVZftiqEuOXi0A11DX73hsosyPtQ==
X-Received: by 2002:a05:620a:444a:b0:7b1:3ada:dc58 with SMTP id af79cd13be357-7b141815711mr662419485a.34.1729114290659;
        Wed, 16 Oct 2024 14:31:30 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b14a2c1491sm54382485a.38.2024.10.16.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:31:30 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB9B6120006E;
	Wed, 16 Oct 2024 17:31:29 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-12.internal (MEProxy); Wed, 16 Oct 2024 17:31:29 -0400
X-ME-Sender: <xms:sTAQZ_7MNK6dbibfODEAI1ADz7h8OymTuxrFnweDZmjjtiXly5Ad2w>
    <xme:sTAQZ06YxSKbrcjFkO-7JwMaUH4-3AcImdisRcNbhAp9Rw7qfhVxynGXroHJHbNQL
    p0kVd23PiZDbcRiEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdeuohhquhhnucfhvghnghdfuceosghoqhhunhdrfhgvnhhgsehgmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeileeuiefffeffiefgleehgefgueeu
    tddvjedvjeetveduffetfeffgfektdeutdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnh
    gvthdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepughirhhkrdgsvghhmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvug
    hsohhnrghfsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihi
    lhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnih
    igrdguvg
X-ME-Proxy: <xmx:sTAQZ2dFQFgb39Cudd2lJEkCbqDB0Pokcfs8H_wofnkciVcNQdwKFw>
    <xmx:sTAQZwKDj-PwCfuzWEktBTT89p_kpD-9mCI4xTSsnOUNPwL-UBRYWg>
    <xmx:sTAQZzJY6pHfxRyHgWFF15ZEaOhj8xa_EsNawyECGv4yvJjG8nTTRQ>
    <xmx:sTAQZ5wVA9fJpT6cGF9Q8H_nrv0zjJWfvDwpb0iFwgJyAGYz96HFUg>
    <xmx:sTAQZ_LsJ_gs9rAmBwD4Eo5as-cwUas0tRZnzEg4hLMaoUNxSDBpfrzM>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B130B00068; Wed, 16 Oct 2024 17:31:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 14:31:09 -0700
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Dirk Behme" <dirk.behme@gmail.com>, "Lyude Paul" <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, "Danilo Krummrich" <dakr@redhat.com>,
 airlied@redhat.com, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
Message-Id: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
In-Reply-To: <87iktrahld.ffs@tglx>
References: <20240916213025.477225-1-lyude@redhat.com>
 <aef35907-b92a-4f56-a330-b4be06f11984@gmail.com> <875xpvhlgm.ffs@tglx>
 <Zww-7DO8jeQfnItV@Boquns-Mac-mini.local> <87iktrahld.ffs@tglx>
Subject: Re: [PATCH v6 0/3] rust: Add irq abstraction, SpinLockIrq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Oct 16, 2024, at 2:00 PM, Thomas Gleixner wrote:
> On Sun, Oct 13 2024 at 14:43, Boqun Feng wrote:
>> On Sun, Oct 13, 2024 at 09:06:01PM +0200, Thomas Gleixner wrote:
>> But that makes `cv.wait()` not working, because interrtups would be
>> still disabled when schedule() is called.
>>
>> I'm waiting for Lyude's new version (with lock_first(), and
>> unlock_last()) to see how we can resolve this. We may need to redesign
>> `CondVar::wait`.
>
> Thinking more about this. I think there is a more general problem here.
>
> Much of the rust effort today is trying to emulate the existing way how
> the C implementations work.
>
> I think that's fundamentally wrong because a lot of the programming
> patterns in the kernel are fundamentally wrong in C as well. They are
> just proliferated technical debt.
>
> What should be done is to look at it from the rust perspective in the
> first place: How should this stuff be implemented correctly?
>

I totally agree. One of things that can help is handling nested interrup=
tion
disabling differently: we can do something similar as preemption disable,
i.e. using a percpu counter to record the level of interrupt disabling,
as a result, SpinLockIrq::lock() just increases the counter and return t=
he
Guard, when the Guard drops the counter decreases. In this way, no matter
what=E2=80=99s the order of Guard dropping, we remain correctly on inter=
rupt disable
states. I can implement a new set of local_irq_*() in this way and let R=
ust use
this. Thoughts?

Regards,
Boqun

> Then you work from there and go the extra mile to create some creative
> workarounds at the abstraction level instead of trying to mimic the
> existing C nonsense.
>
> Which in turn gives you a way cleaner pattern of implementing stuff in
> rust.
>
> Stop worrying about mostly irrelevant low level details which are not
> relevant to the primary audience of rust adoption. We can worry about
> them when we replace the scheduler and the low level interrupt handling
> code ten years down the road.
>
> Please focus on providing a sane and efficient programming environment
> to get actual stuff (drivers) into the rust domain.
>
> Thanks,
>
>         tglx

