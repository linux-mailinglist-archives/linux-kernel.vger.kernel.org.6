Return-Path: <linux-kernel+bounces-227752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0D91563D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5923B20519
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E0A19FA82;
	Mon, 24 Jun 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q8fWcpKC"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132118039
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252672; cv=none; b=ATdHbGyAY7UvfN9NW5N7G1VXF8YQAeiYvvYLqC2DfNtObdcqcQjxlU0oIWZan6Tb3Uya0kIdlBO57fwWnd6CemG4xDqu7yqBmAU9ATtfaKIK5XKBS6axbnnBxc57I19kBo8b5eUaompRGOcvvAWVJ/K5aXWXmiPIGnNHNt5iRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252672; c=relaxed/simple;
	bh=9RbQgTCqCFSALgUc/JRqpUmZQvIwc1hyoGU2TywvaWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwRXECkvY+HMNQ5lP/N0eoRuC1KpxmWYGlfoYeHAxvUPkwcJvIW8IImiG4QeZHEX7Ise1+AaSkFwKwZgNXzaU5I6RkH96pTrDhzpFZ0vD4AF311fEKXkbLRVDL+WAmpLVvm7w0KzKnRgoQXNBcQjbLDqdYbLMGxL3FofMTcVgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q8fWcpKC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so4958371a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719252668; x=1719857468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xeba+taLfwoM/yTWpKlwizK8Xk6HSTOMdLsJyeBt0rM=;
        b=Q8fWcpKC9BhNOx+sqFUZp3Vfo+VGYSDsQn/5d+6hEADfP9BTgFTmhhJVKXI4sBrxOZ
         pYMELWd1kTqaM9Y/giewvviF9m7M+gI0H68L7UEK5XEpyTdeEErqCIqCe8Yn4HYzWgFr
         yycwZ2VkU/5WXYibbZBDcYz2rjzohws4zUjec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252668; x=1719857468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xeba+taLfwoM/yTWpKlwizK8Xk6HSTOMdLsJyeBt0rM=;
        b=WpKB1aU6YLUvzWkrEXvYvohSw4u0m4Z3IBYxtJ1iqgoYaRzF5Mm59o+R4c6UGVhV8i
         W8xACizQZKOEOlrjuUUxuJTNvI9B/6kNSwJQcjAAlq5I5dEj6DfknyBLEt7cuK0ros/u
         WO6WgNmi9JLB9s0P9w6U6+9SDX1zxfZPos//tQfMH64mP3EZQyEdSqHz10ZxS0RlTr+I
         pIve+nq84L6wh9rWQEJDw0gNo/E6CFrFObH981MKFu4TYDC/DIyXVlgrXwQPrVuu6Nyw
         LvpKiiSykENGL1vXvSVXREwJNcLc+5fC7YaNeF5Y2cDHZBwN4ngToLvhUBK3LaTc9LlL
         jXkA==
X-Gm-Message-State: AOJu0YzLjm1iudquj3BeLj/9EJ+SSM6aiu572wGDKOeoT/dgHV51HtXk
	4ps1DUEzJxN1Rv3JRk91YyuASRqgmcS0KLjdwVvQz8skPwVhKjAe8kjW+UEjG47cj8KwhA314a8
	pAOr8Aw==
X-Google-Smtp-Source: AGHT+IGtmhzH58phMo1FNqcdKrwPIJARj+j/TFMRV1ADxC/KLkDmjdRl2D4/ytMSYcKcyMtR8XAF7A==
X-Received: by 2002:a50:a688:0:b0:57a:2eff:8ae with SMTP id 4fb4d7f45d1cf-57d4bd5662bmr3991781a12.1.1719252667979;
        Mon, 24 Jun 2024 11:11:07 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303d7aecsm4949752a12.20.2024.06.24.11.11.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:11:07 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6fe118805dso231561266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:11:06 -0700 (PDT)
X-Received: by 2002:a17:906:6d4b:b0:a6f:ab9c:7778 with SMTP id
 a640c23a62f3a-a7245cece82mr312240066b.34.1719252666566; Mon, 24 Jun 2024
 11:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZniqQuGkosZYqIYE@google.com> <CAHk-=wj730guvRzh4wo16Cq8tq1D1tyD8ub4CiBxV4Bk0Kq_-g@mail.gmail.com>
 <ZnmX1XeOzU1NfgrY@google.com>
In-Reply-To: <ZnmX1XeOzU1NfgrY@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Jun 2024 14:10:49 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh3ZpDhHseFjYf96CcgTSRoZtjbf41hoBCyfQJ=N+oMng@mail.gmail.com>
Message-ID: <CAHk-=wh3ZpDhHseFjYf96CcgTSRoZtjbf41hoBCyfQJ=N+oMng@mail.gmail.com>
Subject: Re: [git pull] Input updates for v6.10-rc5
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 11:59, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Ugh, I was on a wrong branch ('next' for the next merge window) when I
> created the tag. I'll fix my script, but in the meantime should I:
>
> - blow away the bad tag and re-create under the same name as before
>   (input-for-v6.10-rc5) or
>
> - blow away the bad tag and use new name for the correct one (somthing
>   like input-for-v6.10-rc5-fixed)?

Either works. Some people just re-use the same tag name, others will
always use new names. I don't personally worry about it, and whatever
you feel better about works for me.

               Linus

