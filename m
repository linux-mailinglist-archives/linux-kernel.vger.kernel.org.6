Return-Path: <linux-kernel+bounces-362061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9099B070
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F0E1F22AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3641C6E;
	Sat, 12 Oct 2024 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imjyCaNA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00688139D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703885; cv=none; b=o0iKTDNKGl9v9SRmRjSJHiK1RhLrYoPTIqlQmFNXpA55vnYPQkOvCdeKV/ylmZ9Bpd00fAPYN1YvRd/z5U91fJBglBqWICwi4/UQIlXtvBDO4sXaSWjQy8lRT/R/vKRsBeG/senpNqURxotoaGOP2pp6PFfk7stU43nuehB0QzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703885; c=relaxed/simple;
	bh=VmRsLzwtG2EZpUQJV8TqCwnZQn1czf1t4o8pSzBcuOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY0iM3u41aLrScwPOEpvTfS22TGxyXmw2WvnKJMBUK7H+RECZrpqc4zRwKqHSMBYz+12cyiEk2Ro1KJu9agEZgPedNFHbKD3KV8WvnthC8HeEqxDu/sn2642BB+rIO829RLWCYB5tHQXMAEpCEwI1xeiJo6isjBkMEZI3MZYvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imjyCaNA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a993a6348e0so173489166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728703882; x=1729308682; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnO9v4vTKeXZqPVPayJt3fFn+BABsrVfLqW1dC+xfSs=;
        b=imjyCaNAAjdYjQV0b3O9W0+A+Az1cySB1GHTmtaLdlaHBcR/N+muhEEuAtUaARUn2f
         kyMZ5Vpt3OrMG4xX+JR7zp6RVkVWZNZ2m4zZJ776thSQlNMdvLVRdI7xbm5yGD9Whbi5
         pRtppz+UhffCMonCw3f151VmfIP1P71T0FoWCAa7fYVmhfL96mTPoAAtiw3uu84iC8j6
         h38NdIX5b9nxGEPxVCnN3WpmZMonZXKudGPW61yOxSYTYcfG8Bok5ZnTNBnRD3/EI7vU
         A7Po3zs9cwacrGBtZGg3ltCPdcnL5KuQjfPizTAHFsRwzsNZ8i02j9wSteT2YjrS8qr5
         NlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728703882; x=1729308682;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnO9v4vTKeXZqPVPayJt3fFn+BABsrVfLqW1dC+xfSs=;
        b=Z8gH/i5dZhTnX6Sro9LISBAInXAbO7ezZpjDu+9eEHXDVC+oCWD+PgwdZ6kdzNUBSi
         sDrYOucNTKiE6aSXnoteP+YZr0OhKnP2VqLC3H9kXj+Rt6BfPHDfT29eE4htFzJxofrh
         CKo6sQZtmtqCids9Naq8xQhPHOwTvsb0UiCeoI/7YVwMcHGfd34ejw9QpjuVkTdrjqmC
         LiWciFnAO3LRwasSyFdYjXYiZPODcJ5x7IwXHWuHQxmyNjqfyPucclAh/Ye3WW8qDx9d
         vvs5dYUZu0kXycnqJAaDrTzSCztK8Uwen9IdkYMEhn+q6d2ugwcwSKoJ/00QW34B3hqw
         Da8g==
X-Gm-Message-State: AOJu0Yzw0XkEo/K/C6huoO/Ejtfumnmyl5cblg9otxvRjMRapxDydYy5
	Floh15Tr1XFCvfzeI7CdTTVbCbxVBD2SmuhQrwQ/a6DSt7LuJ+Ly
X-Google-Smtp-Source: AGHT+IFWKCcdncpjIaFs5v+Y86kKPqO+J51NoGA0v1xXk9JslHDM9Qot9xCwQEIiLbnhyYKCowWKGA==
X-Received: by 2002:a05:6402:42c4:b0:5c8:7bbd:1c4f with SMTP id 4fb4d7f45d1cf-5c95ac09972mr1447843a12.7.1728703881964;
        Fri, 11 Oct 2024 20:31:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f292146fsm2682166b.118.2024.10.11.20.31.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2024 20:31:20 -0700 (PDT)
Date: Sat, 12 Oct 2024 03:31:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com, willy@infradead.org,
	richard.weiyang@gmail.com
Subject: Re: [PATCH 1/2] maple_tree: check for MA_STATE_BULK on setting
 wr_rebalance
Message-ID: <20241012033118.33rqa6xlpgxcuidj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 11, 2024 at 05:44:50PM -0400, Sidhartha Kumar wrote:
>It is possible for a bulk operation (MA_STATE_BULK is set) to enter the
>new_end < mt_min_slots[type] case and set wr_rebalance as a store type.
>This is incorrect as bulk stores do not rebalance per write, but rather
>after the all of the writes are done through the mas_bulk_rebalance()
>path. Therefore, add a check to make sure MA_STATE_BULK is not set
>before we return wr_rebalance as the store type.
>
>Also add a test to make sure wr_rebalance is never the store type when
>doing bulk operations via mas_expected_entries()
>
>Fixes: 5d659bbb52a2 ("maple_tree: introduce mas_wr_store_type()")
>Suggested-by: Liam Howlett <liam.howlett@oracle.com>
>Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

