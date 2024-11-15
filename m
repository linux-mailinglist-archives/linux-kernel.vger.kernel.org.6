Return-Path: <linux-kernel+bounces-410309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA92B9CD9B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C373B231CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E3188CCA;
	Fri, 15 Nov 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSTLnJLx"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F6A32
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654890; cv=none; b=OkwfPcjmtvwEFNTzLQ7rdfPMh7g7DGgO2bDFrQT+ziB4zAS+dtAxZuwr2+utX2XWEwdoZVV2pK5lzLcJjqbyHiDZvKe6Hk1dw9KLH92138dcBtMygvPqA6wRzSrT2RfR1tx0CVJV1jtxWcUIM5Kuj4XecnPNkkIUAwCkDz3/qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654890; c=relaxed/simple;
	bh=dfhNcewPRmScZEpNTrEJ3wGxFnVLC4hzpzKmvqCM+sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+h/99uesYMEKnxtxztIfYabJVjbPd+/4KzR/8J6OvBvJfO9nc1A5n7JEaECCu9nZViiENJy5hI/rmNeZtqFVBgGYz3AXqvAkQc7VM3mxNOQOv5miCnBUrhTc6lTK5Ek3B/mAtISwbUKDFiDr8HX+fpccwNX1uc6BqR2alrtuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSTLnJLx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb518014b9so12735591fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731654887; x=1732259687; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCSZIfVvAxQDL7aS8fPTwPSS4kT4m6f2HO16FJ19sd8=;
        b=ZSTLnJLxLjNJfh+znlyhxeWqiaMVbiG1oucXuXvvT/TOHLNdABHVLxVikSVcdlkIa+
         UzdHjFJEnqKAcFJW5D/cr0Ts0Yu0VJAByuezIVq6+VmU9X6yAnQM0khJpFz6laotVQnH
         SxQQXIVEJLONXbdxhDgTAmy5MIfmu8FWGMK/4pQkLAEhXa9W5tE8xf7G24IsyIF0IeeV
         TLpG3cI7fT6mtfsim6Q3HFyKJk2HpFToAwfX+cpCU2pFlsxMEsh/AqbW1jaTd6BCYEko
         UuYF8flotCOSFHhp7KXLsv33lQo1jcS6Y/T70LEbNxjtopdwfXPhiVXDx8yi+XDiMY8+
         CQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731654887; x=1732259687;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCSZIfVvAxQDL7aS8fPTwPSS4kT4m6f2HO16FJ19sd8=;
        b=TS9i+8gD0fNsRXfvf3JDBQpTbEcdkxDxW82jbUPu01UeqZo++6cFl3CIPAIa0AlWRK
         nV0z/cY6Kjpkyyan/8Y2LfQ6k4cfNaUoP5lZOqiKPFC8yG8vGhttEC5LncnefM6EH830
         rsa6F5yoC0pQK0SD2uH7I5xemZnKQGCPMj2LA65RmMsKf5alF9GL5EIFEHbKpZqbm3pk
         /N7ddZWLxhARwtbkjcBd6Gtgki03egfNRDw1igoSSKmj9x6mUi4qcORVho2w9F+md38h
         KoVnUah844mlhDfJXEn33v1zkSi30u3sY38oCwGXBgoBZuJIf1Nngh10fx4VFpuMuu9P
         gAcw==
X-Gm-Message-State: AOJu0Yw8RKDLEFODfhwg4oVbk8AC8Qu18Xu9yLrohwNpzaqpP3LHnZsN
	Jjdk7AMgxGY9cUfusM1wVPcyfvdTv76iDponWFUgngIzfwB8I6Ak
X-Google-Smtp-Source: AGHT+IEYJTJZ4AkQd5RAXoCoFivbsntQ05lv6Qvna/InPjCupFHDdTCMv2LD0kHb7L/icWDC/cOUkw==
X-Received: by 2002:a05:651c:511:b0:2fb:55f0:2f7b with SMTP id 38308e7fff4ca-2ff609bdf12mr7040201fa.35.1731654886705;
        Thu, 14 Nov 2024 23:14:46 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9e168sm1362002a12.21.2024.11.14.23.14.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2024 23:14:44 -0800 (PST)
Date: Fri, 15 Nov 2024 07:14:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com
Subject: Re: [PATCH 4/5] maple_tree: break on convergence in
 mas_spanning_rebalance()
Message-ID: <20241115071444.o5iwkvwpur2lmcnt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <20241114170524.64391-5-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114170524.64391-5-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Nov 14, 2024 at 12:05:23PM -0500, Sidhartha Kumar wrote:
>This allows support for using the vacant height to calculate the worst
>case number of nodes needed for wr_rebalance operation.
>mas_spanning_rebalance() was seen to perform unnecessary node allocations.
>We can reduce allocations by breaking early during the rebalancing loop
>once we realize that we have ascended to a common ancestor.
>
>Suggested-by: Liam Howlett <liam.howlett@oracle.com>
>Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

I am just about to send a similar patch :-)

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

