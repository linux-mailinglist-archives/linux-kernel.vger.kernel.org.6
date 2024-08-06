Return-Path: <linux-kernel+bounces-276798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537394988A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7CF1F20610
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B214901A;
	Tue,  6 Aug 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLexqu0C"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5A18D62B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973199; cv=none; b=CCzIfxyu2HylaJ4mlSpQcQPIk3ucNNYjAUozCMjv6Hh2LipjYrDSWC2Huc7+TbTHmo4DRC4J21TjHDavJZuUr1ttVesVoqS0XleyH/SCvbAtPOEdtsJaymruMIQtgVpYNTLrrJxOH8+iQbPq0mJIQGIqQHByflv4RrvMGkOjdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973199; c=relaxed/simple;
	bh=BRtPN5X/E6nGP9PEOMOjIzvOlGDm380dop/d0xDj7Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wcxm6005yEMs34ggKA0BSP5sjOwz+Qtn+Kbg8p+F6Sdeawv8AwJG71yWUQ+Nj1BDKjIN2DQ82cgQ3Mh7RrmQa6eftZg55P05/qDEbQu56gIk7qpRdT3c3ak5WvLxpkEPmR7CzRqqwQrANtHQwWZJhNUYfiYaZf3ksnK9/5PV8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLexqu0C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so6571135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722973197; x=1723577997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WnePIG8Ol+90L76RBvGEhgtMrBy8NMhyWZbfXGuhFo=;
        b=TLexqu0CF3akNt97b/CrMJLhBhCmRMvv+bLYc57Z/8fhWd62iBIh+3cG+2O/3xSA63
         2GP6/Q+DU/VYjEmzZbxSjjjkXc5VSdElEKn/dR7vXpCkpjV2aBvuUd55h/NelJJcXkZC
         I5ZaRcmRs98O9s1f9i2c63L7lnRJtkMYV3h6PshGhZfCzN2Rlkpuuc0BRqSUWf2tBk4H
         WlAJqsqR6gsZVd9L5CP0c94nXjLGiojBVa8tPAvjqyLt98yFIP94YFffdK1gZF6n3BO4
         RhnIp6RRiRBf2HZUCSz1i73Y+SbuqPnqFyknR/3pF4rtOhF0s5z0oRJT5yDDTyhOUTiL
         kqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973197; x=1723577997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WnePIG8Ol+90L76RBvGEhgtMrBy8NMhyWZbfXGuhFo=;
        b=Ws/Wc8Gg8J+nHpfGK08ec9r9LRx7pIfzg0H8pil4C+fLGNdOv0t7SVe/KOhmc06puf
         1mkE4kzU/pOhToMnbZ5/HR9mbazPbt04pzMIV9TJ01HGq1EjqpuOM5ceht00hn1HEcUi
         UeRsV0siyLfVzjpI40G3EYS2d+4rWBLbnxKVmP7XsbSkKYmjISSZ4/INoSZyGw0tQDct
         pHiq6ALj8mB8C9iWAd7u+/MWL0kUabnrBMRTQMJnpM1t7PA5zK0lQU6dgwQzJhvS4Ncn
         tdZecZ3UagnfOGXQlLp71MZM8bI9UUV/jes2za7PoN/aMlqISMuPAgLoXHVJFnjllnC7
         tl3w==
X-Gm-Message-State: AOJu0Ywih825/aeHM07bJwIjjYLWbrN0fo15DQXtO5TDUl9kX75cPvwa
	QVXVD0GE2n4yK9Vulnfk24MOLPYw8UYbRn4KPglL7BJnXV+oyRpM
X-Google-Smtp-Source: AGHT+IEIr1QuysdTACnJ5dGDUKKCeGxKyK0I30znlZvc2gVzTJGkY+u7xWXzw+C81gMxTFs1U5S9+g==
X-Received: by 2002:a17:902:db0e:b0:1fc:692a:ba46 with SMTP id d9443c01a7336-1ff5750ddb9mr164218595ad.65.1722973197047;
        Tue, 06 Aug 2024 12:39:57 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200798e8759sm17634905ad.97.2024.08.06.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:39:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 09:39:55 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@redhat.com
Subject: Re: [PATCHSET sched_ext/for-6.12] sched_ext: Misc updates
Message-ID: <ZrJ8C0qRzZ9UrMPw@slm.duckdns.org>
References: <20240804024047.100355-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-1-tj@kernel.org>

On Sat, Aug 03, 2024 at 04:40:07PM -1000, Tejun Heo wrote:
> Misc updates mostly implementing Peter's feedbacks from the following
> thread:
> 
>  http://lkml.kernel.org/r/20240723163358.GM26750@noisy.programming.kicks-ass.net
> 
> This patchset contains the following patches:
> 
>  0001-sched_ext-Simplify-scx_can_stop_tick-invocation-in-s.patch
>  0002-sched_ext-Add-scx_enabled-test-to-start_class-promot.patch
>  0003-sched_ext-Use-update_curr_common-in-update_curr_scx.patch
>  0004-sched_ext-Simplify-UP-support-by-enabling-sched_clas.patch
>  0005-sched_ext-Improve-comment-on-idle_sched_class-except.patch
>  0006-sched_ext-Make-task_can_run_on_remote_rq-use-common-.patch

Applied 1-6 (0006 updated to v2) to sched_ext/for-6.12.

Thanks.

-- 
tejun

