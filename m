Return-Path: <linux-kernel+bounces-549103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF19A54D57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A8F3A4B95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D501487DD;
	Thu,  6 Mar 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NJyQRxIi"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC03CA52
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270551; cv=none; b=b0o7ua9YoVCftbBsn4ksLw4C3l2KE5yeDV8a3a7iUzyoUCsQIC2eRrHrWqChGt/2xjD+dRomvXAKDM8bCYM3oqeH7lyePj0LJhi30sm2hJIyEBLcdBHTwWBt+ci61/VNmDU5PqaW20W7Z+Dl7WiqjZ2QQw4kWF7vXEJ4ztY/2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270551; c=relaxed/simple;
	bh=x+GJRsfUDsD4C7Ln5R3MU3dJ1MX9aqJGshcxu+iDAy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg5v4YcNpgj1a687uHHThTVnKsfx0m9Ejoe4IjCaeVUpuWu0Cx9AdPFkureMDuDkssvkeGj7Jgb0K4HvHUDPB0ZG+WdKUNC77Sc345307E/fPqUF3aw1wcEmwDV+FV96VNJS3COWCx9DlGvFOchZGpCyfD9nS60Zrdnywy3UdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NJyQRxIi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3b533a683so71894785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741270547; x=1741875347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoufJmQv2HUe7ypcDnbmXL6HESrvjZS9wAJynnsLf5s=;
        b=NJyQRxIizTw65U/7XeUzMLTP3uZp04gJ6/gV6Eqt0kUrAh81rZEUHFl6K48nxo6xmB
         t3nipq60AqvYSJd6Z1K0vkIqOk1ZSesl8jafdtMOUXVcnlWa/UO5BuAxX1UtIGnG8XoD
         o8Ag/Y/mQEV5gSfa1AbgwQ0OwJY0GALHxOFt2VoHsEblUXXNPzrlTrLttVk7ZKVnqWdv
         rn/tEU1jVnRHQvgiC3XmuZqssdVg+mL62GXPI/g/xjp6KWFrjMP+iEsvdBZEHBFEzyyw
         s93r8ro87TVdPj/yRb3uocyKSvNGp+oMaF9o/clLUXcLL4Yfl48sK09SHljnKiurWht0
         qbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270547; x=1741875347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoufJmQv2HUe7ypcDnbmXL6HESrvjZS9wAJynnsLf5s=;
        b=LR0QGm2GSEuG1Q0DIZUWJ5o3YrkYnbzbEwFjimOlL7V3CwXNYYa8mXZAqUDW7k0s01
         qnunL0iZobTb+efWQJaUQlb54OV8Q9emppu2mxFAE5KoMTBMssdBf+z9SyG0HiTrVX8/
         6Cvu9G19CJBvYtt2RExe8FbTEtWnlFuLuvR9nP2334ZhYcVZF6/lhIjwmSfbiTX2FTZp
         kEJTRvOzJJ0m2rVkDgOaT9wagCbra5ZGDMIPPVCnbaEvUQ11RnHpBAih3lxxUkQIGIDs
         nhjkuMMBW07awWEpcevMlVKn8kdz8ga+Q6bOw1zU+BT5c4i4ZykvbG0hWjqDv9dZlMJU
         mzyA==
X-Forwarded-Encrypted: i=1; AJvYcCVVykxqv2T3UqQAgty+xL2yF17rY9BCa0r/WokVSXESSGgfP9usxaGcWNRA5sJM6ZOoiORBUOIxVEvoYnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8NSZm39gaqoB5UrxANeghgpsj4lFBquwfeG4wJuRCp71R5Mw
	is0YvPYB+j2pm8ehZbzGChMpUIUw7JruDbECy/peTSAhKSrP1mI0C3QQZaM4AJi1fMv+dfITOqw
	O
X-Gm-Gg: ASbGncvYcRTmi/Oogxz4PkR02L2wtW4UJU8A1iqjYdwtGTUv9Y1CIeQ1qlA8+RvM79H
	rmIXeCh8faOd5yNIJOVDSS/9G+RyyAqL8elsrM8U/mvaD4lVqp8ehUMx75nx+go5jOpQ8fS9riG
	m+xmhd12TvPS8Z+lBmdL4syBjt8JrtViDTyjakfNHEII0W4+ZtxO8JMYH4jzeDLujFVttRxHi9f
	nD45aufLhAcRyeUGPnbee0aNyT3NF0DjV1un3NRIHZDPSZ6rLA+BiJICPOakskRCwJm6+uNtCsq
	oSAtGdWrTXnxMWLXmMr9L+OWH8jTNKIW4w/UJeGQAv4=
X-Google-Smtp-Source: AGHT+IGLLqA/C3nLhBQL9c5UnVf95JSrbTd/4mXb2ecn7OXpm83PV2SxcCjvf9Lsz+yoptISEXGN8w==
X-Received: by 2002:a05:620a:2b96:b0:7c3:d778:6bd with SMTP id af79cd13be357-7c3d8e6faa3mr1137170485a.47.1741270546797;
        Thu, 06 Mar 2025 06:15:46 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e5511047sm94316885a.100.2025.03.06.06.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:15:45 -0800 (PST)
Date: Thu, 6 Mar 2025 09:15:44 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <20250306141544.GA290530@cmpxchg.org>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
 <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>

On Thu, Mar 06, 2025 at 09:48:58AM +0800, Herbert Xu wrote:
> On Wed, Mar 05, 2025 at 06:11:31AM +0000, Yosry Ahmed wrote:
> > zpool_map_handle(), zpool_unmap_handle(), and zpool_can_sleep_mapped()
> > are no longer used. Remove them with the underlying driver callbacks.
> > 
> > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > ---
> >  include/linux/zpool.h | 30 ---------------------
> >  mm/zpool.c            | 61 -------------------------------------------
> >  mm/zsmalloc.c         | 27 -------------------
> >  3 files changed, 118 deletions(-)
> 
> This patch breaks zbud and z3fold because they haven't been converted
> to the new interface.

They're both scheduled for removal and already gone in the mm tree.

