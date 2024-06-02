Return-Path: <linux-kernel+bounces-198327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F68D76C7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE532817FC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847947F4A;
	Sun,  2 Jun 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mar+lBwc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF561EF01
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342305; cv=none; b=rS0oZOebAmkm5tDYAS/rgZ4HXWynH3EB0Q1yT+DQ3PzEviMdFZbQosO0dJHaA2YSQ5OAXyTrpcYpgZLf7Cn2j+Orh2uWOjwD9U/c7vD1yJNydTH7FsWXgKzKzFIYSuOLUAlgqnwrP32ZR995VojfGzjPC+Aod8vyb4CadDXTGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342305; c=relaxed/simple;
	bh=rNBnPWcv/UT24JI/E+LCM1Eixw1GOAQgxs2uWjTqgKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRpECgdLIIVrSwd8VysyRiazJ8u8GxZornvfs7VSlxGDXKAmP4hsDntjX6s/Gs7xWGted9PV5qWl38JeR1B+wtFm1oqlNfTbO6Mx6bBwDiYKhH/H/DsFCBpMn+RoGuVbHo0yz6cnyLsjQoASetcE89tvdRohOCVL+q5ntxuwZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mar+lBwc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b976b5d22so452357e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717342300; x=1717947100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ef+jPbCl/Q2MIEYpCmzzicRwWRwVQMPXcaN6w64uiM=;
        b=mar+lBwc7SdpL6hPM64DMSqc1Usm8AQXICBGcwGJLppiboetZQyzK2zkBs1UevDqo5
         uCn/2cA43nBkf9rw2Q29lmbumVGRgk4lU0Z9btP3+2y3rHn/SWjUK9Nl/EQ5kNL5aBxI
         zKeCEnEp69NVSCJP5GNAvXYsm7qzY6GfW2GFo0gQ6nseMEp/WhOuqVm+hNy54NQ02ab0
         fBM4Bxojtgi75x/iOOJ1JEJERnxSl2utZqMZWxrribBnQ963diQJ+tWBFnAqZvLDurjP
         3V18sF+4rKeqKlJguxtxqKVpsVTMBmu9nN2gA1bDxprrP492NQjudGDqGHlf9XtA6IOj
         eWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342300; x=1717947100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ef+jPbCl/Q2MIEYpCmzzicRwWRwVQMPXcaN6w64uiM=;
        b=xCWQsTYMBiS6e44EOQjxcd3LkFGgoECEz19vPs2zioBlDFfpkapbQ3DLwW2QI7e//s
         50pZN5aUSliOqFOae4tHy3lwTpXuUx10At792D6wRj5masELWPFswgRFEx2D5vAToNxM
         FjB/MJu1dHYk1B8jP+RQ+9RL5g6pb29Uaq8lnvjMLgk1kmZRrhK7/vmZiHI+j1aNrybv
         X0tkEOqAg93jq6+4tO6aHbCgvFmIr2Dg+vcA7L97YeVEYLzOdu2VvgpWRzeNmM+UIOt7
         O47cCc2y3qAxYJtryIjBxWq0IL6sBLv9Cl0OT/Tmt82Qtpav+9h2qoe2NDgZ3GFgLG7A
         ksyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1NLIMXhqgJoS0ey2Fry41yKWkxmhunefBVHlkkkWsgZ6s5MAbmfInH6ktQnH3QU67RNMEOWPK9rzfQLjgKJTy/bxhxKnLJHwmAjC4
X-Gm-Message-State: AOJu0YyyZ5erGN9iTnCFksUAQpwdr155xOzBlp2YpnPjOKafpmVtN3n7
	70wJyxI6nUACXh0yfgd+y77JApPHELKurw8n9F1NJ8V3syUpNtqP
