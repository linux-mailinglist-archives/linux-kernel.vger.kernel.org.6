Return-Path: <linux-kernel+bounces-275170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2AF948160
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F1828541F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE1A15FD16;
	Mon,  5 Aug 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvs6ptHA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCF15B57B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881005; cv=none; b=Bx4RPKJ7YRB1ewUFWn7dZwVTuFj3FD+ZosGWRNHP6v95y/7oTDi2xB1eW2rDoIqyPo04GO3TxgHzOY+xMIALbTy1rwzPG8YW/KjIHibceclePl9AtprQZ9ZVXoVBzvJSoBKtrqIORcNvyKUce/PhVORjyhluFSae7DFPmn7p4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881005; c=relaxed/simple;
	bh=as51Z7m3gx/5gWcwca8krmrjoM5BFfF8FsRSCWuV97M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0pM86XzteX2gJhDWDVrwVYyDCO8DnjIRET1J4FQ1pYFj7NcPgQSldYbUWLnZm755pmpO7qHEJaF88DhndfDR+ieAE0hN+JATBEDVKYrHIZ1m0KARlQ1MDNQEyUXli5d/694TpUMRJ4YTuF8YShuH1A+9c5GrIclE5ltEuQRiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvs6ptHA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ff67158052so18809965ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722881003; x=1723485803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zAWVk7ehim7FJEzwr2kwsxKiBLej/6k06J291bcYEM=;
        b=Bvs6ptHAGTQErvi0l9BttcaPgmGfXlxOB460f3mDYzZ8RMp7FHMST6oCUrsRRQCwtR
         viyCLuFtnIsdbuRinW+ofTFg0i0hU1XOZ/vLjzPQMRh7+aqDASSWCQmbDtEAHD+B1npY
         DdZsMPLnNiyhZvUWCDMCLuZcvELuQohZZmVYjfcKRrRkNiXOktQjU2P0rhttTIb4tHsC
         amA302+2MZhCrKxCapPiHFfIwKtEogczzaHxbyJ/yS0bXK/qYm+yK249//kVidunPsrV
         2ZYFzQmfPyOOZHoZN9WeTKkPifYLiN1H8N86rxa5uCP+wjFVkU06D7T39imr9k2nbdff
         ltsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881003; x=1723485803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zAWVk7ehim7FJEzwr2kwsxKiBLej/6k06J291bcYEM=;
        b=MnQoxYqqGwgv8ug5ov3SZp5vPNem4Ut8EeGgNHwaI6bO/Gght7hmB//Kh7yetXztfq
         mW30PEFFfA7W0aG0C7vKYXGhzibUj9JPeUzwCgNrs4d4tcqOPjHETIWtwkbbqnRJjasI
         TIgG53xBbIdhV96pJmgSxKxL9XhWwEdHsu3DiaAWJLWiwkqKEPnNZosJU2JVM8S/snD6
         +P+DxhonLypkfS4uGTbvSXQBjkZx/JIURVt+G/sMkdfLZmrNLmX6cS5mM/LFb+u7OCKT
         tV1QFyYnoi7qwxyvOgOedrisCCyP5dwLUQO+pAgxUTFHCAnD4HTfDbRZddT3AWk1S+Da
         WgAw==
X-Forwarded-Encrypted: i=1; AJvYcCX47e2Uz9G6NQjvTZsi3vBcsriBO68H/QB8AHgtdT4IIhJnU7NLCpQBGZVm5FKewsEZHrRSDpUXyysrxzSB1oS7umMgHfYtbPT0Pc3E
X-Gm-Message-State: AOJu0YydmtqIPI/w+6c8U1br0RwOka69aM4o8l2cpEriMCICGpSpIqzQ
	aN96dxWTkSQNCJbDKpa1gp2tIbJMJ0+Y3UfYoc5b8ZPIurU8ZEA9
X-Google-Smtp-Source: AGHT+IFLBwZbjUTK2Fl4o25aXYGQ6j0cGhTnPexgTkw02M2trZp+D2C+PljbUYND4usWr44tMvsrGQ==
X-Received: by 2002:a17:903:24d:b0:1fb:5e2c:986c with SMTP id d9443c01a7336-1ff573bb797mr112127225ad.45.1722881003156;
        Mon, 05 Aug 2024 11:03:23 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592aee71sm71026145ad.279.2024.08.05.11.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:03:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Aug 2024 08:03:21 -1000
From: Tejun Heo <tj@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH tip/sched/core] sched/fair: Make balance_fair() test
 sched_fair_runnable() instead of rq->nr_running
Message-ID: <ZrET6XFqxkMYjVpY@slm.duckdns.org>
References: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>
 <0b8d4584-6ca2-f810-16fb-e989a0723bdc@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8d4584-6ca2-f810-16fb-e989a0723bdc@amd.com>

Hello,

On Mon, Aug 05, 2024 at 08:51:05AM +0530, K Prateek Nayak wrote:
...
> When does this happen exactly? throttle_cfs_rq() calls sub_nr_running()
> negating the "h_nr_running" of the throttled entity from the
> rq->nr_running. Even deadline entities on being throttled dequeue the
> entity (or don't enqueue them at all in enqueue_dl_entity()) and would
> have the correct "rq->nr_running". Could you please highlight the path
> that might hit this scenario?

I just missed the sub_nr_running() call. No wonder I couldn't see behavior
difference. I'll redo the patch description.

Thanks.

-- 
tejun

