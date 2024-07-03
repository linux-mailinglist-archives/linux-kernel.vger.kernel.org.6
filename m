Return-Path: <linux-kernel+bounces-240014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A129267E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47D11C254CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B018732E;
	Wed,  3 Jul 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAEdPDRQ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD41836DA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030414; cv=none; b=pYsRBwkx0tHW0anQegRLlE+1Ka8wnK63EsZ/gC4GiG8xTe1P6gOxIqLQbtg880+WQyKycAlzzU1U5VjABcFgro1ues6FS2Ljc6+9RU6y4oSPhEKbEkw0apHHoQAdmmeQHatqtXOjMqxOXL1pgX54bNpjMYc4LNwu7ETgzflAMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030414; c=relaxed/simple;
	bh=ac7Mgd4zakctEcwMbiHKkKAj0fTVqWPcMawTfYpxsNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDZuWdlc0567irCUfpL869GTcY3qM4cT1g4j5h7z4dl0lxbr5A95N/ncEx6tFkkZEQsxu+o0cQjiMnJe41zT7wlePWFZotd1ErMG3xNvEYOp8XPUEza2yN6aT5qrCjEz7jgxwOzyjwCcYXR0hvBpN0DmOJrxq5G5DxF/bBtD/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAEdPDRQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-707040e3018so4139965a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720030413; x=1720635213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dilV25TDKD6iLmK2b8NW8VyemEFy7d8HLqg8pW58g80=;
        b=AAEdPDRQn4zZgJyMOO5BeOvh3QCDbXo4ojRMpwk7y/E06KlPCCYDUmNkyggULG8Pce
         WLShcV+kbMaTB1TuSFybeRLhPhPxpoz85IUHoyF1U64QH6fp1VNPtp7PtfPDKgPj2hlL
         rXRdx5I9XAnhusQntvECNKZgyc0obUd6wkDXvCBGhHVV+g3DjYpr+9HdAyaaR5TUNU1p
         fMTfu1vOswRl4v3t/hJ6JqA9mvgyFpsEm3TO4gKNE9xBB+FtUwSe8R9p3ta5jnnBl2b0
         5dixb9WDWepshwj+SP88sTGn6EMA84mZ+xA82Tdb3GAhXBu8meDGJAuVQwioqFyOpSRI
         t4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030413; x=1720635213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dilV25TDKD6iLmK2b8NW8VyemEFy7d8HLqg8pW58g80=;
        b=UVujk18+qNvVyJ4Rzb9efMTaprnYD1i3ye8gFClafzWaccxda4zQWkfQ18Z3xAc515
         O23Pid1tHsJ8h2h4zZBoMyMrlm7YwCByNWQiN4wH9D9Qn2q8FXkx1H5TsCfhgP9P/6zm
         /q40VdDymO20h/fgBqBN6kFDB+e8FG0kZiyU3kbbkEVfmxf5CMkKg/Djhn+S74NsH18n
         1wll5bqJBP98NosdvasfD3fv25O6w9Xi7Ess61EbR7wZDocNEWueyJ7UvpnIDlx2n7eS
         k6I9jg968ukAdKZ8snfFh2/1E8H7v8sifLqi0tLe/La2nahguhPGL3Yy/pIFNDchY5q5
         BYlw==
X-Gm-Message-State: AOJu0YxPuDHQ/zlxw7bvIY3I+Qb1hnVnzIS184h3+MI7izy79aP5w9t3
	uHWeNqgWyKBiNJRQtVIR3eF8ToFhH+M9Sx8tgwgxkt8wSz/M9MD6
X-Google-Smtp-Source: AGHT+IH+w8SwxTZ9IDySIBOlOWC71eG0m2nnTQK9NWTbSdYQWb6KEDUhIcqqGKxmtDXjPZoCrQkDhQ==
X-Received: by 2002:a05:6a20:12c2:b0:1bd:2d53:35d4 with SMTP id adf61e73a8af0-1bef612775dmr17340061637.32.1720030412626;
        Wed, 03 Jul 2024 11:13:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3eb9bbsm11086593a91.57.2024.07.03.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:13:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 08:13:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Delegate uclamp to each sched_class
Message-ID: <ZoWUyrYwVDqSMBam@slm.duckdns.org>
References: <cover.1719999165.git.hongyan.xia2@arm.com>
 <45e58e2fe1f72d6c095c8824c7da696edfd80bd7.1719999165.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e58e2fe1f72d6c095c8824c7da696edfd80bd7.1719999165.git.hongyan.xia2@arm.com>

On Wed, Jul 03, 2024 at 11:07:47AM +0100, Hongyan Xia wrote:
> uclamp-related operations are written in core.c in a way that may
> suggest it is a global thing regardless of sched_class, but we end up
> checking sched_class->uclamp_enabled, so in reality it is sched_class
> specific anyway.
> 
> Remove sched_class->uclamp_enabled and simply delegate uclamp to
> sched_class->{enqueue,dequeue}_task(). This also removes extra
> uclamp_enabled checks in uclamp_rq_{inc,dec}().
> 
> No functional changes for fair and RT.
> 
> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