X-Google-Smtp-Source: AGHT+IFIStiDV5vU5Y0oUwFpyaRIxaKDE45IOTn0TWg6IK6lX2Mk28N1js/u5dlXb1ju4AViWHXdqA==
X-Received: by 2002:ac2:544c:0:b0:52b:82d5:b36a with SMTP id 2adb3069b0e04-52b8957fe73mr4228460e87.2.1717342300040;
        Sun, 02 Jun 2024 08:31:40 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d894c3sm969583e87.249.2024.06.02.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 08:31:39 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yorha.op@gmail.com
Subject: Re: [PATCH v2 0/2] DAMON multiple contexts support
Date: Sun,  2 Jun 2024 18:31:02 +0300
Message-ID: <20240602153102.926789-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240531193307.71424-1-sj@kernel.org>
References: <20240531193307.71424-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi SJ,

> Hello Alex,
> 
> On Fri, 31 May 2024 15:23:18 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> 
> > Currently kdamond uses only one context per kthread
> > and most of its time it sleeps, so utilizing several
> > contexts can scale kdamond and allow it to use
> > another set of operations.
> > 
> > This patch-set implements support for multiple contexts
> > per kdamond.
> >
> [...]
> > 
> > ---
> > Changes from v1 (https://lore.kernel.org/damon/20240515152457.603724-1-yorha.op@gmail.com/)
> > - Compatibility for DebugFS interface is kept
> > - Kunit tests build/execution issues are fixed
> > - Patches from v1 are sqaushed, so that consistency between patches is
> > kept
> 
> My request was to avoid unnecessary temporal changes that will be removed in
> next patches.  Some of those are well removed in this version, but I still show
> some.  E.g., nr_contexts field.  Also, this resulted in two big patches.

This makes sense and I actually wanted that as well, so I tried to separate
them in previous version, looks like I misunderstood your request.

Anyway, don't you mind if lru_sort/traceevents/etc. will not function
correctly without applying the whole patch-set? I mean if we use the
approach below, once core.c is modified at least lru_sort and reclaim
will not work correctly, they even will not be built.

> 
> I'd also appreciate if you can separate changes into smaller ones of logical
> single change.  For example, changes for lru_sort.c, reclaim.c, and sysfs.c on
> first patch could be much smaller in my opinion.  Traceevent change can also be
> separated from patch 2.  Some of multi-context support seems mixed in patch 1.
> 
> I'd suggest below patches flow.
> 
> Patch 1: Introduce new struct and control functions for the struct.  Don't
> really use the struct and the functions.
> 
> Patch 2: Modify core.c to use the struct and implement multiple contexts
> support.  Minimize changes to core.c users.  Just keep those work as before.
> Don't implement multi contexts support on sysfs.c or trace events at this
> point.
> 
> Patch 3: Update sysfs.c to support the multiple contexts.
> 
> Patch 4: Update trace events to better support it.
> 
> > - Added/Fixed comments about data structures/functions
> 
> Also, you don't need to put version history under '---' marker if it is a cover
> letter.  You can put it on the body.
> 
> > 
> > Alex Rusuf (2):
> >   mm/damon/core: add 'struct kdamond' abstraction layer
> >   mm/damon/core: implement multi-context support
> 
> I will try to put more detailed comments on each patch.
> 
> > 
> >  include/linux/damon.h        |  80 ++++--
> >  include/trace/events/damon.h |  14 +-
> >  mm/damon/core-test.h         |   2 +-
> >  mm/damon/core.c              | 509 ++++++++++++++++++++++-------------
> >  mm/damon/dbgfs-test.h        |   4 +-
> >  mm/damon/dbgfs.c             | 342 ++++++++++++++---------
> >  mm/damon/lru_sort.c          |  31 ++-
> >  mm/damon/modules-common.c    |  35 ++-
> >  mm/damon/modules-common.h    |   3 +-
> >  mm/damon/reclaim.c           |  30 ++-
> >  mm/damon/sysfs.c             | 303 +++++++++++++--------
> >  11 files changed, 872 insertions(+), 481 deletions(-)
> > 
> > -- 
> > 2.42.0
> 
> 
> Thanks,
> SJ

BR,
Alex

