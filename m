Return-Path: <linux-kernel+bounces-278244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0D094ADE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB221C2134B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C20139580;
	Wed,  7 Aug 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbkfNHah"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8882877;
	Wed,  7 Aug 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047410; cv=none; b=W+FMyfl/o9AdDYGZc8cJuAggITHRmH+w0WJdW3Jo9gXxlhQjUHxARNwQiiw40ZxmSuE21KCCCNtIlggP++fzjGxHx3hw6edFr2W/ixJb01q7ygpC5Cs1BtJVKBPd1YV++Jl7V4CYnNWki2guPveuRa0GsgcuzL/8lmaAYv5WFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047410; c=relaxed/simple;
	bh=UptmENx6TJV+uGONRp2iVcbWnaYM95O1Di3YA6293ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp8nuWeN5DkcdgoqEvG0pprQOfWec7NQu1uiQ/YSB+XQlvrzg7shk5ohPVY60qfV2C1IfIIkNzKxHAaJJwQTC+n0AzS7UvA807rkabq6qII4J3nxPNzZ1JTNKyrS10V7WmVixWUB8Fia3VV6KJr60g/o/jR2sZ+s7DXl73Ur+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbkfNHah; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso45546b3a.1;
        Wed, 07 Aug 2024 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723047408; x=1723652208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjsfNYgH0GikFN6Lo2nyrKruXgjk5LFi+vPsS/sC+Pg=;
        b=cbkfNHahE3NKWuWTS7+2Yo9n++V2DCYZtDMFMqJ8tkljNEaCQ6/k8skKrd5oAd8sR1
         kOAOsMg2nVFx48VDO8bpz8BIntxAD7u2xMZ+l+Ia4uVnBzXbdPEr0M0GWMFPAMtRZ+o5
         xH9Co7kWasT6YN4kMaUQrsuzGkqVnrcKxw+OM573HlMAY4fRGDTTux7oWnFkhRa+yrcK
         uFRPPX3i71eNU7QDMdK33eMVvX++1mZu/LXK97XXQt6g8SzwCEG18UUzQnUQVzmrLYCO
         e1nzWtEkJq9b2EoWxy7Y0fPKNjjiFpxbDUdKdvk8XylMOqC33/LOE2GV9TCmEUywh4n3
         NX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047408; x=1723652208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjsfNYgH0GikFN6Lo2nyrKruXgjk5LFi+vPsS/sC+Pg=;
        b=V6G2ssWJNLZJmtgrbY/3FBed3Gg37Y2EWQqBDXSdBjOKLcU+bVPuk2xr0jl+zIuWt1
         iQwmE6jNPcbxkbLVncnkEWmdyPAikkqE8nNGjGQZSD1hrQ0sQfJYurEWNSPo9IXpytgr
         LPmNn7fYQFmyzTgYb4cUzNJm8gQYev+3Rly7+E6376VoCOoejVyZIlmifGvCho2PMs4j
         fwPXS6omGfRfQbFJZvSNK0sLG7g1zYEKn5HZSAc1lNBxwUyhATeP4oTjeYWrR+geemqc
         YHi78v/zUJjhxqd52bFfIjXSuGiQXqmMxcxJyVwhnF4aec6vM54Flr1Qyz5BZWgUgdcL
         MeOA==
X-Forwarded-Encrypted: i=1; AJvYcCVUpRdb/32ixauFaSz6m0RTvN+O3LXIep7M72Ut8pGa2YZtmS6m2mJwOiPZhMTDH2xyH/nfmt1ZodgCRx6A8bLpRafdGX/GZSR9LN21eK/COWXmRCy39cTd7hMmCdvh7lTC1oOC2L6V
X-Gm-Message-State: AOJu0YwgBJvxy2UDdgKu942CwF3dPy7Y6zPAUXhiKneMRqdw+qTYBia6
	u7VjShak4u3kaIVNNkpIdP0j0V0A2CMg+4/uLC8xlex/f+H4JXXh
X-Google-Smtp-Source: AGHT+IHCWTXXGmjruJAWXKpRpr+dtOlyI7NMlSBscrx8uwQHRc9gGrJtCN2u6obxZDC52qP+/zOZwg==
X-Received: by 2002:a05:6a20:1e43:b0:1c6:ac1c:630d with SMTP id adf61e73a8af0-1c6ac1c63f1mr11643320637.1.1723047408461;
        Wed, 07 Aug 2024 09:16:48 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654bf910sm8505321a12.79.2024.08.07.09.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 09:16:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Aug 2024 06:16:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Sangmoon Kim <sangmoon.kim@samsung.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jordan.lim@samsung.com,
	myoungjae.kim@samsung.com, youngjae24.lim@samsung.com
Subject: Re: [PATCH] Documentation: kernel-parameters: add
 workqueue.panic_on_stall
Message-ID: <ZrOd7ipYqshfjnvF@slm.duckdns.org>
References: <CGME20240807105515epcas1p1e3d0893f404f5b294ce5628a4188293f@epcas1p1.samsung.com>
 <20240807105500.3958276-1-sangmoon.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807105500.3958276-1-sangmoon.kim@samsung.com>

On Wed, Aug 07, 2024 at 07:55:00PM +0900, Sangmoon Kim wrote:
> The workqueue.panic_on_stall kernel parameter was added in commit
> 073107b39e55 ("workqueue: add cmdline parameter workqueue.panic_on_stall")
> but not listed in the kernel-parameters doc. Add it there.
> 
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>

Applied to wq/for-6.12.

Thanks.

-- 
tejun

