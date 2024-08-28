Return-Path: <linux-kernel+bounces-305410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D65962E43
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4291F226F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB80C1A7051;
	Wed, 28 Aug 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBLCCn7E"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0261A38E0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865256; cv=none; b=ISy6nPBnGQBj28wUmkyYemoYoZwyndgfWF/wZL+23D/zwgBrrNU6oAo4/ARqS1230N9N2cyo1qlHuNuNShFbNsFeYZylHg/pbaH0zKlMdlcObJGNAomGd4l+FFTsNOEEezuhafgqE/ak/9x/5RirHdjUn+qSH1fhL0Hzz9T2VDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865256; c=relaxed/simple;
	bh=XuU6lfnAXc7wBWZXO3LoSeJokR3ZvXf1xIXUsa6plnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD/uCKbJ4gfTUd0V8Vlo/lDA8h5msP4n/SqMXGK/5OwywnTLfn/50m5LhOCwlaT91/ntAM2HoWHeXluZbDifhvMOj0+16wV7RKRA7cVfnDnHQTR/CKxLrgl1nABY1ofA+cycAHONdBqa09jZ9c4Hu/a8WTazZSGs3YsL2OaTp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBLCCn7E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20260346ca1so13565ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724865254; x=1725470054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgsg9KYlOPgnINZ9GfyD+BBUo6PvUfKigYVEMj5LYlU=;
        b=VBLCCn7Ezc56gL7vPp1OxXFkJWx8jAiTv0mUjPaAAvyu9Q54RSTGZk5WYPf5/Cuney
         HmVvgHK1gmRL+MqRrQ1UFyzR8ClsYgByXUcVolKD+HheNu8dhHOY4rn9WbWn94O7dDXd
         CMHvJkiiH5oTL+0juR0ZVOdwbAN5pY/1owU+grTKXK/THk+hntu6WO+94/ASNyoVIKsW
         MBGqoEqkH4baLsuvXhV2oeLX/2R82hUckXEge9H/w0X1RCQUnwBDu2USW6ivrxgch3M4
         RjZyzr23IxbzV3RzmBbCxgVStk7lWg6xGOWF3XM96LeNfZvk4cxAMVhSu5Hul1V5h2zx
         wpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724865254; x=1725470054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgsg9KYlOPgnINZ9GfyD+BBUo6PvUfKigYVEMj5LYlU=;
        b=U/O07yLJWgviDtlMZsNJqfs+zTqANK12fSdXs2EbiS0aZxgfaN/A1YCtO3boROT3VS
         TJVC1bn0v7Mh+SEh7d+Mqb0dFG2lboK/w4HDGI841KR8tKH9/8xo8Oecd20b96aq2Tpl
         izsgtmyjjj9mvE7VwIooA9Ry3eq3p1goFU5svMQ0+tj7cPXncqokMmouMZPzu+ZIdzda
         yK6FAIPsNMeVh7EtVrBX8PGQc/efgbZgBXhOQ7+Cskg6IJdPxC8ADpG2C6hJ7/uo61Z8
         6H7lSFrw5q6/N0qbozlvEvrUbIUJ3MJMRxHkqilIslxSu+Z1zm+1Aem9oxrJBNDR6snP
         +jow==
X-Forwarded-Encrypted: i=1; AJvYcCUx25ZwhbPTB1+H/00ol3NTquskLCFvNq1Yewg+gO6t+nE1aes1T1o/qrsO1D4YRAESPSgo7L0FgLHoHlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClcoRYzI6Zt+c0/8REZ7TjSUS8QN9I1TR9xsGEjpo/GJNfdvC
	qpe0GndEDGlxj8FuAno4cRsmtbtCbTPmOUoaX4C6iZpMQg5RDv9x41pGR1hB4miLnlXOUweoBMD
	lmZi0Mkrd22ZeASwIhcbejFCf+pCU0mEoYcR/
X-Google-Smtp-Source: AGHT+IEclezY9FbFmYOMIJpk7h1+XOP+3gwZEglT1ovqH0RFwg8+37NHUTVC2VrWG5GzhCh5VftM3Q+HdyA8/UzsKJM=
X-Received: by 2002:a17:902:d512:b0:201:e2db:7be3 with SMTP id
 d9443c01a7336-204f960ea01mr3339395ad.21.1724865253338; Wed, 28 Aug 2024
 10:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140736.156703-1-james.clark@linaro.org> <Zs9YGP4d0_QanpoA@tassilo>
In-Reply-To: <Zs9YGP4d0_QanpoA@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Aug 2024 10:14:01 -0700
Message-ID: <CAP-5=fW=eYuKQtnd=1gM3wh7MubZ+P56ZCHn9dwvkhUn_NQZMQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Event parsing fixes
To: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	kan.liang@linux.intel.com, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Ze Gao <zegao2021@gmail.com>, Yunseong Kim <yskelg@gmail.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:02=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> On Wed, Aug 28, 2024 at 03:07:14PM +0100, James Clark wrote:
> > I rebased this one and made some other fixes so that I could test it,
> > so I thought I'd repost it here in case it's helpful. I also added a
> > new test.
> >
> > But for the testing it all looks ok.
> >
> > There is one small difference where it now hides _all_ <not supported>
> > events, when previously it would only hide some selected subset of
> > events like "stalled-cycles-frontend". I think this is now more
> > consistent across platforms because, for example, Apple M only has
> > cycles and instructions, and the rest of the default events would
> > always show as <not supported> there.
>
> I'm not a big fan of hiding all of <unsupported>, when they are explicitl=
y
> specified on the command line they should be absolutely shown.
>
> I do have tools that specify events on the command line and expect
> the same order/events in the output. This might well cause breakage.

The patch series doesn't do this, it just doesn't display unsupported
events that came from the set of default events - default evsels have
a "skippable" flag set. In patch 3 James has added to
should_skip_zero_counter in stat-display.c:

+       /*
+        * Skip unsupported default events when not verbose. (default event=
s
+        * are all marked 'skippable').
+        */
+       if (verbose =3D=3D 0 && counter->skippable && !counter->supported)
+               return true;

Thanks,
Ian

