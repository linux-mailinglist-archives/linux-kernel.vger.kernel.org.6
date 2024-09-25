Return-Path: <linux-kernel+bounces-339207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD07986163
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E9E28894B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B51D5AB5;
	Wed, 25 Sep 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="LhG9YHZe"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C251D5AA4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273469; cv=none; b=uezJoKIgn96xuPvgH+FAdL1HpcvrlFbX44LwPuGPODceDivZgPEDGKQhhNmSKMAFiDuqUj/Sb1VJY92tv5Mv3i2stY7hKlNnUGXgkCFwpD71inmlRIt2kLanZ135ugA2bXlc2PXa4H64COFWTVAO3BX+EFtIkZ+D6fjVU1kq1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273469; c=relaxed/simple;
	bh=2NpmFCyvx35doZMsyioIMQv72mu7+QvkHLNt8qHLUDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b48Tf+fdnZXDkjSyglcSQsYwc7TcmvQoK1E6sbuXc+0E+2BjVr1WWpLGACEw/FLdJckild//2i7sCxjNtVvaSNJ/2fdlBaMu/Ga72qQPtei6pOWX5hZcr/DgLB1R1Dd3bVSVfU/nGYpX74in3GNHRH6HRm1f87BRcbA6RFc2x9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=LhG9YHZe; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582face04dso8882821cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727273465; x=1727878265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HqqYimt1QxZeVkOQJVU//HMfOibhD9+jQu/EZc2E3E=;
        b=LhG9YHZebLj4XZDG5umv8BlJ8Rn3xG2ASbHkVH46pqEREEF5JsvKyQLWTtjI4x2GUE
         NhWXOfRD6Yw6eq3d0UJDDtpginQ+FTw5zAffQH6KamB6JFddyNaK3fupCHMJOUdjSkd8
         sjSLcZK8gC4C1YsmafEfjxCkGj+kiJs/l46UO02eK7w9J1kGGf8F15Wvt88p/8qDUUNc
         9Dpkt7NCOzr9+GQNvAh65Os4/iaQatdraRI3rUCkH80u2xjV/n54pe9Hlinxqip94rNT
         9ZEQ7FMNzcrL/bxDP5+rWDGAd+YXsm+LrEgnlgitz7bl3Chtx16l+RJGyUuJGJKlMkKL
         shEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273465; x=1727878265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HqqYimt1QxZeVkOQJVU//HMfOibhD9+jQu/EZc2E3E=;
        b=v5uVuKiJaZ+jw1LvGR09vT27AWGVjrpZhxaC7TXys4L4lLI0qd8LcjNUmM4LEc9S6p
         HkOvd1SBPoRCiuKMHpkKCaGNJ/pTPfblGBr4/f2DbLPx1kOHcZIPq28+ZtF76L28a3WD
         f5zH9z2hRLocwS+e3YtkdjyOnZAf+37MDd27zlW4JsZbb4JvJ+6vDBCGD/ug/Wq1wjA8
         sJ+h4yIqppxvv+x2CzuthW0IpvjJ015ARK7p4UX8bZ3omwSzNnxGEdNP1I0qxlZDbM0i
         /z9NWtQPqwKvCkgE+7pcVqGMa1G9kZvh2X+IkAggpqECtO+nBrovfjop7lEVzTn+2Mo5
         B3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWb6OZw2UldqYLOunCJ4GWevQU7GvUcI4cAcYHk3bc0OJ1JIBY2J9RNBuvsvYtEOBhq2NBCSpYJTmsFqjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+mhxQFoR07KCURguTIWU2DXs8BGiBudYxZ4sW4mhibxP67MJ
	KokwEMNNBPv8ZMmyq0T1eKecnnxkZyGwxp0gILBJAImqgDsTYZtMvrTXCyK00Qw=
X-Google-Smtp-Source: AGHT+IEuFnOI+QoqaIzFOoubbDZyeNUkTSvIM7YU7oUFKsxL5yCIUFokpICLD4x4Uhi8lw04gcfKJQ==
X-Received: by 2002:ac8:6bc9:0:b0:45b:c5fc:502b with SMTP id d75a77b69052e-45bc5fc5271mr22616421cf.17.1727273464788;
        Wed, 25 Sep 2024 07:11:04 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b525953e9sm16585421cf.43.2024.09.25.07.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:11:04 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:11:00 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Message-ID: <20240925141100.GC875661@cmpxchg.org>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
 <CAJD7tkbdRPKxOoVJMg5XdQuoByE1yuOjEENuM=wDnh_cOQZ7mA@mail.gmail.com>
 <SJ0PR11MB5678E588D9640C92E06AB0A8C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbRewK-L07GPzX6YtBnw7zpA1NboBCEyszoT4=-PvpdYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbRewK-L07GPzX6YtBnw7zpA1NboBCEyszoT4=-PvpdYw@mail.gmail.com>

On Tue, Sep 24, 2024 at 05:43:22PM -0700, Yosry Ahmed wrote:
> What I meant is "zswap_tree_delete(struct xarray *tree, pgoff_t
> offset)", and loop and call this  in zswap_store(). This would be
> consistent on looping and calling zswap_store_page().
> 
> But we can keep the helper as-is actually and just rename it to
> zswap_tree_delete() and move the loop inside. No strong preference.

Both helpers seem unnecesary.

zswap_tree_store() is not called in a loop directly. It's called from
zswap_store_page(), which is essentially what zswap_store() is now,
and that was fine with the open-coded insert.

zswap_tree_delete() just hides what's going on. zswap_store() has the
for-loop to store the subpages, so it makes sense it has the for loop
for unwinding on rejection as well. This makes it easier on the reader
to match up attempt and unwind.

Please just drop both.

