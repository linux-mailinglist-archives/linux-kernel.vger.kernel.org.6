Return-Path: <linux-kernel+bounces-206468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A80900A38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8D285662
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14619A2BE;
	Fri,  7 Jun 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjfTCMYS"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61519007A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777483; cv=none; b=YMQEtlwK2R3cyv++n5XwUyFm1ug5lDwyCQzyw39NycircMqCG6APOmbf1+K0hNEBGYMqo+65wg4Q1ebQFd3UKDtsDpidWeqG6WKuKTlqj6gPsxIhOmYLPP/mOoTz5k9CWx95Dv7gihVlztTFXH1k0TXipwxnppn/UVOFtDGLdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777483; c=relaxed/simple;
	bh=yMdxZWELbNf2x/aK6q835sfzLs4Rv0B+kBfNYO1T/3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS72i0NeCTgC94OvEfWiF6NK/UiMdWw+/SvffjfPCdeTyZt9egU9iMMSaNPhQi+S0hpLPdoyfEgseLq9UQ+8gNyNu9yLA/R+QNzMFTztqifm7kpTOCwW0K/OI3xG2cDSq7BeOtjAsEXhZ1+fAvoxEkxnA1lAXJMFik5uizeEB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjfTCMYS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e41550ae5bso453383a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717777481; x=1718382281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mj/r2BLsdZrnHapT+mP9xz2FAngZGg2mWfF3gwLWEBE=;
        b=gjfTCMYSMcpBQeGkCkrJTAGicdlZQGn6ReX2MukJVJ3yGMGH0EafGYMqAU3/jqbjpf
         +N6BpXu9abnRPYX9X1pA/fuaW9MrTsPLgqGN0Ck0+NR9MphQZaRFIfHeB9mkr/aOS5/4
         d4jl112keLYO18q+cKCPDBPnTrj2jS8V8cFkWEUGTVCtYu8mQy9LFzR9Nfg7546G0HOI
         hTIRD58VIy2sM1loWJ3iphSVure7UXlYW4v05UDRCjr9kC+Ilcba7O1ceKmf3FDn4yM3
         m9yt4mJAz1qSDlMOpymzctv5K26UzVbApM1SSfHylOB3cvUzfEO78xTYJgA0bLIE+zDQ
         8uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717777481; x=1718382281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj/r2BLsdZrnHapT+mP9xz2FAngZGg2mWfF3gwLWEBE=;
        b=VE2n+k+ELYsTpJyXNBM34/zs212XgvgW/pHSMFVLqevVFqonDzMARBSX2EnS/xqssX
         WMrJU4XRyXprSm4UEbhBv61nMTHMskxai8U0oCi06U4aMDRULCoVWS2WVVb9xWyHyUiU
         /n/msIEmKY3bSOhQL2E0POPt99nxbjMftXEBukXWlKRHMdrx9UoukRB43uVeJD9uaNBN
         KYnXKG6Sj13nI7j1vlmEo6OhQCLN68rdNoUKeJJP1lMwCtKT2OhqK4YeQDrczfCeQl3b
         tUUtDP4lxyZXTYzR2zrFmlsgt/kamtfsrAwCvkCAvWoHoYz3/Mlc2cjL0jE9tsAozFHs
         iZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTQ4Vqc8yMrrsGVw8+Z9MVrx+2fFth4xdX6fAXmHsvIIIFPfonS0W6xXXlvhG8+H8ujPAj0erFVUzTijhMv0ISry19FmlZF3S5tBiI
X-Gm-Message-State: AOJu0Yxa1Dp6ofU8ZXx+gLR+KQlxO5+1dxS38EMa/uLhS/x3T8M/TzaG
	fsZVHcK5kdmqzO9BQBYRKCRa/n8xjyJXPKslW0FnvOiDyWR8iYSH
X-Google-Smtp-Source: AGHT+IFKYdk0clsArI1eAH6WCggP44bQm5s4NHCWqadeYGsYUron6e8Ycma0k1+A13hpUFsXoTUWAg==
X-Received: by 2002:a17:902:fc50:b0:1f6:828e:8683 with SMTP id d9443c01a7336-1f6d0313772mr32082995ad.41.1717777480835;
        Fri, 07 Jun 2024 09:24:40 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccf33sm36149115ad.125.2024.06.07.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:24:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 7 Jun 2024 06:24:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Audra Mitchell <audra@redhat.com>
Subject: Re: [PATCH 1/2] workqueue: Increase worker desc's length to 32
Message-ID: <ZmM0R2jedisTmAvV@slm.duckdns.org>
References: <20240606085216.3475033-1-haowenchao22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085216.3475033-1-haowenchao22@gmail.com>

On Thu, Jun 06, 2024 at 04:52:15PM +0800, Wenchao Hao wrote:
> Commit 31c89007285d ("workqueue.c: Increase workqueue name length")
> increased WQ_NAME_LEN from 24 to 32, but forget to increase
> WORKER_DESC_LEN, which would cause truncation when setting kworker's
> desc from workqueue_struct's name, process_one_work() for example.
> 
> Fixes: 31c89007285d ("workqueue.c: Increase workqueue name length")
> 
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> CC: Audra Mitchell <audra@redhat.com>

Applied to wq/for-6.10-fixes.

Thanks.

-- 
tejun

