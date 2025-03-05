Return-Path: <linux-kernel+bounces-547399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8EA50695
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897EF172914
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65072517AE;
	Wed,  5 Mar 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1pOhGyr"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69D1C8619
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196403; cv=none; b=mIcuTA47xVLNRRhq34FCs+Hx7+bS+5fD8Ag/7yziIyrmTHbRKuaMEf+/44i16hfe5HrTtSnNdTVYIHP9SLkiGL5XnTx0Owl7iKsqxtlenGTMyY2M78m9jOTjydhxX0VCYFsmYqFd+xKoOgPkqRNSnNxinOInO15ycsaw/vqMtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196403; c=relaxed/simple;
	bh=DDkd0ENTRtnGrvogXd7zw2xzDQ5Lt3hcj+xwfcWbmIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIFfICkNKSPvut1bN3jT0Uz7s6tYtX7FVqOwiVK0u7YGayJ0qILX2vxuHIO+zFcO2HFpUEwCF0Vtu8JMWjfkGnOWGzbwBCxXZRbXkIaiPn7r2Uqhph8LyjJyzjEgOJNNBxPB71R+EYp9ZLvLjrKjqr1mcwglNniUBvAfHLKlhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1pOhGyr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4750c3b0097so10477651cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196400; x=1741801200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDkd0ENTRtnGrvogXd7zw2xzDQ5Lt3hcj+xwfcWbmIY=;
        b=j1pOhGyroCs/gZjTxVHCafoxEAAV6giQfJzvRnhUKFLpX+H4srDVUr/MoJFQ/9/Z2i
         oqpHdYB7KZ1O5a8e/ZwU84fll724tdTdYj6mSJAvUdyNcOP6J1Wvou63KgRhTUTEIId5
         DHN+Rb25WFgpmLRL2bE9bznel60df7hTFo36u5/y81gAZ7RsuaE6l/f3+rNB/veq94jq
         gUcm5RnHmV3O2tPqrjBzdAiQ3QKgsMtsobYERHXTbRDt11FRrnpP5fVEBK/2cygxCAgL
         MQGB3e9G4i4nzOE8ml09bbDR5uXXM7bHd0IeJnqXhdIpLP++UIMXheH++qg4hun9gp42
         RuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196400; x=1741801200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDkd0ENTRtnGrvogXd7zw2xzDQ5Lt3hcj+xwfcWbmIY=;
        b=rSswMkFrsAR9J1HywZKW92USiU8OhcpCFrmDCM9ZWM+s3UiTcn70D/9sXix6QqhPqZ
         Hgll6fZNdV1QX4PvkUrG521X1NisD3ojDhDHnjH32HZsktY1kvnyLIVVaCLBeOYvqvAn
         AUC0Bv47xvugHJwDMhdHw8YcQncndB5uGDCnIs1jAsDELQ8z5gMP2nNapRTz13J6KN86
         8qHikcC0JaCQ5eTUz2YUEFR7BPgnxlCwHkDQx7JM1c8DmZEqwPAWqklU97dWLU7KhS93
         MKux3CYTiDv3j87wJvK3PfIk0NQtxAASIBkQumh1YmJIawbfl7aiBz8Le+ggsFMonLgI
         BdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3GPTArpKq3ZbCOgOEj/ccYlJ342D7TAATaBKkLwukH+AN3xS+HAAxVToRUzuKznN3hTm93DJ9lMlqnhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6iLPUdklElF8vpJNxVmawiiislQZqcm6OTEQd+0tvNM5Jl9zA
	bZUjkLcQ4JhBfhGcxQSMG4mSiAvqFpJ+RUcUpnWdu/LSYmoQWNMTWjS0RjUkMQ4U3BCuDLF7uYz
	+c8rPsFqLhyAmJ1rrea4lUZFrsuo=
X-Gm-Gg: ASbGnct1nI+HQeX5Sf79bOIGyTpbN559xCOIe31UTpXClzp3eiH4nxhrwyXt28IHbn/
	GrqZ2qfnozVIcIxrkmLhQ3zwIIpyCegCfrkHJvgc2dnHZ/Okp5PFsnBomRaxUjIDG9Qjb5y8t+m
	XMJyneeRgG2SwY7/9OczmVknXDyIgASaa1NgN6BIf3EYLFUDzSsZDkzmmphA==
X-Google-Smtp-Source: AGHT+IFdczF+SuHcgUbPjZ3iL/L3BtrG2CX8mWdWbgRMAhfY/GMXA3xJdTkvrzkrNhfGN6IP6d2mHvGjY8FjLhgqgJE=
X-Received: by 2002:a05:6214:e87:b0:6d8:ada3:26c9 with SMTP id
 6a1803df08f44-6e8e6ccf943mr65546946d6.10.1741196400254; Wed, 05 Mar 2025
 09:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev> <20250305061134.4105762-5-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-5-yosry.ahmed@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 5 Mar 2025 09:39:48 -0800
X-Gm-Features: AQ5f1Jrf1mS0LPoGxgvi9bINVgyxAldJGmM-64FOFL4-N34NmSapCOhvv5XPqCc
Message-ID: <CAKEwX=PjkuMbjtPpQDMPhr3YHQUW0sZL6miBmAGsipTXFp83Gg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 4/5] mm: zsmalloc: Remove object mapping APIs
 and per-CPU map areas
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:12=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> zs_map_object() and zs_unmap_object() are no longer used, remove them.
> Since these are the only users of per-CPU mapping_areas, remove them and
> the associated CPU hotplug callbacks too.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Nhat Pham <nphamcs@gmail.com>

