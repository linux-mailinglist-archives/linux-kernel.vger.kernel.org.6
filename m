Return-Path: <linux-kernel+bounces-285383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB1950CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBE1C22794
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6511A3BD2;
	Tue, 13 Aug 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdHGv0A2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83621097B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575989; cv=none; b=b5Wcw1RpcrsR7Ra6S4Sm/3N4h8MBUBAFVI7qp9KJJFibxYe03XoCY6NqI6AY0TADipXhD6bXe0q4/Jgh0WHH4qsfbefwy0PzPRylLXagFI2Moa1ad97AgoMpsaX3GvkpX8XE/FUlgOCo31uNHZD8aASIh+Ba02/nz0Xz7g0TJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575989; c=relaxed/simple;
	bh=oXy7QrudLATJbEBlpz+lHeRMeS2mbqW8YmIB1Awr3d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEvbryQv4cbnLItOlcZ/AQ9M1LS/YiJQF+ipAbnK5732nt1mfhg5PZeBFeHwBAcdeXbQccEZksz4e2SJ90lPZ6UxxTI1NFSZgY7FwTOWrf/UAAWL0ZJ5aD9oegXIDRJed9loc8bOkea7fXvNjd3rh9VQMEA4hSgOG+UTrRt08zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdHGv0A2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so4246271b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575987; x=1724180787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q915GEeCcSuSt6ziTlUhp6/SFWCWlOkiSyA5qmWeTt8=;
        b=fdHGv0A2EYaHisIb+KxlQFOJYzrxBLJpAL8RN1/1seVMup8X7jubXCM+AbIu4jWtCL
         P9toi6NxeWiSzoKOKUfHlyL3Wn/Jdq2ljscAnY7NiyOPZcZtPBUyB4iGI35gpAuzN4w0
         PKmJgnhiJ/JvpfDd8ShijFEy8g8bIX/mxsb2B+wHuA/wGIJiuZuHbhCqwsRo6NLUJnEQ
         YZT7K3mxmep2owyjhlldh0yVtJsrdbmHRkzMtQoOxSEe0GN42WO1q46bndA41np0Kb6+
         R2ySTElZ5izITBq+0ry0HINnZehiB4BSzz15y80/01Y03ek12oft9C7m8ixkW3O8TzNA
         Ah1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575987; x=1724180787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q915GEeCcSuSt6ziTlUhp6/SFWCWlOkiSyA5qmWeTt8=;
        b=m9L2YKORCr67mNk33nCksJRhQhem/yjbPpweuKekNEV9ZCq5etwjdsJk6E+yJA8o4h
         E1aMIEAwQ40Zf0eje/G302+dvobqJWiKkWx1pd5w3WFO9IO/Hn6CmPF+mbpv7jFUJcYG
         DKNsdTUO/oAeix51539jJRHyxyXYMhbGadLaan51PrchaqrMjQiYwVSmwbDsZ9sTXozf
         Bjg3cpDPUjFM/cciFIF0JYsWM5IO3nTU37W0cHg40IBRVUJ3EhVQnkX28eah756K8XzN
         FbL7dCkO65RiFmx5W7OtrBcy7FLyPA1u2c8HKGjdDXus0NFDf+R0ZBJcc5vDRC+xWy2i
         R3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGTH1KHA3uYYn6xH8nf3NsT4R89mRSFEuH7JSLffIoFwzD0cKUKZrRpfRzxSbYsHNlLJuqdQYAY8WUykFuAywxFhO3vSCEk5nT0+1A
X-Gm-Message-State: AOJu0YwkuJkzMemzezPXIUVRu78g0y5zweGE8e7EKb7C90T1JhqrewNY
	xKon2QTHcvfsQKEHKC8jZQrR/CNKYlcW0UJxOZD0LH8mBFqWWpJ6
X-Google-Smtp-Source: AGHT+IFhYITFfi4gSb2h4Ht43ZMadC3xuRgU7/gYCRCkeLcissOAUoS91bw8bOC+oVQNaMObfrjjmA==
X-Received: by 2002:a05:6a20:c88a:b0:1c6:ac08:8dd2 with SMTP id adf61e73a8af0-1c8eae81393mr820403637.15.1723575987169;
        Tue, 13 Aug 2024 12:06:27 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cfd6dsm16760925ad.289.2024.08.13.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:06:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:06:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	christian.koenig@amd.com, ltuikov89@gmail.com, daniel@ffwll.ch
Subject: Re: [PATCH v3 3/5] workqueue: Add interface for user-defined
 workqueue lockdep map
Message-ID: <ZruusVfdGISuRggn@slm.duckdns.org>
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

Applied 1-3 to wq/for-6.12.

Thanks.

-- 
tejun

