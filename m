Return-Path: <linux-kernel+bounces-293099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FF957ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C149B21E79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722451A29A;
	Tue, 20 Aug 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cczUGS0P"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E817BB7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116306; cv=none; b=lf+NJDRPcVNXrQOiJAy5DgiUfXLYhjfMWTCMWtKievDIJKTnnNgFHW9HPdP2vVwQXLuf39oGQOxJUCeVXJRZ2zcNJ5EvnX8ZFVhO2y03vCWmiUqRptH+DW/RCBa+3UzILWdGdQAs1Wl1BbpFDuoVOcEd56Tss/4/93GAHNwDSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116306; c=relaxed/simple;
	bh=UwkZsnmFTogapUcvQLNdDygak09Kfc+DA1y61X4GWs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIcJ21TjhMkxSKV+4gyF48dB0SwuAAzkMGKgy9GIiGmqsxSTc0P8tf+zTEUIubl4LRkPPK987/8f/yrfxRPcKt4NQP22VgYwM/yjLNeX/mmcI+aQVjpvwkDb1ij1w1WxQmHpxmY3fXafYBPYEBARseP+zCJqo14UeeXBp9cuHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cczUGS0P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso41322725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724116303; x=1724721103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=cczUGS0PQ1YdekV7iQZDZrupLGd8gJ9vUdU+VlYz9RrJTiwOY9pQvBv1+pIfMZcExt
         xf0Ruf54mw20BQMmtO/3WQyv7xzAcSv/uLlFJYD1F8K8bKIEmbfXTBy6vZurkxtKxxOM
         Cq2uWazRamKZCwqiqRoUZaKvApZ2uK3nPlF5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116303; x=1724721103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=CnOWcVaibgrk493lGjUXq5I46RGeKhJOBracQCJ0a1YUlN1poBZ0VoA6u1WmHpKHqW
         U+Ntl2DvQ4snCv/PCPruc8xOk7cOB80HNr+TfoPWVcFZz3KeSCGHCzEHUSeQWx5uxRFY
         0OoXbC0NskpujKK1buJuo2/KueCy1KgRcQ/xwESvXNnEO2HRoloAeYVPasnzGqSloclb
         XHFNj65IDUyl/v1ZlryqxMtd01isXnM+E0qUDI1mPl4F7XG+48AVTrUWKzlCTlg1aJEJ
         IGHDju/Wwnm3fZJqPXIPHqUW+dlxKahg7drMvtMbs1SyfLW9OPFHN0Huq2a2psXbD9y8
         NItA==
X-Forwarded-Encrypted: i=1; AJvYcCUCGFtgv8EfY+21JqS8m4yCn8NuUMR8nVOerRuVx1PhbEP2iRD5JKSxEW5xbn3fRoa0TDlDlejR0W1WWpexsll4SgcHhz0kQiKe0Ni5
X-Gm-Message-State: AOJu0YwjV9KJx6mIfYR2IJ4bQ5xxbc/PWVUKQpwL9uADi/YXf3/S48JT
	WXKwpdOBuC9m5s4BaumAMhqbdduxtRohkqRAxVPqBYnRE1Gx4omzKDQAmRuXWG3/EjPaPOzoanV
	YyL9XzQ==
X-Google-Smtp-Source: AGHT+IFVym/qXAQXDOTh2wZWa0k4JTrCHvw7ICpM9NdTFg3dfKRt7mktJDLs/+16+QibufOt6CV6vQ==
X-Received: by 2002:a5d:6d05:0:b0:371:c51a:3b2a with SMTP id ffacd0b85a97d-371c5fa669cmr370498f8f.4.1724116302744;
        Mon, 19 Aug 2024 18:11:42 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393598fsm697076166b.133.2024.08.19.18.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 18:11:42 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so2300650a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:11:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJZeHphwTWxp61kdPp6pEs8YVVdYiTRCJ+XpFbc5krfLsV3OXtTfwZuXfMtixAjokqjC57oHthL5zU4QiIL71DkdWN4p4j8wFtpdDR
X-Received: by 2002:a05:6402:1d50:b0:5b8:f69b:65e8 with SMTP id
 4fb4d7f45d1cf-5bf0cfbca19mr536978a12.0.1724116301657; Mon, 19 Aug 2024
 18:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
In-Reply-To: <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 18:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 18:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> > I forgot to actually attach that "this". Here it is. For real, this time.
>
> Thanks.  Do you think your one-liner remains desirable with this fix in
> place?

That patch actually removes the whole 'legacy_special_mapping_vmops'
that my one-liner then removed the '.close' field from, so no - my
one-liner just becomes a non-issue.

NOTE! That patch of mine *will* conflict with Michael's patch series,
since my patch to remove legacy_special_mapping_vmops was done on top
of my current -git tree. But it should be an obvious conflict, in that
it just means that the addition of .close never happens.

               Linus

