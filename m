Return-Path: <linux-kernel+bounces-385086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCFD9B323A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17EA282778
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4E1DBB36;
	Mon, 28 Oct 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="dk9vHumB"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760C1D86DC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123635; cv=none; b=pJwORMvhELXYIaY2bEc/+Re8qA+KSSB05ez8HOBMmvyvECzRodtGJ3qBOPm45EgzEyJAWXkDCUmcwLltw1XeM9lj1EeBAHnVUAtaxy1Jgj80jH04Qfm9CMCqILA4bVw0njaZuDNxDZdzFBsCIuEf+Te/tFTqnoLqmgWQ3g04UGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123635; c=relaxed/simple;
	bh=L5IFAGdxLKk4RP5WLTAZCi65fPYxfWuR27gxz1ekNPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyJgiHdLehZLgpMB8sdAbZNL10hIPQFj8G+loWeGJhS/P+Xz8U7QHKpFyfwuEUdDInQnPGvPnB3VVAnMKUr2nNGUsCeHJFA0lz7Z/yC0d9dMa1S38S4XDjBjw/a3p3YJtEBjRCgeyo2y82fIPk16R8nkkLxWDvxZLy8nyFrokSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=dk9vHumB; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b152a23e9aso338026785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730123631; x=1730728431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UrmsujUgQJ5BlGaZvf5rEXiek96RGTOcx92GlV6YM4Q=;
        b=dk9vHumBp4Ou8nakV4bmZm2GVSphMZEAsG/abqDET5MBRnNg4LnVTWtih80bMJwMOz
         Ir59+SLDTczbS3cwJyjQXlq5NNq8DNSeDsDE9bGSaVVHD4EhBWMJFucJW8ZAJn47OW5Q
         vHQNyNCn4xLPCHIkX7hAxvY6T4UDIC+u7JWKhdhn8WW6lFANLoAQdIAuNGYd51BGHgCZ
         d+ewLqcIiGb9ctsMvs4WAygBLbaReRR34AP5qIyeg7m6xn9JvFtGOng9KexL/gOyehdz
         G6qnvFcsjIRh/QiiC/74WvWHnWKoi1t9EigKkh6WYTFp2NxfEq2v510F25ne8igPXDAW
         d3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123631; x=1730728431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrmsujUgQJ5BlGaZvf5rEXiek96RGTOcx92GlV6YM4Q=;
        b=Gm+xG0a5M6ASFK6XBYDgD/WcEwuDbEI64rG7wzyUULD5zHNpF0Mo4K2K1mkYwVHOqr
         TSyawTChv08Y8Me9inEvoH5/hs91Ac3/yFC7VaFigTOjxw+FPO9mfp+vqUIQeu6oVV+A
         pc3Drz/uF26A1jekvSsmJODPv3NzjMrUDyA1QO8la/x8thHC8+GS3uJUy1XBwK9nnzQ7
         zY3ubPWvgdw46UkxuWYxGFXMLIX6GSI1t1PWhnDUOWLCT15zQdQP81FtUfMjmpbUXj/F
         gPf0fJEAikR/5q0Kjss/FsGe/pAqlNIgCgqnvTDZzy/yJixhZ+AEFOE2zsildGzWIdqj
         q5IA==
X-Forwarded-Encrypted: i=1; AJvYcCUjedRvpM4yCo6I1PCwd+ZHMTfGvqvOzdvj7UFwDquaE/Qc3gOZpW6m3sdXV8zqT9iYt94QBewOpEIhGUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUf/ZasQU3oAgXioCcL3KD4+f1m1bu7qjt/NiT+EUsUNEnEIb
	ZdUX2poFiY47/jsp3M0ZoB0/GPhMzGh9K4CyeYndz7YHZaaERY4QnKJ9/2FvReY=
X-Google-Smtp-Source: AGHT+IH40KuDHrVOWhkEyQxVYIBNRcqoqm2Gc7OFJ7y7QxKdJ+GlPWy+DCSBDUatY4TQu0/pwXFjgQ==
X-Received: by 2002:a05:620a:1709:b0:7a9:783e:3fb1 with SMTP id af79cd13be357-7b193efb057mr1458081785a.23.1730123630974;
        Mon, 28 Oct 2024 06:53:50 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d2930ddsm319958485a.42.2024.10.28.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:53:49 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:53:45 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 1/6] memcg-v1: fully deprecate move_charge_at_immigrate
Message-ID: <20241028135345.GA10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-2-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:22:58PM -0700, Shakeel Butt wrote:
> Proceed with the complete deprecation of memcg v1's charge moving
> feature. The deprecation warning has been in the kernel for almost two
> years and has been ported to all stable kernel since. Now is the time to
> fully deprecate this feature.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

