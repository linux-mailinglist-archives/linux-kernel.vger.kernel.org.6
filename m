Return-Path: <linux-kernel+bounces-252870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A2931926
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F301F2205A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536A47A6A;
	Mon, 15 Jul 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePWEFTQx"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C62446AF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064179; cv=none; b=r17+YZlZFSFUR2htmY8DiNMWaoHYAAGPsIxngXcwND6UyqgVfN/3TJV9hdKJ+r4miA5Kvxo+rWZi9xTftYNyD66O9Sq7Gv4wpJWTxVEaNdoB7EKKm877sT34UJu0wXac+m1lNpG+TvpglUVTH5zGf/nYwH2xFlttjaqHhrf+kFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064179; c=relaxed/simple;
	bh=zZksEh1vYqLGn6g7NkPYHrk8Y02M9cK3JqB8R4g3zmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G809kwv0LAr+H3T8I8gKGfTrRHGKGIywOef4oytI0J8p7pa5PHeV7LuC9KyFcD2UVnn9TuBBhVCFDjLAkTObjaftLnhvh90bJkE5TZ1X7DPEod6/cF4CgX5ka5RiL5W21G1JrP05pjM/aauGmx+JQ6KxTqnxKrj6no6o+IrdG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePWEFTQx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7662181d487so2306421a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721064177; x=1721668977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbbLw2U3GAWIN7gKkKYFKE0dl76aBMmJ1Hvw1SafxkE=;
        b=ePWEFTQxTSe8RXgDVxy0CvgsHWX6er7Vg0jb7w+toODradn00jAIerNGAtoX2Kx1BP
         E1/NbnPJowFGc3cR323ciJGNvDV9fxlHJVVTYQItcyWZSB4PtB+6KGJrQWN6a4rTv5R4
         a7igQqvIoW5ZAdF4pgiW8UNurpQ+VC6xGKeEbfk7xeE8yHj8zKVDIRfWokxHR04XjuGB
         OKzx6JdIOXiUYV6+PjYwBsbcm2bNJrtDkIij3LfNoZMGWrQui06SLKXHqWv5vxg5EBfK
         UmwNtt11SGZxXEgZjHun7/PtfpwsqbeA43zClbMjxXFNrcjSDwIecAL6w0y0/uhmy8ge
         hSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064177; x=1721668977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbbLw2U3GAWIN7gKkKYFKE0dl76aBMmJ1Hvw1SafxkE=;
        b=WX/ni99dnQviIAttX1ZY9C3NoM2EO+MZtRjMSyT38UqEl9/4z9NWQbMnp+VQV5Y2we
         ylIh8GIM/8FTdsmX/+eUvWmEptomP4T2/HL2r0hzvrXQsHUkr3Q1xTXqPtXJxeiaCJE5
         dD+Wo3y8/WVMWaXWvT2Uc5Umcca/MWS8fKdHg4TsJRBptlJS3Ka2HUfA3kWJzYy3UsJD
         9RkjtYbRxk/Go1T6qeoEnShtsWYU8LcXiJ6MOL15HnGZXz3MdCkIh2J9ISd9mLOhFyAI
         WYr27W0wbtu/EQ8s4/sArh1JhxS/cenSsG5zx+uBZFv37/k5QQ7Qt1Rc8jfoK9XXtsML
         bCJA==
X-Forwarded-Encrypted: i=1; AJvYcCVMlrog0T+DEzg02nGC4CAno4yzbpSTnnnKn183U1E89FSIlZxDbYXUsejNaAUmcaTeIF4vNuMBCoOr+a7F+JtVCWOvEmNqJKPkIfdr
X-Gm-Message-State: AOJu0Yy6sWH3g2fHIjPLqC5v+Gzi1FIUnfgZy9oOuASt3+NfKCRBmpeK
	K7NKQ29aJJsPcdK/dM8PqBy7EjLauG4RP0sCr0oARQ1e48R8p2V/
X-Google-Smtp-Source: AGHT+IGcMlsjL7q6eYjhEapU2Lq6U4fK+vi0bFOeIIEEu/1my0A8UaIrf0o6+AcH7YJB/oOhrPbVsQ==
X-Received: by 2002:a05:6a20:3945:b0:1c3:3436:a225 with SMTP id adf61e73a8af0-1c3ee9336eamr532541637.21.1721064176829;
        Mon, 15 Jul 2024 10:22:56 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebd1fefsm4769558b3a.95.2024.07.15.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:22:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 07:22:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH UPDATED 3/7] workqueue: Remove cpus_read_lock() from
 apply_wqattrs_lock()
Message-ID: <ZpVa7z7CFJHK_ybY@slm.duckdns.org>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
 <20240711083547.3981-4-jiangshanlai@gmail.com>
 <ZpASNBN0hpTVcjE-@slm.duckdns.org>
 <xesrnvzs4xahy4473mp5vzxemjdtrci457x76si6gqbte3xx7k@ubfomqay7tck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xesrnvzs4xahy4473mp5vzxemjdtrci457x76si6gqbte3xx7k@ubfomqay7tck>

Hello, Daniel.

On Mon, Jul 15, 2024 at 11:13:56AM -0400, Daniel Jordan wrote:
...
> pcrypt/padata doesn't need to hold cpus_read_lock during
> alloc_workqueue.
> 
> I didn't look closely at the workqueue changes that avoid this issue,
> but I can remove the restriction in padata if it helps to reduce
> complexity in workqueue.
> 
> I saw the recent wq pull though, so if it's fine as is, that's ok too.

I think it'd be better if workqueue can put as little restrictions as
possible to its users. alloc_workqueue() is a bit of a boundary case, I
think, but if workqueue can avoid it, I think it's better that way, so no
need to change it from pcrypt/padata.

Thanks.

-- 
tejun

