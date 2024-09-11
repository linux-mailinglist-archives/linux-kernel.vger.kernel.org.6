Return-Path: <linux-kernel+bounces-325548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A4975B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459251F21DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5281BAEEA;
	Wed, 11 Sep 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dNyEMBDf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD21B29B9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084672; cv=none; b=illmaOG5L9ScLSt+VXj9sHUckC7Xk1TNd+deEOsr+q7konqNfxOfXSmkxBy8s5VwamXo0NFbL1SGkUwZ30IYY04eZkJYpAjEVo1TvCbErsZMyOAgJ4+iAUic9dDFPWjow3oUkI8mEzlvngAh9CT/Yza6/Yku9Jr0nAGn979W0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084672; c=relaxed/simple;
	bh=TydEbWqN0eFNSU6dDcEtuL0aKp51b5Wvl+qj9yyJiv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5kYP9EeWB+EHQumS+y24h2Bc1vQ9xSy2zrujOHtvAsIM9ASXtugYnLyWD1iUasOA74jbWolHyr0ePlXGxL56UOms5S47e5tg7hHdWTU6wsVY88RRzQGfuTzqPdNdFM1tHIHbZdsRBiYG190ezbhcdNW1IbdfuZcTlDciju50Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dNyEMBDf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so220549866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726084668; x=1726689468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCYTrbfOU4Zba2OC0hhtiywmRWH1bHD0rXp427ld1jI=;
        b=dNyEMBDf8gEhrrHuR298/dt1AYpdW+7OsuwfWul7OpJbg5o607x4k/d6Y1eHwV5YRs
         P3xctrsHRSMHf3n9KQrZNlk85or+TW8ds5Gmqq9ShLhW/USAohEWbN2xCu0P5jZgcMjQ
         GtM0cxyotPYBjP56hQv4opMzEGC30D8iKw9YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084668; x=1726689468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCYTrbfOU4Zba2OC0hhtiywmRWH1bHD0rXp427ld1jI=;
        b=hcGokNaJnVgJwiHbLJVNrtDL1/UFp8bn1Kje3TglWUXDh071ItsAwDlkb+IpRBTWsk
         tsopSe+MkUxuXOKcsz5QVeqj4JY7szKsfjy6gGuN+6Yed6SUs3anV3ZqL+IEl5Us4Cmm
         waDpLY9qukum49QurUF0/6TSr+fIwvCvtfMolAvZ+KcrcoBtSjJq//8gzeiD1kQjC5iq
         rG1RLecNwvmk/imlGsz2tM8P48xPR6bA0rzqtt5w/L/n8kGvi5jdx9SRsty7K0T/H/2c
         AkEhabSgo60ekDVSyPbT0zf4SwuEyS4WImdHWgrVxiYI/rLtozJKxPFl4iNoOT9foxJk
         VEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1/S0abqZUrCTpctvI+0viC9lGAoQJyF+vutZra/aTVs7x9HRZp/wQpzE4/Zrkt/1B+d8c6EQwOmsicqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Q8maxFVWJAEhX0H2AYVeYZZB9d64YdErmo5Pl61Kcmhf7yu2
	He8CUXtYxivSa3Dphg/axI+H7UGKPmpALV/CZhVWyUopHqCYhpfWIlY+wRnMS3ZdIf5mvyIFqDo
	jdqdtZg==
X-Google-Smtp-Source: AGHT+IFZRBCCV0eJTDelOXvlZ/Z3FV/omwKq88Sxg37eS+WTGPkeZuQXFboKMdR+2K241CmXN+dcoA==
X-Received: by 2002:a17:907:3f26:b0:a87:370:8dfc with SMTP id a640c23a62f3a-a902a47871dmr44518266b.14.1726084667952;
        Wed, 11 Sep 2024 12:57:47 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a4428fsm648740666b.97.2024.09.11.12.57.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 12:57:46 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so312411a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:57:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7qgu0wV2evUpUdblv/SfpBL/zmq/Hm/Vs9Q6ccxampJgE4W0akbe+LjPO1V8GQuJ8StU3ACQLfiO+xJo=@vger.kernel.org
X-Received: by 2002:a05:6402:3552:b0:5c3:ce35:d165 with SMTP id
 4fb4d7f45d1cf-5c4143835f3mr400036a12.12.1726084665862; Wed, 11 Sep 2024
 12:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911144412.GA16954@redhat.com> <20240911174107.1217693-1-romank@linux.microsoft.com>
 <20240911195311.GA16757@redhat.com>
In-Reply-To: <20240911195311.GA16757@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Sep 2024 12:57:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhqn+B85OA8pfLhckUXSwLtJzFq5JPO2cNNzhPN__HJQ@mail.gmail.com>
Message-ID: <CAHk-=wjhqn+B85OA8pfLhckUXSwLtJzFq5JPO2cNNzhPN__HJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, akpm@linux-foundation.org, 
	apais@microsoft.com, benhill@microsoft.com, ebiederm@xmission.com, 
	linux-kernel@vger.kernel.org, ssengar@microsoft.com, sunilmut@microsoft.com, 
	vdso@hexbites.dev, workingjubilee@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 12:54, Oleg Nesterov <oleg@redhat.com> wrote:
>
>         - please try to make your changelog more convincing. And in particular,
>           please explain why !!current->ptrace is not enough and this feature
>           needs the tracer's pid.

Oleg, I realize you like the simpler patch that only has that
"!!current->ptrace", but my point is that even that simpler patch is
simply WRONG, WRONG, WRONG.

There is simply no valid situation where a "I have a tracer" is a good
thing to test for.

Whether it then gives just that "tracer exists" information, or the
pid of the tracer, or a proper pidfd that is actually reliable, is
then entirely immaterial. The whole feature fails at an earlier and
more fundamental point.

              Linus

