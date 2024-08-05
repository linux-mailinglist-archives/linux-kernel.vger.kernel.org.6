Return-Path: <linux-kernel+bounces-275041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B11947FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4711F284D8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51D15DBBA;
	Mon,  5 Aug 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="d2jHGYtj"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90013A3F7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877588; cv=none; b=gnctlkefE5n1wcY5T/YVlnncLhqdXD/ZYWCVCfvm2ykp7CRbWscf+2uLEBNptz7eBeunVGLdRQGXCoJrJpJmysA2MCTTrMhuAJszXSqDXQSpuA4E0t0LCtLb9958pgj2XgrdxsJKPDvkfxeJDgmXczNDr5mfODTRQLMs74xkZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877588; c=relaxed/simple;
	bh=iQtbsDPgR9sKg4X4Eh+laDiLDhT9Z9+F9uTfohkxk0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkqA8U1msS8n5emv2ewoyCkLkOKKb4NBymQzj/u2TNkxhFriapuNhtH4lC/B0C9iJuI/7DGg3sbHzHEAJACDY5RRBqIPSl3uZybYRjjvn0jC4QLUtS7fIOUHoA9/59Ic56jXt7oRSiA2pzBDGOrT+LLTb+NjjtBg7S2a7RXdf7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=d2jHGYtj; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44ff132ff9cso62007021cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722877585; x=1723482385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVdnmiDlJ6/XqpvsgoCw3lC20iW8UH/7vdY3FPonF88=;
        b=d2jHGYtjWFA8J7+6UaudFEFxFla3NT+0ZQTNGI9UgXB6InqQPwFVdHap17INPWBD0r
         e/+FCGrI7VVDBODbHopIB0zVE+pXcwORjqfatSRWmVWBTnhJzmOlC4j4OsQP201z1m/R
         x7aoOCgKZLVmfijMnjuqUAIL2znkSgodgeaF2M5hlV4li2tDGR/J7+ym6Xa/gdBtSLOW
         pEmXN7T0SKu5dHjizNS1GYyVZav4SYFPQpu9fME1/ig/wIQRJ22EnZ9ktZihbx7t29kZ
         q3oROLs5N+pSgB6Snrnl6ZzFnhqpScn1oPXJY3XLHMud5AiDiPZR2ktM5he3L+Sem2uc
         2V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877585; x=1723482385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVdnmiDlJ6/XqpvsgoCw3lC20iW8UH/7vdY3FPonF88=;
        b=CCX+Q3m7mNtATx2SbtnbFrCPz+fGVo9Ub10XxaBNuLUw3+9NPSilBk4fop5t5DMEo1
         WKfJOBfvF/SD2WyO6M8/rOHP/JVRL/T00UA2/QWB/132ijivtpZJWPyG/KajRmrwDWhK
         vF7herag1a2r7CtnK6rmvvraNrPeRh93joPvlYaZdgP3TocQWhGlSuH8WmLtFKSNhEHd
         GucRMOpDfSMB2GeTCjuq0cERqB5uHlbN3Iig3DnwC0f9EiemxnrFFIlPKKl8FPVtZxdU
         ZkkKU7CFzCK5teGnQXLYByiMCMh4IHRWRzBjqLDFnyPDrED92MWm/Qz9vlrgm+wDVOpD
         sckw==
X-Forwarded-Encrypted: i=1; AJvYcCUuuwzV/xisJ3usaHbWpky2x4wRjd9PZZMpcWO8oYWvOcuUepde6CwMtmpTKXQWaqI7Zu2sepTxAOoKYEA/WIFGmxm0jjb9mou3t2KJ
X-Gm-Message-State: AOJu0Yw8ARIRceDbcuHXhOega3vtgI4OtMSQy+45OPF0/W9jQ5Yjz6C0
	lm0vHvZwzOUGQxdSK5KbMezWGOlaHUa3Y5cxS4WWXnYkZsJfzQYaXbhHoKLeJz8=
X-Google-Smtp-Source: AGHT+IHD+XnKjNCAF8dzli3R/mIEHTrgOWVGf53JNuRafUP3Rfz9QB7P9TlGbdcWMqYdzpV1ApOe/w==
X-Received: by 2002:ac8:5fd2:0:b0:44f:ee96:cc80 with SMTP id d75a77b69052e-4518923dd26mr163577601cf.28.1722877585155;
        Mon, 05 Aug 2024 10:06:25 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a75be2dsm30774971cf.61.2024.08.05.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:06:24 -0700 (PDT)
Date: Mon, 5 Aug 2024 13:06:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Takero Funaki <flintglass@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: make the lock critical section obvious in
 shrink_worker()
Message-ID: <20240805170623.GC322282@cmpxchg.org>
References: <20240803053306.2685541-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803053306.2685541-1-yosryahmed@google.com>

On Sat, Aug 03, 2024 at 05:33:06AM +0000, Yosry Ahmed wrote:
> Move the comments and spin_{lock/unlock}() calls around in
> shrink_worker() to make it obvious the lock is protecting the loop
> updating zswap_next_shrink.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

