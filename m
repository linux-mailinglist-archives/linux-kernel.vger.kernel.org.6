Return-Path: <linux-kernel+bounces-568047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE152A68D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AF426EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30FB253F1C;
	Wed, 19 Mar 2025 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgECjlsg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96625250F8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389666; cv=none; b=NbHpbLZ9CSrEiAlQqME2ui+fHo2mLi/VahqDvl+x290NryX88DHBudbKj1BBC1NPk/mn9zAfAX2LufQDoFKi0xqnb2OEGwFsgjXOOZ2Ff2+cuqxjHdq9pSZWbd9UW/P7e2AVKE/jssCZ+3nb4pGdzEjgWRlSdJpFG3OGrtIf2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389666; c=relaxed/simple;
	bh=tjNGfDNbFxJXjsfq8RJtooSKbWQIDHcL3Flj6rwHbTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEtMbW+B23q0RLPsUBSKmkHlUSlqSvVTGbSsWa7Eq8vM0nmlXK3Y/o7/lZ/jWTfmyaIBHZmTlLV30EIdVbrmH0UyLtt7+DvmEbp/UWN0eRL8efYTDQMWo50E5Yxz/L1Cz0qDnOvrcAWZx+YrNLvki1AEyRjlUCuGGHtlYoy2050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgECjlsg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39129fc51f8so6081274f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742389662; x=1742994462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LaMa5O/1onD3ZHUjn6Tk2stfCq5DyYcHj34L+aNHEU=;
        b=jgECjlsgEf/1/AsCjGj/6vY1CHTBo9fH5kt30XheGRhdj2jvR/eTwvOq2VwoxLHFOi
         M3v1Ohnkwz5z1Xou2lgilQyPGtpVQCAlrvemrQ04fcWCiHB13d+5+/jftNAwRxVqkDlq
         C4+F3/JFDgoCBjOitzxMoS6HqfSjUq0BGcIZMtFNXQvmbH5IXjok6ErfsTMwxk4SLRUR
         diqcscruYGH4A6/ue+DPVkLWK4H8IwRG3sHA/L2XmeaRjtZ36C283TGeL5VcXb/ocHfL
         GQ/xBfQh5w2tWw/cZUbtBAr2w8jGiDdam2DP63b3xCut6AgAd4xFRleHYuVEKDp5Bepz
         sPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389662; x=1742994462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LaMa5O/1onD3ZHUjn6Tk2stfCq5DyYcHj34L+aNHEU=;
        b=uwaQSUSQ04RZizaMVuGjxV8K8BZQ8sUp7IVZj2oSJ6CMXWJGPgKA0xvJogKVL5Jt3/
         2T9KzBwnjr/c3fBHM7OxegJCZarCZv7iQlZ+8Wmrg59hQRCKHlAx2WAhQ1lNVOURbmbn
         0GiL9Bk9JI8DU24vSwlu5ZF4oDDFDQYDWI4djya2jDL5r/MxeV11M3JSpQ6Zl01IS13L
         SNJbMkxqKNPo+qo0WhFGxMMO02tli+eShgVQok/3AcAbV0UJxqdibqulHYc80/0lGHqA
         OYmSWGlE8mdWOnD7jEdSsm8sTeLZNSWYedwIVuvg3ipEgOTEOPixNaf5mPoYlc+1bygX
         FkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg2l8N3IxQUoK0+TIQBQ+fn+MzX1UrGLwV4DdSpIJEbKNsbNX4TiFq0e3BmerAO+uqjxVBK0xuZKvKV3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3J6MRk+YmKt280PO4UW9sZzyMrQDQq00kiyOfUe1nnQTW5mi
	5AKLJzqMfMY4n48vOIO+budnEQArovb6c6mS3KAISPgXQ5rZspKz
X-Gm-Gg: ASbGncsEus6IBFc7FqUYYh2RQtTFgReLb/eFuj6i6pS3PrRicVWIpZzPhvPVaeMvfw3
	qL38mgVBepl//pf17iH6OvQHBPFgzvJvQru+S/WVrkvYCe0ubyIxmZRNlonUtVxMgs3QdrgEWRZ
	IqVdV6sMbJU84uaxJ/bpUkVoXefqIAgNmGgH+Qm8miRG3xtwt3dbVmDnKkbHef0itjpkYog9qSw
	GpKu4T16BVKEL3BwHhVlCzbDqdptBllqZV7yyd0/H8B4CGUhjIsmp/gWmRkPsvYwGgD41903FrL
	XVmdRC/Ihv12DGNJMdCs/PGMNUs5+4mkamqT5A7LNl63fm5IP4/4+binF2GF1uU/VbFf1ip05ZB
	TVKLQRbX/qfBQfvZFWw==
X-Google-Smtp-Source: AGHT+IE3ndz65dSeiFl87OzIOjD9iW7wVp+7yq9YBDJ9RPmfRRVs15ab15lihrsrL3xv4wfp2lh8Dg==
X-Received: by 2002:a5d:59a5:0:b0:391:43cb:43e3 with SMTP id ffacd0b85a97d-39973b0b964mr2575877f8f.46.1742389661590;
        Wed, 19 Mar 2025 06:07:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e87sm21605596f8f.32.2025.03.19.06.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:07:41 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:07:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Herton Krzesinski <hkrzesin@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, olichtne@redhat.com, atomasov@redhat.com,
 aokuliar@redhat.com
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8
 bytes in copy_user_generic()
Message-ID: <20250319130739.4c93069b@pumpkin>
In-Reply-To: <CAJmZWFGOc_HR2xrD_L9PADmfWP=Sg9v3-yeDRdiw=mhD_BSwww@mail.gmail.com>
References: <20250314175309.2263997-1-herton@redhat.com>
	<20250314175309.2263997-2-herton@redhat.com>
	<CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
	<CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>
	<Z9au20vtMSXCbdXu@gmail.com>
	<Z9axe9Ac5biyJjCC@gmail.com>
	<20250318215926.0a7fd34e@pumpkin>
	<CAJmZWFGOc_HR2xrD_L9PADmfWP=Sg9v3-yeDRdiw=mhD_BSwww@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 19:50:41 -0300
Herton Krzesinski <hkrzesin@redhat.com> wrote:

> On Tue, Mar 18, 2025 at 6:59=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
...
> For Intel, I was looking and looks like after Sandy Bridge based CPUs
> most/almost all have ERMS, and FSRM is something only newer ones have.
> So the way back to Ivy Bridge is ERMS and not FSRM.

ERMS behaves much the same as FSRM.
The cost of the first tranfser is a few clocks higher (maybe 30 not 24),
and (IIRC) the overhead for the next couple of blocks is a bit bigger.
Reading Agner's tables (again) Haswell will do 32 bytes/clock
(for an aligned destination) whereas Sandy/Ivy bridge 'only' do 16..
I doubt it is enough to treat them differently.

The real issue with using (aligned) 'rep movsq' was the 140 clock
setup cost on P4 netburst (and no one cares about that and more).
I don't think anything else really needs an open coded loop.
There is no hint in the tables of the AND cpu (going way back)
having long setup times.

The differing cost of different ways of aligning the copy will show
up most on short copies.
You also need to benchmarks differing sizes/alignments - otherwise the bran=
ch
predictor will get it right every time - which it doesn't in 'real code'.

	David

