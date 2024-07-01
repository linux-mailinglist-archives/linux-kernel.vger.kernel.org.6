Return-Path: <linux-kernel+bounces-236930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7191E8B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E60E1C21711
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2616F855;
	Mon,  1 Jul 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj3MHwHH"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2016D9BA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862745; cv=none; b=YSLV3zOZaj8GJGuonIFss3Pb7vcRnG28oGvRHBZaQApHJ33GQsh6lOnDfsjUDSuyRRjYoIL3pLmrSxaRLRhl5cLe/WFLljneex0A7yS+bNqxwUooXqKACX/1aYSZX/vGmmrDhSv2xR8VZ5bfymNO2swH5/T0SjXEeNyWHFhRuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862745; c=relaxed/simple;
	bh=Vb9si8Rn3y8/CBPzZ/gHGlU4tsQfEpckUse/BMUn4WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvwBihF+0+2nYuw+uSl33z7EnXdSN/JzM3oAtyGXBrQKJ30dc8akiDcg4gGEY1jld21VkQ+/gu/46ZQDmxVOE071Chd7/RBO17YOkgRDhMz/cE1j0BDsZxWdlRJn7KTo/UDhTgxisYXHGOCEigezogNITzbkgBNdv/YZCyFJ/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj3MHwHH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7066c9741fbso2856742b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719862744; x=1720467544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id2aCLKMpOQwvQsH+GkFwVo4vhGvFVlzUoGpW4OMhDQ=;
        b=Bj3MHwHHaS1+9YHEf8wpZ2RvFd4whZLAOe1WEPmbsK+NGU8DGL1WNNERL6hGA3KSZ5
         DEkFvB+jFRhDUGzdA0b2aRpgyfjOSTerMIIZW6pqITcNYaZbRlz7wJIP62bhYPse4JAe
         dX3u5tRp9yCSx6G50hmQRqNlDp10xvAT+/hRLDsHoZbiniMAaQO+P/a3q5SgNTHkoyBu
         XYLrmMK8jJUrvzMv7ijjnSeLnXWNjTyZPQqb6thUl9lNJMnB6bHwzkiGKLD7Xs6gceBY
         QCIQWQ/OeXTWJdItDL0o+6aAf1KYuwTYx2iTZZtMrK30qUBliGhSVhuwXcgEL7nDhn0F
         2Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862744; x=1720467544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id2aCLKMpOQwvQsH+GkFwVo4vhGvFVlzUoGpW4OMhDQ=;
        b=HgrOEWHpgiYX2yE/2rTXyl7rN4ikA8NjGJVzB7nxu8rjdYlePi3Z7tREuSRBChRS7M
         N7qrzNKqkpxDjgYlvTBMQAy/OIncaTh7Qw0iFg72wBCOrmOijHNbIkWK+8xpTD3hy6QE
         XAxhx2LiXjTMqeKHqq1XwHNnfTj4ILv/A4zlCzJYrH4zlpesFX6+J4Nhfd/HnuGMw80V
         EKAYu2ohXaYaUaQExUdRUsKJmh/2SmeNe8hYSnYtXpElStWuCyqoPEMwibLtr0uHjtGB
         P+gtY6WVLQMEzSSGt9ajMVAPaPcJMZXtQhSlRBcidqK1Xi4nE22HPiHEajaIkjyUsw8d
         WP6g==
X-Forwarded-Encrypted: i=1; AJvYcCUA2aOEvyJpopilbEBJLCfxhICHv5Rah2iokC8LlQ2EMLTJHHJ2aY8IQbbMDOhiloWsGYVmp/1PJ7NKomYI5vxOYVNqnwvpsTq/6pvC
X-Gm-Message-State: AOJu0YyS9lBhhMPl7R3NKjOUPTjMkdUP0I0EOlcwGE0Ayc8C+puIDu99
	avXv3ae7WPVPjgeCccE2f14IzHFzPdhtkYAa2Dnr6NbbOFiL4avL6RlZDw==
X-Google-Smtp-Source: AGHT+IH/9CWhzipWMumLZqMqkUPZckTw7QxAk9JbrNuGUMwLcbJOiHSYsEXJzs/IiHXyRiRY39J56g==
X-Received: by 2002:a05:6a00:1812:b0:706:9030:8960 with SMTP id d2e1a72fcca58-70aaad2a08cmr10024926b3a.4.1719862743571;
        Mon, 01 Jul 2024 12:39:03 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205a180sm7143659b3a.18.2024.07.01.12.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:39:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 09:39:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/53] Let create*_workqueue() accept a printf-style
 format string
Message-ID: <ZoMF1ZydZUusxRcf@slm.duckdns.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630222904.627462-1-bvanassche@acm.org>

Hello, Bart.

On Sun, Jun 30, 2024 at 03:26:18PM -0700, Bart Van Assche wrote:
> 1. Introduce the create*_workqueue2() macros that accept a printf-style
>    format string and argument list.

I don't think we want to update create_workqueue() interface at all. Please
convert them to use alloc_workqueue() instead. Once we convert all
create_workqueue() users then we can just drop the old interface.

The challenge with converging to alloc_workqueue() interface is that the
conversion needs to explicitly decide whether WQ_MEM_RECLAIM is needed or
not but that shouldn't be *too* difficult.

Thanks.

-- 
tejun

