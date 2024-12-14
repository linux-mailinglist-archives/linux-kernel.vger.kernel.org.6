Return-Path: <linux-kernel+bounces-445845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46729F1C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587F5188D3B0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EBA17543;
	Sat, 14 Dec 2024 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDleB+aQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412991CD2B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734144785; cv=none; b=eebIYIY/yHTp31y2f19L7TLHhZd7ByLFsZzDaqEIOo41zsyHYvdPxAaOtcMF5900N+3faQKRfK9e6uJFmF3XE4rgzqc32ebO+OCm4VeR6Lr2U2IvjF2qCoihqSZGkDTpzKSTT+7v9M5xxBTmKliOw5zWiJjh0NePN7X7IZAcgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734144785; c=relaxed/simple;
	bh=W/vuPUG04kZuvtvbS2itX/gg7Q3mEnTK+YwJQnSopXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UazJYGFl572AyPVMBeyIy2tHdOm48uC6ZBfhfJf4tnarqQ3meytA07wKLDk3BuB8H5oEL0kbuUXWXWANUaAJsg7kIr6OXDt0vEPJ6ghRp/RE4W0rTGCI2KGjcYWcohOtHC7/cSwLybCRrM6F6l0ajmUe89vvRkokZIrxgHMirMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDleB+aQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e1799d95so2872604b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734144783; x=1734749583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoSCsOBB1zMFBPFMyed5n425wAfTXjv1eFmj2Y6uIoA=;
        b=BDleB+aQWUw33tcQq600zR+3j4AR+Mm5HMWtaV//RbiTOUrkOqdz+8CIbj3dE/hjCA
         kVcbMU/2jg6oTuYh2Z+VbPZX0yPnY4ie3keyJQMvqsXINXr7nT/n+O40CWFW7IqTXZYq
         Hu8vy5ZL9IjIXP0KmB8BNfG8dMyt6IkqztUx4JsAzpH5mLRzxBjX8bAm+NmAM+G4wBE3
         qXy7VvrpHo+2xziW85F3XMqy94dirMl0Xnk7vwaKQ2Rkv8071VUw44tzFgdUfbNWBFov
         dKAV8ucI/+gSeTegblF2Q5t8u9gM5nDN/Swd8nPGL+GK/4GoG4a7G1OcVNxKRG02Xz7x
         Aefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734144783; x=1734749583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoSCsOBB1zMFBPFMyed5n425wAfTXjv1eFmj2Y6uIoA=;
        b=gFnco3Vd4pITC0rt7Xs82A0phDcXcHCIZhqKw4vG0Pf16GD+AhqSBFXHA5J9xOeP56
         Tf9+WmrFspuBy61g1kWcuIwKYuzyj/KFbkDuWSjWb+T6aSxGc6wOadC7Y0YmcLfBBveK
         XV9B/bpAidwrMLlsEuE+H0oi7f1RpKeJ1kt5mpnIpsFgJ70bAMurtslWhfvrnbf3g1IQ
         fVv0Pzwi/YzZFkAKdiCQHgJ0w5qMMq0cCi+eyyIZ3igifontZ2jQiavyvjefN2ycf6xC
         9r/8ATmrYtIJtt4kruF60uAz9UDR67YFBDwpavgR17bE7pyejlVjEAiULS9xi7Cj8xn9
         sn9A==
X-Forwarded-Encrypted: i=1; AJvYcCUW+J1MHZa+M7e7i+gItmZF5dQlsFaxo57nrqb5eRh3cGCxMxTZTKDvsvmOInmm9LDuTCwNZs8HSNZ+WsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTq8dRqHhNsZb5BfBsEK0hQlDKSTsmzWUzCSFflEuthAG38ZDW
	gnq/mciZL5pPyNCxcAtSn8kUwNv2TK1IvC7X1VuhA4vR09N0bON3
X-Gm-Gg: ASbGncuuoZtE/E1h5ZJ6gouD+L1FB1QB86eUbbdKoxo8FQZOFnSfpWKDmA2dUH5VyKD
	hadQMTJHE2bbQfEepJwKIIYCO3og/Qn4GB9bvNi8GlrXdVOmf0RNpjifYMCGRAipxtI8tfZZqIn
	RTSySxpnT27e4shyQzD2r0zD+sKWuFJ5zJhPn3I9AygRFuGNQOSg4VskG1zhlIwnmpSgyIoiv16
	A+FsX+w3N82x2vSJcQ9lyTlG5MK9DWgmhSUdN80goMX4gm3IEY726U3fx1fKFUFiEx9KFBE
X-Google-Smtp-Source: AGHT+IE9yqKil16UkLMMa1KH51Cvs9G0UBDPnpq9LgjvcrdnNNDNXHdmMKrSw03O3bDV/dXgA7bc/g==
X-Received: by 2002:a05:6a00:181d:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-7290c184ea9mr6904515b3a.13.1734144783480;
        Fri, 13 Dec 2024 18:53:03 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac53f3sm525391b3a.27.2024.12.13.18.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 18:53:03 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: liam.howlett@oracle.com
Cc: akpm@linux-foundation.org,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix outdated incorrect code comments for handle_mm_fault()
Date: Sat, 14 Dec 2024 10:53:00 +0800
Message-ID: <20241214025300.1697300-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <qby7q5ghatldakzgayxr573g247pgoyuz2jkytbcnvwhas3mla@nvc4whogmnut>
References: <qby7q5ghatldakzgayxr573g247pgoyuz2jkytbcnvwhas3mla@nvc4whogmnut>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Dec 2024 10:24:00 -0500, Liam R. Howlett wrote:
> * Jinliang Zheng <alexjlzheng@gmail.com> [241212 22:18]:
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> >  mm/memory.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d9af83dd86bb..d7342a726845 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6159,7 +6159,8 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
> >  }
> >  
> >  /*
> > - * By the time we get here, we already hold the mm semaphore
> > + * By the time we get here, we already hold either the VMA lock or the
> > + * mmap_Lock (FAULT_FLAG_VMA_LOCK tells you which).
>            ^ lower case here please, otherwise looking for mmap_lock
> 	   could fail. ie: grep mmap_lock..

Thank you, I will send a v2 patch.

Jinliang Zheng :)

> >   *
> >   * The mmap_lock may have been released depending on flags and our
> >   * return value.  See filemap_fault() and __folio_lock_or_retry().
> > -- 
> > 2.41.1
> > 
> > 

