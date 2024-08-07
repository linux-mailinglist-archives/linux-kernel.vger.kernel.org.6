Return-Path: <linux-kernel+bounces-278043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369FE94AA06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DBB218E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEECB74429;
	Wed,  7 Aug 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xu0q0hyT"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC835473E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040672; cv=none; b=SLPanOd85+xhfI0gL8GPI9OtjY3M1I9X7SverQ8wWMUGzdxUs2m/wXwwwHqWAprSc4nxEL40Q+d+7aMdddq4ididJpVq5OhJIUdLhz5XkJAPtaVJvRl0Wb+0EdNCNc9ZT68yOHndWo/6EuTPJFgPaIUFGH6oVkhdr1hC0VryZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040672; c=relaxed/simple;
	bh=mCP8+7YpoScP1VzJ8pUak30zAZYvQhBR58zPvlp0lwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQl5FypYe4HhVkGtUM0LvLmq/mv7FEMl7m8GCJuy1OrElmqOV4YiAImZ/YDVVgksoEiM2eyWLsZdgXGLxOtMKHF94uOItqjkQzptpymKqbA/CluJ8nWU5h1LfSjzRpPMKTjaVw4RbTRNSt07cDAV06awaA23AYWhWrczF2FMqLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xu0q0hyT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe58fcf29so8300621cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723040670; x=1723645470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJOzyZ3pr/wbnscWHAqs/2LF1xLrFt7lH++/GqT7UiQ=;
        b=xu0q0hyTNwbPin0AfN4XOes4rrt88bBzlXiL1jhOxs3/9RBP1tcOpuH2apMN82/luA
         dX63oN+j1iG3p7W/vSY6llEvaVav88FXKP/2OucfzEhw06HGTlt0su2m5vXPtKbhNC8l
         Q7Zzy1nkxA67F8nFGCCG+uJwwvQtY357lwszauAMstPhNscHwiW9xsrZSKD4/4Udk58U
         GmuwDDnpU9ethgx6E1MUKK4Spx8NpYwouMDKwD3CsttqqP+HmSclHmYkbPGpnlYS+yl2
         JaIXDcC6dClDef8O+SsIQKue7UcAP1nsnxChhkOHYAQZvFfvar78U0DTE+mU3TuYfduO
         MIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040670; x=1723645470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJOzyZ3pr/wbnscWHAqs/2LF1xLrFt7lH++/GqT7UiQ=;
        b=O5J8EifyYXqejsI2gQj1Ga27LQLZ99HFVkq3pzlb4xB8ZmgQTXH4paH0Bz5u1tZO8F
         Br7DlKrIhyY64/la9Qld9Vq+D0oGRdd+Bnw6V4QXo1mTfsQwOOhp25T5XZs7X5Ydjjz6
         uqc43cu9YCzGbs6mrHpP03gRiCoAkEAgr7L/oQzOCZhRzf15BPfcw4cx6sfhI2kaNsls
         n8CgHaB3mOatr00YC6MxIDfJPk/GUgCnWCW6cnvgYGAf7GnthSq5CjI0FhcpTpqLu/wy
         q8Z0UTTbRep4GkcIeqbo2mT62NTgWdb8t4pPLdBMELhkuUETVCw3S67jFKcV+9f8N8Ss
         H7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUch6HaLLBu7/JmYIVvnfeWSi9riQ9HyEgKroKK+pomZzAkiNGSdG3cj7TeBnzdyk90ShfltyWJe0NGNli8q5a5kcceNAyMrR7hmbh+
X-Gm-Message-State: AOJu0YwhH8jbW29tSqjseNw4Vzm3T3xz6rLVMD1nTVGvBtNESF4+xezk
	TbRp0m9aGchgtB4DD78tPqhBbcfhakZ0xATda7Oee0xoo7MxrCgtWEfK+4fKzhc=
X-Google-Smtp-Source: AGHT+IGeWznESzGcuhD6tAn7XbMgDl631N33VqcNz6M5XC/pJ+2Lr+IpFqkXcZYvPIWeVbis5llU5Q==
X-Received: by 2002:ac8:5fc1:0:b0:440:5f14:1647 with SMTP id d75a77b69052e-451892170d1mr225499441cf.8.1723040669662;
        Wed, 07 Aug 2024 07:24:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c86ffb3fsm5334901cf.7.2024.08.07.07.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:24:29 -0700 (PDT)
Date: Wed, 7 Aug 2024 10:24:28 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240807142428.GC242945@perftesting>
References: <20240807-openfast-v3-1-040d132d2559@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-openfast-v3-1-040d132d2559@kernel.org>

On Wed, Aug 07, 2024 at 08:10:27AM -0400, Jeff Layton wrote:
> Today, when opening a file we'll typically do a fast lookup, but if
> O_CREAT is set, the kernel always takes the exclusive inode lock. I
> assume this was done with the expectation that O_CREAT means that we
> always expect to do the create, but that's often not the case. Many
> programs set O_CREAT even in scenarios where the file already exists.
> 
> This patch rearranges the pathwalk-for-open code to also attempt a
> fast_lookup in certain O_CREAT cases. If a positive dentry is found, the
> inode_lock can be avoided altogether, and if auditing isn't enabled, it
> can stay in rcuwalk mode for the last step_into.
> 
> One notable exception that is hopefully temporary: if we're doing an
> rcuwalk and auditing is enabled, skip the lookup_fast. Legitimizing the
> dentry in that case is more expensive than taking the i_rwsem for now.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

