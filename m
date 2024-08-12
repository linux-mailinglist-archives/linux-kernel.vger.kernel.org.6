Return-Path: <linux-kernel+bounces-283536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 399C794F60A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A486B21D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED9189516;
	Mon, 12 Aug 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="P+xa8Mr9"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04513B297
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484782; cv=none; b=mee1Zi/IawyJF3wcGcXSQ6cGIY+uYjEV6t5HihWRGERBantMaQwuzMZQ64GQ/aGzXr12SsXEdanfqC7AiuYdEHahzqj3cwdsGn0WgtjPzEfrGumgJM7+Y397F9DJrBaXejcl5Yq4uhg9fFbBK3tCt2iOvm6Cg9QNg9VF0sd+yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484782; c=relaxed/simple;
	bh=8l2gricLljthAnZTTnctVq1KM/p9N8Gxlk87y2mpoFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAqPnB4MF4MXGn7nVzg+VXlJmQsefOvzNDhUUDCGLVSm60OWirKdSj0Zj7UP6J1BlLrIaonvraVJghMlIKb2I4aq9xxK9lJlWXd28SfVNlk9Cei+7AWrAz2hlQl8AxkH/9n752VprKgypWW2+ry+SATvpoqEvVi7MD3lfZRACPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=P+xa8Mr9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f025b94e07so54103711fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723484779; x=1724089579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1jyChJiJKCmkSfgrnMvnEFtALUoiz6H3cwnuWBsxT8=;
        b=P+xa8Mr9PiH3Nil8jp2JLLgICAYfWDve/2yv0PmdZyCAPikpSuNszGwM5ten48IGNP
         gn+qJ5OT8YaKu4Kze8GdxhRSlJiVyfktV2GD8HDpTh4KCDDLghb+fouJU3+zVpTBkCDs
         0yn8DBAhofHanygwGo7TmmO8DKvH6LKa551Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484779; x=1724089579;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1jyChJiJKCmkSfgrnMvnEFtALUoiz6H3cwnuWBsxT8=;
        b=h4TuX3mpHsUOmoHQmKQPYCplF9glg3lXPfc0YHcU8lDOO0rjuNmr33ac3lYxnM8jsk
         utC6Pz4uEmz0Vp5NE1b0uQ+pNrxRqMUXBpPPRe20Kmi5BH7TenJSfd9jc7KykNTu8Pbc
         2wel3lUXljSBFwP59P3LOnretVK/1L4O2tpa6eASsIC/xkrQoUbcfQLd4SNNco8zwe0z
         vAcmIMjXrdM7wXvjnonKw+P/u6k7Tnxkw7aQIYQriu8IH3WuDi4jwiF6XMuD/Xue8y2G
         tuhGjpoIDJS9Y7CmCxMMiGBRI52I1qoeAPi75jsNYDg+ZZ91yA/Jbz8/q6qstRyCmxEk
         nTLA==
X-Forwarded-Encrypted: i=1; AJvYcCX/1g9IJB5h7WF1dqtRX8CrvfYGyQvt/rxwqO+LoIbZrGiZKFY88RehlNh6OqonpoW9dr+jKCq017E+r6dCIqffAjrJTEDChNS68rhM
X-Gm-Message-State: AOJu0YwHRdzr4ZM907xSjtRXNb1raSgVJZ/LranvMV2zmPT1W8xfqPLg
	n71ARSlOi9pqYMWsO6ozXvPqsClo5GMWjNwgtY8YtAG2SR1UfGEM1o87jzXqVRw=
X-Google-Smtp-Source: AGHT+IF1vOhqNLNMr5sJRpH4hayHHgjsz6++vKRWoz1iFhdnqkOWUKnsI4efNLThl3n6KHNk41H/xA==
X-Received: by 2002:a2e:9d0a:0:b0:2f0:1b87:9090 with SMTP id 38308e7fff4ca-2f2b7156fedmr7522451fa.29.1723484778635;
        Mon, 12 Aug 2024 10:46:18 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4293e41496dsm173490805e9.23.2024.08.12.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:46:18 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:46:16 +0100
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 4/5] eventpoll: Trigger napi_busy_loop, if
 prefer_busy_poll is set
Message-ID: <ZrpKaPcAow7vvClC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <20240812125717.413108-5-jdamato@fastly.com>
 <ZroL54bAzdR-Vr4d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroL54bAzdR-Vr4d@infradead.org>

On Mon, Aug 12, 2024 at 06:19:35AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 12:57:07PM +0000, Joe Damato wrote:
> > From: Martin Karsten <mkarsten@uwaterloo.ca>
> > 
> > Setting prefer_busy_poll now leads to an effectively nonblocking
> > iteration though napi_busy_loop, even when busy_poll_usecs is 0.
> 
> Hardcoding calls to the networking code from VFS code seems like
> a bad idea.   Not that I disagree with the concept of disabling
> interrupts during busy polling, but this needs a proper abstraction
> through file_operations.

Thanks for the feedback; the code modified in the this patch was
already calling directly into the networking stack; we didn't add
that call. We added a check on another member of the eventpoll
structure, though.

In general: it may be appropriate for a better abstraction to exist
between fs/eventpoll.c and the networking stack as there are already
many calls into the networking stack from this code.

However, I think that is a much larger change that is not directly
related to what we're proposing, which is: a mechanism for more
efficient epoll-based busy poll which shows significant performance
improvements.

- Joe

