Return-Path: <linux-kernel+bounces-542117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F571A4C5D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE283A599E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E96214A8F;
	Mon,  3 Mar 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTiJSvLV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D626ADD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017334; cv=none; b=ehQV/eZsWwc9kR20dGzjZnucKS0Pua+WO6T5IfsPO7p/n4jMl6rqYlC8xoMl8mx22X/xzQZwGjr80mG2efMw103GIOdxOKG3Cz0ewtdAvlLQvrTljOAk9n/aykMy9h7eGx84obhOFcHIQMr3G7rZAZaL4QikL/hN1npCq2Nvn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017334; c=relaxed/simple;
	bh=uEsznxX/xMb286UGCWYy8SkfkN538iRw91fvaeob1J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV/lqa4AZOLOwXDI9QE552qBQFYa6/Av2yZ317gkTpqinWsN21kiHNAKAjc11xbH3qDC8te209vd0Mw95EAvpQHQ3DAE1dvZPL9WXaY8yPBBt5/CmD6Rr1k5hqoHSzpkGyVHRbxKNfCECl+j8/423Qi+c6rjBEiXVwmG3O9gQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTiJSvLV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741017331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEsznxX/xMb286UGCWYy8SkfkN538iRw91fvaeob1J8=;
	b=aTiJSvLVId/YLHA+qglJvrVrfeYqV+0wShT/B4mH0sSVstIImF2Q4d5lsSdhM09Mn9VjeL
	QZGS8/8mDZ+Z5SA3ArBGsohPob0siLMkg4yL0ibCEpG73XEzzMQuiUl7Ujtza6yWtNrejy
	9Q2vI1v3/CHYpVP/c/Fiq+rsq7V+iBQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Vx-BSXj3M-OPZ-anoaffTA-1; Mon, 03 Mar 2025 10:55:25 -0500
X-MC-Unique: Vx-BSXj3M-OPZ-anoaffTA-1
X-Mimecast-MFC-AGG-ID: Vx-BSXj3M-OPZ-anoaffTA_1741017324
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e4c2618332so1059080a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017324; x=1741622124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEsznxX/xMb286UGCWYy8SkfkN538iRw91fvaeob1J8=;
        b=QGIfRSNfFJxvYTx+sN2qOVr0MdXRu+Skc5FBx23xeDMV9VlSJeCYnUEroXdDvHyxCC
         rEZts0yQNvXtj+X+BGhJBDoxbdQtYTxXk+XycHie56jJ4zEvEgsJ7On8/2a+xL/ilXwK
         nygr8r4TQe37BS3QQiynPsfz3b96LkYOEEoB8kcmzplGTXJTI+ZX4P9OXreWEUamweTL
         nCVfUdyVlPLJ+VfdSUt2v0D8sBCsSVrqHY8Rg9PhAvqgs2O+Dz/2e/ztCIwwkqCpdnh7
         VSqICFcVH/3uJhC2LVleS1FniDu2DBxcbNOQLQQmj6JuGmbfGO9nD0B9cXiGSbJriqst
         rzdw==
X-Forwarded-Encrypted: i=1; AJvYcCWio5yXe5c44WbpiZXD24v0hn5wIeM/j+a0xNiBsxQcIjcvzgLzaFf+rMyjEp/fSXzfBpNKlbKTdeiQBtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZNmVM8rpZwKlnVgrMOHjj4iYeAYaXEPkqsIVk3lTrJ3oK7Fi
	6xs7tZwFayOM76uBGG9hkJcux9zveGa8i+7Cog2bagKfgN7sKWdXIWr0prMhsOK1VKfyhzG1qhd
	5aS6X8FTOTqHfKj14QFW5s5I3Mv8cWYMEV2pIfTOhstfGwGXtZ9aqd4bv+L84N/ryPFEyT8SGeU
	D7tWia4QApKiR7dUtFRGbU7RBgbRQY9S7ZN+/5
X-Gm-Gg: ASbGncunRZIh61ZbNQRKSMuhMwQ35Ww9bZCQV4cjv6IeOrtEKsiNH6CZG74OOFQw5/y
	v6kHduW0/zSGh75COTijjuKrBKz9a646nl1FM/QS2tkNs7Dvc5PlKYUZ02AXFZRfEiBCMB7cu0n
	V7sJMzhfXwtb371OaRhuVAswtdGz3yfzM=
X-Received: by 2002:a05:6402:518a:b0:5e0:b542:fb32 with SMTP id 4fb4d7f45d1cf-5e4d6af38c4mr16733486a12.19.1741017324402;
        Mon, 03 Mar 2025 07:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPGTxc1snuBJBdKHqlXGLWSFEPR9nWpoVGKyGNemsQOjxXhG6YU68Dfkwsg9V552o9TegQovJJ4ZO+UZQdfbY=
X-Received: by 2002:a05:6402:518a:b0:5e0:b542:fb32 with SMTP id
 4fb4d7f45d1cf-5e4d6af38c4mr16733456a12.19.1741017324012; Mon, 03 Mar 2025
 07:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
In-Reply-To: <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 3 Mar 2025 17:54:47 +0200
X-Gm-Features: AQ5f1JoWt4ZxpLw4IoDK9sZzUvGLABknJjfBY2g9Ho-HNZIyoFep9paWlRxouPc
Message-ID: <CADDUTFwyMt5zFqWeKXXiECOeqeyZ46fJcc4-ff=rjccsMDHKSQ@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Actually trace collection can be performed using just trace-cmd start,
trace-cmd stop, and trace-cmd extract.


