Return-Path: <linux-kernel+bounces-285361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C654950C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B472228265F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7771A3BA7;
	Tue, 13 Aug 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8zA0gFS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9F1BF53
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575150; cv=none; b=FB/RqoiEcZssLStuVPMMm7LG2p7iwIPYaqEoFTpL4gSvkGrSTvn9kzN6Qf94z8lk0LKW97UipBQ/k0jHZkVLaNUMBT9wZCMMn4xGrRKymUTA1r41fGT6x4jgj6zTGpTyvkZrIrm8/8Ew32Jbh4BrpHCH2+YKEnH3GaLY3lQ+g4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575150; c=relaxed/simple;
	bh=Ht/4NFAEeyqFk2I64WQxC4gmFPP2gZX2QYc1BYcFG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9muP6gMEib4PSmC5F2t5r+QpJNErxr//kcxKUVsy4Pn05fVmT0sksjeVEomP+RDAD7oqpmRkMVXQ20tfTcXmoRKbVjjdOYsKmKpEjHlYkzZSVHhJ57BfJo9qhwL7ZpAN0T3Qx6Gz+6z0WL9g1FfLiP3c2cFhx3v+NyAkid/2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8zA0gFS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201cd78c6a3so9518565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575148; x=1724179948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xQzhhJbIGKfeDQrho3uQSrEp/8CKApl6FnGtjvV1Gk=;
        b=Z8zA0gFSglF7TCfqU2XoBfRTIW5hxlAy9SY1TEhYF6h2WNr3dlbZzpFcSWzVLx+x+s
         ekOgvQO6siUDxyPG22aSRLh0dO63MLfsMpllZS6tI5pmuug5cQQ/Jh58Nfc6CCng4USK
         9VXmC6oEFdj135kAMhMMiX9TQ5IJMZY1vJOiAMTJSBJYfvORremVG0pebcyGbuJCuGNE
         E6rvF97oOYrZ1fAqzeadt1tSbARs0vlRkTrdDw0iKbcCVQb5jyQYQ6sLrk9SJESujDXt
         SzkSsZmOKMWLDcjWnJJnzOCxUcLtXFTFxrWKjcZDoGPVRt1xY7/cNLThggqhT0C17Rib
         MRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575148; x=1724179948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xQzhhJbIGKfeDQrho3uQSrEp/8CKApl6FnGtjvV1Gk=;
        b=sv8LU84ExkbnR/WDHwvtBej7Zj2MfS2Eh6YPt1pkE63tsszjlEnEbbFRTNfrdS7p/B
         nNcr4ptnxExYSeJI3KTtoVl3MlYzU6oQ59lVsQZZEdGn74wRDIJIZswqn3R8hhM6jx4H
         EwN3XUkE5Wd+T9Ja0xNzewO438F7Ksl/DIYqhU/CU9vVsFxF87ATH8KPXO+FWTQHzmZK
         KtoryuuxyMVh2hPTWWTimWd6O+tHixZhxsgA4VAl31P65kD6sAR4C+eH9CqmtHjFjl64
         +L601nbGNyx9V/lN0SaViqlBx7KvlCFIDGVuHWg7VRPZ+qunlKu7VuFPcpOILG9E23IK
         iWqw==
X-Forwarded-Encrypted: i=1; AJvYcCUGu6XmW+6zWMWy7XUtAwjzrq5JffO9axGRsiGMPEY3E4/tHQ7awtyR/8lplkFmmOFiqT5QR5Xqo92LNnyXebbfwWk38EViGoH2E4pG
X-Gm-Message-State: AOJu0YywlVEkQEGPLwyT6TjYqZYnr1PnPfYgc76OVPXD8zeriyjkM93N
	+W+ZY+io8Te/UAeqVIupb5cktFL+9033RACsVOrKvHQKH7Ij0GXe
X-Google-Smtp-Source: AGHT+IExqAikqPzCWcTNT8iAUkHKEahJn51m0lDKY6dhJd0tvI/DDNDXfZMw0pBnodwAk3R7pX8juA==
X-Received: by 2002:a17:902:c943:b0:1fd:6c5b:afd4 with SMTP id d9443c01a7336-201d64d1d6emr5866675ad.64.1723575147917;
        Tue, 13 Aug 2024 11:52:27 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cfe71sm16718505ad.285.2024.08.13.11.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:52:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 08:52:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	christian.koenig@amd.com, ltuikov89@gmail.com, daniel@ffwll.ch
Subject: Re: [PATCH v3 3/5] workqueue: Add interface for user-defined
 workqueue lockdep map
Message-ID: <ZruraicqNAvPWGJ1@slm.duckdns.org>
References: <20240809222827.3211998-1-matthew.brost@intel.com>
 <20240809222827.3211998-4-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809222827.3211998-4-matthew.brost@intel.com>

On Fri, Aug 09, 2024 at 03:28:25PM -0700, Matthew Brost wrote:
> Add an interface for a user-defined workqueue lockdep map, which is
> helpful when multiple workqueues are created for the same purpose. This
> also helps avoid leaking lockdep maps on each workqueue creation.
> 
> v2:
>  - Add alloc_workqueue_lockdep_map (Tejun)
> v3:
>  - Drop __WQ_USER_OWNED_LOCKDEP (Tejun)
>  - static inline alloc_ordered_workqueue_lockdep_map (Tejun)
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

1-3 look fine to me. Would applying them to wq/for-6.12 and pulling them
from the dri tree work?

Thanks.

-- 
tejun

