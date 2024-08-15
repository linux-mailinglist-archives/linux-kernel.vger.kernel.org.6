Return-Path: <linux-kernel+bounces-287605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760C9529D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9B6282C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8B17ADFA;
	Thu, 15 Aug 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gD0OChyH"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5818D65A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706674; cv=none; b=FkqyEpxj3/4gBpvSTQgIsFCP1GdH8SVvZERtNldRgAQHYLxHzFQ/QRjdNfekQYMwoRCjM0YJuhpPxCY7wfV7iQpz/D1/UmOtq/w3YdsYKJHuxmOyy6Sz65WEKFnJFRtmqK9m+USvkHVZH8yV/upK3F+s+6TzAHAAhhtnCQB7jbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706674; c=relaxed/simple;
	bh=0ZvWVz8laCkPwuTcmfWk3uba6EnZQvtbzPCAun0rGJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cke4h4J+ZheVJXFI22G/rV9+cBYSjpGTIKrR6AWPcUsqEJsxrTBCiO/xUcuEwosIMUsAnympHI4gov+Bcjjj4uJ0t26rF/XjAlqKUap3x+y/I1WjehblIuXlTrkvuq5D5B5Yc4fuo2Giq7l9jw6QsOpIoTTkBOpmtPZenb/WUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gD0OChyH; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db157cb959so412017b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723706672; x=1724311472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqHUZASxk9lo+KYeDHahILtgGWgy53G3aaTiMVVr4Jg=;
        b=gD0OChyHkufM9iyTmR0/Tl1M3AZlpaIzKaEd2zl2iw5QUabhqAvWejC4hasDXeIfbO
         DJCh+LmwVtjYWdHOMOHrEqDOQaoFI645B3XUaP3soxfoNVojzagFV/1LM3yFsA2g/gdy
         szH2oDOOPQV/AipMmWhbpPBDtjLiTXzf9zwPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706672; x=1724311472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqHUZASxk9lo+KYeDHahILtgGWgy53G3aaTiMVVr4Jg=;
        b=sP87mPwyiKgmbqfsY6EJEjgGCZNjRupOj5/QvHcCkYqYAasGzslOTuQs905wguI90l
         eIawxwBIGtfymx0jKMovrJqtGK8mdpLUmrQ1/44ngaWrJFVoq1toZwtnxV4NMp/vm5NZ
         X1HexzHxG/uo6znbLL7BeP35i7FImthDhteWzOgFRWYVQVZc+4OutWL9Ktr0lJeYWHd1
         +M+RLl09/sjlbvCshPiI4uhWocAKQR+RCjdwNjzaDpId+eCEhQBy9esZv0Bsjzga8sp5
         5WNlfcm4ZWOCHVVLdiMpuTX7m+cBbFJE2+vLSKn8CXhSeksiuC8gPp0blFALqzzbLmsU
         nigQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1qqb0VhtvLVcvLCQLSDUAEjg5lJnOneA0eXGOtUjY/r4TYrrbjFgD7RrhscWMudEBI51bRsfiKOw9zb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbVpTqGM/ICPhmEZH4Kt/fVKA7C+TpQalyII7XAUxc0MfaCFte
	EYYUeJZOl0r1YfF2mIVsQ1OyzOv+FG7AjiQrnGdhhX41H9tJL9rJmXoNFMM20w==
X-Google-Smtp-Source: AGHT+IEJ6FSV0d5pvQzbTGqH3ePSY2RNyygtwBfDUFMilqj0MEy+NPX4/OaCoG7e1Xb8T2Pvhn0e0Q==
X-Received: by 2002:a05:6870:7312:b0:25e:2208:6c8a with SMTP id 586e51a60fabf-26fe59d7f5dmr5169322fac.4.1723706672331;
        Thu, 15 Aug 2024 00:24:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7dc:2307:3c4b:963e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1999fsm549312b3a.169.2024.08.15.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:24:31 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:24:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <20240815072427.GC12106@google.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815070900.GB12106@google.com>

On (24/08/15 16:09), Sergey Senozhatsky wrote:
> On (24/08/15 16:02), Sergey Senozhatsky wrote:
> Oh, okay, so this is related to [1]
> 
> 	workqueue: Split alloc_workqueue into internal function and lockdep init
> 
> Cc-ing Matthew on this.
> 
> [1] https://lore.kernel.org/all/20240809222827.3211998-2-matthew.brost@intel.com/

Matthew, did you mean to do something like below instead?
Otherwise it breaks boot for me.

---

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7a2f4cbbe8b2..55e0e69ee604 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5615,12 +5615,11 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	} while (activated);
 }
 
-__printf(1, 4)
 static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 						  unsigned int flags,
-						  int max_active, ...)
+						  int max_active,
+						  va_list args)
 {
-	va_list args;
 	struct workqueue_struct *wq;
 	size_t wq_size;
 	int name_len;
@@ -5652,9 +5651,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			goto err_free_wq;
 	}
 
-	va_start(args, max_active);
 	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
-	va_end(args);
 
 	if (name_len >= WQ_NAME_LEN)
 		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",

