Return-Path: <linux-kernel+bounces-221377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFFB90F2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7821DB267C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1B15696F;
	Wed, 19 Jun 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ChcLhwad"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DC152191
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811773; cv=none; b=rGi8qqNli3IZx5v6/EuuuXhXtjja//x+Ioy3LuAUYcB+JVPa3NW/5WDwDH6GElQ5MyrF+ERTrbE8AltYmS4wrrwEpDNNIEcCotIihJVtRsGoMngXIsKYAG+czg9DCPkUPoKp44qOG317h75GadfRNaWnMJQc5ffGlACnaPKO5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811773; c=relaxed/simple;
	bh=s+qqeW802UJOguIjmeEXKOJCXz2i+t+/LhRe+b1qPPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6D37P/Za2nOL9YlsiaE4eUs7Fg6zUgBSJH8JluI3+UFZLLE0ZoDJ1Zc6uzT8xpkgIbl3tnKPgsDF76W8s8wPQeS9gmNuDVWU7akWh55zh4iQ3NI6JWL73FcP+TCBpxcDKnx8AAt/ipSUYgpzmkARhJdPL6b+gIyuxVu3Yw6vX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ChcLhwad; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso1155739a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718811769; x=1719416569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mCd26Kpmq+Fvnv2ArYUPcUx6JklDXjN53TCL/X1xRg=;
        b=ChcLhwadR0cVkimeGrnH2pNpSCp/H0Lmb/KWqGzqWc47+HwMKauxDFQBPA9HKyCjuD
         5EJYapPQcKt8rVPzf0sRRRQ8S6DrniXaOkieimVSkbL/upxLglrCEBH7iJ5LhRvwHz+0
         wbRNmRFwDjgoJvceMrlcD/Di29DUoFe6apG/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811769; x=1719416569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mCd26Kpmq+Fvnv2ArYUPcUx6JklDXjN53TCL/X1xRg=;
        b=EWbv9akZqbrUEL9WJjTTc5mAjWHqDSZWcm+vPe+pXk4BDG2TP7pJaDy5SQyvH41AXA
         zbXR8yg/z3rgyd7mFlHRIWs7SyhrYenSwc1UF2J4CGOI04uiDrhrH7e8zexID2KR06el
         jpQGCLeeqfiP7xV84ZTd+Y6fabxULvYBMg1gHSKQCxCkmEtTzIE7smjjhg6k4Dbmytmn
         oJWGJpVWGlXP5Xv/xqGnjEHIXgzQzKi2Trk6M1o8QX8WeP2+QXU/Tcos/tbP5ftAK47T
         jXlH4RlWEVCIjf40r2mbee8iBS9FixrnlyGWK1rGipn5ih4czC3BVTmbQu32+laRYicC
         D82g==
X-Forwarded-Encrypted: i=1; AJvYcCWrS7+zOaLPnDXT6C8ljKLAu5iCFjmdLhbBP2QanCCormkfPaidR5+XhF1+G5xUt81E8ciRxv/jinH1bcsE1BbCXCMMF0X5cUoZemI7
X-Gm-Message-State: AOJu0Ywp8s8GrCU3r9ynXUbVqjgW45b0rUGKKQVfxBswGNAfruWlsAuF
	zj18CQkDg0lcAqyFX9Yu7RzugnpZU0H9XnxtP9WY8Nfmf97IHbCm19KCxD1FLrJx7ekjMlY3OFK
	UQG4=
X-Google-Smtp-Source: AGHT+IEIaedQIG8dd8ejfxNG2db/PFcZggTAWL1lxELlbR4jnx5o+4tW8omDvQm4/MYhpjEcyojT3g==
X-Received: by 2002:a50:d643:0:b0:574:f27a:b3ec with SMTP id 4fb4d7f45d1cf-57d07e7c4fbmr1882003a12.16.1718811769526;
        Wed, 19 Jun 2024 08:42:49 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da790sm8490658a12.35.2024.06.19.08.42.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:42:48 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so2968867a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:42:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWc7HKyFaUz5/SP0lolZJlkar7yf3xAGWIGLIdTUY8Cx9u16RrFYf2PlfLq7AN9K1a16vYSuYX69pPZO2uJktzT1e98GKPkdom5Kaj
X-Received: by 2002:a17:907:a787:b0:a6f:ad2f:ac4b with SMTP id
 a640c23a62f3a-a6fad2fad01mr173491766b.2.1718811767802; Wed, 19 Jun 2024
 08:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zm1NIOnj0NR3U8om@gmail.com> <CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com>
 <20240619153606.GDZnL65ui-X_bFxYtD@fat_crate.local>
In-Reply-To: <20240619153606.GDZnL65ui-X_bFxYtD@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 08:42:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBjOOZnTuCXipg6+szpLj6Y4XsR30dME2=1xzTLB8aZw@mail.gmail.com>
Message-ID: <CAHk-=wjBjOOZnTuCXipg6+szpLj6Y4XsR30dME2=1xzTLB8aZw@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fixes
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 08:36, Borislav Petkov <bp@alien8.de> wrote:
>
> I productized it like this:

Thanks, LGTM.

              Linus

