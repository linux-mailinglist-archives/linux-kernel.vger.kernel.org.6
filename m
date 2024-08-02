Return-Path: <linux-kernel+bounces-273026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC794637F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF09E1F226BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD891547D1;
	Fri,  2 Aug 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID6d8Ajn"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA751ABEC2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625197; cv=none; b=hx37H1aWlTD7uQMH9gDKb2xb5RdLSYSmDgqc+D1rCLfPGOUIKiU7egI51l8e2gi3LV12w9O/Iu5XGJQt8pYouBQgIh0nHissBIeuYUekgBc4/9WZRqru0arX5mVisjGOlfo7Q0mFbpWGVbOj33RwGPZVXuZNx+HPoNgRZvZPbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625197; c=relaxed/simple;
	bh=6Oq2YA2pmLOHc0LGjhUhjd2RhE572MLmN+9EJNZ4XVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2fmfJJT1fj9A3yeqpW57HgJiYpUQNRyQb0jUszccaRTqiUh35KOjiGPLkLxc0nWFIMhld+AE+AS7uUMfUhT9PseD1iJH3/R8DnCUtg8xiVRfKL4Ep+YNhiMKWO6GWSWATMaXqPhJZEO07qqKGbcIiVzdtiI+oZxqod9gkaVRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID6d8Ajn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc56fd4de1so26991985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722625195; x=1723229995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwSftlIurclRafu7LWzfCWxvcV52fQxmz5EFZiJ9yss=;
        b=ID6d8Ajn+hTJfd4O61hrJcw0S7d/Zh0tkpDD6FoNnwOQ38Y8PPRXgk57oPNhRE6gtJ
         YPUVtvf2+BPLCpI7alHoJ95puUmBtk9aR9bOYTFxjxUlPdeX8wUQbyemW66QVS4a9+oB
         uuvj3jZj/fJtKZxwkD0yra+lKJgvnlI35za+/UgHJqSPCEJBbJglRSvWNmedfBrdiSPL
         yJBaDl833hB2JJVO60rjYIv0h+ebE0bPl4xcUulrI0NzWRVdIxCcm4azfUHXVqNCtThp
         QBA3u0x8UdMYpdFw2MFPHbeMABDuqb9dfTKNbVPM0KZT9b3wA5sDqE9KG/MxCmYTvPq7
         I9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625195; x=1723229995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwSftlIurclRafu7LWzfCWxvcV52fQxmz5EFZiJ9yss=;
        b=JIDyS+1HWUfUlGqnk1KZHDnlWv6QBjUAkxyvKq+yJCKrGX3ZcS2vv6wEIf5JrEMAV3
         mpTmtFdJWXn4QvQWMfGOPtOHkJBRBZhC46wwZPJ00HZle4DKZcl+kWkhpXuLqqWi7ra4
         aEUvSCD9LBWF5CiPZjRDlu/yMDv3dvJAzJzPz3iZcrzr77+7awojjgrhWPhU1Zi1oCyQ
         zynTts6qMoZUHqU0KkWUraOyPdWlcS2j1kOgvNhWAxuNKYOq6lLWvqz5Xf7J+GKaEK+p
         1zlfkNCsoU/qsY/998q9DXmV7I6LA79phoBsey8JIrkT0IV7fmKvSbIRVWxiM1XgTb06
         lpJA==
X-Forwarded-Encrypted: i=1; AJvYcCVjn7OEuirC1PlrU51efYLRywI+v5Sp/Dc6JU+TTUuzCVW9DIUdIT/qhOr9lBs1GDVa5fjxFC1RrVkzQ0+/yshs/k2j7VogD2uOnWHf
X-Gm-Message-State: AOJu0YwzpUI/2zWYcfNbk743YcdiC6lcJRmHjzK6E3BYVn3KOhDhkq8h
	D8brlBdNwDNQXQLOFLL7LcUhKsb/Fn/7PTRkrhv4XZ63bTmzPD0v
X-Google-Smtp-Source: AGHT+IFCVaSXdt6+0rKFZgYoCd8P+A+kCzNHu2o5aSsX+A4K2MWUJKYpMjYkEnSI2JHZy92JbyH/QA==
X-Received: by 2002:a17:902:d2cd:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-1ff57f186a1mr62936885ad.31.1722625195095;
        Fri, 02 Aug 2024 11:59:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5928f849sm20533515ad.236.2024.08.02.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:59:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Aug 2024 08:59:53 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 sched_ext/for-6.12] sched_ext: Allow p->scx.disallow
 only while loading
Message-ID: <Zq0sqdxd_-P8Xxgq@slm.duckdns.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
 <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
 <ZpgERphu--gPn235@slm.duckdns.org>
 <7d39f26d-3c9f-4ee4-977c-87f9bed0bac1@huawei.com>
 <ZqqNLNWLfjsJ2E02@slm.duckdns.org>
 <20240731203344.GA42857@maniforge>
 <ZqwbK9m6ATnyYxHS@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqwbK9m6ATnyYxHS@slm.duckdns.org>

On Thu, Aug 01, 2024 at 01:32:59PM -1000, Tejun Heo wrote:
> From 1232da7eced620537a78f19c8cf3d4a3508e2419 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 31 Jul 2024 09:14:52 -1000
> 
> p->scx.disallow provides a way for the BPF scheduler to reject certain tasks
> from attaching. It's currently allowed for both the load and fork paths;
> however, the latter doesn't actually work as p->sched_class is already set
> by the time scx_ops_init_task() is called during fork.
> 
> This is a convenience feature which is mostly useful from the load path
> anyway. Allow it only from the load path.
> 
> v2: Trigger scx_ops_error() iff @p->policy == SCHED_EXT to make it a bit
>     easier for the BPF scheduler (David).
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
> Link: http://lkml.kernel.org/r/20240711110720.1285-1-zhangqiao22@huawei.com
> Fixes: 7bb6f0810ecf ("sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

