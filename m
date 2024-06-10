Return-Path: <linux-kernel+bounces-208825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D059029A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFCE1C22A15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604614E2E3;
	Mon, 10 Jun 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX87/2rH"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF04B65E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049766; cv=none; b=Wai1VwMuS0bXiuIov05s1aTIBKdgFuUVQIEUs8sSoOWydJp0ObsmlSLojVXGasGA3hUOlOMO+D4vQXjh3U02mVsqcgBEFUeVdyglqtrCDw8yDPzJLgynPbnbcqvP8ozszU/VaJ0hGuoDuO6orTBhc8T/cjwbvk9zEWZVaoZ5GV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049766; c=relaxed/simple;
	bh=7mmjAeD9muzauT0QEkLnX5sQAFSGIuZ8o59hqELMSFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgiXFMcqYZS8ztDxE8/CVAQTleMh0uC9k60EkQaukHKsbYcGnCF+8CBJx4qQ+tnu061E9r/uqf+pbR4t2OBPEjD5d1v1tgh3gKnS1CYF76MqBH1abKoFn8BAcZnJ2iFGOdK/4N4rDRcXFKwkrMJtb5S57hV+C8X8bQeZBzetIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX87/2rH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b594deeso40107815ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718049764; x=1718654564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLXwpiUVTp1sSqZSnBKBcrrvXkld+MkCeBKUsdMttSI=;
        b=QX87/2rHUf3NLMyFtc1NOWmumZbIj1dVDGni04MC+jNl81Al7KYbbcIt06LzRvtSh8
         MBvMNchAdx9j7QMSLQCsbhM9THD3Q7SEo0WPpJjJIva5a5h/R96In14TQr49iCAfSuVm
         o1DHD5xhkE8u/RgZj5R++OM915wJDfvOuiXt6Ctbf+sxGH7RlbRh4kcEq2xGubyFZGU+
         KzP+i1n5JTw4/z9V+YEcIKyqABR3wwSjxn3xYODIf+KlBqBg4PcgR/I9tAitDZ70h5qE
         eq5mPNE50lTC6tJnw0VWrhqFM7g9qavS9Zg+YHbTF3p03UaXi0ujHNLnqOENNNEXFh27
         WsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718049764; x=1718654564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLXwpiUVTp1sSqZSnBKBcrrvXkld+MkCeBKUsdMttSI=;
        b=abcX811pyRULLCG8Juv5oe5sVb6xTfelCAhE4djeC11W2IavaHYK4BuhrAiGbgNmg4
         jkPHKbUPEzOl7RfSvSPVGUpINeTudMtMZMbVIKkXUHKPCL8bPGar6hZUox4dJtAUrEOf
         Xe1uhjne/oTeTDKenVX7FsPbS2D5DVx40barN7F1+XWfhmnP6VwCD+XJ7xOrgPs91EiV
         IlZEg47o7DmATu02gvkArnYrKFJrPb6ZYOaJLn5fdgQv0jwaogitttoKd4LB9TMZ9fVI
         IeYiENl3oYIRcurjudrvMMRnzR+QZBb65RMtywxatXeQqaWLpKEZfsKzzoRvWnubyly1
         9UGA==
X-Forwarded-Encrypted: i=1; AJvYcCWuRxqZo8PrLi/nqxZNnuNPfI7NC9RtKzHMiMGTMuftpf8g4dhnovF1hquTaWJU9o0phQKrhR5Bt4tqj7cedeGr94HNepaiKduNT5Aq
X-Gm-Message-State: AOJu0YyCOuIburoGlo7rQl/8tX1zBpm6pF47AEZsCpZWloJSJNe7TV4c
	+p0O7uDZQIXzfuSX22gN+D6AfZII1K9XxR4p1Y8uo5y6CQJKYLzF
X-Google-Smtp-Source: AGHT+IFiAG9/jAjPwLPqtskZ0gFaUHIV+8iGg5X5oz8TD+hl+lZEmMHhUKALWjO3jrPiyLFXsOdq0g==
X-Received: by 2002:a17:902:ec87:b0:1f7:234b:4f28 with SMTP id d9443c01a7336-1f7234b9815mr17485635ad.25.1718049764077;
        Mon, 10 Jun 2024 13:02:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f0f4sm86141855ad.36.2024.06.10.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:02:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 10 Jun 2024 10:02:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Q: css_task_iter_advance() && dying_tasks
Message-ID: <Zmdb4moXhvkU8P0R@slm.duckdns.org>
References: <20240609142342.GA11165@redhat.com>
 <20240610105028.GA21586@redhat.com>
 <20240610110852.GA21828@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610110852.GA21828@redhat.com>

On Mon, Jun 10, 2024 at 01:08:52PM +0200, Oleg Nesterov wrote:
> Sorry for the spam, forgot to mention. Either way the usage of group_dead
> or atomic_read(signal->live) in these paths doesn't look "perfect", but
> this is another thing. The pseudo code below tries to mimic the current
> logic but again, I'm afraid I misread this code completely.

The usage of signal->live there is something I added without much thinking.
I just needed something which goes off after all sub-threads are gone.
Getting @group_dead from do_exit() sounds perfectly fine to me.

Thanks.

-- 
tejun

