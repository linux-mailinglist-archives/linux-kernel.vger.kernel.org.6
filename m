Return-Path: <linux-kernel+bounces-437486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303EA9E93F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690E31885820
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD358223710;
	Mon,  9 Dec 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G1CKTvxd"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2802236F4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747346; cv=none; b=hfzWzch/H6Nr5txSq3tDNyOr0tFizQ4dU77CQaVZrxoymzbHjO/s9j1iAxs1OlmU2kGMkiSoXU7R2Qp1dZxbsPjHZdyRFJbn2tbEzgyfJLJG/sbZW3NpfTDJrw17MlJ8XEpYJqX0WJkgDlBZx0G6Ux3Ohy84JTCtbZDOYECxZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747346; c=relaxed/simple;
	bh=Qkk0kDiJ7iVTZVBmpiuPSmH5N0pAA4DlMttgSaOYgro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7Pl6q4I/YMx3mefWBalyGqFdeI90h7fHIve4mpC3ryfBIhPHvyWQmHpa6WJV8/8vRFzfUcbob449H+Dqs9++l3I66sf4NYzCQOo7j5Y4F4YU1PB3QkXOT4J+PfnFxoFux2TquY72EIxrs1kUQUXGr9xWjUUh3/IkRKHhtTVtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G1CKTvxd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1994985f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733747342; x=1734352142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JacI4mB04a8LmhCK/TbvYbOJL2q6pHnlqOBJlZwmZq8=;
        b=G1CKTvxd76YhVBp31/pAarpeZyFenu5UgkFORJFN6c+T3ftiX08xa444Pfpn2KzXSz
         OjkbmYLWnpINEfJ2CXpgOP7XmZrDbGifVe0zZxQQwJHQSoIVpg2y95+oDWkqm+vI/co1
         EnA0dKrbBeC6F2UObCQFLVLAUK4S9Wzz20+b4WlIq254Ig2feRpZmRKLzEE+2+SOXJb2
         gK3JQaG0FYscZIKywp1Y/BFp1e8eUoGfx1U4oK9E2l6nLBnjSMw8IvYtYg87voUVXZpE
         FYba1oezOlNMuvMx/iu/7gw+fbKVicZ0Lc0WLth5E0FzoATQryotz0uFVQn3eEJVfsWG
         AQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747342; x=1734352142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JacI4mB04a8LmhCK/TbvYbOJL2q6pHnlqOBJlZwmZq8=;
        b=UKH7EeX39lS/01QrpoRVZ5WuhuzJ5E+7ZR0Xvq+llyvcLFx0SdvzDMrYNJzYcP5nJu
         5O+iHQQTtWYUkSt1M2Prn7FSav+0Aw3zWo6ok6atqRouiS/1iwI2nw/sh2Eg7/xJMhaW
         fdRfVTTAAgbhyqmhe8UTxY8KBMNBX3ge9sAWeWffq6y3t+TaEJ76cquQTJaS7VMTVgox
         ynBrWS5F+5MjXix9nCacr8YMff/xYVqFQshJDiAQPc2Rr35Dwp+nETmYtNcTU8R1W87L
         lvVh3qI0S7gMDbhKZXSUxdTSNv4GJxuz23vA3BL9E4+px+dE7stACU18SVTWUF5wk+8/
         HkzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeHmhKIYwqkxRwhuHjXoiMz4cdME7+XIXYAfTExT1KquDQLrwkhDk4GwvfbUHDBltWnKbKj3NSXLjvXB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRjkXGm5s/U5Tg2uCwEG2z9F3zmZa4r9AXT9Z7pA/ydGLT8vz
	FtUWXZGU8eYQnkfslZIg/HlVqNwSWZc9Ill25f80+BijHT7l0LRIqtWbRFdPjkE=
X-Gm-Gg: ASbGncsYLSk4gBqUCSjaCC03mzrCI6aqha6ifQO9Fp5UpL7teG7EHnf+WM2pp3FNZPO
	BVPf/6EAqhL3s1XapN92O9dA0TymTAcgbuyq4PpnPL8pR6Tl/naqLB21/4irV+5xFKxrlW9m+SS
	dJdBu8kTTZ2miYcqSj0Ef4lxEBuDGHpdOgQ+yAENMXwDYofklFvFTrcfG1FFQUmRaiMzLYCfapQ
	kGPZrQqvESZO1+Uvuh9x7pcF14rsMsxDsP7NoodLtDhh2f3p34=
X-Google-Smtp-Source: AGHT+IE+6SrVhA7lxXXWZ2TRa5Vtd+x05Nx18JSjzrlkUyDRkzVakZMiRRWDAFfWkUvG1F7oja5peA==
X-Received: by 2002:a05:6000:2aa:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-386453c6383mr137490f8f.3.1733747341754;
        Mon, 09 Dec 2024 04:29:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd15698cd7sm7350830a12.7.2024.12.09.04.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:29:01 -0800 (PST)
Date: Mon, 9 Dec 2024 13:28:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/1] livepatch: Add stack_order sysfs attribute
Message-ID: <Z1bihaY1sJkioopk@pathway.suse.cz>
References: <20241008014856.3729-1-zhangwarden@gmail.com>
 <20241008014856.3729-2-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008014856.3729-2-zhangwarden@gmail.com>

On Tue 2024-10-08 09:48:56, Wardenjohn wrote:
> Add "stack_order" sysfs attribute which holds the order in which a live
> patch module was loaded into the system. A user can then determine an
> active live patched version of a function.
> 
> cat /sys/kernel/livepatch/livepatch_1/stack_order -> 1
> 
> means that livepatch_1 is the first live patch applied
> 
> cat /sys/kernel/livepatch/livepatch_module/stack_order -> N
> 
> means that livepatch_module is the Nth live patch applied
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>

JFYI, the patch has been comitted into livepatching.git,
branch for-6.14/stack-order.

Note that I have updated the version in the ABI
documentation to 6.14.

Best Regards,
Petr

